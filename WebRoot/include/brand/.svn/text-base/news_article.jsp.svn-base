<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalogName = CommonString.getFormatPara(request.getParameter("catalogName")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	String factoryname = "".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid)) ;	
	if(catalogName!=null && !catalogName.equals("")){
		factoryname += catalogName;
	}
	String cacheKey = "brand_news_art_"+factoryid;
	DBHelper dbHelper = DBHelper.getInstance() ;
	String dataSql = "select top 22 id,title,pub_date,html_filename from article where is_pub=1 and title like '%"+factoryname+"%' order by add_date desc ,id desc";
	//List<Map> dataList = dbHelper.getMapList(dataSql);
	List<Map> dataList =WEBDBHelper.getMapList(dataSql,"Web21sunDBHelper") ;
%>
<cache:cache cron="* */5 * * *" key="<%=cacheKey%>">
<%
	if(dataList!=null && dataList.size()>0){
		for(Map d:dataList){
			String id = CommonString.getFormatPara(d.get("id"));
			String title = CommonString.getFormatPara(d.get("title"));
			String pub_date = CommonDate.getFormatDate("yyyy-MM-dd", d.get("pub_date"));
%>
	<li><a href="http://product.21-sun.com/news/detail.jsp?id=<%=id %>" target="_blank" title="<%=title %>">&bull;&nbsp;&nbsp;<%=title %></a><span><%=pub_date %></span></li>
<%}} %>
</cache:cache>