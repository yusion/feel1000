#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import json
import pytest
import session
import utility
import sqlite3
import traceback
import sys,os,bottle,datetime
from bottle import route, template,install,view,request,get,post,SimpleTemplate

sex_type = utility.enum(Male=1,Female=0)

class ctrl_user_manager:
	@staticmethod
	def register(nick,phone,pwd,sex,age):
		assert int(sex) <= 1
		age = int(age)
		try:
			now = utility.now()
			db = utility.get_db()
			c = db.cursor()
			c.execute("INSERT INTO u_user (NickName,Sex,Phone,Password,CreateDate,BirthdayYear,CertfState)VALUES(?,?,?,?,?,?,?)", 
				(nick,int(sex),phone,pwd,now.strftime("%Y-%m-%d %H:%M:%S"),now.year - age,0))			
			db.commit()
			user = session.login(nick,pwd)
			
			c.execute("INSERT INTO u_profile(ID,EditDate)VALUES(?,?)",(user.user_id,now))
			utility.write_log(user.user_id,"注册成功",1,user.ip,False)
			db.commit()
			return user
			
		except Exception as err:
			traceback.print_exc()
			return None;

	def is_repeat(keyname,nick):
		sql = "SELECT COUNT(*) FROM u_user WHERE " + keyname+"=?"
		r = utility.get_cursor().execute(sql,(nick,))
		return r.fetchone()[0] > 0
		
@route('/register')	
@view('register')	
def url_show_register():
	return utility.get_dist()

@route('/agreement')	
@view('agreement')	
def url_show_agreement():
	return utility.get_dist()

@route('/action/register')	
def url_register():
	ret = ctrl_user_manager.register(bottle.request.params["nick"],
		bottle.request.params["phone"],
		bottle.request.params["pass"],
		bottle.request.params["sex"],
		bottle.request.params["age"])
	if ret:
		return json.dumps({"result":"true"})	
	else:
		return json.dumps({"result":"false"})	

@route('/action/is_repeat_phone')	
def url_is_repeat_phone():
	return str(not ctrl_user_manager.is_repeat("phone",bottle.request.params["phone"])).lower()

@route('/action/is_repeat_nickname')	
def url_is_repeat_nickname():
	return str(not ctrl_user_manager.is_repeat("nickName",bottle.request.params["nickname"])).lower()	


#############################	web unit test	###########################

@route('/test/check_user')	
def url_test_check_user():
	sql = "SELECT COUNT(*) FROM u_user WHERE nickname='%s' and password='%s' and phone='%s' and sex=%d and birthdayYear=%d" %	(bottle.request.params["nick"],
		utility.md5("pwd"+bottle.request.params["pass"]),bottle.request.params["phone"],int(bottle.request.params["sex"])
		,int(bottle.request.params["birthdayYear"]))	
	
	r = utility.get_cursor().execute(sql)
	return str(r.fetchone()[0]) 

def clear_test_user2():
	db = utility.get_db()
	c = db.cursor()
	c.execute("""DELETE FROM r_log WHERE userID IN
		(
		SELECT u_user.ID FROM u_user WHERE (Password like '%test%') OR  (nickname like 'test_%')
		)""")

	c.execute("DELETE FROM u_user WHERE (Password like '%test%') OR  (nickname like 'test_%')")
	c.execute("""DELETE FROM u_profile WHERE ID IN
		(
		SELECT u_profile.ID FROM u_profile LEFT JOIN u_user ON u_user.ID=u_profile.ID WHERE u_user.nickname is NULL
		)""")
	db.commit()
	
@route('/test/del_user')	
def url_test_del_user():
	clear_test_user2()

if __name__ == '__main__':
	utility.run_tests("test_user_manager.py")
	
#TODO:忘记密码要在登陆失败时，才弹出来。。。	