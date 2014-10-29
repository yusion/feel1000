<!DOCTYPE HTML>
<html>  
<head>
	{{!web_head}}
	<script src="js/jquery.masonry.min.js"></script>
	<script src="js/jquery-ias.min.js"></script>
</head>
<body>
{{!page_head}}

<div id="masonry_container" style="width:80%;height:80%;background-color: black">
	%for r in result:
	<div class="item" >
		<img alt="" src="{{r.photo_url}}" style="width:400px;height: 300px" />	
	</div>
	
	<div class="item" >
		<img alt="" src="{{r.photo_url}}" style="width:400px;height: 300px" />	
	</div>
	
	<div class="item" >
		<img alt="" src="{{r.photo_url}}" style="width:400px;height: 300px" />	
	</div>
	%end
</div>

<div id="pagination">
    <a href="search?page_size=3&page={{int(current_page)+1}}" class="next">next page {{total_page}}</a>
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

  var ias = $.ias({
      container: "#masonry_container",
      item: ".item",
      pagination: "#pagination",
      next: ".next",
      delay: 1200
    });
  
	ias.on('render', function(items) {
	  $(items).css({ opacity: 0 });
	});

	ias.on('rendered', function(items) {
		for (var i=0;i<items.length;i++) {
			var item = $(items[i]);
			item.css({ opacity: 1 });
			$('#masonry_container').append(item);
			$('#masonry_container').masonry("appended",item);
		}
		
		//$('#masonry_container').masonry();
	});
 
	ias.extension(new IASSpinnerExtension({
	    src: 'res/ajax-loader.gif', // optionally
	}));
	
	ias.extension(new IASNoneLeftExtension({
		text: 'There are no more pages left to load.'      // override text when no pages left
	}));
	
	//ias.extension(new IASNoneLeftExtension({html: '<div class="ias-noneleft" style="text-align:center"><p><em>You reached the end!</em></p></div>'}));    	
	ias.extension(new IASPagingExtension());
	ias.on('pageChange', function(pageNum, scrollOffset, url) {
		console.log(
		    "Welcome at page " + pageNum + ", " +
		    "the original url of this page would be: " + url
		);
	    });
	});
</script>

{{!page_foot}}
</body>
</html>

 
