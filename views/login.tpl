<style type="text/css">
#form_login .row{
	margin-bottom: 15px;
}
</style>
<form id="form_login" style="margin-top: 20px">
	<div class="row" style="padding-top: 17px">
		<div class="col-md-12">
			<input type="text" name="login_nickname" class="form-control limit_m input-lg" id="login_nickname" maxLen="11" placeholder="�ǳ�">
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<input type="password"  name="login_password" class="form-control limit_m input-lg" id="login_password"  placeholder="����">
		</div>
	</div>  
	<div class="row small">
		<div class="col-md-8">
		   <div class="checkbox_ctrl text-left" >�´��Զ���¼</div>
		</div>
		<div class="pull-right col-md-4">
		   <a href="reset_pwd.html" target="_blank" style="color:gray">�������룿</a>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<button id="btn_login" type="button" style="width:100%" class="btn btn-success btn-lg">��&nbsp; ¼&nbsp;<i class="icon-music" style="color:mediumorchid"></i></button>
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
					$("#btn_login").enabled();
					$("#session").val(json.session);
					document.cookie="session="+json.session; 
				}
				else{
					$("#login_password").val("");
					setTimeout(function(){
						$("#btn_login").enabled();
					},500);
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
     
      QUnit.asyncTest("check_nickname2",function(assert){
	expect(6);
	assert.ok($("#nickname-error").text() == "", "error msg is hidden" );
	$("#login_nickname").focusin();
	$("#login_nickname").val("a");
	$("#login_nickname").focusout();
	assert.ok($("#login_nickname-error").visible(), "error msg is visibled");
	assert.ok($("#login_nickname-error").text().indexOf("���Ȳ�������2����") != -1,"wrong msg");
 
	$("#login_nickname").focusin();
	$("#login_nickname").val("");
	$("#login_nickname").focusout();
	assert.ok($("#login_nickname-error").text().indexOf("����д����Ϣ") != -1,"wrong msg");
	
	$("#login_nickname").focusin();
	$("#login_nickname").val("123456789011");
	$("#login_nickname").focusout();
	assert.ok($("#login_nickname-error").text().indexOf("���Ȳ��ܳ���11����") != -1,"wrong msg");
	
	$("#login_nickname").focusin();
	$("#login_nickname").val("Ҧ˴Ҧ˴Ҧ˴Ҧ˴Ҧ˴");
	$("#login_nickname").focusout();
	
	setTimeout(function() {
		assert.ok($("#login_nickname-error").text() == "", "error msg is hidden" );	
		QUnit.start();
	}, 300);
     });
     
      QUnit.asyncTest("login_failed",function(assert){
	expect(5);
	$("#login_nickname").val("ycat");
	$("#login_password").val("wrongpass");
	$("#btn_login").click();
	assert.ok(!$("#btn_login").is_enabled());
	setTimeout(function() {
		assert.equal($("#login_result").val(),"false");
		assert.equal($("#login_result_msg").val(),"�û��������벻��ȷ");
		assert.equal($("#login_password").val(),"");
		assert.ok($("#btn_login").is_enabled());
		QUnit.start();
	}, 1000);
      });
      
      QUnit.asyncTest("login_success",function(assert){
	expect(7);
	$("#nickname").val("test_ycat3");
	$("#phone").val("13728975541");
	$("#password").val("123456");
	$("#age").val("21");
	$("#radio_female").attr("checked",true);
	$("#btn_register").click();
	
	setTimeout(function() {
		$("#login_nickname").val("test_ycat3");
		$("#login_password").val("123456");
		$("#btn_login").click();
		assert.ok(!$("#btn_login").is_enabled());
		assert.equal($("#session").val(),"-1");
		setTimeout(function() {
			assert.equal($("#login_result").val(),"true");
			assert.equal($("#login_result_msg").val(),"test_ycat3, ��ӭ������");
			assert.ok($("#btn_login").is_enabled());
			assert.ok($("#session").val() != "");
			assert.ok(document.cookie.indexOf($("#session").val()) != -1);
			$.getJSON("test/del_user");
			QUnit.start();
		}, 800);
	}, 400);
	
      });
      
     </script>
%end     
