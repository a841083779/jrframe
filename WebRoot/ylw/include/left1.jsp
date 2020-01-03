<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%
   	DBHelper dbHelper = DBHelper.getInstance();

String web_no ="20056"; 
String web_name ="优立维国际机械有限公司";
 String web_name2 ="Copyright Uniwell International Machinery Co.,Limited. All Rights Reserved.";
 String web_count ="http://www.21-sun.com/count/counter.asp?uid=youliwei&amp;style=7";
 String web_site ="http://www.uniwellmachine.com";
 String language_version ="1";
%>
<%
		List<Map> list1 = dbHelper.getMapList("select id,sort_no,sort_name from web_category where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='products01'  and is_show=1  order by order_no") ;

%>
<table border="0" cellpadding="0" cellspacing="0" width="220">
      <tr>
        <td class="ziti01" background="images/img01.gif" width="215" height="26" style=" padding-left:10px;"><a class="n2" href="products/">产品分类</a></td>
      </tr>
    </table>
    <table width="220" cellspacing="0" cellpadding="0" class="leftm">
       <%
  			if(null !=list1 && list1.size()>0){
				for(Map oneMap:list1){
	  %>
      <tr>
        <td><a href="../products/?sortNo=123"><%=CommonString.getFormatPara(oneMap.get("sort_name"))%></a> </td>
      </tr>
			<%}}%>
      </table>
<%
 		List<Map> list2 = dbHelper.getMapList("select visualize_pic_small,pic_small_link from web_columns where web_no='"+web_no+"' and language_version='"+language_version+"' and catalog_no='index00'") ;
	 
 	 	if(null !=list2 && list2.size()>0){
				for(Map oneMap:list2){
	  	String visualize_pic_small=CommonString.getFormatPara(oneMap.get("visualize_pic_small"));
	  	String pic_small_link=CommonString.getFormatPara(oneMap.get("pic_small_link"));
	  	if(visualize_pic_small!=null&&!visualize_pic_small.equals("")){
	  %>
      <table border="0" cellpadding="0" cellspacing="0" style="margin-bottom:15px; margin-top:15px;">
        <tr>
          <td><%if(pic_small_link!=null&&!pic_small_link.equals("")){ %><a href="../order/"><%} %> 
          </a><a href="order/"> 
          <img border="0" src="<%=visualize_pic_small %>" width="215" height="71"/></a><a href="order/"><%if(pic_small_link!=null&&!pic_small_link.equals("")){ %></a><%} %></td>
        </tr>
      </table>
		<%}}} %>
 