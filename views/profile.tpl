<!DOCTYPE HTML>
<html>  
<head>
	{{!web_head}}
	<link href="css/uploadify.css" rel="stylesheet" type="text/css" />
	<script src="js/jquery.uploadify.min.js" type="text/javascript"></script>
</head>
<body onbeforeonload="alert('bbb')">
<script type="text/javascript">
function uploadfile()
{
	$("#uploadify").uploadify({
		    //指定swf文件
		    'swf': 'res/uploadify.swf',
		    //后台处理的页面
		    'uploader': 'action/upload_profile_photo',
		    //按钮显示的文字
		    'buttonText': '上传图片',
		    //显示的高度和宽度，默认 height 30；width 120
		    //'height': 15,
		    //'width': 80,
		    //上传文件的类型  默认为所有文件    'All Files'  ;  '*.*'
		    //在浏览窗口底部的文件类型下拉菜单中显示的文本
		    'fileTypeDesc': 'Image Files',
		    //允许上传的文件后缀
		    'fileTypeExts': '*.gif; *.jpg; *.png; *.bmp',
		    //发送给后台的其他参数通过formData指定
		    //'formData': { 'someKey': 'someValue', 'someOtherKey': 1 },
		    //上传文件页面中，你想要用来作为文件队列的元素的id, 默认为false  自动生成,  不带#
		    //'queueID': 'fileQueue',
		    //选择文件后自动上传
		    'auto': true,
		    //设置为true将允许多文件上传
		    'multi': false,
		    'onUploadSuccess': function (file, data, response) {
			//$('#' + file.id).find('.data').html(' 上传完成');
			    $("#img_profile").attr("src","my_images/" + Math.random() + Math.random());
			}
		});
}
var current_item;

function set_old_value(item)
{
	item.attr("old",item.val());
	current_item = item;
}

function is_changed()
{
	if (!current_item) return false;
	if(current_item.attr("old") == current_item.val())
	{
		return false;
	}
	return true;
}

function save_item()
{
	if (!is_changed()) {
		return;
	}
	
	current_item.css("font-weight","bold");
	jQuery.getJSON("action/update_profile", 
		{
			key: current_item.attr("id"), 
			value: current_item.val()},
			function(json){
				if(json.result != "success")
					alert(json.result); //TODO error display
				$("#"+json.id).css("font-weight","normal");
				$("#"+json.id).attr("old",$("#"+json.id).val());
				current_item = null;
		});
}

function leave_func()
{
	save_item();
	if (is_changed())
	{
		return "FEEL千千：正在保存修改信息";
	}
} 
        $(function () {
		uploadfile();
		
		//set old value 
		$("input").focus(function(){
			set_old_value($(this));
		});
		
		$("select").focus(function(){
			set_old_value($(this));
		});
		
		//save input value into db 
		$(".txt_input").blur(function(){
			save_item();
		});
		
	
        });
    
    $.fn.datebox.defaults.formatter = function(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	return y + '年' + m + '月' + d + '日';
	};
	
    $.fn.calendar.defaults.months = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
    $.fn.calendar.defaults.weeks = ['日','一','二','三','四','五','六'];
    
    
    window.onbeforeunload=leave_func;
    </script>
	
    
    <style type="text/css">

#div_container{
	border: medium double rgb(250,0,255);
	width: 90%;
	height: 800px;
	margin: auto;
	}
	
#div_left_container{
	border: medium double rgb(0,255,255);
	width: 50%;
	height: 800px;
	float: left
	}
	
#div_right_container{border: medium double blue;
	margin: auto;
	height: 800px;
	float: left
	}
	
#div_class1,#div_class2,#div_class3 {
	border: medium double rgb(100,155,0);
	height: 220px;
}

ul div{
	width : 50px;
	display: inline-block
}

.txt_input{
	width: 200px;
	border-top-style:none;
	border-left-style:none;
	border-right-style:none;
	border-color: black;
	
}

#img_profile{
	cursor:pointer
}

</style>
	
<div id="div_body">
	<div id="div_container">
		<div id="div_left_container">
			<img id="img_profile" src="{{photo_url}}"></img>	
		        <input type="file" name="uploadify" id="uploadify" />
		        <div id="fileQueue">
		        </div>
			<BR>
			<BR>
			无注册0星：相片，妮称（*），年龄（*），描述（前10个字加...）<BR>
			注册0星：相片，妮称，描述，年龄<BR>
			1星：聊天，主页，相册,生物信息，前提：已经注册<BR>
			2星：学校信息，公司信息，好友统计信息，前提：已经相片验证，1星2星期<BR>
			3星：通信信息，真实姓名，前提：已经身份证验证，2星2星期<BR>
			4星：仅能有9个，3星2星期<BR>
			5星：仅能有3个，4星2星期<BR>
			Soul Mate：仅能有1个<BR>
		</div>
		<div id="div_right_container">
			<div id="div_class3" >
				<ul>
					<li><div>姓名:</div><input class="txt_input" id="realname"  value="{{!realname}}" /></li>
					<li><div>手机:</div><input class="txt_input" id="phone" value="{{!phone}}" /></li>
					<li><div>QQ: </div><input class="txt_input" id="qq" value="{{!qq}}" /></li>
					<li><div>邮件:</div><input class="txt_input" id="email" value="{{!email}}" /></li>
					<li><div>微博:</div><input class="txt_input" id="blogid" value="{{!blogid}}" /></li>
					<li><div>住址:</div><input class="txt_input" id="address" value="{{!address}}" /></li>
					
					<li><div>城市:</div><input class="txt_input" id="city" value="{{!city}}" /></li>
				</ul>
			</div>
			<div id="div_class2" >
				<ul>
					<li><div>职务:</div><input class="txt_input" id="career"  value="{{!career}}" /></li>
					<li><div>收入:</div>
						<select id="income" class="txt_input">
							%for x in c_income:
								<option value="{{x[0]}}" 
								%if x[0] == income:
									selected="selected"
								%end
								>{{x[1]}}</option>
							%end
						</select>
					</li>
					<li><div>公司:</div><input class="txt_input" id="campany"  value="{{!campany}}" /></li>
					<li><div>学校:</div><input class="txt_input" id="school"  value="{{!school}}" /></li>
					<li><div>学历:</div>
						<select id="degree" class="txt_input">
						%for x in c_degree:
							<option value="{{x[0]}}"
							%if x[0] == degree:
								selected="selected"
							%end
							>{{x[1]}}</option>
						%end
						</select>
					</li>
				</ul>
			</div>
			<div id="div_class1" >
				<ul>
					<li><div>年龄:</div><input class="txt_input" id="age"  value="{{!age}}" /></li>
					<li><div>星座:</div>
						<select id="star" class="txt_input">
						%for x in c_star:
						<option value="{{x[0]}}"
							%if x[0] == star:
								selected="selected"
							%end
							>{{!x[1]}}</option>
						%end
					  </select>
					</li>
					<li><div>身高:</div><input class="txt_input" id="height"  value="{{!height}}" />厘米</li>
					<li><div>体重:</div><input class="txt_input" id="weight"  value="{{!weight}}" />公斤</li>
					
					<li><div>描述:</div><textarea rows="3" cols="10" style="width:200px;height: 30px"></textarea></li>
					<li><div>标签:</div><input class="txt_input"/></li>
				</ul>
			</div>
		</div>
	</div>
	
	
</body>
</html>