<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */1 * *">
<%
	// 代理商查询
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> agentsList= null ;
	agentsList = dbHelper.getMapList(" select top 7 title,id from pro_agent_news where is_approval=1 order by newid()") ;
%>
    <%
        if(null != agentsList && agentsList.size()>0){
        	for(Map oneMap:agentsList){
    %>
	         

        <li><a target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("title"))%>" href="/news_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm"><%=CommonString.getFormatPara(oneMap.get("title"))%></a></li>
    <%}}%>
<!--代理商列表结束-->
</cache:cache>