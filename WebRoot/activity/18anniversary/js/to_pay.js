$(function(){
	$('body').height($(window).height());
	//判断广告是否出售
	$.ajax({
			url: 'action/ajax.jsp',
			data: {
				flag: "isSell",
				adId: $('#adId').val()
			},
			success: function(data) {
				if($.trim(data)==1){
					$('.alert').html('这款产品太火爆，已经被别人抢先了！');
					$('.tip_mask').fadeIn().removeClass('hide');
				}
			}
		});
	
	/**
	 * 提示框 开启/关闭
	 */
	$('.close_it').on('click',function(){
		$(this).parents('.tip_mask').fadeOut(function(){
			$(this).addClass('hide');
		});
	})
	//提交
	$('.pay_btn').on('click',function(){
		var mobile_phone_reg = /^1[34587][0-9]\d{8}$/;
		var tel=$('#tel').val();
		if($("#name").val()==''){
				$('.alert').html('请输入您的姓名！');
				$('.tip_mask').fadeIn().removeClass('hide');
				return false;
		}
		if(tel==''||tel==null||tel.length==0){
			$('.alert').html('请输入您的手机号码！');
			$('.tip_mask').fadeIn().removeClass('hide');
			return false;
		}
		if(!mobile_phone_reg.test(tel)){
			$('.alert').html('请输入正确的手机号码！');
			$('.tip_mask').fadeIn().removeClass('hide');
			return false;
		}
		
		$.ajax({
			url: 'action/ajax.jsp',
			data: {
				flag: "saveOrder",
				uid:$('#openId').val(),
				name:$('#name').val(),
				tel:$('#tel').val(),
				adId:$('#adId').val(),
				adTitle:$('#adTitle').val(),
				money:$('#money').val()
			},
			success: function(data) {
				if($.trim(data)=='isSell'){
					$('.alert').html('这款产品太火爆，已经被别人抢先了！');
					$('.tip_mask').fadeIn().removeClass('hide');
				}
				if($.trim(data)!='' && $.trim(data)!='fail'){
					console.log("微信订单提交");
					$.ajax({
							type:"post",
							url:"wxpay/sub.jsp",
							data:{
								orderNo:$.trim(data),
								openId:$("#openId").val(),
								title:$('#adTitle').val(),
								price:$('#money').val()
							},
							dataType:"json",
							success:function(rs){
								WeixinJSBridge.invoke(
										 'getBrandWCPayRequest', {
											"appId":rs.appId,     //公众号名称，由商户传入     
											"timeStamp":rs.timeStamp,         //时间戳，自1970年以来的秒数     
											"nonceStr":rs.nonceStr, //随机串     
											"package":rs.package,     
											"signType":rs.signType,         //微信签名方式：     
											"paySign":rs.paySign//微信签名 

										   },
									function(res){      
										if(res.err_msg == "get_brand_wcpay_request:ok" ) {}     // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。 
									}
								); 
							}
					});
				}
			}
		});	
		
	})
})
