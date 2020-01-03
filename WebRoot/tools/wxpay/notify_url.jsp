<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.io.*,com.jerehnet.wxpay.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
WXPayUtil wxutil=new WXPayUtil();
BufferedReader reader;
try{
 	reader = request.getReader();
 	String line="";
 	StringBuffer inputString = new StringBuffer();
 	while((line = reader.readLine()) !=null){
 		inputString.append(line);
 	}
 	request.getReader().close();
 	Map<String,String> map = wxutil.xmlToMap(inputString.toString());
 	if("SUCCESS".equals(map.get("return_code"))){
 		if("SUCCESS".equals(map.get("result_code"))){
	   		map.remove("xml");
	   		//业务处理
	   		//Connection conn = null;
           // DBHelper dbHelper = DBHelper.getInstance();
			//try{
			//    conn = dbHelper.getConnection();
			//	dbHelper.execute("update activity_sany_pay set order_state=1 where order_no='"+out_trade_no+"'", conn);
			//}catch(Exception e){
	        //       e.printStackTrace();
	        //       out.println("fail");
           //}finally{
	       //    DBHelper.freeConnection(conn);
           //}
           
           //System.out.println(map.get("mweb_url"));
           //response.sendRedirect(map.get("mweb_url"));
           
	   		response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code></xml>");
	   	}
 	}
}catch (Exception e) {
  e.printStackTrace();
}
%>
