<link rel="stylesheet" href="css/select_city.css" />
<script src="js/select_city.js"></script>
	
<style type="text/css">
#div_detail_profile{
	background-color: white;
}

#div_detail_profile .form-group{
    margin-bottom: 5px;
}

#div_detail_profile .control-label{
    padding-right: 0px;
    color: gray;
    text-align: left;
}

#div_detail_profile H3{
	/* for edit title */
	display: inline-block;
}

#div_detail_profile H4{
	/* for edit icon */
	cursor: pointer;
	float:right;vertical-align: bottom;display: inline-block;
	margin-top: 18px; margin-bottom: 0px;
}

.div_save_group{
	margin-bottom: 20px; 
}

#div_detail_profile .title{
	background-color: #fee0e0;
	margin-left: 0px;
	margin-right: 0px;
	padding-bottom: 20px;
}

#img_girl{
	position: absolute;
	right: 0px;
	bottom: 100px;
}
</style>
<script type="text/javascript">
	var allInput = "#div_detail_profile input, #div_detail_profile select";
	function get_text(item){
		if (item.tagName() == "INPUT") {
			var t = $(item).val();
			var e = $(item).siblings(".input-group-addon");
			if (e.length && t.length) {
				t += " (" + e.text() + ")";
			}
			return t;
		}
		else{
			return $(item).find("option:selected").text();
		}
	}
	
	function get_val(item){
		return item.val();
	}
	
	function set_val(item,value){
		return item.val(value);
	}
	
	function add_p(elem)
	{ 
		elem.parents(".form-group").children("div").append("<p id='p_"+elem.attr("id")+"' pid="+
				elem.attr("id")+" class='form-control-static p_readonly'></p>");
	}
	
	function update_p(elem)
	{
		var val = get_text(elem);
		if (val == "" || val ==" "){
			val = "未知";
		}
		$("#p_"+elem.attr("id")).text(val);
	}
	
	function show_edit()
	{ 
		var p = $("#div_detail_profile");
		p.find(".p_readonly").hide();
		p.find(".form-control").show();
		p.find(".input-group").show();
		p.find("#div_edit_button").hide();
		p.find("#div_save_button").show();
		
		$("#div_detail_profile input").each(function()
		{
			if($(this).val() == "未知"){
				$(this).val("");
			}
		});
	}
		
	function hide_edit()
	{
		var p = $("#div_detail_profile");
		p.find(".form-control").hide();
		p.find(".input-group").hide();
		p.find(".p_readonly").show();
		p.find("#div_edit_button").show();
		p.find("#div_save_button").hide();
		 
		$(allInput).each(function()
		{ 
			update_p($(this));
		});
		 
	}
	
	function save_detail(){
		trim_input($("#div_detail_profile input"));
		var ids = new Array();
		var vals = new Array();

		$(allInput).each(function()
		{
			ids.push($(this).attr("id"));
			vals.push(get_val($(this)));
		}); 
		$.getJSON("/action/update_profile_detail",{ids:ids.join("@@"),vals:vals.join("@@")},
			function(json){
				if (json.result == "true") {
					$(allInput).each(function(){
						$(this).attr("old",get_val($(this)));
					});
					hide_edit();
				}
				else{
					alert("保存个人信息失败");
			}
		});
	}
	
	function cancel_detail(){
		$(allInput).each(function(){
			set_val($(this),$(this).attr("old"));
		});
		hide_edit();
	}
	
	function init_edit()
	{
		//setup readonly text
		$(allInput).each(function()
		{
			$(this).attr("old",$(this).val());
			add_p($(this),"");
		});
		 
		hide_edit();
	}
	
	$(document).ready(function(e){
		$("#div_detail_profile label").addClass("col-md-2 col-md-offset-2");
		$("#div_detail_profile .form-group>div").addClass("col-md-5");
		$("#div_detail_profile H3").parent().addClass("col-md-6 col-md-offset-2");
		init_edit();
		var c = new Vcity.CitySelector({input:'city'});
	});
</script>
	
