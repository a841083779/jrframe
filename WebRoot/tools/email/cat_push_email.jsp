<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
	request.setCharacterEncoding("utf-8");
	DBHelper dbHelper = DBHelper.getInstance();
	String productids = CommonString.getFormatPara(request.getParameter("productids")); // 获得产品id
	String uuids = CommonString.getFormatPara(request.getParameter("uuids")); // 订单表单中的uuid
	if (!"".equals(uuids)) {
	    Map one_proform = dbHelper.getMap("  select  * from pro_product_form where uuid='" + uuids + "'");	
        String contents=CommonString.getFormatPara(one_proform.get("factoryname"))+ CommonString.getFormatPara(one_proform.get("product_name"))+ CommonString.getFormatPara(one_proform.get("cataname"));
        String ids=	CommonString.getFormatPara(one_proform.get("id"));	
        System.out.println("http://product.21-sun.com/tools/email/erro.jsp?id= "+ids);
		WEBEmail.sendMailByUrl("zengfc@21-sun.com,zhangjx@21-sun.com", null, null, contents+ "订单推送异常",
								"http://product.21-sun.com/tools/email/erro.jsp?id="+ids, "utf-8");		
								}

%>