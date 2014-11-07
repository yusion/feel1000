<script type="text/javascript">
	$(document).ready(function(){
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
			hasGrid: true
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
			hasGrid: true
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
			hasGrid: true
		});
	}); 
</script>

<form id="search_form1 " class="form-horizontal green_div" role="form">
<div class="fixDiv blue_div">
	<div class="form-group">	
		<label for="city" class="col-md-4 control-label">城市</label>
		<div class="col-md-8">
			<select id="city" class="form-control">
				<option>广州</option>
				<option>广州</option>
				<option>广州</option>
				<option>广州</option>
				<option>广州</option>
			</select>
		</div>
	</div>
	
	<div class="form-group">			
		<label for="degree" class="col-md-4 control-label">学历</label>
		<div class="col-md-8">
			<select id="degree" class="form-control">
				<option>本科</option>
				<option>本科</option>
				<option>本科</option>
				<option>本科</option>
			</select>
		</div>
	</div>
 	<div class="form-group">
		<label for="income" class="col-md-4 control-label">收入</label>
		<div class="col-md-8">
			<select id="income" class="form-control">
				<option>1000~2000</option>
				<option>1000~2000</option>
				<option>1000~2000</option>
				<option>1000~2000</option>
				<option>1000~2000</option>
			</select>
		</div>
	</div>
	<div class="form-group">	
		<label for="has_car" class="col-md-4 control-label">有车</label>
		<div class="col-md-8">
			<input id="has_car" type="checkbox" class="form-control input-sm">
		</div>		
	</div>
	<div class="form-group">	
		<label for="has_house" class="col-md-4 control-label">有房</label>
		<div class="col-md-8">
			<input id="has_house" type="checkbox" class="form-control input-sm">
		</div>		
	</div>
	<div class="form-group">	
		<label class="col-md-4 control-label">长相</label>
		<div class="col-md-8">
			<div id="stara_rating1"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="col-md-4 control-label">身材</label>
		<div class="col-md-8">
			<div id="stara_rating2"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="col-md-4 control-label">性格</label>
		<div class="col-md-8">
			<div id="stara_rating3"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="col-md-4 control-label">态度</label>
		<div class="col-md-8">
			<div id="stara_rating4"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label for="age" class="col-md-4 control-label">年龄</label>
		<div class="col-md-8">
			<input id="age" type="text"/>
		</div>		
	</div>
	<div class="form-group">	
		<label for="height" class="col-md-4 control-label">身高</label>
		<div class="col-md-8">
			<input id="height" type="text"/>
		</div>		
	</div>
	<div class="form-group">	
		<label for="weight" class="col-md-4 control-label">体重</label>
		<div class="col-md-8">
			<input id="weight" type="text"/>
		</div>		
	</div>
	<div class="form-group">	
		<label for="??" class="col-md-4 control-label">关键字</label>
		<div class="col-md-8">
			<input id="keyword" type="text" class="form-control" placeholder="电话号码/昵称/学校...">
		</div>		
	</div>
	<div class="form-group">
		<div class="col-md-12">
		<button type="submit" class="btn btn-default"><i class="icon-search"></i>查找</button>
		</div>
	</div>
</div>
</form>	
