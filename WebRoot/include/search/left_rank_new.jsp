﻿<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%   
    int i=0;
	String id = CommonString.getFormatPara(request.getParameter("id"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String catalogName = CommonString.getFormatPara(request.getParameter("catalogName"));
    String keyword = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String sql = "SELECT top 15 name,id FROM pro_agent_factory AS a INNER JOIN (SELECT factoryid,SUM(view_count) as counts FROM pro_products WHERE catalognum LIKE '"+catalog+"%'  GROUP BY factoryid) AS b ON a.id=b.factoryid ORDER BY b.counts desc";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
	<cache:cache  cron="* * */7 * *">
        <%
		    String tid="";
			String factorynames="";
			if(list != null && list.size() > 0){
				for(Map m : list){
				tid=CommonString.getFormatPara(m.get("id"));
				factorynames=CommonString.getFormatPara(m.get("name"));
				if(tid.equals("174")&&!catalog.equals("")){factorynames="卡特";}
		%>
		<li <%if(i<=2){%> class="top3"<%}%>>
      <em style="width:18px"><%=i+1%></em><h4><a title='<%=factorynames%><%=catalogName%>' href="/<%=keyword%>_0_0_<%=CommonString.getFormatPara(m.get("id"))%>_0_0.htm">
	  <%=factorynames%><%=catalogName%>
	  </a></h4></li>
        <%i++;}}%>
  </cache:cache>