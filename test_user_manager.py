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
	db = utility.get_db()
	c = db.cursor()
	c.execute("SELECT MAX(ID) FROM u_user")
	max_id = -1
	r = c.fetchone()
	if r and r[0] != None:
		max_id = r[0]
	assert ctrl_user_manager.register("ycat22'22#2\"2","132974'26\"4666","546\"79'87979test",sex_type.Male,35)
	assert ctrl_user_manager.register("这是一个测试","13928979001","32212346dfADDFDtest",sex_type.Female,29)
	c.execute("SELECT NickName,Phone,Password,CreateDate,Sex,birthdayYear,certfState from u_user WHERE ID > %d"%max_id)
	rows = c.fetchall()
	assert len(rows) == 2
	assert rows[0][0] == "ycat22'22#2\"2"
	assert rows[0][1] == "132974'26\"4666"
	assert rows[0][2] == "546\"79'87979test"
	assert datetime.datetime.strptime(rows[0][3],"%Y-%m-%d %H:%M:%S") - datetime.datetime.now() < datetime.timedelta(minutes=1)
	assert rows[0][4] == 1
	assert rows[0][5] == 1979
	assert rows[0][6] == 0

	assert rows[1][0] == "这是一个测试"	
	assert rows[1][1] == "13928979001"
	assert rows[1][2] == "32212346dfADDFDtest"
	assert datetime.datetime.strptime(rows[1][3],"%Y-%m-%d %H:%M:%S") - datetime.datetime.now() < datetime.timedelta(minutes=1)
	assert rows[1][4] == 0
	assert rows[1][5] == 1985
	assert rows[1][6] == 0
	
	assert not ctrl_user_manager.is_repeat("NickName","noexist")
	assert not ctrl_user_manager.is_repeat("Phone","noexist")
	
	assert ctrl_user_manager.is_repeat("NickName","这是一个测试")
	assert ctrl_user_manager.is_repeat("Phone","132974'26\"4666")
	assert ctrl_user_manager.is_repeat("NickName","ycat22'22#2\"2")
	assert ctrl_user_manager.is_repeat("Phone","13928979001")
	
	clear_test_user()
	
def test_login():
	clear_test_user()
	ctrl_user_manager.register("ycat","13956464001","passwtest",sex_type.Male,23)
	ctrl_user_manager.register("ycat2","17056464001","passwtest",sex_type.Female,35)
	assert not session.login("noexit","passwtest")
	user = session.login("ycat","passwtest")
	utility.set_session_id(user.session_id)
	assert user
	assert user == session.get()
	assert user.sex == 1
	assert user.nickname == "ycat"
	assert user.user_id != 0
	assert 23 == user.age
	assert user.certf_state == 0
	session.g_session_data.clear();
	
	user = session.login("13956464001","passwtest")
	utility.set_session_id(user.session_id)
	assert user
	assert user.sex == 1
	assert user.nickname == "ycat"
	assert user.user_id != 0
	assert user == session.get()
	assert 23 == user.age
	assert user.certf_state == 0
	session.g_session_data.clear();
	
	user = session.login("ycat2","passwtest")
	utility.set_session_id(user.session_id)
	assert user
	assert user.sex == 0
	assert user.nickname == "ycat2"
	assert user.user_id != 0
	assert user.certf_state == 0
	assert user == session.get()
	
	assert 35 == user.age
	session.g_session_data.clear();
	
	assert session.login("17056464001","passwtest")
	clear_test_user()
		 
		
if __name__ == '__main__':
	utility.run_tests(__file__)
	
	