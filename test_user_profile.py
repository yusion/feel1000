#coding=utf-8 
# ycat			 2014/10/09      create
import pytest,os,sys
import web_register,session
import test_user_manager
from web_profile import *
from PIL import Image
	 
def test_user_age():
	test_user_manager.clear_test_user()
	now = datetime.datetime(2014,5,27,12,50,43)
	utility.set_now(now)
	assert utility.now() == now
	
	s = web_register.ctrl_user_manager.register("ycattest","123test",web_register.sex_type.Male,35)
	utility.set_session_id(s.session_id)
	assert session.get().age == 35
	session.logout()
	
	utility.set_now(datetime.datetime(2015,5,27,12,50,43))
	s = session.login("ycattest","123test")
	assert s.age == 36

	test_user_manager.clear_test_user()
	utility.set_now(None)

def set_attri(u,key,value1,value2):
	dd = {}
	dd[key] = str(value1)
	assert u.save_profile(dd)
	u2 = ctrl_profile._read(u.id)
	assert getattr(u2,key) == value1
	assert getattr(u2,key) == getattr(u,key)
	assert u.get_dict()[key] == value1
	
	dd[key] = str(value2)
	assert u.save_profile(dd)
	u2 = ctrl_profile._read(u.id)
	assert getattr(u2,key) == value2
	assert getattr(u2,key) == getattr(u,key)
	assert u.get_dict()[key] == value2
	if key == "age":
		assert u.agebegin == utility.now().year
	log = "修改： %s:`%s`->`%s`, " % (str(key),str(value1),str(value2))
	utility.check_log(u.user_id,log,1)	

def test_update_single():
	test_user_manager.clear_test_user()
	s = web_register.ctrl_user_manager.register("ycattest","123test",web_register.sex_type.Male,35)
	utility.set_session_id(s.session_id)
	u = ctrl_profile._read(s.user_id)
	assert s.age == 35
	assert not u.save_profile({"none":1})
	assert not u.save_profile({"none":"abc"})
	
	set_attri(u,"height",168,180)
	set_attri(u,"weight",50,80)
	set_attri(u,"realname","ycat1","姚舜")
	set_attri(u,"email","13597556","3135478797456")
	set_attri(u,"address","13597556","31354787'9<7>456")
	
	set_attri(u,"career",2,3)
	set_attri(u,"campany","13597556","company 在英文单词中一般的意思是：")
	set_attri(u,"income",1,22200)
		
	set_attri(u,"degree",1,2)
	set_attri(u,"school","company 在英文单词中一般的意思是","company 在ssss英文单词中一般的sss意思是")
	assert u.save_profile({"income":""})
	u2 = ctrl_profile._read(u.id)
	assert getattr(u2,"income") == -1
	test_user_manager.clear_test_user()
	
def test_update():
	test_user_manager.clear_test_user()
	s = web_register.ctrl_user_manager.register("ycattest","123test",web_register.sex_type.Male,35)
	utility.set_session_id(s.session_id)
	u = ctrl_profile._read(s.user_id)
	assert hasattr(u,"city")
	d = {}
	d["realName"] = "ycat姚"
	d["Address"] = "ycat桃园西路"
	d["Income"] = "2"
	d["Height"] = 168
	d["Weight"] = 50
	d["Email"] = "ycat@gqq.com"
	d["City"] = "广州"
	d["Star"] = "3"
	d["Career"] = "2"
	d["Campany"] = "lfasdlfd通信公司"
	d["Degree"] = ""
	d["School"] = "暨南大学数据系统"
	u.save_profile(d)
	u2 = ctrl_profile._read(s.user_id)
	for uu in (u,u2):
		assert uu.realname == "ycat姚"
		assert uu.address == "ycat桃园西路"
		assert uu.income == 2
		assert uu.height == 168
		assert uu.weight == 50
		assert uu.email == "ycat@gqq.com"
		assert uu.city ==  "广州"
		assert uu.star == 3
		assert uu.career == 2
		assert uu.campany == "lfasdlfd通信公司"
		assert uu.degree == -1
		assert uu.school == "暨南大学数据系统"
	log = "修改： Campany:`None`->`lfasdlfd通信公司`, City:`None`->`广州`, School:`None`->`暨南大学数据系统`, Degree:`-1`->`-1`, Star:`-1`->`3`, realName:`None`->`ycat姚`, Weight:`-1`->`50`, Career:`-1`->`2`, Address:`None`->`ycat桃园西路`, Height:`-1`->`168`, Income:`-1`->`2`, Email:`None`->`ycat@gqq.com`, "
	utility.check_log(u.user_id,log,1)	
	test_user_manager.clear_test_user()
	
def test_get_user():
	test_user_manager.clear_test_user()
	s = web_register.ctrl_user_manager.register("ycattest","123test",web_register.sex_type.Male,35)
	assert s
	utility.set_session_id(s.session_id)
	
	u = ctrl_profile._read(s.user_id)
	assert u
	assert u.nickname == "ycattest"
	assert u.id == s.user_id
	assert u.sex == web_register.sex_type.Male
	assert u.hasphoto == 0
	test_user_manager.clear_test_user()

def test_set_photo_url():
	s = web_register.ctrl_user_manager.register("ycattest","123test",web_register.sex_type.Male,35)
	utility.set_session_id(s.session_id)
	u = ctrl_profile._read(s.user_id)
	assert u.hasphoto == 0
	u.save_profile({"hasphoto":1})
	assert u.hasphoto == 1
	test_user_manager.clear_test_user()

def test_handle_profile_img():
	user = user_profile(1001)
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

