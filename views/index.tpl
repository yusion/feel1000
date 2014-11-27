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
		//http://www.gmarwaha.com/jquery/jcarousellite/demo.php
		$("#div_new_member .carousel").jCarouselLite({
			btnNext: "#div_new_member .prev",
			btnPrev: "#div_new_member .next",
			auto: 3000,
			speed: 2000,
			scroll: 3,
			mouseWheel: false,
			circular:true,
			visible:10
		});
		
		//自动生成1,2,3的按钮 
		var btnArray = new Array();
		var index = 1;
		var newDiv = $("<div id='div_carousel_ctrl'></div>");
		$("#div_introduction >ul>li").each(function(){
			btnArray.push("#div_introduction ." + index);
			newDiv.append("<a href='#' class='go " + index + "'>" + index + "</a>");
			if (index == 1) {
				newDiv.children(".go").addClass("active");
			}
			index += 1;
		});
		$("#div_introduction").append(newDiv);
		newDiv.children(".go").mouseenter(function(){
			//鼠标悬停时，自动跳到这一页 
				$(this).click();
			});
		
		$("#div_introduction li").click(function(){
			var index = parseInt($(this).attr("no")) +1;
			if (index > $("#div_introduction .go").length) {
				index = 1;
				console.log($("#div_introduction li").length);
			}
			var item = $("#div_carousel_ctrl").find("." + index);
			item.click();
		});
		
		$("#div_introduction").jCarouselLite({
			//btnNext: "#div_introduction .prev",
			//btnPrev: "#div_introduction .next",
			auto: 5000,
			speed: 500,
			visible:1,
			btnGo: btnArray,
			beforeStart: function(item) {
				//自动滑动时，变成active
				$("#div_carousel_ctrl").children(".active").removeClass("active");
				$("#div_carousel_ctrl").children("." + item.attr("no")).addClass("active");
			},
			afterEnd : function(item) {
				//自动滑动时，变成active,仅靠beforeStart有时item为None
				$("#div_carousel_ctrl").children(".active").removeClass("active");
				$("#div_carousel_ctrl").children("." + item.attr("no")).addClass("active");
 			}
		});
		$(".carousel").AutoCarouselLite("true");

		$("#div_new_member").children("p").hide();
			
		$("#div_new_member").mouseenter(function(){
			$(this).children("p").show();
			$("#div_new_member .carousel").AutoCarouselLite("false");
		});
		
		$("#div_new_member").mouseleave(function(){
			$(this).children("p").hide();
			$("#div_new_member .carousel").AutoCarouselLite("true");
		});
	});
</script>

<div class="row">
	<div class="col-md-5 col-md-offset-2">
		<div id="div_introduction" class="carousel">
 		        <ul>
				%for i in range(3):
				   <li no="{{i+1}}" style="cursor:pointer"><img src="res/indexad{{i+1}}.jpg" style="width:520px;height:273px"></img></li>
				%end
		        </ul>
 		</div>
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
<div class="row">
	<div class="col-md-8 col-md-offset-2">
		<div id="div_new_member">
		   <p class="prev"></p>
		   <div class="carousel">
		       <ul>
			%for i in range(10):
			   <li><img src="res/test/a ({{i+1}}).jpg" class="img_profile_sm new_tag"></li>
			%end
		       </ul>
		   </div>
		   <p class="next"></p>
	       </div>
	</div>
</div>
{{!page_foot}}	
</body>
</html>
