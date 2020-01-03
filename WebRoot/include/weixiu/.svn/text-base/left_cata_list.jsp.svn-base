<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String cataNum = CommonString.getFormatPara(request.getParameter("cataNum"));
		String area = CommonString.getFormatPara(request.getParameter("area"));
	    String areaName = CommonString.getFormatPara(request.getParameter("areaName"));
		String whereStr="";
        String sql="select name,num from pro_catalog where num like '"+cataNum+"%' and LEN(num)=6";
        Map catalogMap = (Map) application.getAttribute("catalogMap");
		String  cataName=CommonString.getFormatPara(catalogMap.get(cataNum));
%>
<cache:cache cron="* * */1 * *">
    <div class="rp clearfix mb10 cate">
      <div class="title">
        <h3>热门<%=cataName%>产品维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
		<%
		    List<Map> list = dbHelper.getMapList(sql,connection);
	       	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
	  			String catalognum =CommonString.getFormatPara(list.get(i).get("num"));
				String catalogName=CommonString.getFormatPara(list.get(i).get("name"));
		%>
				<li><a target="_blank" title="<%=catalogName%>维修" href="/<%=catalognum%>-0-0.htm"><%=catalogName%></a></li>
		<%}}%>
        </ul>
      </div>
    </div>
</cache:cache>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>