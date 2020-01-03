<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Connection"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %>
<%
	String catalog = CommonString.getFormatPara(request.getParameter("text")) ;  // 品牌 id
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String catalogname = CommonString.getFormatPara(catalogMap.get(catalog)) ;
	String cachekey = "level_2_json_chooser" +catalog ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Connection conn = null ;
%>  
<cache:cache cron="* * * */1 *">
catalog_subcallback(
{"catalog_sub":[
<%
try{

	List<Map> all_preCatalog = dbHelper.getMapList("select num,name from pro_catalog where num like '"+catalog+"%' and len(num)>=6") ; // 取出所有的一级栏目
	if(null != all_preCatalog && all_preCatalog.size()>0 &&!"".equals(catalogname)){
		out.println("{\"id\":\""+catalogname+"\",\"title\":\""+catalogname+"\",\"text\":\""+catalogname+"\",\"caption\":\"true\",\"disabled\":\"true\"},");
				for(Map onesubMap:all_preCatalog){
					out.println("{\"id\":\""+CommonString.getFormatPara(CommonString.getFormatPara(onesubMap.get("num")))+"\",\"title\":\""+CommonString.getFormatPara(onesubMap.get("name"))+"\",\"text\":\""+CommonString.getFormatPara(onesubMap.get("name"))+"\"},");
				}
	}else{
		out.println("{\"id\":\"该类型无类别\",\"title\":\"该类型无类别\",\"text\":\"该类型无类别\",\"caption\":\"true\",\"disabled\":\"true\"},");
	}
	
}catch(Exception e){
	e.printStackTrace() ;
}finally{
	dbHelper.freeConnection(conn) ;
}
%>
]})
</cache:cache>