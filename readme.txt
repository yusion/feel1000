yaoshun@comba.com.cn http://www.51taonan.com/ comba  
zaq1XSW2

www.feel1000.com


��ǰ��¼�ʺţ�113595@qq.com *


http://www.docin.com/p-299792423.html


wow sliderͼƬ���
http://wowslider.com/automatic-jquery-slider-noir-squares-demo.html?affid=571-JGL2

�������
http://www.360doc.com/content/14/0228/14/13247663_356447995.shtml

�������
http://www.360doc.com/content/14/0228/14/13247663_356445693.shtml

Բ�ν�����
http://www.360doc.com/content/14/0228/14/13247663_356449344.shtml

http://js.itivy.com/?cat=14

ѡ���ǩ
http://www.17sucai.com/pins/demoshow/321

��ҳ��Ч��
http://www.jq22.com/
http://www.jsfoot.com/jquery/form/

���Źؼ���
http://www.17sucai.com/pins/demoshow/331

�Ǽ�����
http://www.17sucai.com/pins/tag/547.html

����ǽ
http://www.17sucai.com/pins/demoshow/2533

����
http://jqueryui.com/datepicker/

�Ʊ���
http://www.jq22.com/Demo498

ͼ��
http://www.jq22.com/jquery-info289

ʱ����
http://www.jq22.com/jquery-info247

ģʽ�Ի���
http://www.jq22.com/jquery-info258


������js
http://www2.yunshipei.com/price.html

�������Ƽ���10�����е� Metro UI ���� Bootstrap �����ģ��
http://www.cnblogs.com/lhb25/archive/2013/04/11/10-metro-bootstraps-ui-templates.html

Web������Ա�Ƽ�12������� Twitter Bootstrap ����͹���
http://www.cnblogs.com/lhb25/archive/2012/09/11/resources-that-complement-twitter-bootstrap.html


ͼƬչʾ������,����һ��jQuery������ڲ���Ԫ�صĶ�̬����,Ҳ���Ǵ�ҳ��������ٲ�����
http://www.jq22.com/jquery-info203
http://www.th7.cn/web/ajax/201303/10620.shtml


jQuery Masonry(ѡ��)
http://www.iteye.com/news/15831-masonry-jquery

jQUery ��masonry��infinitescroll��� ʵ���ٲ�������������
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
		//��������������ײ�����50��ʱ�򴥷�
		$(window).scroll(function(){
			// ����������ײ�����100����ʱ�� ����������
			if ($(document).height() - $(this).scrollTop() - $(this).height()<50){	
				if (flag){
					var $boxes = $(getList());	 
					$container.append($boxes).masonry('appended',$boxes);
				}
			}
		});	
	});	
	//���Ի�ȡ�б�
	function getList() {	
		var boxes = [],count = parseInt(Math.random()*10); 
		for (var i=0; i < count; i++ ) {
			boxes.push('<div class="post"><a href="#"><img src="images/'+(i+1)+'.jpg" width="280" alt="" /></a><a href="#" target="_blank">ͼƬ'+(i+1)+'</a></div>');
		}
		//������ת���ַ���
		return boxes.join("");
	};
</script>















���û�����վ�����ܵõ�ʲô������������ĵģ�����һ����վҪ֪��������ļ�ֵ���壬�ͱ�������û�֪�����Ǵ��п��Եõ�ʲô�������������ֳ���վ��������塣��


��������Ʒ��δ��޵��оۼ��û���
http://www.yixieshi.com/pd/12350.html

����App��ǰ100���û���ô���ģ�
http://www.yixieshi.com/pd/19243.html

�����㣬��͸���ɲ���ʾ��ʵ�ְ취
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
 
 //���λ��
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