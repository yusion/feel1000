#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import json
import pytest
import session
import sys,os,bottle,datetime
from bottle import route, template,install,view,request,get,post,SimpleTemplate

import sqlite3
class user_profile:
	@staticmethod
	def register(nick,phone,pwd,sex):
		assert sex <= 1
		try:
			db = session.global_info.get_db()
			c = db.cursor()
			c.execute("INSERT INTO u_user (NickName,Sex,Phone,Password,CreateDate)VALUES(?,?,?,?,?)", 
				(nick,sex,phone,pwd,datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")))
			db.commit()
			return True
		except Exception as err:
			print(err)
			return False;

	def is_repeat(keyname,nick):
		sql = "SELECT COUNT(*) FROM u_user WHERE " + keyname+"=?"
		r = session.global_info.get_cursor().execute(sql,(nick,))
		return r.fetchone()[0] > 0
			
			
@route('/register')	
@view('register')	
def url_show_register():
	return session.global_info.get_dist()

@route('/action/register')	
def url_register():
	ret = user_profile.register(bottle.request.params["nick"],
		bottle.request.params["phone"],
		bottle.request.params["pass"],
		int(bottle.request.params["sex"]))
		
	if ret:
		return json.dumps({"result":"success"})	
	else:
		return json.dumps({"result":"failed"})	

#############################	unit test	###########################		
def clear_test_user():
	db = session.global_info.get_db()
	c = db.cursor()
	c.execute("DELETE FROM u_user WHERE Password like '%test%'")
	db.commit()
	
def test_register():
	db = session.global_info.get_db()
	c = db.cursor()
	c.execute("SELECT MAX(ID) FROM u_user")
	max_id = -1
	r = c.fetchone()
	if r and r[0] != None:
		max_id = r[0]
	assert user_profile.register("ycat22'22#2\"2","132974'26\"4666","546\"79'87979test",1)
	assert user_profile.register("这是一个测试","13928979001","32212346dfADDFDtest",0)
	c.execute("SELECT NickName,Phone,Password,CreateDate,Sex from u_user WHERE ID > %d"%max_id)
	rows = c.fetchall()
	assert len(rows) == 2
	assert rows[0][0] == "ycat22'22#2\"2"
	assert rows[0][1] == "132974'26\"4666"
	assert rows[0][2] == "546\"79'87979test"
	assert datetime.datetime.strptime(rows[0][3],"%Y-%m-%d %H:%M:%S") - datetime.datetime.now() < datetime.timedelta(minutes=1)
	assert rows[0][4] == 1

	assert rows[1][0] == "这是一个测试"	
	assert rows[1][1] == "13928979001"
	assert rows[1][2] == "32212346dfADDFDtest"
	assert datetime.datetime.strptime(rows[1][3],"%Y-%m-%d %H:%M:%S") - datetime.datetime.now() < datetime.timedelta(minutes=1)
	assert rows[1][4] == 0
	
	assert not user_profile.is_repeat("NickName","noexist")
	assert not user_profile.is_repeat("Phone","noexist")
	
	assert user_profile.is_repeat("NickName","这是一个测试")
	assert user_profile.is_repeat("Phone","132974'26\"4666")
	assert user_profile.is_repeat("NickName","ycat22'22#2\"2")
	assert user_profile.is_repeat("Phone","13928979001")
	
	clear_test_user()
	
def test_login():	
	user_profile.register("ycat","13956464001","passwtest",1)
	user_profile.register("ycat2","17056464001","passwtest",0)
	assert not session.session.login("noexit","passwtest")
	user = session.session.login("ycat","passwtest")
	assert user
	assert user == session.session.get(user.session_id)
	assert user.sex == 1
	assert user.nickname == "ycat"
	assert user.user_id != 0
	session.session.data.clear();
	
	user = session.session.login("13956464001","passwtest")
	assert user
	assert user.sex == 1
	assert user.nickname == "ycat"
	assert user.user_id != 0
	assert user == session.session.get(user.session_id)
	session.session.data.clear();
	
	user = session.session.login("ycat2","passwtest")
	assert user
	assert user.sex == 0
	assert user.nickname == "ycat2"
	assert user.user_id != 0
	assert user == session.session.get(user.session_id)
	session.session.data.clear();
	
	assert session.session.login("17056464001","passwtest")
	clear_test_user()
		
if __name__ == '__main__':
	if sys.platform == "win32":
		os.chdir(os.path.dirname(__file__))
	pytest.main("-v -x " + os.path.basename(__file__))				
	
	