<style type="text/css">
#div_album_container{
	background-color: white;
}

#div_album_container HR{
	width: 90%;
}

#div_album_container .row{
	margin-bottom: 35px;
}

#div_album_container button{
	width: 80px;
}

.div_album_info .div_album_detail{
	background-color: #f8f8f8;
	
}

.div_album_detail{
	border-right: 4px solid purple;
}

.div_album_detail_img img{
	width: 100px;
	height: auto;
}

.div_album_like_list img{
	width: 40px;
	height: 60px;
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
		$(".div_album_info").parent().addClass("col-md-1");
		$(".div_album_detail").parent().addClass("col-md-11");
		$("#div_album_container HR").addClass("visible-xs visible-sm");
		
	});
</script>
<div id="div_album_container">
	<div class="row">
		<div>
			<div class="div_album_info">
				<H3 class="in_block">今天</H3>
			</div>
		</div>
		<div class="col-md-10">
			<button>发表文章</button>
		</div>
	</div>
	
	%import random
	%for i in range(5):
	<div class="row">
		<div>
			<div class="div_album_info">
				<H4 class="in_block"><small>2014/9/</small>25</H4>
				<small style="float: right">2小时前</small>
			</div>
		</div>
		<div>
			<div class="div_album_detail">
				<div class="div_album_detail_img" style="background-color: black">
					%ll = random.randint(1,10)
					%for k in range(ll):
						<img src="res/test/a ({{random.randint(1,15)}}).jpg"></img>
					%end
					
				</div>
				<div class="div_album_detail_text">
					报道称，国际能源署在一年一度的《世界能源展望》报告中预测，全球能源需求到2040年将增长37%，从去年的每天9000万桶，上升至每天1亿400万桶。尽管气候暖化问题受到关注，但石化燃料仍将是主要的能源来源。
				</div>
				<div class="div_album_like_list">
					<img src="res/test/a (1).jpg" title="姚姚"></img>
					<img src="res/test/a (7).jpg" title="姚姚"></img>
					<img src="res/test/a (4).jpg" title="姚姚"></img>
					<small style="vertical-align: bottom">等40个人点了赞</small>
				</div>
				<div class="div_album_reply">
					<div><strong>某某</strong>回复<strong>某某</strong>：于生成一个指定范围内的随机符点数，两个参数其中一个</div>
					<div><strong>某某</strong>回复<strong>某某</strong>：于生成一个指定范围内的随机符点数，两个参数其中一个 <i class="icon-chat">回复</i></div>
					<div><strong>某某</strong>回复<strong>某某</strong>：于生成一个指定范围内的随机符点数，两个参数其中一个</div>
				</div>
				<div class="div_album_detail_info">
					<button class="btn btn-link"><i class="icon-heart-empty"></i>赞</button>
					<button class="btn btn-link"><i class="icon-chat"></i>评论</button>
				</div>
			</div>
		</div>
		<HR>
	</div>
	%end
</div>


	
