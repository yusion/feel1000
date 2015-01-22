<style type="text/css">
#form_record .control-label{
	color: gray;
}
#form_record .control-label.active{
	color: black; 
}

#form_record .control-label.modified:before{
	content: " *";
	color: red;
}
</style>

<script type="text/javascript">
	function is_modified(item){
		return item.val().trim2() != item.attr("old").trim2();
	}
	
	function update_mark(){
		$("#form_record input").each(function(){
			var f = $(this).attr("id");
			var c = $("#form_record").find("[for='"+f+"']");
			if (is_modified($(this))){
				c.addClass("modified"); 
			}
			else{
				c.removeClass("modified");	
			}
			$(".div_record .active").removeClass("active");
		});
	}
		
	function save_record(){
		var ids = new Array();
		var vals = new Array();
		$("#form_record input").each(function(){
			if (is_modified($(this))) {
				ids.push($(this).attr("recordID"));
				vals.push($(this).val());
			}
		});
		$.getJSON("/action/save_record",{ids:ids.join("@@"),vals:vals.join("@@")},
			function(json){
				if (json.result == "true") {
					$("#form_record input").each(function(){
						if (is_modified($(this))) {
							$(this).attr("old",$(this).val());
						}
					});
				}
				else{
					alert("保存个人喜好失败");
				}
				update_mark();
			});
	}
		
	function cancle_record(){
		$("#form_record input").each(function(){
			$(this).val($(this).attr("old"));
		});
		update_mark();
	}
		
 	$(document).ready(function(e){
		$("#form_record label").addClass("col-md-2 col-md-offset-2");
		$("#form_record .form-group>div").addClass("col-md-5 ");
		
		$("#form_record input").focus(function(){
			var f = $(this).attr("id");
			var c = $("#form_record").find("[for='"+f+"']");
			$("#form_record").find(".control-label.active").removeClass("active");
			c.addClass("active");
		});
		
		
		$("#form_record input").blur(function(){
			var v = $(this).val();
			if (v.length>=20) {
				$(this).val(v.substr(0,20));
			}
			update_mark();
		});
	});
</script>
<div id="form_record" class="form-horizontal"  style="padding-top: 30px;padding-bottom: 20px;background-color: white">
	<div>
		%for r in c_record:
		<div class="form-group div_record" >	
			<label for="record_{{r[0]}}" class="control-label">{{r[1]}}</label>
			<div >
				%vv = ""
				%if r[0] in record_value:
				%	vv = record_value[r[0]]
				%end
				<input class="txt_input form-control limit_m" id="record_{{r[0]}}" recordID="{{r[0]}}" old="{{vv}}" value="{{vv}}">
			</div>		
		</div>
		%end
		<img src="/res/girl.gif" style="position: absolute;left: 20px;bottom:50px" class="hidden-xs hidden-sm"></img>	
		<div class="form-group" >
			<div class="col-md-2 col-md-offset-4">
				<button  id="btn_save" class="form-control  green_btn" onclick="save_record();"><i class="icon-ok-2"> 保存</i></button>
			</div>
			<div class="col-md-2">
				<button id="btn_cancel" class="form-control  gray_btn" onclick="cancle_record();"><i class="icon-remove-2"> 取消</i></button>	
			</div>
		</div>
		<img src="/res/boy.gif" style="position: absolute;right: 20px;bottom:50px" class="hidden-xs hidden-sm"></img>
	</div>
</div>


%if is_test:
     <script type="text/javascript">
      QUnit.module("record");
      
      QUnit.asyncTest("init",function(assert){
	$.getJSON("/test/get_record",null,
		function(json){
			assert.equal($(".div_record").length,object_length(json));
			for (var i =0;i<$(".div_record").length;i++) {
				assert.equal($(".div_record").eq(i).children("label").text(),json[i+1][0])				
				var id = "#record_"+(1+i).toString();
				assert.equal($(id).val(),json[i+1][1])
				assert.equal($(id).attr("old"),json[i+1][1])
				assert.equal($(id).attr("recordID"),(i+1).toString());
			}
			QUnit.start();
		});
	});
       var oldVal = {};
      QUnit.test("cancel",function(assert){
		var a = {};
		for (var i =0;i<$(".div_record").length;i++) {
			var id = "#record_"+(1+i).toString(); 
			oldVal[id] = $(id).val();
			$(id).val($(id).val()+"lalalala " + id);
			$(id).blur();
		}
		assert.equal($(".div_record").length,$("label.modified").length);
		$("#btn_cancel").click();
		assert.equal(0,$("label.modified").length);
		for (var i =0;i<$(".div_record").length;i++) {
			var id = "#record_"+(1+i).toString();
			assert.equal($(id).val(),$(id).attr("old"));
			assert.equal($(id).val(),oldVal[id]);
		}
      });
     
       QUnit.asyncTest("save_record1",function(assert){
		var a={};
		for (var i =0;i<$(".div_record").length;i++) {
			var id = "#record_"+(1+i).toString();
			$(id).val($(id).val()+id);
			a[id] = $(id).val();
		}
		$("#record_1").blur();
		assert.equal($(".div_record").length,$("label.modified").length);
		$("#btn_save").click();
		setTimeout(function(){
			for (var i =0;i<$(".div_record").length;i++) {
				var id = "#record_"+(1+i).toString();
				assert.equal($(id).val(),a[id]);
				assert.ok(!is_modified($(id)));
			}
			assert.equal(0,$("label.modified").length);
			$.getJSON("/test/get_record",null,
				function(json){
					assert.equal($(".div_record").length,object_length(json));
					for (var i =0;i<$(".div_record").length;i++) {
						var id = "#record_"+(1+i).toString();
						assert.equal(json[i+1][1],$(id).val())
					}
					QUnit.start();
				});
			},500);
	});
 
	QUnit.asyncTest("restore",function(assert){
		for (var i =0;i<$(".div_record").length;i++) {
			var id = "#record_"+(1+i).toString();
			$(id).val(oldVal[id]);
		}
		$("#record_1").blur();
		assert.equal($(".div_record").length,$("label.modified").length);
		$("#btn_save").click();
		setTimeout(function(){
			for (var i =0;i<$(".div_record").length;i++) {
				var id = "#record_"+(1+i).toString();
				assert.equal($(id).val(),oldVal[id]);
				assert.ok(!is_modified($(id)));
			}
			assert.equal(0,$("label.modified").length);
			$.getJSON("/test/get_record",null,
				function(json){
					assert.equal($(".div_record").length,object_length(json));
					for (var i =0;i<$(".div_record").length;i++) {
						var id = "#record_"+(1+i).toString();
						assert.equal(json[i+1][1],$(id).val())
					}
					QUnit.start();
				});
			},500);
	});
  </script>
%end 
	
