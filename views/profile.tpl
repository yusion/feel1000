<!DOCTYPE HTML>
<html>  
<head>
	{{!web_head}}
	<link href="css/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.uploadify.min.js" type="text/javascript"></script>
</head>
<body>
<script type="text/javascript">
        $(function () {
            $("#uploadify").uploadify({
                //指定swf文件
                'swf': 'res/uploadify.swf',
                //后台处理的页面
                'uploader': 'action/upload_profile_photo',
                //按钮显示的文字
                'buttonText': '上传图片',
                //显示的高度和宽度，默认 height 30；width 120
                //'height': 15,
                //'width': 80,
                //上传文件的类型  默认为所有文件    'All Files'  ;  '*.*'
                //在浏览窗口底部的文件类型下拉菜单中显示的文本
                'fileTypeDesc': 'Image Files',
                //允许上传的文件后缀
                'fileTypeExts': '*.gif; *.jpg; *.png; *.bmp',
                //发送给后台的其他参数通过formData指定
                //'formData': { 'someKey': 'someValue', 'someOtherKey': 1 },
                //上传文件页面中，你想要用来作为文件队列的元素的id, 默认为false  自动生成,  不带#
                //'queueID': 'fileQueue',
                //选择文件后自动上传
                'auto': true,
                //设置为true将允许多文件上传
                'multi': false,
				'onUploadSuccess': function (file, data, response) {
                    $('#' + file.id).find('.data').html(' 上传完成');}
            });
        });
    
    </script>
	
<div id="body">
	    <div>
         
        <div id="fileQueue">
        </div>
        <input type="file" name="uploadify" id="uploadify" />
        <p>
            <a href="javascript:$('#uploadify').uploadify('upload')">上传</a>| 
            <a href="javascript:$('#uploadify').uploadify('cancel')">取消上传</a>
        </p>
    </div>
	
	
	<div id="header">
		<div id="base_profile">
		<img src="res/man_unknown.gif"></img>
		<h2>ycat</h2>
		<span id="desc">让所有爱电影的人，都能有一个舒适的座位</span>
		</div>	
		<div id="class1_profile">
		</div>	
		<div id="class2_profile">
		</div>	
		<div id="class3_profile">
		</div>	
    </div>
</body>
</html>