<link href="/css/fineuploader-5.0.8.min.css" rel="stylesheet">
<script src="/js/all.fineuploader-5.0.8.min.js"></script>

<style type="text/css">
.infomation >div{
	margin-top: 20px;
	color:gray;
}
	
.infomation .text_last_info:after{
	content: "请采用手机或相机拍摄后直接原件上传，修改过的相片不能通过验证"
}

.upload img{
	width: 120px;
	height: auto;
}

.upload .qq-upload-button-selector{
	width: 120px;
	height: auto;
	margin-top: 10px;
}

.title{
	background-color: #fee0e0;
	margin-left: 0px;
	margin-right: 0px;
	padding-bottom: 20px;
}
	
</style>
<script type="text/javascript">
	function init_fineuploader(elem,btnMsg){
		$(elem).fineUploader({
			request: {
			  endpoint: 'action/upload_id_cerf'
			},
			validation: {
				allowedExtensions: ['jpeg', 'jpg'],
				sizeLimit: 1024*1024*20, //20M,
				minSizeLimit: 50*1024 //50K
			},
			text: {
				formatProgress: "{percent}% / {total_size}",
				failUpload: "上传失败",
				waitingForResponse: "正在处理...",
				paused: "暂停"
			},
			messages: {
                                typeError: "'{file}'后缀名不正确，只支持{extensions}后缀的文件",
                                sizeError: "'{file}'太大，最大只支持{sizeLimit}字节",
                                minSizeError: "'{file}'太小, 最小文件长度为 {minSizeLimit}字节.",
                                emptyError: "'{file}'为空文件",
                                noFilesError: "没有文件上传",
                                tooManyItemsError: "选择太多文件，最多可以选择 {itemLimit}个文件，将上传 ({netItems})",
                                maxHeightImageError: "图片太高",
                                maxWidthImageError: "图片太宽",
                                minHeightImageError: "图片不够高",
                                minWidthImageError: "图片不够宽",
                                retryFailTooManyItems: "重试失败",
                                onLeave: "文件正在上传，如果你退出将导致上传失败",
                                unsupportedBrowserIos8Safari: "不支持iOS8 Safari，请使用iOS8 Chrome"
                        },
			multiple:false 
		});
		
		$(elem).find(".qq-upload-button-selector > div").text(btnMsg);
	}
	
	$(document).ready(function(e){
		$("#div_certif_container .title").children("div").addClass("col-md-8 col-md-offset-2");
		$("#div_certif_container .infomation").children("div").addClass("col-md-8 col-md-offset-2");

		$(".icon-lightbulb").css("color","orange");
		init_fineuploader("#div_id_upload","上传身份证相片");
		init_fineuploader("#div_company_upload","上传相片");
	});
</script>
<div id="div_certif_container" style="background-color:white;">
	<div id="div_certif_container">
		<div class="row title">
			<div>
				<h3 class="text-cen1ter in_block"><i class="icon-nameplate"></i><strong>身份证</strong>验证</h3>
				<span >仅仅想和有身份的人交朋友</span>
			</div>
		</div>
		<div class="row upload">
			<div class="col-md-3 col-md-offset-2">
				<img class="in_block" src="res/unknownprofile.jpg"></img>
				<div id="div_id_upload" style="height:50px"></div>
			</div>
			<div class="col-md-3 in_block">
				<img src="res/id_certif_example.jpg"></img><BR>
				<p style="margin-top: 10px;">示例相片</p>
			</div>
		</div>
		<div class="row infomation">
			<div class="small">
				<p><i class="icon-lightbulb"></i>
					1. 身份证验证仅用于确认您的真实有效身份信息，我们承诺绝不会泄露您的身份证信息
				</p>
				<p><i class="icon-lightbulb"></i>
					2. 如您的个人信息和身份证信息不相符，人工客服免费为您修改个人信息	
				</p>
				<p><i class="icon-lightbulb last"></i>
					<span class="text_last_info">3. </span>
				</p>
			</div>
		</div>
		<div class="row title">
			<div>
				<h3 class="text-cen1ter in_block"><i class="icon-nameplate"></i><strong>公司</strong>验证</h3>
				<span >通过公司认证能增加您的成功率喔</span>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3 col-md-offset-2">
				<label>公司名称：</label>
			</div>
			<div class="col-md-4">
				<input  class="form-control" placeholder="请输入公司名称"></input>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3 col-md-offset-2">
				<label>工卡/名片相片：</label>
			</div>
			<div class="col-md-3">
				<div id="div_company_upload"></div>
			</div>
		</div> 
		
		<div class="row infomation">
			<div class="small">
				<p><i class="icon-lightbulb"></i>
					1. 您可以上传工卡和名片相片信息来通过公司验证
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
    <div class="qq-upload-button-selector green_btn">
      <div>上传文件</div>
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
