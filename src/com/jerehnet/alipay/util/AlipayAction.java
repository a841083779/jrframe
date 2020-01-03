package com.jerehnet.alipay.util;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradeAppPayModel;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.alipay.api.response.AlipayTradeAppPayResponse;
import com.jerehnet.alipay.config.*;
public class AlipayAction {
	public String doAlipay(){
		String result="";
	    //AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do", AlipayConfig.appId, AlipayConfig.privateKey, "json", AlipayConfig.input_charset, AlipayConfig.publicKey, "RSA2");
	    AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do", "", "", "json", "", "", "RSA2");

		//SDK已经封装掉了公共参数，这里只需要传入业务参数。以下方法为sdk的model入参方式(model和biz_content同时存在的情况下取biz_content)。
	    AlipayTradeAppPayModel model = new AlipayTradeAppPayModel();
	    //实例化具体API对应的request类,类名称和接口名称对应,当前调用接口名称：alipay.trade.app.pay
	    AlipayTradeAppPayRequest request = new AlipayTradeAppPayRequest();
	    model.setBody("商贸网会员业务");
	    model.setSubject("商贸网会员业务");
	    model.setOutTradeNo("20180223002");
	    model.setTimeoutExpress("30m");
	    model.setTotalAmount("0.01");
	    model.setProductCode("QUICK_MSECURITY_PAY");
	    request.setBizModel(model);
	    request.setNotifyUrl("");
	    //request.setNotifyUrl(AlipayConfig.app_notify_url);

	 // 设置同步地址
	    //request.setReturnUrl(AlipayConfig.app_return_url); 
	    request.setReturnUrl("");   

	    try {
	        //这里和普通的接口调用不同，使用的是sdkExecute
	        AlipayTradeAppPayResponse response = alipayClient.sdkExecute(request);
	        result=response.getBody();
	        System.out.println("这是结果:============="+response.getBody());//就是orderString 可以直接给客户端请求，无需再做处理。
	    } catch (AlipayApiException e) {
	        e.printStackTrace();
	    }
	    return  result;
	}
}
