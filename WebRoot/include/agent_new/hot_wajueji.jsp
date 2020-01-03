<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */1 * *">
<%
	// 代理商查询
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> proList= null ;
	proList = dbHelper.getMapList(" select top 4 file_name,factoryname,name,catalogname,img2 from pro_products where catalognum like '101001%' and view_count>5000  order by newid()") ;
%>
    <%
        if(null != proList && proList.size()>0){
        	for(Map oneMap:proList){
    %>
	          <li><a target="_blank" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>"><img width="127" height="87" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>" ><strong><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalogname"))%></strong></a></li>
    <%}}%>
<!--代理商列表结束-->
</cache:cache>