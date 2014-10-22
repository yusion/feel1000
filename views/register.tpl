<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">

<html>
<head>
	<title>FEEL千千</title>
	{{!web_head}}
	<script type="text/javascript" src="./js/md5.js"></script >
</head>
<body>
 
{{!page_head}}
<form class="form-horizontal" role="form">
	<div row>
		<div class="col-sm-4 col-sm-offset-4">
			<div class="form-group">
				<label class="btn btn-info col-sm-3">
					<input type="radio" name="options" id="option1" value="0">帅哥
				</label>
				<label class="btn btn-warning col-sm-3  col-sm-offset-1">
					<input type="radio" name="options" id="option2" value="1">美女
				</label>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" id="nickname" placeholder="昵称">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" id="phone" placeholder="手机号码">
			</div>
			<div class="form-group">
				<input type="password" class="form-control" id="password" placeholder="密码">
			</div>
			<div class="form-group">
				<label>信息仅用于登陆验证，无广告推送</label>
				<label>
					<input id="checkbox" type="checkbox" checked="">我已阅读并同意<a href="/agreement.html" target="_blank">《FEEL千千用户协议》</a>
				</label>
			</div>
			<div class="form-group">
				<div class="col-sm-10">
				   <button type="submit" class="btn btn-primary">注&nbsp; 册</button>	
				</div>
				<div class="pull-right ">
				   <a href="/login" class="registor_now">直接登录</a>
				</div>
			</div>
		</div>
	</div>
</form>

     <script type="text/javascript">
	function submit()
	{
		var sex = $('input:radio:checked').val();
		
		$.getJSON("action/register", 
			{ 	nick: $("#nickname").val(), 
				pass: hex_md5($("#password").val()),
				phone:$("#phone").val(), 
				sex:sex},
				function(json){
					alert("JSON Data: " + json.result);
				});
	}
	
    $(document).ready(function(e)	      {
 		$("#checkbox").click(function(e){
			if(!$("#checkbox").attr("checked"))
				$("#submitLogin").hide(600);
			else $("#submitLogin").show(600);
		});
		
		$("#submitLogin").click(function(e){		
			$(".easyui-validatebox").validatebox("validate");		
			var v = true;
			$(".easyui-validatebox").each(function(i){
				if(!$(this).validatebox("isValid")) 
				{
					v = false;
					return;
				}
			});			
			if(!v) return;
			
			submit();
		});
    });
    </script>
{{!page_foot}}	    
</body>
</html>
