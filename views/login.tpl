<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>
	{{!web_head}}
</head>
<body>
{{!page_head}}
	<div class="container">
		<div class="row" style="height: 200px"></div>
		<div class="row">
			<div class="col-xs-5 col-xs-offset-1">
				<form class="form-horizontal" role="form" style="background-color: yellow">
					<div class="form-group">
						<div class="col-xs-8 col-xs-offset-2">
						   <input type="text" name="nickname" class="form-control limit_m" id="nickname" maxLen="20" placeholder="昵称/手机号">
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-8 col-xs-offset-2">
						   <input type="password" name="password" class="form-control limit_m" id="password" placeholder="密码">
						</div>
					</div>  
					<div class="form-group">
						<div class="col-xs-4 col-xs-offset-2">
						   <div class="checkbox">
						      <label>
							 <input type="checkbox">请记住我
						      </label>
						   </div>
						</div>
						<div class="pull-right col-xs-4">
						   <a href="reset_pwd.html" class="fr" target="_blank">忘记密码？</a>
						</div>
					     </div>
					<div class="form-group">
						<div class="col-xs-12 col-xs-offset-2 ">
						   <button id="btn_login" type="submit" class="btn btn-primary">登&nbsp; 录</button>
						</div>
						
					     </div>
				</form>
			</div>
			<div class="col-xs-4" style="background-color: #EEE2E2">
					<div class="row">
						<div class="col-xs-12">
							还没有帐号？
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12">
							<a  href="register"  class="registor_now">免费注册</a>
						</div>
					</div>
					<div class="row" style="height:100px"></div>
					<div class="row">
						<div class="col-xs-12">
							使用以下帐号直接登录:
						</div>
					</div>
					<div class="row">
						<div class="col-xs-6">
							<a  href="ologin/auth/sina.html"  target="_blank" class="icon_wb">使用新浪微博登录</a>
						</div>
						<div class="col-xs-6">
							<a  href="ologin/auth/qq.html"  class="icon_qq" target="_blank">使用腾讯QQ登录</a>
						</div>
					</div>
			</div>
		</div>
	</div>
    </div>
<script type="text/javascript">	
	function submit()
	{
	}
	
	$(document).ready(function(e){
		$("#btn_login").click(function(e){		
			if(!$("form").valid()) return;
			submit();
		});
		
		$("form").validate({
			rules: {
			   nickname: {required:true,minlength:2,maxlength:20},
			   password:{required: true,minlength:6,maxlength:20}
			   }
			});
		
		set_background_img("res/login_bg.jpg")
	});
    </script>

 %if is_test:
     <script type="text/javascript">
     QUnit.module("login");
     </script>
%end     
     
{{!page_foot}}	    
</body>
</html>
