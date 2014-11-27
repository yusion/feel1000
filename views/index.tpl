<!DOCTYPE HTML>
<html>  
<head>
	{{!web_head}}
	<script src="js/jquery.jcarousellite.js"></script> <!-- ycat modify -->
	<script src="js/jquery-scrolltofixed-min.js"></script>
</head>
<body>
{{!page_head}}

<style type="text/css">
#div_login_container{
	background-color: white;
	padding: 10px 20px 10px 20px;
	border: 1px solid #ddd;
	border-top-width: 0px;
}
</style>
<script type="text/javascript">
	$(document).ready(function(e){
	});
</script>

<div class="row">
	<div class="col-md-5 col-md-offset-2">
		<img src="res/indexad1.jpg" style="width:100%;height:100%"></img>
	</div>
	<div class="col-md-3">
		<ul id="tab_login" class="nav nav-tabs">
			<li class="active">
			   <a href="#register" data-toggle="tab">免费注册</a>
			</li>
			<li>
			   <a href="#login" data-toggle="tab">快速登陆</a>
			</li>
		</ul>
		<div id="div_login_container" class="tab-content">
			<div class="tab-pane fade in active" id="register">
			   {{!register}}
			</div>
			<div class="tab-pane fade" id="login">
			   {{!login}}
			</div>
		</div>
	</div>
</div>
{{!page_foot}}	
</body>
</html>
