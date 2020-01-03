<%@ page language="java"
	import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.webservice.WEBEmail,com.jerehnet.util.common.*,com.jerehnet.util.pay.*"
	pageEncoding="UTF-8"%>
<%
	
	String a="";
	String flag=CommonString.getFormatPara(request.getParameter("flag"));
	WXPayCommon wx = new WXPayCommon();
	try {
		
		//验证码
		if("test".equals(flag)){
			a = wx.weixinPay(request);
			System.out.println("result:"+a);
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {

	}
%>