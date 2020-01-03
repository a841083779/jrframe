<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.webservice.WEBDBHelper"%>
<%  
    String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
	List<Map> getNewsList  = WEBDBHelper.getMapList("select top 5 title,CONVERT(varchar(100),add_date, 23) as add_date,html_filename from article where is_pub=1 and title like '%"+factoryname+"%' ","Web21sunDBHelper");
%>




        <div class="txd_plant fix">
          <div class="tpl_title">行业口碑</div>
          <a href="http://sowa.21-sun.com/?q=<%=factoryname%>&f=news" class="tpl_more" target="_blank">查看更多</a> </div>
        <div class="hy_kb_list">
          <ul>
        <%
	        if(getNewsList!=null&&getNewsList.size()>0){
		    for(Map oneMap:getNewsList){
	    %>
            <li><a target="_blank" href="http://news.21-sun.com/detail/<%=CommonString.getFormatPara(oneMap.get("html_filename")).substring(0,4)%>/<%=CommonString.getFormatPara(oneMap.get("html_filename")).substring(4,6)%>/<%=CommonString.getFormatPara(oneMap.get("html_filename"))%>" title="<%=CommonString.getFormatPara(oneMap.get("title"))%>"><%=CommonString.getFormatPara(oneMap.get("title"))%></a></li>
    	<%}}%>
          </ul>
        </div>
		


