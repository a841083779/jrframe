<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="*/1 * * * *">
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> agentsList= null ;
	String agentid = CommonString.getFormatPara(request.getParameter("agentid"));
	agentsList = dbHelper.getMapList(" select username,content,add_date,province,city from pro_agent_online_message where agentid="+agentid+" order by id desc") ;
%>
    <%
        if(null != agentsList && agentsList.size()>0){
        	for(Map oneMap:agentsList){
    %>
	
	
	 <li>
                <div class="s1">来自<span class="area"><%=CommonString.getFormatPara(oneMap.get("province"))%><%=CommonString.getFormatPara(oneMap.get("city"))%></span>的铁臂商城用户的询问 (<%=CommonDate.getFormatDate("yyyy-MM-dd",CommonString.getFormatPara(oneMap.get("add_date")))%>)</div>
                <div class="s2"><strong><%=CommonString.getFormatPara(oneMap.get("username"))%>：</strong><%=CommonString.getFormatPara(oneMap.get("content"))%></div>
     </li>
	

    <%}}%>
</cache:cache>