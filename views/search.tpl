<!DOCTYPE HTML>
<html>
<head>
	{{!web_head}}
</head>
<body>
{{!page_head}}
%import random

<style type="text/css">
</style>
<script type="text/javascript">
	function set_like_it_btn(btn){
		btn.html("<i class='icon-heart' style='color:#FF60AF'></i><span class='sm_hide'>喜欢</span>");
		btn.removeAttr("cancel");
	}
	
	function set_dislike_it_btn(btn){
		btn.html("<i class='icon-heart' style='color:black'></i><span class='sm_hide'>取消喜欢</span>");
		btn.attr("cancel","true"); 
	}	
		
	function click_like_it(btn)
	{	//按喜欢的动态效果，只能写到html里，不能用jquery事件
		function update_like_it(isIncrease)
		{//TODO:远程调用未完成 
		}
		
		btn.attr("disabled","disabled");
		var src = btn.find("i");
		var n = btn.parent().find(".text_like_num");
		var showValue = !$("#div_search_result").hasClass("search_display_list");
		var isIncrease = btn.attr("cancel")!="true";
		$("#add_heart,#del_heart").hide();
		var t;
		if (isIncrease) {
			t = $("#add_heart");
			if (showValue) {
				t.text(n.text() + "人喜欢 +1");
			}
		}
		else{
			t = $("#del_heart");
			if (showValue) {
				t.text(n.text() + "人喜欢 -1");
			}
		}
		if (showValue) {
			t.css("border","1px solid white");
		}
		else{
			t.css("border","transparent");
		}
		t.show();
		t.css({top: src.offset().top,left:src.offset().left,opacity:1});
		t.animate({top:t.offset().top-30,
			  opacity:0},
			  1200,function(){
				if (isIncrease) {
					t.hide(100);
					n.text(parseInt(n.text()) + 1);
					set_dislike_it_btn(btn);
				}else{
					n.text(parseInt(n.text()) - 1);
					set_like_it_btn(btn);
				}
				update_like_it(isIncrease);
				btn.removeAttr("disabled");
			});
	}
	
	function click_dislike_it(btn)
	{	//按不喜欢的动态效果，只能写到html里，不能用jquery事件
		var r = btn.parents(".col");
		r.fadeOut(800,function(){
			r.remove()
			$("#div_display_ctrl .active").click();
		});
	}
	
	$(document).ready(function(){
		//show and hide condition panel
		function hideSearchPanel(timeout){
			if (timeout == null) timeout = 500;
			$("#dt_cond_area").nextAll().fadeOut(timeout);
			$("#link_hide_cond").hide();
			$("#link_show_cond").show();
		}
		
		function showSearchPanel(timeout){
			if (timeout == null) timeout = 500;
			$("#dt_cond_area").nextAll().fadeIn(timeout);
			$("#link_show_cond").hide();
			$("#link_hide_cond").show();
		}
		
		$("#link_hide_cond").click(hideSearchPanel);
		$("#link_show_cond").click(showSearchPanel);
		hideSearchPanel(0);
				
		//设置排序指示图标
		function add_order_mark(elem)
		{
			if (elem.find(".order_mark").length) {
				return;
			}
			if (elem.hasClass("up")) {
				elem.append("<i class='icon-up-arrow order_mark'></i>");
			}
			else
			{
				elem.append("<i class='icon-down-arrow order_mark'></i>");	
			}
			elem.addClass("active");
		}
		
		$("#div_display_order .btn,#div_display_order li>a").click(function(){
			if ($(this).hasClass("dropdown-toggle")) {
				return;
			}
			$("#div_display_order .order_mark").remove();
			$("#div_display_order .active").removeClass("active");
			$("#div_display_order .caret").show();
			//find dropdown-toggle link
			var p = $(this).parent().parent().prev();
			if (p.length) {
				if ($(this).hasClass("up")) {
					p.addClass("up");
				}
				else
				{
					p.removeClass("up");
				}
				add_order_mark(p);
				p.find(".caret").hide()
			}
			add_order_mark($(this));
		});
		add_order_mark($("#div_display_order .active"));
		$("#div_display_order .btn").height(20);//加了icon后，高度会变形
		$("#div_display_order .btn").width(50);
		
		//初始化喜欢效果 
		$("#add_heart").hide();
		$("#del_heart").hide();

		set_like_it_btn($(".btn_like_it"));
			
		//列表显示切换效果
		$("#div_display_ctrl > button").click(function(){
			$(this).siblings().removeClass("active");
			$(this).addClass("active");
			
			var container = $("#div_search_result");
			var info = container.find(".div_profile");
			var match = container.find(".div_match");
			var btns = container.find(".div_btn");
			assert(info.length == match.length,"html格式错误");
			assert(btns.length == match.length,"html格式错误2");
			container.empty();
			
			function addContainer(elem,columnCount){
				var r = container.children(".row:last");
				var isFirst=false;
				if (r.length == 0 || r.children(".col").length == columnCount) {
					r = $("<div class='row top_row'></div>");
					container.append(r);
					isFirst = true;
				}
				var c = $("<div class='col col-md-" + 8/columnCount + "'></div>");
				if (isFirst) {
					c.addClass("col-md-offset-2");
				}
				c.append(elem);
				r.append(c);
			}
			
			var id = $(this).attr("id");
			if (id == "btn_display_list") {
				container.removeClass("search_display_sm");
				container.removeClass("search_display_lg");
				container.addClass("search_display_list");
				btns.find(".div_space").addClass("visible-md visible-lg");
				btns.find(".text_like").addClass("visible-md visible-lg");
				btns.find("button").removeClass("btn-xs");
				for(var i=0;i<info.length;i++){
					r = $("<div class='row list_item'></>");
					var c1 = $("<div class='col-md-6' style='padding-left: 10px;padding-top: 10px'>")
					var c2 = $("<div class='col-md-4'></div>");
					var c3 = $("<div class='col-md-2'></div>");
					c1.append(info[i]);
					c2.append(match[i]);
					c3.append(btns[i]);
					r.append(c1);
					r.append(c2);
					r.append(c3);
					addContainer(r,1);
				}
			}
			else if (id == "btn_display_sm") {
				container.removeClass("search_display_lg search_display_list");
				container.addClass("search_display_sm");
				btns.find("button").addClass("btn-xs");
				btns.find(".div_space").removeClass("visible-md visible-lg");
				btns.find(".text_like").removeClass("visible-md visible-lg");
	 
				for(var i=0;i<info.length;i++){
					c = $("<div class='sm_item'></>");
					c.append(info[i]);
					c.append(btns[i]);
					c.append(match[i]);
					addContainer(c,4);
				}
			}
			else if (id == "btn_display_lg") {
				container.removeClass("search_display_sm search_display_list");
				container.addClass("search_display_lg");
				btns.find("button").removeClass("btn-xs");
				btns.find(".div_space").addClass("visible-md visible-lg");
				btns.find(".text_like").removeClass("visible-md visible-lg");
				
				for(var i=0;i<info.length;i++){
					c = $("<div class='lg_item'></>");
					c.append(info[i]);
					c.append(btns[i]);
					c.append(match[i]);
					addContainer(c,2);
				}
			} 
			init_common();
		});
	});
