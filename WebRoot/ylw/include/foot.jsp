<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%
String web_no ="20056"; 
String web_name ="优立维国际机械有限公司";
 String web_name2 ="Copyright Uniwell International Machinery Co.,Limited. All Rights Reserved.";
 String web_count ="http://www.21-sun.com/count/counter.asp?uid=youliwei&amp;style=7";
 String web_site ="http://www.uniwellmachine.com";
 String language_version ="1";
%>
<table border="0" cellpadding="0" cellspacing="0" width="950" height="60" align="center">
	<tr >
		<td style="padding-top:10px;padding-bottom:10px; padding-left:25px">
		<%if(web_site!=null&&!web_site.equals("")){%><a class="n6" href="<%=web_site%>"><%=web_name%></a><%}else{%><%=web_name%><%}%> | 版权所有
<br>
		<%=web_name2 %></td>
		<td align="right" valign="bottom" style="padding-top:10px;padding-bottom:10px; padding-right:25px"><a href="http://www.21-sun.com" target="_blank" class="n6">中国工程机械商贸网</a> | 制作维护&nbsp;</td>
	</tr>
</table>