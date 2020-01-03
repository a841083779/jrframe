<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="GBK"%><%
	response.setContentType("text/xml;charset=gbk;");	
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String rs = "fail";
	try{
		connection = dbHelper.getConnection();
		if("task1_chart_report".equals(flag)){
			StringBuffer xml = new StringBuffer();
			xml.append("<chart palette='2' caption='任务一外呼结果' xAxisName='Result' yAxisName='Times' showValues='0' decimals='0' formatNumberScale='0' useRoundEdges='1'>");
			String sql = " select pce.name,count(p4t.call_rs) as counts from ";
			sql += " pro_common_enum pce left join pro_400_task1 p4t on p4t.call_rs = pce.no ";
			sql += " where pce.parent_no = '103' group by p4t.call_rs,pce.name ";
			List<Map> enumCounts = dbHelper.getMapList(sql,connection);
			for(Map m : enumCounts){
				xml.append("<set label='"+CommonString.getFormatPara(m.get("name"))+"' value='"+CommonString.getFormatPara(m.get("counts"))+"'/>");
			}
			xml.append("</chart>");
			rs = xml.toString();
		}
		if("task2_chart_report".equals(flag)){
			response.setContentType("text/xml;charset=gbk;");
			StringBuffer xml = new StringBuffer();
			xml.append("<chart palette='2' caption='任务二外呼结果' xAxisName='Result' yAxisName='Times' showValues='0' decimals='0' formatNumberScale='0' useRoundEdges='1'>");
			String sql = " select pce.name,count(p4t.call_rs) as counts from ";
			sql += " pro_common_enum pce left join pro_400_task2 p4t on p4t.call_rs = pce.no ";
			sql += " where pce.parent_no = '103' group by p4t.call_rs,pce.name ";
			List<Map> enumCounts = dbHelper.getMapList(sql,connection);
			for(Map m : enumCounts){
				xml.append("<set label='"+CommonString.getFormatPara(m.get("name"))+"' value='"+CommonString.getFormatPara(m.get("counts"))+"'/>");
			}
			xml.append("</chart>");
			rs = xml.toString();
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);	
%>