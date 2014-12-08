#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import sys,os,bottle,json
import session,utility
from web_register import url_show_register
from bottle import route, template,install,view,request,get,post,SimpleTemplate

@route('/login')	
@view('login')	
def url_show_login():
	return utility.get_dist()

#用于冷却登陆次数，防止暴力破解
g_loginFailedCount = {}
g_loginBackoff = {}

@route('/action/login')	
def url_login():
	u = bottle.request.params["nick"]
	user = session.login(u,bottle.request.params["pass"])
	if u in g_loginFailedCount:
		g_loginFailedCount[u]+=1
		if g_loginFailedCount[u] > 20:
			return json.dumps({"result":"false","msg":"登陆次数过多，请稍后再试"})	
		
	if user:
		g_loginFailedCount.pop(u);
		g_loginBackoff.pop(u);
		return json.dumps({"result":"true","msg":(user.nickname+", 欢迎您回来")})	
	else:
		return json.dumps({"result":"false","msg":"用户名或密码不正确"})	
		