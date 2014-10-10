#coding=utf-8 
# ycat			 2014/10/09      create
import pytest,os,sys
import web_register,session
import test_user_manager
from web_profile import *
from PIL import Image

def test_get_user():
	test_user_manager.clear_test_user()
	s = web_register.ctrl_user_manager.register("ycattest","13912546654","123test",web_register.sex_type.Male)
	assert s
	utility.set_session_id(s.session_id)
	
	u = ctrl_profile.get()
	assert u
	assert u.nickname == "ycattest"
	assert u.id == s.user_id
	assert u.sex == web_register.sex_type.Male
	assert u.has_photo == 0
	test_user_manager.clear_test_user()

def test_set_photo_url():
	s = web_register.ctrl_user_manager.register("ycattest","13912546654","123test",web_register.sex_type.Male)
	utility.set_session_id(s.session_id)
	u = ctrl_profile.get()
	assert u.has_photo == 0
	u.update_photo_state()
	
	assert u.has_photo == 1
	test_user_manager.clear_test_user()

def test_handle_profile_img():
	user = user_profile()
	user.id = 978897112
	user.has_photo = True
	mem = io.BytesIO()
	fp = open("user_images/unittest1.jpg","rb")
	mem.write(fp.read())
	mem.seek(0)
	fp.close()
		
	ctrl_profile.handle_profile_img(mem,user)
	mem.close()
	#高图片效果 
	img = Image.open("user_images/978897112_small.jpg")
	assert img
	assert img.size[0] == 100 or img.size[1] == 100
	
	img2 = Image.open("user_images/978897112.jpg")
	assert img2
	assert img2.size[0] == 400 or img2.size[1] == 300
	
	#平图片效果
	ctrl_profile.handle_profile_img("user_images/unittest2.jpg",user)
	img = Image.open("user_images/978897112_small.jpg")
	assert img
	assert img.size[0] == 100 or img.size[1] == 100
	
	img2 = Image.open("user_images/978897112.jpg")
	assert img2
	assert img2.size[0] == 400 or img2.size[1] == 300
	
	#小图效果
	ctrl_profile.handle_profile_img("user_images/unittest3.jpg",user)
	img = Image.open("user_images/978897112_small.jpg")
	assert img
	assert img.size[0] <= 50 or img.size[1] <= 50
	
	img2 = Image.open("user_images/978897112.jpg")
	assert img2
	assert img2.size[0] <= 50 or img2.size[1] <= 50
	
	img.close()
	img2.close()
	os.remove("user_images/978897112_small.jpg")
	os.remove("user_images/978897112.jpg")

if __name__ == '__main__':
	utility.run_tests(__file__)
	
