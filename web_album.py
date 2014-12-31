#coding=utf-8 
# ycat			 2014/11/13      create
import pytest
import random
import sys,os,bottle
import session,utility
from bottle import route, template,install,view,request,get,post,SimpleTemplate

@route('/album')	
@view('album')	
def url_show_album():
	return session.get_dist()

@route('/certif')	
@view('certif')	
def url_show_certif():
	return session.get_dist()

@route('/all_space')
@view('all_space')
def url_show_all_space():
	d = session.get_dist()
	d["show_all"] = "true"
	d["album"] = utility.get_template_file("views/album2.tpl",d)
	return d