<%@ page language="java"
	import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*"
	pageEncoding="UTF-8"%>
<%
		Connection connection = null;
	    DBHelper dbHelper = DBHelper.getInstance();
		String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
        String factoryid = CommonString.getFormatPara(request.getParameter("fa_id"));
	  
		 System.out.println(factoryname);
		  System.out.println(factoryid);
		try {
				List<Map> model =null;
		        connection = dbHelper.getConnection();
				if(!factoryname.equals("")&&!factoryid.equals("")){
				model = dbHelper.getMapList(" select * from pro_products where factoryid =? and catalognum=?",new Object [] {factoryname,factoryid},connection);
				}else if(factoryname.equals("")&&!factoryid.equals("")){
				model = dbHelper.getMapList(" select * from pro_products where catalognum =?",new Object [] {factoryid},connection);
				}else if(!factoryname.equals("")&&factoryid.equals("")){
				model = dbHelper.getMapList(" select * from pro_products where factoryid =?",new Object [] {factoryname},connection);
				}
			%>
			<option value="">--请选择产品型号--</option>
			<%
			for(int i=0;i<model.size();i++){
			%>
			 <option value="<%=CommonString.getFormatPara(model.get(i).get("name")) %>"><%=CommonString.getFormatPara(model.get(i).get("name")) %></option>
			<%
				}
				
            
				
				
				


	}catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>