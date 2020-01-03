$(function(){
	$('body').height($(window).height());
	/**
	 * 初始化
	 */
	 
	 //已经绑定过品牌
	$.ajax({
		url: 'action/ajax.jsp',
		data: {
			flag :'hasBindBrand',
			uid: $('#openId').val()
		},
		success: function(data){
			if(parseInt($.trim(data))==0){
				$('.mask').removeClass('hide');
			}
		}
	})
	//势力榜列表
	$.ajax({
		url: 'action/ajax.jsp',
		data: {
			flag :'rankList'
		},
		success: function(data){
			$('.rl_main').html($.trim(data));
		}
	})
	//定时刷新
	var reloadList = setInterval(function(){
			console.log('刷新');
			$.ajax({
			url: 'action/ajax.jsp',
				data: {
					flag :'rankList'
				},
				success: function(data){
					$('.rl_main').html($.trim(data));
				}
			})
		},300000);
	/**
	 * 上下分离
	 */
	$('.rl_main').css('height',$('body').height()-$('.rl_header').height()+'px');
	//助力
	$('.rl_main').on('click','.point_it',function(){
		var thisPar = $(this).parent();
		$.ajax({
			url: 'action/ajax.jsp',
			data: {
				flag: 'doHelp',
				uid: $('#openId').val(),
				brandId: $(this).data('id')
			},
			success: function(data){
				if($.trim(data)=='success'){
					var elem = $('<span></span>')
					.addClass('add1')
					.text('+1')
					.appendTo(thisPar)
					.animate({
						top:"-1rem",
						opacity:"0",
					},8000,'linear',function(){
						$(this).remove()
					})
					$.ajax({
						url: 'action/ajax.jsp',
						data: {
							flag :'rankList'
						},
						success: function(data){
							$('.rl_main').html($.trim(data));
						}
					})
					
				}else if($.trim(data)=='over'){
					$('.el').html('您今天的助力机会已用完，明天再来吧！');
					$('.tip_mask').fadeIn().removeClass('hide');
				}else{
					$('.el').html('操作失败！');
					$('.tip_mask').fadeIn().removeClass('hide');
				}
			}
		});
	})
	
	/**
	 * 填写品牌
	 */
	$('#brand').on('change',function(){
		if($('#brand option:selected').val()=='999'){
			$('.write_brand').removeClass('hide');
		}else{
			$('.write_brand').addClass('hide');
		}
	})
	/**
	 * 提示框 开启/关闭
	 */
	$('.close_it').on('click',function(){
		$(this).parents('.tip_mask').fadeOut(function(){
			$(this).addClass('hide');
		});
	})
	
	
	/**
	 * 按钮动画
	 */
	var inner = -50,center = 0,outer = 0;
	var btnbiling = setInterval(function(){
		inner++;
		center = inner+50,
		outer = inner+100;
		$('.sub_btn').css({
			'background':'radial-gradient(circle,rgba(188,128,254,.9) '+inner+'%,rgba(176,249,245,.9)'+center+'%, rgba(188,128,254,.9) '+outer+'%)'
		})
		if(inner == 100){inner=-50;}
	},20)
	
	//用户品牌绑定
	$('.sub_btn').on('click',function(){
		var mobile_phone_reg = /^1[34587][0-9]\d{8}$/;
		var tel=$('#tel').val();
		if(tel==''||tel==null||tel.length==0){
			$('.el').html('请输入您的手机号码！');
			$('.tip_mask').fadeIn().removeClass('hide');
			return false;
		}
		if(!mobile_phone_reg.test(tel)){
			$('.el').html('请输入正确的手机号码！');
			$('.tip_mask').fadeIn().removeClass('hide');
			return false;
		}
		$.ajax({
			url: 'action/ajax.jsp',
			data: {
				flag: "saveUserBrand",
				uid:$('#openId').val(),
				tel:$('#tel').val(),
				brandId:$('#brand').val(),
				otherBrand:$('#otherBrand').val()
			},
			success: function(data) {
				if($.trim(data)=='success'){
					//成功后提交框隐藏
					$('.mask').addClass('hide');
				}
			}
				
		});	
		
	})
})