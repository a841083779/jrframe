<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalogName = CommonString.getFormatPara(request.getParameter("catalogName")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	String factoryname = "".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid)) ;	
	if(catalogName!=null && !catalogName.equals("")){
		factoryname += catalogName;
	}
	String cacheKey = "brand_news_pic_"+factoryid;
	DBHelper dbHelper = DBHelper.getInstance() ;
	String dataSql = "select top 8 id,title,pub_date,html_filename,image from article where title like '%"+factoryname+"%' and image<>'' and  image not like '%.pdf' and is_pub=1 and is_del=0  order by pub_date  desc";
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
			String html_filename = CommonString.getFormatPara(d.get("html_filename"));
			String image = CommonString.getFormatPara(d.get("image"));
			String img = "http://news.21-sun.com/UserFiles/x_Image/x_"+image;
%>
	<li>     
        <p class="pp_videoimg"><a href="http://product.21-sun.com/news/detail.jsp?id=<%=id %>" target="_blank" title="<%=title %>"><img src="<%=img %>" alt="<%=title %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a></p>
        <p class="pp_videoname"><a href="http://product.21-sun.com/news/detail.jsp?id=<%=id %>" target="_blank" title="<%=title %>"><%=title %></a></p>
     </li>
<%}} %>
</cache:cache>