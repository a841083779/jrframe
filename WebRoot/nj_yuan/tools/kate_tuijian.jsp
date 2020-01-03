<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="utf-8"%>

<%
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
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
	String factory_num = CommonString.getFormatPara(request.getParameter("factory_num"));
	String catalog_num = CommonString.getFormatPara(request.getParameter("catalog_num"));
	String pro_id = CommonString.getFormatPara(request.getParameter("pro_id"));
	String uuid=UUID.randomUUID().toString();
	String time=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
	
	String insert_sql="insert into pro_cate_tui(add_date,add_ip,catalog_num,factory_num,pro_id,uuid,add_user) values(?,?,?,?,?,?,?)";
	dbHelper.execute(insert_sql,new Object [] {time,ip,catalog_num,factory_num,pro_id,uuid,"游客"},connection);
	out.print("ok");
		}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
