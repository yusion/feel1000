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

/*for tag selector */
.tagItem{
	min-width: 50px;
	display: inline-block;
	color: black;
	background-color: white;
	margin: 0px 10px 5px 0px;
	padding: 2px 4px 2px 4px;
}

.linkTagNew{
	cursor:pointer;
	color:#faae7d;
}

.linkTagNew:hover{
	cursor:pointer;
	color:#f68e51;
	text-decoration:none;
}

.divTagNew{
	position: absolute;
	color: black;
	background-color: #ffffe1;
	padding: 10px 10px 10px 10px;
	border: 1px solid dark;
	z-index: 500;
	border-radius: 2px;
	-moz-box-shadow: 3px 3px 4px #000;
	-webkit-box-shadow: 3px 3px 4px #000;
	box-shadow: 3px 3px 4px #000;
	/* For IE 8 */
	-ms-filter: "progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#000000')";
	/* For IE 5.5 - 7 */
	filter: progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#000000');
}

.divTagNew .tagItem{
	cursor: pointer;
}

.divTagNew .tagItem:hover{
	background-color:orange;
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
		$("#tagSelector").tag_selector();
		
	});
</script>	


<div id="my_space_head" class="row">
     <div class="col-md-10 col-md-offset-1" >
	<div class="row">
		<div class="col-md-3">
			<img src="res/test/a (11).jpg" style="width:224px;height:276px;margin-top: 10px"></img>
			<p class="detail_css">
				<i class="icon-eye-open"></i>1000次 |
				<i class="icon-heart"></i>21人 |
				<i class="icon-picture"></i>11张
			</p>
		</div>
		<div class="col-md-6">
			<h4 class="in_block">姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚</h4>
			<h5 class="in_block" style="float: right;cursor:pointer">
				<i class="icon-edit">编辑</i>
			</h5><BR>
			<div style="margin-bottom: 10px">
				<i class="icon-iphone" title="手机认证******79001"></i>&nbsp;<i class="icon-nameplate" title="身份认证"></i>&nbsp;
				<i class="icon-camera" title="相片认证"></i>&nbsp;<i class="icon-car" title="有车认证"></i>&nbsp;
				<i class="icon-temple-christianity-church" title="有房认证"></i>
			</div>
			<div style="margin-bottom: 15px">
				<div style="margin-bottom: 5px">
					<span>长相：</span><div id="star_rating1" class="in_block"></div>
				</div>
				<div style="margin-bottom: 5px">
					<span>身材：</span><div id="star_rating2" class="in_block"></div>
				</div>
				<div style="margin-bottom: 5px">
					<span>性格：</span><div id="star_rating3" class="in_block"></div>
				</div>
				<div style="margin-bottom: 5px">
					<span>态度：</span><div id="star_rating4" class="in_block"></div>
				</div>
			</div>
			<div id="tagSelector" style="margin-bottom: 10px">
				<input id="input_tagSelector" type="hidden" ></input>
				<ul>
					<li>C</li>
					<li>C++</li>
					<li>JAVA</li>
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
				<textarea id="desc" class="form-control" rows="3" cols="10" placeholder="内心独白"></textarea>
			</div>
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
