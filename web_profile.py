#coding=utf-8 
# ycat			 2014/09/28      create
import pytest
import sqlite3,collections
import sys,os,io,datetime
import utility,json
import bottle,session
from PIL import Image
	
class user_profile:
	def __init__(self,id):
		self.user_id = id
		self.ip = "127.0.0.8"
		self.scores = {"1":"0","2":"0","3":"0","4":"0"} #4个选项
		self.tags = []
		self.desc = ""
		self._has_tag = False #是否已经存在u_tags表 
		self._read_tags()
	
	def _read_tags(self):
		c = utility.get_cursor()
		r = c.execute("SELECT tags,scoreID,score,desc FROM u_tags WHERE userID=%d"%self.user_id).fetchone()
		if not r:
			return
		
		if r[0] and len(r[0]):
			self.tags = r[0].split("@@")

		if r[1]	and r[2]:
			self.scores.clear()
			for k,v in zip(r[1].split(","),r[2].split(",")):
				self.scores[k] = v
		
		if r[3]:
			self.desc = r[3]
		self._has_tag = True 
	
	@property
	def small_photo_url(self):
		return "user_images/" + utility.scramble(self.user_id) + "_small.jpg"
	
	@property
	def normal_photo_url(self):
		return "user_images/" + utility.scramble(self.user_id) + ".jpg"
		
	@property
	def photo_url(self):
		if self.hasphoto:
			return self.normal_photo_url
		else:
			return "res/unknownprofile.jpg"

	def get_dict(self):
		d = {}
		for k in self.__dict__:
			v = self.__dict__[k] 
			if v == None or v == -1:
				d[k] = ""
			else:
				d[k] = v
		return d
		
	def save_tags(self,tags,scores,desc):
		if None == tags and None == desc and not scores :
			return
		
		db = utility.get_db()
		c = db.cursor()
		need = False
		
		cols = []
		vals = []
		
		if tags != None:
			s = set(tags) #清除重复的 
			val = "@@".join([x for x in s])
			utility.write_log(self.user_id,"修改tags`"+val+"`",1,False)
			cols.append("tags")
			vals.append(val)
			self.tags = tags
			
		if scores:
			o = collections.OrderedDict(sorted(scores.items(), key=lambda scores: scores[0]))
			val = ",".join([str(x) for x in o.values()])
			key = ",".join([str(x) for x in o.keys()])
			utility.write_log(self.user_id,"修改了评分信息`"+val+"`",1,False)
			cols.append("score")
			cols.append("scoreID")
			vals.append(val)
			vals.append(key)
			self.scores = scores
			
		if desc != None:
			cols.append("desc")
			vals.append(desc)
			utility.write_log(self.user_id,"修改描述`"+desc+"`",1,False)
			self.desc = desc	
		
		sql = ""
		if not self._has_tag:
			self._has_tag = True
			t = "?,"*len(cols)
			sql = "INSERT INTO u_tags(userID," + ",".join(cols) + ")VALUES(" +str(self.user_id)+"," + t[:-1] + ")"
		else:
			t = ""
			for x in cols:
				t += (x + "=?,")
			sql = "UPDATE u_tags SET " + t[:-1]
			sql += " WHERE userID=%d"%self.user_id
		c.execute(sql, vals)
		db.commit()

	def save_profile(self,valMap):
		log = "修改： "
		sql = "UPDATE u_profile SET EditDate=?"
		now = utility.now_str()
		sqlValue = [now,]
		changed = False
		for k in valMap:
			k2 = k.lower()
			if not hasattr(self,k2):
				continue
			changed = True
			value = valMap[k]
			old = self.__dict__[k2]
			if isinstance(old,int):
				if value == "":
					value = -1
				setattr(self,k2,int(value))
			else:
				setattr(self,k2,str(value))
			log += k+":`" + str(old) + "`->`" + str(value) +"`, "
			sql += ",%s=? " % k
			sqlValue.append(value)
		
		if not changed:
			return False
		
		db = utility.get_db()
		c = db.cursor()
		sql += " WHERE ID=?"
		sqlValue.append(self.user_id)
		c.execute(sql,sqlValue)
		utility.write_log(self.user_id,log,1,False)
		db.commit()
		return True
	
