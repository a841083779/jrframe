<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="utf-8"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String id = CommonString.getFormatPara(request.getParameter("id"));
    if(id.equals("")){id="0";}
	String sql = "select add_date,content,username from pro_comments where product_id ="+id+" order by id desc";
%>
	<cache:cache  cron="* * */1 * *">
        <%
        List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
			if(list != null && list.size() > 0){
				for(Map m : list){
		%>
	<li style="border-bottom: #f1f1f1 1px solid;"><span style="color:#d6d6d6"><%=CommonString.getFormatPara(m.get("username")).equals("")?"游客":CommonString.getFormatPara(m.get("username")) %>&nbsp;&nbsp;&nbsp;<%=CommonDate.getFormatDate("yyyy-MM-dd",m.get("add_date"))%></span><br>
	<%=CommonString.getFormatPara(m.get("content")) %></li>  
        <%}}else{%>
		暂无相关评论！
		<%}%>
  </cache:cache>