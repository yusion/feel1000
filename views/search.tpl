<!DOCTYPE HTML>
<html>
<head>
	{{!web_head}}
</head>
<body>
{{!page_head}}
%import random

<style type="text/css">
#div_search_cond dl{
	background-color:white;
}
#div_search_cond hr{
	margin: 0 0 10px 0;
}
#div_search_cond dl > dt{
	width: 70px;
	color: gray;
}
#div_search_cond dl > dd{
	margin-left: 90px;
}
#div_arrange_list{
	background-color:white;
}
#div_search_cond .badge{
	background-color: lightgray;
}

#tab_dispaly .navbar-text, #tab_dispaly  .navbar-form{
	margin: 0px 15px 0px 15px;
}

#link_show_cond,#link_hide_cond{
	text-decoration:none;
	padding: 0 10px 0 0;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		//setup layout css
		//$("#div_search_cond").wrap("<small></small>");
		$(".div_arrange_list .row >div").addClass("col-md-8 col-md-offset-2");
		$(".div_arrange_thumbnail .row >div").addClass("col-md-1 col-md-offset-2");
		$(".div_arrange_bigthumbnail .row >div").addClass("col-md-2 col-md-offset-2");
		
		//show and hide condition panel
		$("#link_hide_cond").click(function(){
			$(this).parents("dd").nextAll().hide(300);
			$(this).hide();
			$("#link_show_cond").show();
		});
		$("#link_show_cond").click(function(){
			$(this).parents("dd").nextAll().show();
			$(this).hide();
			$("#link_hide_cond").show();
		});
		$("#link_show_cond").hide();
				
		//auto set order mark
		function add_mark(elem)
		{
			if (elem.hasClass("up")) {
				elem.append("<i class='icon-up-arrow order_mark'></i>");
			}
			else
			{
				elem.append("<i class='icon-down-arrow order_mark'></i>");	
			}
		}
		
		$("#tab_dispaly li a").click(function(){
			if ($(this).hasClass("dropdown-toggle")) {
				return;
			}
			$("#tab_dispaly .order_mark").remove();
			$("#tab_dispaly .caret").show();
			//find dropdown-toggle link
			var p = $(this).parents(".dropdown").children("a");
			if (p.length) {
				if ($(this).hasClass("up")) {
					p.addClass("up");
				}
				else
				{
					p.removeClass("up");
				}
				add_mark(p);
				p.find(".caret").hide()
			}
			add_mark($(this));
		});
		add_mark($("#tab_dispaly .active>a"));
	}); 
</script>

<div class="row">
	<div id="div_search_cond" class="col-md-8 col-md-offset-2">
	<dl class="dl-horizontal" style="margin: 0 0 0 0;padding-top: 10px">
		<dt>地区</dt>
		<dd>
			<ul class="list-inline">
			<li><a href="#">广东<span class="badge">111</span></a></li>
			<li>广州<span class="badge">1</span></li>
			<li>切换城市</li>
			<li style="float: right">
				<button id="link_hide_cond" class="btn btn-link"><i class="icon-collapse-top"></i>折叠</button>
			</li>
			<li style="float: right">
				<button id="link_show_cond" class="btn btn-link"><i class="icon-expand"></i>展开</button>
			</li>
			</ul>
		</dd>
		
		<hr/>
		<dt>年龄</dt>
		<dd>
			<ul class="list-inline">
			%for i in range(18,35):
				<li>{{i}}<span class="badge">{{i}}</span></li>
			%end 
			</ul>
		</dd>
		<dt>身高(cm)</dt>
		<dd>
			<ul class="list-inline">

			%for i in range(0,7):
				<li>{{i*5+150}}-{{i*5+155}}<span class="badge">{{i}}</span></li>
			%end 
			</ul>
		</dd>
		<dt>体重(kg)</dt>
		<dd>
			<ul class="list-inline">
			%for i in range(0,7):
				<li>{{i*5+45}}-{{i*5+50}}<span class="badge">{{i}}</span></li>
			%end 
			</ul>
		</dd>
		<hr/>
		
		<dt>学历</dt>
		<dd>
			<ul class="list-inline">
			%for x in c_degree:
				<li value="{{x[0]}}">{{x[1]}}<span class="badge">1</span></li>
			%end
			</ul>
		</dd>
		<dt>条件</dt>
		<dd>
			<ul class="list-inline">
				<li>无住房<span class="badge">2</span></li>
				<li>无车<span class="badge">2</span></li>
				<li>有房<span class="badge">2</span></li>
				<li>有车<span class="badge">2</span></li>
			</ul>
		</dd>	
		<dt>收入</dt>
		<dd>
			<ul class="list-inline">
			%for x in c_income:
				<li value="{{x[0]}}">{{x[1]}}<span class="badge">1</span></li>
			%end
			</ul>
		</dd>
		<hr/>
		%for s in c_score:
			<dt>{{s[1]}}</dt>
			<dd>
				<ul class="list-inline">
					%for t in s[2].split("、"):
						<li>{{t}}<span class="badge">1</span></li>
					%end
				</ul>
			</dd>
		%end
		<hr/>
		<dt>标签</dt>
		<dd>
			<ul class="list-inline">
			%for t in c_tag:
				<li><div class="tagItem " >{{t[1]}}<span class="badge">{{random.randint(1,300)}}</span></div></li>
			%end 
			</ul>
		</dd>
	</dl>
	</div>
	
