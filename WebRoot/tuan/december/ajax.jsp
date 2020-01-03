<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String rs = "fail";
	String callback = CommonString.getFormatPara(request.getParameter("callback"));
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	try{
		connection = dbHelper.getConnection(); 

	
		if("toupiao".equals(flag)){
	
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String city = CommonString.getFormatPara(request.getParameter("city"));
			String name = CommonString.getFormatPara(request.getParameter("user_name"));
			String phone = CommonString.getFormatPara(request.getParameter("contact_tel"));
			String pinpai = CommonString.getFormatPara(request.getParameter("pinpai"));
			
			String emailText = "";
			emailText += "【"+province;
			if(!province.equals(city)){
				emailText += city;
			}
			emailText += "】的";
			emailText += "【"+name + "】最喜欢品牌投票：<br />";
			emailText += "电话是："+phone+"<br />";
			emailText += "品牌是："+pinpai+"<br />";
			HttpClient httpClient = new HttpClient();
			PostMethod postMethod = new PostMethod("http://service.21-sun.com/http/utils/sendmail.jsp");
			postMethod.getParams().setContentCharset("UTF-8");
			postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
			postMethod.addParameter("to","caofj@21-sun.com");
			postMethod.addParameter("cc","caozq@21-sun.com,songsn@21-sun.com");
			postMethod.addParameter("title","来自优买团的最喜欢品牌投票");
			postMethod.addParameter("content",emailText);
			postMethod.addParameter("fixed","21sun");
			httpClient.executeMethod(postMethod);
			
			
		}
		
		
		
	
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>