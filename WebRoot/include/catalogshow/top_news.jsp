<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.regex.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */1 * *">
<%
	String catalogname = CommonString.getFormatPara(request.getParameter("catalogname")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
	List<Map> newsPicList = null;
	List<Map> newsRecList = null;
	List<Map> newsNewList = null;
	PageBean pageBean = new PageBean();
	DBHelper dbHelper = DBHelper.getInstance();
	try{

     
	String sql_newsPicList="select top 4 id,title,pub_date,content,image from article where is_pub=1 and image<>'' and title like '%"+catalogname+"%' order by pub_date desc";
	String sql_newsRecList="select top 4 id,title,pub_date,content,image from article where is_pub=1 and title like '%"+catalogname+"%' and title like '%活动%' order by pub_date desc";
	String sql_newsNewList="select top 9 id,title,pub_date,content,image from article where is_pub=1 and title like '%"+catalogname+"%' and (link_other='' or link_other is null)  order by pub_date desc";

    newsPicList=WEBDBHelper.getMapList(sql_newsPicList,"Web21sunDBHelper") ;
	newsRecList=WEBDBHelper.getMapList(sql_newsRecList,"Web21sunDBHelper") ;
    newsNewList=WEBDBHelper.getMapList(sql_newsNewList,"Web21sunDBHelper") ;	


%>
	<div class="p_1_1">
      <div class="p_slide">
        <div class="bd">
          <ul>
		  <%
		   	if (null != newsPicList && newsPicList.size() > 0) {
			    for (Map oneMap : newsPicList) {
		  %>
            <li><a title="<%=CommonString.getFormatPara(oneMap.get("title"))%>" target="_blank" href="/detail_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm"><img src="http://news.21-sun.com/UserFiles/Image/<%=CommonString.getFormatPara(oneMap.get("image"))%>" width="328" height="240" /><strong><%=CommonString.getFormatPara(oneMap.get("title"))%></strong></a></li>
          <%}}%>
          </ul>
        </div>
        <div class="hd">
          <ul></ul>
        </div>
      </div>
      <div class="p_act_box">
        <ul>
		  <%
		  	if (null != newsRecList && newsRecList.size() > 0) {
			    for (Map oneMap : newsRecList) {
		  %>
          <li><span class="p_tag">[活动]</span><a title="<%=CommonString.getFormatPara(oneMap.get("title"))%>" target="_blank" href="/detail_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm"><%=CommonString.getFormatPara(oneMap.get("title"))%></a></li>
         <%}}%>
        </ul>
      </div>
    </div>
    <div class="p_1_2">
	
      <div class="p_topNews">
	  	<%  
		    int topNews=1;
			if (null != newsNewList && newsNewList.size() > 0) {
			    for (Map oneMap : newsNewList) {
				if(topNews==1){
				String content=CommonString.getFormatPara(oneMap.get("content"));
				content=CommonHtml.filterHTML(content);
				if(content.length()>70){content=content.substring(0,70)+"...";}
		%>
        <a target="_blank" href="/detail_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" title="<%=CommonString.getFormatPara(oneMap.get("title"))%>"><h2><%=CommonString.getFormatPara(oneMap.get("title")).length()>16?CommonString.getFormatPara(oneMap.get("title")).substring(0,16)+"...":CommonString.getFormatPara(oneMap.get("title"))%></h2>
          <p class="text"><%=content%></p></a>
		<%}topNews++;}}%>
      </div>
	  
      <ul class="p_newsList fix">
	  	<% 
     		int otherNews=1;
		  	if (null != newsNewList && newsNewList.size() > 0) {
			    for (Map oneMap : newsNewList) {
				if(otherNews!=1){
				String title=CommonString.getFormatPara(oneMap.get("title"));
				//if(title.length()>20){title=title.substring(0,20)+"...";}
		%>
        <li><h3 style="width: 250px;"><a title="<%=title%>" target="_blank" href="/detail_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm"><%=title%></a></h3><span class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd",CommonString.getFormatPara(oneMap.get("pub_date")))%></span></li>
		<%}otherNews++;}}%>
      </ul>
    </div>

<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
	
	}
%>
</cache:cache>