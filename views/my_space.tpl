<!DOCTYPE HTML>
<html>
<head>
	{{!web_head}}
	<script src="js/jquery.raty.min.js"></script>
</head>
<body>
{{!page_head}}

<style type="text/css">
</style>
<script type="text/javascript">
	function init_raty(readonlyVal)
	{
		$("#star_rating1").empty();
		$("#star_rating2").empty();
		$("#star_rating3").empty();
		$("#star_rating4").empty();
		
		$("#star_rating1").raty({ start:3,inline_width:38,readOnly:readonlyVal});
		$("#star_rating2").raty({ start:3,inline_width:68,readOnly:readonlyVal});
		$("#star_rating3").raty({ start:3,inline_width:68,readOnly:readonlyVal});
		$("#star_rating4").raty({ start:3,inline_width:68,readOnly:readonlyVal});
	}
	
	$(document).ready(function(e){
		init_raty(true);
		var isFirst = true;
		$("#nav_my_space .navbar-nav").children("li").click(function(){
			var text = $(this).children().text();
			var u = $(this).children().attr("data");
			$(this).parent().children("li").removeClass("active");
			$(this).addClass("active");
			$("#div_profile").load(u,function(responseTxt,statusTxt,xhr){
				if(statusTxt!="success")
					$("#div_profile").text("Error: "+xhr.status+": "+xhr.statusText);
				init_common();
				if(!isFirst) pop_breadcrumb();
				push_breadcrumb(text,u);
				isFirst=false;
			      });
			
		});
		
		$("#tagSelector").tag_selector({edit_mode:false});
		$("#desc").hide();
		$("#first_nav_tag").click();
	});
	
	function click_edit()
	{
		if ("True" == $(this).attr("edit_mode")) {
			$(this).attr("edit_mode","False");
			$("#tagSelector").tag_selector({edit_mode:false});
			$("#desc").hide();
			$("#head_save_button").hide();
			
			init_raty(true);
		}
		else
		{
			$(this).attr("edit_mode","True");
			$("#tagSelector").tag_selector({edit_mode:true});
			$("#desc").show();
			$("#head_save_button").show();
		
			init_raty(false);
		}
	}
</script>	
<!-- div_space_readonly代表别人访问时的只读属性
     div_space_edit 代表本人，可以修改
