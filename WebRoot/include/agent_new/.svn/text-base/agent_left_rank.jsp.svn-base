<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * * */1 *">
<%
	// 代理商查询
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> agentsList= null ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String whereStr="";
    if(!factory.equals("")&&!factory.equals("0")){whereStr+="and agent_fac like '%"+factory+"%'";}	
    if(!catalog.equals("")&&!catalog.equals("0")){whereStr+=("and id in ( select distinct agent_id from pro_agent_products where catalognum like '"+catalog+"%')");}

	agentsList = dbHelper.getMapList(" select top 15 usern,is_qijiandian,is_made,full_name from pro_agent_factory where flag = 2 and is_show=1 "+whereStr+"order by view_count desc") ;
%>
    <%  int i=1;
        if(null != agentsList && agentsList.size()>0){
        	for(Map oneMap:agentsList){
    %>
	    <%if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
		<li <%if(i<=3){%>class="top3"<%}%>><em><%=i%></em><h4><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://product.21-sun.com/agentstore/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></h4></li>
        <%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li <%if(i<=3){%>class="top3"<%}%>><em><%=i%></em><h4><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://<%=CommonString.getFormatPara(oneMap.get("usern"))%>.product.21-sun.com" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></h4></li>       
        <%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li <%if(i<=3){%>class="top3"<%}%>><em><%=i%></em><h4><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://product.21-sun.com/agentshop02/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></h4></li>       
        <%}else{%>
        <li <%if(i<=3){%>class="top3"<%}%>><em><%=i%></em><h4><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></h4></li>
        <%}%>
    <%i++;}}%>
<!--代理商列表结束-->
</cache:cache>