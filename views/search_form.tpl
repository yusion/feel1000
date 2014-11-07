<script type="text/javascript">
	$(document).ready(function(){
		$("#search_form label").wrap("<small></small>");
		$("#search_form label").addClass("col-md-3");
		$("#search_form .form-group>div").addClass("col-md-8");
		
		$("#search_form select,#search_form input").addClass("input-sm");
		//$("#search_form button").addClass("btn-sm");
		
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

<form id="search_form" class="form-horizontal fixDiv blue_div" role="form">
	<div class="form-group">
		<div class="col-md-6">
			<button type="submit" class="btn btn-default btn-sm" style="width:100%"><i class="icon-search"></i>查找</button>
		</div>
		<div class="col-md-4"> 
			<div class="input-group-btn">
				<button type="button" class="btn btn-default" style="font-size:small" ><i class="icon-bookmark">收藏</i></button>
				<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
				   <span class="caret"></span>
				   <span class="sr-only">切换下拉菜单</span>
				</button>
				<ul class="dropdown-menu">
				    <li>
					<a class="save_search_link" href="#">男一号</a><a class="del_search_link" href="#" title="删除"><i class="icon-remove-2"></i></a>
				    </li>
				    <li>
					<a class="save_search_link" href="#">男二号</a><a class="del_search_link" href="#" title="删除"><i class="icon-remove-2"></i></a>
				    </li>
				    <li>
					<a class="save_search_link" href="#" >男三号</a><a class="del_search_link" href="#" title="删除"><i class="icon-remove-2"></i></a>
				    </li>
				</ul>
			</div>
		</div>
	</div>
	<HR/>
	<div class="form-group">	
		<label for="city" class="control-label">城市</label>
		<div >
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
		<label for="degree" class="control-label">学历</label>
		<div >
			<select id="degree" class="form-control">
				<option>本科</option>
				<option>本科</option>
				<option>本科</option>
				<option>本科</option>
			</select>
		</div>
	</div>
 	<div class="form-group">
		<label for="income" class="control-label">收入</label>
		<div >
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
	<HR/>
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
	<HR/>
	<div class="form-group">	
		<label class="control-label">长相</label>
		<div >
			<div id="stara_rating1"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="control-label">身材</label>
		<div >
			<div id="stara_rating2"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="control-label">性格</label>
		<div >
			<div id="stara_rating3"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="control-label">态度</label>
		<div >
			<div id="stara_rating4"></div>
		</div>		
	</div>
	<HR/>
	<div class="form-group">	
		<label for="keyword" class="control-label">关键字</label>
		<div >
			<input id="keyword" type="text" class="form-control" title="输入电话号码/昵称/学校/QQ/职业等等" placeholder="电话号码/昵称/学校...">
		</div>		
	</div>		
</form>	
