<!-- this is page foot begin-->
<script src="js/test_common.js"></script>

	%if is_test:
	<div class="row">
		<div class="col-md-8 col-md-offset-2" >
			<div id="qunit"></div>
			<div id="qunit-fixture"></div>
		</div>
	</div>
	%end
	
	<div id="page_foot_row" class="row">
	    <div class="col-md-8 col-md-offset-4" >
		<small>
		������վ�����ſͻ���  �������Ķ�  ����Ů��  �е��ʵ�������̳  ����Ӧ��  �����̳ǰ���  ���ױ���Ʒ  ����������  ���׿Ƽ�  �鿴����>><BR>
		..��˾��Ȩ����<BR>�汾�� {{version}}
		
		<p id="browser_version"></p>
		Copyright 360.CN  ��ICP��08010314��-19  ����������110000000006��
		</small>
	    </div>
	</div>
</div> <!-- container end -->

<script>
$(document).ready(function(e){
	var t = get_browser_info();
	$("#browser_version").text(t.name + " " + t.version);
	

});
</script>
 
<!--[if !IE]><!-->
<script>
less = {
    env: "development",
    async: false,
    fileAsync: false,
    poll: 1000,
    functions: {},
    dumpLineNumbers: "comments",
    relativeUrls: false,
    rootpath: ":/127.0.0.1/"
  };	
</script>
<script src="js/less.min.js"></script>    
<!--<![endif]-->

<!-- this is page foot end-->

