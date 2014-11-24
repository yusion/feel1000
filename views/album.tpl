<style type="text/css">


.div_album_info .div_album_detail{
	background-color: #f8f8f8;
	
}

.div_album_reply{
	margin-left: 40px;
	background-color:lightgray;
}

.div_album_reply >div{
	margin-bottom: 10px;
}

</style>
<script type="text/javascript">
	$(document).ready(function(e){
		$(".div_album_user").parent().addClass("col-md-2");
		$(".div_album_detail").parent().addClass("col-md-10");
		//$("#div_album_container HR").addClass("visible-xs visible-sm");
		
	});
</script>
<div id="div_album_container">
	%import random
	%for i in range(5):
	%if i %2 == 0:
	%	onlineState="online"
	%else:
	%	onlineState="phone_online"
	%end
	<div class="row">
		<div>
			<div class="div_album_user">
				<img src="res/test/a (7).jpg" class="img_profile_sm {{onlineState}}"></img>
				<H4 class="in_block"><small>2014/9/</small>25 2小时前</H4> 
				<button class="btn icon-heart btn-success"> 点赞</button>
				<button class="btn btn-primary icon-comments"> 回复</button>
			</div>
		</div>
		<div>
			<div class="div_album_detail">
				<div class="div_album_detail_img" style="">
					%ll = random.randint(1,10)
					%for k in range(ll):
						<img src="res/test/a ({{random.randint(1,15)}}).jpg"></img>
					%end					
				</div>
				<div class="div_album_detail_text">
					报道称，国际能源署在一年一度的《世界能源展望》报告中预测，全球能源需求到2040年将增长37%，从去年的每天9000万桶，上升至每天1亿400万桶。尽管气候暖化问题受到关注，但石化燃料仍将是主要的能源来源。
				</div>
				<ul class="list-inline likeit_list">
					%for m in range(5):
					<li><img class="thumbnail_profile" src="res/test/a (1).jpg" title="姚姚"></img></li>
					%end
					<small style="vertical-align: bottom">等40个人点了赞</small>
					<a href="#">收起回复|共有10条回复</a>
				</ul> 					
				<div class="div_reply_container">
					%for a in range(2):
					<div class="div_reply_user">
						<img class="thumbnail_profile" src="res/test/a (1).jpg"></img>
					</div>
					<div class="div_reply_content">
						<strong>某某</strong>回复<strong>某某</strong>：	
							张继科有几项比较突出的技术值的学习： </dd>
						<div style="width:100%">
							<div class="div_reply_ctrl" style="float:right;margin-top:10px">
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
								<a href="#">回复</a>
							</div>
						</div>			
					</div>
					<HR>
					%end
					<div style="height:25px;width: 100%;margin-bottom: 20px" class="in_block">
						<div class="text-center in_block" style="width: 80%">
							还有5条回复，<a href="#">请点击查看</a>
						</div>
						<button class="btn in_block btn-sm" style="float:right;padding: 2px 6px 2px 6px">
							<i class="icon-comments " style="color:lightblue;"></i> 我也说一句
						</button>
					</div>
					<div style="height:100px">
						<textarea class="form-control" rows="3"></textarea>
						<button class="btn btn-primary btn-sm" style="margin-top: 10px;padding: 2px 6px 2px 6px;float:right">
							发表
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<HR>
	%end
</div>