-->
<div id="my_space_head" class="row div_space_edit">
     <div class="col-md-8 col-md-offset-2" >
	<div class="row">
		<div class="col-md-4">
			<img class="img_profile_lg hot_tag" src="res/test/a (11).jpg"></img>
			<p class="detail_css text-center">
				<i class="icon-eye-open num_format">1000</i>次&nbsp;&nbsp;|
				&nbsp;&nbsp;<i class="icon-picture num_format">111</i>张
			</p>
		</div>
		<div class="col-md-8">
			<h4 class="in_block"><strong>姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚</strong></h4>
			<p class="text_like in_block" style="margin-left: 10px"><span class="text_like_num">221256</span>人喜欢<i class="icon-heart"></i></p>
			<BR>
			<p class="text_profile_info1 in_block">
				<strong>广东广州 | </strong><strong>21岁 | 178cm | 50kg</strong>
			</p>
			<div style="margin-left: 20px" class="in_block">
				<i class="icon-iphone" title="手机认证******79001"></i>&nbsp;<i class="icon-nameplate" title="身份认证"></i>&nbsp;
				<i class="icon-camera" title="相片认证"></i>&nbsp;<i class="icon-car" title="有车认证"></i>&nbsp;
				<i class="icon-temple-christianity-church" title="有房认证"></i>
			</div>
			<p>
				 本科 | 10k-15k | 租房 | 有车
			</p>
			<div class="in_block" >
				<div style="margin-bottom: 5px">
					<span>长相：</span><div id="star_rating1" class="in_block"></div><span class="small">英俊潇洒</span><BR/>
				</div>
				<div style="margin-bottom: 5px">
					<span>身材：</span><div id="star_rating2" class="in_block"></div><span class="small">英俊潇洒</span><BR/>
				</div>
				<div style="margin-bottom: 5px">
					<span>性格：</span><div id="star_rating3" class="in_block"></div><span class="small">英俊潇洒</span><BR/>
				</div>
				<div style="margin-bottom: 5px">
					<span>态度：</span><div id="star_rating4" class="in_block"></div><span class="small">英俊潇洒</span><BR/>
				</div>
			</div>
			<h5 class="in_block icon-edit readonly_hide" style="margin-left: 50px;margin-top: 0px;vertical-align: top;cursor:pointer" edit_mode="False" onclick="click_edit()">
					编辑
			</h5>
			<BR>
			<div id="tagSelector" style="margin-bottom: 8px">
				<span>标签：</span>
				<input id="input_tagSelector" type="hidden" ></input>
				<ul>
					<li>C</li>
					<li>C++</li>
					<li>天下无敌</li>
					<li>PHP</li>
					<li>Python</li>
					<li>C</li>
					<li>C++</li>
					<li>JAVA</li>
					<li>PHP</li>
					<li>Python</li>
					<li>C</li> 
				</ul>
			</div>
			<div>
				<span>描述：</span>
				<textarea id="desc" class="form-control" rows="3" cols="10" placeholder="自我描述"></textarea>
			</div>
			
			<div id="head_save_button" class="readonly_hide" style="margin-top: 10px;display: none">
				<button class="btn btn-success" style="margin-right: 20px"><i class="icon-ok-2">保存</i></button>
				<button class="btn btn-danger"><i class="icon-remove-2"> 取消</i></button>	
			</div>
			
			<div class="div_btn edit_hide" style="margin-top: 10px">
					<button class="btn btn-primary btn_send_msg">
						<i class="icon-envelope"></i><span class="sm_hide">发信息</span>
					</button>
					
					<button class="btn btn-success btn_like_it" onclick="click_like_it($(this))">
						<i class="icon-heart-empty"></i>喜欢
					</button>
					
					<div class="btn_dislike_it btn-group dropdown-hover" >
						<button type="button" class="btn btn-warning dropdown-toggle"  data-toggle="dropdown" style="width:100%">
						   <i class="icon-remove-2"></i><span class="sm_hide">不喜欢<span><span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
						   <li><a href="#" onclick="click_dislike_it($(this))">外表不喜欢</a></li>
						   <li><a href="#" onclick="click_dislike_it($(this))">PS痕迹严重</a></li>
						   <li><a href="#" onclick="click_dislike_it($(this))">感觉不好</a></li>
						</ul>
					</div>
			</div>
		</div>
	</div>
     </div>
</div>
<div class="row">
	<div class="col-md-8 col-md-offset-2" >
		<div class="row" style="margin-bottom: 0px;" >
			<div class="col-md-12" >
			<nav id="nav_my_space" class="navbar navbar-default" role="navigation">
				<div class="navbar-header">
				   <button type="button" class="navbar-toggle" data-toggle="collapse" 
				      data-target="#example-navbar-collapse">
				      <span class="sr-only">切换导航</span>
				      <span class="icon-bar"></span>
				      <span class="icon-bar"></span>
				      <span class="icon-bar"></span>
				   </button>
				</div>
				<div class="collapse navbar-collapse" id="example-navbar-collapse">
				   <ul class="nav navbar-nav">
				      <li ><a href="#" data="album" class="icon-camera">   我的动态</a></li>
				      <li ><a href="#" class="icon-group">   我的好友</a></li>
				      <li><a href="#" data="profile" class="icon-user">我的资料</a></li>
				      <li id="first_nav_tag"><a href="#" data="certif" class="icon-certificate">  我的认证</a></li>
				      <li ><a href="#" class="icon-star">对TA的要求</a></li>
				      <li ><a href="#" class="icon-envelope">   留言<span class="badge">20</span></a></li>
				   </ul>
				</div>
			</nav>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12" >
				<div id="div_profile"> 
				</div>
			</div>
		</div>	
	</div>
</div>
     
{{!page_foot}}	    
</body>
</html>
