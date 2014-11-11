<!DOCTYPE HTML>
<html>  
<head>
	{{!web_head}}
	<script src="js/jquery.jcarousellite.js"></script> <!-- ycat modify -->
	<script src="js/jquery.infinitescroll.dev.js"></script>
	<script src="js/imagesloaded.pkgd.min.js"></script>
	<script src="js/jquery-scrolltofixed-min.js"></script>
	<script src="js/jquery.raty.min.js"></script>

	<!-- http://ionden.com/a/plugins/ion.rangeSlider/en.html -->
	<link rel="stylesheet" href="css/rangeslider/ion.rangeSlider.css" />
	<link rel="stylesheet" href="css/rangeslider/ion.rangeSlider.skinFlat.css"/>
	<script src="js/ion.rangeSlider.js"></script>
	
	<link rel="stylesheet" href="css/select_city.css" />
	<script src="js/select_city.js"></script>
	<link href="css/return_top.css" rel="stylesheet"  type="text/css"/>
	<script src="js/return_top.js" type="text/javascript"></script>
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

.img_new_member{
        width: 150px;
        height: 118px;
        vertical-align:middle;
        margin: 8px 8px 8px 0;
        border-radius: 5px;
}

#div_new_member .prev, #div_new_member .next {
    position:absolute;
    top: 40px; 
    opacity: 0.8;
    z-index: 1000;
    color: blue; 
    cursor: pointer;
}

#div_new_member .prev:hover,#div_new_member .next:hover{
	opacity: 1;
}

#div_new_member.prev {
    left: 5px;
}

#div_new_member .next {
    right: 5px;
}

.search_item{
	cursor: pointer	
}

</style>

<script type="text/javascript">
	$(document).ready(function(e){
		//http://www.gmarwaha.com/jquery/jcarousellite/demo.php
		$("#div_new_member .carousel").jCarouselLite({
			btnNext: "#div_new_member .prev",
			btnPrev: "#div_new_member .next",
			auto: 2000,
			speed: 1500,
			scroll: 3,
			mouseWheel: false,
			circular:true,
			visible:10
		});
		$("#div_new_member .carousel").AutoCarouselLite("true");
		
		$("#div_new_member").children(".prev").hide();
		$("#div_new_member").children(".next").hide();
			
		$("#div_new_member").mouseenter(function(){
			$(this).children(".prev").show();
			$(this).children(".next").show();
			$("#div_new_member .carousel").AutoCarouselLite("false");
		});
		
		$("#div_new_member").mouseleave(function(){
			$(this).children(".prev").hide();
			$(this).children(".next").hide();
			$("#div_new_member .carousel").AutoCarouselLite("true");
		});
		
		///////////for search result////////////
		function set_popup()
		{
			$('.search_item_css').inline_popup({
				popup_ctrl:"#img_popup",
				opacity:0.95
			});
		}
		
		$('#infinitescroll').infinitescroll({
			navSelector  : "#pagination",           
			nextSelector : ".next_page", // 需要点击的下一页链接
			itemSelector : ".search_item" ,  // 你要检索的所有项目的选择器
			 animate : true
			},
			function(arrayOfNewElems){ //成功后执行的自定义的函数，如页面javascript的重载,这个自定义
				$('#div_search_foot').before(arrayOfNewElems);
				set_popup();
			}); 
		set_popup();
		
		//visit for more infor, https://github.com/bigspotteddog/ScrollToFixed
		$(".fixDiv").scrollToFixed({
			minWidth : 990
			});
	});
</script>		

<div id="img_popup" style="background-color:white;padding: 10px 10px 10px 10px">
	<div style="width: 45%;display: inline-block">
		<button id="img_popup_like" class="btn btn-success" style="width: 100%"><i class="icon-heart-empty"></i>喜欢</button>
	</div>
	<div class="btn-group" style="width: 45%;float: right">
		<button type="button" class="btn btn-warning dropdown-toggle"  data-toggle="dropdown" style="width: 100%;height: 100%">
		   <i class="icon-remove-2"></i>不喜欢 <span class="caret"></span>
		</button>
		<ul class="dropdown-menu" role="menu">
		   <li><a href="#">外表不喜欢</a></li>
		   <li><a href="#">PS痕迹严重</a></li>
		   <li><a href="#">感觉不好</a></li>
		</ul>
	</div>
</div>

<div class="row">
<div class="col-md-12">
	<div id="div_new_member">
	   <H1 class="prev"><i class="icon-circle-arrow-left"></i></H1>
	   <div class="carousel">
	       <ul>
		   <li><img src="res/test/a (1).jpg" class="img_new_member hot_tag"></li>
		   <li><img src="res/test/a (2).jpg" class="img_new_member hot_tag"></li>
		   <li><img src="res/test/a (3).jpg" class="img_new_member new_tag"></li>
		   <li><img src="res/test/a (4).jpg" class="img_new_member" ></li>
		   <li><img src="res/test/a (5).jpg" class="img_new_member"></li>
		   <li><img src="res/test/a (6).jpg" class="img_new_member"></li>
		   <li><img src="res/test/a (7).jpg" class="img_new_member"></li>
		   <li><img src="res/test/a (8).jpg" class="img_new_member"></li>
	       </ul>
	   </div>
	   <H1 class="next"><i class="icon-circle-arrow-right"></i></H1>
       </div>
</div>
</div>
<div class="row">
	<div class="col-md-3">
		{{!search_form}}
	</div>

	<div class="col-md-9" >
		{{!search_result}}
		<div id="div_search_foot" class="row">
			<div id="pagination">
				<a href="search?page_size={{page_size}}&page={{int(current_page)+1}}" class="next_page">加载更多</a>		
			</div>
			<div id="infinitescroll" style="margin: 0;width: auto;height: 200px"></div>
		</div>	
	</div>
	
</div>
	<a class="visible-md visible-lg" id="returnTop" href="javascript:;">回到顶部</a> 
{{!page_foot}}	
</body>
</html>
