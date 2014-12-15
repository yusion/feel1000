<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
{{!web_head}}
	<link rel="stylesheet" type="text/css" href="/css/jquery.pagepiling.css">
	<script src="js/jquery.jcarousellite.js"></script> <!-- ycat modify -->
	<script src="js/md5.js"></script>
	<script type="text/javascript" src="/js/jquery.pagepiling.min.js"></script>
	<script src="/js/masonry.pkgd.min.js"></script>
	<script src="/js/imagesloaded.pkgd.min.js"></script>
</head>
<body style="background-color:gray">
<style type="text/css">
#div_tag_container{
	background-color: white;
	padding: 10px 20px 10px 20px;
	border: 1px solid #ddd;
	border-top-width: 0px;
	height:340px;
}

#index_container{
	background-color: gray;
}
#tab_login > li > a{
	cursor: pointer
}
.pp-tableCell{
	height: 100%
}

#div_recommand_member p{
	z-index:1000;
	width:60px;
	position: absolute;
	top: 0px;
	left: 0px;
	opacity: 0.8;
	background-color:gray;
	cursor:pointer;
	color:white;
	font-size: 40px;
	font-family: Arial, sans-serif;
	padding-top:170px;
	text-align: center;
}

.nav-tabs>li>a {
	background-color: rgba(0,0,0,0.3);
	color:white;
}

#div_anonymity > img{
	width:100%;
	margin-top:20px;
}

#div_anonymity > button{
	width:100%;
	margin-top:10px;
}

</style>
<script type="text/javascript">
	$(document).ready(function(e){
		$("#section3").hide(); //因为carousel会闪现，所以先隐藏  
		
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
		
		//分页插件
		$('#pagepiling').pagepiling({
	    		menu: '#menu',
			navigation: {
                                textColor: "#000",
                                bulletsColor: "#000",
                                position: "right",
                                tooltips: ["首页", "第2页", "第3页"]
                        },
	    		anchors: ['page1', 'page2', 'page3'],
			    sectionsColor: ['gray', '#2ebe21', '#2ebe21'],
			    onLeave: null,
			    afterRender: null,
			    afterLoad: null
		}); 
		$("#pp-nav").addClass("visible-md visible-lg");
		
		
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
		 
		$("#div_recommand_member").find("p").hide();
			
		$("#div_recommand_member").mouseenter(function(){
			$("#div_recommand_member .prev").height($(this).height()).show();
			$("#div_recommand_member .next").height($(this).height()).show(); 
			
			var left = $("body").width() - $("#div_recommand_member .next").width();
			$("#div_recommand_member .next").css("left",""+left+"px");
			$(this).children("p").show();
		});
		
		$("#div_recommand_member").mouseleave(function(){
			$(this).find("p").hide();
		});
	});
</script>	
<ul id="page_menu">
	<li data-menuanchor="page1" class="active"><a href="/index2#page1">首页</a></li>
	<li data-menuanchor="page2" class=""><a href="/index2#page2">第2页</a></li>
	<li data-menuanchor="page3" class=""><a href="/index2#page3">第3页</a></li> 
</ul>
<div id="pagepiling" style="overflow: hidden;">
	<div class="section pp-section pp-table pp-easing active" id="section1" data-anchor="page1" style1="z-index: 10; background-color: rgb(191, 218, 0); -webkit-transform: translate3d(0px, -100%, 0px);">
		<div id="index_container" class="container pp-tableCell1">
			<div class="row">
				<div class="col-md-4 col-md-offset-4">
					<img src="/res/title_logo.png"></img>
				</div>
			</div>
			<div class="row" style="margin-top: 20px">
				<div class="col-md-4 col-md-offset-4">
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
									<button type="button" class="btn btn-info" style="width:100%;margin-top:10px">我是男生</button>
									</a>
								</div>
								<div class="col-xs-6">
									<a href="/index?sex=1">
									<img src="/res/girl.jpg" style="width:100%;margin-top:20px"></img>
									<button type="button" class="btn btn-danger" style="width:100%;margin-top:10px">我是女生</button>
									</a>
								</div>
							</div>
						</div>
					</div>
					
				</div>
			</div>
			<div class="row visible-md visible-lg">
				<div class="col-md-4 col-md-offset-4">
					<div style="height: 50px;width:100%"></div>
				</div>
			</div>
		</div>
 
	</div>
	<div class="section pp-section pp-table pp-easing" id="section2" data-anchor="page2" style="z-index: 9; background-color: rgb(46, 190, 33); -webkit-transform: translate3d(0px, -100%, 0px);">
		<div class="pp-tableCell">
			<div class="intro" >
				<h1>无骚扰风险</h1>
				<h4>无需登记您的<strong>手机号</strong>或<strong>QQ号</strong></h4>
				<h4><strong>一键注销</strong>个人信息功能，让您隐私无后顾无优</h4>
				<h4>采用<strong>先进加密</strong>技术，保障数据安全</h4>
				
				<h1>多重审核</h1>
				<h4>美女客服会审核刚注册会员，<strong>确保会员质量</strong></h4>
				<h4>建立<strong>个人评价系统</strong>，防止各种酒托、婚托和一夜情</h4>
				<h4>通过身份证和相片审核，<strong>保障真实性</strong></h4>
				<h4>会员都是通过朋友介绍，无虚假会员</h4>
				
				<h1>终身会员制度</h1>
				<h4>只要成功通过审核，就可以使用网站的全部功能，<strong>无附加费用</strong></h4>
			</div>
		</div>
	</div>
	<div class="section pp-section pp-table" id="section3" data-anchor="page3" style="z-index: 6; background-color: rgb(44, 62, 80)">
		<div class="pp-tableCell">
			<H1 style="color:white">精选会员等着您</H1>  
			<div id="div_recommand_member">
				<div class="carousel">
				    <p class="prev">&lt;</p>
				      <p class="next">&gt;</p>
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
