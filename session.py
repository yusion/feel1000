#coding=utf-8 
# ycat			 2014/09/28      create
import sqlite3
import os,time,datetime
import utility
		
class session_data:
	def __init__(self):
		self.user_id = 0
		self.sex = -1
		self.ip = ""
		self.nickname = ""
		self.session_id = 0
		self.login_date = datetime.datetime.now()

class session:
	data = {} 
	last_session_id = int(time.time())
	
	@staticmethod
	def make_session_id():
		session.last_session_id += 1
		return session.last_session_id
	
	@staticmethod
	def login(loginName,password):
		c = utility.get_cursor()
		c.execute("SELECT ID,NickName,Sex FROM u_user WHERE password=? AND (nickname=? OR phone=?)",(password,loginName,loginName))
		rows = c.fetchall()
		if len(rows) == 0:
			return None
		r = rows[0]
		user = session_data()
		user.user_id = r[0]
		user.nickname = r[1]
		user.sex = r[2]
		user.session_id = session.make_session_id()
		session.data[user.session_id] = user
		return user
		
	@staticmethod
	def get(session_id):
		return session.data[session_id]
		
#############################	unit test	###########################		
	
		
if __name__ == '__main__':
	run_tests(__file__)		
			