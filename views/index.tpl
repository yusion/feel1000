<!DOCTYPE HTML>
<html>  
<head>
	{{!web_head}}
	<script src="js/jquery.jcarousellite.js"></script> <!-- ycat modify -->
	<script src="js/masonry.pkgd.min.js"></script>
	<script src="js/jquery.infinitescroll.dev.js"></script>
	<script src="js/imagesloaded.pkgd.min.js"></script>
	<script src="js/jquery-scrolltofixed-min.js"></script>
	<script src="js/jquery.raty.min.js"></script>

	<!-- http://ionden.com/a/plugins/ion.rangeSlider/en.html -->
	<link rel="stylesheet" href="css/rangeslider/ion.rangeSlider.css" />
	<link rel="stylesheet" href="css/rangeslider/ion.rangeSlider.skinFlat.css"/>
	<script src="js/ion.rangeSlider.js"></script>
	
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

/* setup for inner popup layer */
#img_popup{
	display: none;
	background-color: white;
	border-color: orange;
	border-bottom-style: solid;
	border-bottom-width: 4px;
	padding: 2px 10px 10px 10px
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
		$('#div_search_result').masonry({  
			// options 设置选项  
			itemSelector : '.search_item',//class 选择器  
			columnWidth : 30 ,//一列的宽度 Integer
			gutterWidth:10,//列的间隙 Integer  
			singleMode:true,
			isAnimated:true,//使用jquery的布局变化  Boolean  
			animationOptions:{  
			    //jquery animate属性 渐变效果  Object { queue: false, duration: 500 }  
			  },  
			isFitWidth:true,// 适应宽度   Boolean  
			isResizableL:true,// 是否可调整大小 Boolean  
			isRTL:false,//使用从右到左的布局 Boolean
			layoutComplete:function(){alert("ddd");}
		});
			 
		$('#infinitescroll').infinitescroll({
			navSelector  : "#pagination",           
			nextSelector : ".next_page", // 需要点击的下一页链接
			itemSelector : ".search_item" ,  // 你要检索的所有项目的选择器
			 animate : true
			},
			function(arrayOfNewElems){ //成功后执行的自定义的函数，如页面javascript的重载,这个自定义
				for (var i=0;i<arrayOfNewElems.length; i++)
				{
					var img = $(arrayOfNewElems[i]);
					//img.children("img").css({ opacity: 1 });
					
					var newElement = $('<div class="item"></div>');
					newElement.append(img);
					$('#div_search_result').append(newElement);
					$('#div_search_result').masonry("appended",newElement);
		 
					
					img.children("img").imagesLoaded(function(){
						//console.log($(this).attr("style"));
					});
				}
				$(arrayOfNewElems).inline_popup({
					popup_ctrl:"#img_popup"
				});
		});
		
		$('.search_item').inline_popup({
			popup_ctrl:"#img_popup"
		});
		
		$(".fixDiv").scrollToFixed();
		
		$('#div_search_result').imagesLoaded(function(){
			$('#div_search_result').masonry();
		});
 

		//setup star rating
		$("#star_rating1").raty({ start:2,inline_width:68});
		$("#star_rating2").raty({ start:3,inline_width:68});
		$("#star_rating3").raty({ start:4,inline_width:68});
		$("#star_rating4").raty({ start:2,inline_width:68});
		
		$("#stara_rating1").raty({ start:2,inline_width:68});
		$("#stara_rating2").raty({ start:3,inline_width:68});
		$("#stara_rating3").raty({ start:4,inline_width:68});
		$("#stara_rating4").raty({ start:2,inline_width:68});
		//$("#img_popup_dislike").
		//$('#div_search_result').masonry( 'on', 'layoutComplete', function(){
		//});
	});
</script>		

<div id="img_popup">
	<small>广东 广州 | 21岁 | 178厘米 | 50公斤</small>
	<div>
		<small>
		<i class="icon-eye-open"></i>1000次 | <i class="icon-heart"></i>21人 | <i class="icon-camera"></i>11张
		</small>
	</div>
	<div>
		<button id="img_popup_like" class="btn btn-default btn-sm"><i class="icon-heart-empty"></i>喜欢</button>
		
		<div id="img_popup_dislike" class="btn-group">
			<button type="button" class="btn btn-primary dropdown-toggle btn-sm"  data-toggle="dropdown">
			   不喜欢 <span class="caret"></span>
			</button>
			<ul class="dropdown-menu" role="menu">
			   <li><a href="#">外表不喜欢</a></li>
			   <li><a href="#">PS痕迹严重</a></li>
			   <li><a href="#">感觉不好</a></li>
			</ul>
		</div>
	</div>
</div>

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
<div >
	<div class="col-md-3">
		{{!search_form}}
	</div>
</div>
<div class="col-md-9" >
	<div class="row">
		<div class="col-md-6">
			{{!search_item}}
		</div>
		<div class="col-md-6">
			{{!search_item}}
		</div>
	</div>
	<div class="row">
		<div class="col-md-6">
			{{!search_item}}
		</div>
		<div class="col-md-6">
			{{!search_item}}
		</div>
	</div>
	<div class="row">
		<div class="col-md-6">
			{{!search_item}}
		</div>
		<div class="col-md-6">
			{{!search_item}}
		</div>
	</div>
	<div class="row">
		<div class="col-md-6">
			{{!search_item}}
		</div>
		<div class="col-md-6">
			{{!search_item}}
		</div>
	</div>
	<div class="row">
		<div class="col-md-6">
			{{!search_item}}
		</div>
		<div class="col-md-6">
			{{!search_item}}
		</div>
	</div>
	<div class="row">
		<div class="col-md-6">
			{{!search_item}}
		</div>
		<div class="col-md-6">
			{{!search_item}}
		</div>
	</div>
	
	<div class="row">
		<div id="div_search_result" style="width:80%;height:70%;background-color: black">
			{{!search_result}}
		</div>
	</div>
	<div class="row">
		<div id="pagination">
			<a href="search?page_size={{page_size}}&page={{int(current_page)+1}}" class="next_page">加载更多</a>		
		</div>
		<div id="infinitescroll" style="margin: 0;width: auto;height: 200px"></div>
	</div>	
</div>
</div>
				
{{!page_foot}}	
</body>
</html>
