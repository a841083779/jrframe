<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %>
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("text")) ;  // 品牌 id
	String cachekey = "photo_level_2_json_chooser" +factoryid ;
	String url = request.getHeader("referer") ; // 来自图片的查询
	DBHelper dbHelper = DBHelper.getInstance() ;
	if(url.indexOf("photo")!=-1 ||url.indexOf("news")!=-1){
%>  
<cache:cache cron="* * * */1 *"  key = "<%=cachekey %>">
catalogidcallback(
{"catalog":[
<%
	List<Map> all_preCatalog = dbHelper.getMapList(" select num,name from pro_catalog where len(num)=3 ") ; // 取出所有的一级栏目
	List<Map> all_catalogs = null ;
	if(null != all_preCatalog && all_preCatalog.size()>0){
		for(Map oneMap:all_preCatalog){
			all_catalogs = dbHelper.getMapList("  select count(catalogname) total, catalogname,catalognum from pro_products where catalognum like '"+CommonString.getFormatPara(oneMap.get("num"))+"%' and factoryid="+factoryid+" group by catalogname,catalognum ") ;
			if(null !=all_catalogs && all_catalogs.size()>0){
				out.println("{\"id\":\""+CommonString.getFormatPara(oneMap.get("name"))+"\",\"title\":\""+CommonString.getFormatPara(oneMap.get("num"))+"\",\"text\":\""+CommonString.getFormatPara(oneMap.get("name"))+"\",\"caption\":\"true\",\"disabled\":\"true\"},");
				for(Map onesubMap:all_catalogs){
					out.println("{\"id\":\""+CommonString.getFormatPara(CommonString.getFormatPara(onesubMap.get("catalognum")))+"\",\"title\":\""+CommonString.getFormatPara(onesubMap.get("catalogname"))+"\",\"text\":\""+CommonString.getFormatPara(onesubMap.get("catalogname"))+"\"},");
				}
			}
		}
	}
%>
]})
</cache:cache>
<%
}else if(url.indexOf("agent")!=-1){
	  %>
	   catalogidcallback(
     		{"catalog":[
		<%
		List<Map> allareaList = dbHelper.getMapList(" select city  from pro_agent_factory where agent_fac like '%"+factoryid+"%' and city is not null and is_show=1 group by city ") ;
		if(null != allareaList && allareaList.size()>0){
			out.println("{\"id\":\"代理地区\",\"title\":\"代理地区\",\"text\":\"代理地区\",\"caption\":\"true\",\"disabled\":\"true\"},");
			for(Map oneMap:allareaList){
				out.println("{\"id\":\""+CommonString.getFormatPara(oneMap.get("city"))+"\",\"title\":\""+CommonString.getFormatPara(oneMap.get("city"))+"\",\"text\":\""+CommonString.getFormatPara(oneMap.get("city"))+"\"},");
			}
		}else
		{
			out.println("{\"id\":\"代理地区\",\"title\":\"代理地区\",\"text\":\"代理地区\",\"caption\":\"true\",\"disabled\":\"true\"},");
			out.println("{\"id\":\"该品牌暂无代理商\",\"title\":\"该品牌暂无代理商\",\"text\":\"该品牌暂无代理商\",\"disabled\":\"true\"},");
		}
        %>
       	]})
	  <%
}
%>