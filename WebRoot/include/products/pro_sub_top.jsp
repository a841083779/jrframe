<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String sql = " select top 6 file_name,name,factoryname,catalogname,img2 from pro_products where catalognum like '"+catalog+"%' and img2 is not null and img2 != '' and is_show = 1 order by view_count desc ";
	String cacheKey = "pub_sub_top_"+catalog;
%>
<cache:cache cron="* */1 * * *" key="<%=cacheKey%>">
<%	
	List<Map> list = DBHelper.getInstance().getMapList(sql);
%>
<%
	  	for(int i = 0;list != null && i < list.size();i++){
	  %>
<li><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(list.get(i).get("img2")).toLowerCase()%>" alt="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="109px" height="72px"/></a>
  <h3><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%></a></h3>
</li>
<%
		}
	  %>
</cache:cache>