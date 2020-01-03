<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%

	String sql = " select top 6 title,add_date,id,username from pro_weixiu_info  order by add_date desc ";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
<cache:cache  cron="*/1 * * * *">

     <%
			if(list != null && list.size() > 0){
			    String content="";
				for(Map m : list){	
                content=CommonString.getFormatPara(m.get("title"));
                if(content.length()>10){content=content.substring(0,10)+"...";}			
     %>
          <li><a  href="/info_<%=CommonString.getFormatPara(m.get("id"))%>.htm"><%=content%></a><span class="date"><%=CommonString.getFormatPara(m.get("username")).equals("front")?"铁臂商城用户":CommonString.getFormatPara(m.get("username"))%>&nbsp;&nbsp;<%=CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(m.get("add_date")))%></span></li>  
	<%}}else{%>
        暂无维修心得
   <%}%>
</cache:cache>