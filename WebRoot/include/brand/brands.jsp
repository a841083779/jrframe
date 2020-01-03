<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	String cacheKey = "products_"+factoryid;
	DBHelper dbHelper = DBHelper.getInstance() ;
	String brandSql = "select top 15 logo,full_name,name,usern,introduce,view_count  from pro_agent_factory where flag=1 order by view_count desc";
	
%>
<cache:cache cron="* * */5 * *" key="<%=cacheKey%>">
<%
	List<Map> brandsList = dbHelper.getMapList(brandSql);
	if(brandsList!=null && brandsList.size()>0){
		int i = 1;
		for(Map brand:brandsList){
			String usern = CommonString.getFormatPara(brand.get("usern"));
			String full_name = CommonString.getFormatPara(brand.get("full_name"));
			String name = CommonString.getFormatPara(brand.get("name"));
%>
	<li <% if(i<=3){ %>class="top3"<%} %><% if(i==15){ %>style="border-bottom:none;"<%} %>> <em><%=i %></em>
          <h4><a target="_blank" href="/brand/<%=usern %>/" title="<%=name %>"><%=name %></a></h4>
        </li>
<%i++;}
		} %>
</cache:cache>