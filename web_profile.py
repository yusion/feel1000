#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import sqlite3
import sys,os,io,datetime
import utility,json
import bottle,session
from PIL import Image

class user_profile:
	def __init__(self):
		pass
	
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
		if not hasattr(self,key):
			return False
		if getattr(self,key) == value:
			return True
		if key == "id" or key== "user_id":
			return False
		
		if isinstance(self.__dict__[key],int):
			if value == "":
				value = -1
			setattr(self,key,int(value))
		else:
			setattr(self,key,str(value))
		
		db = utility.get_db()
		c = db.cursor()
		now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
		c.execute("UPDATE u_profile SET %s=?,EditDate=? WHERE ID=?"%key,(value,now,self.user_id))
		db.commit()
		return True
	
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


if __name__ == '__main__':
	utility.run_tests("test_user_profile.py")
	