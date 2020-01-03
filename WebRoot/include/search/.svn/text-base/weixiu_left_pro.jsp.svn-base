<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String sql = " select top 6 id,img2,add_date,factoryname,catalogname,name,file_name,price_start,price_end from pro_products where is_show=1  and img2 is not null and img2 != '' order by view_count desc ";
%>
<cache:cache cron="* * */1 * *">
    <div class="Similar nse_left_viewpro Sborder">
      <div class="stitle">
        <h3>热门产品维修</h3>
      </div>
      <div class="scontent">
        <ul class="slist" id="history">
<%
       List<Map> list = dbHelper.getMapList(sql);
	  	if(list != null && list.size() > 0){
	         for(Map m : list){	


	  %>	  
			 <li><a href="http://weixiu.21-sun.com/pro_<%=CommonString.getFormatPara(m.get("id")) %>.htm" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>">
			 <img title="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" alt="<%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> <%=CommonString.getFormatPara(m.get("factoryname")) %><%=CommonString.getFormatPara(m.get("name")) %><%=CommonString.getFormatPara(m.get("catalogname")) %></h4>
            </a></li>
	<%}}%> 
</cache:cache>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
      </ul>
      </div>
 </div>

