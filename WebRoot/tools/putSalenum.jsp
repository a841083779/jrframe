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
	List<Map> list =dbHelper.getMapList(" select top 1000 id from pro_products where is_create_mobile=0 ",conn);
	if(list!=null&&list.size()>0){
		for(Map m:list){
			Map inquiry=dbHelper.getMap(" select count(id) as a from pro_product_form where product_id=? ",new Object[]{ CommonString.getFormatPara(m.get("id")) },conn);
			if(inquiry!=null){
				dbHelper.execute(" update pro_products set inquiry_count=?,is_create_mobile=1 where id=? ",new Object[]{CommonString.getFormatPara(inquiry.get("a")),CommonString.getFormatPara(m.get("id"))},conn);
			}
			out.print(CommonString.getFormatPara(m.get("id"))+";");
		}
	}
	
} catch (Exception ex) {
	ex.printStackTrace();
} finally {
	dbHelper.freeConnection(conn);
}
   
%>