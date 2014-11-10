#coding=utf-8 
# ycat			 2014/11/10      create
import sys,os,sqlite3

def get_all_city(fileName):
	db = sqlite3.connect("user.db")
	rr = db.cursor().execute("select cityName from c_city").fetchall()
	with open(fileName,"w") as f:
		for r in rr:
			f.write(r[0])
	db.close()

def is_az(d,ss):
	for s in d:
		if not( s >= 'a' and s <= 'z'):
			print(ss)
			assert 0

mm = {}	
pinyin = "北bei 京jing 天tian 津jin 上shang 海hai 重zhong 庆qing 石shi 家jia 庄zhuang 唐tang 山shan 秦qin 皇huang 岛dao 邯han 郸dan 邢xing 台tai 保bao 定ding 张zhang 家jia 口kou 承cheng 德de 沧cang 州zhou 廊lang 坊fang 衡heng 水shui 太tai 原yuan 大da 同tong 阳yang 泉quan 长chang 治zhi 晋jin 城cheng 朔shuo 州zhou 晋jin 中zhong 运yun 城cheng 忻xin 州zhou 临lin 汾fen 吕lv 梁liang 台tai 北bei 高gao 雄xiong 基ji 隆long 台tai 中zhong 台tai 南nan 新xin 竹zhu 嘉jia 义yi 台tai 北bei 宜yi 兰lan 桃tao 园yuan 新xin 竹zhu 苗miao 栗li 台tai 中zhong 彰zhang 化hua 南nan 投tou 云yun 林lin 嘉jia 义yi 台tai 南nan 高gao 雄xiong 屏ping 东dong 澎peng 湖hu 台tai 东dong 花hua 莲lian 沈shen 阳yang 大da 连lian 鞍an 山shan 抚fu 顺shun 本ben 溪xi 丹dan 东dong 锦jin 州zhou 营ying 口kou 阜fu 新xin 辽liao 阳yang 盘pan 锦jin 铁tie 岭ling 朝chao 阳yang 葫hu 芦lu 岛dao 长chang 春chun 吉ji 林lin 四si 平ping 辽liao 源yuan 通tong 化hua 白bai 山shan 松song 原yuan 白bai 城cheng 延yan 边bian 哈ha 尔er 滨bin 齐qi 齐qi 哈ha 尔er 鹤he 岗gang 双shuang 鸭ya 山shan 鸡ji 西xi 大da 庆qing 伊yi 春chun 牡mu 丹dan 江jiang 佳jia 木mu 斯si 七qi 台tai 河he 黑hei 河he 绥sui 化hua 大da 兴xing 安an 岭ling 南nan 京jing 无wu 锡xi 徐xu 州zhou 常chang 州zhou 苏su 州zhou 南nan 通tong 连lian 云yun 港gang 淮huai 安an 盐yan 城cheng 扬yang 州zhou 镇zhen 江jiang 泰tai 州zhou 宿su 迁qian 杭hang 州zhou 宁ning 波bo 温wen 州zhou 嘉jia 兴xing 湖hu 州zhou 绍shao 兴xing 金jin 华hua 衢qu 州zhou 舟zhou 山shan 台tai 州zhou 丽li 水shui 合he 肥fei 芜wu 湖hu 蚌bang 埠bu 淮huai 南nan 马ma 鞍an 山shan 淮huai 北bei 铜tong 陵ling 安an 庆qing 黄huang 山shan 滁chu 州zhou 阜fu 阳yang 宿su 州zhou 巢chao 湖hu 六liu 安an 亳bo 州zhou 池chi 州zhou 宣xuan 城cheng 福fu 州zhou 厦xia 门men 莆pu 田tian 三san 明ming 泉quan 州zhou 漳zhang 州zhou 南nan 平ping 龙long 岩yan 宁ning 德de 南nan 昌chang 景jing 德de 镇zhen 萍ping 乡xiang 九jiu 江jiang 新xin 余yu 鹰ying 潭tan 赣gan 州zhou 吉ji 安an 宜yi 春chun 抚fu 州zhou 上shang 饶rao 济ji 南nan 青qing 岛dao 淄zi 博bo 枣zao 庄zhuang 东dong 营ying 烟yan 台tai 潍wei 坊fang 济ji 宁ning 泰tai 安an 威wei 海hai 日ri 照zhao 莱lai 芜wu 临lin 沂yi 德de 州zhou 聊liao 城cheng 滨bin 州zhou 菏he 泽ze 郑zheng 州zhou 开kai 封feng 洛luo 阳yang 平ping 顶ding 山shan 安an 阳yang 鹤he 壁bi 新xin 乡xiang 焦jiao 作zuo 濮pu 阳yang 许xu 昌chang 漯luo 河he 三san 门men 峡xia 南nan 阳yang 商shang 丘qiu 信xin 阳yang 周zhou 口kou 驻zhu 马ma 店dian 济ji 源yuan 武wu 汉han 黄huang 石shi 十shi 堰yan 荆jing 州zhou 宜yi 昌chang 襄xiang 樊fan 鄂e 州zhou 荆jing 门men 孝xiao 感gan 黄huang 冈gang 咸xian 宁ning 随sui 州zhou 仙xian 桃tao 天tian 门men 潜qian 江jiang 神shen 农nong 架jia 恩en 施shi 长chang 沙sha 株zhu 洲zhou 湘xiang 潭tan 衡heng 阳yang 邵shao 阳yang 岳yue 阳yang 常chang 德de 张zhang 家jia 界jie 益yi 阳yang 郴chen 州zhou 永yong 州zhou 怀huai 化hua 娄lou 底di 湘xiang 西xi 广guang 州zhou 深shen 圳zhen 珠zhu 海hai 汕shan 头tou 韶shao 关guan 佛fo 山shan 江jiang 门men 湛zhan 江jiang 茂mao 名ming 肇zhao 庆qing 惠hui 州zhou 梅mei 州zhou 汕shan 尾wei 河he 源yuan 阳yang 江jiang 清qing 远yuan 东dong 莞guan 中zhong 山shan 潮chao 州zhou 揭jie 阳yang 云yun 浮fu 兰lan 州zhou 金jin 昌chang 白bai 银yin 天tian 水shui 嘉jia 峪yu 关guan 武wu 威wei 张zhang 掖ye 平ping 凉liang 酒jiu 泉quan 庆qing 阳yang 定ding 西xi 陇long 南nan 临lin 夏xia 甘gan 南nan 成cheng 都du 自zi 贡gong 攀pan 枝zhi 花hua 泸lu 州zhou 德de 阳yang 绵mian 阳yang 广guang 元yuan 遂sui 宁ning 内nei 江jiang 乐le 山shan 南nan 充chong 眉mei 山shan 宜yi 宾bin 广guang 安an 达da 州zhou 雅ya 安an 巴ba 中zhong 资zi 阳yang 阿a 坝ba 甘gan 孜zi 凉liang 山shan 贵gui 阳yang 六liu 盘pan 水shui 遵zun 义yi 安an 顺shun 铜tong 仁ren 毕bi 节jie 黔qian 西xi 南nan 黔qian 东dong 南nan 黔qian 南nan 海hai 口kou 三san 亚ya 五wu 指zhi 山shan 琼qiong 海hai 儋dan 州zhou 文wen 昌chang 万wan 宁ning 东dong 方fang 澄cheng 迈mai 定ding 安an 屯tun 昌chang 临lin 高gao 白bai 沙sha 昌chang 江jiang 乐le 东dong 陵ling 水shui 保bao 亭ting 琼qiong 中zhong 昆kun 明ming 曲qu 靖jing 玉yu 溪xi 保bao 山shan 昭zhao 通tong 丽li 江jiang 思si 茅mao 临lin 沧cang 文wen 山shan 红hong 河he 西xi 双shuang 版ban 纳na 楚chu 雄xiong 大da 理li 德de 宏hong 怒nu 江jiang 迪di 庆qing 西xi 宁ning 海hai 东dong 海hai 北bei 黄huang 南nan 海hai 南nan 果guo 洛luo 玉yu 树shu 海hai 西xi 西xi 安an 铜tong 川chuan 宝bao 鸡ji 咸xian 阳yang 渭wei 南nan 延yan 安an 汉han 中zhong 榆yu 林lin 安an 康kang 商shang 洛luo 南nan 宁ning 柳liu 州zhou 桂gui 林lin 北bei 海hai 防fang 城cheng 港gang 钦qin 州zhou 贵gui 港gang 玉yu 林lin 百bai 色se 贺he 州zhou 河he 池chi 来lai 宾bin 崇chong 左zuo 拉la 萨sa 那na 曲qu 昌chang 都du 山shan 南nan 日ri 喀ka 则ze 阿a 里li 林lin 芝zhi 银yin 川chuan 石shi 嘴zui 山shan 吴wu 忠zhong 固gu 原yuan 中zhong 卫wei 乌wu 鲁lu 木mu 齐qi 克ke 拉la 玛ma 依yi 石shi 河he 子zi 阿a 拉la 尔er 图tu 木mu 舒shu 克ke 五wu 家jia 渠qu 吐tu 鲁lu 番fan 阿a 克ke 苏su 喀ka 什shi 哈ha 密mi 和he 田tian 阿a 图tu 什shi 库ku 尔er 勒le 昌chang 吉ji 阜fu 康kang 米mi 泉quan 博bo 乐le 伊yi 宁ning 奎kui 屯tun 塔ta 城cheng 乌wu 苏su 阿a 勒le 泰tai 呼hu 和he 浩hao 特te 包bao 头tou 乌wu 海hai 赤chi 峰feng 通tong 辽liao 鄂e 尔er 多duo 斯si 呼hu 伦lun 贝bei 尔er 巴ba 彦yan 淖nao 尔er 乌wu 兰lan 察cha 布bu 锡xi 林lin 郭guo 勒le 盟meng 兴xing 安an 盟meng 阿a 拉la 善shan 盟meng 澳ao 门men 香xiang 港gang"
def get_pinyin_map():
#use http://qq.ip138.com/wb/wb.asp? to get pinyin coding
	global mm
	for s in pinyin.split(' '):
		s = s.strip("' \t")
		if len(s):
			d = s[1:].strip("' \t")
			is_az(d,s)
			mm[s[0]] = d 
	return mm

def get_pinyin(ss):
	r = ""
	short = ""
	for s in ss.strip():
		r += mm[s]
		short += mm[s][0]
	return (r,short)
	
def update_city():
	db = sqlite3.connect("user.db")
	c = db.cursor()
	rr = c.execute("select cityID,cityName from c_city").fetchall()
	for r in rr:
		t = get_pinyin(r[1])
		db.execute("UPDATE c_city SET pinyin ='%s',pinyinCapital='%s',cityName='%s' WHERE cityID=%d"%(t[0],t[1],r[1].strip(),r[0]))	
	db.commit()
	db.close()
	
def get_js():
	db = sqlite3.connect("user.db")
	rr = db.cursor().execute("select cityID,cityName,pinyin,pinyinCapital from c_city").fetchall()
	s = "["
	for index,r in enumerate(rr):
		#['北京|beijing|bj','包头|baotou|bt'];
		s += "'" + r[1] + '|' + r[2] + '|' + r[3] + "',"
		if index != 0 and index % 5 == 0:
			s += "\n"
	s = s[0:len(s)-1 ]
	s += "];"
	print(s)

get_pinyin_map()
update_city()		
get_js()
		
		
	
	

	
	