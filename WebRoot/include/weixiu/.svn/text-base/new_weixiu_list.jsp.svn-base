<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String factoryName = CommonString.getFormatPara(request.getParameter("factoryName"));
	String catalogName = CommonString.getFormatPara(request.getParameter("catalogName"));
	String whereStr=" where 1=1 ";
	if(!factoryName.equals("")){whereStr+=" and title like '%"+factoryName+"%'";}
	if(!catalogName.equals("")){whereStr+=" and title like '%"+catalogName+"%'";}
	String sql = " select top 10 title,id from pro_weixiu_info "+whereStr+" order by add_date desc ";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
<cache:cache  cron="*/1 * * * *">

     <%
			if(list != null && list.size() > 0){
			    String title="";
				for(Map m : list){	
                title=CommonString.getFormatPara(m.get("title"));
     %>
          <li><a title="<%=title%>" href="/info_<%=CommonString.getFormatPara(m.get("id"))%>.htm"><%=title%></a></li>  
	<%}}else{%>
        ÔÝÎÞÎ¬ÐÞÐÄµÃ
   <%}%>
</cache:cache>