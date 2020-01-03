<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%
	
	try{
	//定时更新产品中心详细页信息
	Map root1 = new HashMap() ;  
	
	Common.doPostHttpAsync("http://product.21-sun.com/tools/create/products/create_products_detail_koubei_one.jsp",root1);
	Common.doPostHttpAsync("http://product.21-sun.com/tools/create/products/create_products_detail_order_one.jsp",root1);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
%>