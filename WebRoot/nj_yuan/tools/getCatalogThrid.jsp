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
				if(factoryid.equals("")){
					sql= " select  name,num from pro_catalog where parentid!=0 and is_show=1 and len(num)>6 and num like '"+catalog+"%'";
				}else{
					sql= " select  num,name from pro_catalog where  is_show=1 and parentid!=0 and  num in (select  SUBSTRING(catalognum, 0, 10) from pro_products where factoryid="+factoryid+"  and is_show=1  and  catalognum like '"+catalog+"%' and len(catalognum)>6 GROUP BY catalognum )";
				}
			    list = dbHelper.getMapList(sql);
				%>
					<a href="javascript:void(0); return false;" data-val="">请选择产品类型</a>
				<%
				for(Map m : list){
				%><a href="javascript:void(0); return false;" data-val="<%=m.get("num") %>"><%=m.get("name") %></a><%
		  			
		  		}
		  		
	         
				
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>