<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="java.sql.Connection"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %>
<cache:cache cron="* * * */1 *">
	/**
* 本页面生成一段javascript，用于返回 品牌的数据
*/   
catalogcallback(
{"catalog":[
<%
	Connection conn = null ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	try{
	conn = dbHelper.getConnection() ;
	List<Map> catalogs = dbHelper.getMapList("select name,num from pro_catalog where len(num)=3 and is_show=1 order by num",conn) ;
	List<Map> allBrands = null ; 
	if(null != catalogs && catalogs.size()>0){
		for(Map catalog:catalogs){
			out.println("{\"id\":\""+CommonString.getFormatPara(catalog.get("num"))+"\",\"title\":\""+CommonString.getFormatPara(catalog.get("name"))+"\",\"text\":\""+CommonString.getFormatPara(catalog.get("name"))+"\"},");
		}
	}
	
	}catch(Exception e){
		e.printStackTrace() ;
	}finally{
		dbHelper.freeConnection(conn) ;
	}
%>
]})
</cache:cache>