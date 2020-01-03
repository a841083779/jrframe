<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.*" %>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();

	String userName=CommonString.getFormatPara(request.getParameter("userName"));
	userName= URLDecoder.decode(userName,"UTF-8"); 
	String userPhone=CommonString.getFormatPara(request.getParameter("userPhone"));
	String userJob=CommonString.getFormatPara(request.getParameter("userJob"));
	userJob= URLDecoder.decode(userJob,"UTF-8"); 
	String usedEquip=CommonString.getFormatPara(request.getParameter("usedEquip"));
	usedEquip= URLDecoder.decode(usedEquip,"UTF-8"); 
	String ownEquip=CommonString.getFormatPara(request.getParameter("ownEquip"));
	ownEquip= URLDecoder.decode(ownEquip,"UTF-8"); 
	String jobTime=CommonString.getFormatPara(request.getParameter("jobTime"));
	jobTime= URLDecoder.decode(jobTime,"UTF-8"); 
	String userAdd=CommonString.getFormatPara(request.getParameter("userAdd"));
	userAdd= URLDecoder.decode(userAdd,"UTF-8"); 

	try{
		connection=dbHelper.getConnection();
		String insertSql=" insert into shangong_activity_form (add_user,add_date,add_ip,user_name,tel,profession,used_model,have_model,work_experience,province_id,pub_date  ) values"+
		" ('"+userName+"','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+Common.getIp(request)+"','"+userName+"','"+userPhone+"','"+userJob+"','"+usedEquip+"','"+ownEquip+"','"+jobTime+"','"+userAdd+"','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"') ";
		Integer keyId = dbHelper.executeUpdate(insertSql, new Object[]{},connection) ;
		if(keyId>0){
			out.print("success_"+keyId);
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