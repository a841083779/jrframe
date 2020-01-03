<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="gbk"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* * */7 * *">
<%
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
	String sql = " select top 10 id,img2,add_date,factoryname,catalogname,name,file_name,price_start,price_end from pro_products where is_show=1  and img2 is not null and img2 != '' order by view_count desc ";

	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
	<ul class="np_fix">
		 <%
			String linkTo="";
			if(list != null && list.size() > 0){
				for(Map m : list){
		%>
		
		<li> <a href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name")) %>" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" target="_blank"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>" width="130" height="90" alt="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>"></a>
          <div class="tlt"> <p class="sn_pname"><a title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %></a></p>
            <b>参考价：</b> <font>
			<%if(CommonString.getFormatPara(m.get("price_start")).equals("0")||CommonString.getFormatPara(m.get("price_end")).equals("0")){%>
			 面议
			<%}else{%>
			<%=CommonString.getFormatPara(m.get("price_start")) %>-<%=CommonString.getFormatPara(m.get("price_end")) %>万
			<%}%>
			</font><br>
            <span class="blink"> 【<a title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>参数" href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).replace(".shtm","")%>_parameter.shtm" target="_blank">参数</a>】【<a title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>评论" href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).replace(".shtm","")%>_message.shtm" target="_blank">评论</a>】【<a title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>询价" href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).replace(".shtm","")%>_order.shtm" target="_blank"><font color="#ff6000">询价</font></a>】 </span></div>
        </li>	
			
       <%}}%>
    </ul>
	  </cache:cache>  
	  

 