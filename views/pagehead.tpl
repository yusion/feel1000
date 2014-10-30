<!-- this is page head -->
<input type="hidden" id="session" value="{{session}}" />
<style type="text/css">
input.error { border: 1px solid red; }
label.error {
  background:url("res/unchecked.gif") no-repeat 0px 0px;

  padding-left: 16px;

  padding-bottom: 2px;

  font-weight: bold;

  color: #EA5200;
}
label.checked {
  background:url("res/checked.gif") no-repeat 0px 0px;
}

#img_banner{
	width:100%;
	height: auto;
	position:absolute;
	left:0px;
	top:0px;
	z-index: -1;
}

</style>

<div class="container">
   <div class="row">
      <div class="col-xs-12">
      <div id="div_banner" style="height: 100px;width: 100%"></div>
      <img id="img_banner" src="res/banner.jpg" alt="banner"></img>
      </div>
   </div>
   <div class="row">
      <div class="col-xs-12">
	<ul class="nav nav-tabs">
		<li><a href="#">Home</a></li>
		<li><a href="register">register</a></li>
		<li><a href="search?page=0&page_size=3">search</a></li>
		<li><a href="login">login</a></li>
		<li><a href="profile">profile</a></li>
	</ul>
      </div>
   </div>
</div>

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
		//set banner overlay navigator tabs
		$("#div_banner").height($("#img_banner").height() - $("ul.nav-tabs").height());
	});

</script>

