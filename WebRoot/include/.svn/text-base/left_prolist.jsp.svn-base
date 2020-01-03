<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*" pageEncoding="UTF-8"%><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache" %><%
	String factoryid  = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String url = CommonString.getFormatPara(request.getParameter("url")) ;
	String urlOne = CommonString.getFormatPara(request.getParameter("url")) ;
	String cacheKey = "left"+factoryid+catalognum+url;
	%>
	<cache:cache  cron="*/1 * * * *">
	<%
    DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
		try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
	    List<Map> catalogs = dbHelper.getMapList(" select id,name,num from pro_catalog where len(num) = 3 ",connection);
%>

<div class="w208 border01 l leftPart mb10" id="agent_tab02" style=" height:487px;*height:453px; overflow-x:hidden;overflow-y: scroll;">
     <ul>
    	<%
    		List<Map> sub_catalogs = null;
    		for(Map m : catalogs){
    			sub_catalogs = dbHelper.getMapList(" select id,name,num from pro_catalog where len(num) = 6 and num like '"+m.get("num")+"%' ",connection);
    			%><li><h3 class="agent_tab_name"><%=m.get("name") %></h3>
    				<%
    					if(null!=sub_catalogs&&sub_catalogs.size()>0){
    						%><ul><%
    						for(Map m1 : sub_catalogs){	      	
    							%><li><a href="?catalog=<%=m1.get("num") %>"><%=m1.get("name") %></a></li><%
    						}
    						%></ul><%
    					}
    				%>
    			</li><%
    		}
    	%>
    </ul>
</div>
<%
	connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>
</cache:cache>
