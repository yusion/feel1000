<!DOCTYPE HTML>
<html>
<head>
	{{!web_head}}
</head>
<body>
{{!page_head}}

<style type="text/css">
#div_search_cond dl{
	background-color:white;
}
#div_search_cond dl > dt{
	width: 60px;
}
#div_search_cond dl > dd{
	margin-left: 100px;
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
 

</style>
<script type="text/javascript">
	$(document).ready(function(){ 
		$(".div_arrange_list .row >div").addClass("col-md-8 col-md-offset-2");
		$(".div_arrange_thumbnail .row >div").addClass("col-md-1 col-md-offset-2");
		$(".div_arrange_bigthumbnail .row >div").addClass("col-md-2 col-md-offset-2");
	}); 
</script>

<div class="row">
	<div id="div_search_cond" class="col-md-8 col-md-offset-2">
	<dl class="dl-horizontal">
		<dt>地区</dt>
		<dd>
			<ul class="list-inline">
			<li>广东<span class="badge">111</span></li>
			<li>广州<span class="badge">1</span></li>
			</ul>
		</dd>
		<dt>年龄</dt>
		<dd>
			<ul class="list-inline">
			%for i in range(18,30):
				<li>{{i}}<span class="badge">{{i}}</span></li>
			%end 
			</ul>
		</dd>
		<dt>年龄</dt>
		<dd>
			<ul class="list-inline">
			%for i in range(18,30):
				<li>{{i}}<span class="badge">{{i}}</span></li>
			%end 
			</ul>
		</dd>
		<dt>年龄</dt>
		<dd>
			<ul class="list-inline">
			%for i in range(18,30):
				<li>{{i}}<span class="badge">{{i}}</span></li>
			%end 
			</ul>
		</dd>
		<dt>年龄</dt>
		<dd>
			<ul class="list-inline">
			%for i in range(18,30):
				<li>{{i}}<span class="badge">{{i}}</span></li>
			%end 
			</ul>
		</dd>
	</dl>
	</div>			
</div>
<div class="row" id="div_display_ctrl">
	<div class="col-md-8 col-md-offset-2" >
		<ul id="tab_dispaly" class="nav nav-tabs">
		   <li class="active">
		      <a href="#" data-toggle="tab">
			 匹配度排序
		      </a>
		   </li>
		   <li><a href="#ios" data-toggle="tab">人气</a></li>
		   <li><a href="#ios" data-toggle="tab">活跃度</a></li>
		    <li><a href="#ios" data-toggle="tab">收入</a></li>
		   <li class="dropdown">
		      <a href="#" class="dropdown-toggle" data-toggle="dropdown">年龄 
			 <b class="caret"></b>
		      </a>
		      <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
			 <li><a href="#jmeter" tabindex="-1" data-toggle="tab">按年龄<strong>由小到大</strong>排序</a></li>
			 <li><a href="#ejb" tabindex="-1" data-toggle="tab">按年龄<strong>由大到小</strong>排序</a></li>
		      </ul>
		   </li>
		   <li class="dropdown">
		      <a href="#" class="dropdown-toggle" data-toggle="dropdown">身高 
			 <b class="caret"></b>
		      </a>
		      <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
			 <li><a href="#jmeter" tabindex="-1" data-toggle="tab">按身高<strong>由高到低</strong>排序</a></li>
			 <li><a href="#ejb" tabindex="-1" data-toggle="tab">按身高<strong>由低到高</strong>排序</a></li>
		      </ul>
		   </li>
		   <div>
			<p class="navbar-text navbar-center">共<strong>99</strong>人</p>
		    </div>
		    <form class="navbar-form navbar-right">
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
 {{!page_foot}}	    
</body>
</html>