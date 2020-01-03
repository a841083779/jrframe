<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%
DBHelper dbHelper = DBHelper.getInstance() ;
List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");

String sql="";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<style>
    table{ border-collapse:collapse; border-spacing:0;}
    table ,tr ,td{ border:#333 solid 1px;font-size:16px;text-align:center}
	td{height:20px;width:105px}
</style>
<body>
<%
for(Map m:catalogAppList){
	String cataNum="";String cataName="";
	cataNum = CommonString.getFormatPara(m.get("num"));
	cataName = CommonString.getFormatPara(m.get("name"));
	
	if(!"101001".equals(cataNum)&&!"101002".equals(cataNum)&&!"106001".equals(cataNum)&&!"102".equals(cataNum)&&!"103".equals(cataNum)
			&&!"104".equals(cataNum)&&!"101003".equals(cataNum)&&!"101005".equals(cataNum)&&!"105".equals(cataNum)&&!"110".equals(cataNum)
		&&!"101008".equals(cataNum)&&!"122".equals(cataNum)&&!"118".equals(cataNum)&&!"107".equals(cataNum)&&!"109".equals(cataNum)
		&&!"111".equals(cataNum)&&!"123".equals(cataNum)&&!"120".equals(cataNum)&&!"113".equals(cataNum)&&!"101".equals(cataNum)){
		%>
		<h3><%=cataName%></h3>
		<%
		sql = " select top 20 t1.id,t1.name,t1.factoryname,t1.catalogname,t2.a from pro_products t1 left join (select product_id,count(product_id) as a from pro_product_form where is_deleted=0 group by product_id ) as t2 on t1.id=t2.product_id where t1.catalognum='"+cataNum+"' and is_show=1 order by t2.a desc ";
		List<Map> list = dbHelper.getMapList(sql);
		if(list!=null&&list.size()>0){
			%>
			<div>
			<%
			for(Map p:list){
			%>
				<div><%=CommonString.getFormatPara(p.get("factoryname"))%><%=CommonString.getFormatPara(p.get("name"))%><%=CommonString.getFormatPara(p.get("catalogname"))%></div>
			<%
			}
			%>
			</div>
			<%
		}
	}
}
%>
</body>
</html>
