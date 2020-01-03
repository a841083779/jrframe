<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* */2 * * *">
<%
	String id = CommonString.getFormatPara(request.getParameter("id"));
	String name = CommonString.getFormatPara(request.getParameter("name"));
	String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
	String catalogname = CommonString.getFormatPara(request.getParameter("catalogname"));
	String sql = " select top 5 id,username,content,add_date from pro_comments where product_id = "+id+" and is_show=1 order by add_date desc,id desc ";	
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
		 <%	if(list != null && list.size() > 0){
				for(Map m : list){
		%>
	 <li> <strong class="l"><%=CommonString.getFormatPara(m.get("username")).equals("")?CommonString.getFormatPara(m.get("n")):CommonString.getFormatPara(m.get("username")) %> 对 <%=factoryname%><%=name%><%=catalogname%> 的评论：</strong> <span class="r"><%=CommonString.getFormatPara(m.get("add_date")).length() >= 16?CommonString.getFormatPara(m.get("add_date")).substring(0,16):CommonString.getFormatPara(m.get("add_date"))%></span>
       <div class="clc"> <%=CommonString.getFormatPara(m.get("content"))%> </div>
    </li>				
        <%}}else{%>
		<div align="center"><strong>暂无评论</strong></div>
		<%}%>

  </cache:cache>