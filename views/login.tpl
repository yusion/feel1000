<div id="div_login" style="margin-top: 20px">
	<div class="row">
		<div class="col-md-12">
			<input type="text" name="nickname" class="form-control limit_m" id="nickname" maxLen="20" placeholder="�ǳ�/�ֻ�����">
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<input type="password" name="password" class="form-control limit_m" id="password" placeholder="����">
		</div>
	</div>  
	<div class="row small">
		<div class="col-md-6">
		   <span class="checkbox_ctrl text-left" >�������</span>
		</div>
		<div class="pull-right col-md-6">
		   <a href="reset_pwd.html" class="fr" target="_blank">�������룿</a>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<button id="btn_login" type="submit" class="btn btn-success form-control"  style="margin-top: 10px">��&nbsp; ¼</button>
		</div>
	</div>
</div>
<script type="text/javascript">	
</script>
%if is_test:
     <script type="text/javascript">
     QUnit.module("login");
     </script>
%end     
