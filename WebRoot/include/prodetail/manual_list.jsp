<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
    String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String whereStr=" is_show=1 and manual!='' and manual is not null";
	if(!factory.equals("")){whereStr+=" and factoryid="+factory;}
	if(!catalog.equals("")){whereStr+=" and catalognum like '"+catalog+"%'";}
	whereStr+=" order by view_count desc";
    String sql = "select top 10 name,catalogname,factoryname,manual,file_name from pro_products where"+whereStr;
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
<cache:cache  cron="* * */7 * *">
     <%
			if(list != null && list.size() > 0){
				for(Map m : list){		
     %>
	  <ul  class="libg02">
          <li class="g1" style="width:465px;"><a title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>产品手册" href="/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).replace(".shtm","")%>_manual.shtm" target="_blank"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>产品手册</a></li>
	      <li class="g10" style="overflow:hidden;"><a style="background:url(../images/down.png) no-repeat 0 -22px" href="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("manual"))%>" target="_blank">在线浏览产品手册</a></li>
	      <li class="g10" style="overflow:hidden;"><a href="javascript:void(0);" onclick="javascript:down('/uploadfiles/<%=CommonString.getFormatPara(m.get("manual"))%>','<%=CommonString.getFormatPara(m.get("name"))%>')">点击下载产品手册</a></li>     
	 </ul>
	<%}}else{%>
       <ul align="center">暂无其他产品手册</ul>
    <%}%>
</cache:cache>