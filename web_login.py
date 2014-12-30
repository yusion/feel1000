#coding=utf-8 
# ycat			 2014/09/28      create
import pytest,threading
import sys,os,bottle,json
import session,utility
import common.timer,time,datetime
from web_register import clear_test_user2,ctrl_user_manager,sex_type

@bottle.route('/login')	
@bottle.view('login')	
def url_show_login():
	return session.get_dist()

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
	
	key = nickname			
	if key:
		g_loginFailedCountLock.acquire()
		count = 0
		if key in g_loginFailedCount:
			count = g_loginFailedCount[key]
		g_loginFailedCountLock.release() 
		if count >= 20:
			utility.write_log(-1,nickname+"登陆次数过多"+str(count),0)
			return {"result":"false","msg":"登陆次数过多，请30分钟后重试"}		
	
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

#TODO: 注册URL和登陆的URL可能被复制。。。需要根据时间进行，，加解密，或者增加另一个字符串，，，
@bottle.route('/action/login')	
def url_login():
	return json.dumps(web_login(bottle.request.params["nick"],bottle.request.params["pass"]))
	
@bottle.route('/logout')	
def url_logout():
	session.logout()
	bottle.response.delete_cookie("uname")
	bottle.response.delete_cookie("pwd")
	bottle.response.delete_cookie("session") 
	bottle.redirect("/index")

@bottle.route('/')
@bottle.route('/index')	 
def url_index():
	nick = bottle.request.get_cookie("uname",secret="abc123")
	pwd = bottle.request.get_cookie("pwd",secret="abc123")
	if nick and pwd:
		#保存了cookies
		user = session.login(nick,pwd)
		if user:
			bottle.response.set_cookie('session',user.session_id)
			bottle.redirect("/index2")
			return
	
	d = session.get_dist2()
	d["register"] = utility.get_template_file("views/register.tpl",d)
	d["login"] = utility.get_template_file("views/login.tpl",d)
	return bottle.template('index', d)

@bottle.route('/index2',method='GET')
@bottle.route('/index2',method='POST')
def url_index2():
	s = None
	save = False
	if bottle.request.query.sex:
		#直接访问 
		i = int(bottle.request.query.sex)
		if i != 1 and i != 0:
			i = 0
		s = session.visit(i)
		
	elif bottle.request.forms.session:
		#注册用户访问 
		s = session.get(bottle.request.forms.session) 
		if bottle.request.forms.save:
			save = True
	else:
		#从保存cookies的index页面中直接redirect过来的情况   
		session_id = utility.get_session_id()
		if session_id != "-1":
			s = session.get(session_id) 

	if not s:
		bottle.redirect("/")

	timeout = utility.now() + datetime.timedelta(days = 365)		
	if save:
		bottle.response.set_cookie("uname",s.nickname,secret="abc123",expires=timeout)
		bottle.response.set_cookie("pwd",s.pwd,secret="abc123",expires=timeout) 
	
	bottle.response.set_cookie("loginstate","yes",expires=timeout) #标识用户已经登陆过  
	bottle.response.set_cookie('session',s.session_id)
	d = session.get_dist(s)
	return bottle.template('index2', d)

#############################	unit test	###########################
def test_set():
    utility.set_is_test(True)

def test_login_too_many():
	clear_test_user2()
	user = ctrl_user_manager.register("ycat3","passwtest",sex_type.Female,35)
	utility.check_log(user.user_id,"注册成功",1,0)
	r = web_login("ycat3","passwtest")
	assert r["result"] == "true"  
	assert r["msg"] == "ycat3, 欢迎您回来"
	utility.set_session_id(r["session"])
	user = session.get()
	utility.check_log(user.user_id,"登陆成功",1,1)
	
	for i in range(20):
		r = web_login("ycat3","wrongpassword_" +str(i))
		assert r ==  {"result":"false","msg":"用户名或密码不正确"}
		assert 1+i == g_loginFailedCount["ycat3"]
	assert len(g_loginFailedCount) == 1
	
	r = web_login("ycat3","wrongpassword20")
	assert r ==  {"result":"false","msg":"登陆次数过多，请30分钟后重试"}
	r = web_login("ycat3","passwtest")
	assert r ==  {"result":"false","msg":"登陆次数过多，请30分钟后重试"}
	r = web_login("ycat3","passwtest")
	assert r ==  {"result":"false","msg":"登陆次数过多，请30分钟后重试"}

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
	utility.get_timer().stop()
		
if __name__ == '__main__':
	utility.run_tests(__file__)
	