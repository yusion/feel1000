#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import sqlite3
import sys,os,io,datetime
import utility,json
import bottle,session
from PIL import Image

profile_column_type = utility.enum(Readonly=0,ChangeOnce=1,Changable=2)

class profile_column_info:
	def __init__(self):
		self.column = ""
		self.columnName = ""
		self.type = profile_column_type.Readonly
		self.unit = ""
		self.descTable = ""
	
	def get_value_desc(self,value):
		if value == -1:
			return ""
		if self.descTable == "":
			return value
		rr = utility.get_c_table(self.descTable)
		for r in rr:
			if r[0] == value:
				return r[1]
		return "未知"
	
class profile_columns:
	columns = {}
	
	@staticmethod
	def get(key):
		if len(profile_columns.columns) == 0:
			c = utility.get_cursor()
			rs = c.execute("SELECT profileColumn,profileColumnName,profileColumnType,Unit,descTable"
				       +" FROM c_profile_column").fetchall()
			for r in rs:
				info = profile_column_info()
				info.column = r[0]
				info.columnName = r[1]
				info.type = r[2]
				info.unit = ""
				if r[3] != None:
					info.unit = r[3]
				info.descTable = ""
				if r[4] != None:
					info.descTable = r[4]
				profile_columns.columns[info.column.lower()] = info
		lowKey = key.lower()
		if lowKey in profile_columns.columns:
			return profile_columns.columns[lowKey]
		return None

class user_profile:
	def __init__(self):
		self.ip = "127.0.0.8"
	
	@property
	def small_photo_url(self):
		return "user_images/" + utility.scramble(self.id) + "_small.jpg"
	
	@property
	def normal_photo_url(self):
		return "user_images/" + utility.scramble(self.id) + ".jpg"
		
	@property
	def photo_url(self):
		if self.hasphoto:
			return self.normal_photo_url
		else:
			return "res/man_unknown.gif"
	
	def update(self,key,value):
		lowKey = key.lower()
		column = profile_columns.get(lowKey)
		if column == None:
			return False
		assert hasattr(self,key)
		if getattr(self,key) == value:
			return True
		
		#TODO未完成 
		if column.type == profile_column_type.Readonly:
			return False
		oldValue = self.__dict__[key]
		if isinstance(oldValue,int):
			if value == "":
				value = -1
			setattr(self,key,int(value))
		else:
			setattr(self,key,str(value))
		
		db = utility.get_db()
		c = db.cursor()
		now = utility.now_str()
		if lowKey == "age":
			y = utility.now().year
			c.execute("UPDATE u_profile SET %s=?,EditDate=?,AgeBegin=? WHERE ID=?"%key,
				  (value,now,y,self.user_id))
			setattr(self,"agebegin",y)
		else:
			c.execute("UPDATE u_profile SET %s=?,EditDate=? WHERE ID=?"%key,(value,now,self.user_id))
		utility.write_log(self.user_id,user_profile.get_log_desc(column,oldValue,value),1,self.ip,False)
		db.commit()
		return True
	
	@staticmethod	
	def __get_value_desc(column,value):
		return "<span class='strong'>" + str(column.get_value_desc(value)) + column.unit + "</span>"
	
	@staticmethod	
	def get_log_desc(column,oldValue,newValue):
		if column.column == "HasPhoto":
			return "修改了" + column.columnName + "信息"
		
		if oldValue == "" or oldValue == -1 or oldValue == None:
			return "设置" + column.columnName + "信息为" + user_profile.__get_value_desc(column,newValue)
		else:
			return "修改" + column.columnName + "信息，从" + user_profile.__get_value_desc(column,oldValue) + "改为" + user_profile.__get_value_desc(column,newValue)

	def get_dict(self):
		d = {}
		for k in self.__dict__:
			v = self.__dict__[k]
			if v == None or v == -1:
				d[k] = ""
			else:
				d[k] = v
		return d
		
