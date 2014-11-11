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
			type: 'double',//��������
			step: 1,
			prefix: "",//������ֵǰ׺
			postfix: "��",//������ֵ��׺
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
			type: 'double',//��������
			step: 1,
			prefix: "",//������ֵǰ׺
			postfix: "����",//������ֵ��׺
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
			type: 'double',//��������
			step: 1,
			prefix: "",//������ֵǰ׺
			postfix: "����",//������ֵ��׺
			prettify: true,
			hasGrid: true,
			gridMargin: 1,
			hideMinMax: true
		});
		
		var c = new Vcity.CitySelector({input:'city'});
		
		//setup star rating 
		$("#star_rating1").raty({ start:2,inline_width:68});
		$("#star_rating2").raty({ start:3,inline_width:68});
		$("#star_rating3").raty({ start:4,inline_width:68});
		$("#star_rating4").raty({ start:2,inline_width:68});
	}); 
</script>

<form id="search_form" class="form-horizontal fixDiv panel_css" role="form">
	
	<div class="form-group">	
		<label for="city" class="control-label">����</label>
		<div >
			<input type="text" class="cityinput form-control" id="city" value="������">
		</div>
	</div>
	
	<div class="form-group">			
		<label for="degree" class="control-label">ѧ��</label>
		<div >
			<select id="degree" class="form-control">
				<option>����</option>
				<option>����</option>
				<option>����</option>
				<option>����</option>
			</select>
		</div>
	</div>
 	<div class="form-group">
		<label for="income" class="control-label">����</label>
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
		<label for="condition" class="control-label">����</label>
		<div >
			<select id="condition" class="form-control">
				<option>��</option>
				<option>�г�</option>
				<option>�з�</option>
				<option>�з�\�г�</option>
			</select>
		</div>
	</div>
	<HR/>
	<div class="form-group">	
		<label for="age" class="control-label">����</label>
		<div >
			<input id="age" type="text"/>
		</div>		
	</div>
	<div class="form-group">	
		<label for="height" class="control-label">���</label>
		<div >
			<input id="height" type="text"/>
		</div>		
	</div>
	<div class="form-group">	
		<label for="weight" class="control-label">����</label>
		<div >
			<input id="weight" type="text"/>
		</div>		
	</div>
	<HR/>
	<div class="form-group">	
		<label class="control-label">����</label>
		<div >
			<div id="star_rating1"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="control-label">���</label>
		<div >
			<div id="star_rating2"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="control-label">�Ը�</label>
		<div >
			<div id="star_rating3"></div>
		</div>		
	</div>
	<div class="form-group">	
		<label class="control-label">̬��</label>
		<div >
			<div id="star_rating4"></div>
		</div>		
	</div>
	<HR/>
	<div class="form-group">	
		<label for="keyword" class="control-label">�ؼ���</label>
		<div >
			<input id="keyword" type="text" class="form-control" title="����绰����/�ǳ�/ѧУ/QQ/ְҵ�ȵ�" placeholder="�绰����/�ǳ�/ѧУ...">
		</div>		
	</div>		 
	<BR/>
	<div class="form-group">
		<div class="col-md-6">
			<button type="submit" class="btn btn-default button_css" style="width: 100%">
				<i class="icon-search"></i>����
			</button>
		</div>
		<div class="col-md-6"> 
			<div class="input-group-btn">
				<button type="button" style="width: 100%;border-radius: 4px;" class="btn btn-default button_css" data-toggle="dropdown">
			           <i class="icon-bookmark">�ղ�</i>
				   <span class="caret"></span>
				   <span class="sr-only">�л������˵�</span>
				</button>
				<ul class="dropdown-menu">
				    <li>
					<a class="save_search_link" href="#">��һ��</a><a class="del_search_link" href="#" title="ɾ��"><i class="icon-remove-2"></i></a>
				    </li>
				    <li>
					<a class="save_search_link" href="#">�ж���</a><a class="del_search_link" href="#" title="ɾ��"><i class="icon-remove-2"></i></a>
				    </li>
				    <li>
					<a class="save_search_link" href="#" >������</a><a class="del_search_link" href="#" title="ɾ��"><i class="icon-remove-2"></i></a>
				    </li>
				    <li>
					<a class="save_search_link" href="#">����Ϊ���ĺ�</a>
				    </li>
				</ul>
			</div>
		</div>
	</div>
	
</form>	
