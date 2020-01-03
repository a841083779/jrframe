<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
DBHelper dbHelper = DBHelper.getInstance();
Connection conn = null;
Map proParamMap = (Map) application.getAttribute("proParamMap");
if(proParamMap==null){proParamMap=new HashMap();}

try{
	conn = dbHelper.getConnection();
	List<Map> list =dbHelper.getMapList(" select * from pro_catalog where parentid <>0",conn);
	if(list!=null&&list.size()>0){
		for(Map m:list){
			Map catalog=dbHelper.getMap(" select num  from pro_catalog where id=? ",new Object[]{CommonString.getFormatPara(m.get("parentid"))},conn);
			if(catalog!=null){
				dbHelper.execute(" update pro_catalog set parentnum=? where id= ? ",new Object[]{CommonString.getFormatPara(catalog.get("num")),CommonString.getFormatPara(m.get("id"))},conn);
				out.print(CommonString.getFormatPara(m.get("num"))+";");
			}
			
		}
	}
	
} catch (Exception ex) {
	ex.printStackTrace();
} finally {
	dbHelper.freeConnection(conn);
}
   
%>