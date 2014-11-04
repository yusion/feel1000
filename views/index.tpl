<!DOCTYPE HTML>
<html>  
<head>
	{{!web_head}}
	<script src="js/jquery.jcarousellite.js"></script> <!-- ycat modify -->
	<script src="js/jquery.masonry.min.js"></script>
	<script src="js/jquery.infinitescroll.dev.js"></script>
	<script src="js/imagesloaded.pkgd.min.js"></script>
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
    top: 50px; 
    opacity: 0.8;
    z-index: 1000;
    cursor: pointer;
    border-radius: 12px;
}

#div_new_member .prev:hover,#div_new_member .next:hover{
	opacity: 1;
	/*border-width: 1px;
	border-style: solid;
	border-color: grey*/
}

#div_new_member .prev {
    left: 5px;
}

#div_new_member .next {
    right: 5px;
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
			isRTL:false//使用从右到左的布局 Boolean
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
		});
		
		$('#div_search_result').imagesLoaded(function(){
			$('#div_search_result').masonry();
		});
	});
</script>		

<div class="col-md-12">
	<div id="div_new_member">
	   <img src="res/arrowleft.gif" class="prev" >
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
	   <img src="res/arrowright.gif" class="next">
	   <div class="clear"></div>
       </div>
</div>

<div class="col-md-3 col-md-push-9"  style="background-color: orange">
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
<div class="col-md-9 col-md-pull-3" >
	<div class="row">
		<img src="res/test/a (9).jpg" style="width:200px;height:200px;display: inline-block;" >今日明星
		<img src="res/test/a (1).jpg" style="width:200px;height:200px;display: inline-block;" >今日明星
	</div>
	<div class="row">
		<input type="input" style="width:80%"><button>查询</button>
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
