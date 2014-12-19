<style type="text/css">
#form_record .control-label{
	color: gray;
}
#form_record .control-label.active{
	color: black; 
}
</style>

<script type="text/javascript">
 	$(document).ready(function(e){
		$("#form_record label").addClass("col-md-2 col-md-offset-2");
		$("#form_record .form-group>div").addClass("col-md-5 ");
		
		$("#form_record input").focus(function(){
			var f = $(this).attr("id");
			var c = $("#form_record").find("[for='"+f+"']");
			$("#form_record").find(".control-label.active").removeClass("active");
			c.addClass("active");
		});
	});
</script>
<form id="form_record" class="form-horizontal" role="form" style="padding-top: 30px;padding-bottom: 20px;background-color: white">
	<div>
		%for r in c_record:
		<div class="form-group">	
			<label for="record_{{r[0]}}" class="control-label">{{r[1]}}</label>
			<div >
				<input class="txt_input form-control" id="record_{{r[0]}}" /> 
			</div>		
		</div>
		%end
		<img src="/res/girl.gif" style="position: absolute;left: 20px;bottom:50px" class="hidden-xs hidden-sm"></img>	
		<div class="form-group" >
			<div class="col-md-2 col-md-offset-4">
				<button class="form-control  green_btn"><i class="icon-ok-2"> 保存</i></button>
			</div>
			<div class="col-md-2">
				<button class="form-control  gray_btn"><i class="icon-remove-2"> 取消</i></button>	
			</div>
		</div>
		<img src="/res/boy.gif" style="position: absolute;right: 20px;bottom:50px" class="hidden-xs hidden-sm"></img>
	</div>
</form>


	