</script>
<p id="add_heart" class="icon-heart" style="position: absolute;color:red;z-index:100;display: none"> +1</p>
<p id="del_heart" class="icon-heart" style="position: absolute;color:black;z-index:100;display: none"> -1</p>
<div class="row">
	<div id="div_search_cond" class="col-md-8 col-md-offset-2">
	<dl class="dl-horizontal" style="margin: 0 0 0 0;padding-top: 10px">
		<dt>地区</dt>
		<dd  id="dt_cond_area">
			<ul class="list-inline">
			<li><a href="#">广东<span class="badge">111</span></a></li>
			%for i in range(1):
				<li>广州<span class="badge">1</span></li>
			%end
			<li>切换城市</li>
			<li style="float: right">
				<button id="link_hide_cond" class="btn btn-link"><i class="icon-collapse-top"></i>折叠</button>
			</li>
			<li style="float: right">
				共有<strong>99</strong>位女士
				<button id="link_show_cond" class="btn btn-link"><i class="icon-expand"></i>更多</button>
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
			<ul class="list-inline tag_readOnly">
			%for t in c_tag:
				<li>{{t[1]}}<span class="badge">{{random.randint(1,300)}}</span></li>
			%end 
			</ul>
		</dd>
	</dl>
	</div>
	
</div>
<div class="row" id="div_display_ctrl">
	<div class="col-md-8 col-md-offset-2" >
		<div id="div_display_order" class="btn-group">
			<button class="btn btn-default active btn-sm">匹配度</button>
			<button class="btn btn-default btn-sm">人气 </button>
			<button class="btn btn-default btn-sm">收入</button>
			<div class="btn-group btn-group-sm dropdown-hover">
				<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				  年龄
				  <span class="caret"></span>
				</button>
				<ul class="dropdown-menu" role="menu">
				  <li><a href="#" class="up">按年龄<strong>由小到大</strong>排序</a></li>
				  <li><a href="#">按年龄<strong>由大到小</strong>排序</a></li>
				</ul>
			</div>
			<div class="btn-group btn-group-sm dropdown-hover">
				<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				  身高
				  <span class="caret"></span>
				</button>
				<ul class="dropdown-menu" role="menu">
				   <li><a href="#">按身高<strong>由高到低</strong>排序</a></li>
				   <li><a href="#" class="up">按身高<strong>由低到高</strong>排序</a></li>
				</ul>
			</div>
		</div>
		
		<div id="div_display_ctrl" class="btn-group btn-group-sm navbar-right">
			<button id="btn_display_list" class="btn btn-default active"><i class="icon-list"></i> 列表显示</button>
			<button id="btn_display_sm" class="btn btn-default"><i class="icon-show-thumbnails"></i>小图 </button>
			<button id="btn_display_lg" class="btn btn-default"><i class="icon-show-big-thumbnails"></i>大图 </button>
		</div>
	</div>
