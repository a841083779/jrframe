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
//挖掘机
List<Map> excavatorBrand=dbHelper.getMapList("select top 10 factoryid,factoryname,count(DISTINCT mobile_phone) as a from pro_product_form where catanum like '101001%' and catanum not in ('101001098','101001099') and   add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0 and factoryid <>0 and factoryid <> '' and factoryid is not null group by factoryid,factoryname order by count(DISTINCT mobile_phone) desc");
List<Map> excavatorProv=dbHelper.getMapList("select top 10 province ,count(DISTINCT mobile_phone) as a from pro_product_form where catanum like '101001%' and catanum not in ('101001098','101001099') and   add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0 and province <> '' and province is not null group by province order by count(DISTINCT mobile_phone) desc");
List<Map> exvavatorModel=dbHelper.getMapList("select top 20 product_name,factoryname ,count(DISTINCT mobile_phone) as a from pro_product_form where catanum like '101001%' and catanum not in ('101001098','101001099') and   add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0 and factoryid <>0 and factoryid <> '' and factoryid is not null and product_id <>0 and product_id <> '' and product_id is not null group by product_id,product_name,factoryid,factoryname order by count(DISTINCT mobile_phone) desc");
//装载机
List<Map> loaderBrand=dbHelper.getMapList("select top 10 factoryid,factoryname,count(DISTINCT mobile_phone) as a from pro_product_form where catanum like '101002%'  and   add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0 and factoryid <>0 and factoryid <> '' and factoryid is not null group by factoryid,factoryname order by count(DISTINCT mobile_phone) desc");
List<Map> loaderProv=dbHelper.getMapList("select top 10 province ,count(DISTINCT mobile_phone) as a from pro_product_form where catanum like '101002%'  and   add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0 and province <> '' and province is not null group by province order by count(DISTINCT mobile_phone) desc");
List<Map> loaderModel=dbHelper.getMapList("select top 10 product_name,factoryname ,count(DISTINCT mobile_phone) as a from pro_product_form where catanum like '101002%'  and   add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0 and factoryid <>0 and factoryid <> '' and factoryid is not null and product_id <>0 and product_id <> '' and product_id is not null group by product_id,product_name,factoryid,factoryname order by count(DISTINCT mobile_phone) desc");
//推土机
List<Map> bulldozerBrand=dbHelper.getMapList("select top 10 factoryid,factoryname,count(DISTINCT mobile_phone) as a from pro_product_form where catanum like '101003%'  and   add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0 and factoryid <>0 and factoryid <> '' and factoryid is not null group by factoryid,factoryname order by count(DISTINCT mobile_phone) desc");
List<Map> bulldozerProv=dbHelper.getMapList("select top 10 province ,count(DISTINCT mobile_phone) as a from pro_product_form where catanum like '101003%'  and   add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0 and province <> '' and province is not null group by province order by count(DISTINCT mobile_phone) desc");
List<Map> bulldozerModel=dbHelper.getMapList("select top 10 product_name,factoryname ,count(DISTINCT mobile_phone) as a from pro_product_form where catanum like '101003%'  and   add_date>='"+startTime+"' and add_date<='"+endTime+"' and is_deleted=0 and factoryid <>0 and factoryid <> '' and factoryid is not null and product_id <>0 and product_id <> '' and product_id is not null group by product_id,product_name,factoryid,factoryname order by count(DISTINCT mobile_phone) desc");

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
<!--挖掘机-->
<table>
<tr colspan="2"><span  style="color:red;font-weight:bold;">挖掘机询价前十品牌:</span></tr>
<tr>
<%
if(excavatorBrand!=null&&excavatorBrand.size()>0){
	for(Map m:excavatorBrand){
%>
<td><%=CommonString.getFormatPara(m.get("factoryname"))%></td>
<%
	}
}else{
	out.println("暂无数据");
}
%>
</tr>
</table>

<table>
<tr colspan="2"><span  style="color:red;font-weight:bold;">挖掘机询价前十区域:</span></tr>
<tr>
<%
if(excavatorProv!=null&&excavatorProv.size()>0){
	for(Map m:excavatorProv){
%>
<td><%=CommonString.getFormatPara(m.get("province"))%></td>
<%
	}
}else{
	out.println("暂无数据");
}
%>
</tr>
</table>

<table>
<tr colspan="2"><span  style="color:red;font-weight:bold;">挖掘机询单前十机型:</span></tr>
<tr>
<%
if(exvavatorModel!=null&&exvavatorModel.size()>0){
	for(Map m:exvavatorModel){
%>
<td><%=CommonString.getFormatPara(m.get("factoryname"))%><br/><%=CommonString.getFormatPara(m.get("product_name"))%><br/><span style="color:red"><%=CommonString.getFormatPara(m.get("a"))%></span></td>
<%
	}
}else{
	out.println("暂无数据");
}
%>
</tr>
</table>
<br/>
<br/>
<br/>
<!--装载机-->
<table>
<tr colspan="2"><span  style="color:red;font-weight:bold;">装载机询价前十品牌:</span></tr>
<tr>
<%
if(loaderBrand!=null&&loaderBrand.size()>0){
	for(Map m:loaderBrand){
%>
<td><%=CommonString.getFormatPara(m.get("factoryname"))%></td>
<%
	}
}else{
	out.println("暂无数据");
}
%>
</tr>
</table>

<table>
<tr colspan="2"><span  style="color:red;font-weight:bold;">装载机询价前十区域:</span></tr>
<tr>
<%
if(loaderProv!=null&&loaderProv.size()>0){
	for(Map m:loaderProv){
%>
<td><%=CommonString.getFormatPara(m.get("province"))%></td>
<%
	}
}else{
	out.println("暂无数据");
}
%>
</tr>
</table>

<table>
<tr colspan="2"><span  style="color:red;font-weight:bold;">装载机询单前十机型:</span></tr>
<tr>
<%
if(loaderModel!=null&&loaderModel.size()>0){
	for(Map m:loaderModel){
%>
<td><%=CommonString.getFormatPara(m.get("factoryname"))%><br/><%=CommonString.getFormatPara(m.get("product_name"))%></td>
<%
	}
}else{
	out.println("暂无数据");
}
%>
</tr>
</table>
<br/>
<br/>
<br/>
<!--推土机-->
<table>
<tr colspan="2"><span  style="color:red;font-weight:bold;">推土机询价前十品牌:</span></tr>
<tr>
<%
if(bulldozerBrand!=null&&bulldozerBrand.size()>0){
	for(Map m:bulldozerBrand){
%>
<td><%=CommonString.getFormatPara(m.get("factoryname"))%></td>
<%
	}
}else{
	out.println("暂无数据");
}
%>
</tr>
</table>

<table>
<tr colspan="2"><span  style="color:red;font-weight:bold;">推土机询价前十区域:</span></tr>
<tr>
<%
if(bulldozerProv!=null&&bulldozerProv.size()>0){
	for(Map m:bulldozerProv){
%>
<td><%=CommonString.getFormatPara(m.get("province"))%></td>
<%
	}
}else{
	out.println("暂无数据");
}
%>
</tr>
</table>

<table>
<tr colspan="2"><span  style="color:red;font-weight:bold;">推土机询单前十机型:</span></tr>
<tr>
<%
if(bulldozerModel!=null&&bulldozerModel.size()>0){
	for(Map m:bulldozerModel){
%>
<td><%=CommonString.getFormatPara(m.get("factoryname"))%><br/><%=CommonString.getFormatPara(m.get("product_name"))%></td>
<%
	}
}else{
	out.println("暂无数据");
}
%>
</tr>
</table>