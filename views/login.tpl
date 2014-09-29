<!DOCTYPE HTML>
<html>
<head>
{{!web_head}}
</head>
<body id="login_bg">
	<div class="login_wrapper">
		<div class="login_header">
        	<a href=""><img src="images/logo_white.png" width="285" height="62" alt="FEEL千千" /></a>
            <div id="cloud_s"><img src="res/cloud_s.png" width="81" height="52" alt="cloud" /></div>
            <div id="cloud_m"><img src="res/cloud_m.png" width="136" height="95"  alt="cloud" /></div>
        </div>
        
    	<input type="hidden" id="resubmitToken" value="" />		
		 <div class="login_box">
        	<form id="loginForm">
				<input type="text" id="email" name="email" value="" tabindex="1" placeholder="昵称/邮箱/手机号" />
			  	<input type="password" id="password" name="password" tabindex="2" placeholder="密码" />
			    <span class="error" style="display:none;" id="beError"></span>
			    <label class="fl" for="remember"><input type="checkbox" id="remember" value="" checked="checked" name="autoLogin" />牵挂我</label>
			    <a href="reset.html" class="fr" target="_blank">忘记密码？</a>
			    <input type="submit" id="submitLogin" value="登 &nbsp; &nbsp; 录" />
			    
			    <input type="hidden" id="callback" name="callback" value=""/>
                <input type="hidden" id="authType" name="authType" value=""/>
                <input type="hidden" id="signature" name="signature" value=""/>
                <input type="hidden" id="timestamp" name="timestamp" value=""/>
			</form>
			<div class="login_right">
				<div>还没有FEEL千千帐号？</div>
				<a  href="register"  class="registor_now">免费注册</a>
			    <div class="login_others">使用以下帐号直接登录:</div>
			    <a  href="ologin/auth/sina.html"  target="_blank" class="icon_wb" title="使用新浪微博登录"></a>
			    <a  href="ologin/auth/qq.html"  class="icon_qq" target="_blank" title="使用腾讯QQ登录"></a>
			</div>
        </div>
        <div class="login_box_btm"></div>
    </div>
</body>
</html>
