<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
		String area = CommonString.getFormatPara(request.getParameter("area"));
	    String areaName = CommonString.getFormatPara(request.getParameter("areaName"));
		Map catalogMap = (Map) application.getAttribute("catalogMap");
		String catalogName=CommonString.getFormatPara(catalogMap.get(catalog));
		String whereStr="";
		if(!catalog.equals("")){whereStr+="and id in (select distinct factoryid from pro_products where catalognum like '"+catalog+"%' )";}
	    String sql = "select  top 30 id,name from pro_agent_factory where is_show=1 and flag=1"+whereStr+" order by view_count desc";
%>
<cache:cache cron="* * */1 * *">
    <div class="rp clearfix mb10 area">
      <div class="title">
        <h3><%=areaName+catalogName%>热门品牌维修网点</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
		<%
	        List<Map> list = dbHelper.getMapList(sql,connection);
	  	    if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
	  			String id = CommonString.getFormatPara(list.get(i).get("id"));
	  			String factoryname = CommonString.getFormatPara(list.get(i).get("name"));
	  %>
            <li><a target="_blank" title="<%=factoryname%>维修网点" href="/0-0-<%=id%>-0.htm"><%=factoryname%></a></li>
      <% } }  %> 
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