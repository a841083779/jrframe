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

       	<div class="nph_val mb10">
        	<div class="nph_title">产品类别</div>
			     <ul class="nph_list">
    	<%
    		List<Map> sub_catalogs = null;
    		for(Map m : catalogs){
    			sub_catalogs = dbHelper.getMapList(" select id,name,num from pro_catalog where len(num) = 6 and num like '"+m.get("num")+"%' ",connection);
    			%><li class="cur"><a href="#"><%=m.get("name") %></a>
    				<%
    					if(null!=sub_catalogs&&sub_catalogs.size()>0){
    						%><ul><%
    						for(Map m1 : sub_catalogs){	      	
    							%><li><a href="#"><%=m1.get("name") %></a></li><%
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
