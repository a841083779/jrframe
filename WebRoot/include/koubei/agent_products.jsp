<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="GBK"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
		String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
		String sql = " select top 10 id,img2,file_name,factoryid,factoryname,name,place,catalognum,catalogname from pro_products where factoryid = "+factoryid+" and catalognum like '"+catalog+"%' and is_show = 1 order by view_count desc ";
		String cacheKey = "koubei_product_"+catalog+factoryid;
%>
<cache:cache cron="* * */5 * *" key="<%=cacheKey%>">
<%
	List<Map> list = dbHelper.getMapList(sql,connection);
	  	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
	  			String file_name = CommonString.getFormatPara(list.get(i).get("file_name"));
	  			String factoryname = CommonString.getFormatPara(list.get(i).get("factoryname"));
	  			String name = CommonString.getFormatPara(list.get(i).get("name"));
	  			String catalogname = CommonString.getFormatPara(list.get(i).get("catalogname"));
				String catalognum = CommonString.getFormatPara(list.get(i).get("catalognum"));
				String factoryids = CommonString.getFormatPara(list.get(i).get("factoryid"));
	  %>
	  
	   <li class="top3">
          <h4><a target="_blank" href="/list/<%=CommonString.getFormatPara(list.get(i).get("id"))%>.htm" title="<%=factoryname %><%=name %><%=catalogname %>¿Ú±®"><%=factoryname %><%=name %><%=catalogname %>¿Ú±®</a></h4>
        </li>
      <%}} %> 
</cache:cache>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>