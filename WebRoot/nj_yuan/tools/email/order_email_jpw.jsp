<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
	request.setCharacterEncoding("utf-8");
	String name = CommonString.getFormatPara(request.getParameter("name")); // 获得产品id
	String tel = CommonString.getFormatPara(request.getParameter("tel")); // 获得产品id
	String company = CommonString.getFormatPara(request.getParameter("company")); // 获得产品id
	String product = CommonString.getFormatPara(request.getParameter("product")); // 订单表单中的uuid
	String factoryid = "";
	DBHelper dbHelper = DBHelper.getInstance();
	String[] productid = null;
	String[] uuid = null;
	String province = null ;
	String catanum = null ;
	if (!"".equals(name)&&!"".equals(tel)&&!"".equals(company)&&!"".equals(product)) {
		String content="";
		content+="姓名:"+name+"<br />";
		content+="电话:"+tel+"<br />";
		content+="公司:"+company+"<br />";
		content+="产品:"+product+"<br />";
		WEBEmail.sendMail("caofj@21-sun.com,gaopeng@21-sun.com","","杰配网5周年感恩回馈申请人信息",content);
		out.println("name:"+name);
	}
%>