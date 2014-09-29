#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import sys,os,bottle
import session
from web_register import url_show_register
from bottle import route, template,install,view,request,get,post,SimpleTemplate

@route('/login')	
@view('login')	
def url_show_login():
	return session.global_info.get_dist()

