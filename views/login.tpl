<style type="text/css">
#form_login .row{
	margin-bottom: 15px;
}
</style>
<form id="form_login" style="margin-top: 20px">
	<div class="row" style="padding-top: 17px">
		<div class="col-md-12">
			<input type="text" name="login_nickname" class="form-control limit_m input-lg" id="login_nickname" maxLen="11" placeholder="昵称">
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<input type="password"  name="login_password" class="form-control limit_m input-lg" id="login_password"  placeholder="密码">
		</div>
	</div>  
	<div class="row ">
		<div class="col-md-8">
		   <div id="div_autologin" class="checkbox_ctrl text-left" >下次自动登录</div>
		</div>
		<div class="pull-right col-md-4">
		   <!-- TODO: 自动发送密码到邮箱中，需经过身份认证 -->
		   <a href="reset_pwd.html" target="_blank" style="color:gray">忘记密码？</a>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<button id="btn_login" type="submit" style="width:100%;font-size: 18px;height:45px" class="orange_btn">
				登&nbsp; 录&nbsp;<i class="icon-music" style="color:mediumorchid"></i>
			</button>
			<input type="hidden" id="login_result_msg" value="unknown">
			<input type="hidden" id="login_result" value="unknown">
		</div>
	</div>
</form>
<script type="text/javascript">
	function login_submit()
	{
		$("#btn_login").disabled();
		$.getJSON("action/login", 
		{ 	nick: $("#login_nickname").val(),
			pass: hex_md5("pwd" + $("#login_password").val())},
			function(json){
				$("#login_result").val(json.result);
				$("#login_result_msg").val(json.msg);
				if (json.result == "true") {
					var params = {"session":json.session};
					if ($("#div_autologin").is_check()) {
						params.save = "1";
					}
					jump_to("index2",params);
					$("#btn_login").enabled();
				}
				else{
					$("#login_password").val("");
					alert("登陆失败："+json.msg);
					$("#btn_login").enabled();
					$("#login_password").set_focus();
				}
		});
	}   
	
	$(document).ready(function(e){	
		$("#btn_login").click(function(e){		
			if(!$("#form_login").valid()) return;
			login_submit();
		});
		
		$("#form_login").validate({
			rules: {
			   login_nickname: {required:true,minlength:2,maxlength:11},
			   login_password:{required: true,minlength:6,maxlength:20}
			}
		});
	});
</script>

