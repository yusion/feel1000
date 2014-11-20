<link rel="stylesheet" href="css/select_city.css" />
<script src="js/select_city.js"></script>
	
<style type="text/css">
#form_profile{
	background-color: transparent;
}

#form_profile .form-group{
    margin-bottom: 5px;
}

#form_profile .control-label{
    padding-right: 0px;
    color: gray;
}

#form_profile H3{
	/* for edit title */
	display: inline-block;
}

#form_profile H4{
	/* for edit icon */
	cursor: pointer;
	float:right;vertical-align: bottom;display: inline-block;
	margin-top: 18px; margin-bottom: 0px;
}

.div_save_group{
	margin-bottom: 20px;
	border-width: 1px;
	border-style: solid;
	border-color: transparent;
}

.div_save_group:hover{
	border-color: orange;
}

</style>
<script type="text/javascript">
	function show_edit(p)
	{
		p.find(".p_readonly").hide();
		p.find(".form-control").show();
		p.find(".input-group").show();
		p.find("#div_save_button").show();
	}
		
	function hide_edit(p)
	{
		p.find(".form-control").hide();
		p.find(".input-group").hide();
		p.find("#div_save_button").hide();
		p.find(".p_readonly").show();
	}
	
	function init_edit()
	{
		//setup readonly text 
		function add_p(elem,val)
		{
			elem.parents(".form-group").children("div").append("<p id='p_"+$(this).attr("id")+"' class='form-control-static p_readonly'>"+val+"</p>");
		}
		
		$("#form_profile input").each(function()
		{
			var t = $(this).val();
			var e = $(this).siblings(".input-group-addon");
			if (e.length) {
				t += " (" + e.text() + ")";
			}
			add_p($(this),t);
		});
		$("#form_profile select").each(function()
		{
			add_p($(this),$(this).find("option:selected").text());
		});
		
		$("#form_profile .div_save_group").append($("#div_save_button"));
		
		//toggle edit mode and read mode
		$("#form_profile H4").click(function(){
			var p = $(this).parents(".div_save_group");
			p.toggleClass("in_edit_mode");
			if (p.hasClass("in_edit_mode")) {
				show_edit(p);
			}
			else
			{
				hide_edit(p);
			}
		});
		
		hide_edit($("#form_profile"));
	}
	
	$(document).ready(function(e){
		$("#form_profile label").addClass("col-md-2");
		$("#form_profile .form-group>div").addClass("col-md-5");
		$("#form_profile H3").parent().addClass("col-md-6 col-md-offset-1");

		//$("#form_profile label").wrap("<small></small>");
		//$("#form_profile input").addClass("input-sm");
		//$("#form_profile select").addClass("input-sm");
		init_edit();
		var c = new Vcity.CitySelector({input:'city'});
	});
</script>

<div id="div_save_button" class="form-group edit_button" style="display: none">
	<div class="col-md-2 col-md-offset-2">
		<button class="form-control  btn btn-success"><i class="icon-ok-2">保存</i></button>
	</div>
	<div class="col-md-2">
		<button class="form-control  btn btn-danger"><i class="icon-remove-2"> 取消</i></button>	
	</div>
</div>
		
<form id="form_profile" class="form-horizontal" role="form">
	<div class="div_save_group">
		<div class="row">
			<div>
				<H3>联系信息    <small><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i></small></H3>
				<H4><i class="icon-edit">点击编辑</i></H4>
			</div>
		</div>	
		<div class="form-group">
			<label class="control-label" for="realname">姓名</label>
			<div>
				<input class="form-control txt_input " id="realname"  value="{{!realname}}" />
			</div>
			
		</div>
		<div class="form-group">
			<label class="control-label" for="qq">QQ</label>
			<div>
				<input class="txt_input onlyNum form-control" id="qq" value="{{!qq}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="control-label" for="email">邮件</label>
			<div>
				<input class="txt_input onlyEmail form-control" id="email" value="{{!email}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="control-label" for="blogid">微博</label>
			<div>
				<input class="txt_input form-control" id="blogid" value="{{!blogid}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="control-label" for="address">住址</label>
			<div>
				<input class="txt_input form-control" id="address" value="{{!address}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="control-label">城市</label>
			<div>
				<input class="txt_input form-control" id="city" value="{{!city}}" />
			</div>
		</div>
	</div> 
	
	<div class="div_save_group">
		<div class="row">
			<div>
				<H3>生活信息    <small><i class="icon-star"></i><i class="icon-star"></i></small></H3>
				<H4><i class="icon-edit">点击编辑</i></H4>	
			</div>
		</div>	
		<div class="form-group">
			<label class="control-label" for="career">职务</label>
			<div>
				<input class="txt_input form-control" id="career"  value="{{!career}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="control-label" for="income">收入</label>
			<div>
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
				<input class="txt_input form-control" id="campany"  value="{{!campany}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="control-label" for="school">学校</label>
			<div>
				<input class="txt_input form-control" id="school"  value="{{!school}}" /> 
			</div>
		</div>
		<div class="form-group">
			<label class="control-label" for="degree">学历</label>
			<div>
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
		<div class="row">
			<div>
				<H3>特征信息</H3>
				<H4><i class="icon-edit">点击编辑</i></H4>
			</div>
		</div>	
		<div class="form-group">
			<label class="control-label" for="age">年龄</label>
			<div>
				<input class="txt_input onlyNum  form-control" id="age"  value="{{!age}}" />
			</div>
		</div>
			<div class="form-group">
				<label class="control-label" for="star">星座</label>
				<div>
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
			<div class="form-group">
				<label class="control-label" for="height">身高</label>
				<div>
					<div class="input-group">
						<input class="txt_input onlyNum form-control" id="height"  value="{{!height}}" />
						<span class="input-group-addon"><small>厘米</small></span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label" for="weight">体重</label>
				<div>
					<div class="input-group">
						<input class="txt_input onlyNum form-control" id="weight"  value="{{!weight}}" />
						<span class="input-group-addon"><small>公斤</small></span>
					</div>
				</div>
			</div>
	</div>
</form>


	
