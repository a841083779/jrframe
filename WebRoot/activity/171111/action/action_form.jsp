<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLDecoder"%><%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String sql="";String rs="";
	String flag= CommonString.getFormatPara(request.getParameter("flag"));
	String callbackparam=CommonString.getFormatPara(request.getParameter("callbackparam"));
	
	
	try{
		connection=dbHelper.getConnection();
		if(flag.equals("submit")){
			String factoryid=CommonString.getFormatPara(request.getParameter("factoryid"));
			String factoryname=CommonString.getFormatPara(request.getParameter("factoryname"));
			String product_id=CommonString.getFormatPara(request.getParameter("product_id"));
			String product_name=CommonString.getFormatPara(request.getParameter("product_name"));
			String catanum=CommonString.getFormatPara(request.getParameter("catanum"));
			String cataname=CommonString.getFormatPara(request.getParameter("cataname"));
			String province=CommonString.getFormatPara(request.getParameter("province"));
			String city=CommonString.getFormatPara(request.getParameter("city"));
			String contact_address=CommonString.getFormatPara(request.getParameter("contact_address"));

			String name=CommonString.getFormatPara(request.getParameter("name"));
			String mobile_phone=CommonString.getFormatPara(request.getParameter("mobile_phone"));  
			
			String is_interested=CommonString.getFormatPara(request.getParameter("is_interested"));
			String add_user=CommonString.getFormatPara(request.getParameter("add_user"));
				
			sql=" insert into pro_product_form (uuid,add_user,add_date,add_ip,agentid,factoryid,factoryname,product_id,product_name,catanum,cataname,ifgroup,is_first,message,province,city,contact_address,name,mobile_phone,is_interested) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
			Integer keyId = dbHelper.executeUpdate(sql,new Object[]{CommonString.getUUID(),add_user,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),0,factoryid,factoryname,product_id,product_name,catanum,cataname,"个人",1,"您好，我对"+factoryname+product_name+cataname+"感兴趣，想要咨询，请您给我回复，谢谢。",province,city,contact_address,name,mobile_phone,is_interested},connection) ; 
			
			

		}
		
		

		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
		
		out.print(rs);
	}
%>