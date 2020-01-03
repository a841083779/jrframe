<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="GBK"%>
<%@page session="false" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String search = CommonString.getFormatPara(request.getParameter("search"));
    String sql = "select image,link,title from product_video where title like '%"+search+"%'";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{});
%>
<cache:cache  cron="* */7 * * *">
    <div class="np_videoval">
    	<ul class="list">
     <%
			if(list != null && list.size() > 0){
				for(Map m : list){		
     %>

			<li>
	          <a title="<%=CommonString.getFormatPara(m.get("title"))%>สำฦต" href="<%=CommonString.getFormatPara(m.get("link"))%>" target="_blank"><img alt="<%=CommonString.getFormatPara(m.get("title"))%>สำฦต" src="http://news.21-sun.com/UserFiles/Image/<%=CommonString.getFormatPara(m.get("image"))%>" width="160" height="90" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"><em class="playico"></em>
	          </a>
			  <h3 style="width:160px;overflow:hidden;"><a title="<%=CommonString.getFormatPara(m.get("title"))%>สำฦต" href="<%=CommonString.getFormatPara(m.get("link"))%>" target="_blank"><%=CommonString.getFormatPara(m.get("title"))%></a></h3>
	        </li>
    
	<%}}%>
      </ul>
    </div>   
</cache:cache>