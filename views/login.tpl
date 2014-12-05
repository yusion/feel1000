<form id="form_login" style="margin-top: 20px">
	<div class="row">
		<div class="col-md-12">
			<input type="text" name="login_nickname" class="form-control limit_m" id="login_nickname" maxLen="11" placeholder="昵称/手机号码">
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<input type="password"  name="login_password" class="form-control limit_m" id="login_password"  style="width:100%;height:34px" placeholder="密码">
		</div>
	</div>  
	<div class="row small">
		<div class="col-md-6">
		   <span class="checkbox_ctrl text-left" >请记密码</span>
		</div>
		<div class="pull-right col-md-6">
		   <a href="reset_pwd.html" target="_blank">忘记密码？</a>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<button id="btn_login" type="submit" class="btn btn-success form-control"  style="margin-top: 10px">登&nbsp; 录</button>
		</div>
	</div>
</form>
<script type="text/javascript">
	function login_submit()
	{
		var sex = $('input:radio:checked').val();
		$.getJSON("action/register", 
		{ 	nick: $("#nickname").val(), 
			pass: hex_md5("pwd" + $("#password").val()),
			phone:$("#phone").val(), 
			sex:sex,
			age:$("#age").val()},
			function(json){
				$("#result").val(json.result);
		});
	}   
	
	$(document).ready(function(e){	
		$("#btn_login").click(function(e){		
			if(!$("#form_login").valid()) return;
			submit();
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
     QUnit.module("login");
     QUnit.asyncTest("start",function(assert){
	$("#link_login").click();
	assert.ok(true);
	setTimeout(function() {
		QUnit.start();
	}, 300);
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
     </script>
%end     