class ctrl_profile:
	@staticmethod
	def get():
		s = session.get()
		return ctrl_profile.get_by_userid(s.user_id)
		
	@staticmethod
	def get_by_userid(user_id):
		user = user_profile()
		sql = """SELECT * FROM u_user as u LEFT JOIN u_profile as u1 ON u.ID=u1.ID WHERE u.ID=""" + str(user_id)
		c = utility.get_cursor()
		r = c.execute(sql).fetchone()
		if r == None:
			return None
		user.user_id = user_id
		i = 0
		for col in c.description:
			setattr(user,col[0].lower(),r[i])
			i+=1
			
		if user.age != -1 and user.agebegin != None:
			#increase user age every year 
			diff = utility.now().year - user.agebegin
			if diff > 0:
				user.age += diff
		return user

	@staticmethod
	def handle_profile_img(fp,user):
		assert isinstance(user,user_profile)
		user.update("hasphoto",1)
		img = Image.open(fp)
		img = ctrl_profile._rotate_img(img)
		img.thumbnail((1024,768))
		img.save(user.photo_url)
		
		img.thumbnail( (400,300) )
		img.save(user.small_photo_url)
		img.close()
	
	@staticmethod	
	def _get_rotate(image):
		if not hasattr(image,"_getexif"):
			return -1
		
		r = image._getexif()
		if not r:
			return -1
		
		orientation = 0x112
		if orientation not in r:
			return -1
		v = r[orientation]
		if v == 6:
			return Image.ROTATE_270
		elif v == 8:
			return Image.ROTATE_90
		elif v == 3:
			return Image.ROTATE_180
		else:
			return -1
	
	@staticmethod	
	def _rotate_img(image):
		#http://blog.csdn.net/daisyhd/article/details/6000962
		r = ctrl_profile._get_rotate(image)
		if r == -1:	
			return image 
		img = image.transpose(r)
		image.close()
		return img
		

@bottle.route('/my_space')	
@bottle.view('my_space')	
def url_show_space():
	d = utility.get_dist()
	return d

@bottle.route('/ta_request')	
@bottle.view('ta_request')	
def url_show_ta_request():
	d = utility.get_dist()
	u = ctrl_profile.get()
	d["photo_url"] = u.photo_url
	d["normal_photo_url"] = u.normal_photo_url
	d.update(u.get_dict())
	utility.update_c_table(d,"c_income",u.income)
	utility.update_c_table(d,"c_star",u.star)
	utility.update_c_table(d,"c_degree",u.degree)
	utility.update_c_table(d,"c_career",u.career)
	return d

@bottle.route('/record')	
@bottle.view('record')	
def url_show_record():
	d = utility.get_dist()
	utility.update_c_table(d,"c_record")
	return d

		
@bottle.route('/profile')	
@bottle.view('profile')	
def url_show_profile():
	d = utility.get_dist()
	u = ctrl_profile.get()
	d["photo_url"] = u.photo_url
	d["normal_photo_url"] = u.normal_photo_url
	d.update(u.get_dict())
	utility.update_c_table(d,"c_income",u.income)
	utility.update_c_table(d,"c_star",u.star)
	utility.update_c_table(d,"c_degree",u.degree)
	utility.update_c_table(d,"c_career",u.career)
	return d

@bottle.route('/action/update_profile')	
def url_update_profile():
	u = ctrl_profile.get()
	id = bottle.request.params.key
	v = bottle.request.params.value
	ret = u.update(id,v)
	if ret:
		return json.dumps({"result":"success","id":id})	
	else:
		return json.dumps({"result":"failed","id":id})	

@bottle.route('/user_images/<path:path>')	
def get_file(path):
	return bottle.static_file(path,"./user_images")

@bottle.route('/my_images/<path:path>')
def get_profile_file(path):
	u = user_profile()
	u.id = session.get().user_id
	return bottle.static_file(u.normal_photo_url,"")

@bottle.post('/action/upload_profile_photo')
def url_upload():
	user = ctrl_profile.get()
	upload = bottle.request.files.get('Filedata')
	mem = io.BytesIO()
	upload.save(mem)
	mem.seek(0)
	ctrl_profile.handle_profile_img(mem,user)
	mem.close()
	return 0

@bottle.post('/action/upload_id')
def url_upload_id():
	user = ctrl_profile.get()
	upload = bottle.request.files.get('qqfile')
	mem = io.BytesIO()
	upload.save(mem)
	mem.seek(0)
	mem.close()
	bottle.request.content_type = "text/plain"
	return json.dumps({"success":"true"})	

if __name__ == '__main__':
	utility.run_tests("test_user_profile.py")
	
#TODO: Age和AgeBegin改成BirdthdayYear
