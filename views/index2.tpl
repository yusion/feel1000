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
	height:360px;
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

</style>
<script type="text/javascript">
	$(document).ready(function(e){
		$("#section5").hide(); //因为carousel会闪现，所以先隐藏  
		
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
                                tooltips: ["首页", "第2页", "第3页", "第4页", "第5页"]
                        },
	    		anchors: ['page1', 'page2', 'page3', 'page4', 'page5'],
			    sectionsColor: ['gray', '#2ebe21', '#2ebe21', 'lightblue',, 'yellow', 'white'],
			    onLeave: null,
			    afterRender: null,
			    afterLoad: null
		}); 
		$("#pp-nav").addClass("visible-md visible-lg");
		
		
		//http://www.gmarwaha.com/jquery/jcarousellite/demo.php
		//图片读取 http://imagesloaded.desandro.com/
		setTimeout(function(){
			$("#section5").show();	//因为carousel会闪现，所以这时才显示  	
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
	<li data-menuanchor="page4" class=""><a href="/index2#page4">第4页</a></li>
	<li data-menuanchor="page5" class=""><a href="/index2#page5">第5页</a></li>
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
					</ul>
					<div id="div_tag_container" class="tab-content">
						<div class="tab-pane active" id="div_register">
						   {{!register}}
						</div>
						<div class="tab-pane" id="div_login">
						   {{!login}}
						</div>
						<a href="" class="small">不注册，直接逛逛</a><BR>
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
			<div class="intro" style="left: 0%;">
				<h1>怛心被人骚扰？</h1>
				<h3>个人<strong>联系信息</strong>无需要告诉我们</h3>
				<h3>采用先进的<strong>加密技术</strong>，保障您的个人数据安全</h3>
				<h3>承诺不会主动投放广告邮件和短信</h3>
				<h3>一键注销个人信息和相片功能，让您隐私无后顾无优</h3>
			</div>
		</div>
	</div>
	<div class="section pp-section pp-table pp-easing" id="section3" data-anchor="page3" style="z-index: 8; background-color: rgb(46, 190, 33); -webkit-transform: translate3d(0px, -100%, 0px);">
		<div class="pp-tableCell">
			<div class="intro" style="left: 0%;">
				<h1>多重审核保障真实性</h1>
				<h3>客服美眉根据个人审美观淘汰部份刚注册会员</h3>
				<h3>建立个人评价体系，防止酒托和婚托</h3>
				<h3>需进行身份证和相片审核，才能正常使用网站功能</h3>
			</div>
		</div>
	</div>
	<div class="section pp-section pp-table pp-easing" id="section4" data-anchor="page4" style="z-index: 7; background-color: rgb(46, 190, 33); -webkit-transform: translate3d(0px, -100%, 0px);">
		<div class="pp-tableCell">
			<div class="intro" style="left: 0%;">
				<h1>终身会员制度</h1>
				<h3>只要成功通过审核，就可以终身使用网站的全部功能，无任何附加费用</h3>
			</div>
		</div>
	</div>
	<div class="section pp-section pp-table" id="section5" data-anchor="page5" style="z-index: 6; background-color: rgb(44, 62, 80)">
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
