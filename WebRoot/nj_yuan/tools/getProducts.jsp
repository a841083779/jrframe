<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,java.sql.Connection,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String sql = "";
	List<Map> list=null;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	try{
		connection = dbHelper.getConnection();
		 	sql= " select  id,name,img2 from pro_products where catalognum like '"+catalog+"%' and factoryid='"+factoryid+"' and is_show=1  order by view_count asc";
			    list = dbHelper.getMapList(sql);
				if(list != null && list.size() > 0){
				%>
					<option>请选择产品</option>
				<%
				for(Map pro:list){
					String  id=CommonString.getFormatPara(pro.get("id"));
					String  name=CommonString.getFormatPara(pro.get("name"));
					String  img2=CommonString.getFormatPara(pro.get("img2"));
					%>
					<option value="<%=id%>*<%=img2%>"><%=name%></option>
					<%
					}
				}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>