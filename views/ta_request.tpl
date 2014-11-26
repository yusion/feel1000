<link rel="stylesheet" href="css/select_city.css" />
<script src="js/select_city.js"></script>
	
<style type="text/css">
</style>

<script type="text/javascript">
 	$(document).ready(function(e){
		test("ddddd");
		$("#form_ta_request label").addClass("col-md-2");
		$("#form_ta_request .form-group>div").addClass("col-md-5");
		$("#form_ta_request H3").parent().addClass("col-md-6 col-md-offset-1");
		
		var c = new Vcity.CitySelector({input:'city'});
				
		//设置星星评价
		$("#star_ta_appearance").raty({ start:2,inline_width:68});
		$("#star_ta_figure").raty({ start:3,inline_width:68});
		$("#star_ta_character").raty({ start:4,inline_width:68});
		$("#star_ta_attitude").raty({ start:2,inline_width:68});
		
		$("#age").ionRangeSlider({
			min: 20,
			max: 40,
			from:20,
			to: 24,
			type: 'double',//设置类型
			step: 1,
			prefix: "",//设置数值前缀
			postfix: "岁",//设置数值后缀
			prettify: true,
			hasGrid: true,
			gridMargin: 1,
			hideMinMax: true
		});
		
		$("#height").ionRangeSlider({
			min: 150,
			max: 210,
			from:150,
			to: 170,
			type: 'double',//设置类型
			step: 1,
			prefix: "",//设置数值前缀
			postfix: "厘米",//设置数值后缀
			prettify: true,
			hasGrid: true,
			gridMargin: 1,
			hideMinMax: true
		});
		
		$("#weight").ionRangeSlider({
			min: 40,
			max: 100,
			from:40,
			to: 60,
			type: 'double',//设置类型
			step: 1,
			prefix: "",//设置数值前缀
			postfix: "公斤",//设置数值后缀
			prettify: true,
			hasGrid: true,
			gridMargin: 1,
			hideMinMax: true
		});
		
		
	});
</script>
 
<form id="form_ta_request" class="form-horizontal" role="form" style="padding-top: 30px;padding-bottom: 20px">
	<div>
		<div class="form-group">
			<label class="control-label">城市</label>
			<div>
				<input class="txt_input form-control" id="city" value="{{!city}}" />
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
		
		<div class="form-group">
			<label for="condition" class="control-label">条件</label>
			<div >
				<select id="condition" class="form-control">
					<option>无</option>
					<option>有车</option>
					<option>有房</option>
					<option>有房\有车</option>
				</select>
			</div>
		</div>
		
		<div class="form-group">	
		<label for="age" class="control-label">年龄</label>
		<div >
			<input id="age" type="text"/>
		</div>		
		</div>
		<div class="form-group">	
			<label for="height" class="control-label">身高</label>
			<div >
				<input id="height" type="text"/>
			</div>		
		</div>
		<div class="form-group">	
			<label for="weight" class="control-label">体重</label>
			<div >
				<input id="weight" type="text"/>
			</div>		
		</div>
		
		
		<div class="form-group">	
		<label class="control-label">长相</label>
		<div >
			<div id="star_ta_appearance" class="in_block"></div><span style="vertical-align: bottom">英俊潇洒</span>
		</div>		
		</div>
		<div class="form-group">	
			<label class="control-label">身材</label>
			<div >
				<div id="star_ta_figure" class="in_block"></div><span style="vertical-align: bottom">英俊潇洒</span>
			</div>		
		</div>
		<div class="form-group">	
			<label class="control-label">性格</label>
			<div >
				<div id="star_ta_character" class="in_block"></div><span style="vertical-align: bottom">英俊潇洒</span>
			</div>		
		</div>
		<div class="form-group">	
			<label class="control-label">态度</label>
			<div >
				<div id="star_ta_attitude" class="in_block"></div><span style="vertical-align: bottom">英俊潇洒</span>
			</div>		
		</div>
	</div>
	
	 <div class="form-group" >
		<div class="col-md-2 col-md-offset-2">
			<button class="form-control  btn btn-success"><i class="icon-ok-2">保存</i></button>
		</div>
		<div class="col-md-2">
			<button class="form-control  btn btn-danger"><i class="icon-remove-2"> 取消</i></button>	
		</div>
	</div>
</form>


	
