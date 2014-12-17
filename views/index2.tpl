<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
{{!web_head}}
	<script src="js/jquery.jcarousellite.js"></script> <!-- ycat modify -->
	<script src="js/md5.js"></script>
	<script type="text/javascript" src="/js/jquery.pagepiling.min.js"></script>
	<script src="/js/masonry.pkgd.min.js"></script>
	<script src="/js/imagesloaded.pkgd.min.js"></script>
</head>
<body>
<style type="text/css">
/*标签页设计 */
#div_tag_container{
	background-color: #faf3e3;
	padding: 10px 20px 10px 20px;
	border: 3px solid #d58aad;
	border-bottom-width: 15px;
	min-height: 370px;
	margin-top: -1px;
	box-shadow: 4px 10px 5px #888888;
}

#div_border{
	height: 18px;
	width: 100%;
	background-image: url("/res/border1.jpg");
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
	box-shadow: 4px 10px 5px #888888;
}

.nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus {
	border: 3px solid #d58aad;
	border-bottom-color: transparent;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	background-color: #faf3e3;
}

.nav-tabs>li>a {
	background-color: rgba(0,0,0,0.3);
	color:white;
	margin-bottom: -3px;
}

#div_anonymity > img{
	width:100%;
	margin-top:20px;
}

#div_anonymity > button{
	width:100%;
	margin-top:10px;
}

#tab_login > li > a{
	cursor: pointer
}

/* 推荐会员 */
#div_recommand_member{
	background-color: #f9e3cb;
}

#div_recommand_top_border,#div_recommand_bottom_border{
	background: url("/res/border2.jpg");
	height: 20px;
	width:100%;
}

#div_recommand_member .prev, #div_recommand_member .next{
	z-index:1000;
	width:50px;
	position: absolute;
	top: 0px;
	left: 0px;
	opacity: 0.8;
	background-color:gray;
	cursor:pointer;
	padding-top:170px;
}

#div_recommand_member .prev>div,#div_recommand_member .next>div{
	width:31px;
	height:48px;
	z-index: 1000;
	margin-top:20px;
	margin-left: 8px;
	margin-right: 5px;
	background: url('/res/small_icon.png') no-repeat -328px -45px;
}

#div_recommand_member .next>div{
	margin-left: 5px;
	background: url('/res/small_icon.png') no-repeat -365px -45px;
}

#div_recommand_member li > div > img{
	margin: 15px 10px 10px 10px;
}

/* 介绍页设计  */
H1{
	color: #535353;
	font-size: 46px;
	padding: 30px 0;
	text-align: center;
	font-family: "\5FAE\8F6F\96C5\9ED1";
	font-weight: 800;
}

H2{
	font-size: 30px;
	font-family: "\5FAE\8F6F\96C5\9ED1";
	font-weight: 500;
}

</style>
<script type="text/javascript">
	$(document).ready(function(e){ 
		//自动切换注册和登陆页面
		$("#tab_login > li").mouseenter(function(){
			$(this).children("a").click();
			
			if(get_browser_info().ie)
			{
				//ie这个东东，会显示焦点混乱 
				setTimeout(function(){
					var f = $("#div_tag_container .active").find("button");
					f.select().focus(); 
				},100);	
			}
		});
		
		//http://www.gmarwaha.com/jquery/jcarousellite/demo.php
		//图片读取 http://imagesloaded.desandro.com/
		setTimeout(function(){
			$("#section3").show();	//因为carousel会闪现，所以这时才显示  	
			$('#div_recommand_member').imagesLoaded( function() {
				$("#div_recommand_member .carousel").jCarouselLite({
					btnNext: "#div_recommand_member .prev",
					btnPrev: "#div_recommand_member .next",
					//auto: 3000,
					speed: 2000,
					scroll: 4,
					//mouseWheel: false,
					//circular:true,
					visible:10
				});
			}); 
		},600);
		 
		$("#div_recommand_member").find(".prev,.next").hide();
			
		$("#div_recommand_member").mouseenter(function(){
			$("#div_recommand_member .prev").height($(this).height()).show();
			$("#div_recommand_member .next").height($(this).height()).show(); 
			
			var left = $("body").width() - $("#div_recommand_member .next").width();
			$("#div_recommand_member .next").css("left",""+left+"px");
			$(this).children(".prev,.next").show();
		});
		
		$("#div_recommand_member").mouseleave(function(){
			$(this).find(".prev,.next").hide();
		});
		
		set_background_img("res/index_background.jpg")
	});
