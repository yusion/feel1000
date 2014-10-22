#coding=utf-8 
# ycat			 2014/10/09      create
import pytest,os,sys
import web_register,session
import test_user_manager
from web_profile import *
from PIL import Image

def set_attri(u,key,value1,value2):
	assert u.update(key,str(value1))
	u2 = ctrl_profile.get_by_userid(u.id)
	assert getattr(u2,key) == value1
	assert getattr(u2,key) == getattr(u,key)
	assert u.get_dict()[key] == value1
	
	assert u.update(key,str(value2))
	u2 = ctrl_profile.get_by_userid(u.id)
	assert getattr(u2,key) == value2
	assert getattr(u2,key) == getattr(u,key)
	assert u.get_dict()[key] == value2

def test_update():
	test_user_manager.clear_test_user()
	s = web_register.ctrl_user_manager.register("ycattest","13912546654","123test",web_register.sex_type.Male)
	utility.set_session_id(s.session_id)
	u = ctrl_profile.get()
	assert not u.update("none",1)
	assert not u.update("none","abc")
	
	set_attri(u,"age",20,18)
	set_attri(u,"height",168,180)
	set_attri(u,"weight",50,80)
	set_attri(u,"realname","ycat1","姚舜")
	set_attri(u,"qq","13597556","3135478797456")
	set_attri(u,"email","13597556","3135478797456")
	set_attri(u,"blogid","1359<BR>7556","3135478797456")
	set_attri(u,"address","13597556","31354787'9<7>456")
	
	set_attri(u,"career","IT工程师","不知道'9<7>456")
	set_attri(u,"campany","13597556","company 在英文单词中一般的意思是：")
	set_attri(u,"income",1,22200)
		
	set_attri(u,"degree","1","")
	set_attri(u,"school","company 在英文单词中一般的意思是","company 在ssss英文单词中一般的sss意思是")
	assert u.update("income","")
	u2 = ctrl_profile.get_by_userid(u.id)
	assert getattr(u2,"income") == -1
	test_user_manager.clear_test_user()
	
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
	assert u.hasphoto == 0
	test_user_manager.clear_test_user()

def test_set_photo_url():
	s = web_register.ctrl_user_manager.register("ycattest","13912546654","123test",web_register.sex_type.Male)
	utility.set_session_id(s.session_id)
	u = ctrl_profile.get()
	assert u.hasphoto == 0
	u.update("hasphoto",1)
	assert u.hasphoto == 1
	test_user_manager.clear_test_user()

def test_handle_profile_img():
	user = user_profile()
	user.id = 978897112
	user.hasphoto = True
	mem = io.BytesIO()
	fp = open("user_images/unittest1.jpg","rb")
	mem.write(fp.read())
	mem.seek(0)
	fp.close()
		
	ctrl_profile.handle_profile_img(mem,user)
	mem.close()
	#高图片效果 
	img = Image.open(user.small_photo_url)
	assert img
	assert img.size[0] == 100 or img.size[1] == 100
	
	img2 = Image.open(user.normal_photo_url)
	assert img2
	assert img2.size[0] == 400 or img2.size[1] == 300
	
	#平图片效果
	ctrl_profile.handle_profile_img("user_images/unittest2.jpg",user)
	img = Image.open(user.small_photo_url)
	assert img
	assert img.size[0] == 100 or img.size[1] == 100
	
	img2 = Image.open(user.normal_photo_url)
	assert img2
	assert img2.size[0] == 400 or img2.size[1] == 300
	
	#小图效果
	ctrl_profile.handle_profile_img("user_images/unittest3.jpg",user)
	img = Image.open(user.small_photo_url)
	assert img
	assert img.size[0] <= 50 or img.size[1] <= 50
	
	img2 = Image.open(user.normal_photo_url)
	assert img2
	assert img2.size[0] <= 50 or img2.size[1] <= 50
	
	img.close()
	img2.close()
	os.remove(user.small_photo_url)
	os.remove(user.normal_photo_url)

if __name__ == '__main__':
	utility.run_tests(__file__)
	