<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %>
<cache:cache cron="* * * */1 *" key="product_search_brand">
	/**
* 本页面生成一段javascript，用于返回 品牌的数据
*/
factorycallback(
{"factory":[
{"id":"0","title":"热门","text":"热门","caption":"true","disabled":"true"},
{"id":"133","title":"三一","text":"三一"},
{"id":"209","title":"徐工","text":"徐工"},
{"id":"136","title":"柳工","text":"柳工"},
{"id":"182","title":"小松","text":"小松"},
{"id":"192","title":"斗山","text":"斗山"},
{"id":"134","title":"中联重科","text":"中联重科"},
{"id":"135","title":"龙工","text":"龙工"},
{"id":"139","title":"厦工","text":"厦工"},
{"id":"175","title":"沃尔沃","text":"沃尔沃"},
{"id":"144","title":"山推","text":"山推"},
{"id":"137","title":"临工","text":"临工"},
{"id":"141","title":"福田雷沃","text":"福田雷沃"},
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> allBrands_upper_index = dbHelper.getMapList("  select distinct upper_index from pro_agent_factory where flag=1 ") ;
	List<Map> allBrands = null ; 
	if(null != allBrands_upper_index && allBrands_upper_index.size()>0){
		for(Map oneindexMap:allBrands_upper_index){
			out.println("{\"id\":\""+CommonString.getFormatPara(oneindexMap.get("upper_index"))+"\",\"title\":\""+CommonString.getFormatPara(oneindexMap.get("upper_index"))+"\",\"text\":\""+CommonString.getFormatPara(oneindexMap.get("upper_index"))+"\",\"caption\":\"true\",\"disabled\":\"true\"},");
			allBrands = dbHelper.getMapList(" select id,name from pro_agent_factory where flag=1 and upper_index='"+CommonString.getFormatPara(oneindexMap.get("upper_index"))+"' ") ;
			if(null !=allBrands && allBrands.size()>0)
			for(Map oneMap:allBrands){
				out.println("{\"id\":\""+CommonString.getFormatPara(CommonString.getFormatPara(oneMap.get("id")))+"\",\"title\":\""+CommonString.getFormatPara(oneMap.get("name"))+"\",\"text\":\""+CommonString.getFormatPara(oneMap.get("name"))+"\"},");
			}
		}
	}
%>
]})
</cache:cache>