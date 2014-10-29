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
</style>

<div class="container">
   <div class="row">
      <div class="col-xs-12">
	<img src="res/banner.jpg" style="width:100%;height: auto" alt="banner"></img>
      </div>
   </div>
   <div class="row">
      <div class="col-xs-12">
	<ul class="nav nav-tabs">
		<li><a href="#">Home</a></li>
		<li><a href="#">SVN</a></li>
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
			link = $(this).attr("href").toLowerCase();
			url = window.location.pathname.trim("/").toLowerCase();
			if (url[0] == "/") {
				url = url.substr(1);
			}
			if (link.indexOf(url) != -1){
				$(this).parent().addClass("active");
			}
			else{
				//console.log(link,url);
				$(this).parent().removeClass("active");
			}
		});	
	});

</script>

