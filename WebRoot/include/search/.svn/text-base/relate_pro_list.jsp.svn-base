<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="gbk"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* * */7 * *">
<%
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
	String sql = " select top 5 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where is_show=1  and img2 is not null and img2 != '' order by newid()  ";

	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
	<ul class="np_fix">
		 <%
			if(list != null && list.size() > 0){
				for(Map m : list){
		%>
		
		   <li>
            	<a href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name")) %>" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" target="_blank">
            	<p><img height="127" width="172" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>" alt="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>"/></p>
                <p class="nselike_name"><%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %></p>
                </a>
            </li>		
       <%}}%>
    </ul>
	  </cache:cache>  
	  

 