<div id="div_detail_profile" class="form-horizontal">
	<div class="div_save_group">
		<div class="row title">
			<div>
				<H3>亲密信息    </H3>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label" for="realname">姓名</label>
			<div>
				<input class="form-control txt_input limit_s" id="realname"  value="{{!realname}}" />
			</div>
			
		</div>
		<div class="form-group">
			<label class="control-label" for="email">邮件</label>
			<div>
				<input class="txt_input onlyEmail form-control limit_m" id="email" value="{{!email}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="control-label" for="address">住址</label>
			<div>
				<input class="txt_input form-control limit_l" id="address" value="{{!address}}" />
			</div>
		</div>
		<HR>		
		<div class="form-group">
			<label class="control-label" for="career">职业</label>
			<div style="height:34px">
				<select id="career" class="txt_input form-control">
					%for x in c_career:
						<option value="{{x[0]}}" 
						%if x[0] == career:
							selected="selected"
						%end
						>{{x[1]}}</option>
					%end
				</select> 
			</div>
		</div>
		<div class="form-group">
			<label class="control-label" for="income">收入</label>
			<div style="height:34px">
				<select id="income" class="txt_input form-control">
					%for x in c_income:
						<option value="{{x[0]}}" 
						%if x[0] == income:
							selected="selected"
						%end
						>{{x[1]}}</option>
					%end
				</select> 
			</div>
		</div>
		<div class="form-group">
			<label class="control-label" for="campany">公司</label>
			<div>
				<input class="txt_input form-control limit_l" id="campany"  value="{{!campany}}" />
			</div>
		</div>
		<HR>
		<div class="form-group">
			<label class="control-label" for="school">学校</label>
			<div>
				<input class="txt_input form-control limit_l" id="school"  value="{{!school}}" /> 
			</div>
		</div>
		<div class="form-group">
			<label class="control-label" for="degree">学历</label>
			<div style="height:34px">
				<select id="degree" class="txt_input  form-control">
					%for x in c_degree:
						<option value="{{x[0]}}"
						%if x[0] == degree:
							selected="selected"
						%end
						>{{x[1]}}</option>
					%end
				</select>
			</div>
		</div>
	</div>
	
	<div class="div_save_group">
		<div class="row title">
			<div>
				<H3>一般信息</H3>
			</div>
		</div>
			<div class="form-group">
				<label class="control-label" for="city">城市</label>
				<div>
					<input class="txt_input form-control" id="city" value="{{!city}}" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label" for="star">星座</label>
				<div style="height:34px">
					<select id="star" class="txt_input form-control">
					%for x in c_star:
					<option value="{{x[0]}}"
						%if x[0] == star:
							selected="selected"
						%end
						>{{!x[1]}}</option>
					%end
					</select>
				</div>
			</div>
			<HR>
			<div class="form-group">
				<label class="control-label" for="height">身高</label>
				<div>
					<div class="input-group">
						<input class="txt_input onlyNum form-control limit_s" max_len="3" id="height"  value="{{!height}}" />
						<span class="input-group-addon"><small>厘米</small></span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label" for="weight">体重</label>
				<div>
					<div class="input-group">
						<input class="txt_input onlyNum form-control  limit_s" max_len="3" id="weight"  value="{{!weight}}" />
						<span class="input-group-addon"><small>公斤</small></span>
					</div>
				</div>
			</div>
	</div>
	<img src="/res/girl2.gif" id="img_girl" class="hidden-sm hidden-xs"></img>
	<div class="row" style="height:60px">
		<div id="div_edit_button" class="col-md-2 col-md-offset-4">
			<button class="green_btn" onclick="show_edit();"><i class="icon-edit">开始编辑</i></button>
		</div>	
		
		<div id="div_save_button" class="form-group">
			<div class="col-md-2 col-md-offset-4">
				<button class="green_btn" onclick="save_detail();"><i class="icon-ok-2">保存</i></button>
			</div>
			<div class="col-md-2">
				<button class="gray_btn" onclick="cancel_detail();"><i class="icon-remove-2"> 取消</i></button>	
			</div>
		</div>
	</div>
</div>

