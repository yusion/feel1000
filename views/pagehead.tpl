<!-- this is page head begin -->
<input type="hidden" id="session" value="{{session}}" />
<div id="page_container" class="container">
  <div id="page_head_row" class="row">
    <div class="col-md-6 col-md-offset-2"  >
	<nav id="nav_main" class="navbar navbar-inverse" role="navigation">
 		<div class="navbar-header">
		   <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#my_navbar-collapse">
		      <span class="sr-only">切换导航</span>
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		   </button>
		   <a class="navbar-brand" href="index2" style="padding: 0 20px 0 0px">
		    <img alt="logo" src="res/logo.gif" style="width:50px;height:auto"></img>
		    <span style="font-weight:900;font-size: 20px;vertical-align: middle;color: yellow">LoveCC</span>
		   </a>
		</div>
		<div class="collapse navbar-collapse" id="my_navbar-collapse">
		   <ul class="nav navbar-nav">
			<li  class="active"><a href="index2"><i class="icon-home"></i> 主页</a></li>
			<li><a href="all_space"><i class="icon-conversation"></i> 动态</a></li>
		        <li><a href="search"><i class="icon-search"></i> 查找</a></li>  
			<li id="li_my_space"><a href="my_space"><i class="icon-user"></i> 我的空间</a></li>
		   </ul>
		</div>
	     </nav>
     </div>
     <div class="col-md-3 col-md-pull-1">
	<div style="float: right;color:white;vertical-align: middle">
		<img id="img_profile" src="{{photo_url}}" style="width:30px;heigth:auto" class="in_block"></img>
		<div id="div_visit" class="in_block">
			<a href="/index?register"  style="color:white;margin-right: 10px">注册</a>
			<a href="/index?login"  style="color:white">登陆</a>
		</div>
		<div id="div_user_menu" class="dropdown dropdown-hover in_block">
			<button id="btn_name" type="button" class="btn-link dropdown-toggle" data-toggle="dropdown" style="color:white">
				{{name}}
			   <span class="caret"></span>
			</button>
			<ul class="dropdown-menu pull-right1" role="menu" >
			   <li role="presentation"  class="small">
			      <a role="menuitem" tabindex="-1" href="#">我的好友</a>
			   </li>
			   <li role="presentation"  class="small">
			      <a role="menuitem" tabindex="-1" href="#">帐号设置</a>
			   </li>
			   <li role="presentation" class="divider"></li>
			   <li role="presentation" class="small">
			      <a id="link_logout" role="menuitem" tabindex="-1" href="/logout">退出登陆</a>
			   </li>
			</ul>
	     </div>
	</div>	
     </div>
  </div>
  <div class="row"> 
	<div class="col-md-8 col-md-offset-2">
		<div id="my_breadcrumb">
			<a href="index"><i class="icon-google-maps"></i>主页</a>
		</div>
	</div>
  </div>

<script type="text/javascript">
	$(document).ready(function(e){
		if (!is_visit()) {
			$("#div_visit").hide();
		}
		else{
			//访客 
			$("#li_my_space").hide();
			$("#div_user_menu").hide();
		}
		
		$("#nav_main .active").removeClass("active");
		$("#nav_main .navbar-nav a").each(function(){
			//set active tab 
			link = $(this).attr("href").toLowerCase();
			url = window.location.pathname.toLowerCase();
			if (url[0] == "/") {
				url = url.substr(1);
			}
			if (url == "") {
				url = "index2";
			}
			if (link.indexOf(url) != -1){ 
				$(this).parent().addClass("active");
				if (url != "index2") {
					push_breadcrumb($(this).text());
				}
			}
		});
	});
</script>
<style type="text/css">
#div_user_menu ul{
	min-width: 100px;
}
</style>

%if is_test:
<script type="text/javascript">
     QUnit.module("page_head");
     var p;
     if (is_visit()) {
	QUnit.test("visit_data",function(assert){
		assert.ok($("#div_visit").visible());
		assert.ok(!$("#li_my_space").visible());
		assert.ok(!$("#div_user_menu").visible());
		
		var u = $("#img_profile").attr("src");
		if (u == "/res/boy.jpg") {
			assert.equal($("#btn_name").text().trim2(),"神秘的帅哥");
		}
		else if(u == "/res/girl.jpg"){
			assert.equal($("#btn_name").text().trim2(),"神秘的美女");
		}
	});	
     }
     else
     {
	QUnit.asyncTest("get_data",function(assert){
		expect(5);
		$.getJSON("/test/get_my_profile",null,
			function(json){ 
				assert.ok(!$("#div_visit").visible());
				assert.ok($("#li_my_space").visible());
				assert.ok($("#div_user_menu").visible());
				assert.equal($("#btn_name").text().trim2(),json.nickname);
				if (json.hasphoto) {
					assert.equal($("#img_profile").attr("src"),json.photo_url);
				}
				else
				{
					assert.equal($("#img_profile").attr("src"),"res/unknownprofile.jpg");
				}
				QUnit.start();
			});	
        });
     }
</script>
%end     
<!-- this is page head end -->
