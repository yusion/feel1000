<link href="/css/fineuploader-5.0.8.min.css" rel="stylesheet">
<script src="/js/all.fineuploader-5.0.8.min.js"></script>

<style type="text/css">
.infomation{
	margin-top: 30px;
}
.infomation .text_last_info:after{
	content: "请采用手机或相机拍摄后直接上传，用软件修改过的相片将不能通过认证"
}
.upload_id .img_id{
	width: 150px;
	height: auto;
}
.upload_id .qq-upload-button-selector{
	width: 150px;
	margin-top: 15px;
	margin-bottom: 15px;
}
	
</style>
<script type="text/javascript">
	function init_fineuploader(elem,btnMsg){
		$(elem).fineUploader({
			request: {
			  endpoint: 'action/upload_id'
			},
			multiple:false,
			validation: {
                                allowedExtensions: ["jpeg","jpg"],
                                sizeLimit: 20 * 1024 * 1024,
                                minSizeLimit: 1024*10
                        },
			messages: {
                                typeError: "不支持{file}后缀文件，只支持{extensions}的后缀",
                                sizeError: "{file}太大,最大文件为{sizeLimit}字节",
                                minSizeError: "{file}太小，最小文件为{minSizeLimit}字节",
                                emptyError: "{file}为空",
                                noFilesError: "没有文件可以上传",
                                tooManyItemsError: "太多文件，只有({netItems}) 可以上传. 最大文件数为{itemLimit}",
                                maxHeightImageError: "图片太长",
                                maxWidthImageError: "图片太宽",
                                minHeightImageError: "图片不够长",
                                minWidthImageError: "图片不够宽",
                                retryFailTooManyItems: "重试失败",
                                onLeave: "正在上传文件，如果您离开，将导致上传失败",
                                unsupportedBrowserIos8Safari: "不支持iOS8 Safari浏览器，请使用iOS8 Chrome"
                        },
			text: {
				formatProgress: "{percent}% / {total_size}",
				failUpload: "上传失败",
				waitingForResponse: "正在处理...",
				paused: "暂停"
				}
		});
		
		$(elem).find(".qq-upload-button-selector > div").text(btnMsg);
	}
	
	$(document).ready(function(e){
		$("#div_certif_container .title").children("div").addClass("col-md-8 col-md-offset-1");
		$("#div_certif_container .infomation").children("div").addClass("col-md-8 col-md-offset-1");

		$(".icon-lightbulb").css("color","orange");
		init_fineuploader("#div_id_upload","上传身份证相片");
		init_fineuploader("#div_company_upload","上传相片");
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
		<div class="row upload_id">
			<div class="col-md-4 col-md-offset-1">
				<img class="img_id" src="res/unknownprofile.jpg"></img>
				<div id="div_id_upload"></div>
			</div>
			<div class="col-md-5">
				<span style="vertical-align: top">示例：<span><img class="in_block" src="res/id_certif_example.png"></img>
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
					<span class="text_last_info">3. </span>
				</p>
			</div>
		</div>
		<HR>
		<div class="row title">
			<div>
				<h3 class="text-cen1ter in_block"><i class="icon-nameplate"></i><strong>公司</strong>验证</h3>
				<span >我们仅仅想和有身份的人交朋友</span>
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 col-md-offset-1">
				<label for="photo">公司名称</label>
			</div>	
			<div class="col-md-4">
				<input type="text" class="form-control" placeholder="公司名称">
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 col-md-offset-1">
				<label for="photo">工卡或名片相片</label>
			</div>	
			<div class="col-md-4">
				<div id="div_company_upload"></div>
			</div>
		</div>
		<div class="row infomation">
			<div class="small">
				<p><i class="icon-lightbulb"></i>
					1. 公司证验证仅用于确认您的公司信息，网站不会泄露您的任何个人资料
				</p>
				<p><i class="icon-lightbulb last"></i>
					<span class="text_last_info">2. </span>
				</p>
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
