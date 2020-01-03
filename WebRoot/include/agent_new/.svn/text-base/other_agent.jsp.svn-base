<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */1 * *">
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> agentsList= null ;
	String whereStr="";
	String area = CommonString.getFormatPara(request.getParameter("area"));
	String agent_fac = CommonString.getFormatPara(request.getParameter("agent_fac"));
	if(!area.equals("")){whereStr=" and city like '%"+area+"%'";}
	if(!agent_fac.equals("")){whereStr=" and city like '%"+area+"%'";}
	agentsList = dbHelper.getMapList(" select top 6 usern,is_qijiandian,is_made,full_name from pro_agent_factory where flag = 2 and is_show=1 "+whereStr+" order by view_count desc") ;
%>
    <%
        if(null != agentsList && agentsList.size()>0){
        	for(Map oneMap:agentsList){
    %>
	    <%if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
		<li><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://product.21-sun.com/agentstore/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://<%=CommonString.getFormatPara(oneMap.get("usern"))%>.product.21-sun.com" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>       
        <%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://product.21-sun.com/agentshop02/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>       
        <%}else{%>
        <li><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}%>
    <%}}%>
</cache:cache>