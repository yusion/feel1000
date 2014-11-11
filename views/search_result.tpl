%for index,r in enumerate(result):
	%if index == 0:
		<div class='row search_item'>
	%elif (index%2 == 0):
		</div><div class='row search_item'>
	%end
<div class="col-md-6">
	<div class="search_item_css panel2_css" >
		<div class="search_item_img_css">
			<img src="{{r.photo_url}}" style="display: block">
			<small><i class="icon-parents"></i> 在线
			<i class="icon-skitch"></i> 好友</small>
		</div>		
		<div class="search_item_detail_css">
			<h4 title="姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚">姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚姚</h4>
			<div class="badge_css">
				<i class="icon-iphone" title="手机认证"></i>&nbsp;<i class="icon-nameplate" title="身份认证"></i>&nbsp;
				<i class="icon-camera" title="相片认证"></i>&nbsp;<i class="icon-car" title="有车认证"></i>&nbsp;
				<i class="icon-temple-christianity-church" title="有房认证"></i>
			</div>
			<p class="detail_css"><small>
				广东 广州 | 21岁 | 178厘米 | 50公斤
			</small></p>
			<p class="detail_css"><small>
				<i class="icon-eye-open"></i>1000次 | <i class="icon-heart"></i>21人 | <i class="icon-picture"></i>11张
			</small></p>
			<div class="search_item_score_css">
				<small>
				长相:<span class="star_readonly" star="2"></span><BR/>
				身材:<span class="star_readonly" star="3"></span><BR/>
				性格:<span class="star_readonly" star="1"></span><BR/>
				态度:<span class="star_readonly" star="5"></span><BR/>
				</small>
			</div>
		</div>
	</div>
</div>
%end
</div>