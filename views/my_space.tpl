<!DOCTYPE HTML>
<html>
<head>
	{{!web_head}}
	<script src="js/jquery.raty.min.js"></script>
</head>
<body>
{{!page_head}}

<style type="text/css">
#my_space_head{
	background-color: #516793;
	color:white;
	margin-top: -15px;
	padding-top: 15px;
}

#nav_my_space{
	margin: 0px 0px 0px 0px;
	border-bottom-width: 0px;
}

#div_profile{
	background-color: #f8f8f8;border:1px solid #e7e7e7
}

</style>
<script type="text/javascript">
	$(document).ready(function(e){
		//setup star rating 
		$("#star_rating1").raty({ start:3,inline_width:38});
		$("#star_rating2").raty({ start:3,inline_width:68});
		$("#star_rating3").raty({ start:3,inline_width:68});
		$("#star_rating4").raty({ start:3,inline_width:68});
		
		//set_background_img("res/banner.jpg",$("#my_space_head"));
		$("#div_profile").load("profile");
	});
</script>	


<div id="my_space_head" class="row">
     <div class="col-md-10 col-md-offset-1" >
	<div class="row">
		<div class="col-md-3">
			<img src="res/test/a (11).jpg" style="width:224px;height:276px;"></img>
		</div>
		<div class="col-md-5">
			<h4>姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚</h4>
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
			
			"选择标签"
		</div>
		<div class="col-md-3">
			<div class="search_item_score_css in_block">
				长相<div id="star_rating1"></div>	
				身材<div id="star_rating2"></div>
				性格<div id="star_rating3"></div>
				态度<div id="star_rating4"></div>
			</div>
		</div>
		<div class="col-md-3">
		</div>
	</div>
     </div>
</div>

<div class="row">
<div class="col-md-10 col-md-offset-1" >
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
			      <li class="active"><a href="#">我的动态</a></li>
			      <li><a href="#">我的资料</a></li>
			      <li><a href="#">我的认证</a></li>
			      <li><a href="#">我的好友</a></li>
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
