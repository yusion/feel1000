<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">

<html>
<head>
	<title></title>
</head>

<body>
</body>
</html>
{{!web_head}}
	<link href="css/uploadify.css" rel="stylesheet" type="text/css" />
	<script src="js/jquery.uploadify.min.js" type="text/javascript"></script>
</head>
<body>
{{!page_head}}		
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
		if(!current_item.check()) return;
		
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
		
		my_init();
        });
	
	window.onbeforeunload=leave_func;
	</script>

	<style type="text/css">
	#img_profile{
		cursor:pointer
	}
	</style>
    
<div class="container">
	<div class="row">
		<div class="col-md-5">
			<form class="form-horizontal" role="form">
			<div class="panel panel-primary">
			<div class="panel-heading">
			   <h3 class="panel-title">
						<span class="glyphicon glyphicon-heart-empty"></span>
						<span class="glyphicon glyphicon-heart-empty"></span>
						<span class="glyphicon glyphicon-heart-empty"></span>
						信息
				</h3>
			</div>
			<div class="panel-body">
				<div class="form-group">
					<label class="col-md-2 control-label">手机</label>
					<div class="col-md-10">
						<p id="phone" class="form-control-static">{{!phone}}</p>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">姓名</label>
					<div class="col-md-10">
						<input class="form-control txt_input " id="realname"  value="{{!realname}}" />
					</div>
					
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">QQ</label>
					<div class="col-md-10">
						<input class="txt_input onlyNum form-control" id="qq" value="{{!qq}}" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">邮件</label>
					<div class="col-md-10">
						<input class="txt_input onlyEmail form-control" id="email" value="{{!email}}" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">微博</label>
					<div class="col-md-10">
						<input class="txt_input form-control" id="blogid" value="{{!blogid}}" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">住址</label>
					<div class="col-md-10">
						<input class="txt_input form-control" id="address" value="{{!address}}" />
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label">城市</label>
					<div class="col-md-10">
						<input class="txt_input form-control" id="city" value="{{!city}}" />
					</div>
				</div>
			</div>
			</div>
			<div class="panel panel-info">
				<div class="panel-heading ">
					<h3 class="panel-title">
						<span class="glyphicon glyphicon-heart-empty"></span>
						<span class="glyphicon glyphicon-heart-empty"></span>
						信息
					</h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label class="col-md-2 control-label">职务</label>
						<div class="col-md-10">
							<input class="txt_input form-control" id="career"  value="{{!career}}" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">收入</label>
						<div class="col-md-10">
							<select id="income" class="txt_input form-control">
								%for x in c_income:
									<option value="{{x[0]}}" 
									%if x[0] == income:
										selected="selected"
									%end
									>{{x[1]}}</option>
								%end
							</select> 
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">公司</label>
						<div class="col-md-10">
							<input class="txt_input form-control" id="campany"  value="{{!campany}}" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">学校</label>
						<div class="col-md-10">
							<input class="txt_input form-control" id="school"  value="{{!school}}" /> 
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">学历</label>
						<div class="col-md-10">
							 <select id="degree" class="txt_input  form-control">
							%for x in c_degree:
								<option value="{{x[0]}}"
								%if x[0] == degree:
									selected="selected"
								%end
								>{{x[1]}}</option>
							%end
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="panel panel-success">
				 <div class="panel-heading">
					<h3 class="panel-title">
						<span class="glyphicon glyphicon-heart-empty"></span>
						信息
					</h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label class="col-md-2 control-label">年龄</label>
						<div class="col-md-10">
							<input class="txt_input onlyNum  form-control" id="age"  value="{{!age}}" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">星座</label>
						<div class="col-md-10">
							<select id="star" class="txt_input form-control">
							%for x in c_star:
							<option value="{{x[0]}}"
								%if x[0] == star:
									selected="selected"
								%end
								>{{!x[1]}}</option>
							%end
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">身高</label>
						<div class="col-md-10">
							<div class="input-group">
								<input class="txt_input onlyNum form-control" id="height"  value="{{!height}}" />
								<span class="input-group-addon">厘米</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">体重</label>
						<div class="col-md-10">
							<div class="input-group">
								<input class="txt_input onlyNum form-control" id="weight"  value="{{!weight}}" />
								<span class="input-group-addon">公斤</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			</form>
		</div>
		<div class="col-md-6">
			<div class="row">
				<img id="img_profile" class="img-responsive img-rounded" src="{{photo_url}}" alt="头像"></img>
				<input type="file" name="uploadify" id="uploadify" />
				<div id="fileQueue">
				</div>	
			</div>		
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">
						<span class="glyphicon glyphicon-heart-empty"></span>
						信息
					</h3>
				</div>
				<div class="panel-body">
					<div class="form-group">
						<label class="col-md-2 control-label">描述</label>
						<div class="col-md-10">
							<textarea class="form-control" rows="10" cols="10"></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label">标签</label>
						<div class="col-md-10">
							<input class="txt_input form-control"/>
						</div>
					</div>
				</div>
			</div>
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
	</div>
</div>

{{!page_foot}}		
</body>
</html>