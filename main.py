#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import platform  
import sys,os,bottle
import session,utility
from web_profile import url_show_profile,url_show_ta_request,url_show_record,url_upload_id_cerf
from web_login import url_show_login
from web_album import url_show_album
from web_search import *

@bottle.route('/res/<path:path>')	
def get_res_file(path):
	return bottle.static_file(path,"./res")

@bottle.route('/fonts/<path:path>')	
def get_res_file(path):
	return bottle.static_file(path,"./fonts")

@bottle.route('/css/<path:path>')	
def get_res_file(path):
	return bottle.static_file(path,"./css")
	
@bottle.route('/js/<path:path>')	
def get_js_file(path):
	return bottle.static_file(path,"./js")
	 
@bottle.route('/jquery-easyui-1.3.2/<path:path>')	
def get_file(path):
	return bottle.static_file(path,"./jquery-easyui-1.3.2")

@bottle.route('/')
@bottle.route('/index')	
@bottle.view('index')
def url_index():
	# response.add_header('Set-Cookie', 'name2=value2')
	d = utility.get_dist()
	user = session.login("ycat2","123456")
	bottle.response.set_header('Set-Cookie', 'session=%s'%user.session_id)
	d["session"] = user.session_id
	d["register"] = utility.get_template_file("views/register.tpl",d)
	d["login"] = utility.get_template_file("views/login.tpl",d)
	return d
 
if __name__ == '__main__':
	print("python " + platform.python_version())
	utility.set_is_test(True);
	
	os.chdir(os.path.dirname(__file__))
	
	#if utility.is_test():
	#	utility.run_all_tests()
	
	bottle.run(host='', port=80,reloader=True,debug=True)

	

	

	