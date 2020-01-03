<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
DBHelper dbHelper = null;
			String factory = CommonString.getFormatPara(request.getParameter("factory"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	
	//获取数据库连接
	dbHelper = DBHelper.getInstance();
	
	Connection connection = null;
	List<Map> proLists = null;
	
	try {
	connection = dbHelper.getConnection();
	String sql="select  id,name from pro_agent_factory where flag=1 and is_show=1";
	System.out.println(sql);
	proLists = dbHelper.getMapList(sql);
		//用户登陆
	%>
	<div class="_val"><span><i class="red">*</i> 请选择型号</span></div>
       <div class="_option hide"> 
	  <%
			
			if(proLists!=null){
    		for(Map m:proLists){
    			String id = CommonString.getFormatPara(m.get("id"));
    			String name = CommonString.getFormatPara(m.get("name"));
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