<%@ page language="java"
	import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
		Connection connection = null;
	    DBHelper dbHelper = DBHelper.getInstance();
		String place = CommonString.getFormatPara(request.getParameter("place"));
		try {
				Map model = new HashMap();
		        connection = dbHelper.getConnection();
				model = dbHelper.getMap(" select * from pro_agent_factory where name= ?  and is_cooperate=1",new Object [] {place} , connection);
			%>
			 <input type="text" class="jr_text" name="zd_agent_area" id="zd_agent_area" value="<%=CommonString.getFormatPara(model.get("city"))%>" style="width:130px" />
			<%
				
				
            
				
				
				


	}catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>