import pytest,os,sys
import web_register,session
import test_user_manager
from web_profile import *

def test_get_user():
	test_user_manager.clear_test_user()
	assert not ctrl_user_profile.get(9999999)
	s = web_register.ctrl_user_manager.register("ycattest","13912546654","123test",web_register.sex_type.Male)
	assert s
	
	u = ctrl_user_profile.get(s.user_id)
	assert u
	assert u.nickname == "ycattest"
	assert u.id == s.user_id
	assert u.sex == web_register.sex_type.Male
	assert u.photo_url == "res/man_unknown.gif"
	test_user_manager.clear_test_user()
	
def test_set_photo_url():
	s = web_register.ctrl_user_manager.register("ycattest","13912546654","123test",web_register.sex_type.Male)
	u = ctrl_user_profile.get(s.user_id)
	assert u.photo_url == "res/man_unknown.gif"
	u.set_photo_url("user_images/101212gbpe3csbh8aya8y3.jpg")
	
	assert ctrl_user_profile.get(s.user_id).photo_url == u.photo_url
	test_user_manager.clear_test_user()

if __name__ == '__main__':
	utility.run_tests(__file__)
	
