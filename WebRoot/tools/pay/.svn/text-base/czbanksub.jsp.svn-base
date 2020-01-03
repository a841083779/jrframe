<%@page import="com.czbank.netpay.api.APIConstance"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.czbank.netpay.api.KeyStoreUtil"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@ page language="java" import="com.jerehnet.alipay.config.*,com.jerehnet.alipay.util.*,com.jerehnet.manage.*,java.util.*,com.jerehnet.util.dbutil.DBHelper,java.sql.Connection,com.jerehnet.util.common.CommonString" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>购销通接口-跳转</title>
	</head>
	<%
		////////////////////////////////////请求参数//////////////////////////////////////
		String domain = request.getScheme() + "://" + request.getServerName();
		domain += request.getServerPort() != 80 ? ":" + request.getServerPort() : "";
		
		String interfaceName="CZB_B2B_GET_ORDER_TOKEN";         //接口名称
		String interfaceVersion="1_0";							//接口编号
		String token = (String)request.getAttribute("token");	//令牌
		String tokenstr = "CZB_B2B_ORDER_COMMIT"+"1_0"+token;
		String signMsgData = KeyStoreUtil.signData(tokenstr);	//商户签名
		String serverAPIurl = APIConstance.serverAPIURL;
				
		////////////////////////////////////组装表单////////////////////////////////////////
		
        StringBuffer sbHtml = new StringBuffer();

        sbHtml.append("<form id=\"czbanksubmit\" name=\"czbanksubmit\" action=\""+  serverAPIurl +"\" style=\"display:none;\" method=\"post\">");
		//
        sbHtml.append("<input type=\"text\" name=\"interfaceName\" value=\""+ URLEncoder.encode("CZB_B2B_ORDER_COMMIT","gbk") +"\" />");
        sbHtml.append("<input type=\"text\" name=\"interfaceVersion\" value=\""+ URLEncoder.encode("1_0","gbk") +"\" />");
        sbHtml.append("<input type=\"text\" name=\"signMsg\" value=\""+ URLEncoder.encode(signMsgData,"gbk") +"\" />");
        sbHtml.append("<input type=\"text\" name=\"accessToken\" value=\""+ URLEncoder.encode(token,"gbk") +"\" />");
        //
        sbHtml.append("<input type=\"submit\" value=\"确认\" style=\"display:none;\"></form>");
        sbHtml.append("<script>document.forms['czbanksubmit'].submit();</script>");
        
		String sHtmlText = sbHtml.toString();
		out.println(sHtmlText);
	%>
	<body>
	</body>
</html>