%if is_test:
<script type="text/javascript">
   QUnit.module("profile");
    var p_text = {};
    var input_value = {};
    function get_sel_text(item,value){
	var t = "unknown";
	item.find("option").each(function(){
		if ($(this).attr("value") == value) {
			t = $(this).text();
			return ;
		}
	});
	return t;
    }
    
    QUnit.asyncTest("init_json",function(assert){
	$.getJSON("/test/get_my_profile",null,
		function(json){
 			$("#div_detail_profile label").each(function(){
				var id = $(this).attr("for");
				var value = json[id];
				if (!value) {
					value = "";
				}
 				if ($("#"+id).tagName() == "SELECT" ) {
					get_sel_text($("#"+id),value);
				}
				else if (value == -1) {
					value = "";//weight,height都是为""，而不是-1
				}
				
				input_value[id]= value;
				if ($("#"+id).tagName() == "SELECT" ) {
					value = get_sel_text($("#"+id),value);
				}
				if (value && value!=-1 && value!=" ") {
					p_text[id] = value;
				}
				else{
					p_text[id] = "未知";
				}
				if (id == "weight") {
					p_text[id] = value + " (公斤)";
				}
				if (id == "height") {
					p_text[id] = value + " (厘米)";
				}
			});
 		assert.equal(get_sel_text($("#income"),"50"),"50k以上");
		assert.equal(get_sel_text($("#income"),"-1")," ");
		QUnit.start();
	});
   });
    
   QUnit.test("init",function(assert){
	assert.equal($(allInput).length,$("#div_detail_profile label").length);
	$(allInput).each(function(){
		assert.ok(!$(this).visible());
		assert.equal(get_val($(this)),input_value[$(this).attr("id")],"input_" + $(this).attr("id"));
	});
	 
	assert.equal($(".p_readonly").length,$("#div_detail_profile label").length);
	$(".p_readonly").each(function(){
		var id = $(this).attr("pid");
		assert.equal($(this).text(),p_text[id],"p_" + id);
		assert.ok($(this).visible());
	});
	assert.ok($("#div_edit_button").visible());
	assert.ok(!$("#div_save_button").visible());
    });

    QUnit.test("showEdit",function(assert){
	$("#div_edit_button button").click();
	$(allInput).each(function(){
		assert.ok($(this).visible());
		assert.equal(get_val($(this)),input_value[$(this).attr("id")],$(this).attr("id"));
	});
	 
	assert.equal($(".p_readonly").length,$("#div_detail_profile label").length);
	$(".p_readonly").each(function(){
		var id = $(this).attr("pid");
		assert.ok(!$(this).visible());
	});
	assert.ok(!$("#div_edit_button").visible());
	assert.ok($("#div_save_button").visible());
    });
    
    QUnit.test("trim_input",function(assert){
	$("#realname").val("12345678901");
	var a="";
	for(var i=0;i<100;i++){
		a+="a";	
	}
	var aa =a;
	a+="b";
	$("#school").val(a);
	$("#email").val("12345678901234567890A");
	$("#height").val("1234");
	$("#weight").val("7890");
	trim_input($("#div_detail_profile input"));
	assert.equal($("#realname").val(),"1234567890");
	assert.equal($("#email").val(),"12345678901234567890");
	assert.equal($("#height").val(),"123");
	assert.equal($("#weight").val(),"789");
	assert.equal($("#school").val(),aa);
    });
     
    QUnit.test("cancelEdit",function(assert){
	$("#realname").val("姚舜");
	$("#email").val("姚舜@qq.com");
	$("#address").val("亲密信息亲密信息亲密信息亲密信息亲密信息");
	$("#career").val(9);
	$("#income").val(10);
	$("#school").val("姚舜密信息亲密信息亲密信息");
	$("#city").val("广州");
	$("#star").val(4);
	$("#height").val(140);
	$("#weight").val(40);
	
	$("#div_save_button").find("button").eq(1).click();//click cancel button 
	 
	assert.equal($(allInput).length,$("#div_detail_profile label").length);
	$(allInput).each(function(){
		assert.ok(!$(this).visible());
		assert.equal(get_val($(this)),input_value[$(this).attr("id")],$(this).attr("id"));
	});
	 
	assert.equal($(".p_readonly").length,$("#div_detail_profile label").length);
	$(".p_readonly").each(function(){
		var id = $(this).attr("pid");
		assert.equal($(this).text(),p_text[id],id);
		assert.ok($(this).visible());
	});
	assert.ok($("#div_edit_button").visible());
	assert.ok(!$("#div_save_button").visible());
    });
    	
    QUnit.asyncTest("saveEdit",function(assert){
	$("#realname").val("姚舜");
	$("#email").val("姚舜@qq.com");
	$("#address").val("亲密信息亲密信息亲密信息亲密信息亲密信息");
	$("#career").val(9);
	$("#income").val(10);
	$("#school").val("姚舜密信息亲密信息亲密信息");
	$("#city").val("广州");
	$("#star").val(4);
	$("#height").val(140);
	$("#weight").val(40);
	$("#div_save_button").find("button").eq(0).click();//click save button
	setTimeout(function(){
		assert.equal($("#p_realname").text(),"姚舜");
		assert.equal($("#p_email").text(),"姚舜@qq.com");
		assert.equal($("#p_address").text(),"亲密信息亲密信息亲密信息亲密信息亲密信息");
		assert.equal($("#p_career").text(),"金融/银行/投资/保险");
		assert.equal($("#p_income").text(),"10k-15k");
		assert.equal($("#p_school").text(),"姚舜密信息亲密信息亲密信息");
		assert.equal($("#p_city").text(),"广州");
		assert.equal($("#p_star").text(),"巨蟹座 06.22─07.22");
		assert.equal($("#p_height").text(),"140 (厘米)");
		assert.equal($("#p_weight").text(),"40 (公斤)");
		
		assert.equal(get_val($("#realname")),"姚舜");
		assert.equal(get_val($("#email")),"姚舜@qq.com");
		assert.equal(get_val($("#address")),"亲密信息亲密信息亲密信息亲密信息亲密信息");
		assert.equal(get_val($("#career")),"9");
		assert.equal(get_val($("#income")),"10");
		assert.equal(get_val($("#school")),"姚舜密信息亲密信息亲密信息");
		assert.equal(get_val($("#city")),"广州");
		assert.equal(get_val($("#star")),"4");
		assert.equal(get_val($("#height")),"140");
		assert.equal(get_val($("#weight")),"40");
		
		assert.equal($(allInput).length,$("#div_detail_profile label").length);
		$(allInput).each(function(){
			assert.ok(!$(this).visible());
		});
		 
		assert.equal($(".p_readonly").length,$("#div_detail_profile label").length);
		$(".p_readonly").each(function(){
			assert.ok($(this).visible());
		});
		assert.ok($("#div_edit_button").visible());
		assert.ok(!$("#div_save_button").visible());
		QUnit.start();
	},500);
    });
    
    QUnit.asyncTest("saveEdit2",function(assert){
	$("#realname").val("姚舜222");
	$("#email").val("姚舜343@qq.com");
	$("#address").val("亲密信息亲密信息3434亲密信息亲密信息亲密信息");
	$("#career").val(3);
	$("#income").val(-1);
	$("#school").val("姚舜密信息亲密3434信息亲密信息");
	$("#city").val("南宁");
	$("#star").val(10);
	$("#height").val(168);
	$("#weight").val(53);
	$("#div_save_button").find("button").eq(0).click();//click save button
	setTimeout(function(){
		assert.equal($("#p_realname").text(),"姚舜222");
		assert.equal($("#p_email").text(),"姚舜343@qq.com");
		assert.equal($("#p_address").text(),"亲密信息亲密信息3434亲密信息亲密信息亲密信息");
		assert.equal($("#p_career").text(),"教师");
		assert.equal($("#p_income").text(),"未知");
		assert.equal($("#p_school").text(),"姚舜密信息亲密3434信息亲密信息");
		assert.equal($("#p_city").text(),"南宁");
		assert.equal($("#p_star").text(),"摩羯座 12.22─01.19");
		assert.equal($("#p_height").text(),"168 (厘米)");
		assert.equal($("#p_weight").text(),"53 (公斤)");
		
		assert.equal(get_val($("#realname")),"姚舜222");
		assert.equal(get_val($("#email")),"姚舜343@qq.com");
		assert.equal(get_val($("#address")),"亲密信息亲密信息3434亲密信息亲密信息亲密信息");
		assert.equal(get_val($("#career")),"3");
		assert.equal(get_val($("#income")),"-1");
		assert.equal(get_val($("#school")),"姚舜密信息亲密3434信息亲密信息");
		assert.equal(get_val($("#city")),"南宁");
		assert.equal(get_val($("#star")),"10");
		assert.equal(get_val($("#height")),"168");
		assert.equal(get_val($("#weight")),"53");
		
		assert.equal($(allInput).length,$("#div_detail_profile label").length);
		$(allInput).each(function(){
			assert.ok(!$(this).visible());
		});
		 
		assert.equal($(".p_readonly").length,$("#div_detail_profile label").length);
		$(".p_readonly").each(function(){
			assert.ok($(this).visible());
		});
		assert.ok($("#div_edit_button").visible());
		assert.ok(!$("#div_save_button").visible());
		QUnit.start();
	},500);
    });
    
    QUnit.asyncTest("restore",function(assert){
	$(allInput).each(function(){
		var id = $(this).attr("id");
		set_val($(this),input_value[id]);
	});
	$("#div_save_button").find("button").eq(0).click();//click save button
	setTimeout(function(){
		assert.equal($(allInput).length,$("#div_detail_profile label").length);
		$(allInput).each(function(){
			assert.ok(!$(this).visible());
			assert.equal(get_val($(this)),input_value[$(this).attr("id")],"input_" + $(this).attr("id"));
		});
		 
		assert.equal($(".p_readonly").length,$("#div_detail_profile label").length);
		$(".p_readonly").each(function(){
			var id = $(this).attr("pid");
			assert.equal($(this).text(),p_text[id],"p_" + id);
			assert.ok($(this).visible());
		});
		assert.ok($("#div_edit_button").visible());
		assert.ok(!$("#div_save_button").visible());		 
		QUnit.start();
	},500);
    });

</script>
%end



