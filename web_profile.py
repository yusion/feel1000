#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import sys,os,bottle
from bottle import route, template,install,view,request,get,post,SimpleTemplate

@route('/profile')	
@view('profile')	
def url_show_profile():
	return {"web_head":""}



