%for index,r in enumerate(result):
	%if index == 0:
		<div class='row search_item'>
	%elif (index%2 == 0):
		</div><div class='row search_item'>
	%end
<div class="col-md-6">
	<div class="search_item_css panel2_css" >
		<div class="search_item_img_css">
			<img src="{{r.photo_url}}" class="hot_tag" style="display: block">
			<small>&nbsp;&nbsp;<i class="icon-parents"></i> ����
			&nbsp;&nbsp;
			<i class="icon-skitch"></i> ����</small>
		</div>		
		<div class="search_item_detail_css">
			<h4 title="ҦҦҦҦҦҦҦҦҦҦҦҦҦҦҦҦ">ҦҦҦҦҦҦҦҦҦҦҦҦҦҦҦҦ</h4>
			<div class="badge_css">
				<i class="icon-iphone" title="�ֻ���֤"></i>&nbsp;<i class="icon-nameplate" title="�����֤"></i>&nbsp;
				<i class="icon-camera" title="��Ƭ��֤"></i>&nbsp;<i class="icon-car" title="�г���֤"></i>&nbsp;
				<i class="icon-temple-christianity-church" title="�з���֤"></i>
			</div>
			<p class="detail_css"><small>
				�㶫 ���� | 21�� | 178���� | 50����
			</small></p>
			<p class="detail_css"><small>
				<i class="icon-eye-open"></i>1000�� | <i class="icon-heart"></i>21�� | <i class="icon-picture"></i>11��
			</small></p>
			<div class="search_item_score_css">
				<small>
				����:<span class="star_readonly" star="2"></span><BR/>
				���:<span class="star_readonly" star="3"></span><BR/>
				�Ը�:<span class="star_readonly" star="1"></span><BR/>
				̬��:<span class="star_readonly" star="5"></span><BR/>
				</small>
			</div>
		</div>
	</div>
</div>
%end
</div>