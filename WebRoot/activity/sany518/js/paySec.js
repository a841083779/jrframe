$(function(){
	
	$('#zfb').on('click',function(){
		//微信打开 显示遮罩层
		if(isWeiXin()){
			loadHtml();
			loadStyleText(cssText);
		}
	})
	/**
	 * 选中获取 
	 */
	$('.pay_ways').on('change','input',function(){
		var $this = $(this);
		$('label').removeClass('check');
		$this.parent().find('label').addClass('check');
	})
	
	
	
	
	/**
	 * 确认方式测试 
	 */
	$('.confirm').on('click',function(){
		var mobile_phone_reg = /^1[34587][0-9]\d{8}$/;
			var source=$("input[name='source']:checked").val();
			$.ajax({
					type:"post",
					url:"action/ajax.jsp",
					data:{
						flag:"updateOrder",
						source:source,
						openId:$("#openId").val(),
						price:$("#price").val(),
						productId:$("#productId").val(),
						productName:$("#productName").val()
					},
					success:function(rs){
						var order_num=$.trim(rs);
						if(order_num != ""&&order_num!="fail"){
							if(source=='zfb'){
								window.location.href="action/alipay/alipayapi.jsp?WIDout_trade_no=" + order_num +"&WIDsubject=三一"+$("#productName").val()+"微型液压挖掘机预售金&WIDtotal_amount="+$("#price").val()+"&WIDbody=三一"+$("#productName").val()+"微型液压挖掘机预售金"+$("#price").val()+"元";
							}else if(source=='vx'){
								
								$.ajax({
									type:"post",
									url:"http://product.21-sun.com/wxpay/sub.jsp",
									data:{
										orderNo:order_num,
										openId:$("#openId").val(),
										proName:"三一"+$("#productName").val()+"微型液压挖掘机",
										payType:2
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
												//alert(res.err_msg);	   
											   if(res.err_msg == "get_brand_wcpay_request:ok" ) {}     // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。 
										   }
									   ); 
									}
								});
							}
							
						}else{
							alert("系统错误，订单提交失败，请稍后重试！");
						}
					}
			});

		
	})
	
})
	var cssText = "#weixin-tip{position: fixed; left:0; top:0; background: rgba(0,0,0,0.8); filter:alpha(opacity=80); width: 100%; height:100%; z-index: 100;} #weixin-tip p{text-align: center; margin-top: 10%; padding:0 5%;}";
	function isWeiXin(){
		var ua = window.navigator.userAgent.toLowerCase();
		if(ua.match(/MicroMessenger/i) == 'micromessenger'){
			return true;
		}else{
			return false;
		}
	}
	function loadHtml(){
		var div = document.createElement('div');
		div.id = 'weixin-tip';
		div.innerHTML = '<p><img src="images/live_weixin.png" alt="微信打开"/></p>';
		document.body.appendChild(div);
	}
		
	function loadStyleText(cssText) {
	    var style = document.createElement('style');
	    style.rel = 'stylesheet';
	    style.type = 'text/css';
	    try {
	        style.appendChild(document.createTextNode(cssText));
	    } catch (e) {
	        style.styleSheet.cssText = cssText; //ie9以下
	    }
        var head=document.getElementsByTagName("head")[0]; //head标签之间加上style样式
        head.appendChild(style); 
	}
	
	