def test_score():
	s = web_register.ctrl_user_manager.register("ycattest","123test",web_register.sex_type.Male,35)
	utility.set_session_id(s.session_id)
	u = ctrl_profile._read(s.user_id)
	c = {"1":"0","2":"0","3":"0","4":"0"}
	utility.assert_dict(c,u.scores)
	
	c = {"1":"5","2":"4","3":"2","4":"1"}
	u.save_tags(None,c,None)
	utility.check_log(u.user_id,"修改了评分信息`5,4,2,1`",1)
	
	db = utility.get_db()
	cc = db.cursor()
	r = db.execute("SELECT score,scoreID FROM u_tags WHERE userID=%d"%u.user_id).fetchone()
	assert r
	assert r[1] == "1,2,3,4"
	assert r[0] == "5,4,2,1"
	
	utility.assert_dict(c,u.scores)
	u._scores = None
	utility.assert_dict(c,u.scores)
	
	c = {"1":"3","2":"2","3":"1","4":"5"}
	u.save_tags(None,c,None)
	utility.assert_dict(c,u.scores)
	u._scores = None
	utility.assert_dict(c,u.scores)
	test_user_manager.clear_test_user()
		
def test_save_desc():
	s = web_register.ctrl_user_manager.register("ycattest","123test",web_register.sex_type.Male,35)
	utility.set_session_id(s.session_id)
	u = ctrl_profile._read(s.user_id)
	
	for i in range(4):
		v = """
		fsdfsdfdsf'dfsf<FADFSDF><BR>"\n\r\tdsfadfsf
		"""
		v += str(i)
		if i ==1:
			v =""
		u.save_tags(None,None,v)
		if i ==1:
			assert u.desc == ""
		else:
			assert u.desc == v
			
		cc = utility.get_cursor()
		rr = cc.execute("SELECT desc FROM u_tags WHERE userid=?",(u.user_id,)).fetchall()
		assert len(rr) == 1
		assert rr[0][0] == v
		utility.check_log(u.user_id,"修改描述`"+v+"`",1)
	test_user_manager.clear_test_user()

def test_save_tags():
	s = web_register.ctrl_user_manager.register("ycattest","123test",web_register.sex_type.Male,35)
	utility.set_session_id(s.session_id)
	u = ctrl_profile._read(s.user_id)
	t = ["聪明通威的","长腿欧巴","运动健将","风趣幽默"]
	oo = "长腿欧巴@@聪明通威的@@运动健将@@风趣幽默"	
	u.save_tags(t,None,None)
	assert u.tags == t
	cc = utility.get_cursor()
	rr = cc.execute("SELECT tags FROM u_tags WHERE userid=?",(u.user_id,)).fetchall()
	assert len(rr) == 1
	assert rr[0][0] == oo
	utility.check_log(u.user_id,"修改tags`"+oo+"`",1)
	
	t = ["聪明通威的1","长腿欧巴1","运动健将1","长腿欧巴1","风趣幽默1","风趣幽默1"]
	oo = "长腿欧巴1@@风趣幽默1@@聪明通威的1@@运动健将1"
	u.save_tags(t,None,None)
	assert u.tags == t
	cc = utility.get_cursor()
	rr = cc.execute("SELECT tags FROM u_tags WHERE userid=?",(u.user_id,)).fetchall()
	assert len(rr) == 1
	assert rr[0][0] == oo
	utility.check_log(u.user_id,"修改tags`"+oo+"`",1)
	
	t = []
	oo = ""
	u.save_tags(t,None,None)
	assert u.tags == t
	cc = utility.get_cursor()
	rr = cc.execute("SELECT tags FROM u_tags WHERE userid=?",(u.user_id,)).fetchall()
	assert len(rr) == 1
	assert rr[0][0] == oo
	utility.check_log(u.user_id,"修改tags`"+oo+"`",1)
	test_user_manager.clear_test_user()
	
def test_save_tags2():
	s = web_register.ctrl_user_manager.register("ycattest","123test",web_register.sex_type.Male,35)
	utility.set_session_id(s.session_id)
	u = ctrl_profile._read(s.user_id)
	t = ["聪明通威的","长腿欧巴","运动健将","风趣幽默"]
	c = {"1":"0","2":"0","3":"0","4":"0"}
	d = "lalalala"
	u.save_tags(t,None,d)
	
	u2 = ctrl_profile._read(s.user_id)
	assert u2.desc == d
	assert u.desc == d
	
	assert u.scores == c
	assert u2.scores == c
	
	utility.assert_array_noorder(u.tags,t)
	utility.assert_array_noorder(u2.tags,t)
	
	d = "asgfasfgw532534sd"
	c = {"1":"5","2":"4","3":"2","4":"2"}
	u.save_tags(t,c,d)
	u2 = ctrl_profile._read(s.user_id)
	assert u2.desc == d
	assert u.desc == d
	
	assert u.scores == c
	assert u2.scores == c
	
	utility.assert_array_noorder(u.tags,t)
	utility.assert_array_noorder(u2.tags,t)
	
	utility.assert_array_noorder(u.tags,t)
	utility.assert_array_noorder(u2.tags,t)
	
	d = "asgfasfgw532534sd"
	c = {"1":"5","2":"4","3":"3","4":"2"}
	u.save_tags(None,c,d)
	u2 = ctrl_profile._read(s.user_id)
	assert u2.desc == d
	assert u.desc == d
	
	assert u.scores == c
	assert u2.scores == c
	
	utility.assert_array_noorder(u.tags,t)
	utility.assert_array_noorder(u2.tags,t)
	
	test_user_manager.clear_test_user()
		
def test_auto_rotate():	
	check_img("test/","2.gif","2.gif")
	check_img("test/","0.jpg","0result.jpg")
	check_img("test/","6.jpg","6result.jpg")
	check_img("test/","8.jpg","8result.jpg")	

if __name__ == '__main__':
	utility.run_tests(__file__)
	
