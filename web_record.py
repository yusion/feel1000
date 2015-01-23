#coding=utf-8 
# ycat			 2015/01/21      create
import pytest
import sqlite3,collections
import sys,os,io,datetime
import utility,json
import bottle,session

class ctrl_record:
	_record_map = None
	
	@staticmethod
	def _is_right_id(id):
		if not ctrl_record._record_map:
			ctrl_record._record_map = {}
			for rr in utility.get_c_table("c_record"):
				ctrl_record._record_map[rr[0]] = rr[1]
		return id in ctrl_record._record_map
	
	@staticmethod
	def save(user_id,record_map):  #key=record_id,value=record_value 
		db = utility.get_db()
		c = db.cursor()
		data = ctrl_record.read(user_id)
		changed = False
		for id in record_map:
			if not ctrl_record._is_right_id(id):
				continue
			changed = True
			if id in data:
				c.execute("UPDATE u_record SET recordValue=? WHERE userID=? AND recordID=?",
					  (record_map[id],user_id,id))
			else:
				c.execute("INSERT INTO u_record(userID,recordID,recordValue)VALUES(?,?,?)",
					  (user_id,id,record_map[id]))
		if not changed:
			return
		utility.write_log(user_id,"更改喜好信息",1,False)
		db.commit()
		
	@staticmethod
	def read(user_id):
		ret = {}
		c = utility.get_cursor()
		rr = c.execute("SELECT recordID,recordValue FROM u_record WHERE userID="+str(user_id)).fetchall()
		for r in rr:
			if not ctrl_record._is_right_id(r[0]):
				continue
			ret[r[0]] = r[1]
		return ret

@bottle.route('/record')	
@bottle.view('record')	
def url_show_record():
	d = session.get_dist()
	utility.update_c_table(d,"c_record")
	d["record_value"] = ctrl_record.read(session.get().user_id)
	return d

@bottle.route('/action/save_record')	
def url_register():
	try:
		ids =  bottle.request.params.ids.split("@@")
		vals = bottle.request.params.vals.split("@@")
		r = {}
		for i,v in zip(ids,vals):
			r[int(i)] = v
		ctrl_record.save(session.get().user_id,r);	
		return json.dumps({"result":"true"});
	except Exception as error:
		utility.write_log(-1,"更改喜好信息失败"+ str(error),0)
		return json.dumps({"result":"false"});

#############################	web unit test	###########################
@bottle.route('/test/get_record')
def url_test_get_record():
	ctrl_record._is_right_id(0)
	v = ctrl_record.read(session.get().user_id)
	ret = {}
	for r in ctrl_record._record_map:
		if r in v:
			ret[r] = (ctrl_record._record_map[r],v[r])
		else:
			ret[r] = (ctrl_record._record_map[r],"")
	return json.dumps(ret) 

def test_is_right_id():
	assert not ctrl_record._is_right_id(0)
	assert not ctrl_record._is_right_id(20)
	for i in range(1,20):
		assert ctrl_record._is_right_id(i)

def test_read():
	test_id = 100009
	utility.get_db().execute("DELETE FROM u_record WHERE userID=" + str(test_id))
	utility.get_db().commit()
	
	r = ctrl_record.read(23123123)
	assert len(r) == 0
	
	m={}
	for i in range(1,5):
		m[i] = "this is a test ~~~~~~~~~" + str(i)
	ctrl_record.save(test_id,m)
	utility.check_log(test_id,"更改喜好信息",1)
	r = ctrl_record.read(test_id)
	utility.assert_dict(r,m)
	
	m.clear()
	for i in range(1,20):
		m[i] = "this is a test'1\"22ds ~~~~~~~~~" + str(i)
	assert 19 == len(m)
	ctrl_record.save(test_id,m)
	utility.check_log(test_id,"更改喜好信息",1)
	r = ctrl_record.read(test_id)
	utility.assert_dict(r,m)
	
	count = utility.get_cursor().execute("SELECT COUNT(*) FROM u_record").fetchone()[0]
	m2 = {}
	m2[190] = "wrong wrong "
	m2[191] = "wrong wrong "
	ctrl_record.save(test_id,m2)
	ctrl_record.save(test_id,m)	
	r = ctrl_record.read(test_id)
	utility.assert_dict(r,m)
	assert utility.get_cursor().execute("SELECT COUNT(*) FROM u_record").fetchone()[0] == count
	
	for i in range(1,20):
		m[i] = ""
	ctrl_record.save(100009,m)	
	r = ctrl_record.read(test_id)
	utility.assert_dict(r,m)	
		 
	utility.get_db().execute("DELETE FROM u_record WHERE userID=" + str(test_id))
	utility.get_db().commit()
	
		 
if __name__ == '__main__':
	utility.run_tests(__file__)



