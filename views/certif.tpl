<link href="/css/fineuploader.css" rel="stylesheet">
<script src="/js/all.fineuploader-5.0.8.min.js"></script>

<style type="text/css">
.infomation .text_last_info:after{
	content: "3. 请采用手机或相机拍摄后直接上传，请勿用任何软件修改相片"
}
	
</style>
<script type="text/javascript">
	function init_fineuploader(elem,btnMsg){
		$(elem).fineUploader({
			request: {
			  endpoint: 'server/handleUploads'
			},
			multiple:false
		});
		
		$(elem).find(".qq-upload-button-selector > div").text(btnMsg);
	}
	
	$(document).ready(function(e){
		$("#div_certif_container .title").children("div").addClass("col-md-8 col-md-offset-1");
		$("#div_certif_container .infomation").children("div").addClass("col-md-8 col-md-offset-1");
		//$("#div_certif_container .upload").children("div").addClass("col-md-2 col-md-offset-3");

		$(".icon-lightbulb").css("color","orange");
		init_fineuploader("#div_id_font_upload","上传身份证相片");
	});
</script>
<div id="div_certif_container">
	<div id="div_certif_container">
		<div class="row title">
			<div>
				<h3 class="text-cen1ter in_block"><i class="icon-nameplate"></i><strong>身份证</strong>验证</h3>
				<span >我们仅仅想和有身份的人交朋友</span>
			</div>
		</div>
		<div class="row upload">
			<div class="col-md-4 col-md-offset-1">
				<img src="res/id_certif_example.png"></img>
				<div id="div_id_font_upload"></div>
			</div>
			<div class="col-md-4">
				示例：<img class="in_block" src="res/id_certif_example.png"></img>
			</div>
		</div>
		<div class="row infomation">
			<div class="small">
				<p><i class="icon-lightbulb"></i>
					1. 身份证验证仅用于确认您的真实有效身份信息，网站不会泄露您的任何个人资料
				</p>
				<p><i class="icon-lightbulb"></i>
					2. 如您的个人信息和身份证信息不相符，我们将以身份证信息为修改您的个人信息	
				</p>
				<p><i class="icon-lightbulb last"></i>
					<span class="text_last_info"></span>
				</p>
			</div>
		</div>
		<HR>

		<div class="row">
			<div>
				<h3><i class="icon-temple-christianity-church"></i>房产认证</h3>
			</div>
		</div>
		<div class="row">
			<div>
				<label for="photo">房产证相片</label>
			</div>	
			<div>
				<div id="photo"  class="input-group">
					<input type="text" class="form-control" placeholder="相片文件路径">
					<span class="input-group-btn">
					   <button class="btn btn-default" type="button">浏览</button>
					</span>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-9 col-md-offset-1">
				<p class="help-block"><i class="icon-lightbulb"></i>1、首先，此次身份信息核验是为了验证常用联系人身份信息的真实性，并不需要民众的参与，由12306网站自动完成。
				<BR/>2、其次，在12306网站上使用二代居民身份证的注册用户和常用联系人身份信息经过身份验证将会产生三种结果：已通过、待核验和未通过。使用护照、港澳居民来往内地通行证、台湾居民来往大陆通行证的注册用户和常用联系人身份信息将有“已通过”“请报验”“预通过”“未通过”四种核验状态。
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 col-md-offset-3">
				<button type="submit" class="btn btn-success">上传认证信息</button>
			</div>
		</div>
		
		
		
		<div class="row">
			<div>
				<h3><i class="icon-car"></i>车子验证</h3>
			</div>
		</div>
		<div class="row">
			<div>
				<label for="photo">相片</label>
			</div>	
			<div>
				<div id="photo"  class="input-group">
					<input type="text" class="form-control" placeholder="相片文件路径">
					<span class="input-group-btn">
					   <button class="btn btn-default" type="button">浏览</button>
					</span>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-9 col-md-offset-1">
				<p class="help-block"><i class="icon-lightbulb"></i>1、首先，此次身份信息核验是为了验证常用联系人身份信息的真实性，并不需要民众的参与，由12306网站自动完成。
				<BR/>2、其次，在12306网站上使用二代居民身份证的注册用户和常用联系人身份信息经过身份验证将会产生三种结果：已通过、待核验和未通过。使用护照、港澳居民来往内地通行证、台湾居民来往大陆通行证的注册用户和常用联系人身份信息将有“已通过”“请报验”“预通过”“未通过”四种核验状态。
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 col-md-offset-3">
				<button type="submit" class="btn btn-success">上传认证信息</button>
			</div>
		</div>
		
		<div class="row">
			<div>
				<h3><i class="icon-car"></i>公司验证</h3>
			</div>
		</div>
		<div class="row">
			<div>
				<label for="photo">公司名称</label>
			</div>	
			<div>
				<input type="text" class="form-control" placeholder="公司名称">
			</div>
		</div>
		<div class="row">
			<div>
				<label for="photo"><strong>工卡/名片</strong>相片</label>
			</div>	
			<div>
				<div id="photo"  class="input-group">
					<input type="text" class="form-control" placeholder="相片文件路径">
					<span class="input-group-btn">
					   <button class="btn btn-default" type="button">浏览</button>
					</span>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-9 col-md-offset-1">
				<p class="help-block"><i class="icon-lightbulb"></i>1、首先，此次身份信息核验是为了验证常用联系人身份信息的真实性，并不需要民众的参与，由12306网站自动完成。
				<BR/>2、其次，在12306网站上使用二代居民身份证的注册用户和常用联系人身份信息经过身份验证将会产生三种结果：已通过、待核验和未通过。使用护照、港澳居民来往内地通行证、台湾居民来往大陆通行证的注册用户和常用联系人身份信息将有“已通过”“请报验”“预通过”“未通过”四种核验状态。
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 col-md-offset-3">
				<button type="submit" class="btn btn-success">上传认证信息</button>
			</div>
		</div>	 
	</div>	     
</div>


<!-- Fine Uploader template begin -->
<script type="text/template" id="qq-template">
  <div class="qq-uploader-selector qq-uploader">
    <div class="qq-upload-drop-area-selector qq-upload-drop-area" qq-hide-dropzone>
      <span>把文件拖动到这里开始上传...</span>
    </div>
    <div class="qq-upload-button-selector btn btn-success">
      <div>上传身份证相片</div>
    </div>
    <span class="qq-drop-processing-selector qq-drop-processing">
      <span>正在处理拖动文件...</span>
      <span class="qq-drop-processing-spinner-selector qq-drop-processing-spinner"></span>
    </span>
    <ul class="qq-upload-list-selector qq-upload-list">
      <li>
        <div class="qq-progress-bar-container-selector">
          <div class="qq-progress-bar-selector qq-progress-bar"></div>
        </div>
        <span class="qq-upload-spinner-selector qq-upload-spinner"></span>
        <span class="qq-edit-filename-icon-selector qq-edit-filename-icon"></span>
        <span class="qq-upload-file-selector qq-upload-file"></span>
        <input class="qq-edit-filename-selector qq-edit-filename" tabindex="0" type="text">
        <span class="qq-upload-size-selector qq-upload-size"></span>
        <a class="qq-upload-cancel-selector qq-upload-cancel" href="#">取消</a>
        <a class="qq-upload-retry-selector qq-upload-retry" href="#">重试</a>
        <a class="qq-upload-delete-selector qq-upload-delete" href="#">删除</a>
        <span class="qq-upload-status-text-selector qq-upload-status-text"></span>
      </li>
    </ul>
  </div>
</script>
<!-- Fine Uploader template end -->	
