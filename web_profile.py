#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import sqlite3
import sys,os,io
import utility
import bottle,session
from PIL import Image

class user_profile:
	def __init__(self):
		self.id = -1
		self.nickname = ""
		self.has_photo = 0
		self.sex = 0
		
	def update_photo_state(self):
		if self.has_photo:
			return
		db = utility.get_db()
		c = db.cursor()
		c.execute("UPDATE u_profile SET HasPhoto=1 WHERE ID=%d"%self.id)
		db.commit()
		self.has_photo=1
	
	@property
	def small_photo_url(self):
		return "user_images/" + str(self.id) + "_small.jpg"
	
	@property
	def normal_photo_url(self):
		return "user_images/" + str(self.id) + ".jpg"
		
	@property
	def photo_url(self):
		if self.has_photo:
			return self.normal_photo_url
		else:
			return "res/man_unknown.gif"
		
need to scramble image id
login user_id 

		
class ctrl_profile:
	@staticmethod
	def get():
		s = session.get()
		user = user_profile()
		sql = """SELECT u.ID,u.NickName,u.Sex,
			u1.HasPhoto
			FROM u_user as u LEFT JOIN u_profile as u1 ON u.ID=u1.ID  
			LEFT JOIN u_profile2 AS u2 ON u2.ID=u.ID WHERE u.ID=""" + str(s.user_id)
		r = utility.get_cursor().execute(sql).fetchone()
		if r == None:
			return None
		
		i = 0
		user.id = r[i]
		i+=1
		user.nickname = r[i]
		i+=1
		user.sex = r[i]
		i+=1
		user.has_photo = r[i]
		i+=1
		return user
	
	@staticmethod
	def handle_profile_img(fp,user):
		assert isinstance(user,user_profile)
		img = Image.open(fp)		
		img.thumbnail((400,300))
		img.save(user.photo_url)
		
		img.thumbnail( (100,100) )
		img.save(user.small_photo_url)
		img.close()

@bottle.route('/profile')	
@bottle.view('profile')	
def url_show_profile():
	d = utility.get_dist()
	u = ctrl_profile.get()
	d["photo_url"] = u.photo_url
	d["normal_photo_url"] = u.normal_photo_url
	return d

@bottle.route('/user_images/<path:path>')	
def get_file(path):
	return bottle.static_file(path,"./user_images")

@bottle.post('/action/upload_profile_photo')
def url_upload():
	user = ctrl_profile.get()
	
	upload = bottle.request.files.get('Filedata')
	mem = io.BytesIO()
	upload.save(mem)
	mem.seek(0)
	user.update_photo_state()
	ctrl_profile.handle_profile_img(mem,user)
	mem.close()
	return 0


if __name__ == '__main__':
	utility.run_tests("test_user_profile.py")
	