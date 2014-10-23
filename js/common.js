// ----------------------------------------------------------------------
// <summary>
// 限制只能输入数字 http://www.cnblogs.com/xdp-gacl/p/3467245.html
// </summary>
// ----------------------------------------------------------------------
$.fn.onlyNum = function () {
	$(this).keypress(function (event) {
	    var eventObj = event || e;
	    var keyCode = eventObj.keyCode || eventObj.which;
	    if ((keyCode >= 48 && keyCode <= 57))
		return true;
	    else
		return false;
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

var validate_rex = [{class:"onlyNum",rex:/^\d+$/,msg:"只能输入数字"},
                    {class:"onlyAlpha",rex:/^[a-zA-Z]+$/,msg:"只能输入英文字母"},
                    {class:"onlyNumAlpha",rex:/^(\d|[a-zA-Z])+$/,msg:"只能输入数字和英文字母"},
                    {class:"onlyEmail",rex: /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/,msg:"只能输入正确的Email格式"},
                    {class:"onlyPhone",rex: /^(1[3|5|7|8])[\d]{9}$/,msg:"只能输入正确的手机格式"}
                   ];

$.fn.my_validate = function(){
  for(x in validate_rex)
  {
    x = validate_rex[x]
    if(this.hasClass(x.class))
    {
      if(!x.rex.test(this.val()))
      {
        return x.msg;
      }
    }
  } 
  return "";
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

function my_init()
{
    $(".onlyNum").onlyNum();
    $(".onlyAlpha").onlyAlpha();
    $(".onlyNumAlpha").onlyNumAlpha();
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

