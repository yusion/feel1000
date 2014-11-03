#coding=utf-8 
# ycat			 2014/10/09      create
import pytest,os,sys
import web_register,session
import test_user_manager
from web_profile import *
from PIL import Image

def test_get_log_desc():
	c = profile_columns.get("height")
	assert "修改身高信息，从<span class='strong'>168厘米</span>改为<span class='strong'>180厘米</span>" == user_profile.get_log_desc(c,168,180)
	c = profile_columns.get("weight")
	assert "设置体重信息为<span class='strong'>50公斤</span>" == user_profile.get_log_desc(c,-1,50)
	
	c = profile_columns.get("degree")
	assert "设置学历信息为<span class='strong'>本科</span>" == user_profile.get_log_desc(c,-1,2)
	assert "修改学历信息，从<span class='strong'>硕士</span>改为<span class='strong'>本科</span>" == user_profile.get_log_desc(c,3,2)
	
	c = profile_columns.get("HasPhoto")
	assert "修改了头像信息" == user_profile.get_log_desc(c,0,1)
	assert "修改了头像信息" == user_profile.get_log_desc(c,1,1)
	
	c = profile_columns.get("city")
	assert "修改城市信息，从<span class='strong'>太原</span>改为<span class='strong'>常州</span>" == user_profile.get_log_desc(c,601,1104)

def test_profile_columns():
	assert None == profile_columns.get("citywrong")
	
	c = profile_columns.get("city")
	assert c.column == "City"
	assert c.columnName == "城市"
	assert profile_column_type.Changable == c.type
	assert c.get_value_desc(601) == "太原"
	assert c.get_value_desc(1104) == "常州"
	
	c = profile_columns.get("Email")
	assert c.column == "Email"
	assert c.columnName == "电子邮箱"
	assert profile_column_type.Changable == c.type
	assert c.get_value_desc("113595@qq.com") == "113595@qq.com"
	
	c = profile_columns.get("AgeBegin")
	assert c.column == "AgeBegin"
	assert c.columnName == "年龄开始年份"
	assert profile_column_type.Readonly == c.type
	assert c.get_value_desc(2014) == 2014
	
	c = profile_columns.get("Realname")
	assert c.column == "RealName"
	assert c.columnName == "真实姓名"
	assert profile_column_type.ChangeOnce == c.type
	
	c = profile_columns.get("Star")
	assert c.get_value_desc(1) == "白羊座 03.21─04.20"
	assert c.get_value_desc(5) == "狮子座 07.23─08.22"
	assert c.get_value_desc(-1) == ""
	
	c = profile_columns.get("income")
	assert c.get_value_desc(2) == "2k-5k"
	assert c.get_value_desc(5) == "5k-10k"
	assert c.get_value_desc(-1) == ""
	
	c = profile_columns.get("degree")
	assert c.get_value_desc(2) == "本科"
	assert c.get_value_desc(-1) == ""
	
def test_user_age():
	test_user_manager.clear_test_user()
	s = web_register.ctrl_user_manager.register("ycattest","13912546654","123test",web_register.sex_type.Male)
	utility.set_session_id(s.session_id)
	now = datetime.datetime(2010,5,27,12,50,43)
	utility.set_now(now)
	assert utility.now() == now
	
	u = ctrl_profile.get()
	assert not u.update("none",1)
	assert not u.update("none","abc")
	
	set_attri(u,"age",29,50)
	assert 50 == u.age
	assert 2010 == u.agebegin
	
	utility.set_now(datetime.datetime(2014,5,27,12,50,43))
	u2 = ctrl_profile.get_by_userid(u.id)
	assert 54 == u2.age
	assert 2010 == u2.agebegin
	
	utility.set_now(datetime.datetime(2024,5,27,12,50,43))
	u2 = ctrl_profile.get_by_userid(u.id)
	assert 64 == u2.age
	assert 2010 == u2.agebegin
	test_user_manager.clear_test_user()
	utility.set_now(None)

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
	if key == "age":
		assert u.agebegin == utility.now().year

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
		
	set_attri(u,"degree",1,2)
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
	fp = open("test/unittest1.jpg","rb")
	mem.write(fp.read())
	mem.seek(0)
	fp.close()
		
	ctrl_profile.handle_profile_img(mem,user)
	mem.close()
	l1,l2 = 1024,768
	s1,s2 = 400,300
	
	#高图片效果 
	img = Image.open(user.small_photo_url)
	assert img
	assert img.size[0] == s1 or img.size[1] == s2
	
	img2 = Image.open(user.normal_photo_url)
	assert img2
	assert img2.size[0] == l1 or img2.size[1] == l2
	
	#平图片效果
	ctrl_profile.handle_profile_img("test/unittest2.jpg",user)
	img = Image.open(user.small_photo_url)
	assert img
	assert img.size[0] == s1 or img.size[1] == s2
	
	img2 = Image.open(user.normal_photo_url)
	assert img2
	assert img2.size[0] == l1 or img2.size[1] == l2
	
	#小图效果
	ctrl_profile.handle_profile_img("test/unittest3.jpg",user)
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

def check_img(p,name,result):
	temp_name = p+"tmp_"+name
	img = Image.open(p+name)
	img = ctrl_profile._rotate_img(img)
	img.save(temp_name)
	img.close()
	b1 = Image.open(p+result).tobytes()
	b2 = Image.open(temp_name).tobytes()
	assert len(b1) == len(b2)
	for b,d in zip(b1,b2):
		assert b == d
	os.remove(temp_name)
	print(name,result)
	
def test_auto_rotate():	
	check_img("test/","2.gif","2.gif")
	check_img("test/","0.jpg","0result.jpg")
	check_img("test/","6.jpg","6result.jpg")
	check_img("test/","8.jpg","8result.jpg")

if __name__ == '__main__':
	utility.run_tests(__file__)
	
