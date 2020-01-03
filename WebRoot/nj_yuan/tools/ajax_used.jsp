<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,java.sql.Connection,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String sql = "";
	String ip  = request.getHeader("x-forwarded-for");
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("X-Real-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("WL-Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getRemoteAddr();
	}
	try{
		connection = dbHelper.getConnection();
		if("fromUsedForm".equals(flag)){
			String name = CommonString.getFormatPara(request.getParameter("name"));
			String mobile_phone = CommonString.getFormatPara(request.getParameter("mobile_phone"));
			String message = CommonString.getFormatPara(request.getParameter("message"));

			sql = " insert into pro_product_used_form ( add_date,add_ip,uuid,name,mobile_phone,message,factoryid) ";
			sql += " values ( ? , ? ,? , ? , ? , ? , ?  ) ";
			//插入询价记录
			dbHelper.execute(sql,new Object [] {
				CommonDate.getToday("yyyy-MM-dd"),
				ip,
				UUID.randomUUID().toString(),
				name,
				mobile_phone,
				message,
				0      
			},connection);
	
		}	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>