
function assert(value,msg) {
  if (!value) {
    if (msg) {
      alert(msg);
    }
    else{
      alert("unknow error");  
    }
  }
}

//是否为单元测试 
var g_test = false;
function set_test(val){
  g_test = val;
}

function is_test(){
  return g_test;
}

//ie8 doesn't support indexOf 
function indexOfArray(array,elem){
  for(var i=0;i<array.length;i++){
    if (array[i] == elem) {
      return i;
    }
  }
  return -1;
}

//ie8 doesn't support trim
if(!String.prototype.trim2){
  String.prototype.trim2 = function(){
    return $.trim(this); //using jquery trim
  }
}


//增加jquery一些小功能  
(function(a) {
    a.fn.extend({
        DOM : function(){
          //转成js的DOM元素 
          return $(this)[0];
        },
        outerHTML: function() {
          //取外部的html
          if(!$(this).DOM()) return "";
          return $(this).DOM().outerHTML;
        },
        attrs: function(){
          //取所有属性 
          var a = new Object();
          if(!$(this).DOM()) return a;
          var t = $(this).DOM().attributes;
          for(x in t)
          {
            if (!t[x].name) {
              continue;
            }
            a[t[x].name] = t[x].value;
          }
          return a;
        },
        attrsStr:function(){
          //把属性转成字符串 
          var s = "";
          var a = $(this).attrs();
          for(k in a)
          { 
            s += k + "='" + a[k] + "'; ";
          }
          return s;
        },
        hasAttr:function(key){
          var a = $(this).attrs();
          for(k in a)
          {
            if (k == key) {
              return true;
            }
          }
          return false;
        },
        visible: function(){
          return $(this).is(":visible");
        },
        is_enabled :function(){
          return $(this).attr("disabled") != "disabled";
        },
        disabled : function(){
          $(this).attr({"disabled":"disabled"});
        },
        enabled:function(){
          $(this).removeAttr("disabled");
        },
        set_focus: function(){
          $(this).focus().select();  
        }
    })
})(jQuery);
    
