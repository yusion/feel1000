<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
	{{!web_head}}
	<script src="js/jquery.jcarousellite.js"></script> <!-- ycat modify -->
	<script src="js/md5.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/jquery.pagepiling.css">
	<script type="text/javascript" src="/js/jquery.pagepiling.min.js"></script>
</head>
<body>
<style type="text/css">
#div_tag_container{
	background-color: white;
	padding: 10px 20px 10px 20px;
	border: 1px solid #ddd;
	border-top-width: 0px;
	height:330px;
} 
#index_container{
	background-color: gray;
}
#tab_login > li > a{
	cursor: pointer
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
		
		$('#pagepiling').pagepiling({
	    		menu: '#menu',
			navigation: {
                                textColor: "#000",
                                bulletsColor: "#000",
                                position: "right",
                                tooltips: ["第1页", "第2页", "第3页"]
                        },
	    		anchors: ['page1', 'page2', 'page3'],
			    sectionsColor: ['gray', '#2ebe21', '#2C3E50', '#51bec4'],
			    onLeave: null,
			    afterRender: null,
			    afterLoad: null 
		});
		$("#pp-nav").addClass("visible-md visible-lg");
	});
</script>	
<ul id="page_menu">
	<li data-menuanchor="page1" class="active"><a href="/index2#page1">注册/登陆</a></li>
	<li data-menuanchor="page2" class=""><a href="/index2#page2">第2页</a></li>
	<li data-menuanchor="page3" class=""><a href="/index2#page3">第3页</a></li>
</ul>
<div id="pagepiling" style="overflow: hidden;">
    <div class="section pp-section pp-table pp-easing active" id="section1" data-anchor="page1" style1="z-index: 3; background-color: rgb(191, 218, 0); -webkit-transform: translate3d(0px, -100%, 0px);">
		<div id="index_container" class="container pp-tableCell1" style="width:100%">
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
<div class="section pp-section pp-table pp-easing" id="section2" data-anchor="page2" style="z-index: 2; background-color: rgb(46, 190, 33); -webkit-transform: translate3d(0px, -100%, 0px);">
	<div class="pp-tableCell" style="height:100%">
		<div class="intro" style="left: 0%;">
			<h1>Feel free</h1>
			<p style="display: block;">All the callbacks you need to do whatever you need.</p>
			<p style="display: block;">Just what you would expect.</p>
		</div>
	</div>
</div>
<div class="section pp-section pp-table" id="section3" data-anchor="page3" style="z-index: 1; background-color: rgb(44, 62, 80);">
	<div class="pp-tableCell" style="height:100%">
		<div class="intro">
			<h1>Ideal for animations</h1>
			<p>Total control over your website.</p>
		</div>
	</div>
    </div>
</div>

<!-- container end -->
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

<!-- this is page foot end-->
</body>
</html>
