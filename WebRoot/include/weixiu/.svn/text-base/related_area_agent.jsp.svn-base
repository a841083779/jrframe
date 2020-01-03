<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String province = CommonString.getFormatPara(request.getParameter("province"));
		String city = CommonString.getFormatPara(request.getParameter("city"));
		String areaName = CommonString.getFormatPara(request.getParameter("areaName"));
	    String sql = "select name,num from pro_catalog where len(num)=6";
%>
<cache:cache cron="* * */14 * *">
<%
       List<Map> list = dbHelper.getMapList(sql,connection);
	  	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
	  			String catalognum =CommonString.getFormatPara(list.get(i).get("num"));
				String catalogName=CommonString.getFormatPara(list.get(i).get("name"));
	  %><li style="height:18px"><a title="<%=areaName+catalogName%>维修网点" href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-0-<%=catalognum%>.htm"><%=catalogName%></a></li>
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