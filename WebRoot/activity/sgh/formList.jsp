<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%

DBHelper dbHelper = DBHelper.getInstance() ;

List<Map> formList=dbHelper.getMapList(" select * from shangong_activity_form ");
%>
 <style>
    table{ border-collapse:collapse; border-spacing:0;}
    table ,tr ,td{ border:#333 solid 1px;font-size:16px;text-align:center}
	td{height:20px;width:105px}
	input{height:20px;width:100px}
	</style>

<table>
<tr>
<td>姓名</td>
<td>电话</td>
<td>职业</td>
<td>用过的产品型号</td>
<td>拥有的产品型号</td>
<td>驾龄</td>
<td>现所在省份</td>
<td>正确率</td>
<td>提交时间</td>
</tr>


<%
if(formList!=null&&formList.size()>0){
	for(Map m:formList){
%>
<tr>
<td><%=CommonString.getFormatPara(m.get("user_name"))%></td>
<td><%=CommonString.getFormatPara(m.get("tel"))%></td>
<td><%=CommonString.getFormatPara(m.get("profession"))%></td>
<td><%=CommonString.getFormatPara(m.get("used_model"))%></td>
<td><%=CommonString.getFormatPara(m.get("have_model"))%></td>
<td><%=CommonString.getFormatPara(m.get("work_experience"))%></td>
<td><%=CommonString.getFormatPara(m.get("province_id"))%></td>
<td><%=CommonString.getFormatPara(m.get("correct_rate"))%></td>
<td><%=CommonString.getFormatPara(m.get("pub_date"))%></td>
</tr>
<%
	}
}else{
	out.println("暂无数据");
}
%>

</table>


