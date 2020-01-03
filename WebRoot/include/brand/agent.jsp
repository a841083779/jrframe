<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	String factoryname = "".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid)) ;	
	String cacheKey = "agent_"+factoryid;
%>
<cache:cache cron="* * */1 * *" key="<%=cacheKey%>">
<%
	// 代理商查询
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> agentsList= null ;
	agentsList = dbHelper.getMapList(" select top 10 usern,full_name,city,telphone,agent_fac_name from pro_agent_factory where flag = 2 and is_show=1 and agent_fac like '%"+factoryid+"%'") ;
%>
<!--代理商列表-->
<div class="agentListContain">
  <div class="title12">
    <h3><%=factoryname %>代理商查询</h3>
    <span><a target="_blank" href="/agent/list.jsp?factory=<%=factoryid %>">更多&gt;&gt;</a></span> </div>
  <ul class="ti">
    <li class="a1">代理地区</li>
    <li class="a2">代理商名称</li>
    <li class="a4">代理品牌</li>
    <li class="a5">查看</li>
  </ul>
  <div class="li">
    <%
        	if(null != agentsList && agentsList.size()>0){
        		int i = 1 ;
        		for(Map oneMap:agentsList){
        			%>
    <ul <%=i%2==0?"class='abg02'":"" %>>
      <li class="a1"><%=CommonString.getFormatPara(oneMap.get("city")) %></li>
      <li class="a2"><a href="/agent/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name")) %></a></li>
      <li class="a4"><a href="javascript:;"><%=factoryname %></a></li>
      <li class="a5"><a href="/agent/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" title="查看" target="_blank"><img src="/images/check.gif" width="40" height="17" /></a></li>
    </ul>
    <%
        			i++ ;
        		}
        	}else{
        %>
        <span class="textStyle">暂无代理商</span>
        <%
			}
		%>
  </div>
</div>
<!--代理商列表结束-->
</cache:cache>