%if is_test:
<script type="text/javascript">
     jump_url = "";
     QUnit.module("login");
       QUnit.asyncTest("start",function(assert){
	$("#link_login").click();
	assert.ok(true);
	setTimeout(function() {
		QUnit.start();
	}, 300);
     });
	 
     QUnit.test("checkbox",function(assert){
	expect(5);
	assert.ok(!$("#div_autologin").is_check());
	$("#div_autologin").set_check(true);
	assert.ok($("#div_autologin").is_check());
	$("#div_autologin").set_check(false);
	assert.ok(!$("#div_autologin").is_check());
	$("#div_autologin").click();
	assert.ok($("#div_autologin").is_check());
	$("#div_autologin").click();
	assert.ok(!$("#div_autologin").is_check());
     });
     
     QUnit.test("check_pass",function(assert){
	$("#link_login").click();
	assert.ok($("#login_password-error").text() == "", "error msg is hidden" );
	$("#login_password").focusin();
	$("#login_password").val("12345");
	$("#login_password").focusout();
	
	assert.ok($("#login_password-error").visible(), "error msg is visibled");
	assert.ok($("#login_password-error").text().indexOf("长度不能少于6个字") != -1,"wrong msg");

	$("#login_password").focusin();
	$("#login_password").val("");
	$("#login_password").focusout();
	assert.ok($("#login_password-error").text().indexOf("请填写该信息") != -1,"wrong msg");
	
	$("#login_password").focusin();
	$("#login_password").val("12345678901234567890x");
	$("#login_password").focusout();
	assert.ok($("#login_password-error").text().indexOf("长度不能超过20个字") != -1,"wrong msg");
	});
     
      QUnit.asyncTest("check_nickname2",function(assert){
	expect(6);
	assert.ok($("#nickname-error").text() == "", "error msg is hidden" );
	$("#login_nickname").focusin();
	$("#login_nickname").val("a");
	$("#login_nickname").focusout();
	assert.ok($("#login_nickname-error").visible(), "error msg is visibled");
	assert.ok($("#login_nickname-error").text().indexOf("长度不能少于2个字") != -1,"wrong msg");
 
	$("#login_nickname").focusin();
	$("#login_nickname").val("");
	$("#login_nickname").focusout();
	assert.ok($("#login_nickname-error").text().indexOf("请填写该信息") != -1,"wrong msg");
	
	$("#login_nickname").focusin();
	$("#login_nickname").val("123456789011");
	$("#login_nickname").focusout();
	assert.ok($("#login_nickname-error").text().indexOf("长度不能超过11个字") != -1,"wrong msg");
	
	$("#login_nickname").focusin();
	$("#login_nickname").val("姚舜姚舜姚舜姚舜姚舜");
	$("#login_nickname").focusout();
	
	setTimeout(function() {
		assert.ok($("#login_nickname-error").text() == "", "error msg is hidden" );	
		QUnit.start();
	}, 300);
     });

      QUnit.asyncTest("login_failed",function(assert){
	expect(6);
	jump_url = "";
	$("#login_nickname").val("ycat");
	$("#login_password").val("wrongpass");
	$("#btn_login").click();
	assert.ok(!$("#btn_login").is_enabled());
	setTimeout(function() {
		assert.equal($("#login_result").val(),"false");
		assert.equal($("#login_result_msg").val(),"用户名或密码不正确");
		assert.equal($("#login_password").val(),"");
		assert.ok($("#btn_login").is_enabled());
		assert.equal(jump_url,"");
		QUnit.start();
	}, 1000);
      });  

      QUnit.asyncTest("login_success_part1",function(assert){
	expect(1);
	$.getJSON("action/register", 
		{nick: "test_ycat3", 
		pass: hex_md5("pwdabcd123"),
		sex:"1"	, 
		age:"21"},
		function(json){
			assert.equal(json.result,"true");
			QUnit.start();
		});
       });
      
      QUnit.asyncTest("login_success_part2",function(assert){
	expect(7);
	jump_url = "";
	jump_param = null;
	$("#login_nickname").val("test_ycat3");
	$("#login_password").val("abcd123");
	$("#btn_login").click();
	$("#div_autologin").set_check(false);
	assert.ok(!$("#btn_login").is_enabled());
	setTimeout(function() {
		assert.equal($("#login_result").val(),"true");
		assert.equal($("#login_result_msg").val(),"test_ycat3, 欢迎您回来");
		assert.ok($("#btn_login").is_enabled());
		assert.equal(jump_url,"index2");
		assert.ok(jump_param["session"]);
		assert.ok(!jump_param["save"]); 
		QUnit.start();
	}, 800);
       });
      
       QUnit.asyncTest("login_success_part2",function(assert){
	expect(7);
	jump_url = "";
	jump_param = null;
	$("#login_nickname").val("test_ycat3");
	$("#login_password").val("abcd123");
	$("#btn_login").click();
	$("#div_autologin").set_check(true);
	assert.ok(!$("#btn_login").is_enabled());
	setTimeout(function() {
		assert.equal($("#login_result").val(),"true");
		assert.equal($("#login_result_msg").val(),"test_ycat3, 欢迎您回来");
		assert.ok($("#btn_login").is_enabled());
		assert.equal(jump_url,"index2");
		assert.ok(jump_param["session"]);
		assert.ok(jump_param["save"]); 
		$.getJSON("test/del_user");
		QUnit.start();
	}, 800);
       });  
</script>
%end     
