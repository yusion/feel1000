<!DOCTYPE HTML>
<html>  
<head>
	{{!web_head}}
	<script src="js/jquery.jcarousellite.js"></script>   
</head>
<body>
{{!page_head}}

<style type="text/css">
 
#div_new_member .carousel {
    border: 1px solid #bababa;
    border-radius: 4px;
    background-color: ghostwhite;
    float: left;
    padding-left: 0px;
}

#div_new_member .carousel>ul>li>img {
        width: 150px;
        height: 118px;
        vertical-align:middle;
        margin: 8px 8px 8px 0;
        border-radius: 5px;
}

#div_new_member .prev, #div_new_member .next {
    position:absolute;
    top: 0px;
    width:50px;
    padding-top:40px; 
    opacity: 0.8;
    z-index: 1000;
    cursor: pointer;
}

#div_new_member .prev {
    left: 0px;
}

#div_new_member .next {
    right: 0px;
}
</style>

<script type="text/javascript">
	$(document).ready(function(e){
		//http://www.gmarwaha.com/jquery/jcarousellite/demo.php
		$("#div_new_member .carousel").jCarouselLite({
			btnNext: "#div_new_member .next",
			btnPrev: "#div_new_member .prev",
			auto: 2000,
			speed: 1500,
			scroll: 3,
			mouseWheel: true,
			//visible: 4.5,
			circular:true
		});
		
		$("#div_new_member").children(".prev").hide();
		$("#div_new_member").children(".next").hide();
			
		$("#div_new_member").mouseenter(function(){
			$(this).children(".prev").show();
			$(this).children(".next").show();
		});
		
		$("#div_new_member").mouseleave(function(){
			$(this).children(".prev").hide();
			$(this).children(".next").hide();
		});
	});
</script>		

<div class="col-md-12">
	<div id="div_new_member">
	   <img src="res/arrowleft.gif" class="prev">
	   <div class="carousel">
	       <ul>
		   <li><img src="res/test/a (1).jpg"></li>
		   <li><img src="res/test/a (2).jpg"></li>
		   <li><img src="res/test/a (3).jpg"></li>
		   <li><img src="res/test/a (4).jpg"></li>
		   <li><img src="res/test/a (5).jpg"></li>
		   <li><img src="res/test/a (6).jpg"></li>
		   <li><img src="res/test/a (7).jpg"></li>
		   <li><img src="res/test/a (8).jpg"></li>
	       </ul>
	   </div>
	   <img src="res/arrowright.gif" class="next">
	   <div class="clear"></div>
       </div>
</div>

<div class="col-md-4 col-md-push-8"  style="background-color: yellow">
	<div class="row">
		<div class="col-md-2" >
			<img src="res/test/a (9).jpg" style="width:100px;height:100px" >
		</div>
		<div class="col-md-8" >
			ycat（身份认证）<BR>
			<button>写心情日记</button>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12" >
			***好友  5/29<BR>
			<img src="res/test/a (4).jpg" style="width:50px;height:50px" >
			<img src="res/test/a (4).jpg" style="width:50px;height:50px" >
			<img src="res/test/a (4).jpg" style="width:50px;height:50px" >
		</div>
		<div class="col-md-12" >
			**好友  5/29<BR>
			<img src="res/test/a (4).jpg" style="width:50px;height:50px" >
			<img src="res/test/a (4).jpg" style="width:50px;height:50px" >
			<img src="res/test/a (4).jpg" style="width:50px;height:50px" >
		</div>
		<div class="col-md-12" >
			*好友  5/29<BR>
			<img src="res/test/a (4).jpg" style="width:50px;height:50px" >
			<img src="res/test/a (4).jpg" style="width:50px;height:50px" >
			<img src="res/test/a (4).jpg" style="width:50px;height:50px" >
		</div>
		<div class="col-md-12" >
			留言箱<BR>
			某某人向你发了一封信<BR>
			某好友修改了相片<BR>
			某好友发表了一篇文章<BR>
		</div>
	</div>
	
</div>
<div class="col-md-8 col-md-pull-4" >
	<div class="row">
		<img src="res/test/a (9).jpg" style="width:200px;height:200px;display: inline-block;" >今日明星
		<img src="res/test/a (1).jpg" style="width:200px;height:200px;display: inline-block;" >今日明星
	</div>
	<div class="row">
		<input type="input" style="width:80%"><button>查询</button>
	</div>
	<div class="row">
		<img src="res/test/a (1).jpg" style="width:100px;height:100px;display: inline-block;" >
		<img src="res/test/a (9).jpg" style="width:100px;height:100px;display: inline-block;" >
		<img src="res/test/a (6).jpg" style="width:100px;height:100px;display: inline-block;" >
		<img src="res/test/a (3).jpg" style="width:100px;height:100px;display: inline-block;" >
		<img src="res/test/a (7).jpg" style="width:100px;height:100px;display: inline-block;" >
		<img src="res/test/a (9).jpg" style="width:100px;height:100px;display: inline-block;" >
	</div>
</div>
</div>

{{!page_foot}}	
</body>
</html>
