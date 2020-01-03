<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
	List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
	if("".equals(catalognum)){
		catalognum="101001";
	}
	String whereStr="";
	if(catalognum.equals("101001")){
		whereStr="and catalognum like '"+catalognum+"%' and catalognum <>'101001098' and  catalognum <>'101001099'";
	}else{
		whereStr="and catalognum like '"+catalognum+"%'";
	}
	try{
	
		List<Map> upperList=dbHelper.getMapList(" select upper_index from pro_agent_factory where id in (select factoryid from pro_products where is_show=1 "+whereStr+" and factoryid <> 0 group by factoryid) group by upper_index ");
		
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<style>
    table{ border-collapse:collapse; border-spacing:0;}
    table ,tr ,td{ border:#333 solid 0px;font-size:16px;text-align:left}
	td{height:20px;width:105px}
</style>
<body>
<form action="" method="post" >
<table width="100%">
<tr><td>
<select  name="catalognum">
        <option value="">--请选择产品类别--</option>
      <%if(catalogList != null){for(Map m : catalogList){%>
	  <%=m.get("num")%>
       <option value="<%=m.get("num")%>" <%if(catalognum.equals(m.get("num").toString())){%> selected="selected"<%}%>><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%></option>
         <%}}%>
		 
</select>
<input name="sub" type="submit" value="查询">
</td></tr>
</table>
</form>
<%
for(Map m:upperList){
	String upper=CommonString.getFormatPara(m.get("upper_index"));
	List<Map> list = dbHelper.getMapList(" select id,name from pro_agent_factory where id in (select factoryid from pro_products where is_show=1 "+whereStr+" and factoryid <> 0 group by factoryid) and upper_index='"+upper+"' ");
	%>
	<h3><%=upper%></h3>
	<%
	if(list!=null){
		for(Map model:list){
			%>
			<div><%=CommonString.getFormatPara(model.get("name"))%></div>
			<%
		}
	}
}
%>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{

	}
%>