<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
        if(catalog.length()>3){catalog=catalog.substring(0,3);}
        Map catalogMap = (Map) application.getAttribute("catalogMap");
		String pName=CommonString.getFormatPara(catalogMap.get(catalog));
%>
<cache:cache cron="* * */14 * *">
	<div class="mb10 nkb_zyyw border02 l w208 nkb_proxf">
    	<div class="nkb_zyyw_title"><h2><%=pName%>产品细分</h2></div>
        <ul class="nkb_zyyw_list np_fix">
<%
       List<Map> list = dbHelper.getMapList("select name,num from pro_catalog where num like '"+catalog+"%' and LEN(num)=6");
	  	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
	  			String catalognum =CommonString.getFormatPara(list.get(i).get("num"));
				String catalogName =CommonString.getFormatPara(list.get(i).get("name"));
				
	  %><li><a href="/products/prolist.jsp?catalog=<%=catalognum%>" target="_blank" title="<%=catalogName%>"><%=catalogName%></a></li>
      <%
			}
		}
	  %> 
	          </ul>
    </div>
</cache:cache>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>