#coding=utf-8 
# ycat			 2014/09/28      create
import pytest,threading
import sys,os,bottle,json
import session,utility
import common.timer,time
from web_register import clear_test_user2,ctrl_user_manager,sex_type

@bottle.route('/login')	
@bottle.view('login')	
def url_show_login():
	return utility.get_dist()

#用于冷却登陆次数，防止暴力破解
g_loginFailedCount = {}
g_loginFailedCountLock = None

def auto_del_timer():
	global g_loginFailedCountLock
	g_loginFailedCountLock.acquire()
	g_loginFailedCount.clear()
	g_loginFailedCountLock.release()
	
def web_login(nickname,password):
	global g_loginFailedCountLock
	if not g_loginFailedCountLock:
		g_loginFailedCountLock = threading.RLock()
		utility.get_timer().setInterval(auto_del_timer,30*60*1000)
	
	ip = ""
	if bottle.request and bottle.request.remote_addr:
		ip = bottle.request.remote_addr
	key = nickname	
		
	if key:
		g_loginFailedCountLock.acquire()
		count = 0
		if key in g_loginFailedCount:
			count = g_loginFailedCount[key]
		g_loginFailedCountLock.release() 
		if count >= 20:
			utility.write_log(-1,nickname+"登陆次数过多"+str(count),0,ip)
			return {"result":"false","msg":"登陆次数过多，请稍后再试"}		
	
	user = session.login(nickname,password)
	 
	if user:
		g_loginFailedCountLock.acquire()
		if key in g_loginFailedCount:
			del g_loginFailedCount[key];
		g_loginFailedCountLock.release()
		return {"result":"true","msg":(user.nickname+", 欢迎您回来"),"session":user.session_id}	
	else:
		g_loginFailedCountLock.acquire()
		if key in g_loginFailedCount:
			g_loginFailedCount[key]+=1
		else:
			g_loginFailedCount[key]=1
		g_loginFailedCountLock.release()
		return {"result":"false","msg":"用户名或密码不正确"}

@bottle.route('/action/login')	
def url_login():
	return json.dumps(web_login(bottle.request.params["nick"],bottle.request.params["pass"]))
	

#############################	unit test	###########################
def test_login_too_many():
	clear_test_user2()
	ctrl_user_manager.register("ycat3","17056464001","passwtest",sex_type.Female,35)	
	r = web_login("ycat3","passwtest")
	assert r["result"] == "true"  
	assert r["msg"] == "ycat3, 欢迎您回来"
	utility.set_session_id(r["session"])
	user = session.get()
	utility.check_log(user.user_id,"登陆成功",1)
	
	for i in range(20):
		r = web_login("ycat3","wrongpassword_" +str(i))
		assert r ==  {"result":"false","msg":"用户名或密码不正确"}
		assert 1+i == g_loginFailedCount["ycat3"]
	assert len(g_loginFailedCount) == 1
	
	r = web_login("ycat3","wrongpassword20")
	assert r ==  {"result":"false","msg":"登陆次数过多，请稍后再试"}
	r = web_login("ycat3","passwtest")
	assert r ==  {"result":"false","msg":"登陆次数过多，请稍后再试"}
	r = web_login("ycat3","passwtest")
	assert r ==  {"result":"false","msg":"登陆次数过多，请稍后再试"}

	common.timer.set_pass_ticks(30*60*1000 + 5000)
	time.sleep(3)
	r = web_login("ycat3","passwtest") 
	assert r["result"] == "true"  
	assert r["msg"] == "ycat3, 欢迎您回来"
	utility.set_session_id(r["session"])
	user = session.get()
	utility.check_log(user.user_id,"登陆成功",1)
	assert len(g_loginFailedCount) == 0
	
	clear_test_user2()	
		
if __name__ == '__main__':
	utility.run_tests(__file__)
	