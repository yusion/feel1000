<style type="text/css">
#form_register .row{
	margin-bottom: 8px;
}
</style>
<form id="form_register">
	<div class="row">
		<div class="col-md-7 small" style="padding-right: 0px">
			�Ա�
			<input type="radio" name="sex" id="radio_male" value="0" checked="checked" style="heigth:auto">
				˧��
			<input type="radio" name="sex" id="radio_female" value="1" style="margin-left: 10px">
				��Ů
		</div>
		<div class="col-md-5 pull-right small" style="padding: 0 0 0 0">
			���䣺
			<select id="age" name="age" class="form-control input-sm in_block" style="padding: 0 0 0 0;width:50px;height:24px">
			%for a in range(18,41):
				<option value="{{a}}"
					%if a == 24:
						selected="selected"
					%end
				>{{a}}��</option>
			%end
			</select>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<input type="text" class="form-control onlyNum limit_m input-sm" max_len="11" id="phone" name="phone" placeholder="�ֻ�����">
		</div>
	</div>	
	<div class="row">
		<div class="col-md-12">
			<input type="text" id="nickname" name="nickname" class="form-control limit_s input-sm" placeholder="�ǳ�">
		</div>		
	</div>
	<div class="row">
		<div class="col-md-12">
			<input type="password" class="form-control limit_m input-sm" id="password" name="password" placeholder="����">
		</div>	
	</div>
	<div class="row">
		<div class="col-md-12 small">
			<span id="chk_agreement" checked="checked" class="checkbox_ctrl text-left">�����Ķ���ͬ��</span>
			<a href="/agreement" target="_blank">���û�����Э�顷</a>
		</div>
	</div>
	<div class="row" style="margin-bottom: 4px">
		<div class="col-md-12">
			<button id="btn_register" type="button" class="btn btn-success form-control ">ע&nbsp; ��</button>
		</div>
	</div>
	<input type="hidden" id="result" value="unknown">
</form>

<script type="text/javascript">
	function submit()
	{
		var sex = $('input:radio:checked').val();
		$.getJSON("action/register", 
		{ 	nick: $("#nickname").val(), 
			pass: hex_md5("pwd" + $("#password").val()),
			phone:$("#phone").val(), 
			sex:sex,
			age:$("#age").val()},
			function(json){
				//TODO:�Զ���½������ת
				//TODO:�ö�����֤���ܣ���ע�ᣬ����֤������ʡǮ
				$("#result").val(json.result);
		});
	}   
	
	$(document).ready(function(e){	
		var firstcheck = true;
 		$("#chk_agreement").click(function(){
			if("checked" == $("#chk_agreement").attr("checked"))
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
				nickname:{remote:"���ǳ��Ѿ�ע��"},
				phone:{remote:"�ú����Ѿ�ע��"},
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
	expect(4);
	assert.ok($("#chk_agreement").attr("checked"),"init value is check");
	assert.ok($("#radio_male").attr("checked"),"init radio_male value is check");
	assert.ok(!$("#radio_female").attr("checked"),"init radio_male value is check");
	assert.equal($("#age").val(),24);
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
	$("#nickname").val("12345678901");
	$("#nickname").focusout();
	assert.ok($("#nickname-error").text().indexOf("���Ȳ��ܳ���10����") != -1,"wrong msg");
	
	$("#nickname").focusin();
	$("#nickname").val("Ҧ˴Ҧ˴Ҧ˴Ҧ˴Ҧ˴");
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
	assert.ok($("#phone-error").text().indexOf("����д��ȷ���ֻ�����") != -1,"wrong msg");
	
	$("#phone").focusin();
	$("#phone").val("");
	$("#phone").focusout();
	assert.ok($("#phone-error").text().indexOf("����д����Ϣ") != -1,"wrong msg");
	
	$("#phone").focusin();
	$("#phone").val("1392897901");
	$("#phone").focusout();
	assert.ok($("#phone-error").text().indexOf("����д��ȷ���ֻ�����") != -1,"wrong msg");
	
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
		assert.ok($("#nickname-error").text().indexOf("���ǳ��Ѿ�ע��") != -1,"wrong msg");
		QUnit.start();
	}, 500);
     });
     
     QUnit.test("check_pass",function(assert){
	assert.ok($("#password-error").text() == "", "error msg is hidden" );
	$("#password").focusin();
	$("#password").val("12345");
	$("#password").focusout();
	assert.ok($("#password-error").is(":visible"), "error msg is visibled");
	assert.ok($("#password-error").text().indexOf("���Ȳ�������6����") != -1,"wrong msg");
 
	$("#password").focusin();
	$("#password").val("");
	$("#password").focusout();
	assert.ok($("#password-error").text().indexOf("����д����Ϣ") != -1,"wrong msg");
	
	$("#password").focusin();
	$("#password").val("12345678901234567890x");
	$("#password").focusout();
	assert.ok($("#password-error").text().indexOf("���Ȳ��ܳ���20����") != -1,"wrong msg");
	});
      
     QUnit.asyncTest("check_phone_repeat",function(assert){
	expect(1);
	$("#phone").focusin();
	$("#phone").val("13928979001");
	$("#phone").focusout();
	
	setTimeout(function() {
		assert.ok($("#phone-error").text().indexOf("�ú����Ѿ�ע��") != -1,"wrong msg");
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
			sex:1,
			birthdayYear:1993},
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
