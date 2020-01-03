<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	String factoryname=CommonString.getFormatPara(brandMap.get(factoryid));
	//所有分类
	List<Map> allcatalogsList = dbHelper.getMapList("select name,num from pro_catalog where len(num) = 6");
	
%>
<cache:cache cron="* * */1 * *">
    <div class="mb10 nkb_zyyw border02 l w208" style="margin-top:10px;">
    	<div class="nkb_zyyw_title">
        	<h2 class="l"><%=factoryname %>主营业务</h2>
            <span class="r"><a href="/0-<%=factoryid %>-0.htm" target="_blank" title="更多<%=factoryname %>口碑">更多&gt;&gt;</a></span>
        </div>
        <ul class="nkb_zyyw_list np_fix">
        <%
       		if(allcatalogsList!=null && allcatalogsList.size()>0){
       			for(Map m:allcatalogsList){
       				String num = CommonString.getFormatPara(m.get("num"));
       				String cataname = CommonString.getFormatPara(m.get("name"));
       				List<Map> subcatalogList = dbHelper.getMapList("select top 1 id from pro_products where is_show=1 and factoryid = '"+factoryid+"' and catalognum like '"+num+"%'");
       				if(subcatalogList!=null && subcatalogList.size()>0){
       	%> 
        	<li><a target="_blank"  href="/<%=num %>-<%=factoryid %>-0.htm" title="<%=factoryname %><%=cataname %>"><%=cataname %></a></li>
         <%}}}%>
        </ul>
    </div>
</cache:cache>