#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import platform  
import sys,os,bottle
import session,utility
from web_profile import url_show_profile
from web_login import url_show_login
from bottle import route, template,install,view,request,get,post,SimpleTemplate

@route('/res/<path:path>')	
def get_res_file(path):
	return bottle.static_file(path,"./res")

@route('/css/<path:path>')	
def get_res_file(path):
	return bottle.static_file(path,"./css")
	
@route('/js/<path:path>')	
def get_js_file(path):
	return bottle.static_file(path,"./js")
	 
@route('/jquery-easyui-1.3.2/<path:path>')	
def get_file(path):
	return bottle.static_file(path,"./jquery-easyui-1.3.2")

@route('/')	
@view('index')
def url_index():
	# response.add_header('Set-Cookie', 'name2=value2')
	d = utility.get_dist()
	user = session.login("ycat2","123456")
	bottle.response.set_header('Set-Cookie', 'session=%s'%user.session_id)
	d["session"] = user.session_id
	return d

#import web_register

if __name__ == '__main__':	
	print("python " + platform.python_version())
	os.chdir(os.path.dirname(__file__))
	#for root, dirs, files in os.walk(os.getcwd()):
	#	for name in files:
	#		if name[-3:] == ".py":				
	#			pytest.main(r"-v -x " + name)
	
	bottle.run(host='', port=80,reloader=True,debug=True)

	

	

	