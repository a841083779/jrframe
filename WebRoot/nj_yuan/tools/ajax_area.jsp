<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,java.sql.Connection,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	
	try{
		connection = dbHelper.getConnection();
		String p = CommonString.getFormatPara(request.getParameter("p"));
		List<Map> areas =null;
		if("get_city".equals(flag)){
			 areas=dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {p},connection);
			 %>
			  <option value="" >选择城市</option>
			 <%
			 for(Map pravince:areas){
			   String id=CommonString.getFormatPara(pravince.get("area_id"));
			   String name=CommonString.getFormatPara(pravince.get("area_name"));
			   %>
			  <option value="<%=id%>" id="<%=name%>"><%=name%></option>
			  <%
			 }
		}else if("get_area".equals(flag)){
			 areas=dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {p},connection);
			 %>
			  <option value="" >选择区域</option>
			 <%
			 for(Map pravince:areas){
			   String id=CommonString.getFormatPara(pravince.get("area_id"));
			   String name=CommonString.getFormatPara(pravince.get("area_name"));
			   %>
			  <option value="<%=id%>" id="<%=name%>"><%=name%></option>
			  <%
			 }
		}else if("get_name".equals(flag)){
		Map memberInfo = (Map)session.getAttribute("memberInfo");
		System.out.println("memberInfo="+memberInfo);
		 String name="";
		if(memberInfo!=null){
		   name=CommonString.getFormatPara(memberInfo.get("username"));
		  name=name+"，恭喜您注册成功！";
		  }else{
		    name="恭喜您注册成功！";
		  }
		  out.print(name);
	   
       }else if("get_img".equals(flag)){
	   	Map memberInfo = (Map)session.getAttribute("memberInfo");
		 String name="";
		if(memberInfo!=null){
		   name=CommonString.getFormatPara(memberInfo.get("image"));
		  }
		  out.print(name);
	   }
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>