<style type="text/css">
</style>

<script type="text/javascript">
 	$(document).ready(function(e){
		$("#form_record label").addClass("col-md-2");
		$("#form_record .form-group>div").addClass("col-md-5");
	});
</script>
 
<form id="form_record" class="form-horizontal" role="form" style="padding-top: 30px;padding-bottom: 20px">
	<div>
		%for r in c_record:
		<div class="form-group">	
			<label for="record_{{r[0]}}" class="control-label">{{r[1]}}</label>
			<div >
				<input class="txt_input form-control" id="record_{{r[0]}}" /> 
			</div>		
		</div>
		%end
	
		<div class="form-group" >
			<div class="col-md-2 col-md-offset-2">
				<button class="form-control  btn btn-success"><i class="icon-ok-2"> 保存</i></button>
			</div>
			<div class="col-md-2">
				<button class="form-control  btn btn-danger"><i class="icon-remove-2"> 取消</i></button>	
			</div>
		</div>	
	</div>
</form>


	
