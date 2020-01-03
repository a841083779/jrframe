<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="/WEB-INF/oscache.tld" prefix="cache"%>
<%

DBHelper dbHelper = DBHelper.getInstance() ;
int qNum=0;
int pscNum=0;
int yyjNum=0;
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
Calendar c = Calendar.getInstance();    
c.add(Calendar.MONTH, 0);
c.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期既为本月第一天 
String first = format.format(c.getTime()); 

Calendar ca = Calendar.getInstance();    
ca.set(Calendar.DAY_OF_MONTH, ca.getActualMaximum(Calendar.DAY_OF_MONTH));  
String last = format.format(ca.getTime());

String startTime=CommonString.getFormatPara(request.getParameter("startTime")).equals("")?first:CommonString.getFormatPara(request.getParameter("startTime"));
startTime+=" 00:00:00";
String endTime=CommonString.getFormatPara(request.getParameter("endTime")).equals("")?last:CommonString.getFormatPara(request.getParameter("endTime"));
endTime+=" 23:59:59";
List<Map> catalogList=dbHelper.getMapList("SELECT id,name,num FROM pro_catalog where parentid=0 order by order_no asc , id asc");
//破碎锤
Map pscMap=dbHelper.getMap("select  count(distinct(mobile_phone))  as num   from pro_product_form where catanum ='101001098'  and  mobile_phone<>'' and mobile_phone is not null and add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0  ");
if(pscMap==null){pscMap=new HashMap();}else{pscNum=CommonString.getFormatInt(CommonString.getFormatPara(pscMap.get("num")));}
//液压剪
Map yyjMap=dbHelper.getMap("select  count(distinct(mobile_phone))  as num   from pro_product_form where catanum ='101001099'  and  mobile_phone<>'' and mobile_phone is not null and add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0  ");
if(yyjMap==null){yyjMap=new HashMap();}else{yyjNum=CommonString.getFormatInt(CommonString.getFormatPara(yyjMap.get("num")));}
%>
 <style>
    table{ border-collapse:collapse; border-spacing:0;}
    table ,tr ,td{ border:#333 solid 1px;font-size:16px;text-align:center}
	td{height:20px;width:105px}
	input{height:20px;width:100px}
	</style>
<script src="/plugin/date/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<form name="theform" id="theform" action="" method="post">
<table>
<tr>
时间：
<input type="text"   name="startTime" id="startTime" value="<%=startTime%>" readonly="readonly" onClick="WdatePicker()" /> --
<input type="text"   name="endTime" id="endTime"  value="<%=endTime%>" readonly="readonly" onClick="WdatePicker()" />
<input type="submit" class="btn" value="查询" style="margin-left: 5px;" />
</tr>
</table>
</form>
<table>
<%
for(Map m:catalogList){
	Map qMap=dbHelper.getMap("select  count(distinct(mobile_phone))  as num   from pro_product_form where catanum like '"+CommonString.getFormatPara(m.get("num"))+"%' and catanum not in ('101001098','101001099') and  mobile_phone<>'' and mobile_phone is not null and add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0  ");
	if(qMap==null){qMap=new HashMap();}else{qNum=CommonString.getFormatInt(CommonString.getFormatPara(qMap.get("num")));}
	%>
<tr>
<td><%=CommonString.getFormatPara(m.get("name")) %></td>
<td ><%=qNum%></td>
</tr>
<%
}
%>
<tr>
<td>破碎锤</td>
<td ><%=pscNum%></td>
</tr>
<tr>
<td>液压剪</td>
<td ><%=yyjNum%></td>
</tr>

</table>

