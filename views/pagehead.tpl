<!-- this is page head begin -->
<input type="hidden" id="session" value="{{session}}" />
<div id="page_container" class="container">
  <div id="page_head_row" class="row">
    <div class="col-md-10 col-md-offset-1"  >
	<nav class="navbar navbar-inverse" role="navigation">
 		<div class="navbar-header">
		   <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#my_navbar-collapse">
		      <span class="sr-only">切换导航</span>
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		   </button>
		   <a class="navbar-brand" href="#">Feel1000</a>
		</div>
		<div class="collapse navbar-collapse" id="my_navbar-collapse">
		   <ul class="nav navbar-nav">
			<li><a href="message"><i class="icon-conversation"></i> 动态</a></li>
		        <li><a href="index"><i class="icon-search"></i> 查找</a></li> <!-- icon-temple-islam -->
			<!--li><a href="pkstage"><i class="icon-crown"></i> PK舞台</a></li -->
			<li class="active"><a href="my_space"><i class="icon-parents"></i> 我的主页</a></li>
		   </ul>
		</div>
	     </nav>
     </div>
  </div>
  <div class="row">
	<div class="col-md-11 col-md-offset-1">
		个人主页->广州交友->我的认证
	</div>
  </div>

<script type="text/javascript">
	$(document).ready(function(e){
		$(".navbar a").each(function(){
			//set active tab 
			link = $(this).attr("href").toLowerCase();
			url = window.location.pathname.toLowerCase();
			if (url[0] == "/") {
				url = url.substr(1);
			}
			if (link.indexOf(url) != -1){
				$(this).parent().addClass("active");
			}
			else{
				$(this).parent().removeClass("active");
			}
		});
	});

</script>	
<!-- this is page head end -->
