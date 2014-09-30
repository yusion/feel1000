#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import sys,os,bottle
import session
from bottle import route, template,install,view,request,get,post,SimpleTemplate

@route('/profile')	
@view('profile')	
def url_show_profile():
	return session.global_info.get_dist()

@post('/action/upload_profile_photo')
def url_upload():
	upload     = bottle.request.files.get('Filedata')
	upload.save("user_images",overwrite=True) # appends upload.filename automatically
	#如果太大，则缩小，太小则不变
	#同时生成thumbnail 
	return 0
