<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
DBHelper dbHelper = null;
			String factory = CommonString.getFormatPara(request.getParameter("factory"));
	
	//获取数据库连接
	dbHelper = DBHelper.getInstance();
	
	Connection connection = null;
	List<Map> proLists = null;
	
	try {
	connection = dbHelper.getConnection();
	String sql = "select link_name,link_addr from link_list where website_id=6 ";
	proLists = dbHelper.getMapList(sql);
		//用户登陆
	%>
	<link href="friendly_link.css" rel="stylesheet" type="text/css"/>
		<div class="foot5"><ul class="link_left"><li><a href="#">友情链接：</a></li></ul><ul class="link_right">
<%
		if(proLists!=null){
    		for(Map m:proLists){
    			String id = CommonString.getFormatPara(m.get("link_addr"));
    			String name = CommonString.getFormatPara(m.get("link_name"));
		%>
		<li class="m1"><a href="<%=id%>"target="_blank"><%=name%></a></li>
		<%}}%>
		</ul></div>
		
	<%
			
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>