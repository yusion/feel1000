#coding=utf-8 
# ycat			 2014/09/28      create
import sqlite3,bottle
import sys,pytest,os
import hashlib

def enum(**enums):
    return type('Enum', (), enums)
 
g_db = None

g_test_id = None
def set_session_id(id):
	''' for test only '''
	global g_test_id
	g_test_id = id

def get_session_id():
	if g_test_id:
		return g_test_id
	
	session_id =  bottle.request.get_cookie("session")
	if not session_id:
		#TODO unknown man and female has different id
		return "-1"
	return session_id
	    
def get_dist():
	session_id = get_session_id()
	with open("views/head.tpl","r") as f:
		return {"web_head":f.read().replace("#session#",str(session_id))}

def get_db():
	global g_db
	if g_db == None:
	    g_db = sqlite3.connect("user.db")
	    g_db.text_factory=lambda x: x.decode("utf-8", "ignore")
	return g_db
	
def get_cursor():
	global g_db
	return get_db().cursor()
		
def md5(value):
    return hashlib.md5(value.encode("utf-8")).hexdigest()

def scramble(value):
    return md5(str(value) + "ycat")

def run_tests(file):
	if sys.platform == "win32":
	    os.chdir(os.path.dirname(__file__))
	    print(os.path.dirname(__file__))

	if not os.path.isabs(file):
	    pytest.main("-v -x " + file)				
	else:
	    pytest.main("-v -x " + os.path.basename(file))
	
	

	