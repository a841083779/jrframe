﻿<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
		String factoryName = CommonString.getFormatPara(request.getParameter("factoryName"));
	    String sql = " select substring(catalognum,1,6) as catalognum from pro_products where factoryid = '"+factoryid+"' and catalognum is not null and catalognum !='' group by substring(catalognum,1,6) order by catalognum asc ";
        Map catalogMap = (Map) application.getAttribute("catalogMap");
%>
<cache:cache cron="* * */14 * *">
<%
       List<Map> list = dbHelper.getMapList(sql,connection);
	  	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
	  			String catalognum =CommonString.getFormatPara(list.get(i).get("catalognum"));
				String catalogName=CommonString.getFormatPara(catalogMap.get(catalognum));
	  %><li style="height:18px"><a title="<%=factoryName+catalogName%>维修网点" href="/0-0-<%=factoryid%>-<%=catalognum%>.htm"><%=factoryName+catalogName%></a></li>
      <%
			}
		}
	  %> 
</cache:cache>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>