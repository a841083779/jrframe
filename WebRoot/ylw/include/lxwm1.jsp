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

<%
 		DBHelper dbHelper = DBHelper.getInstance();

		List<Map> catalogList = dbHelper.getMapList("select catalog_name,summary from web_infomation where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='contactus00'") ;
			if(null !=catalogList && catalogList.size()>0){
				for(Map oneMap:catalogList){
%>
<table border="0" cellpadding="0" cellspacing="0" width="220" height="200" style="margin:10px 0;">
	<tr>
	  <td class="ziti01" background="images/img01.gif" height="26" width="215" style="padding-left:10px;">
	  <a class="n2" href="contact/"><%=CommonString.getFormatPara(oneMap.get("catalog_name"))%></a>
	  </td>
	</tr>
	<tr>
	  <td background="images/lxwmbj.gif" width="215" height="170" valign="top" style="padding-top:15px; padding-left:10px" class="n5">
		<%=CommonString.getFormatPara(oneMap.get("summary"))%></td>
	</tr>
</table>
<%	}}
 
%>