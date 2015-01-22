#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import json 
import pytest
import session,utility
import sqlite3
import sys,os,bottle,datetime
from web_register import *

def clear_test_user():
	clear_test_user2()
	
def test_register():
	clear_test_user()
	session.clear()
	db = utility.get_db()
	c = db.cursor()
	c.execute("SELECT MAX(ID) FROM u_user")
	max_id = -1
	r = c.fetchone()
	if r and r[0] != None:
		max_id = r[0]
	u = ctrl_user_manager.register("ycat22'22#2\"2","546\"79'87979test",sex_type.Male,35)
	assert u
	utility.check_log(u.user_id,"注册成功",1)
	assert ctrl_user_manager.register("这是一个测试","32212346dfADDFDtest",sex_type.Female,29)
	c.execute("SELECT NickName,Password,CreateDate,Sex,birthdayYear,certfState from u_user WHERE ID > %d"%max_id)
	rows = c.fetchall()
	assert len(rows) == 2
	assert rows[0][0] == "ycat22'22#2\"2"
	assert rows[0][1] == "546\"79'87979test"
	assert datetime.datetime.strptime(rows[0][2],"%Y-%m-%d %H:%M:%S") - datetime.datetime.now() < datetime.timedelta(minutes=1)
	assert rows[0][3] == 1
	assert rows[0][4] == 1979 + datetime.datetime.now().year - 2014 #因为35岁,79年是2014的数据  
	assert rows[0][5] == 0

	assert rows[1][0] == "这是一个测试"	
	assert rows[1][1] == "32212346dfADDFDtest"
	assert datetime.datetime.strptime(rows[1][2],"%Y-%m-%d %H:%M:%S") - datetime.datetime.now() < datetime.timedelta(minutes=1)
	assert rows[1][3] == 0
	assert rows[1][4] == 1985 + datetime.datetime.now().year - 2014
	assert rows[1][5] == 0
	
	assert not ctrl_user_manager.is_repeat("NickName","noexist")	
	assert ctrl_user_manager.is_repeat("NickName","ycat22'22#2\"2")
	assert ctrl_user_manager.is_repeat("NickName","这是一个测试")
	
	clear_test_user()
	
def test_login():
	session.clear()
	clear_test_user()
	user = ctrl_user_manager.register("ycat","passwtest",sex_type.Male,23)
	utility.check_log(user.user_id,"注册成功",1,0)
	utility.check_log(user.user_id,"登陆成功",1,1)
	user = ctrl_user_manager.register("ycat2","passwtest",sex_type.Female,35)
	utility.check_log(user.user_id,"注册成功",1,0)
	utility.check_log(user.user_id,"登陆成功",1,1)
	assert 2 == len(session.g_session_data)
	assert not session.login("noexit","passwtest")
	utility.check_log(-1,"noexit登陆失败",0)
	user = session.login("ycat","passwtest")
	#utility.check_log(user.user_id,"登陆成功",1)
	ycatID = user.session_id
	utility.set_session_id(user.session_id)
	assert user
	assert user == session.get()
	assert user.sex == 1
	assert user.nickname == "ycat"
	assert user.user_id != 0
	assert 23 == user.age
	assert user.certf_state == 0
	#session.clear()
	
	user = session.login("ycat2","passwtest")
	utility.set_session_id(user.session_id)
	assert user
	assert user.sex == 0
	assert user.nickname == "ycat2"
	assert user.user_id != 0
	assert user.certf_state == 0
	assert user == session.get()
	assert 2 == len(session.g_session_data)
	session.logout()
	assert not session.get()
	assert 1 == len(session.g_session_data)
	assert session.g_session_data[ycatID].session_id == ycatID
	
	assert 35 == user.age
	
	for i in range(10):
		assert session._is_repeat_login("ycat","passwtest")
		assert not session._is_repeat_login("ycat","passwtest_wrong")
		assert session.login("ycat","passwtest") #repeat login but session keep same 
	assert 1 == len(session.g_session_data)
	
	session.clear();

	clear_test_user()
		 
		
if __name__ == '__main__':
	utility.run_tests(__file__)
	
	