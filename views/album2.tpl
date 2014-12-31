<style type="text/css">
.div_likeit a{
	text-decoration: none;
	cursor: pointer;
}
 
/*   �����Ǿɵ�   */

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
	//չ������ظ���ť
	function link_show_reply(item)
	{
		var c = item.parents(".div_album_detail").find(".div_reply_container");
		var i = c.find(".div_reply_one_container").length;
		if (c.hasClass("reply_expand")) {
			if (i==0) {
				//û�лظ�����ֱ����ʾ�ظ��� 
				item.text("�ظ�");
				c.find(".div_reply_more").hide();
			}
			else
			{
				c.find(".div_reply_more").show();
				item.text("�ظ�(" +i+")");				
			}
		}
		else
		{
			if (i == 0) {
				c.find(".div_reply_more").hide();
			}
			item.text("����ظ�");	
		}
		
		c.fadeToggle();
		c.toggleClass("reply_expand");
	}
	
	//��ʾ���еĻظ�
	function show_all_reply(item) {
		var c = item.parents(".div_reply_container");
		c.addClass("show_all");
		c.find(".div_reply_one_container").show();
		c.find(".div_reply_more").hide();
	}
	
	//�Զ��ղض���Ļظ� 
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
				//���û�лظ���Ŀ��������ظ� 
 				$(this).parent().find(".link_show_reply").click();
 			}
		});
	}
	 
	//�������°�ť
	function like_it(item){
		var t = item.parent().parent().find(".text_likeit_num");
		t.text("" + (parseInt(t.text()) + 1));
		item.html("����");
		item.removeAttr("onclick");
		item.removeClass("link_span");
	}
	
	//��ʾ����Ļظ��Ի���
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
			<li><span class="checkbox_ctrl">ȫ��<span class="badge">10</span></span></li>
			<li><span class="checkbox_ctrl">������־<span class="badge">10</span></span></li>
			<li><span class="checkbox_ctrl">�ҵ���־<span class="badge">10</span></span></li>
			<li><span class="checkbox_ctrl">����<span class="badge">10</span></span></li>
			<li><span class="checkbox_ctrl">ϵͳ<span class="badge">10</span></span></li>
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
				<strong>����ů</strong>
				<i class="icon-heart"></i><span class="text_like_num">221</span>ϲ��&nbsp;&nbsp;|
				<div class="div_likeit">
					<a>ϲ��</a>
					<div class=" btn-group dropdown-hover" style="float:right">
						<a  class="dropdown-toggle"  data-toggle="dropdown">
						   ��ϲ��
						</a>
						<ul class="dropdown-menu" role="menu">
						   <li><a href="#" onclick="click_dislike_it($(this))">���ϲ��</a></li>
						   <li><a href="#" onclick="click_dislike_it($(this))">PS�ۼ�����</a></li>
						   <li><a href="#" onclick="click_dislike_it($(this))">�о�����</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div> <!-- col div -->
			<div class="div_album_detail">
				<div class="div_arrow"></div>
				<strong>����ů</strong> ������һƪ��־  <span>2013-7-21&nbsp;10:35</span>
				
				<div class="small1" style="float:right;color:gray">
					����|21��|178cm|��ר|
					<i class="icon-picture">��Ƭ(5)</i>|
					<i class="icon-eye-open">���(58)</i>
				</div>
				<HR>
				<div class="div_album_detail_text">
					�����ƣ�������Դ����һ��һ�ȵġ�������Դչ����������Ԥ�⣬ȫ����Դ����2040�꽫����37%����ȥ���ÿ��9000��Ͱ��������ÿ��1��400��Ͱ����������ů�������ܵ���ע����ʯ��ȼ���Խ�����Ҫ����Դ��Դ��
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
						<li><img class="thumbnail_profile" src="res/test/a (1).jpg" title="ҦҦ"></img></li>
						%end
						<li style="vertical-align: bottom" class="small">
							��<span class="text_likeit_num">40</span>���˵�����
						</li>
					</ul>
					<div class="div_show_reply in_block">
						<span class="link_span" style="margin-right: 10px" onclick="like_it($(this))">����</span>|
						<span class="link_span link_show_reply" onclick="link_show_reply($(this))" >����ظ�</span>
					</div>
				</div>
				<div class="div_reply_container reply_expand">
					%for a in range(0):
					<div class="div_reply_one_container">
						<div class="div_reply_user">
							<img class="thumbnail_profile" src="res/test/a (1).jpg"></img>
						</div>
						<div class="div_reply_content">
							<strong>ĳĳ</strong>�ظ�<strong>ĳĳ</strong>��	
								�ż̿��м���Ƚ�ͻ���ļ���ֵ��ѧϰ�� </dd>
							<div style="width:100%">
								<div class="div_reply_ctrl small" style="float:right;margin-top:10px">
									<div class="dropdown small in_block">
									   <a href="#" class="dropdown-toggle icon-bell" data-toggle="dropdown">
									      �ٱ�
									      <span class="caret"></span>
									   </a>
									   <ul class="dropdown-menu" role="menu">
										<li><a role="menuitem" tabindex="-1" href="#">���˹���</a></li>
										<li><a role="menuitem" tabindex="-1" href="#">���˹���</a></li>
										<li><a role="menuitem" tabindex="-1" href="#">���˹���</a></li>
									   </ul>
									</div>
									<span>2013-7-21&nbsp;10:35</span>&nbsp;
									<span class="link_span" >�ظ�</span>
								</div>
							</div>			
						</div>
						<HR>
					</div>
					%end
					<div  class="in_block div_reply_more text-center" style="height:25px;width: 100%;margin-bottom: 15px">
						����<span class="text_reply_count">5</span>���ظ���<span class="link_span" onclick="show_all_reply($(this))">�����鿴</span>
					</div>
					<div class="div_reply_edit" style="padding-bottom: 20px" >
						<textarea class="form-control" rows="1" onfocus="show_edit_ctrl($(this));" onblur="hide_edit_ctrl($(this));" placeholder="��Ҳ˵һ��"></textarea>
						<button class="btn btn-primary in_block btn-sm icon-comments" style="display: none;margin-top: 10px;padding: 4px 10px 4px 10px;float:right">
							����
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	%end
</div>