</div>
<div class="row" id="div_display_ctrl">
	<div class="col-md-8 col-md-offset-2" >
		<ul id="tab_dispaly" class="nav nav-tabs dropdown-hover">
		   <li class="active"><a href="#" data-toggle="tab">匹配度</a></li>
		   <li><a href="#" data-toggle="tab">人气</a></li>
		   <li><a href="#" data-toggle="tab">活跃度</a></li>
		    <li><a class="up" href="#" data-toggle="tab">收入</a></li>
		   <li class="dropdown">
		      <a href="#" class="dropdown-toggle" data-toggle="dropdown">年龄
			 <b class="caret"></b>
		      </a>
		      <ul class="dropdown-menu" role="menu">
			 <li><a href="#" class="up" tabindex="-1" data-toggle="tab">按年龄<strong>由小到大</strong>排序</a></li>
			 <li><a href="#" tabindex="-1" data-toggle="tab">按年龄<strong>由大到小</strong>排序</a></li>
		      </ul>
		   </li>
		   <li class="dropdown">
		      <a href="#" class="dropdown-toggle" data-toggle="dropdown">身高 
			 <b class="caret"></b>
		      </a>
		      <ul class="dropdown-menu" role="menu">
			 <li><a href="#" tabindex="-1" data-toggle="tab">按身高<strong>由高到低</strong>排序</a></li>
			 <li><a href="#" class="up" tabindex="-1" data-toggle="tab">按身高<strong>由低到高</strong>排序</a></li>
		      </ul>
		   </li>
		   <div>
			<p class="navbar-text navbar-center">共<strong>99</strong>人</p>
		    </div>
		   
		    <form class="navbar-form navbar-right" style="margin-right: 0px;padding-right: 0px;">
			<div class="btn-group btn-group-sm">
				<button class="btn btn-default"><i class="icon-list"></i> 列表显示</button>
				<button class="btn btn-default"><i class="icon-show-thumbnails"></i>小图 </button>
				<button class="btn btn-default"><i class="icon-show-big-thumbnails"></i>大图 </button>
			</div>
		    </form>
		    </ul>
	</div>
</div>

<div class="div_arrange_list">
%for i in range(10):
<div class="row">
	<div>
		<div class="search_item_css panel2_css" >
			<div class="search_item_img_css">
				<img src="/res/test/a (4).jpg" class="hot_tag" style="display: block">
				<small>&nbsp;&nbsp;<i class="icon-parents"></i> 在线
				&nbsp;&nbsp;
				<i class="icon-skitch"></i> 好友</small>
			</div>		
			<div class="search_item_detail_css">
				<h4 title="姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚">姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚</h4>
				<div class="badge_css">
					<i class="icon-iphone" title="手机认证"></i>&nbsp;<i class="icon-nameplate" title="身份认证"></i>&nbsp;
					<i class="icon-camera" title="相片认证"></i>&nbsp;<i class="icon-car" title="有车认证"></i>&nbsp;
					<i class="icon-temple-christianity-church" title="有房认证"></i>
				</div>
				<p class="detail_css"><small>
					广东 广州 | 21岁 | 178厘米 | 50公斤
				</small></p>
				<p class="detail_css"><small>
					<i class="icon-eye-open"></i>1000次 | <i class="icon-heart"></i>21人 | <i class="icon-picture"></i>11张
				</small></p>
				<div class="search_item_score_css">
					<small>
					长相:<span class="star_readonly" star="2"></span><BR/>
					身材:<span class="star_readonly" star="3"></span><BR/>
					性格:<span class="star_readonly" star="1"></span><BR/>
					态度:<span class="star_readonly" star="5"></span><BR/>
					</small>
				</div>
			</div>
		</div>
	</div>
</div>
%end
</div>
%if is_test:
<script type="text/javascript">
     QUnit.module("search");
     QUnit.config.reorder = false;
     
     QUnit.test("breadcrumb",function(assert){
	expect(1);
	assert.equal(get_breadcrumb(),"主页/查找");
     });
     
     QUnit.test("order_mark",function(assert){
	expect(1);
	//assert.equal(get_breadcrumb(),"主页/查找");
     });
     
     QUnit.asyncTest("hide_condition_panel",function(assert){
	expect(5);
	assert.ok($("#link_hide_cond").is(":visible"));
	assert.ok(!$("#link_show_cond").is(":visible"));
	$("#link_hide_cond").click();
	setTimeout(function() {
		assert.ok($("#link_show_cond").is(":visible"));
		assert.ok(!$("#link_hide_cond").is(":visible"));
		assert.equal($("#div_search_cond dl").children(":visible").length,2);
		QUnit.start();
	}, 300);
     });
     
     QUnit.asyncTest("show_condition_panel",function(assert){
	expect(5);
	assert.ok(!$("#link_hide_cond").is(":visible"));
	assert.ok($("#link_show_cond").is(":visible"));
	$("#link_show_cond").click();
	setTimeout(function() {
		assert.ok(!$("#link_show_cond").is(":visible"));
		assert.ok($("#link_hide_cond").is(":visible"));
		assert.ok($("#div_search_cond dl").children().length > 8);
		QUnit.start();
	}, 300);
	
	
     });
</script>
%end     
 {{!page_foot}}	    
</body>
</html>