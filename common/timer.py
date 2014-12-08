#coding=utf-8 
# ycat			 2014/12/08      create
import os,time,pytest,sys
import threading
import time
 		
class timer:
	def _ticks():
		return int(time.clock()*1000)
	
	class timer_info:
		def __init__(self,func,ms,args,repeat):
			self.func = func
			self.timeout = timer._ticks() + ms
			self.ms = ms
			self.args = args
			self.repeat = repeat
		
	def __init__(self,sleepMs=3000):
		self._lock = threading.RLock()
		self._time_map = {}
		self._thread = threading.Thread(target=self._loop,name="timer_thread")
		self._exited = False
		self._id = 0
		self.sleepSec = sleepMs/1000
		if self.sleepSec == 0:
			self.sleepSec = 1
	
	def __del__(self):
		self.stop()
	
	def setTimeout(self,func,timeoutMs,args=()):
		#只调用一次func，返回timerID 
		return self._add_timer(func,timeoutMs,args,False)
	
	def setInterval(self,func,timeoutMs,args=()):
		#会循环调用func，返回timerID 
		return self._add_timer(func,timeoutMs,args,True)
	
	def remove(self,timeID):
		self._lock.acquire()
		self._remove_timer(timeID)
		self._lock.release()
	
	def start(self):
		assert not self._exited
		self._thread.start()
	
	def stop(self):
		self._exited = True
		self._thread.join()
	
	def _loop(self):
		callbackList = []
		removeList = []
		while not self._exited:
			removeList = []
			callbackList = []
			now = timer._ticks()
			self._lock.acquire()
			for key in self._time_map:
				value = self._time_map[key]
				if now >= value.timeout:
					callbackList.append(value)
					if value.repeat:
						value.timeout = now + value.ms
					else:
						removeList.append(key)
			
			for k in removeList:
				self._remove_timer(k)
				
			self._lock.release()
			
			for v in callbackList: 
				v.func(*v.args)
				
			time.sleep(self.sleepSec) 

	
	def _add_timer(self,func,ms,args,repeat):
		self._lock.acquire()
		
		while True:
			self._id+=1
			if self._id not in self._time_map:
				break
		id = self._id
			
		self._time_map[id] = timer.timer_info(func,ms,args,repeat)
		
		self._lock.release()
		return id
	
	def _remove_timer(self,key):
		if key in self._time_map:
			del self._time_map[key]
		
########## for unit test ############
y = x = 1000
def my_func1(step):
	global x
	x = x+step

def my_func2(step):
	global y
	y = y+step	
	
def test_setInterval():
	t = timer(200)
	t.start()
	global x,y
	y = x = 1000
	id = t.setInterval(my_func1 ,2001,(1,))
	id2 = t.setInterval(my_func2 ,2002,(2,))
	assert 2 == len(t._time_map)
	time.sleep(1.2)
	assert x == 1000
	assert y == 1000
	time.sleep(1.2)
	assert x == 1001
	assert y == 1002 #timeout

	time.sleep(2.2)
	assert x == 1002
	assert y == 1004
	assert 2 == len(t._time_map)
	t.remove(id2)
	assert 1 == len(t._time_map)
	
	time.sleep(2.2)
	assert x == 1003
	assert y == 1004
	assert 1 == len(t._time_map)
	t.stop()
	
def test_setTimeout():
	t = timer(200)
	t.start()
	global x,y
	y = x = 1000
	id = t.setTimeout(my_func1 ,1000,(1,))
	assert 1 == len(t._time_map)
	assert id == 1
	id2 = t.setTimeout(my_func2 ,1000,(2,))
	assert 2 == len(t._time_map)
	assert id2 == 2
	
	id3 = t.setTimeout(my_func2 ,4000,(2,))
	assert 3 == len(t._time_map)
	assert id3 == 3
	
	time.sleep(1.2)
	assert 1 == len(t._time_map)
	assert x == 1001
	assert y == 1002
	
	time.sleep(1.2)
	assert 1 == len(t._time_map)
	t.remove(id3)
	assert 0 == len(t._time_map)
	t.remove(1545)
	assert x == 1001
	assert y == 1002
	t.stop()
	


if __name__ == '__main__':
	if sys.platform == "win32":
		os.chdir(os.path.dirname(__file__))
	pytest.main("-v -x timer.py")				
			