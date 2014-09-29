<!DOCTYPE HTML>
<html>
<head>
{{!web_head}}
<script type="text/javascript" src="./js/md5.js"></script >
</head>
<body id="login_bg">
	<div class="login_wrapper">
		<div class="login_header">
        	<a href=""><img src="images/logo_white.png" width="285" height="62" alt="FEEL千千" /></a>
            <div id="cloud_s"><img src="res/cloud_s.png" width="81" height="52" alt="cloud" /></div>
            <div id="cloud_m"><img src="res/cloud_m.png" width="136" height="95"  alt="cloud" /></div>
        </div>
		<div class="login_box">
        	<div id="loginForm">
        		<ul class="register_radio clearfix">
		            <li>
		            	帅哥
		              	<input type="radio" value="0" name="type"> 
		            </li>
		            <li>
		           	    美女
		              	<input type="radio" value="1" name="type"> 
		            </li>
		        </ul> 
				<input type="text" id="nickname" name="nickname" tabindex="1" placeholder="昵称" class="easyui-validatebox textbox" data-options="required:true,validType:'length[2,20]',missingMessage:'昵称不能为空',invalidMessage:'请输入2~20个字的昵称',delay:999999999">
				
				<input type="text" id="phone" class="easyui-validatebox textbox" data-options="required:true,validType:'phone',missingMessage:'手机号不能为空',delay:999999999" placeholder="手机号" tabindex="2">
				
				<input type="password" id="password" class="easyui-validatebox textbox" data-options="required:true,validType:'length[6,20]',missingMessage:'密码不能为空',invalidMessage:'请输入6位数的密码',delay:999999999" placeholder="输入密码">
				<div>信息仅用于登陆验证，未经您的允许，不会推送广告</div>
				
            	<label class="fl registerJianJu" for="checkbox">
            		<input type="checkbox" id="checkbox" name="checkbox" checked="" class="checkbox valid">我已阅读并同意<a href="/agreement.html" target="_blank">《FEEL千千用户协议》</a>
           		</label>
                <input type="button" id="submitLogin" value="注 &nbsp; &nbsp; 册">
                <input type="hidden" id="business" name="callback" value="">
            </div>
            <div class="login_right">
            	<div>已有FEEL千千帐号</div>
            	<a href="/login" class="registor_now">直接登录</a>
                <div class="login_others">使用以下帐号直接登录:</div>
                <a href="http://www.lagou.com/ologin/auth/sina.html" target="_blank" class="icon_wb" title="使用新浪微博登录"></a>
               	<a href="http://www.lagou.com/ologin/auth/qq.html" class="icon_qq" target="_blank" title="使用腾讯QQ登录"></a>
            </div>
        </div>
        <div class="login_box_btm"></div>
    </div>
	<script src="/js/auto_complete_email.js" language="javascript" type="text/javascript"></script>
    <script type="text/javascript">
	$.extend($.fn.validatebox.defaults.rules, {
    phone: {
        validator: function(value, param){
			var tel_reg = /^(1[3|5|7|8])[\d]{9}$/;
			 return tel_reg.test(value);
        },
        message: '请输入正确的手机号'
		}
	});

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
	
    $(document).ready(function(e) {
    	$('.register_radio li input').click(function(e){
    		$(this).parent('li').addClass('current').append('<em></em>').siblings().removeClass('current').find('em').remove();
    	});
		
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
</body>
</html>
