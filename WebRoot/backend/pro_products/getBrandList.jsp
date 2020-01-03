<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%

	List <Map> brandList = (ArrayList)application.getAttribute("brandList");
	
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	try{
		connection = dbHelper.getConnection();
		brandList =  dbHelper.getMapList(" select id,name,upper_index from pro_agent_factory where is_show=1 and flag=1 order by upper_index",connection) ;
		}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}

	if(brandList != null){
		for(Map m : brandList){
			//out.println("<option value=\""+m.get("name")+"\" >"+m.get("upper_index")+"_"+m.get("name")+"</option>");
			out.println(m.get("upper_index")+"_"+m.get("name"));
		}
	}
			
			
%>

		  			