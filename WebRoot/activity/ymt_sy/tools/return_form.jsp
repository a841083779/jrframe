<%@ page contentType="text/xml; charset=utf-8" %>
<%@page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%

	response.setHeader("Cache-Control","no-cache");
	out.println("<root>"); 
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String sql = "";
	try{
		connection = dbHelper.getConnection();
	    String id = CommonString.getFormatPara(request.getParameter("id"));
		if(!id.equals("")&&id!=null){
				Map model=dbHelper.getMap(" select * from pro_products where id =? ",new Object[]{id},connection);
				if(model!=null){
					out.println("<factoryid>"+   CommonString.getFormatPara(model.get("factoryid"))   +"</factoryid>");
					out.println("<factoryname>"+   CommonString.getFormatPara(model.get("factoryname"))   +"</factoryname>");
					out.println("<product_name>"+   CommonString.getFormatPara(model.get("name"))   +"</product_name>");
					out.println("<cataname>"+   CommonString.getFormatPara(model.get("catalogname"))   +"</cataname>");
					out.println("<catanum>"+   CommonString.getFormatPara(model.get("catalognum"))   +"</catanum>");
				}
				out.println("<product_id>"+   id   +"</product_id>");
				
		}

	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.println("</root>");
%>