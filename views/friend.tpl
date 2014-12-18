<style type="text/css">
#div_friend{
	background-color: #fdf5e9;
	padding-top: 20px;
	padding-left: 4px;
	padding-bottom: 20px;
	border-radius: 5px;
	box-shadow: 4px 10px 6px #c2baae;
}

#div_friend_list{
	
}

#div_friend_list >ul>li{
	margin-top: 10px;
	margin-bottom: 5px;
	padding-left: 5px;
}

#div_friend_list HR{
	margin-top: 0px; 
	margin-bottom: 0px; 
}

.div_click{
	width:32px;
	height:46px;
	background: url(/res/small_icon.png) no-repeat -460px 0px;
	position: absolute;
	top: -38px;
}

#div_border{
	height: 25px;
	width: 100%;
	position: relative;
	top:22px;
	background: url("/res/border5.gif") repeat-x;
}

#div_friend button{
	background-color:#ffbabb;
	background: -webkit-linear-gradient(#ff6363, #ffbabb); /* Safari 5.1 - 6.0 */
	background: -o-linear-gradient(#ff6363, #ffbabb); /* Opera 11.1 - 12.0 */
	background: -moz-linear-gradient(#ff6363, #ffbabb); /* Firefox 3.6 - 15 */
	background: linear-gradient(#ff6363, #ffbabb); /* ��׼���﷨ */
	font-weight: 800;color:white;width:100%;
	border-style: double;
}

</style>
<div id="div_friend">
	<div class="div_click in_block" style="left: 30px;"></div>
	<div class="div_click in_block" style="right: 30px;"></div>
	<div style="padding: 10px 20px 10px 20px">
	<button type="button" class="btn btn-default">
		<span class="icon-camera" style="font-size: 24px;color:white;margin-bottom: 0;margin-right:10px;vertical-align: middle"></span>
		<div class="in_block" style="vertical-align: middle;">������Ƭ</div>
	</button>
	</div>
	<div id="div_friend_list">
		<hr>
		<H4 style="color:gray;margin-left: 20px">�ҵĺ���(1/50)</H4>
		<ul class="list-unstyled">
			%for i in range(10):
			<hr>
			<li>
				<img src="res/test/a ({{i%9+1}}).jpg" class="thumbnail_profile" >ͬʱ���ְ�ťͬ
			</li>		
			%end
		</ul>
	</div>
</div>
