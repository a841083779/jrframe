<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="gbk"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
	String sql = " select top 8 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where factoryid="+factoryid+"and catalognum like '%"+catalognum+"%' and img2 is not null and img2 != '' order by view_count desc  ";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
	<cache:cache  cron="* */7 * * *">
    <div class="np_piclist np_fix l">
    <ul class="list12 np_fix">
        <%
			if(list != null && list.size() > 0){
				for(Map m : list){
		%>
		
        <li>
            <div class="photo"><a target="_blank" href="http://photo.21-sun.com/detail_for_<%=CommonString.getFormatPara(m.get("id")) %>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>图片"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>"></a></div>
            <h3><a target="_blank" href="http://photo.21-sun.com/detail_for_<%=CommonString.getFormatPara(m.get("id")) %>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>图片"><%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %></a></h3>
            <span class="blink"> 
			【<a href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname"))%>参数">参数</a>】【<a href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).replace(".shtm","") %>_message.shtm" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname")) %>口碑">口碑</a>】【<a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(m.get("id"))%>','')"><font color="#ff6000">询价</font></a>】 
			</span>
	    </li>
		
        <%}}%>
            </ul>
    </div>
	  </cache:cache>