class ctrl_profile:
	@staticmethod
	def _read(user_id):
		user = user_profile(user_id)
		sql = """SELECT * FROM u_user as u LEFT JOIN u_profile as u1 ON u.ID=u1.ID WHERE u.ID=""" + str(user_id)
		c = utility.get_cursor()
		r = c.execute(sql).fetchone()
		if r == None:
			return None
		user.user_id = user_id
		i = 0
		for col in c.description:
			setattr(user,col[0].lower(),r[i])
			i+=1
		return user

	@staticmethod
	def handle_profile_img(fp,user):
		assert isinstance(user,user_profile)
		user.save_profile({"hasphoto":1})
		img = Image.open(fp)
		img = ctrl_profile._rotate_img(img)
		img.thumbnail((1024,768))
		img.save(user.photo_url)
		
		img.thumbnail( (400,300) )
		img.save(user.small_photo_url)
		img.close()
	
	@staticmethod	
	def _get_rotate(image):
		if not hasattr(image,"_getexif"):
			return -1
		
		r = image._getexif()
		if not r:
			return -1
		
		orientation = 0x112
		if orientation not in r:
			return -1
		v = r[orientation]
		if v == 6:
			return Image.ROTATE_270
		elif v == 8:
			return Image.ROTATE_90
		elif v == 3:
			return Image.ROTATE_180
		else:
			return -1
	
	@staticmethod	
	def _rotate_img(image):
		#http://blog.csdn.net/daisyhd/article/details/6000962
		r = ctrl_profile._get_rotate(image)
		if r == -1:	
			return image 
		img = image.transpose(r)
		image.close()
		return img
		

@bottle.route('/my_space')	
@bottle.view('my_space')	
def url_show_space():
	s = session.get()
	d = session.get_dist() 
	d.update(s.profile.get_dict())
	d["scores"] = s.profile.scores
	d["tags"] = s.profile.tags
	d["my"] = True 
	d["age"] = s.age
	d["desc"] = s.profile.desc 
	utility.get_tags_table(d,s.sex)
	utility.get_score_table(d,s.sex)
	d["friend"] = utility.get_template_file("views/friend.tpl",{})
	return d

@bottle.route('/action/update_profile')	
def url_update_desc():
	try:
		u = session.get().profile
		tags_val = bottle.request.params.tags #list
		tags = None
		if tags_val:
			tags = tags_val.split(" ")
		
		scores_id = bottle.request.params.scores_id
		scores_val = bottle.request.params.scores_val
		scores = None
		if scores_id and scores_val:
			scores = {}
			for id,val in zip(scores_id.split(" "),scores_val.split(" ")):
				scores[id] = val
			
		desc = bottle.request.params.desc #string
		u.save_tags(tags,scores,desc) 
		return json.dumps({"result":"true"})
	except:
		utility.write_log(-1,"更新用户信息失败",0)
	return json.dumps({"result":"false"})

@bottle.route('/profile')	
@bottle.view('profile')	
def url_show_profile():
	d = session.get_dist()
	u = session.get().profile
	d["photo_url"] = u.photo_url
	d["normal_photo_url"] = u.normal_photo_url
	d.update(u.get_dict())
	utility.update_c_table(d,"c_income",u.income)
	utility.update_c_table(d,"c_star",u.star)
	utility.update_c_table(d,"c_degree",u.degree)
	utility.update_c_table(d,"c_career",u.career)
	return d
	
@bottle.route('/action/update_profile_detail')	
def url_update_profile():
	try:
		u = session.get().profile
		ids = bottle.request.params.ids.split("@@")
		vals = bottle.request.params.vals.split("@@")
		print(ids,vals)
		dd = {}
		for i,v in zip(ids,vals):
			dd[i] = v
			
		if u.save_profile(dd):
			return json.dumps({"result":"true"})
	except Exception as error:
		utility.write_log(-1,"更新用户详细信息失败" + str(error),0)
	return json.dumps({"result":"false"})

@bottle.route('/ta_request')	
@bottle.view('ta_request')	
def url_show_ta_request():
	d = session.get_dist()
	u = session.get().profile
	d["photo_url"] = u.photo_url
	d["normal_photo_url"] = u.normal_photo_url
	d.update(u.get_dict())
	utility.update_c_table(d,"c_income",u.income)
	utility.update_c_table(d,"c_star",u.star)
	utility.update_c_table(d,"c_degree",u.degree)
	utility.update_c_table(d,"c_career",u.career)
	return d
	
@bottle.route('/user_images/<path:path>')	
def get_file(path):
	return bottle.static_file(path,"./user_images")

@bottle.route('/my_images/<path:path>')
def get_profile_file(path):
	u = user_profile(session.get().user_id)
	return bottle.static_file(u.normal_photo_url,"")

@bottle.post('/action/upload_profile_photo')
def url_upload():
	user = session.get().profile
	upload = bottle.request.files.get('Filedata')
	mem = io.BytesIO()
	upload.save(mem)
	mem.seek(0)
	#ctrl_profile.handle_profile_img(mem,user)
	mem.close()
	return 0

@bottle.post('/action/upload_id_cerf')
def url_upload_id_cerf():
	user = session.get().profile
	upload = bottle.request.files.get('qqfile')
	mem = io.BytesIO()
	upload.save(mem)
	mem.seek(0)
	#ctrl_profile.handle_profile_img(mem,user)
	mem.close()
	bottle.response.content_type = 'text/plain'
	return json.dumps({"success":"true"})

if __name__ == '__main__':
	utility.run_tests("test_user_profile.py")
	
#############################	web unit test	###########################
@bottle.route('/test/get_my_profile')	
def url_get_profile():
	return json.dumps(session.get().profile.__dict__)


		









