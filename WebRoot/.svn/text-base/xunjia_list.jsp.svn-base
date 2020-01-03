<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="utf-8"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String catanum = CommonString.getFormatPara(request.getParameter("catanum"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	String product_name = CommonString.getFormatPara(request.getParameter("product_name"));
   
	String sql = "select top 15 province,city,name,add_date,message  from pro_product_form where factoryid='"+factoryid+"' and catanum='"+catanum+"' and product_name like '%"+product_name+"%' order by add_date desc";
%>
	<cache:cache  cron="*/1 * * * *">
        <%
        List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
			if(list != null && list.size() > 0){
				for(Map m : list){
		%>
	<li style="border-bottom: #f1f1f1 1px solid;"><span style="color:#d6d6d6">
	<%=CommonString.getFormatPara(m.get("province"))%><%=CommonString.getFormatPara(m.get("city"))%>的&nbsp;&nbsp;<%=CommonString.getFormatPara(m.get("name")).substring(0,1)%>**&nbsp;&nbsp;询:&nbsp;&nbsp;&nbsp;</span><br>
	<%=CommonString.getFormatPara(m.get("message")) %></li>  
        <%}}else{%>
		暂无相关评论！
		<%}%>
  </cache:cache>
 
 
 