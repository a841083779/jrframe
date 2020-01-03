<%@page contentType="text/html;charset=utf-8"
	import="java.sql.*,java.util.*"
	%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%><% 
String flag=CommonString.getFormatPara(request.getParameter("flag"));
String id=CommonString.getFormatPara(request.getParameter("id"));
DBHelper dbHelper = DBHelper.getInstance() ;
Map oneMap = new HashMap() ;
//flag 1 -产品跳转 2-品牌跳转

	if(flag.equals("1")){
		   oneMap = dbHelper.getMap(" select file_name from pro_products where id="+id) ;
		   if(oneMap !=null){
		   		response.sendRedirect("/proDetail/"+oneMap.get("file_name"));
		   }else{
				response.sendRedirect("/");  
		   }
	}
	if(flag.equals("2")){
		 oneMap = dbHelper.getMap(" select usern from pro_agent_factory where id="+id) ;
		 response.sendRedirect("/brand/"+oneMap.get("usern")+"/");
	}
	if(flag.equals("3"))
	{
		   oneMap = dbHelper.getMap(" select file_name from pro_products where id="+id) ;
		   response.sendRedirect("/proDetail/"+oneMap.get("file_name")) ;
	}
%>