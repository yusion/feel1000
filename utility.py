#coding=utf-8 
# ycat			 2014/09/28      create
import sqlite3,bottle
import sys,pytest,os
import hashlib,datetime 
from common import timer

g_timer = None
def get_timer():
    global g_timer
    if not g_timer:
        g_timer = timer.timer(3000)
#TODO：这里打开影响调试     g_timer.start()
    return g_timer
    

def enum(**enums):
	return type('Enum', (), enums)

g_db = None
_is_test = False;
g_test_id = None
__c_table = {}
g_version = "0.0.1"

def get_version():
    global g_version
    return g_version

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

#TODO：错误页面还未自定义  
def check(value,errorCode,msg=None):
    if not value:
        if errorCode == 401 and not msg:
            msg = "用户未登陆" 
        bottle.abort(errorCode,msg) 

def set_is_test(value):
	global _is_test
	global __test_now
	_is_test = value
	if not value:
		__test_now = None

def get_template_file(filename,keyword):
	with open(filename,"r",encoding='utf-8') as f:
	    tpl = bottle.SimpleTemplate(f.read(),encoding='utf8')
	    return tpl.render(keyword)

def get_ip():
	if is_test():
	    return "unittest"
	if bottle.request and bottle.request.remote_addr:
		return bottle.request.remote_addr
	return "unknown"

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

def get_tags_table(dict1,sex):
	global __c_table
	name = "c_tags"+str(sex) 
	if name in __c_table:
		rr = __c_table[name]
	else:
		rr = get_cursor().execute("SELECT TagID,TagName FROM c_tags WHERE Sex=-1 OR  Sex=?",(sex,)).fetchall()
		__c_table[name] = rr
	dict1["c_tags"] = rr
	return rr
	
def get_score_table(dict1,sex):
	global __c_table
	name = "c_score"+str(sex) 
	if name in __c_table:
		rr = __c_table[name]
	else:
		rr = get_cursor().execute("SELECT ScoreID,ScoreTypeName,ScoreName FROM c_score WHERE ScoreSex=?",(sex,)).fetchall()
		__c_table[name] = rr

	dict1["c_score"] = rr
	return rr		  

def get_c_table(name,emptyName=None):
	global __c_table
	key = name + str(emptyName)
	if key in __c_table:
		return __c_table[key]

	ret = []
	rr = get_cursor().execute("SELECT * FROM " + name)
	for r in rr.fetchall():
		if r[0] == -1 and emptyName != None:
			ret.append((-1,emptyName))
		else:
			ret.append(r)
	__c_table[key] = ret
	return ret

def update_c_table(dict1,name,value=None,emptyName=None):
	dict1[name] = get_c_table(name,emptyName)
	if value:
		dict1[name + "_value"] = value
	return dict1

__test_now = None

def now():
	global __test_now
	if __test_now:
		return __test_now
	return datetime.datetime.now()

def now_str():
	return now().strftime("%Y-%m-%d %H:%M:%S")

def set_now(dateTime):
	global __test_now
	__test_now = dateTime

#logType:1用户日志，0是系统日志 
def write_log(user_id,desc,logType,autoCommit = True):
	db = get_db()
	db.execute("INSERT INTO r_log(LogTypeID,LogDesc,LogDate,UserID,IP)VALUES(?,?,?,?,?)",
		(logType,desc,now_str(),user_id,get_ip()))
	if autoCommit:
		db.commit()

def check_log(user_id,desc,logType,index=0):
	#for unit test to check user log
	c = get_cursor()
	r = c.execute("select UserID,LogDesc,logTypeID from r_log WHERE logTypeID=? ORDER BY LogID Desc",(logType,)).fetchall()
	r = r[index]
	assert r[1] == desc
	assert r[0] == user_id
	assert r[2] == logType

def assert_dict(d1,d2):
	assert d1
	assert d2
	assert len(d1) == len(d2)
	for k in d1:
	    assert k in d2
	    assert d1[k] == d2[k]
	    
def assert_array_noorder(a1,a2):
    #不管顺序的数组比较
    assert a1
    assert a2
    assert len(a1) == len(a2)
    s1 = a1[:]
    s2 = a2[:]
    s1.sort()
    s2.sort()
    assert s1 == s2
        
def get_param(key):
    return bottle.request.params.getunicode(key,encoding="utf-8")


