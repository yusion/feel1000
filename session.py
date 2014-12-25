#coding=utf-8 
# ycat			 2014/09/28      create
import sqlite3
import web_profile
import os,time,datetime
import utility,bottle
		
#TODO过期和删除session, 访客的session要短一些,session过期需返回index 	
class session_data:
	def __init__(self):
		self.user_id = 0
		self.sex = -1
		self.ip = ""
		self.age = 0
		#0 代表未通过任何认证
		#1 已经通过身份证认证
		#2 已经通过公司认证 
		self.certf_state = 0 
		self.nickname = ""
		self.session_id = ""
		self.pwd = ""
		self.login_date = datetime.datetime.now()
	
	@property
	def target_sex(self):
		if self.sex == 0:
			return 1
		if self.sex == 1:
			return 0
		return -1
	
	@property
	def is_visit(self):
		return len(self.session_id) < 8
	

g_session_data = {} 
_last_session_id = int(time.time())
_visit_id = 0

def make_visit_id():
	global _visit_id
	_visit_id -= 1
	return _visit_id

def make_session_id():
	global _last_session_id
	_last_session_id += 1 
	return utility.scramble(_last_session_id)

def _is_repeat_login(loginName,password):
	global g_session_data
	for key in g_session_data:
		u = g_session_data[key]
		if u.pwd == password and u.nickname == loginName:
			return u
	return None 

def login(loginName,password):
	user = _is_repeat_login(loginName,password)
	if user:
		return user
	
	c = utility.get_cursor()
	c.execute("SELECT ID,NickName,Sex,birthdayYear,certfState,Password FROM u_user WHERE password=? AND nickname=?",(password,loginName))
	rows = c.fetchall()
	if len(rows) == 0:
		utility.write_log(-1,"登陆失败",0)
		return None
	r = rows[0]
	user = session_data()
	user.user_id = r[0]
	user.nickname = r[1]
	user.sex = r[2]
	user.session_id = make_session_id()
	user.age = utility.now().year - r[3]
	user.certf_state = r[4]
	user.pwd = r[5]
	user.ip = utility.get_ip()
	
	global g_session_data
	g_session_data[user.session_id] = user
	
	utility.write_log(user.user_id,"登陆成功",1)
	return user

def visit(sex):
	user = session_data()
	user.user_id = make_visit_id()
	user.nickname = ""
	user.sex = sex
	user.session_id = str(user.user_id)
	user.age = 0
	user.certf_state = 0
	user.ip = utility.get_ip()
	
	if sex == 0:
		utility.write_log(user.user_id,"男游客访问",1)
	else:
		utility.write_log(user.user_id,"女游客访问",1)
		
	global g_session_data
	g_session_data[user.session_id] = user
	return user
		
def get(id = None):
	global g_session_data
	if not id:
		id = utility.get_session_id()
	if id in g_session_data:
		return g_session_data[id]
	return None
	
def set(session_id,data):
	''' for test only '''
	global g_session_data
	g_session_data[session_id] = data

def clear():
	global g_session_data
	g_session_data.clear()

def logout():
	user = get()
	if not user:
		return
	del g_session_data[user.session_id]

def get_dist2():
	d = {}
	d["version"] = utility.get_version()
	d["is_test"] = utility.is_test()
	d["web_head"] = utility.get_template_file("views/head.tpl",d)
	return d

def _get_profile_dist(d,s):	
	d["name"] = "游客"
	d["photo_url"] = "/res/unknownprofile.jpg"
	d["session"] = "-1"
	if not s:
		return
	
	d["session"] = s.session_id
	if s.is_visit: 
		if 0 == s.sex:
			d["name"] = "神秘的帅哥"
			d["photo_url"] = "/res/boy.jpg"
		else:
			d["name"] = "神秘的美女"
			d["photo_url"] = "/res/girl.jpg"
	else:
		user = web_profile.ctrl_profile.get(s.user_id)
		if not user:
			return
		d["name"] = user.nickname
		d["photo_url"] = user.small_photo_url

def get_dist(session = None):
	d = get_dist2()
	if session == None:
		session = get() 

	_get_profile_dist(d,session) 
	d["page_head"] = utility.get_template_file("views/pagehead.tpl",d)
	d["page_foot"] = utility.get_template_file("views/pagefoot.tpl",d)
	return d

#############################	unit test	###########################		
def test_visit():
	pass
		
if __name__ == '__main__':
	run_tests(__file__)		
			