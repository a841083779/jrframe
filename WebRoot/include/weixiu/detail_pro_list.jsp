<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%  
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String whereStr="where is_show=1 ";
	if(!catalog.equals("")&&!catalog.equals("0")){whereStr+=" and catalognum like '"+catalog+"%'"; }
	if(!factory.equals("")&&!factory.equals("0")){whereStr+=" and factoryid ="+factory; }
	String sql = " select top 8 id,factoryname,name,catalogname,id from pro_products "+whereStr+"  order by view_count desc ";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
<cache:cache  cron="* * */12 * *">
     <%
			if(list != null && list.size() > 0){
			    String content="";
				for(Map m : list){		
     %> 
	             <li><a target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" href="/pro_<%=CommonString.getFormatPara(m.get("id"))%>.htm"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%></a></li>		
	<%}}else{%>
        ÔÝÎÞ
   <%}%>
</cache:cache>