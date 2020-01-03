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
		
		if("get_city_new".equals(flag)){
			String p = CommonString.getFormatPara(request.getParameter("p"));
			if("105499".equals(p)){ // 北京
				//p = "105500" ;
			}
			if("105290".equals(p)){ // 北京 
				//p = "105300" ;
			}
			if("105879".equals(p)){ // 重庆  
				//p = "105880" ;
			}
			if("105689".equals(p)){ // 天津   
				//p = "105690" ;
			}
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {p},connection);
			StringBuffer html = new StringBuffer();
		   for(Map m : areas){
				    html.append("<span data-city='"+CommonString.getFormatPara(m.get("area_name"))+"'><a href='javascript:void(0);'>"+CommonString.getFormatPara(m.get("area_name"))+"</a></span>");
			}
			out.print(html.toString());
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>