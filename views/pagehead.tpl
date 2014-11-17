<!-- this is page head begin -->
<input type="hidden" id="session" value="{{session}}" />
<div id="page_container" class="container">
  <div id="page_head_row" class="row">
    <div class="col-md-10 col-md-offset-2"  >
	<nav id="nav_main" class="navbar navbar-inverse" role="navigation">
 		<div class="navbar-header">
		   <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#my_navbar-collapse">
		      <span class="sr-only">切换导航</span>
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		   </button>
		   <a class="navbar-brand" href="index" style="padding: 0 20px 0 0px">
		    <img alt="logo" src="res/logo.gif" style="width:50px;height:auto"></img>
		    <span style="font-weight:900;font-size: 20px;vertical-align: middle;color: yellow">LoveCC</span>
		   </a>
		</div>
		<div class="collapse navbar-collapse" id="my_navbar-collapse">
		   <ul class="nav navbar-nav">
			<li><a href="index"><i class="icon-conversation"></i> 动态</a></li>
		        <li><a href="search"><i class="icon-search"></i> 查找</a></li> <!-- icon-temple-islam -->
			<!--li><a href="pkstage"><i class="icon-crown"></i> PK舞台</a></li -->
			<li class="active"><a href="my_space"><i class="icon-parents"></i> 我的主页</a></li>
		   </ul>
		</div>
	     </nav>
     </div>
  </div>
  <div class="row"> 
	<div class="col-md-8 col-md-offset-2">
		<ol id="my_breadcrumb" class="breadcrumb">
			<li style="color:#CCCCCC"><i class="icon-google-maps"></i>位置 </li>
			<li><a href="index">主页</a></li>
		</ol>
	</div>
  </div>

<script type="text/javascript">
	$(document).ready(function(e){
		$("#nav_main > li").removeClass("active");
		$("#nav_main .navbar-nav a").each(function(){
			//set active tab 
			link = $(this).attr("href").toLowerCase();
			url = window.location.pathname.toLowerCase();
			if (url[0] == "/") {
				url = url.substr(1);
			}
			if (link.indexOf(url) != -1){ 
				$(this).parent().addClass("active");
				push_breadcrumb($(this).text());
			}
			else{
				$(this).parent().removeClass("active");
			}
		});
	});

</script>	
<!-- this is page head end -->
