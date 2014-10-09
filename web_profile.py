#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import sqlite3
import sys,os,bottle
import utility
import bottle 
from PIL import Image

class user_profile:
	def __init__(self):
		self.id = -1
		self.nickname = ""
		self._photo_url = None
		self.sex = 0

	@property
	def photo_url(self):
		if self._photo_url == None:
			self._photo_url = "res/man_unknown.gif"
		return self._photo_url
		
	def set_photo_url(self,url):
		db = utility.get_db()
		c = db.cursor()
		i = c.execute("UPDATE u_profile SET PhotoUrl=? WHERE ID=?",(url,self.id))
		db.commit()
		self._photo_url=url
		
class ctrl_user_profile:
	@staticmethod
	def get(user_id):
		user = user_profile()
		sql = """SELECT u.ID,u.NickName,u.Sex,
			u1.PhotoUrl
			FROM u_user as u LEFT JOIN u_profile as u1 ON u.ID=u1.ID  
			LEFT JOIN u_profile2 AS u2 ON u2.ID=u.ID WHERE u.ID=""" + str(user_id)
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
		user._photo_url = r[i]
		i+=1
		return user
		

@bottle.route('/profile')	
@bottle.view('profile')	
def url_show_profile():
	return utility.get_dist()

@bottle.route('/user_images/<path:path>')	
def get_file(path):
	return bottle.static_file(path,"./user_images")
	
@bottle.post('/action/upload_profile_photo')
def url_upload():
	upload     = bottle.request.files.get('Filedata')
	upload.save("user_images",overwrite=True) # appends upload.filename automatically
	
	img = Image.open(upload)
	print(img.size,img.mode)
	#如果太大，则缩小，太小则不变
	#同时生成thumbnail 
	#有规则的名字 id_profile.gif 
	return 0

if __name__ == '__main__':
	utility.run_tests("test_user_profile.py")
	