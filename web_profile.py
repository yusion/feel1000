#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import sqlite3,collections
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
	def __init__(self,id):
		self.user_id = id
		self.ip = "127.0.0.8"
		self.scores = {"1":"0","2":"0","3":"0","4":"0"} #4个选项
		self.tags = []
		self.desc = ""
		self._has_tag = False #是否已经存在u_tags表 
		self._read_tags()
	
	def _read_tags(self):
		c = utility.get_cursor()
		r = c.execute("SELECT tags,scoreID,score,desc FROM u_tags WHERE userID=%d"%self.user_id).fetchone()
		if not r:
			return
		
		if r[0] and len(r[0]):
			self.tags = r[0].split("@@")

		if r[1]	and r[2]:
			self.scores.clear()
			for k,v in zip(r[1].split(","),r[2].split(",")):
				self.scores[k] = v
		
		if r[3]:
			self.desc = r[3]
		self._has_tag = True 
	
	@property
	def small_photo_url(self):
		return "user_images/" + utility.scramble(self.user_id) + "_small.jpg"
	
	@property
	def normal_photo_url(self):
		return "user_images/" + utility.scramble(self.user_id) + ".jpg"
		
	@property
	def photo_url(self):
		if self.hasphoto:
			return self.normal_photo_url
		else:
			return "res/unknownprofile.jpg"
	
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
				d[k] = "未知"
			else:
				d[k] = v
		return d
		
	def save_tags(self,tags,scores,desc):
		if None == tags and None == desc and not scores :
			return
		
		db = utility.get_db()
		c = db.cursor()
		need = False
		
		cols = []
		vals = []
		
		if tags != None:
			s = set(tags) #清除重复的 
			val = "@@".join([x for x in s])
			utility.write_log(self.user_id,"修改tags`"+val+"`",1,False)
			cols.append("tags")
			vals.append(val)
			self.tags = tags
			
		if scores:
			o = collections.OrderedDict(sorted(scores.items(), key=lambda scores: scores[0]))
			val = ",".join([str(x) for x in o.values()])
			key = ",".join([str(x) for x in o.keys()])
			utility.write_log(self.user_id,"修改了评分信息`"+val+"`",1,False)
			cols.append("score")
			cols.append("scoreID")
			vals.append(val)
			vals.append(key)
			self.scores = scores
			
		if desc != None:
			cols.append("desc")
			vals.append(desc)
			utility.write_log(self.user_id,"修改描述`"+desc+"`",1,False)
			self.desc = desc	
		
		sql = ""
		if not self._has_tag:
			self._has_tag = True
			t = "?,"*len(cols)
			sql = "INSERT INTO u_tags(userID," + ",".join(cols) + ")VALUES(" +str(self.user_id)+"," + t[:-1] + ")"
		else:
			t = ""
			for x in cols:
				t += (x + "=?,")
			sql = "UPDATE u_tags SET " + t[:-1]
			sql += " WHERE userID=%d"%self.user_id
		c.execute(sql, vals)
		db.commit()

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
		c.execute("UPDATE u_profile SET %s=?,EditDate=? WHERE ID=?"%key,(value,now,self.user_id))
		utility.write_log(self.user_id,user_profile.get_log_desc(column,oldValue,value),1,False)
		db.commit()
		return True
	
class ctrl_profile:
	@staticmethod
	def _read(user_id):
		user = user_profile(user_id)
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
	s = session.get()
	d = session.get_dist() 
	d.update(s.profile.get_dict())
	d["scores"] = s.profile.scores
	d["tags"] = s.profile.tags
	d["my"] = True 
	d["age"] = s.age
	d["desc"] = s.profile.desc 
	utility.get_tags_table(d,s.sex)
	utility.get_score_table(d,s.sex)
	d["friend"] = utility.get_template_file("views/friend.tpl",{})
	return d

@bottle.route('/action/update_profile')	
def url_update_desc():
	u = session.get().profile
	tags_val = bottle.request.params.tags #list
	tags = None
	if tags_val:
		tags = tags_val.split(" ")
	
	scores_id = bottle.request.params.scores_id
	scores_val = bottle.request.params.scores_val
	scores = None
	if scores_id and scores_val:
		scores = {}
		for id,val in zip(scores_id.split(" "),scores_val.split(" ")):
			scores[id] = val
		
	desc = bottle.request.params.desc #string
	u.save_tags(tags,scores,desc) 
	return json.dumps({"result":"true"})		

@bottle.route('/ta_request')	
@bottle.view('ta_request')	
def url_show_ta_request():
	d = session.get_dist()
	u = session.get().profile
	d["photo_url"] = u.photo_url
	d["normal_photo_url"] = u.normal_photo_url
	d.update(u.get_dict())
	utility.update_c_table(d,"c_income",u.income)
	utility.update_c_table(d,"c_star",u.star)
	utility.update_c_table(d,"c_degree",u.degree)
	utility.update_c_table(d,"c_career",u.career)
	return d
	
@bottle.route('/profile')	
@bottle.view('profile')	
def url_show_profile():
	d = session.get_dist()
	u = session.get().profile
	d["photo_url"] = u.photo_url
	d["normal_photo_url"] = u.normal_photo_url
	d.update(u.get_dict())
	utility.update_c_table(d,"c_income",u.income)
	utility.update_c_table(d,"c_star",u.star)
	utility.update_c_table(d,"c_degree",u.degree)
	utility.update_c_table(d,"c_career",u.career)
	return d
	
@bottle.route('/action/update_profile_detail')	
def url_update_profile():
	u = session.get().profile
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
	u = user_profile(session.get().user_id)
	return bottle.static_file(u.normal_photo_url,"")

@bottle.post('/action/upload_profile_photo')
def url_upload():
	user = session.get().profile
	upload = bottle.request.files.get('Filedata')
	mem = io.BytesIO()
	upload.save(mem)
	mem.seek(0)
	#ctrl_profile.handle_profile_img(mem,user)
	mem.close()
	return 0

@bottle.post('/action/upload_id_cerf')
def url_upload_id_cerf():
	user = session.get().profile
	upload = bottle.request.files.get('qqfile')
	mem = io.BytesIO()
	upload.save(mem)
	mem.seek(0)
	#ctrl_profile.handle_profile_img(mem,user)
	mem.close()
	bottle.response.content_type = 'text/plain'
	return json.dumps({"success":"true"})

if __name__ == '__main__':
	utility.run_tests("test_user_profile.py")
	
#############################	web unit test	###########################
@bottle.route('/test/get_my_profile')	
def url_get_profile():
	u = session.get().profile
	return json.dumps(u.__dict__)


		









