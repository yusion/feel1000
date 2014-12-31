<style type="text/css">
.div_likeit a{
	text-decoration: none;
	cursor: pointer;
}
 
/*   下面是旧的   */

.div_album_reply{
	margin-left: 40px;
	background-color:lightgray;
}

.div_album_reply >div{
	margin-bottom: 10px;
}


.link_show_reply{
	padding: 10px 10px 0px 10px;
	margin-right: 10px;
}

.div_show_reply{
	width:auto;
	margin-top: 33px;
	float:right;
	vertical-align: bottom;
}

.div_album_title{
	height: 30px;
	width:100%;
	padding: 10px 10px 10px 10px;
	margin-top: 24px; 
}
 
</style>
<script type="text/javascript">
	//展开收起回复按钮
	function link_show_reply(item)
	{
		var c = item.parents(".div_album_detail").find(".div_reply_container");
		var i = c.find(".div_reply_one_container").length;
		if (c.hasClass("reply_expand")) {
			if (i==0) {
				//没有回复，则直接显示回复框 
				item.text("回复");
				c.find(".div_reply_more").hide();
			}
			else
			{
				c.find(".div_reply_more").show();
				item.text("回复(" +i+")");				
			}
		}
		else
		{
			if (i == 0) {
				c.find(".div_reply_more").hide();
			}
			item.text("收起回复");	
		}
		
		c.fadeToggle();
		c.toggleClass("reply_expand");
	}
	
	//显示所有的回复
	function show_all_reply(item) {
		var c = item.parents(".div_reply_container");
		c.addClass("show_all");
		c.find(".div_reply_one_container").show();
		c.find(".div_reply_more").hide();
	}
	
	//自动收藏多余的回复 
	function hide_more_reply(container,num){
		container.each(function(){
			if($(this).hasClass("show_all"))
			{
				c.find(".div_more_reply").hide();
				return 0;
			}
			
			var c = $(this).find(".div_reply_one_container");
			var r = 0;
			
			for(var i=num;i<c.length;i++)
			{
				c.eq(i).hide();
				r++;
			}
			$(this).parent().find(".text_reply_count").text(""+r);
			
			if (c.length == 0) {
				//如果没有回复条目，就收起回复 
 				$(this).parent().find(".link_show_reply").click();
 			}
		});
	}
	 
	//点赞文章按钮
	function like_it(item){
		var t = item.parent().parent().find(".text_likeit_num");
		t.text("" + (parseInt(t.text()) + 1));
		item.html("已赞");
		item.removeAttr("onclick");
		item.removeClass("link_span");
	}
	
	//显示扩大的回复对话框
	function show_edit_ctrl(item){//;" onblur="hide_edit_ctrl($(this));"
		item.attr("rows","3");
		item.nextAll().show();
		item.parent().css("padding-bottom","50px");
	}
	
	function hide_edit_ctrl(item){
		item.attr("rows","1");
		item.nextAll().hide();
		item.parent().css("padding-bottom","20px");
	}
	
	$(document).ready(function(e){
		$(".div_album_user").parent().addClass("col-md-2");
		$(".div_album_detail").parent().addClass("col-md-10");
		
		$(".dropdown-menu li").addClass("small");
		hide_more_reply($(".div_reply_container"),5);
	});

	
</script>
%if not show_all:
<div class="row" style="margin-bottom: 0px"> 
	<div class="col-md-10 col-md-offset-2">
		<ul class="list-inline" style="margin-top: 10px;margin-bottom: 10px">
			<li><span class="checkbox_ctrl">全部<span class="badge">10</span></span></li>
			<li><span class="checkbox_ctrl">好友日志<span class="badge">10</span></span></li>
			<li><span class="checkbox_ctrl">我的日志<span class="badge">10</span></span></li>
			<li><span class="checkbox_ctrl">留言<span class="badge">10</span></span></li>
			<li><span class="checkbox_ctrl">系统<span class="badge">10</span></span></li>
		</ul>
	</div>
</div>
<div class="row" style="background-color:#efeff1;margin: 0px 0px 0px 0px" >
	<div style="height: 15px" class="col-md-10 col-md-offset-2">
	</div>
