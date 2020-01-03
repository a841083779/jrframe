<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));

	String sql = " select top 4 add_date,title,html_filename from article where title like '%"+factoryname+"%' order by id desc ";
	String cacheKey = "pub_sub_left_foot_news_"+factoryid;
%>
<style>
.relatenews .list07 li{ width:355px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;}
</style>
<cache:cache cron="*/2 * * * *" key="<%=cacheKey%>">
<%	
	List<Map> list = DBHelper.getInstance().getMapList(sql);
%>
<%
	for(int i = 0;list!=null && i<list.size();i++){		  
	  %>
<li><a target="_blank" href="http://news.21-sun.com/detail/<%=CommonDate.getFormatDate("yyyy",list.get(i).get("add_date"))%>/<%=CommonDate.getFormatDate("MM",list.get(i).get("add_date"))%>/<%=CommonString.getFormatPara(list.get(i).get("html_filename"))%>" title="<%=CommonString.getFormatPara(list.get(i).get("title"))%>"><%=CommonString.getFormatPara(list.get(i).get("title"))%></a></li>
<%
	  }
	  %>
</cache:cache>