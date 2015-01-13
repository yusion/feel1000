﻿<!DOCTYPE HTML>
<html>
<head>
	{{!web_head}}
	<script src="js/jquery.raty.min.js"></script>
	<link rel="stylesheet" href="css/rangeslider/ion.rangeSlider.css" />
	<link rel="stylesheet" href="css/rangeslider/ion.rangeSlider.skinFlat.css"/>
	<script src="js/ion.rangeSlider.js"></script>
</head>
<body>
{{!page_head}}

<style type="text/css">
.img_profile_lg{
	width:200px;
	height:auto;
	border: solid 1px #f597af;
	border-radius: 5px;
}

.div_img_profile{
	width:224px;
	padding: 10px 10px 34px 10px;
	background-color: #fdf9f3;
	border: solid 2px #f597af;
	border-bottom-width: 5px;
	
	border-radius: 5px;
	box-shadow: 4px 10px 6px #e6aec0;
	/*float:right;*/
}

#div_cat{
	z-index: -1;position: absolute;left:-35px;bottom:40px;
	background: url("/res/small_icon.png") no-repeat -496px 0;
	width: 54px;height:74px;
}

/* 个人信息 */
#div_profile{
	border-radius: 10px;
	border: 1px solid gray;
	border-right: 5px double gray;
	border-bottom: 5px double gray;
	box-shadow: 4px 10px 6px #998165;
	
	padding-top: 15px;
	padding-bottom: 15px;
	background-color: #fb96b0;
}

#div_profile>H3{
	color:white;
	font-weight:800;
}

#div_top_border{
	background: url("/res/border5.gif") repeat-x;
	height: 40px;
	width: 92%;
	position: absolute;
	top: -8px;
	left:20px;
	z-index: 1;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}

/*左边导航栏设计*/
#div_left_nav{
	width:120px;
	height:auto;
	position: absolute;
	top: 40px;
	left: -70px; 
	z-index: 1;
	background-color:lightblue;
}

#div_left_nav > ul{
	list-style-type:none;
	position: absolute;
	left: -65px; 
}

#div_left_nav > ul > li{ 
	width: 120px;
	cursor: pointer; 
	margin-bottom: 5px;
	padding: 8px 10px;
	border-radius: 10px;
	position: relative;
	left: 0;
	background-color: #f6fbff;
	border: solid 4px #fb96b0;
	border-left-width: 12px;
	box-shadow: 4px 4px 4px transparent;
}

#div_left_nav > ul > li:hover, #div_left_nav > ul > li.active{
	width: 150px;
	position: relative;
	left: -25px;
	box-shadow: 2px 2px 2px #330033;
}

#div_left_nav > ul > li.active>a{
	color: dimgray;
}

#div_left_nav >ul>li>a{
	text-decoration: none;
	cursor: pointer;
	font-weight: bold;
	color: lightslategray;
}

#div_left_nav >ul>li>a>i{
	margin-right: 5px;
	font-size: 18px;
}

</style>
<script type="text/javascript">
	function init_raty(readonlyVal)
	{
		function set_text(item,score,needUpdate)
		{
			while(!item.hasClass("div_raty")){
				item = item.parent();
			}
			var hints = item.attr("textList").split(",").reverse();
			if (!score) {
				score = item.attr("star");
			}
			else{
				if (needUpdate) {
					item.attr("star",score);
				}
			}
			score = parseInt(score);
			if (score != 0) {
				item.next("span").text(hints[score-1]);
			}
			else{
				item.next("span").text("");
			}
		}
		
		$(".div_raty").each(function(){
			var hints = $(this).attr("textList").split(",").reverse();
			$(this).empty();
			$(this).raty({ start:$(this).attr("star"),inline_width:38,readOnly:readonlyVal,
			hintList:hints,
			onClick: function (score,s){
				set_text(s,score,true);
			},
			onEnter: function (score,s){
				set_text(s,score,false);
			},
			onLeave: function (s){
				set_text(s);
			}
			});
			set_text($(this));
		});
	}
	
	$(document).ready(function(e){
		init_raty(true);
		var isFirst = true;
		$("#div_left_nav ul").append($("#nav_my_space .navbar-nav >li").clone());
		
		$("#nav_my_space,#div_left_nav").find("li").click(function(){
			var text = $(this).find("span:first").text();
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
				
				$("#div_profile").prepend("<H3 class='text-center'>"+ text +"</H3> ");
			      });
			
		});
		 
		$("#tagSelector").tag_selector({edit_mode:false});
		$("#desc").hide();
		
		$("#first_nav_tag").click().addClass("active");;
		
		set_background_img("res/personal_bg.jpg",$("#my_space_head"));
	});
	
	function click_edit(item){
		if ("True" == item.attr("edit_mode")) {
			item.attr("edit_mode","False");
			$("#tagSelector").tag_selector({edit_mode:false});
			$("#desc").hide();
			$("#head_save_button").hide();
			item.text("编辑资料");
			init_raty(true);
		}
		else
		{
			item.attr("edit_mode","True");
			$("#tagSelector").tag_selector({edit_mode:true});
			$("#desc").show();
			$("#head_save_button").show();
			item.text("取消编辑");
			init_raty(false);
		}
	}
	
	function save_edit(){
		
	}
</script>	
<!-- div_space_readonly代表别人访问时的只读属性
     div_space_edit 代表本人，可以修改