#############################	unit test	###########################
def test_set():
    set_is_test(True)

def test_get_tag_table():
	d = {}
	if "c_tags0" in __c_table:
		del __c_table["c_tags0"]
	if "c_tags1" in __c_table:
		del __c_table["c_tags1"]
	rr = get_tags_table(d,0);
	print(rr);
	assert "c_tags0" in __c_table 
	assert len(rr) > 8

	r = rr[0]
	assert 2 == len(r)
	assert r[0] == 1
	assert r[1] == "高富帅"
	r = rr[1]
	assert 2 == len(r)
	assert r[0] == 3
	assert r[1] == "高学历"
	assert rr == d["c_tags"]
	
	rr = get_tags_table(d,1);
	assert "c_tags1" in __c_table 
	assert len(rr) > 8
	r = rr[0]
	assert 2 == len(r)
	assert r[0] == 2
	assert r[1] == "女神"
	r = rr[1]
	assert 2 == len(r)
	assert r[0] == 3
	assert r[1] == "高学历"
	assert rr == d["c_tags"]
	
def test_get_score_table():
	d = {}
	if "c_score0" in __c_table:
		del __c_table["c_score0"]
	if "c_score1" in __c_table:
		del __c_table["c_score1"]
	rr = get_score_table(d,0);
	assert rr == d["c_score"]
	assert len(rr) == 4
	r = rr[0]
	assert r[0] == 1
	assert r[1] == "长相"
	assert r[2] == "玉树临风,英俊潇洒,顺眼,路人丙,非常一般"
	assert "c_score0" in __c_table
	
	rr = get_score_table(d,1);
	assert rr == d["c_score"]
	assert len(rr) == 4
	r = rr[0]
	assert r[0] == 1
	assert r[1] == "长相"
	assert r[2] == "倾城佳人,天生丽质,容貌姣好,路人甲,非常一般"
	assert "c_score0" in __c_table

def test_write_log():
	set_now(datetime.datetime(2014,5,27,12,50,43))
	now1 = now()
	
	db = get_db()
	db.execute("DELETE FROM r_log WHERE LogDesc like 'test_%'")
	db.commit()
	msg = "test_系统创建啦<啦啦>'\"dfdfd"
	msg2 = "test_系统创建啦<啦啦>'\"dfdfddsfdfsfdsf"
	write_log(-1,msg,0)
	check_log(-1,msg,0)
	
	set_now(datetime.datetime(2014,1,27,12,50,43))
	now2 = now()
	write_log(1001,msg2,1)
	check_log(1001,msg2,1)
	
	c = get_cursor()
	r = c.execute("SELECT LogTypeID,LogDesc,LogDate,UserID,IP FROM r_log WHERE LogDesc like 'test_%'").fetchall()
	assert len(r) == 2
	assert r[0][0] == 0
	assert r[0][1] == msg
	assert r[0][2] == now1.strftime("%Y-%m-%d %H:%M:%S")
	assert r[0][3] == -1
	assert r[0][4] == "unittest"
	assert r[1][0] == 1
	assert r[1][1] == msg2
	assert r[1][2] == now2.strftime("%Y-%m-%d %H:%M:%S")
	assert r[1][3] == 1001
	assert r[1][4] == "unittest"
	
	db.execute("DELETE FROM r_log WHERE LogDesc like 'test_%'")
	db.commit()
	
	set_now(None)

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
	
	r = get_c_table("c_degree","未填写")
	assert len(r) == 5
	assert r[0][0] == -1
	assert r[0][1] == "未填写"
	
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

def test_get_dict():
	global _is_test
	set_session_id(3300)
	assert get_template_file("views/pagehead.tpl",{"session":1000}).find('value="1000"') != -1
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

def run_tests(file):
	set_is_test(True)
	if sys.platform == "win32":
		os.chdir(os.path.dirname(__file__))
		print(os.path.dirname(__file__))

	if not os.path.isabs(file):
		pytest.main("-vv -x " + file)				
	else:
		pytest.main("-vv -x " + os.path.basename(file))
	
def run_all_tests():
	set_is_test(True)
	if not is_test():
	   return
	
	for root, dirs, files in os.walk(os.getcwd()):
		for name in files:
			if name[-3:] == ".py":				
				pytest.main(r"-v -x " + name)

if __name__ == '__main__':
	run_tests(__file__)
	
	