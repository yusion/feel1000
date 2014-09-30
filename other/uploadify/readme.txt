http://www.cnblogs.com/Jimmy009/archive/2012/08/02/2619477.html
http://www.cnblogs.com/babycool/archive/2012/08/04/2623137.html

昨天做了一天的ajax效果的图片上传，就是想让自己学的更加的精一些，所以看了很多第三方的控件，最后还是选择了uploadify这个控件，主要原因是比较容易上手。

首先我们先参考别人的资料（我自己整理了一下）

可选项
需要参数类型 　　 参数名字 　　　　 　　　　解释
(布尔型) 　　 　　 auto 　　 　　 　　 　　　当文件被添加到队列时，自动上传。
(字符串) 　　 　　 buttonImg 　　 　　 　　 浏览按钮的背景图片路径。
(字符串) 　　　　  buttonText 　　　　　　  默认在按钮上显示的文本。
(字符串) 　　　　  cancelImg 　　　　　　    取消按钮的背景图片路径。
(字符串) 　　　　  checkScript 　　　　　　  用以检查服务器上已存在文件的后台脚本的路径。【译者注：应该是ajax方式】
(字符串) 　　　　  displayData 　　　　　　  在上传过程中显示在队列里的数据类型。
(字符串) 　　　　  expressInstall 　　　　　  expressInstall.swf文件的路径。
(字符串) 　　　　  fileDataName 　　　　　　 后台脚本中要处理的file域的名称。【译者注：就是type为file的input的name值】
(字符串)  　　　　 fileDesc 　　　　　　　　   在浏览窗口底部的文件类型下拉菜单中显示的文本。
(字符串) 　　　　  fileExt 　　　　   　　　　  允许上传的文件后缀。【译者注：.jpg/.png等】
(字符串) 　　　　  folder 　　　　　　　　　   上传文件夹的路径，文件上传后将被保存于此。
(整型) 　　　　     height 　　　　　　　　     浏览按钮的高度。
(布尔型) 　　　　  hideButton 　　　　　　    设置为true将隐藏flash按钮，这样你就可以为下面的div元素定义样式。
(字符串) 　　　　  method 　　　　　　　　   向后台脚本放送数据的表单方法。
(布尔型) 　　　　  multi 　　　　　　　　　　 设置为true将允许多文件上传。
(字符串) 　　　　 queueID 　　　　　　　　   页面中，你想要用来作为文件队列的元素的id。
(整型) 　　　　　 queueSizeLimit 　　　　　  上传队列中所允许的文件数量。
(布尔型) 　　　　 removeCompleted 　　　　设置为true将自动移除队列中已经完成上传的项目。
(布尔型) 　　　　 rollover 　　　　　　　　　 设置为true将激活浏览按钮的鼠标划过状态。
(字符串) 　　　　 script 　　　　　　　　　　 处理文件上传的后台脚本的路径。
(字符串) 　　　　 scriptAccess 　　　　　　　设置在主swf文件中的脚本访问模式。
(JSON) 　　　　  scriptData 　　　　　　　　在文件上传时，应该被发送给后台脚本的一个包含name/value键值对以及一些额外信息的json对象。
(整型) 　　　　　 simUploadLimit 　　　　　  允许同时上传的文件数量。
(整型) 　　　　　 sizeLimit 　　　　　　　　  上传文件的大小限制，单位为字节。
(字符串) 　　　　 uploader 　　　　　　　　  uploadify.swf文件的路径。
(整型) 　　　　　 width 　　　　　　　　　　 浏览按钮的宽度。
(字符串) 　　　　 wmode 　　　　　　　　　 flash文件的wmode。

事件
(函数) 　　　　　 onAllComplete 　　　　 　 当上传队列中的所有文件都完成上传时触发。
(函数) 　　　　　 onCancel 　　　　　　　　 当从上传队列每移除一个文件时触发一次。
(函数) 　　　　　 onCheck 　　　　　　　　 在上传开始之前，如果检测到一个同名文件时触发。
(函数) 　　　　　 onClearQueue 　　　　　  当uploadifyClearQueue()方法被调用时触发。
(函数) 　　　　　 onComplete 　　　　　　  每完成一次文件上传时触发一次。
(函数) 　　　　　 onError 　　　　　　　　  当上传返回错误时触发。
(函数) 　　　　　 onInit 　　　　　　　　　  当Uploadify实例被载入时触发。
(函数) 　　　　　 onOpen 　　　　　　　　  当上传队列中的一个文件开始上传时就触发一次。
(函数) 　　　　　 onProgress 　　　　　　  在上传过程中触发。
(函数) 　　　　　 onQueueFull　　　　　　  当文件数量达到上传队列限制时触发。
(函数) 　　　　　 onSelect 　　　　　　　　 每向上传队列添加一个文件时触发。
(函数) 　　　　　 onSelectOnce 　　　　　　每向上传队列添加一个或一组文件时触发。
(函数) 　　　　　 onSWFReady 　　　　　　当flash文件载入完成时触发。

方法 　　　　　　 .uploadify() 　　　　　　  创建Uploadify上传组件的一个实例。
　　　　　　　　  .uploadifyCancel()　　　　从上传队列移除一个文件。如果文件正在上传，该方法将先取消上传，然后再将文件移除出上传队列。
　　　　　　　　.uploadifyClearQueue()　　将所有文件移除出上传队列，并且取消正在执行的所有上传。
　　　　　　　　.uploadifySettings()　　　  改变Uploadify组件的可选参数。
　　　　　　　　.uploadifyUpload()　　　　 触发上传。

 

这里会用到一些参数，但是我们并不需要完全的掌握这些参数，用之前看看有哪些参数，倒是自己会用哪些参数就ok。

由于时间有限，我把核心的代码先发出来，供大家参考：

在<head>标签中先应用css样式   <link href="../Plugin/uploadify.css" rel="stylesheet" type="text/css" />路径这里你的可能和我的不一样

接着再在<head>标签中应用js，js代码注意先后顺序，不然会报错。

 <script type="text/javascript" src="../js/jquery-1.4.2.min.js"></script>
<script src="../Plugin/swfobject.js" type="text/javascript"></script>
<script src="../Plugin/jquery.uploadify.v2.1.4.min.js" type="text/javascript"></script>

同样这里路径是改成你自己的路径。uploaddiy是用jquery开发的，那我们就要先应用jquery才可以再使用uploaddiy所以要注意应用js的时候注意先后顺序