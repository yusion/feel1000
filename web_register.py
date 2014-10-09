#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import json
import pytest
import session
import utility
import sqlite3
import sys,os,bottle,datetime
from bottle import route, template,install,view,request,get,post,SimpleTemplate

sex_type = utility.enum(Male=1,Female=0)

class ctrl_user_manager:
	@staticmethod
	def register(nick,phone,pwd,sex):
		assert sex <= 1
		try:
			now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
			db = utility.get_db()
			c = db.cursor()
			c.execute("INSERT INTO u_user (NickName,Sex,Phone,Password,CreateDate)VALUES(?,?,?,?,?)", 
				(nick,int(sex),phone,pwd,now))			
			db.commit()
			user = session.session.login(nick,pwd)
			
			c.execute("INSERT INTO u_profile(ID,EditDate)VALUES(?,?)",(user.user_id,now))
			c.execute("INSERT INTO u_profile2(ID,EditDate)VALUES(?,?)",(user.user_id,now))
			db.commit()
			return user
			
		except Exception as err:
			print(err)
			return None;

	def is_repeat(keyname,nick):
		sql = "SELECT COUNT(*) FROM u_user WHERE " + keyname+"=?"
		r = utility.get_cursor().execute(sql,(nick,))
		return r.fetchone()[0] > 0
			
			
@route('/register')	
@view('register')	
def url_show_register():
	return utility.get_dist()

@route('/action/register')	
def url_register():
	ret = ctrl_user_manager.register(bottle.request.params["nick"],
		bottle.request.params["phone"],
		bottle.request.params["pass"],
		sex_type(bottle.request.params["sex"]))
		
	if ret:
		return json.dumps({"result":"success"})	
	else:
		return json.dumps({"result":"failed"})	
 
		
if __name__ == '__main__':
	utility.run_tests("test_user_manager.py")
	
	