</div>		
%end
<div id="div_album_container">
	%import random
	%for i in range(5):
	%if i %2 == 0:
	%	onlineState="online"
	%else:
	%	onlineState="phone_online"
	%end
	%onlineState="offline"
	<div class="row">
		<div> <!-- col div -->
			<div class="div_album_user">
				<img src="res/test/a (7).jpg" class="img_profile_sm {{onlineState}}"></img>
				<strong>气候暖</strong>
				<i class="icon-heart"></i><span class="text_like_num">221</span>喜欢&nbsp;&nbsp;|
				<div class="div_likeit">
					<a>喜欢</a>
					<div class=" btn-group dropdown-hover" style="float:right">
						<a  class="dropdown-toggle"  data-toggle="dropdown">
						   不喜欢
						</a>
						<ul class="dropdown-menu" role="menu">
						   <li><a href="#" onclick="click_dislike_it($(this))">外表不喜欢</a></li>
						   <li><a href="#" onclick="click_dislike_it($(this))">PS痕迹严重</a></li>
						   <li><a href="#" onclick="click_dislike_it($(this))">感觉不好</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div> <!-- col div -->
			<div class="div_album_detail">
				<div class="div_arrow"></div>
				<strong>气候暖</strong> 发表了一篇日志  <span>2013-7-21&nbsp;10:35</span>
				
				<div class="small1" style="float:right;color:gray">
					广州|21岁|178cm|大专|
					<i class="icon-picture">相片(5)</i>|
					<i class="icon-eye-open">浏览(58)</i>
				</div>
				<HR>
				<div class="div_album_detail_text">
					报道称，国际能源署在一年一度的《世界能源展望》报告中预测，全球能源需求到2040年将增长37%，从去年的每天9000万桶，上升至每天1亿400万桶。尽管气候暖化问题受到关注，但石化燃料仍将是主要的能源来源。
				</div>
				<div class="div_album_detail_img" style="">
					%ll = random.randint(1,8)
					%for k in range(ll):
						<img src="res/test/a ({{random.randint(1,15)}}).jpg"></img>
					%end					
				</div>
				<div sytle="width:100%">
					<ul class="list-inline likeit_list in_block" style="width:80%">
						%for m in range(5):
						<li><img class="thumbnail_profile" src="res/test/a (1).jpg" title="姚姚"></img></li>
						%end
						<li style="vertical-align: bottom" class="small">
							等<span class="text_likeit_num">40</span>个人点了赞
						</li>
					</ul>
					<div class="div_show_reply in_block">
						<span class="link_span" style="margin-right: 10px" onclick="like_it($(this))">点赞</span>|
						<span class="link_span link_show_reply" onclick="link_show_reply($(this))" >收起回复</span>
					</div>
				</div>
				<div class="div_reply_container reply_expand">
					%for a in range(0):
					<div class="div_reply_one_container">
						<div class="div_reply_user">
							<img class="thumbnail_profile" src="res/test/a (1).jpg"></img>
						</div>
						<div class="div_reply_content">
							<strong>某某</strong>回复<strong>某某</strong>：	
								张继科有几项比较突出的技术值的学习： </dd>
							<div style="width:100%">
								<div class="div_reply_ctrl small" style="float:right;margin-top:10px">
									<div class="dropdown small in_block">
									   <a href="#" class="dropdown-toggle icon-bell" data-toggle="dropdown">
									      举报
									      <span class="caret"></span>
									   </a>
									   <ul class="dropdown-menu" role="menu">
										<li><a role="menuitem" tabindex="-1" href="#">个人攻击</a></li>
										<li><a role="menuitem" tabindex="-1" href="#">个人攻击</a></li>
										<li><a role="menuitem" tabindex="-1" href="#">个人攻击</a></li>
									   </ul>
									</div>
									<span>2013-7-21&nbsp;10:35</span>&nbsp;
									<span class="link_span" >回复</span>
								</div>
							</div>			
						</div>
						<HR>
					</div>
					%end
					<div  class="in_block div_reply_more text-center" style="height:25px;width: 100%;margin-bottom: 15px">
						还有<span class="text_reply_count">5</span>条回复，<span class="link_span" onclick="show_all_reply($(this))">请点击查看</span>
					</div>
					<div class="div_reply_edit" style="padding-bottom: 20px" >
						<textarea class="form-control" rows="1" onfocus="show_edit_ctrl($(this));" onblur="hide_edit_ctrl($(this));" placeholder="我也说一句"></textarea>
						<button class="btn btn-primary in_block btn-sm icon-comments" style="display: none;margin-top: 10px;padding: 4px 10px 4px 10px;float:right">
							发表
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	%end
</div>

