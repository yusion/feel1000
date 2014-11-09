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
<div class="container"  style="background-color:#99cc33;width:100%">
  <div class="row">
    <div class="col-md-10 col-md-offset-1" >
      <div class="row">
	<div class="col-md-1 ">
	  <img src="res/logo.gif" class="img-responsive"> 
	</div>
	<div class="col-md-11"> 
	   <nav class="navbar navbar-default" role="navigation" style="margin: 0px 0px 0px 0px">
	    <ul class="nav nav-tabs">
		    <li><a href="index"><i class="icon-home"></i>广场</a></li>
		    <li><a href="message"><i class="icon-conversation"></i>动态</a></li>
		    <li><a href="pkstage"><i class="icon-crown"></i>PK舞台</a></li>
		    <li><a href="profile"><i class="icon-parents"></i>个人主页</a></li>
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

<div class="container"  style="width:100%;background-color:#aae8f3">
  <div class="row">
    <div class="col-md-10 col-md-offset-1" >
<!-- this is page head end -->
