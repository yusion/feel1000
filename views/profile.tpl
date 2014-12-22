<link rel="stylesheet" href="css/select_city.css" />
<script src="js/select_city.js"></script>
	
<style type="text/css">
#form_profile{
	background-color: white;
}

#form_profile .form-group{
    margin-bottom: 5px;
}

#form_profile .control-label{
    padding-right: 0px;
    color: gray;
    text-align: left;
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
}

#form_profile .title{
	background-color: #fee0e0;
	margin-left: 0px;
	margin-right: 0px;
	padding-bottom: 20px;
}

#img_girl{
	position: absolute;
	right: 40px;
	bottom: 100px;
}
</style>
<script type="text/javascript">
	function show_edit(p)
	{
		p.find(".p_readonly").hide();
		p.find(".form-control").show();
		p.find(".input-group").show();
		p.find("#div_edit_button").hide();
		p.find("#div_save_button").show();
	}
		
	function hide_edit(p)
	{
		p.find(".form-control").hide();
		p.find(".input-group").hide();
		p.find(".p_readonly").show();
		p.find("#div_edit_button").show();
		p.find("#div_save_button").hide();
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
			$(this).addClass("hover");
			add_p($(this),$(this).find("option:selected").text());
		});
			
		//toggle edit mode and read mode
		$("#div_edit_button > button").click(function(){
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
		$("#form_profile label").addClass("col-md-2 col-md-offset-2");
		$("#form_profile .form-group>div").addClass("col-md-5");
		$("#form_profile H3").parent().addClass("col-md-6 col-md-offset-2");

		//$("#form_profile label").wrap("<small></small>");
		//$("#form_profile input").addClass("input-sm");
		//$("#form_profile select").addClass("input-sm");
		init_edit();
		var c = new Vcity.CitySelector({input:'city'});
	});
</script>
	
<form id="form_profile" class="form-horizontal" role="form">
	<div class="div_save_group">
		<div class="row title">
			<div>
				<H3>联系信息    <small><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i></small></H3>
			</div>
		</div>	
		<div class="form-group">
			<label class="control-label" for="realname">姓名</label>
			<div>
				<input class="form-control txt_input " id="realname"  value="{{!realname}}" />
			</div>
			
		</div>
		<div class="form-group">
			<label class="control-label" for="email">邮件</label>
			<div>
				<input class="txt_input onlyEmail form-control" id="email" value="{{!email}}" />
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
		<div class="row title">
			<div>
				<H3>生活信息    <small><i class="icon-star"></i><i class="icon-star"></i></small></H3>
			</div>
		</div>	
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
				<H3>特征信息</H3>
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
	<img src="/res/girl2.gif" id="img_girl" class="hidden-sm hidden-xs"></img>
	<div class="row" style="padding-bottom: 20px">
		<div id="div_edit_button" class="col-md-2 col-md-offset-2">
			<button class="green_btn"><i class="icon-edit">开始编辑</i></button>
		</div>	
		
		<div id="div_save_button" class="form-group">
			<div class="col-md-2 col-md-offset-3">
				<button class="green_btn"><i class="icon-ok-2">保存</i></button>
			</div>
			<div class="col-md-2">
				<button class="gray_btn"><i class="icon-remove-2"> 取消</i></button>	
			</div>
		</div>
	</div>
</form>


	
