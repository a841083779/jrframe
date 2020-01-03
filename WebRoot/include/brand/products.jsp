<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	String cacheKey = "products_"+factoryid;
	DBHelper dbHelper = DBHelper.getInstance() ;
	String proSql = "select top 6 img2,factoryname,name,catalogname,introduce,file_name,view_count from pro_products where is_show=1 and factoryid = '"+factoryid+"' order by view_count desc ,id desc";
	
%>
<cache:cache cron="* * */5 * *" key="<%=cacheKey%>">
<%
	List<Map> prosList = dbHelper.getMapList(proSql);
	if(prosList!=null && prosList.size()>0){
		for(Map pro:prosList){
			String factoryname = CommonString.getFormatPara(pro.get("factoryname"));
			String name = CommonString.getFormatPara(pro.get("name"));
			String catalogname = CommonString.getFormatPara(pro.get("catalogname"));
			String file_name = CommonString.getFormatPara(pro.get("file_name"));
			String img2 = CommonString.getFormatPara(pro.get("img2"));
%>
	<li> <a href="/proDetail/<%=file_name %>" target="_blank" title="<%=factoryname %><%=name%><%=catalogname %>"><img src="/uploadfiles/<%=img2 %>" width="80" height="70" alt="<%=factoryname %><%=name%><%=catalogname %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a>
          <h3><a target="_blank" href="/proDetail/<%=file_name %>" title="<%=factoryname %><%=name%><%=catalogname %>"><%=factoryname %><%=name%><%=catalogname %></a><span style="color:#999999"> </span></h3>
        </li>
<%}} %>
</cache:cache>