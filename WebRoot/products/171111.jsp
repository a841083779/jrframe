<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%

DBHelper dbHelper = DBHelper.getInstance() ;
List<Map> list=dbHelper.getMapList("  select name, tel,gift,add_date from activity_17double_eleven_game_log  where gift_id>0 ");
%>
 <style>
    table{ border-collapse:collapse; border-spacing:0;}
    table ,tr ,td{ border:#333 solid 1px;font-size:16px;text-align:center}
	td{height:20px;width:105px}
	input{height:20px;width:100px}
	</style>
<script src="/plugin/date/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!--<form name="theform" id="theform" action="" method="post">
<table>
<tr>
时间：
<input type="text"   name="startTime" id="startTime" value="<%//=startTime%>" readonly="readonly" onClick="WdatePicker()" /> --
<input type="text"   name="endTime" id="endTime"  value="<%//=endTime%>" readonly="readonly" onClick="WdatePicker()" />
<input type="submit" class="btn" value="查询" style="margin-left: 5px;" />
</tr>
</table>
</form>-->
<table>
<tr>
<td>姓名</td>
<td>手机号</td>
<td>奖品</td>
<td>时间</td>
</tr>
<%
for(Map m:list){
%>
<tr>
<td><%=CommonString.getFormatPara(m.get("name"))%></td>
<td><%=CommonString.getFormatPara(m.get("tel"))%></td>
<td><%=CommonString.getFormatPara(m.get("gift"))%></td>
<td><%=CommonString.getFormatPara(m.get("add_date"))%></td>
</tr>
<%	
}
%>

</table>

