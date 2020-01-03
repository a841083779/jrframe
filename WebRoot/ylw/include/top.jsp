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
Connection connection = null;
   	DBHelper dbHelper = DBHelper.getInstance();
	String sql="";
	ResultSet rs ;
	String logo="";
	try{
		sql="select logo from web_columns where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='index00'";
		Map m = dbHelper.getMap(sql);
		if(m!=null){
			logo=CommonString.getFormatPara("logo");
		}else{
			logo="";
		}
%>
<script type="text/javascript" src="../scripts/js.js"></script>
<table border="0" cellpadding="0" cellspacing="0" width="950" height="120" align="center">
	<tr>
		<td valign="top">
<table border="0" cellpadding="0" cellspacing="0" width="950" height="75" align="center">
	<tr>
		<td style="padding:10px 0 10px 20px;"><a href="<%=web_site %>" title="<%=web_name %>"><img border="0" src="<%=logo%>" alt="<%=web_name %>"/></a></td>
		<td width="715"  >
		 <table  border="0" cellpadding="0" cellspacing="0" width="100%" style="padding-top:30px;padding-right:25px;">
			<tr>
				<td align="right" ><a class="n1" target=_top href="#" onclick="favorite()">加入收藏</a> 
				<font color="#000000">|</font> <a class="n1" onclick="setHome(this)" href="#">设为首页</a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width="950" height="35" align="center" class="nymenu">
	<tr>
		<td width="49"></td>
		<td width="142" align="center"><a href="../">首页</a></td>
		<td width="142" align="center"><a href="../about/">公司简介</a></td>
		<td width="142" align="center">
		<a href="../products/">产品展示</a></td>
		<td width="142" align="center">
		<a  href="../parts/">配件仓库</a></td>
		<td width="142" align="center"><a  href="../order/">在线订购</a></td>
		<td width="143" align="center">
		<a href="../contact/">联系我们</a></td>
		<td width="48"></td>
	</tr>
</table>
		</td>
	</tr>
</table>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
	finally{
		DBHelper.freeConnection(connection);
	}	
%>
