<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String sql = " select top 6 id,title from pro_weixiu_info where is_show=1 order by id desc ";
%>
<cache:cache cron="* * */1 * *">
    <div class="w208 border02 l leftPart02 mb10 np_addpcat Similar nse_left_viewpro">
      <div class="stitle Sborder">
        <h3>热门维修知识</h3>
      </div>
      <ul class="list003" id="brandProductList">
<%
       List<Map> list = dbHelper.getMapList(sql);
	  	if(list != null && list.size() > 0){
			         for(Map m : list){	
	  %>
	 <li class="top3">
          <h4> <a title="<%=CommonString.getFormatPara(m.get("title")) %>" target="_blank" href="http://weixiu.21-sun.com/info_<%=CommonString.getFormatPara(m.get("id")) %>.htm"> <%=CommonString.getFormatPara(m.get("title")) %></a></h4>
      </li>  
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


    