//对HTML进行转义 
function html2Escape(sHtml) {
 var s = sHtml.replace(/[<>&'"]/g,function(c){return {"'":'&apos;','<':'&lt;','>':'&gt;','&':'&amp;','"':'&quot;'}[c];});
 return s.replace(/\s/ig, '&nbsp;');
}
 
//把转义后的字符反转 
function escape2Html(str) {
 var arrEntities={'lt':'<','gt':'>','nbsp':' ','amp':'&','quot':'"','apos':"'"};
 var s = str.replace(/&(lt|gt|nbsp|amp|quot|apos);/ig,function(all,t){return arrEntities[t];});
 var arrEntities = {'nbsp' : ' '};
 return s.replace(/&(nbsp);/ig, function(all, t){return arrEntities[t]})
}

//回车转为br标签
function return2Br(str) {
 return str.replace(/\r?\n/g,"<br />");
}
    
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
    
    var sel = "";  
    if (get_browser_info().ie) {
      var o = document.selection.createRange();
      if(o) sel = o.text;
    }
    else{
      sel = $(window).DOM().getSelection();
    }
    
    if(sel != "" && item.val().indexOf(sel) != -1) {
        return true;
    } 
    if (item.val().length + 1 > maxLen) {
        return false;
    }
    return true;
}

//可设置max_len属性来自定义最大输入长度 
$.fn.limitLength = function(len){
  $(this).each(function(){
    var ll = len;
      if ($(this).hasAttr("max_len")) {
        ll = parseInt($(this).attr("max_len"));
      }
    $(this).keypress(function (event) {
      return limit_max_input($(this),event,ll);
    });
  });
}

$.fn.onlyNum = function () {
	$(this).keypress(function (event) {
	    var eventObj = event || e;
	    var keyCode = eventObj.keyCode || eventObj.which;
	    if ((keyCode >= 48 && keyCode <= 57))
		return true;
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
  
  //console.log(this.html());
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

version=null;
function get_browser_info()
{
  if (version) {
    return version;
  }
  version = new Object();
    version.chrome = false;
    version.firefox = false;
    version.safari = false;
    version.mozilla = false;
    version.camino = false;
    version.opera = false;
    version.name = navigator.appName;
    version.ie = false;
    version.version = 0;
    
    var ua = navigator.userAgent.toLowerCase();
    if (window.ActiveXObject) {
      if (/msie 10\.0/i.test(ua)) {
       version.version = 10;
      }
      else if (/msie 9\.0/i.test(ua)) {
       version.version = 9;
      }
      else if (/msie 8\.0/i.test(ua)) {
       version.version = 8;
      }
      else if (/msie 7\.0/i.test(ua)) {
       version.version = 7;
      }
      else if (/msie 6\.0/i.test(ua)) {
       version.version = 6;
      }
      version.ie = true;
    }

    if (window.chrome) {
      version.chrome = true;
       version.version = ua.match(/chrome\/([\d.]+)/)[1];
       version.name = "chrome";
    }
    else if (ua.indexOf("firefox")>0) {
      version.firefox = ua.match(/firefox\/([\d.]+)/)[1];
    }
    else if (window.opera)
    {
      version.opera = true;
      version.version = ua.match(/opera.([\d.]+)/)[1];
    }
    else if (window.openDatabase)
    {
      version.safari = true;
      version.version = ua.match(/version\/([\d.]+)/)[1];
    }
    return version;
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

/**/
$.validator.setDefaults({
  	focusCleanup:false,
        onFocusOut:true
});


function set_background_img(url,object)
{
    if (!object) {
      object = $("body");
    }
  //set web background image
    function cover(){
      var win_width = object.width();
      //var win_height = object.height();
      $("#main_bg > img").attr({width:win_width,height:"auto"});
    }	
    object.after("<div id='main_bg' style='position: absolute; top: "
                 + object.offset().top+"px; left: "+object.offset().left+"px; z-index: -1000'/>");
    $("#main_bg").append("<img src='" + url + "'>");
    cover();
    
    $(window).resize(function(){ //浏览器窗口变化
        cover();
    });
}

function click_animate(button)
{
  var ss = $("<span>" +  button.text() + "<span>");
}

function create_img_div(left,top,width,height)
{
      var i = $("<div style='z-index:900'></div>");
      i.css("background-image","url('res/small_icon.png')");
      i.width(width);
      i.height(height);
      i.css("background-position",""+ left + "px " + top + "px");
      i.css("background-repeat","no-repeat");
      return i;
}

//基于标签的设置器 jquery ctrl, tag selector
(function ($) {
  /* example html
  <div>
    <input type="hidden" value="C++ PHP"></input>
    <ul>
      <li>C</li>
          <li>C++</li>
          <li>JAVA</li>
          <li>PHP</li>
          <li>Python</li>
    </ul>
  </div>
  
  编辑状态切换的方法，调用两次 
  $("#tagSelector").tag_selector({edit_mode:false});
  $("#tagSelector").tag_selector({edit_mode:true});
*/   
    $.fn.tag_selector = function(options){
        if (0 == $(this).find("ul").length) {
          assert(false,"tag_selector:wrong html,no ul");
          return;
        }
        var input = $(this).find("input:hidden");
        if (0 == input.length) {
          assert(false,"tag_selector:wrong html,no hidden input");
          return;
        }
        $(this).find("ul").hide();
        $(this).css("display","inline-block");
        
        var container = $(this);
        var selTags = new Array();
        var d = input.val().split(" ");
        for(var i=0;i<d.length;i++){
          var v = d[i].trim2();
          if (v.length) {
            if (indexOfArray(selTags,v) == -1) {
              selTags.push(v);
            }
          }
        }
        var allTags = new Array();
        container.find("li").each(function(){
          var v =$(this).text();
          if (indexOfArray(selTags,v) == -1) {
              if (indexOfArray(allTags,v) == -1) {
                allTags.push(v);
              }
          }
        });
        
        container.find(".tagItem, .divTagNew, .divSelTags, .link_show").remove(); //因为可能重复初始化
        var selContainer = $("<div class='divSelTags in_block'></div>");
        container.append(selContainer);

        if (!options.edit_mode){
            updateDiv();
            selContainer.find(".tagItem_edit").removeClass("tagItem_edit");
            return;
        }
        
        var editTag = $("<div class='divTagNew'><input /><a class='link_add icon-tag'>贴上</a><a class='link_close icon-remove-2'>关闭</a><HR><div class='divTagNewContant'></div></div>");
        container.append(editTag);
        editTag.children("input").limitLength(6);
        var editContainer = editTag.children(".divTagNewContant");
        updateDiv();

        function addTags(text) { 
           if (indexOfArray(selTags,text) != -1) {
              return;
           }
           selTags.push(text);
           updateDiv();
           updateEditDiv();
        }
        
        function removeTags(tagElem){
            tagElem.remove();
            var i = indexOfArray(selTags,html2Escape(tagElem.text()));
            if (i != -1) {
              selTags.splice(i,1); //删除元素 
            }
            updateDiv();
            updateEditDiv();
        }
        
        function updateDiv() {
            selContainer.empty();
            for (var s in selTags) {
              selContainer.append("<div class='tagItem tagItem_edit'>"+selTags[s]+"</div>");
            }
            input.val(selTags.join(" "));
            if (!options.edit_mode) {
              return;
            }
            
            selContainer.children(".tagItem").click(function(){
              removeTags($(this));
            });
             
            if(!container.find(".divTagNew").visible()) {
               var linkShow = $("<nobr><a class='link_show icon-tag' style='cursor: pointer;text-decoration: none;margin-left:10px'>添加</a></nobr>");
                selContainer.append(linkShow);
                linkShow.click(function(){
                  editTag.show();
                });
            }
        }
        
        function updateEditDiv(){
            if (!editContainer) {
              return;
            }
            editContainer.empty();
            var showHR = false;
            for(var i=0;i<allTags.length;i++){
              if (indexOfArray(selTags,allTags[i]) == -1) {
                editContainer.append("<div class='tagItem tagItem_edit'>"+allTags[i]+"</div>");
                showHR = true;
              }
            }
            if (showHR) {
              editTag.find("HR").show();
            }
            else{
              editTag.find("HR").hide();
            }
            editContainer.find(".tagItem").click(function(){
                addTags($(this).text());
            });
        }
        
        editTag.children(".link_add").click(function(){
          //添加自定义标签 
            var v = editTag.children("input").val();
            v = html2Escape(v.trim2());
            if (v.length) {
              addTags(v); 
            }
        });
        
        editTag.children(".link_close").click(function(){
          editTag.hide();
          updateDiv();
        });
        
        updateEditDiv();
        
        container.children(".tagItem").click(function(){
          removeTags($(this));
        });
        
    }
})(jQuery); 

//jquery ctrl, auto popup a div 
(function ($) {
    $.fn.inline_popup = function (options) {
        default_options = {
          "opacity":"0.8"
          };
          
        if (!options.opacity) {
          options.opacity = default_options.opacity;
        }
        var popup_ctrl = $(options.popup_ctrl);
        $(this).css("cusor","pointer");
        
        var leftX = 0;
        if($(this).css("margin-left"))
        {
          leftX+=parseInt($(this).css("margin-left"));
        }
        if($(this).css("padding-left"))
        {
          leftX+=parseInt($(this).css("padding-left"));
        }
        if($(this).css("border-left-width"))
        {
          leftX+=parseInt($(this).css("border-left-width"));
        }
        
        var bottomY = 0;
        if($(this).css("margin-bottom"))
        {
          bottomY+=parseInt($(this).css("margin-bottom"));
        }
        if($(this).css("padding-bottom"))
        {
          bottomY+=parseInt($(this).css("padding-bottom"));
        }
        if($(this).css("border-bottom-width"))
        {
          bottomY+=parseInt($(this).css("border-bottom-width"));
        }
        
        popup_ctrl.css({"opacity":options.opacity,
                "position":"absolute",
                "bottom":""+bottomY+"px",
              //  "left": ""+leftX+"px",
                "z-index":"1000",
                "cursor":"pointer",
                "display":"none"}); 
        
        $(this).each(function(){
          var this_ctrl = $(this);
          var new_popup_ctrl = null;
          function hideCtr()
          {
            new_popup_ctrl.hide();
            new_popup_ctrl.remove();
          }
          
          function showCtr()
          {
            var w = this_ctrl.width(); 
            new_popup_ctrl = popup_ctrl.clone();
            new_popup_ctrl.css({
                "width":""+w+"px"});
              this_ctrl.append(new_popup_ctrl);
              new_popup_ctrl.fadeIn(600);
          }

          this_ctrl.mouseenter(function(){
              showCtr();
            });
          
          this_ctrl.mouseleave(function(){
            hideCtr();
           });
        });
        return $(this);
    }
})(jQuery);

//设置自动弹出select控件,需设置 <select class="hover">
//注意要设置父元素的高度，要不然会跳变。。。 
function set_select_hover(elems){
    elems.css("cursor","pointer");
    elems.css("overflow","hidden"); 
    
    function reset(item){
         item.css("position","inherit");
         item.css("z-index","0");
         item.removeAttr("multiple");
         item.css("height","auto");
    }
    
    elems.each(function(){
         $(this).mouseenter(function(){
            var ww = $(this).width();
            $(this).attr("multiple","true");
            $(this).css("position","absolute");
            $(this).css("z-index","10000");
            
            var oldItem = $(this).children("option[selected]");
            var opItems = $(this).children("option");
            opItems.css("cursor","pointer");
            $(this).css("height","" +(opItems.length*20) + "px");
            $(this).width(ww);
            $(this).focus().select();
                    
            opItems.mouseenter(function(){
               $(this).parent().children("option[selected]").removeAttr("selected");
               $(this).attr("selected","selected");
             });
            
            opItems.click(function(){
               $(this).parent().children("option[selected]").removeAttr("selected");
               opItems.unbind("mouseenter");
               opItems.unbind("mouseleave");
               oldItem = $(this);
               oldItem.attr("selected","selected");
               reset($(this).parent());
             });
            
            opItems.mouseleave(function(){
                $(this).parent().children("option[selected]").removeAttr("selected");
                oldItem.attr("selected","selected");
             });
       });
      
      $(this).mouseleave(function(){
         reset($(this));
          });
   });
}

//设置自动弹出菜单 
function set_dropdown_hover(elems){
  elems.each(function(){
    
      var timerID1;
      var timerID2;
      var This = $(this);
      
      function showMenu()
      {
        This.addClass("open");
      }
      
      function hideMenu()
      {
        This.removeClass("open");
      }
      
      This.mouseenter(function(){
          This.siblings(".open").removeClass("open");
          clearTimeout(timerID1);
          clearTimeout(timerID2);
          showMenu();
        });
       
      This.mouseleave(function(){
          timerID1 = setTimeout(hideMenu,200);
        });
        
      This.find("ul").mouseenter(function(){
          clearTimeout(timerID1);
          clearTimeout(timerID2);
          showMenu();
        });
      This.find("ul").mouseleave(function(){
          timerID2 = setTimeout(hideMenu,200);
      });
  });
}
		

//set a auto popup div(#pop_div) on img element
function set_pop_div(img,pop_div) {
  pop_div.hide();
  
  function get_pop_div() {
     return img.parent().children(".is_pop_div");
  }
  
  function clearHide() {
    clearTimeout(parseInt(img.attr("timeout")));
    img.removeAttr("timeout");
    var div = get_pop_div();
    if (div) {
      clearTimeout(parseInt(div.attr("timeout")));
      div.removeAttr("timeout");
    }
  }
  
  function startHide(item){
    clearHide();
     var timeoutID = setTimeout(function(){
        get_pop_div().remove();
        },100);
      item.attr("timeout",timeoutID);
  }
     
  img.mouseenter(function(){
      clearHide();
          
      pop_div.css({"opacity":"0.5",
              "position":"absolute",
              "z-index":"1000",
              "top":"" + $(this).height() - pop_div.height() + "px",
              "left":"" + $(this).position().left + "px",
              "width":""+img.width()+"px",
              //"cursor":img.css("cursor"),
              "display":"none"});
      pop_div.addClass("is_pop_div");
      
      $(this).after(pop_div);
      
      pop_div.show();
      
      pop_div.click(function(){
        img.click();
        });
      
      pop_div.mouseenter(function(){
          clearHide();
        });
      
      pop_div.mouseleave(function(){
        startHide($(this));
        });
    });
  
    img.mouseleave(function(){
      startHide($(this));
      });
}

function keep_over(over_elem,under_elem)
{//keep over_elem always on under_elem
  function reset()
  {
    over_elem.css({"position":"absolute",
              "z-index":"900",// + under_elem.css("z-index"),
              "top":"" + (under_elem.position().top) + "px",
              "left":"" + (under_elem.position().left) +"px"
           //   "width":"20px",
           //   "height":"20px"
              });
  }
   reset();
  $(window).resize(function(){
			reset();
		});
}

function set_online_tag(elems,type,title) {
  if (!elems.length) {
    return;
  }
  elems.each(function(){
      //mark the person is cellphone online
      var i;
      if (type) {
        //phone
       i = create_img_div(-154,0,14,20);
      }
      else
      {
	i = create_img_div(-154,-20,17,17); 
      }
      i.css("position","absolute");
      i.css("left","" + $(this).position().left + "px");
      i.css("top","" + ($(this).position().top + $(this).height() - i.height()) +"px");
      i.attr("title",title);
      $(this).after(i);
   });
}

function set_imgtag(items,elem) {
    elem.css({"position":"absolute","top":"0px","left":"0px","z-index":"9000"});
    items.after(elem);
}

//breadcrumb navigator 
function push_breadcrumb(name,url) {
  if (!url) {
    url = window.location.pathname;
  }
  var link = $("<a href='" + url + "'>"+name+"</a>");
  $("#my_breadcrumb").append(link);
}

function pop_breadcrumb() {
  if ($("#my_breadcrumb a").length == 2) {
    return;
  }
  $("#my_breadcrumb a:last-child").remove();
}

function get_breadcrumb(){
  var s = ""
  $("#my_breadcrumb li").each(function(){
    s+= $(this).text().trim2() + "/";
  });
  return s.slice(0,s.length-1);
}

//把数值显示为多少千，多少万
function num_format(elems) {
  elems.each(function(){
      if(!/^\d+$/.test($(this).text())) {
        return;
      }
    
      var i = parseInt($(this).text());
      if (i == NaN) {
        return;
      }
      if (i >= 10000) {
        i /= 10000;
        $(this).text(Math.floor(i)+"万");
      }
      else if (i >= 1000) {
        i /= 1000;
        $(this).text(Math.floor(i)+"千");
      }
  });
}

//把时间显示为多少小时前
function data_format(elems) {   
    //字符串转成Time(dateDiff)所需方法 
    this.strToTime = function(str){ 
        var f = str.split(' ', 2); 
        var d = (f[0] ? f[0] : '').split('-', 3); 
        var t = (f[1] ? f[1] : '').split(':', 3); 
        return new Date( 
            parseInt(d[0]) || null, 
            (parseInt(d[1]) || 1)-1, 
            parseInt(d[2]) || null, 
            parseInt(t[0]) || null, 
            parseInt(t[1]) || null, 
            parseInt(t[2]) || null,
            0
            );
    };
    
    this.dateDiff = function(date1, date2){ 
        if(typeof(date1) == 'string') 
          date1 = strToTime(date1); 
        if(typeof(date2) == 'string') 
          date2 = strToTime(date2); 
        return (date1.getTime() - date2.getTime()) / 1000;//结果是秒 
    };

    this.secToStr = function(s)
    {
        if (s < 60) {
          return "刚刚";
        }
        s = (s/60).toFixed(0);
        if(s<=60)
        {
            return "" + s + "分钟";
        }
        s = (s/60).toFixed(0);
        if (s <= 24) {
          return "" + i + "小时";
        }
        
        s = (s/24).toFixed(0);
        if (s <=30) {
          return "" + s + "天";
        }
        
         s = (s/30).toFixed(0);
        if (s <=12) {
          return "" + s + "月";
        }
        
        s = (s/12).toFixed(0);
        return "" + s + "年";
    }
  
  if (!elems) {
    return;
  }
    //调用 dateDiff("2009-10-10 19:00:00","2009-10-10 18:00:00")
  var now = new Date();
    elems.each(function(){
        var s = dateDiff(now,$(this).text());
        $(this).text(secToStr(s) + "前");
    });
}

//自定义的checkbox
//html写法 <span class="checkbox_ctrl" checked="true">广东省</span>
//注意用is_check来判断是否被选中
$.fn.set_check = function (value) {
  if(value) {
    $(this).attr("checked","true");
  }
  else{
    $(this).removeAttr("checked");
  }
};

$.fn.is_check = function () {
  return $(this).hasAttr("checked"); //ie好象用attr("checked")查询不到  
};

$.fn.checkbox_ctrl = function () {
  $(this).click(function(){
    $(this).set_check(!$(this).is_check());
   });
};

/*自定义的Radio ctrl
<ul class="radio_ctrl" value="1">
  <li value="1" checked="checked">帅哥</li>
  <li value="0">美女</li>
</ul>
取值方法，取li的有checked属性的item
例如 $("ul>li[checked]")
*/
$.fn.radio_ctrl = function () {
  $(this).children("li").click(function(){
    if($(this).hasAttr("checked"))
    {
      return;
    }
    else
    {
      $(this).siblings().removeAttr("checked")
      $(this).attr("checked","checked");
    }
   });
};

$.fn.set_radio_val= function(value){
  $(this).children("li").removeAttr("checked");
  $(this).children("li").each(function(){
    if ($(this).val() == value) {
      $(this).attr("checked","checked");
    }
  });
};

$.fn.get_radio_val = function(){
  return $(this).children("li[checked]").val();
};


//自动回到顶端的小火箭
//html： <a class="visible-md visible-lg" id="returnTop" href="javascript:;">回到顶部</a>
var IMYUAN;
IMYUAN || (IMYUAN = {});

(function(a) {
    a.fn.extend({
        returntop: function() {
            if (this[0]) {
                var b = this.click(function() {
                    a("html, body").animate({
                        scrollTop: 0
                    },
                    120)
                }),
                c = null;
                a(window).bind("scroll",
                function() {
                    var ie6=!-[1,]&&!window.XMLHttpRequest;
                    var d = a(document).scrollTop(),
                    e = a(window).height();
                    0 < d ? b.css("bottom", "100px") : b.css("bottom", "-100px");
                    ie6 && (b.hide(), clearTimeout(c), c = setTimeout(function() {
                        b.show();
                        clearTimeout(c)
                    },
                    1E3), b.css("top", d + e - 125))
                })
            }
        }

    })
})(jQuery);


function placeholder_for_ie(){
   if (get_browser_info().ie)
   {
      //让IE支持password的placeholder
      $("input:password").each(function(){
        if ($(this).hasAttr("placeholder")) {
          if ($(this).hasClass("input-sm")) {
             $(this).addClass("pwd_placeholder_sm");
          }
          else if ($(this).hasClass("input-lg")) {
             $(this).addClass("pwd_placeholder_lg");
          }
          else{
             $(this).addClass("pwd_placeholder");
          }
          
          $(this).focus(function(){
            if ($(this).hasClass("pwd_placeholder_sm")) {
              $(this).removeClass("pwd_placeholder_sm");
            }
            else if ($(this).hasClass("pwd_placeholder_lg")) {
              $(this).removeClass("pwd_placeholder_lg");
            }
            else{
              $(this).removeClass("pwd_placeholder");
            }
          });
          
          $(this).blur(function(){
              if ($(this).val()) {
                return;
              }
              if ($(this).hasClass("input-sm")) {
                $(this).addClass("pwd_placeholder_sm");
              }
              else if ($(this).hasClass("input-lg")) {
                $(this).addClass("pwd_placeholder_lg");
              }
              else{
                $(this).addClass("pwd_placeholder");
              }
          });
        }
      });
   }
}

//写cookies
function setCookie(name,value)
{
//    var Days = 30;
//    var exp = new Date();
//    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
    
//    var strsec = getsec(time);
//    var exp = new Date();
//exp.setTime(exp.getTime() + strsec*1);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

//读取cookies
function getCookie(name)
{
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
 
    if(arr=document.cookie.match(reg))
 
        return (arr[2]);
    else
        return null;
}

//删除cookies
function delCookie(name)
{
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval=getCookie(name);
    if(cval!=null)
        document.cookie= name + "="+cval+";expires="+exp.toGMTString();
}

function is_visit()
{
  return $("#session").val().length < 8;
}

var jump_url = "";
var jump_param = null;

function jump_to(url,params)
{//跳转到某一页面
  if (is_test()) {
    jump_param = params;
    jump_url = url;  
  }
  if (!params) {
    location.href=url;
    return;
  }
  else{
      //构造表单对象，产生post请求 
      var postForm = document.createElement("form");
      postForm.method="post";   
      postForm.action = url;   
      for (p in params)
      {
        var input = document.createElement("input");
        input.setAttribute("name", p) ;   
        input.setAttribute("value", params[p]);
        postForm.appendChild(input);   
      }
      document.body.appendChild(postForm);   
      postForm.submit() ;   
      document.body.removeChild(postForm);
  }
}

function init_common()
{ 
    $(".onlyNum").onlyNum();
    $(".onlyAlpha").onlyAlpha();
    $(".onlyNumAlpha").onlyNumAlpha();
    $(".limit_s").limitLength(10);
    $(".limit_m").limitLength(20);
    $(".limit_l").limitLength(100);
    num_format($(".num_format"));
    data_format($(".data_format"));
    
    set_imgtag($(".hot_tag"),create_img_div(-158,-41,38,21));
    set_imgtag($(".new_tag"),create_img_div(-158,-76,38,19));
    
    set_online_tag($(".phone_online"),true,"手机在线");
    set_online_tag($(".online"),false,"在线");

    set_select_hover($("select.hover"))
    set_dropdown_hover($("div.dropdown-hover"));
     
    $(".checkbox_ctrl").checkbox_ctrl();
    $(".radio_ctrl").radio_ctrl();
    placeholder_for_ie();
}

$(document).ready(function(e){
  init_common();
  get_browser_info();
  $("#returnTop").returntop();
});

//保证最大字符串长度小于len 
function trim_str(str,len){
  if (str.length>len) {
    return str.substr(0,len)
  }
  return str;
}


