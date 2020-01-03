<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */3 * *">
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> agentList= null ;
	String catalogname = CommonString.getFormatPara(request.getParameter("catalogname")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
    String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	agentList = dbHelper.getMapList("select top 8 id,name,full_name,is_qijiandian,is_made,usern from pro_agent_factory where flag = 2 and is_show = 1  and id in ( select distinct agent_id from pro_agent_products where catalognum like '"+catalognum+"%')  order by is_cooperate desc ,id desc ") ;
%>
    <%
        if(null != agentList && agentList.size()>0){
		String url="";
	%>
        <div class="comBox01 mb10">
        	<div class="hd fix">
              <h3><%=catalogname%>代理商</h3>
              <a href="http://product.21-sun.com/agent/0_0_0_<%=catalognum%>.shtm" class="pc_more" title="更多<%=catalogname%>代理商">更多</a>
            </div>
            <div class="bd fix">
            	<ul class="fix pc_dlslist">
	<% for(Map oneMap:agentList){ 
					if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){
					   url="http://product.21-sun.com/agentstore/"+CommonString.getFormatPara(oneMap.get("usern"))+"/";
					}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){
					   url="http://"+CommonString.getFormatPara(oneMap.get("usern"))+".product.21-sun.com";
					}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){
					   url="http://product.21-sun.com/agentshop02/"+CommonString.getFormatPara(oneMap.get("usern"))+"/";
					}else{
					   url="http://dealer.21-sun.com/"+CommonString.getFormatPara(oneMap.get("usern"))+"/";
					}
	%>
		 <li><a target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("full_name")) %>" href="<%=url%>"><%=CommonString.getFormatPara(oneMap.get("full_name")) %></a></li>

      <%}%>
                </ul>
            </div>
        </div>
	<%}%>
</cache:cache>




