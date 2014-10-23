#coding=utf-8 
# ycat			 2014/09/28      create
import sqlite3,bottle
import sys,pytest,os
import hashlib

def enum(**enums):
    return type('Enum', (), enums)
 
g_db = None
_is_test = False;
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

def is_test():
    global _is_test
    return _is_test

def set_is_test(value):
    global _is_test
    _is_test = value

def _get_file(filename,keyword):
     with open(filename,"r") as f:
        tpl = bottle.SimpleTemplate(f.read())
        return tpl.render(keyword)

def get_dist():
	session_id = get_session_id()
	d = {}
	d["is_test"] = _is_test
	d["session"] = str(session_id)
	d["web_head"] = _get_file("views/head.tpl",d)
	d["page_head"] = _get_file("views/pagehead.tpl",d)
	d["page_foot"] = _get_file("views/pagefoot.tpl",d)
	return d

def get_db():
	global g_db
	if g_db == None:
	    g_db = sqlite3.connect("user.db")
	    #g_db.text_factory=lambda x: x.decode("utf-8", "ignore")
	return g_db
	
def get_cursor():
	global g_db
	return get_db().cursor()
		
def md5(value):
    return hashlib.md5(value.encode("utf-8")).hexdigest()

def scramble(value):
    return md5(str(value) + "ycat")

def get_c_table(name):
    ret = []
    rr = get_cursor().execute("SELECT * FROM " + name)
    for r in rr.fetchall():
        ret.append(r)			
    return ret

def update_c_table(dict1,name,value=None):
    dict1[name] = get_c_table(name)
    if value:
        dict1[name + "_value"] = value
    return dict1

#############################	unit test	###########################
def test_get_dict():
    global _is_test
    set_session_id(3300)
    assert _get_file("views/pagehead.tpl",{"session":1000}).find('value="1000"') != -1
    set_is_test(True)
    assert _is_test
    assert is_test()
    print(get_dist()["page_foot"])
    assert get_dist()["page_foot"].find('qunit-fixture') != -1
    assert get_dist()["page_head"].find('value="3300"') != -1
    set_is_test(False)
    assert not _is_test
    assert not is_test()
    assert get_dist()["page_foot"].find('qunit-fixture') == -1
    assert get_dist()["page_head"].find('value="3300"') != -1
    
def test_md5():
    assert md5("abcd") == "e2fc714c4727ee9395f324cd2e7f331f"
    assert md5("123456") == "e10adc3949ba59abbe56e057f20f883e"

def test_update_c_table():
    d = {}
    update_c_table(d,"c_degree",2)
    assert 2 == len(d)
    r = d["c_degree"]
    assert 2 == d["c_degree_value"]
    assert len(r) == 5   
    d.clear()
    update_c_table(d,"c_degree")
    assert 1 == len(d)
    assert "c_degree" in d

def test_get_c_table():
    r = get_c_table("c_degree")
    assert len(r) == 5
    assert r[0][0] == -1
    assert r[0][1] == " "
    assert r[2][0] == 2
    assert r[2][1] == "本科"
    
    r = get_c_table("c_income")
    assert len(r) == 8
    assert r[0][0] == -1
    assert r[0][1] == " "
    assert r[7][0] == 50
    assert r[7][1] == "50k以上"
    
    r = get_c_table("c_star")
    assert len(r) == 13
    assert r[0][0] == -1
    assert r[0][1] == " "
    assert r[10][0] == 10
    assert r[10][1] == "摩羯座 12.22─01.19"


def run_tests(file):
	if sys.platform == "win32":
	    os.chdir(os.path.dirname(__file__))
	    print(os.path.dirname(__file__))

	if not os.path.isabs(file):
	    pytest.main("-v -x " + file)				
	else:
	    pytest.main("-v -x " + os.path.basename(file))
	
def run_all_tests():
    if not is_test():
       return
    
    for root, dirs, files in os.walk(os.getcwd()):
        for name in files:
            if name[-3:] == ".py":				
                pytest.main(r"-v -x " + name)

if __name__ == '__main__':
	run_tests(__file__)
	
	