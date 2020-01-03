<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	if(catalog.length()>=3){
		catalog = catalog.substring(0,3);
	}
%>
<cache:cache cron="* * */1 * *">
<%
List<Map> allcatalogsList = dbHelper.getMapList("select name,num from pro_catalog where num like '"+catalog+"%' and LEN(num)=6");
	if(allcatalogsList!=null && allcatalogsList.size()>0){
		for(Map cata:allcatalogsList){
			String name = CommonString.getFormatPara(cata.get("name"));
			String num = CommonString.getFormatPara(cata.get("num"));
%>
	<li><a href="/plist-<%=num %>-0-0.htm" target="_blank" title="<%=name %>"><%=name %></a></li>
<%}
		} %>
</cache:cache>