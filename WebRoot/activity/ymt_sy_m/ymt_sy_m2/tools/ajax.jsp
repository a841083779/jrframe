<%@page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String sql = "";
	String rs = "";
	try{
		connection = dbHelper.getConnection();
		
		if("returnFormValue".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			if(!id.equals("")&&id!=null){
				Map model=dbHelper.getMap(" select * from pro_products where id =? ",new Object[]{id},connection);
				if(model!=null){
					rs=CommonString.getFormatPara(model.get("count_num"));
				}
			}
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>