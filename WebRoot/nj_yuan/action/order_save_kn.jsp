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
	Map userInfo = (Map)session.getAttribute("userInfo");
	try{
		connection = dbHelper.getConnection();
  

	
			String uname = CommonString.getFormatPara(request.getParameter("username"));
			String phone = CommonString.getFormatPara(request.getParameter("telephone"));
			String pro = CommonString.getFormatPara(request.getParameter("pro"));
			String proname="";
			if(pro.equals("1")){
				proname="安徽合矿HK18小挖";
			}else if(pro.equals("2")){
			    proname="晋工JGM737-II装载机";
			}else if(pro.equals("3")){
				proname="军恒S360破碎锤";
			}
	        dbHelper.execute("insert into pro_kn_order (add_date,phone,uname,pro,ref  ) values ('"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+phone+"','"+uname+"','"+proname+"',1) ");
            out.println("success"); 

	
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>