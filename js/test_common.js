QUnit.module("common");
QUnit.config.reorder = false;

//对时间的整理 1小时前，昨天，1天前，5天前，一个月前，一年前
QUnit.test("strToTime",function(assert){
	expect(3);
	var p = new data_format(null);
        assert.equal(p.strToTime("2014-11-13 01:23:42").getTime(),new Date(2014,11-1,13,1,23,42,0).getTime());
	assert.equal(p.strToTime("2014-1-3 1:21:42").getTime(),new Date(2014,0,3,1,21,42,0).getTime());
	assert.equal(p.strToTime("2014-12-31 23:59:59").getTime(),new Date(2014,11,31,23,59,59).getTime());
});

QUnit.test("strToTime",function(assert){
	expect(4);
	var p = new data_format(null);
        assert.equal(p.dateDiff(p.strToTime("2014-11-13 01:23:42"),new Date(2014,11-1,13,1,23,42,0)),0);
	assert.equal(p.dateDiff("2014-11-13 01:23:42",new Date(2014,11-1,12,1,23,42,0)),3600*24);
	assert.equal(p.dateDiff("2014-11-13 01:23:42","2014-11-13 02:23:42"),-3600);	
	assert.equal(p.dateDiff(p.strToTime("2015-11-13 01:23:42"),new Date(2014,11-1,13,1,23,42,0)),3600*24*365);
});

QUnit.test("secToStr",function(assert){
	expect(13);
	var p = new data_format(null);
        assert.equal(p.secToStr(0),"刚刚");
	assert.equal(p.secToStr(59),"刚刚");
	assert.equal(p.secToStr(60),"1分钟");
	assert.equal(p.secToStr(60*50-1),"50分钟");
	assert.equal(p.secToStr(180),"3分钟");
	assert.equal(p.secToStr(3600),"60分钟");
	assert.equal(p.secToStr(24*3600+3645),"1天");
	assert.equal(p.secToStr(24*3600*30),"30天");
	
	assert.equal(p.secToStr(24*3600*31),"1月");
	var m = 24*3600*30;
	assert.equal(p.secToStr(m*5+6546),"5月");
	assert.equal(p.secToStr(m*12+6546),"12月");
	assert.equal(p.secToStr(m*12*2+6546),"2年");
	assert.equal(p.secToStr(m*12*10+6546),"10年");
});










