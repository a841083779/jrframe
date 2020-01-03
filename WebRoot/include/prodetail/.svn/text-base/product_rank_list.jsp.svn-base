<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	if(catalog.length()>6){catalog=catalog.substring(0,6);}
    String sql = "select top 6 file_name,name,factoryname,catalogname,img2 from pro_products where  catalognum like '%"+catalog+"%'  order by view_count desc";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
<cache:cache  cron="*/1 * * * *">

     <%
			if(list != null && list.size() > 0){
				for(Map m : list){		
     %>
<li><a target='_blank' href='/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>' title='<%=CommonString.getFormatPara(m.get("factoryname"))+CommonString.getFormatPara(m.get("name"))+CommonString.getFormatPara(m.get("catalogname"))%>'>
   <img src='http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2"))%>'  width='80' height='70' alt='<%=CommonString.getFormatPara(m.get("factoryname"))+CommonString.getFormatPara(m.get("name"))+CommonString.getFormatPara(m.get("catalogname"))%>'  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width='80' height='70' /></a> 
	<h3><a target='_blank' href='/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>' title='<%=CommonString.getFormatPara(m.get("factoryname"))+CommonString.getFormatPara(m.get("name"))+CommonString.getFormatPara(m.get("catalogname"))%>'><%=CommonString.getFormatPara(m.get("factoryname"))+CommonString.getFormatPara(m.get("name"))+CommonString.getFormatPara(m.get("catalogname"))%></a>
	<span style='color:#999999'> </span></h3></li>
	<%}}%>
  
</cache:cache>