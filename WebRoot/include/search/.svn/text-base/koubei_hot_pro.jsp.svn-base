<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="utf-8"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="*/1 * * * *">
<%
	String sql = " select top 4 id,img2,add_date,factoryname,catalogname,name,file_name,price_start,price_end from pro_products where is_show=1  and view_count>7000  and img2 is not null and img2 != '' order by newid()   ";

	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>

		 <%
			String linkTo="";
			if(list != null && list.size() > 0){
				for(Map m : list){
		%>
		

		
		  <li><a href="http://koubei.21-sun.com/list/<%=CommonString.getFormatPara(m.get("id")) %>.htm" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>">
		  <img title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" alt="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>"  onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"  width="90" height="50" />
            <h4> <%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %></h4>
         </a></li>
			
	
			
       <%}}%>
 
	  </cache:cache>  
	  

 