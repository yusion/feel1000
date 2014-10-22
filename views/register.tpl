<!DOCTYPE HTML>
<html>
<head>
	<title>FEEL千千</title>
	{{!web_head}}
	<script type="text/javascript" src="./js/md5.js"></script >
</head>
<body>
{{!page_head}}
<form class="form-horizontal" role="form">
	<div class="row">
		<div class="hidden-xs hidden-sm" style="height: 0px;width:100%">
		</div>
	</div>
	<div class="row">
		<div class="col-sm-4 col-sm-offset-4">
			<div class="form-group">
				<label class="btn btn-info col-sm-3">
					<input type="radio" name="options" id="radio_male" value="0" checked="checked">帅哥
				</label>
				<label class="btn btn-warning col-sm-3  col-sm-offset-1">
					<input type="radio" name="options" id="radio_female" value="1">美女
				</label>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" id="nickname" placeholder="昵称">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" id="phone" placeholder="手机号码">
			</div>
			<div class="form-group">
				<input type="password" class="form-control" id="password" placeholder="密码">
			</div>
			<div class="form-group">
				<small>
					<input id="chk_agreement" type="checkbox" checked="checked">我已阅读并同意
					<a href="/agreement.html" target="_blank">《用户服务协议》</a>
				</small>
			</div>
			<div class="form-group">
				<div class="col-sm-4">
				   <button id="btn_register" type="submit" class="btn btn-primary">注&nbsp; 册</button>	
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
				pass: hex_md5($("#password").val()),
				phone:$("#phone").val(), 
				sex:sex},
				function(json){
					alert("JSON Data: " + json.result);
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
			/*$(".easyui-validatebox").validatebox("validate");		
			var v = true;
			$(".easyui-validatebox").each(function(i){
				if(!$(this).validatebox("isValid")) 
				{
					v = false;
					return;
				}
			});			
			if(!v) return;
			*/
			submit();
		});
    });
    </script>
     
     <script type="text/javascript">
     QUnit.module("register");
     QUnit.test("init_value",function(assert){
	expect(3);
	assert.ok($("#chk_agreement").attr("checked"),"init value is check");
	assert.ok($("#radio_male").attr("checked"),"init radio_male value is check");
	assert.ok(!$("#radio_female").attr("checked"),"init radio_male value is check");
     });
     
     QUnit.asyncTest("auto_hide_submit", function( assert ) {
	expect(1);
		$("#chk_agreement").click();
		setTimeout(function() {
			assert.ok($("#btn_register").is(":hidden"), "register button must be hidden" );	
			QUnit.start();
		}
	      , 800);
	});
     
     QUnit.asyncTest("auto_show_submit", function( assert ){
	expect(1);
		$("#chk_agreement").click();
		
		setTimeout(function() {
			assert.ok($("#btn_register").is(":visible"), "register button must be visible" );	
			QUnit.start();
		}, 800);
	});
	
     </script>
{{!page_foot}}	    
</body>
</html>
