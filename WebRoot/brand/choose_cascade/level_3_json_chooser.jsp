<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Connection"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %>
<cache:cache cron="* * * */1 *">
	/**
* 本页面生成一段javascript，用于返回 品牌的数据
*/   
factoryidcallback(
{"factoryid":[
<%
	String catalog = CommonString.getFormatPara(request.getParameter("text")) ;  // 品牌 id
	DBHelper dbHelper = DBHelper.getInstance() ;
	Connection conn = null ;
	try{
	conn = dbHelper.getConnection() ;
	List<Map> allBrands_upper_index = dbHelper.getMapList("select distinct upper_index from pro_catalog_for_factory where num like '"+catalog+"%' and len(num)>=6 and is_show=1 and pro_is_show=1") ;
	List<Map> allBrands = null ; 
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String catalogname = CommonString.getFormatPara(catalogMap.get(catalog)) ;
	if(null != allBrands_upper_index && allBrands_upper_index.size()>0){
		out.println("{\"id\":\""+catalogname+"\",\"title\":\""+catalogname+"\",\"text\":\""+catalogname+"\",\"caption\":\"true\",\"disabled\":\"true\"},");
		for(Map oneindexMap:allBrands_upper_index){
			out.println("{\"id\":\""+CommonString.getFormatPara(oneindexMap.get("upper_index"))+"\",\"title\":\""+CommonString.getFormatPara(oneindexMap.get("upper_index"))+"\",\"text\":\""+CommonString.getFormatPara(oneindexMap.get("upper_index"))+"\",\"caption\":\"true\",\"disabled\":\"true\"},");
			allBrands = dbHelper.getMapList("select factoryname,factoryid,usern,count(*) total ,logo,upper_index from pro_catalog_for_factory where num like '"+catalog+"%' and factoryname<>'' and factoryname is not null and factoryid<>0 and factoryid<>'' and factoryid is  not null and is_show=1 and pro_is_show=1 and upper_index='"+CommonString.getFormatPara(oneindexMap.get("upper_index"))+"' group by factoryname,factoryid,usern,logo,upper_index order by total desc") ;
			if(null !=allBrands && allBrands.size()>0)
			for(Map oneMap:allBrands){
				out.println("{\"id\":\""+CommonString.getFormatPara(CommonString.getFormatPara(oneMap.get("usern")))+"\",\"title\":\""+CommonString.getFormatPara(oneMap.get("factoryname"))+"\",\"text\":\""+CommonString.getFormatPara(oneMap.get("factoryname"))+"\"},");
			}
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