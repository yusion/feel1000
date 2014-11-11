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

</style>
<script type="text/javascript">
	$(document).ready(function(e){
		$("#form_profile label").addClass("col-md-2");
		$("#form_profile label").wrap("<small></small>");
		$("#form_profile .form-group>div").addClass("col-md-3");
		$("#form_profile input").addClass("input-sm");
		$("#form_profile select").addClass("input-sm");
		var c = new Vcity.CitySelector({input:'city'});
	});
</script>

<form id="form_profile" class="form-horizontal" role="form">
	<div class="form-group">
		<label class="control-label">手机</label>
		<div>
			<p id="phone" class="form-control-static">{{!phone}}</p>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-md-offset-1">
			<H3>联系信息</H3>
		</div>
		<div class="col-md-4">
			<H4><i class="icon-edit" style="float:right"></i></H4>
		</div>
	</div>	
	<div class="form-group">
		<label class="control-label">姓名</label>
		<div>
			<input class="form-control txt_input " id="realname"  value="{{!realname}}" />
		</div>
		
	</div>
	<div class="form-group">
		<label class="control-label">QQ</label>
		<div>
			<input class="txt_input onlyNum form-control" id="qq" value="{{!qq}}" />
		</div>
	</div>
	<div class="form-group">
		<label class="control-label">邮件</label>
		<div>
			<input class="txt_input onlyEmail form-control" id="email" value="{{!email}}" />
		</div>
	</div>
	<div class="form-group">
		<label class="control-label">微博</label>
		<div>
			<input class="txt_input form-control" id="blogid" value="{{!blogid}}" />
		</div>
	</div>
	<div class="form-group">
		<label class="control-label">住址</label>
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
	<div class="form-group">
		<div class="col-md-1 col-md-offset-2">
			<button class="btn btn-success"><i class="icon-ok-2"> 保存</i></button>
		</div>
		<div class="col-md-1">
			<button class="btn btn-danger"><i class="icon-remove-2"> 取消</i></button>	
		</div>
	</div>
	  
	
	<div class="row">
		<div class="col-md-4 col-md-offset-1">
			<H3>生活信息</H3>
		</div>
		<div class="col-md-4">
			<H4><i class="icon-edit" style="float:right"></i></H4>
		</div>
	</div>	
	<div class="form-group">
			<label class="control-label">职务</label>
			<div>
				<input class="txt_input form-control" id="career"  value="{{!career}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="control-label">收入</label>
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
			<label class="control-label">公司</label>
			<div>
				<input class="txt_input form-control" id="campany"  value="{{!campany}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="control-label">学校</label>
			<div>
				<input class="txt_input form-control" id="school"  value="{{!school}}" /> 
			</div>
		</div>
		<div class="form-group">
			<label class="control-label">学历</label>
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
	 
	<div class="row">
		<div class="col-md-4 col-md-offset-1">
			<H3>体特信息</H3>
		</div>
		<div class="col-md-4">
			<H4><i class="icon-edit" style="float:right"></i></H4>
		</div>
	</div>	
	<div class="form-group">
			<label class="control-label">年龄</label>
			<div>
				<input class="txt_input onlyNum  form-control" id="age"  value="{{!age}}" />
			</div>
		</div>
		<div class="form-group">
			<label class="control-label">星座</label>
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
			<label class="control-label">身高</label>
			<div>
				<div class="input-group">
					<input class="txt_input onlyNum form-control" id="height"  value="{{!height}}" />
					<span class="input-group-addon"><small>厘米</small></span>
				</div>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label">体重</label>
			<div>
				<div class="input-group">
					<input class="txt_input onlyNum form-control" id="weight"  value="{{!weight}}" />
					<span class="input-group-addon"><small>公斤</small></span>
				</div>
			</div>
		</div>
		
		<HR>
			<div class="form-group">
			<label class="control-label">描述</label>
			<div>
				<textarea class="form-control" rows="10" cols="10"></textarea>
			</div>
		</div>
	</div>	
</form>


	