</script>	
<div id="index_container" class="container" style="width:100%;padding: 0 0 0 0">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<img src="/res/title_logo.png"></img>
		</div>
	</div>
	<div class="row" style="margin-top: 20px">
		<div class="col-md-3 col-md-offset-1">
			<img src="res/index-left.png" style="position: relative;top:260px;left:80px;z-index: 10"></img>
		</div>
		<div class="col-md-4">
			<ul id="tab_login" class="nav nav-tabs">
				<li class="active">
				   <a id="link_register" href="#div_register" data-toggle="tab">免费注册</a>
				</li>
				<li>
				   <a id="link_login" href="#div_login" data-toggle="tab">快速登陆</a>
				</li>
				<li>
				   <a id="link_login" href="#div_anonymity" data-toggle="tab">直接访问</a>
				</li>
			</ul>
			<div id="div_tag_container" class="tab-content">
				<div class="tab-pane active" id="div_register">
				   {{!register}}
				</div>
				<div class="tab-pane" id="div_login">
				   {{!login}}
				</div>
				<div class="tab-pane" id="div_anonymity">
					<div class="row">
						<div class="col-xs-6">
							<a href="/index?sex=0">
							<img src="/res/boy.jpg" style="width:100%;margin-top:20px"></img>
							<button type="button" class="btn btn-info icon-male" style="width:100%;margin-top:10px;text-decoration: none">我是男生</button>
							</a>
						</div>
						<div class="col-xs-6">
							<a href="/index?sex=1">
							<img src="/res/girl.jpg" style="width:100%;margin-top:20px"></img>
							<button type="button" class="btn btn-danger icon-female" style="width:100%;margin-top:10px;text-decoration: none">我是女生</button>
							</a>
						</div>
					</div>
				</div>
			</div>
			<div id="div_border"></div>
		</div>
		<div class="col-md-4">
			<img src="res/index-right.png" style="position: relative;top:-80px;left:-50px;"></img>
		</div>
	</div>
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<img src="/res/index_slogan.jpg"></img>
		</div>
	</div>
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div>
				<h1>无骚扰风险</h1>
				<H2>无需登记您的<strong>手机号</strong>或<strong>QQ号</strong></H2>
				<H2><strong>一键注销</strong>个人信息功能，让您隐私无后顾无优</H2>
				<H2>采用<strong>先进加密</strong>技术，保障数据安全</H2>
			</div>
			<div>
				<h1>多重审核</h1>
				<H2>美女客服会审核刚注册会员，<strong>确保会员质量</strong></H2>
				<H2>建立<strong>个人评价系统</strong>，防止各种酒托、婚托和一夜情</H2>
				<H2>通过身份证和相片审核，<strong>保障真实性</strong></H2>
				<H2>会员都是通过朋友介绍，无虚假会员</H2>
			</div>
			<div>
				<h1>终身会员制度</h1>
				<H2>只要成功通过审核，就可以使用网站的全部功能，<strong>无附加费用</strong></H2>
			</div>	
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<H1 style="color:white">精选会员等着您</H1>
			<img src="/res/bird.png" style="position:relative;top:15px;left:30px"></img>
			<div id="div_recommand_member">
				<div id="div_recommand_top_border"></div>
				<div class="carousel">
				    <div class="prev">
					<div></div>
				    </div>
				    <div class="next">
					<div></div>
				    </div>
				    <ul>
				     %for i in range(20):
					<li>
						<div style="width:200px;height:auto">
							<img src="res/test/a ({{i%9+1}}).jpg" style="width:200px;height:200px">
							<img src="res/test/a ({{i%9+2}}).jpg" style="width:200px;height:200px">
						</div>
					</li>
				     %end
				    </ul>
				</div>
				<div id="div_recommand_bottom_border">
				</div>
			</div>
			<img src="/res/email.png" style="position:relative;top:-60px;right:40px;float:right;z-index:100"></img>
		</div>
	</div>
	<div class="row" style="background-color:#F4F6F7;padding: 16px 0;text-align: center;margin: 0 0 0 0;padding: 0 0 0 0">
		<div class="col-md-12" style="padding: 0 0 0 0">
			<H2>上花田，轻松找对象</H2>
			<a href="#" class="btn btn-info in_block" style="margin-top:10px;text-decoration: none;width:120px">注册</a>
			<a href="#" class="btn btn-success in_block" style="margin-top:10px;margin-left:20px;text-decoration: none;width:120px">登录</a>
			<P style="margin-top: 10px">关注花田：  花田易信号：huatian</P>
			<P>iPhone用户客服邮箱：ihuatianiphone@163.com       Android用户客服邮箱：ihuatianandroid@163.com</P>
			<div style="background-color:#E3E6EE;padding: 16px 0;text-align: center;">
				<P>公司简介 - 联系方法 - 招聘信息 - 使用条款 - 花田动态 - 友情链接 - 网站地图 - 花田意见反馈</P>
				<P>网易公司版权所有</P>
				<P>©2014-2024</P>
			</div>
		</div>
	</div>
</div>
<!--[if !IE]><!-->
<script>
less = {
    env: "development",
    async: false,
    fileAsync: false,
    poll: 1000,
    functions: {},
    dumpLineNumbers: "comments",
    relativeUrls: false,
    rootpath: ":/127.0.0.1/"
  };	
</script>
<script src="js/less.min.js"></script>    
<!--<![endif]-->
 
</body>
</html>
