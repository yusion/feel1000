#coding=utf-8 
# ycat			 2014/10/27      create
import pytest
import sqlite3
import sys,os,io,datetime
import utility,json
import bottle,session
import time
from PIL import Image

class search_item:
	def __init__(self):
		self.user_id = -1
		self.photo_url = ""
		self.photo_width = 0
		self.photo_height = 0

class ctrl_search:
	@staticmethod
	def _handle_page(page_size,current_page,result):
		#current_page即页数-1，由0开始计数  
		total_count = len(result) // page_size
		if len(result) % page_size != 0:
			total_count += 1
		t = page_size*current_page
		return (result[t : t + page_size],total_count)
		
	@staticmethod
	def search(condition,page_size,current_page):
		result = []
		while len(result) < 33:
			for root, dirs, files in os.walk("./res/test"):
				#TODO for test only 
				for name in files:
					if name == "Thumbs.db":
						continue
					item = search_item()
					item.photo_url = "res/test/"+name
					img = Image.open(item.photo_url)
					if not img:
						continue
					item.photo_width = img.size[0]
					item.photo_height = img.size[1]
					img.close()
					result.append(item)

		rr = ctrl_search._handle_page(page_size,current_page,result)
		return {"result":rr[0],
			"page_size":page_size,
			"current_page":current_page,
			"total_page":rr[1]}

def get_search_result(condition,page,page_size):
	return utility.get_template_file("views/search_result.tpl",ctrl_search.search(condition,page_size,page))

@bottle.route('/search')	
@bottle.view('search')	
def url_search():
	return utility.get_dist()

@bottle.route('/action/search')
def url_search():
	page = int(bottle.request.params.page)
	page_size = int(bottle.request.params.page_size)
	return get_search_result(None,page,page_size)

def test_handle_page():
	r = range(0,1000)
	assert 1000 == len(r)
	for i in r:
		rr = ctrl_search._handle_page(1,i,r)
		assert len(rr[0]) == 1
		assert rr[0][0] == i
		assert rr[1] == 1000
		
	rr = ctrl_search._handle_page(2000,0,r)
	assert len(rr[0]) == 1000
	assert rr[1] == 1
	for r1,r2 in zip(r,rr[0]):
		assert r1 == r2
	
	rr = ctrl_search._handle_page(100,11,r)
	assert len(rr[0]) == 0
	assert rr[1] == 10
	
	rr = ctrl_search._handle_page(100,4,r)
	assert len(rr[0]) == 100
	assert rr[1] == 10
	for r1,r2 in zip(range(400,500),rr[0]):
		assert r1 == r2
	
	for k in range(0,3):
		rr = ctrl_search._handle_page(300,k,r)
		assert len(rr[0]) == 300
		assert rr[1] == 4
		print(k)
		for r1,r2 in zip(range(300*k,300*(k+1)),rr[0]):
			assert r1 == r2
	
	rr = ctrl_search._handle_page(300,3,r)
	assert len(rr[0]) == 100
	assert rr[1] == 4
	for r1,r2 in zip(range(900,1000),rr[0]):
		assert r1 == r2


if __name__ == '__main__':
	utility.run_tests(__file__)
	