</div>

<div id="div_search_result" class="search_display_list">
%for i in range(50):
<div class="row top_row "> 
	<div class="col col-md-8 col-md-offset-2" >
		<div class="row list_item">
			<div class="col-md-6" style="padding-left: 10px;padding-top: 10px">
				<div class="div_profile">
					<div class="div_profile_img in_block"">
						<img src="/res/test/a ({{i%10+1}}).jpg">
						<div class="sm_hide lg_hide">
							<small>
								<i class="icon-eye-open"></i><span class="num_format">1022</span>次 |
								<i class="icon-picture"></i><span class="num_format">11022</span>张
							</small>
						</div>
					</div>		
					<div class="div_profile_text in_block">
						<div class="in_block text_nickname">
							<p title="姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚">姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚end</p>
						</div>
						<div class="in_block sm_hide lg_hide" style="margin-left:6px">
							<i class="icon-iphone" title="手机认证"></i>&nbsp;
							<i class="icon-nameplate" title="身份认证"></i>&nbsp;
							<i class="icon-camera" title="相片认证"></i>&nbsp;
							<i class="icon-car" title="有车认证"></i>&nbsp;
							<i class="icon-temple-christianity-church" title="有房认证"></i>
						</div>
						<p class="text_profile_info1">
							<strong class="sm_hide">广东广州 | </strong><strong>21岁 | 178cm | 50kg</strong>
							
						</p>
						<p class="small sm_hide">
						 本科 | 10k-15k | 租房 | 有车
						</p>
						<div class="sm_hide lg_hide small in_block">
							长相:<span class="star_readonly" star="2"></span> 英俊潇洒<BR/>
							身材:<span class="star_readonly" star="3"></span> 英俊潇洒<BR/>
							性格:<span class="star_readonly" star="1"></span> 英俊潇洒<BR/>
							爱情:<span class="star_readonly" star="5"></span> 英俊潇洒<BR/>
						</div>
						<div class="small sm_hide lg_hide">
							<ul class="list-inline tag_readOnly" style="margin-top: 6px;margin-bottom: 0px;">
								<li>专情</li>
								<li>浪漫</li>
								<li>随缘外表</li>
								<li>无所</li>
								<li>无所外表</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="div_match sm_hide lg_hide">
					<span class="match_num">匹配度:<H1 class="in_block">30%</H1></span>
					<BR>
					寻找广东广州21~30岁的男生
				</div>	
			</div>
			<div class="col-md-2" >
				<div class="div_btn">
					<div class="visible-md visible-lg div_space sm_hide lg_hide" style="width:10px;height: 10px"></div>
					<p class="text_like text-center  sm_hide lg_hide visible-md visible-lg" ><span class="text_like_num">221256</span>人喜欢<i class="icon-heart"></i></p>
					<button class="btn btn-primary btn_send_msg">
						<i class="icon-envelope"></i><span class="sm_hide">发信息</span>
					</button>
					
					<button class="btn btn-success btn_like_it" onclick="click_like_it($(this))">
						<!--i class="icon-heart-empty"></i>喜欢-->
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
%end
</div>	
%if is_test:
<span id="span_test"></span>
<script type="text/javascript">
     QUnit.module("search");
     QUnit.config.reorder = false;
     
     QUnit.test("breadcrumb",function(assert){
	expect(1);
	assert.equal(get_breadcrumb(),"主页/查找");
     });
     
     QUnit.test("num_format",function(assert){
	expect(7);
	$("#span_test").text("951");
	num_format($("#span_test"));
	assert.equal($("#span_test").text(),"951");
	
	$("#span_test").text("951013");
	num_format($("#span_test"));
	assert.equal($("#span_test").text(),"95万");
	
	$("#span_test").text("1236951013");
	num_format($("#span_test"));
	assert.equal($("#span_test").text(),"123695万");
	
	$("#span_test").text("9510");
	num_format($("#span_test"));
	assert.equal($("#span_test").text(),"9千");
	
	$("#span_test").text("9510a");
	num_format($("#span_test"));
	assert.equal($("#span_test").text(),"9510a");
	
	$("#span_test").text("aad");
	num_format($("#span_test"));
	assert.equal($("#span_test").text(),"aad");
	
	$("#span_test").text("0");
	num_format($("#span_test"));
	assert.equal($("#span_test").text(),"0");
	$("#span_test").hide();
     });
      
     QUnit.asyncTest("hide_condition_panel",function(assert){
	expect(5);
	assert.ok(!$("#link_hide_cond").is(":visible"));
	assert.ok($("#link_show_cond").is(":visible"));
	$("#link_hide_cond").click();
	setTimeout(function() {
		assert.ok($("#link_show_cond").is(":visible"));
		assert.ok(!$("#link_hide_cond").is(":visible"));
		assert.equal($("#div_search_cond dl").children(":visible").length,2);
		QUnit.start();
	}, 500);
     });
     
     QUnit.asyncTest("show_condition_panel",function(assert){
	expect(3); 
	$("#link_show_cond").click();
	setTimeout(function() {
		assert.ok(!$("#link_show_cond").is(":visible"));
		assert.ok($("#link_hide_cond").is(":visible"));
		assert.ok($("#div_search_cond dl").children().length > 8);
		QUnit.start();
	}, 300);
	
     QUnit.asyncTest("like_it1",function(assert){
	//TODO:还需要加上后台互动
	expect(4);
	var a = $($(".btn_like_it")[2]);
	assert.ok(a.text().indexOf("喜欢")!=-1);
	assert.ok(a.text().indexOf("取消喜欢")==-1);
	var count = parseInt(a.parent().find(".text_like_num").text());
	a.click();
	setTimeout(function() {
		assert.equal(parseInt(a.parent().find(".text_like_num").text()),count+1);
		assert.ok(a.text().indexOf("取消喜欢")!=-1); 
		QUnit.start();
	}, 1000);
     });
     
     QUnit.asyncTest("like_it2",function(assert){
	//TODO:还需要加上后台互动
	expect(4);
	var a = $($(".btn_like_it")[2]);
	assert.ok(a.text().indexOf("取消喜欢")!=-1);
	var count = parseInt(a.parent().find(".text_like_num").text());
	a.click();
	setTimeout(function() {
		assert.equal(parseInt(a.parent().find(".text_like_num").text()),count-1);
		assert.ok(a.text().indexOf("取消喜欢")==-1);
		assert.ok(a.text().indexOf("喜欢")!=-1); 
		QUnit.start();
	}, 1000);
     });
     
     QUnit.asyncTest("dislike_it",function(assert){
	expect(2);
	//TODO:还需要加上后台互动 
	var a = $(".btn_dislike_it .dropdown-menu li>a")[2];
	var len = $(".top_row").length;
	a.click();
	var p = $(a).parents(".top_row:visible");
	setTimeout(function() {
		assert.equal(len-1,$(".top_row:visible").length); 
		assert.ok(!p.is("visible"));
		QUnit.start();
	}, 1000);
     });
     });
</script>
%end     
 {{!page_foot}}	    
</body>
</html>