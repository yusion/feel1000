yaoshun@comba.com.cn http://www.51taonan.com/ comba  
zaq1XSW2

www.feel1000.com


当前登录帐号：113595@qq.com *


http://www.docin.com/p-299792423.html


wow slider图片浏览
http://wowslider.com/automatic-jquery-slider-noir-squares-demo.html?affid=571-JGL2

美化插件
http://www.360doc.com/content/14/0228/14/13247663_356447995.shtml

美化插件
http://www.360doc.com/content/14/0228/14/13247663_356445693.shtml

圆形进度条
http://www.360doc.com/content/14/0228/14/13247663_356449344.shtml

http://js.itivy.com/?cat=14

选择标签
http://www.17sucai.com/pins/demoshow/321

网页特效网
http://www.jq22.com/
http://www.jsfoot.com/jquery/form/

热门关键字
http://www.17sucai.com/pins/demoshow/331

星级评分
http://www.17sucai.com/pins/tag/547.html

留言墙
http://www.17sucai.com/pins/demoshow/2533

日期
http://jqueryui.com/datepicker/

云背景
http://www.jq22.com/Demo498

图表
http://www.jq22.com/jquery-info289

时间轴
http://www.jq22.com/jquery-info247

模式对话框
http://www.jq22.com/jquery-info258


云适配js
http://www2.yunshipei.com/price.html

【今日推荐】10大流行的 Metro UI 风格的 Bootstrap 主题和模板
http://www.cnblogs.com/lhb25/archive/2013/04/11/10-metro-bootstraps-ui-templates.html

Web开发人员推荐12款优秀的 Twitter Bootstrap 组件和工具
http://www.cnblogs.com/lhb25/archive/2012/09/11/resources-that-complement-twitter-bootstrap.html


图片展示，布局,这是一个jQuery插件用于布局元素的动态网格,也就是大家常看到的瀑布流。
http://www.jq22.com/jquery-info203
http://www.th7.cn/web/ajax/201303/10620.shtml


jQuery Masonry(选荐)
http://www.iteye.com/news/15831-masonry-jquery

jQUery 中masonry与infinitescroll结合 实现瀑布流，下拉加载
http://blog.csdn.net/kof820/article/details/8764715

<script type="text/javascript">	
	var flag = true;
	$(function(){			
		var $container = $('#listing');    
		$container.masonry({
			singleMode: true,
			animate: true,
			itemSelector: '.post'
		});		
		//滚动条滚动到离底部距离50的时候触发
		$(window).scroll(function(){
			// 当滚动到最底部以上100像素时， 加载新内容
			if ($(document).height() - $(this).scrollTop() - $(this).height()<50){	
				if (flag){
					var $boxes = $(getList());	 
					$container.append($boxes).masonry('appended',$boxes);
				}
			}
		});	
	});	
	//测试获取列表
	function getList() {	
		var boxes = [],count = parseInt(Math.random()*10); 
		for (var i=0; i < count; i++ ) {
			boxes.push('<div class="post"><a href="#"><img src="images/'+(i+1)+'.jpg" width="280" alt="" /></a><a href="#" target="_blank">图片'+(i+1)+'</a></div>');
		}
		//把数组转成字符串
		return boxes.join("");
	};
</script>















“用户从网站本身能得到什么，是我们最关心的，建立一个网站要知道它本身的价值意义，就必须得让用户知道他们从中可以得到什么，这样才能体现出网站本身的意义。”


互联网产品如何从无到有聚集用户？
http://www.yixieshi.com/pd/12350.html

过亿App的前100万用户怎么来的？
http://www.yixieshi.com/pd/19243.html

弹出层，半透明蒙层提示的实现办法
http://www.cnblogs.com/long_/archive/2010/09/08/1821751.html

<script language="javascript" type="text/javascript">
 $(function(){
  $("#ele1").click(function(ev){
     var evs= ev || window.event; 
     var XYposition=mousePosition(evs);
     var X=XYposition.x;
     var Y=XYposition.y; 
     $('#blk1').css("opacity","0").css("left",''+X+'px').css("top",''+Y+'px');
     $('#blk1').animate({width:"200px",height:"200px",opacity:"1"},3000);
   })
  $("#close1").click(function(){
     $('#blk1').stop().animate({width:"0px",height:"0px",opacity:"0",left:"0px",top:"0px"},300);
    })
 
 });
 
 //鼠标位置
function mousePosition(ev){
    if(ev.pageX || ev.pageY){
    return {x:ev.pageX, y:ev.pageY};
    }
    return {
    x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
    y:ev.clientY + document.body.scrollTop - document.body.clientTop
    };
  } 
 
 </script>





  <!--script type="text/javascript">
  QUnit.module( "group a" );
QUnit.test( "a basic test example", function( assert ) {
  assert.ok( true, "this test is fine" );
});
QUnit.test( "a basic test example 2", function( assert ) {
  assert.ok( true, "this test is fine" );
});
 
QUnit.module( "group b" );
QUnit.test( "a basic test example 3", function( assert ) {
  assert.ok( true, "this test is fine" );
});
QUnit.test( "a basic test example 4", function( assert ) {
  assert.ok( true, "this test is fine" );
});
  </script-->