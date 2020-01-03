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
	String sql="select  catalognum,catalogname from pro_catalog_factory where factoryid="+factory+"  order by catalognum asc";
	System.out.println(sql);
	proLists = dbHelper.getMapList(sql);
		//用户登陆
	%>
	<div class="_val"><span><i class="red">*</i> 请选择机型</span></div>
       <div class="_option hide"> 
	  <%
			
			if(proLists!=null){
    		for(Map m:proLists){
    			String id = CommonString.getFormatPara(m.get("catalognum"));
    			String name = CommonString.getFormatPara(m.get("catalogname"));
			%>
          <a href="#" data-val="<%=id%>" ><%=name%></a>
		  <%}}%>
       </div>
	<%
			
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		dbHelper.freeConnection(connection);
	}
%>