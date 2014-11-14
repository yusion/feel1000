#coding=utf-8 
# ycat			 2014/11/13      create
import pytest
import random
import sys,os,bottle
import session,utility
from web_register import url_show_register
from bottle import route, template,install,view,request,get,post,SimpleTemplate

@route('/album')	
@view('album')	
def url_show_album():
	return utility.get_dist()

@route('/certif')	
@view('certif')	
def url_show_certif():
	return utility.get_dist()
