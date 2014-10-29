// ----------------------------------------------------------------------
// <summary>
// 限制只能输入数字 http://www.cnblogs.com/xdp-gacl/p/3467245.html
// </summary>
// ----------------------------------------------------------------------

function limit_max_input(item,event,maxLen) {
  //有三种限制长度 limit_s = 6, limit_m = 20, limit_l = 100
  if (event.altKey) return true;
  if (event.ctrlKey) return true;
  if (event.keyCode == 67) return true; //del
  if (event.keyCode == 112) return true; //forward del
  
  parseInt(item.attr("maxLen"));
  if (item.val().length + 1 > maxLen) {
      return false;
    }
    return true;
}

$.fn.limitLength = function(len){
  $(this).keypress(function (event) {
    return limit_max_input($(this),event,len);
  });
}

$.fn.onlyNum = function () {
	$(this).keypress(function (event) {
	    var eventObj = event || e;
	    var keyCode = eventObj.keyCode || eventObj.which;
	    if ((keyCode >= 48 && keyCode <= 57))
		return limit_max_input($(this));
	    else return false;
	}).focus(function () {
	//禁用输入法
	this.style.imeMode = 'disabled';
	}).bind("paste", function () {
	//获取剪切板的内容
	    try{
		    var clipboard = window.clipboardData.getData("Text");
		    if (/^\d+$/.test(clipboard))
			return true;
		    else
			return false;
	    }
	    catch(e)
	    {
		    return true;
	    }
	});
};
	
// ----------------------------------------------------------------------
// <summary>
// 限制只能输入字母
// </summary>
// ----------------------------------------------------------------------
$.fn.onlyAlpha = function () {
    $(this).keypress(function (event) {
        var eventObj = event || e;
        var keyCode = eventObj.keyCode || eventObj.which;
        if ((keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122))
            return true;
        else
            return false;
    }).focus(function () {
        this.style.imeMode = 'disabled';
    }).bind("paste", function () {
        try
        {
            var clipboard = window.clipboardData.getData("Text");
            if (/^[a-zA-Z]+$/.test(clipboard))
                return true;
            else return false;
        }
        catch(err)
        {
          return true;  
        }
    });
};

// ----------------------------------------------------------------------
// <summary>
// 限制只能输入数字和字母
// </summary>
// ----------------------------------------------------------------------
$.fn.onlyNumAlpha = function () {
$(this).keypress(function (event) {
	var eventObj = event || e;
	var keyCode = eventObj.keyCode || eventObj.which;
	if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122))
	    return true;
	else
	    return false;
	}).focus(function () {
	this.style.imeMode = 'disabled';
	}).bind("paste", function () {
          try
          {
              var clipboard = window.clipboardData.getData("Text");
              if (/^(\d|[a-zA-Z])+$/.test(clipboard))
                  return true;
              else return false;
          }
          catch(err)
          {
            return true;  
          }
	});
};

$.fn.check = function(){
  $("#div_validate_error").remove();
  
  var msg = this.validate();
  if (msg == "") return true;
  
  console.log(this.html());
  e = '<div id="div_validate_error" style="color:red"';
  e += ' ctrl_id = "' + this.attr("id")+'" ';
  e += '>';
  e += '<span class="glyphicon glyphicon-warning-sign"></span>';
  e += msg;
  e += '<a href="#" style="float:right">放弃编辑</a>';
  e += "</div>";
  
  this.after(e) ;
  return false;
}

function check_browser_version()
{
	var userAgent = $(window).navigator.userAgent.toLowerCase();
	$.browser.ie10 = $.browser.msie && /msie 10\.0/i.test(userAgent);
	$.browser.ie9 = $.browser.msie && /msie 9\.0/i.test(userAgent);
	$.browser.ie8 = $.browser.msie && /msie 8\.0/i.test(userAgent);
	$.browser.ie7 = $.browser.msie && /msie 7\.0/i.test(userAgent);
	$.browser.ie6 = !$.browser.msie8 && !$.browser.msie7 && $.browser.msie && /msie 6\.0/i.test(userAgent);
}
 	
jQuery.extend(jQuery.validator.messages, {
        required: "请填写该信息",
        remote: "请修正该字段",
        email: "请输入正确格式的电子邮件",
        url: "请输入合法的网址",
        date: "请输入合法的日期",
        dateISO: "请输入合法的日期 (ISO).",
        number: "请输入合法的数字",
        digits: "只能输入整数",
        creditcard: "请输入合法的信用卡号",
        equalTo: "请再次输入相同的值",
        accept: "请输入拥有合法后缀名的字符串",
        maxlength: jQuery.validator.format("长度不能超过{0}个字"),
        minlength: jQuery.validator.format("长度不能少于{0}个字"),
        rangelength: jQuery.validator.format("输入长度应在{0}和{1}范围"),
        range: jQuery.validator.format("请输入一个在{0}和{1}之间的值"),
        max: jQuery.validator.format("请输入小于{0}的值"),
        min: jQuery.validator.format("请输入大于{0}的值")
});
        
jQuery.validator.addMethod("isPhone", function(value, element) {   
  var tel = /^(1[3|5|7|8])[\d]{9}$/;
  return this.optional(element) || (tel.test(value));
  }, "请填写正确的手机号码");

$.validator.setDefaults({
  	focusCleanup:false,
        onFocusOut:true,
});

function set_backgroup_img(url)
{
    function cover(){
      var win_width = $(window).width();
      var win_height = $(window).height();
      $("#bigpic").attr({width:win_width,height:win_height});
    }	
            
    $("body").append("<div id='main_bg' style='position: absolute; top: 0; left: 0; z-index: -1'/>");
    $("#main_bg").append("<img src='" + url + "' id='bigpic'>");
    cover();
    
    $(window).resize(function(){ //浏览器窗口变化
      cover();
    });
}

$(document).ready(function(e){
   $(".onlyNum").onlyNum();
    $(".onlyAlpha").onlyAlpha();
    $(".onlyNumAlpha").onlyNumAlpha();
    $(".limit_s").limitLength(6);
    $(".limit_m").limitLength(20);
    $(".limit_l").limitLength(100);
});
