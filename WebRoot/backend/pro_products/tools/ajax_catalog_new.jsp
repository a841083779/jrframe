<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
		Connection connection = null;
	    DBHelper dbHelper = DBHelper.getInstance();
		String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
	  System.out.println(catalognum);
		try {
				Map model =null;
		        connection = dbHelper.getConnection();
				model = dbHelper.getMap(" select catalog_num from pro_catalog where num="+catalognum,connection);
			   String catalog_num=CommonString.getFormatPara(model.get("catalog_num"));
				
                out.print(catalog_num);

	}catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>