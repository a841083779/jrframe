<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,java.sql.Connection,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String sql = "";
	List<Map> list=null;
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));

	try{
		connection = dbHelper.getConnection();
		 	sql= " select  name,num from pro_catalog where parentid!=0 and is_show=1  and  num in (select  catalognum from pro_products where len(catalognum)>3 and factoryid="+factoryid+" and is_show=1  GROUP BY catalognum )";
			    list = dbHelper.getMapList(sql);
				for(Map m : list){
				%><option value="<%=m.get("num") %>"><%=m.get("name") %></option><%
		  			
		  		}
		  		
	         
				
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>