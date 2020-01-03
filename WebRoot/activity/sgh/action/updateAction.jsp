<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.*" %>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();

	String formId=CommonString.getFormatPara(request.getParameter("formId"));
	String rate=CommonString.getFormatPara(request.getParameter("rate"));

	try{
		connection=dbHelper.getConnection();
		if("".equals(formId)||formId==null){
			out.print("error");
			return;
		}
		String sql=" update shangong_activity_form set correct_rate ='"+rate+"' where id= "+formId;
		Integer keyId = dbHelper.executeUpdate(sql, new Object[]{},connection) ;
		if(keyId>0){
			out.print("success");
		}else{
			out.print("error");
		}
	}catch(Exception e){
		e.printStackTrace();
		out.print("error");
	}finally{
		dbHelper.freeConnection(connection);
	}
%>