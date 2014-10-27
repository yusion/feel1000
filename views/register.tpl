<!DOCTYPE HTML>
<html>
<head>
	{{!web_head}}
	<script type="text/javascript" src="./js/md5.js"></script >
</head>
<body>
{{!page_head}}
<input type="hidden" id="result" value="unknown">
<form id="reg_form" class="form-horizontal" role="form">
	<div class="row">
		<div class="hidden-xs hidden-sm" style="height: 0px;width:100%">
		</div>
	</div>
	<div class="row">
		<div class="col-sm-4 col-sm-offset-4">
			<div class="form-group">
				<label class="btn btn-info col-sm-3"">
					<input type="radio" name="sex" id="radio_male" value="0" checked="checked">帅哥
				</label>
				<label class="btn btn-warning col-sm-3  col-sm-offset-1">
					<input type="radio" name="sex" id="radio_female" value="1">美女
				</label>
			</div>
			<div class="form-group">
				<input type="text" id="nickname" name="nickname" class="form-control required:true" placeholder="昵称">
			</div>
			<div class="form-group">
				<input type="text" class="form-control onlyNum" id="phone" name="phone" placeholder="手机号码">
			</div>
			<div class="form-group">
				<input type="password" class="form-control" id="password" name="password" placeholder="密码">
			</div>
			<div class="form-group">
				<small>
					<input id="chk_agreement" type="checkbox" checked="checked" name="agreement">我已阅读并同意
					<a href="/agreement.html" target="_blank">《用户服务协议》</a>
				</small>
			</div>
			<div class="form-group">
				<div class="col-sm-4">
				   <button id="btn_register" type="button" class="btn btn-primary">注&nbsp; 册</button>	
				</div>
				<div class="pull-right">
				   <a href="/login" class="registor_now">已有帐号，直接登录</a>
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
			pass: hex_md5("pwd" + $("#password").val()),
			phone:$("#phone").val(), 
			sex:sex},
			function(json){
				//TODO:自动登陆，并跳转
				//TODO:用短信验证功能，先注册，后验证，这样省钱
				$("#result").val(json.result);
		});
	}
	
	$(document).ready(function(e){
		var firstcheck = true;
 		$("#chk_agreement").change(function(e){
			firstcheck = !firstcheck;
			if(!firstcheck)
			{
				$("#btn_register").hide(600);
			}
			else
			{
				$("#btn_register").show(600);
			}
		});
				
		$("#btn_register").click(function(e){		
			if(!$("#reg_form").valid()) return;
			submit();
		});
		
		var phone_remote = {
			url: "action/is_repeat_phone",      
			type: "get",                
			dataType: "json",           
			data: {                      
			phone: function() {
				return $("#phone").val();
			}}};
			
		var nick_remote = {
			url: "action/is_repeat_nickname",      
			type: "get",                
			dataType: "json",           
			data: {                      
			nickname: function() {
				return $("#nickname").val();
			}}};	

		$("#reg_form").validate({
			rules: {
			   nickname: {required:true,minlength:2,maxlength:20,remote:nick_remote},
			   phone: {required: true,isPhone:true,remote:phone_remote},
			   password:{required: true,minlength:6,maxlength:20}
			   },
			messages:{
				nickname:{remote:"该昵称已经注册"},
				phone:{remote:"该号码已经注册"},
			}
			});
	});
    </script>
     
     %if is_test:
     <script type="text/javascript">
 
     QUnit.module("register");
     $.getJSON("test/del_user");
     QUnit.config.reorder = false;
     
     QUnit.test("init_value",function(assert){
	expect(3);
	assert.ok($("#chk_agreement").attr("checked"),"init value is check");
	assert.ok($("#radio_male").attr("checked"),"init radio_male value is check");
	assert.ok(!$("#radio_female").attr("checked"),"init radio_male value is check");
     });
     
     QUnit.asyncTest("check_nickname",function(assert){
	expect(6);
	assert.ok($("#nickname-error").text() == "", "error msg is hidden" );
	$("#nickname").focusin();
	$("#nickname").val("a");
	$("#nickname").focusout();
	assert.ok($("#nickname-error").is(":visible"), "error msg is visibled");
	assert.ok($("#nickname-error").text().indexOf("长度不能少于2个字") != -1,"wrong msg");
 
	$("#nickname").focusin();
	$("#nickname").val("");
	$("#nickname").focusout();
	assert.ok($("#nickname-error").text().indexOf("请填写该信息") != -1,"wrong msg");
	
	$("#nickname").focusin();
	$("#nickname").val("123456789012345678901");
	$("#nickname").focusout();
	assert.ok($("#nickname-error").text().indexOf("长度不能超过20个字") != -1,"wrong msg");
	
	$("#nickname").focusin();
	$("#nickname").val("12345678901234567890");
	$("#nickname").focusout();
	
	setTimeout(function() {
		assert.ok($("#nickname-error").text() == "", "error msg is hidden" );	
		QUnit.start();
	}, 300);
     });
     
     QUnit.asyncTest("check_phone",function(assert){
	expect(4);
	$("#phone").focusin();
	$("#phone").val("139289790011");
	$("#phone").focusout();
	assert.ok($("#phone-error").text().indexOf("请填写正确的手机号码") != -1,"wrong msg");
	
	$("#phone").focusin();
	$("#phone").val("");
	$("#phone").focusout();
	assert.ok($("#phone-error").text().indexOf("请填写该信息") != -1,"wrong msg");
	
	$("#phone").focusin();
	$("#phone").val("1392897901");
	$("#phone").focusout();
	assert.ok($("#phone-error").text().indexOf("请填写正确的手机号码") != -1,"wrong msg");
	
	$("#phone").focusin();
	$("#phone").val("13259790114");
	$("#phone").focusout();
	
	setTimeout(function() {
		assert.ok($("#phone-error").text()=="","wrong msg");
		QUnit.start();
	}, 500);
     });
     
     QUnit.asyncTest("check_nickname_repeat",function(assert){
	expect(1);
	$("#nickname").focusin();
	$("#nickname").val("ycat");
	$("#nickname").focusout();
	
	setTimeout(function() {
		assert.ok($("#nickname-error").text().indexOf("该昵称已经注册") != -1,"wrong msg");
		QUnit.start();
	}, 500);
     });
     
     QUnit.test("check_pass",function(assert){
	assert.ok($("#password-error").text() == "", "error msg is hidden" );
	$("#password").focusin();
	$("#password").val("12345");
	$("#password").focusout();
	assert.ok($("#password-error").is(":visible"), "error msg is visibled");
	assert.ok($("#password-error").text().indexOf("长度不能少于6个字") != -1,"wrong msg");
 
	$("#password").focusin();
	$("#password").val("");
	$("#password").focusout();
	assert.ok($("#password-error").text().indexOf("请填写该信息") != -1,"wrong msg");
	
	$("#password").focusin();
	$("#password").val("12345678901234567890x");
	$("#password").focusout();
	assert.ok($("#password-error").text().indexOf("长度不能超过20个字") != -1,"wrong msg");
	});
      
     QUnit.asyncTest("check_phone_repeat",function(assert){
	expect(1);
	$("#phone").focusin();
	$("#phone").val("13928979001");
	$("#phone").focusout();
	
	setTimeout(function() {
		assert.ok($("#phone-error").text().indexOf("该号码已经注册") != -1,"wrong msg");
		QUnit.start();
	}, 500);
     });
	     
     QUnit.asyncTest("register", function( assert ){
	expect(1);
	$("#nickname").val("test_ycat3");
	$("#phone").val("13728975541");
	$("#password").val("123456");
	$("#radio_female").attr("checked",true);
	$("#btn_register").click();
	
	setTimeout(function() {
		assert.ok($("#result").val() == "true", "register success" );	
		QUnit.start();
	}, 400);
     });
     var r;
      QUnit.asyncTest("check_exist", function( assert ){
	expect(1);
	
	$.getJSON("test/check_user", 
		{ 	nick: "test_ycat3", 
			pass: "123456",
			phone:"13728975541", 
			sex:1},
			function(json){
				r = json;
		});
		 
	setTimeout(function() {
		assert.equal(r,"1", "register success" );	
		QUnit.start();
	}, 400);
    });
     
      QUnit.asyncTest("auto_hide_submit", function( assert ) {
	expect(1);
	$("#chk_agreement").click();
	setTimeout(function() {
		assert.ok($("#btn_register").is(":hidden"), "register button must be hidden" );	
		QUnit.start();
	}, 700);
	});
     
     QUnit.asyncTest("auto_show_submit", function( assert ){
	expect(1);
	$("#chk_agreement").click();
		
	setTimeout(function() {
		assert.ok($("#btn_register").is(":visible"), "register button must be visibled" );
		$.getJSON("test/del_user");
		QUnit.start();
	}, 700);
	});
     </script>
     %end
{{!page_foot}}	    
</body>
</html>
