//// ----------------------------------------------------------------------
//// <summary>
//// 限制只能输入数字 http://www.cnblogs.com/xdp-gacl/p/3467245.html
//// </summary>
//// ----------------------------------------------------------------------
//$.fn.my = {}
//$.fn.onlyNum = function () {
//	$(this).keypress(function (event) {
//	    var eventObj = event || e;
//	    var keyCode = eventObj.keyCode || eventObj.which;
//	    if ((keyCode >= 48 && keyCode <= 57))
//		return true;
//	    else
//		return false;
//	}).focus(function () {
//	//禁用输入法
//	this.style.imeMode = 'disabled';
//	}).bind("paste", function () {
//	//获取剪切板的内容
//	    try{
//		    var clipboard = window.clipboardData.getData("Text");
//		    if (/^\d+$/.test(clipboard))
//			return true;
//		    else
//			return false;
//	    }
//	    catch(e)
//	    {
//		    return true;
//	    }
//	});
//};
//	
//// ----------------------------------------------------------------------
//// <summary>
//// 限制只能输入字母
//// </summary>
//// ----------------------------------------------------------------------
//$.fn.onlyAlpha = function () {
//    $(this).keypress(function (event) {
//        var eventObj = event || e;
//        var keyCode = eventObj.keyCode || eventObj.which;
//        if ((keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122))
//            return true;
//        else
//            return false;
//    }).focus(function () {
//        this.style.imeMode = 'disabled';
//    }).bind("paste", function () {
//        try
//        {
//            var clipboard = window.clipboardData.getData("Text");
//            if (/^[a-zA-Z]+$/.test(clipboard))
//                return true;
//            else return false;
//        }
//        catch(err)
//        {
//          return true;  
//        }
//    });
//};
//
//// ----------------------------------------------------------------------
//// <summary>
//// 限制只能输入数字和字母
//// </summary>
//// ----------------------------------------------------------------------
//$.fn.onlyNumAlpha = function () {
//$(this).keypress(function (event) {
//	var eventObj = event || e;
//	var keyCode = eventObj.keyCode || eventObj.which;
//	if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122))
//	    return true;
//	else
//	    return false;
//	}).focus(function () {
//	this.style.imeMode = 'disabled';
//	}).bind("paste", function () {
//          try
//          {
//              var clipboard = window.clipboardData.getData("Text");
//              if (/^(\d|[a-zA-Z])+$/.test(clipboard))
//                  return true;
//              else return false;
//          }
//          catch(err)
//          {
//            return true;  
//          }
//	});
//};
//
//var validate_rex = [{class:"onlyNum",rex:/^\d+$/,msg:"只能输入数字"},
//                    {class:"onlyAlpha",rex:/^[a-zA-Z]+$/,msg:"只能输入英文字母"},
//                    {class:"onlyNumAlpha",rex:/^(\d|[a-zA-Z])+$/,msg:"只能输入数字和英文字母"},
//                    {class:"onlyEmail",rex: /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/,msg:"只能输入正确的Email格式"},
//                    {class:"onlyPhone",rex: /^(1[3|5|7|8])[\d]{9}$/,msg:"只能输入正确的手机格式"}
//                   ];
//
//$.fn.validate = function(){
//  for(x in validate_rex)
//  {
//    x = validate_rex[x]
//    if(this.hasClass(x.class))
//    {
//      if(!x.rex.test(this.val()))
//      {
//        return x.msg;
//      }
//    }
//  } 
//  return "";
//};
//
//$.fn.check = function(){
//  $("#div_validate_error").remove();
//  
//  var msg = this.validate();
//  if (msg == "") return true;
//  
//  console.log(this.html());
//  e = '<div id="div_validate_error" style="color:red"';
//  e += ' ctrl_id = "' + this.attr("id")+'" ';
//  e += '>';
//  e += '<span class="glyphicon glyphicon-warning-sign"></span>';
//  e += msg;
//  e += '<a href="#" style="float:right">放弃编辑</a>';
//  e += "</div>";
//  
//  this.after(e) ;
//  return false;
//}
//
//function check_browser_version(){
//	var userAgent = $(window).navigator.userAgent.toLowerCase();
//	$.browser.ie10 = $.browser.msie && /msie 10\.0/i.test(userAgent);
//	$.browser.ie9 = $.browser.msie && /msie 9\.0/i.test(userAgent);
//	$.browser.ie8 = $.browser.msie && /msie 8\.0/i.test(userAgent);
//	$.browser.ie7 = $.browser.msie && /msie 7\.0/i.test(userAgent);
//	$.browser.ie6 = !$.browser.msie8 && !$.browser.msie7 && $.browser.msie && /msie 6\.0/i.test(userAgent);
//});
//
//
//function my_init()
//{
//    $(".onlyNum").onlyNum();
//    $(".onlyAlpha").onlyAlpha();
//    $(".onlyNumAlpha").onlyNumAlpha();
//}
//
//
