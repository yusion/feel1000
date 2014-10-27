<!DOCTYPE HTML>
<html>  
<head>
	{{!web_head}}
	<script src="js/jquery.masonry.min.js"></script>  
</head>
<body>
{{!page_head}}

<style type="text/css">
.item{
	border-style: double;
	border-width: 3px;
	}	
</style>

<div id="container" style="width:100%;height:100%;background-color: yellow">
   <div class="item" >a a a a a  a</div>
      <div class="item" style="width:200px;height:100px">a a a a a  2</div>
      <div class="item">a a a a a  a</div>
      <div class="item" style="width:100px;height:200px">a a a a a 4</div>
      <div class="item"  style="width:100px;height:200px">a a a a a 4</div>
      <div class="item"  style="width:200px;height:200px">a a a a a 4</div>
      <div class="item"  style="width:300px;height:200px">a a a a a 4</div>
      
            <div class="item" style="width:100px;height:200px">a a a a a 4</div>
      <div class="item"  style="width:100px;height:200px">a a a a a 4</div>
      <div class="item"  style="width:200px;height:200px">a a a a a 4</div>
      <div class="item"  style="width:300px;height:200px">a a a a a 4</div>
      
      
            <div class="item" style="width:100px;height:200px">a a a a a 4</div>
      <div class="item"  style="width:100px;height:200px">a a a a a 4</div>
      <div class="item"  style="width:200px;height:200px">a a a a a 4</div>
      <div class="item"  style="width:300px;height:200px">a a a a a 4</div>
<div style="width:100px;height:200px">a a a a a 4</div>
 
</div>


<script type="text/javascript">  
	$(function(){  
    $('#container').masonry({  
      // options 设置选项  
      itemSelector : '.item',//class 选择器  
      columnWidth : 100 ,//一列的宽度 Integer
	singleMode:true,
          isAnimated:true,//使用jquery的布局变化  Boolean  
          animationOptions:{  
            //jquery animate属性 渐变效果  Object { queue: false, duration: 500 }  
          },  
          gutterWidth:0,//列的间隙 Integer  
          isFitWidth:true,// 适应宽度   Boolean  
          isResizableL:true,// 是否可调整大小 Boolean  
          isRTL:false,//使用从右到左的布局 Boolean  
  });
    
    }); 
</script>

<HR>
{{!page_foot}}


</body>
</html>

 
