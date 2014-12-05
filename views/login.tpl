<form id="form_login" style="margin-top: 20px">
	<div class="row">
		<div class="col-md-12">
			<input type="text" name="login_nickname" class="form-control limit_m" id="login_nickname" maxLen="11" placeholder="�ǳ�/�ֻ�����">
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<input type="password"  name="login_password" class="form-control limit_m" id="login_password"  style="width:100%;height:34px" placeholder="����">
		</div>
	</div>  
	<div class="row small">
		<div class="col-md-6">
		   <span class="checkbox_ctrl text-left" >�������</span>
		</div>
		<div class="pull-right col-md-6">
		   <a href="reset_pwd.html" target="_blank">�������룿</a>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<button id="btn_login" type="submit" class="btn btn-success form-control"  style="margin-top: 10px">��&nbsp; ¼</button>
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
     
     QUnit.test("check_pass",function(assert){
	assert.ok($("#login_password-error").text() == "", "error msg is hidden" );
	$("#login_password").focusin();
	$("#login_password").val("12345");
	$("#login_password").focusout();
	assert.ok($("#login_password-error").is(":visible"), "error msg is visibled");
	assert.ok($("#login_password-error").text().indexOf("���Ȳ�������6����") != -1,"wrong msg");

	$("#login_password").focusin();
	$("#login_password").val("");
	$("#login_password").focusout();
	assert.ok($("#login_password-error").text().indexOf("����д����Ϣ") != -1,"wrong msg");
	
	$("#login_password").focusin();
	$("#login_password").val("12345678901234567890x");
	$("#login_password").focusout();
	assert.ok($("#login_password-error").text().indexOf("���Ȳ��ܳ���20����") != -1,"wrong msg");
	});
     
      QUnit.asyncTest("check_nickname",function(assert){
	expect(6);
	assert.ok($("#nickname-error").text() == "", "error msg is hidden" );
	$("#nickname").focusin();
	$("#nickname").val("a");
	$("#nickname").focusout();
	assert.ok($("#nickname-error").is(":visible"), "error msg is visibled");
	assert.ok($("#nickname-error").text().indexOf("���Ȳ�������2����") != -1,"wrong msg");
 
	$("#nickname").focusin();
	$("#nickname").val("");
	$("#nickname").focusout();
	assert.ok($("#nickname-error").text().indexOf("����д����Ϣ") != -1,"wrong msg");
	
	$("#nickname").focusin();
	$("#nickname").val("123456789011");
	$("#nickname").focusout();
	assert.ok($("#nickname-error").text().indexOf("���Ȳ��ܳ���11����") != -1,"wrong msg");
	
	$("#nickname").focusin();
	$("#nickname").val("Ҧ˴Ҧ˴Ҧ˴Ҧ˴Ҧ˴");
	$("#nickname").focusout();
	
	setTimeout(function() {
		assert.ok($("#nickname-error").text() == "", "error msg is hidden" );	
		QUnit.start();
	}, 300);
     });
     </script>
%end     
