<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */3 * *">
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> proList= null ;
	String catalogname = CommonString.getFormatPara(request.getParameter("catalogname")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
	proList = dbHelper.getMapList("select top 12   id,name,usern from pro_agent_factory where is_show=1 and flag=1 and id in (select distinct factoryid from pro_products where catalognum like '"+catalognum+"%' ) order by view_count desc") ;
%>
    <%
        if(null != proList && proList.size()>0){
	%>
        <div class="comBox01 mb10">
        	<div class="hd fix">
              <h3><%=catalogname %>热门品牌</h3>
            </div>
            <div class="bd fix">
            	<ul class="fix pc_hotbrand">
	<%      
	        int i=1;
        	for(Map oneMap:proList){
    %>
         <li><a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("name"))%></a></li>
      <%i++;}%>
                </ul>
            </div>
        </div>
	<%}%>
</cache:cache>




