<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="GBK"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
		if(catalog.length()>6){catalog=catalog.substring(0,6);}
		String catalogName = CommonString.getFormatPara(request.getParameter("catalogName"));
	    String sql = "select  id,name from pro_agent_factory where is_show=1 and flag=1 and id in (select distinct factoryid from pro_products where catalognum like '"+catalog+"%' ) order by view_count desc";
%>
<cache:cache cron="* * */5 * *">
<%
	List<Map> list = dbHelper.getMapList(sql,connection);
	  	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
	  			String id = CommonString.getFormatPara(list.get(i).get("id"));
	  			String factoryname = CommonString.getFormatPara(list.get(i).get("name"));
	  %>
       <li style="height:18px"><a title="<%=factoryname+catalogName%>ÔõÃ´Ñù" href="/<%=catalog%>-<%=id%>-0.htm"><%=factoryname%></a></li>

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