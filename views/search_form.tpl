<script type="text/javascript">
	$(document).ready(function(){
		$("#age").ionRangeSlider({
			min: 20,
			max: 40,
			from:20,
			to: 24,
			type: 'double',//��������
			step: 1,
			prefix: "",//������ֵǰ׺
			postfix: "��",//������ֵ��׺
			prettify: true,
			hasGrid: true
		});
		
		$("#height").ionRangeSlider({
			min: 150,
			max: 210,
			from:150,
			to: 170,
			type: 'double',//��������
			step: 1,
			prefix: "",//������ֵǰ׺
			postfix: "����",//������ֵ��׺
			prettify: true,
			hasGrid: true
		});
		
		$("#weight").ionRangeSlider({
			min: 40,
			max: 100,
			from:40,
			to: 60,
			type: 'double',//��������
			step: 1,
			prefix: "",//������ֵǰ׺
			postfix: "����",//������ֵ��׺
			prettify: true,
			hasGrid: true
		});
	}); 
</script>

<form id="search_form1 " class="form-horizontal green_div" role="form">
<div class="fixDiv blue_div">
	<div class="form-group">	
		<label for="city" class="col-md-4 control-label">����</label>
		<div class="col-md-8">
			<select id="city" class="form-control">
				<option>����</option>
				<option>����</option>
				<option>����</option>
				<option>����</option>
				<option>����</option>
			</select>
		</div>
	</div>
	
	<div class="form-group">			
		<label for="degree" class="col-md-4 control-label">ѧ��</label>
		<div class="col-md-8">
			<select id="degree" class="form-control">
				<option>����</option>
				<option>����</option>
				<option>����</option>
				<option>����</option>
			</select>
		</div>
	</div>
 	<div class="form-group">
		<label for="income" class="col-md-4 control-label">����</label>
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
		<label for="has_car" class="col-md-4 control-label">�г�</label>
		<div class="col-md-8">
			<input id="has_car" type="checkbox" class="form-control input-sm">
		</div>		
	</div>
	<div class="form-group">	
		<label for="has_house" class="col-md-4 control-label">�з�</label>
		<div class="col-md-8">
			<input id="has_house" type="checkbox" class="form-control input-sm">
		</div>		
	</div>
	<div class="form-group">	
		<label class="col-md-4 control-label">����</label>
		<div class="col-md-8">
			<div id="stara_rating1"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="col-md-4 control-label">���</label>
		<div class="col-md-8">
			<div id="stara_rating2"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="col-md-4 control-label">�Ը�</label>
		<div class="col-md-8">
			<div id="stara_rating3"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="col-md-4 control-label">̬��</label>
		<div class="col-md-8">
			<div id="stara_rating4"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label for="age" class="col-md-4 control-label">����</label>
		<div class="col-md-8">
			<input id="age" type="text"/>
		</div>		
	</div>
	<div class="form-group">	
		<label for="height" class="col-md-4 control-label">���</label>
		<div class="col-md-8">
			<input id="height" type="text"/>
		</div>		
	</div>
	<div class="form-group">	
		<label for="weight" class="col-md-4 control-label">����</label>
		<div class="col-md-8">
			<input id="weight" type="text"/>
		</div>		
	</div>
	<div class="form-group">	
		<label for="??" class="col-md-4 control-label">�ؼ���</label>
		<div class="col-md-8">
			<input id="keyword" type="text" class="form-control" placeholder="�绰����/�ǳ�/ѧУ...">
		</div>		
	</div>
	<div class="form-group">
		<div class="col-md-12">
		<button type="submit" class="btn btn-default"><i class="icon-search"></i>����</button>
		</div>
	</div>
</div>
</form>	