-->
<div id="my_space_head" class="row div_space_edit">
     <div class="col-md-8 col-md-offset-2" >
	<div class="row">
		<div class="col-md-4">
			<!-- div style="background:url('/res/border6.gif') repeat-x;width:224px;height:25px;float:right"></div -->
			<div class="div_img_profile small text-center">
				<img class="img_profile_lg" src="{{photo_url}}"></img>
				<i class="icon-heart"></i><span class="text_like_num">221</span>喜欢&nbsp;&nbsp;|
				<i class="icon-eye-open num_format">1000</i>次&nbsp;&nbsp;|
				&nbsp;&nbsp;<i class="icon-picture num_format">111</i>张
			</div>
			<div id="div_cat"></div> 
		</div>
		<div class="col-md-5">
			<img src="/res/border3.gif" style="clear: both"></img><BR>
			<h4 class="in_block"><strong>{{nickname}}</strong></h4>
			<h5 id="text_edit" class="in_block icon-edit readonly_hide" style="float: right;vertical-align: top;cursor:pointer" edit_mode="False" onclick="click_edit($(this))">
				编辑资料
			</h5>
			<BR>
%if not my:				
			<p class="text_profile_info1 in_block">
				<strong>{{city}} | </strong><strong>{{age}}岁 | {{height}}cm | {{weight}}kg</strong>
			</p>
			<div style="margin-left: 20px" class="in_block">
				<i class="icon-iphone" title="手机认证******79001"></i>&nbsp;<i class="icon-nameplate" title="身份认证"></i>&nbsp;
				<i class="icon-camera" title="相片认证"></i>&nbsp;<i class="icon-car" title="有车认证"></i>&nbsp;
				<i class="icon-temple-christianity-church" title="有房认证"></i>
			</div>
			<p>
				本科 | 10k-15k | 租房 | 有车
			</p>
%else:
			<div style="width:10px;height:20px"></div>
%end 
			<div class="in_block" style="width:100%">
%				for s in c_score:
				<div style="margin-bottom: 5px;width:100%">
					<span>{{s[1]}}：</span>
					<div id="div_star_{{s[0]}}" class="in_block div_raty" textList="{{s[2]}}" star="{{scores[str(s[0])]}}"></div>
					<span class="small1" style="margin-left: -15px"></span><BR/>
				</div>
%				end				
			</div>
			<BR>
			<div>
				<span class="in_block" style="margin-bottom: 5px">描述：</span>
				<textarea id="desc" class="form-control limit_l" maxlength="100" rows="3" cols="10" placeholder="自我描述">{{desc}}</textarea>
			</div>
			<div id="tagSelector" style="margin-bottom: 8px">
				<span class="in_block" style="margin-bottom: 5px">标签：</span>
				<input id="input_tagSelector" type="hidden" ></input>
				<ul>
%					for t in c_tags:
					<li value="{{t[0]}}">{{t[1]}}</li>
%					end					
				</ul>
			</div>			
			<div id="head_save_button" class="readonly_hide text-center" style="margin-top: 10px;display: none">
				<button class="green_btn" style="margin-right: 20px"><i class="icon-ok-2">保存</i></button>
				<button class="gray_btn" onclick="click_edit($('#text_edit'));"><i class="icon-remove-2"> 取消</i></button>	
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
			<BR>
			<img src="/res/border4.gif"></img>
			<BR>
%if not my:			
			<button type="button " class="purple_btn"><i class="icon-heart"></i>喜欢</button>
			<button type="button " class="yellow_btn"><i class="icon-coffe-cup"></i>交友</button>
			<button type="button " class="blue_btn"><i class="icon-envelope"></i>私信</button>
			<button type="button " class="gray_btn"><i class="icon-bell"></i>举报</button>
%end			
		</div>
	</div>
     </div>
</div>
<div class="row">
	<div class="col-md-7 col-md-offset-2" >
		<div class="row hidden-md hidden-lg" style="margin-bottom: 0px;" >
			<div class="col-md-12" >
			<nav id="nav_my_space" class="navbar navbar-default" role="navigation">
				<div class="navbar-header">
				   <button type="button" class="navbar-toggle" data-toggle="collapse" 
				      data-target="#space-navbar-collapse">
				      <span class="sr-only">切换导航</span>
				      <span class="icon-bar"></span>
				      <span class="icon-bar"></span>
				      <span class="icon-bar"></span>
				   </button>
				</div>
				<div class="collapse navbar-collapse clearfix " id="space-navbar-collapse" style="padding-left: 0px">
				   <ul class="nav navbar-nav"> 
				      <li><a href="#" data="album2" class="text-center"><i class="icon-envelope" style="color:orange"></i><span>我的动态</span></a></li>
				      <li id="first_nav_tag"><a href="#" data="profile" class="text-center"><i class="icon-user" style="color:limegreen"></i><span>我的资料</span></a></li>
				      <li><a href="#" data="certif" class="text-center"><i class="icon-certificate"  style="color:goldenrod"></i><span>我的认证</span></a></li>
				      <li><a href="#" data="record"><i  class="icon-book-open" class="text-center" style="color:orchid"></i><span>个人喜好</span></a></li>
				      <li><a href="#" data="ta_request"><i class="icon-star" class="text-center" style="color:deepskyblue"></i><span>我的要求</span></a></li>
				   </ul>
				</div>
			</nav>
			</div>
		</div>
		<div class="row">
			<div id="div_left_nav" class="hidden-xs hidden-sm">
				<ul></ul>
			</div>
			<div id="div_profile_container" class="col-md-12 in_block" style="z-index: 2;padding-right: 0" >
				<div id="div_top_border"></div>
				<div id="div_profile">
				</div>
			</div>
		</div>	
	</div>
	<div class="col-md-2">
		{{!friend}}
	</div>
</div>
     
{{!page_foot}}	    
</body>
</html>

