<!-- this is page head begin -->
<input type="hidden" id="session" value="{{session}}" />
<div class="container"  style="width:100%;background-color:#aae8f3">
  <div class="row" style="background-color:#99cc33;">
    <div class="col-md-10 col-md-offset-1"  >
	<nav class="navbar navbar-inverse" role="navigation">
 		<div class="navbar-header">
		   <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#my_navbar-collapse">
		      <span class="sr-only">�л�����</span>
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		      <span class="icon-bar"></span>
		   </button>
		   <a class="navbar-brand" href="#">Feel1000</a>
		</div>
		<div class="collapse navbar-collapse" id="my_navbar-collapse">
		   <ul class="nav navbar-nav">
		       <li><a href="index"><i class="icon-home"></i>�㳡</a></li>
			<li><a href="message"><i class="icon-conversation"></i>��̬</a></li>
			<li><a href="pkstage"><i class="icon-crown"></i>PK��̨</a></li>
			<li><a href="profile"><i class="icon-parents"></i>������ҳ</a></li>
		   </ul>
		</div>
	     </nav>
     </div>
  </div>
  
  <div class="row">
    <div class="col-md-10 col-md-offset-1" >
<script type="text/javascript">
	$(document).ready(function(e){
		$(".nav-tabs a").each(function(){
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
