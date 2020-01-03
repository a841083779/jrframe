<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	String factoryname = "".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid)) ;	
	String cacheKey = "brand_category_"+factoryid;
	DBHelper dbHelper = DBHelper.getInstance() ;
	String allCatalogsSql = "select name,num from pro_catalog where len(num) = 6";
	String usern = "";
	Map factoryMap = null;
	
%>
<cache:cache cron="* * */5 * *" key="<%=cacheKey%>">
<%
	List<Map> allCatlogsList = dbHelper.getMapList(allCatalogsSql);
	if(factoryid!=null && !factoryid.equals("")){
		String factory_sql = "select is_made, is_qijiandian,usern,is_shop,id,name,is_shop,logo,full_name,introduce,mobile,zturl,img1,telphone from pro_agent_factory where id = '"+factoryid+"' and is_show=1 and flag=1" ;
		factoryMap = dbHelper.getMap(factory_sql);
		if(factoryMap!=null){
			usern = CommonString.getFormatPara(factoryMap.get("usern"));
		}
	}
	if(allCatlogsList!=null && allCatlogsList.size()>0){
		for(Map catlog:allCatlogsList){
			String catelogNum = CommonString.getFormatPara(catlog.get("num"));
			String catelogName = CommonString.getFormatPara(catlog.get("name"));
			System.out.println("select id from pro_products where is_show=1 and factoryid = '"+factoryid+"' and catalognum like '"+catelogNum+"%' order by order_no desc");
			List<Map> subcatalogsList = dbHelper.getMapList(" select id from pro_products where is_show=1 and factoryid = '"+factoryid+"' and catalognum like '"+catelogNum+"%' order by order_no desc") ;
			if(subcatalogsList!=null && subcatalogsList.size()>0){
%>
	<li class="top3">
          <h4><a target="_blank" href="/brand/<%=usern %>/products_<%=catelogNum %>.htm" title="<%=factoryname %><%=catelogName %>"><%=factoryname %><%=catelogName %></a></h4>
        </li>
<%}}} %>
</cache:cache>