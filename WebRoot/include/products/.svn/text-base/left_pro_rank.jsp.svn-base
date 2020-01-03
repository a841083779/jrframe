<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%   
	String id = CommonString.getFormatPara(request.getParameter("id"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String sql = " select top 15 file_name,name,factoryname,catalogname,img2,view_count,factoryid from pro_products where catalognum like '"+catalog+"%' and is_show = 1 order by view_count desc ";
	System.out.println(sql);
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
	int i=0;
	String factoryIds="";
%>
	<cache:cache  cron="* * */1 * *">
        <%
			if(list != null && list.size() > 0){
				for(Map m : list){
				if(i<4&&factoryIds.indexOf(CommonString.getFormatPara(m.get("factoryid")))==-1){
		%>
<li>
  <a target="_blank" title='<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>' href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>"><img src="/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")).toLowerCase()%>" width="80" height="70" alt="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a>
  <h3><a title='<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>' target="_blank" href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%></a><span style="color:#999999"> (<%=CommonString.getFormatPara(m.get("view_count"))%>)</span></h3>
</li>
        <%
		 i++;
		 factoryIds+=CommonString.getFormatPara(m.get("factoryid"))+",";
		}
		}}%>
  </cache:cache>