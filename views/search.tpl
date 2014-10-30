<!DOCTYPE HTML>
<html>  
<head>
	{{!web_head}}
	<script src="js/jquery.masonry.min.js"></script>
	<script src="js/jquery.infinitescroll.dev.js"></script>
	<script src="js/imagesloaded.pkgd.min.js"></script>
</head>
<body>
{{!page_head}}
<div id="masonry_container" style="width:80%;height:70%;background-color: black">
	%for r in result:
	<div class="item" >
		<img alt="" src="{{r.photo_url}}" style="width:{{r.photo_width}};heigth:{{r.photo_height}}"/>
		<div style="background: repeat-x url('res/stampframe.gif');height: 9px;width:100%"></div>
	</div>
	
	%end
</div>

<div id="pagination">
    <a href="search?page_size=3&page={{int(current_page)+1}}" class="next">加载更多</a>
</div>

<div id="infinitescroll" style="margin: 0;width: auto;height: 200px">
</div>
<script type="text/javascript">
	
$(function(){  
 $('#masonry_container').masonry({  
	// options 设置选项  
	itemSelector : '.item',//class 选择器  
	columnWidth : 30 ,//一列的宽度 Integer
	gutterWidth:0,//列的间隙 Integer  
	singleMode:true,
        isAnimated:true,//使用jquery的布局变化  Boolean  
        animationOptions:{  
            //jquery animate属性 渐变效果  Object { queue: false, duration: 500 }  
          },  
        isFitWidth:true,// 适应宽度   Boolean  
        isResizableL:true,// 是否可调整大小 Boolean  
        isRTL:false,//使用从右到左的布局 Boolean
	  
	});
	 
	$('#infinitescroll').infinitescroll({
		navSelector  : "#pagination",           
		nextSelector : ".next", // 需要点击的下一页链接
		itemSelector : ".item" ,  // 你要检索的所有项目的选择器
		 animate : true
		},
		function(arrayOfNewElems){ //成功后执行的自定义的函数，如页面javascript的重载,这个自定义
			for (var i=0;i<arrayOfNewElems.length; i++)
			{
				var img = $(arrayOfNewElems[i]);
				//img.children("img").css({ opacity: 1 });
			
				var newElement = $('<div class="item"></div>');
				newElement.append(img);
				
				$('#masonry_container').append(newElement);
				$('#masonry_container').masonry("appended",newElement);
				
				img.children("img").imagesLoaded(function(){
					console.log($(this).attr("style"));
				});
			}
		});
	});

	$('#masonry_container').imagesLoaded(function(){
		$('#masonry_container').masonry();
	});

</script>

{{!page_foot}}
</body>
</html>

 
