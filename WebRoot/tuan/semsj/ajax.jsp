<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String rs = "fail";
	String callback = CommonString.getFormatPara(request.getParameter("callback"));
	try{
		connection = dbHelper.getConnection();
		
		if("order_save".equals(flag)){
			
			String province = CommonString.getFormatPara(request.getParameter("province"));  // 下单区域
			if(province.indexOf("-")!=-1){
				province = province.split("-")[1];
			}
			String city = CommonString.getFormatPara(request.getParameter("city"));
			if(city.indexOf("-")!=-1){
				city = city.split("-")[1];
			}
			String contact_tel = CommonString.getFormatPara(request.getParameter("contact_tel"));
			String ifgroup = CommonString.getFormatPara(request.getParameter("ifgroup"));
			String buy_time = CommonString.getFormatPara(request.getParameter("buy_time"));
			String name = CommonString.getFormatPara(request.getParameter("name"));
			String company_name = CommonString.getFormatPara(request.getParameter("company_name"));
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
			String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
			
			//插入订单
			String sql = " insert into pro_product_form (uuid, add_ip , add_user , add_date , factoryid , factoryname, mobile_phone , province , city , ifgroup , buy_time,name,contact_address) ";
			sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ,?,?) ";
			String uuid =  UUID.randomUUID().toString()  ;
			dbHelper.execute(sql,new Object [] {
					uuid ,
					Common.getIp(request),
					"semsj",
					CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),
					factoryid,
					factoryname,
					contact_tel,
					province,
					city,
					ifgroup,
					buy_time,
					name,
					province+city},connection);
					
			Common.doPostHttpAsync("http://product.21-sun.com/tools/order_interface/shangong.jsp?uuid=" + uuid, null);
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>