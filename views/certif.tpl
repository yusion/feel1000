<style type="text/css">
</style>
<script type="text/javascript">
	$(document).ready(function(e){
		$("#form_certif label").parent().addClass("col-md-2 col-md-offset-1");
		$("#form_certif .form-group>div").addClass("col-md-4");
		$("#form_certif H3").parent().addClass("col-md-6 col-md-offset-1");
		$("#form_certif label").css("float","right");
		$("#form_certif label").css("font-weight","normal");
		
		$(".icon-lightbulb").css("color","orange");
	});
</script>
<form id="form_certif" class="form-horizontal" role="form">
	<div id="div_certif_container">
		<div class="row">
			<div>
				<h3><i class="icon-nameplate"></i><strong>身份证</strong>验证</h3>
			</div>
		</div>
		<div class="form-group">
			<div>
				<label for="id_photo_fontside">身份证<strong>正面</strong>相片</label>
			</div>	
			<div>
				<div id="id_photo_fontside"  class="input-group">
					<input type="text" class="form-control" placeholder="相片文件路径">
					<span class="input-group-btn">
					   <button class="btn btn-default" type="button">浏览</button>
					</span>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div>
				<label for="id_photo_backside">身份证<strong>反面</strong>相片</label>
			</div>	
			<div>	
				<div id="id_photo_backside"  class="input-group">
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
				<BR/>3、其中，已通过和预通过的注册用户和常用联系人，可在12306网站正常办理购票业务;其他状态的用户则需要确认在12306网站所填信息的正确性，或持相关证件原件到车站窗口或代售点办理身份信息核验</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-2 col-md-offset-3">
				<button type="submit" class="btn btn-success">上传认证信息</button>
			</div>
		</div>

		<div class="row">
			<div>
				<h3><i class="icon-camera"></i>相片验证</h3>
			</div>
		</div>
		<div class="form-group">
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
				<h3><i class="icon-temple-christianity-church"></i>房产认证</h3>
			</div>
		</div>
		<div class="form-group">
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
		<div class="form-group">
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
		<div class="form-group">
			<div>
				<label for="photo">公司名称</label>
			</div>	
			<div>
				<input type="text" class="form-control" placeholder="公司名称">
			</div>
		</div>
		<div class="form-group">
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
</form>



	
