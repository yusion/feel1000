#coding=utf-8 
# ycat			 2014/09/28      create
import sqlite3
import sys,pytest,os

def enum(**enums):
    return type('Enum', (), enums)
 
g_db = None
def get_dist():
	with open("views/head.tpl","r") as f:
		return {"web_head":f.read()}

def get_db():
	global g_db
	if g_db == None:
		g_db = sqlite3.connect("user.db")
		g_db.text_factory=lambda x: x.decode("utf-8", "ignore")
	return g_db
	
def get_cursor():
	global g_db
	return get_db().cursor()
		
def run_tests(file):
	if sys.platform == "win32":
		os.chdir(os.path.dirname(__file__))
		print(os.path.dirname(__file__))

	if not os.path.isabs(file):
		pytest.main("-v -x " + file)				
	else:
		pytest.main("-v -x " + os.path.basename(file))
	
	

	