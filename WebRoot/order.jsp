<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.czbank.netpay.api.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@page import="com.czbank.netpay.api.CzbankB2BBean"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="net.sf.json.JSONArray"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<style type="text/css">
<!--
body {
	font-size: 9pt;
	font-style: normal;
	line-height: 20px;
	font-weight: normal;
	font-variant: normal;
	color: #000099;
}
.smallfont {
	font-size: 9pt;
	font-weight: bold;
	color: #FF0000;
}
.bigFont {
	font-size: 16pt;
	font-style: normal;
	font-weight: bolder;
	font-variant: normal;
	color: #000000;
}
.text {
	font-size: 9pt;
	font-style: normal;
	line-height: normal;
	color: #000000;
	background-color: #6699FF;
	letter-spacing: normal;
	word-spacing: normal;
	width: auto;
	border: 1px dotted #CCCCCC;
}
.text1 {
	font-size: 14pt;
	font-weight: bold;
	color: #330099;
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 1px;
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: dotted;
	border-left-style: none;
	border-top-color: #FF0000;
	border-right-color: #FF0000;
	border-bottom-color: #FF0000;
	border-left-color: #FF0000;
}
-->
</style>
</head>
<% 

String interfaceName="CZB_B2B_GET_ORDER_TOKEN";
String interfaceVersion="1_0";
String token = (String)request.getAttribute("token");	
String tokenstr = "CZB_B2B_ORDER_COMMIT"+"1_0"+token;
String signMsgData = KeyStoreUtil.signData(tokenstr);
String serverAPIurl = APIConstance.serverAPIURL;
%>
<body bgcolor="#CCCCCC">
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
    <form action="<%=serverAPIurl %>" method="post">
        <table width="80%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
          <tr>
            <td bordercolor="#CCCCCC" bgcolor="#FFFFFF">
			<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr> 
                  <td width="40%" height="20" nowrap>接口名称【interfaceName】</td>
                  <td width="60%" height="20">
                  <input name="interfaceName" type="text" class="text1" id="interfaceName" value="<%=URLEncoder.encode("CZB_B2B_ORDER_COMMIT","gbk") %>">
                  </td>
                </tr>
                <tr> 
                  <td width="26%" height="20" nowrap>接口编号【interfaceVersion】</td>
                  <td width="74%" height="20">
                  <input name="interfaceVersion" type="text" class="text1" id="interfaceVersion" value="<%=URLEncoder.encode("1_0","gbk") %>">
                  </td>
                </tr>
               
                <tr> 
                  <td height="20">商户签名【signMsg】</td>
                  <td height="20"><input name="signMsg" type="text" class="text1" id="signMsg" value="<%=URLEncoder.encode(signMsgData,"gbk") %>"></td>
                </tr>
                
                  <tr> 
                <td height="20">令牌</td>
                  <td height="20">
                  <input name="accessToken" type="text" class="text1" id="accessToken" value="<%=URLEncoder.encode(token,"gbk") %>">
                  </td>
                </tr>                                           
                <tr> 
                  <td height="20" colspan="2"><div align="center"> 
                      <input type="submit" value="提交">
                    </div>
                    </td>
                </tr>
              </table>
			  </td>
          </tr>
        </table>
	    </form>
</td>
</tr>
</table>
</body>
</html>