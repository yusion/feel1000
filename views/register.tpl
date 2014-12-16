<style type="text/css">
#form_register .row{
	margin-bottom: 15px;
}
</style>
<form id="form_register" class="form-horizontal">
	<div class="row">
		<div class="col-md-12" style="padding-right: 0px;vertical-align: top">
			<ul id="sex" class="radio_ctrl" value="0">
				<li id="li_male" value="0" checked="checked">帅哥</li>
				<li id="li_female" value="1">美女</li>
			</ul>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<input type="text" id="nickname" name="nickname" class="form-control limit_s input-lg" placeholder="昵称">
		</div>		
	</div>
	<div class="row">
		<div class="col-md-12">
			<select id="age" name="age" class="form-control in_block input-lg">
				%for a in range(18,41):
					<option value="{{a}}"
						%if a == 24:
							selected="selected"
						%end
					>{{a}}岁</option>
				%end
				</select>
		</div>
	</div>		
	<div class="row">
		<div class="col-md-12">
			<input type="password" class="form-control limit_m input-lg" style="width:100%" id="password" name="password" placeholder="密码">
		</div>	
	</div>
	<div class="row">
		<div class="col-md-12">
			<div id="chk_agreement" checked="checked" class="checkbox_ctrl">我已阅读并同意</div>
			<a href="/agreement" target="_blank">《用户服务协议》</a>
		</div>
	</div>
	<div class="row" style="margin-bottom: 4px">
		<div class="col-md-12">
			<button id="btn_register" type="button" style="width:100%" class="btn btn-success btn-lg">注&nbsp; 册&nbsp;<i class="icon-note" style="color:mediumorchid"></i></button>
		</div>
	</div>
	<input type="hidden" id="result" value="unknown">
</form>

<script type="text/javascript">
	function submit()
	{
		$.getJSON("action/register", 
		{ 	nick: $("#nickname").val(), 
			pass: hex_md5("pwd" + $("#password").val()),
			phone:$("#phone").val(), 
			sex:$("#sex").val(), 
			age:$("#age").val()},
			function(json){
				//TODO:自动登陆，并跳转
				//TODO:用短信验证功能，先注册，后验证，这样省钱
				$("#result").val(json.result);
		});
	}   
	
	$(document).ready(function(e){	
 		$("#chk_agreement").click(function(){
			if($("#chk_agreement").hasAttr("checked"))
			{
				$("#btn_register").show(600);
			}
			else
			{
				$("#btn_register").hide(600);
			}
		});
				
		$("#btn_register").click(function(e){		
			if(!$("#form_register").valid()) return;
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

		$("#form_register").validate({
			rules: {
			   nickname: {required:true,minlength:2,maxlength:10,remote:nick_remote},
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
	$("#link_register").click();
	expect(6);
	assert.ok($("#chk_agreement").hasAttr("checked"),"init value is check");
	assert.equal($("#sex").val(),"1");
	assert.ok($("#li_male").attr("checked"),"init radio_male value is check");
	assert.ok(!$("#li_female").attr("checked"),"init radio_male value is check");
	assert.equal($("#age").val(),24);
	//assert.equal($("#phone").val(),""); ie的placeHolder会破坏 
	assert.equal($("#password").val(),""); ie的placeHolder会破坏 
     });

     QUnit.asyncTest("check_nickname",function(assert){
	expect(6);
	assert.ok($("#nickname-error").text() == "", "error msg is hidden" );
	$("#nickname").focusin();
	$("#nickname").val("a");
	$("#nickname").focusout();
	assert.ok($("#nickname-error").visible(), "error msg is visibled");
	assert.ok($("#nickname-error").text().indexOf("长度不能少于2个字") != -1,"wrong msg");
 
	$("#nickname").focusin();
	$("#nickname").val("");
	$("#nickname").focusout();
	assert.ok($("#nickname-error").text().indexOf("请填写该信息") != -1,"wrong msg");
	
	$("#nickname").focusin();
	$("#nickname").val("12345678901");
	$("#nickname").focusout();
	assert.ok($("#nickname-error").text().indexOf("长度不能超过10个字") != -1,"wrong msg");
	
	$("#nickname").focusin();
	$("#nickname").val("姚舜姚舜姚舜姚舜姚舜");
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
	assert.ok($("#password-error").visible(), "error msg is visibled");
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
	$("#age").val("21");
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
			sex:"1",
			birthdayYear:1993},
			function(json){
				r = json;
				console.log(r);
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
		assert.ok($("#btn_register").visible(), "register button must be visibled" );
		$.getJSON("test/del_user");
		QUnit.start();
	}, 700);
	});
     </script>
%end
