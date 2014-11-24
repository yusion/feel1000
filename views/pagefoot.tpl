<!-- this is page foot begin-->
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
		合作网站：新闻客户端  网易云阅读  网易女人  有道词典网易论坛  网易应用  网易商城爱拍  网易保健品  网易云音乐  网易科技  查看更多>><BR>
		..公司版权所有<BR>
		<p id="browser_version"></p>
		Copyright 360.CN  京ICP备08010314号-19  京公网安备110000000006号
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

