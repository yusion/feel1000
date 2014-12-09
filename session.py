#coding=utf-8 
# ycat			 2014/09/28      create
import sqlite3
import os,time,datetime
import utility,bottle
		
#TODO过期和删除session  		
class session_data:
	def __init__(self):
		self.user_id = 0
		self.sex = -1
		self.ip = ""
		self.age = 0
		#0 代表未通过手机认证
		#1 已经通过手机认证
		#2 已经通过身份证认证
		#3 已经通过公司认证 
		self.certf_state = 0 
		self.nickname = ""
		self.session_id = ""
		self.login_date = datetime.datetime.now()
	
	@property
	def target_sex(self):
		if self.sex == 0:
			return 1
		if self.sex == 1:
			return 0
		return -1

g_session_data = {} 
_last_session_id = int(time.time())

def make_session_id():
	global _last_session_id
	_last_session_id += 1
	return utility.scramble(_last_session_id)

def login(loginName,password):
	ip = ""
	if bottle.request and bottle.request.remote_addr:
		ip = bottle.request.remote_addr
		
	c = utility.get_cursor()
	c.execute("SELECT ID,NickName,Sex,birthdayYear,certfState FROM u_user WHERE password=? AND (nickname=? OR phone=?)",(password,loginName,loginName))
	rows = c.fetchall()
	if len(rows) == 0:
		utility.write_log(-1,"登陆失败",0,ip)
		return None
	r = rows[0]
	user = session_data()
	user.user_id = r[0]
	user.nickname = r[1]
	user.sex = r[2]
	user.session_id = make_session_id()
	user.age = utility.now().year - r[3]
	user.certf_state = r[4]
	user.ip = ip
	
	global g_session_data
	g_session_data[user.session_id] = user
	
	utility.write_log(user.user_id,"登陆成功",1,ip)
	return user
	
def get():
	global g_session_data 
	return g_session_data[utility.get_session_id()]
	
def set(session_id,data):
	''' for test only '''
	global g_session_data
	g_session_data[session_id] = data
		
#############################	unit test	###########################		

		
if __name__ == '__main__':
	run_tests(__file__)		
			