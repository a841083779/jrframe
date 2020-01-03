<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%><%
Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	StringBuffer sql = new StringBuffer();
	List values = new ArrayList(0);
	String oneuuid = "" ;
	String tel=CommonString.getFormatPara(request.getParameter("zd_mobile_phone"));
	Boolean regTel=tel.matches("^(13|15|18)\\d{9}$");  
	if(!regTel){
			out.print("error");
			return;
		}
	try{
		connection=dbHelper.getConnection();
		Enumeration params = request.getParameterNames();
		StringBuffer sqlback = new StringBuffer("(");
		StringBuffer sqlques = new StringBuffer("(");
		String name = "";
		String value = "";
		while (params.hasMoreElements()) {
			name = (String) params.nextElement();
			if (name.startsWith("zd_") && !name.endsWith("_txt_val")) {
				value = request.getParameter(name);
				sqlback.append(name.substring(name.indexOf("zd_") + 3));
				sqlback.append(",");
				sqlques.append("?,");
				if (null == value) {
					value = "";
				}
				values.add(value);
			}
		}
		oneuuid = CommonString.getUUID() ;
		values.add(oneuuid);
		values.add("ymt_sy");
		values.add(CommonDate.getToday("yyyy-MM-dd HH:mm:ss"));
		values.add(Common.getIp(request));
		sqlback.setLength(sqlback.length() - 1);
		sqlback.append(",uuid");
		sqlback.append(",add_user");
		sqlback.append(",add_date");
		sqlback.append(",add_ip");
		sqlback.append(")");
		sqlques.setLength(sqlques.length() - 1);
		sqlques.append(",?");
		sqlques.append(",?");
		sqlques.append(",?");
		sqlques.append(",?");
		sqlques.append(")");
		sql.setLength(0);
		sql.append(" insert into pro_product_form " + sqlback.toString()+ " values " + sqlques.toString());
		//System.out.println(sql.toString());
		Integer keyId = dbHelper.executeUpdate(sql.toString(), values.toArray(),connection) ; // 
		out.print("success");
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>