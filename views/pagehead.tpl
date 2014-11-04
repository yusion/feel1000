<!-- this is page head begin -->
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
<div class="container"  style="background-color:blue;width:100%">
  <div class="row">
    <div class="col-md-8 col-md-offset-2" >
      <div class="row">
	<div class="col-md-2 ">
	  <img src="res/logo.gif" class="img-responsive"> 
	</div>
	<div class="col-md-10"> 
	   <nav class="navbar navbar-default" role="navigation">
	    <ul class="nav nav-tabs">
		    <li><a href="index">广场</a></li>
		    <li><a href="message">动态</a></li>
		    <li><a href="pkstage">PK舞台</a></li>
		    <li><a href="profile">个人主页</a></li>
	    </ul>
	  </nav>
	</div>
      </div> 
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
	});

</script>

<div class="container"  style="width:100%;">
  <div class="row">
    <div class="col-md-8 col-md-offset-2" style="border-style: solid;border-color: black">
<!-- this is page head end -->
