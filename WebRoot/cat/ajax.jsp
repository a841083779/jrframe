<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.alipay.util.*"%>

<%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String rs = "fail";
	String callback = CommonString.getFilterStr(request.getParameter("callback"));
	try{
		connection = dbHelper.getConnection(); 	






		if("visitHistory".equals(flag)){
			String visit_url=request.getHeader("Referer"); 
			String IP = request.getHeader("Cdn-Src-Ip");
            if(IP.equals("")){  IP=Common.getIp(request,1);}
			String from_url = CommonString.getFormatPara(request.getParameter("ref"));
			String ins_sql = "insert into pro_cat_ad(add_date,add_ip,visit_url,from_url) values(?,?,?,?)" ;
			if(!IP.equals("119.180.98.134")){
			dbHelper.execute(ins_sql,new Object[]{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),IP,visit_url,from_url},connection) ;
			}
		
		}
	
		

		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>