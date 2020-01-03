<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
		String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));

%>
<cache:cache cron="* * */14 * *">
<%
       List<Map> list = dbHelper.getMapList("select id,name from pro_products where catalognum like '"+catalog+"%' and factoryid="+factoryid+" order by view_count desc");
	  	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
	  			String id =CommonString.getFormatPara(list.get(i).get("id"));
				String name =CommonString.getFormatPara(list.get(i).get("name"));
				
	  %>
                        <option value="<%=id%>"><%=name%></option>
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