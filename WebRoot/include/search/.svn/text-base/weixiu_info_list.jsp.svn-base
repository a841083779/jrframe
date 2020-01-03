<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String sql = " select top 10 id,title,add_date from pro_weixiu_info where is_show=1  order by id desc ";
%>
<cache:cache cron="* * */1 * *">
  <div class="rp clearfix mb10 nwx_zxlist repairList border05  mt10">
    <div class="title" style="border-right:1px solid #ccc;border-bottom:1px solid #ccc;">
      <h3 style="color:#000;">维修知识</h3>
    </div>
    <div class="content r_add" style=" padding:10px;">
      <ul class="list blue">
<%
       List<Map> list = dbHelper.getMapList(sql);
	  	if(list != null && list.size() > 0){
	         for(Map m : list){	
	  %>
        <li style="width:50%; margin-bottom:10px;">
          <h3 style="width:360px;"> 
		  <span class="lb"> <a href="http://weixiu.21-sun.com/knowledge/" title="维修" style="color: #ff6600">[维修]</a> </span> 
		  <a target="_blank" href="http://weixiu.21-sun.com/info_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("title"))%>">
		  <%=CommonString.getFormatPara(m.get("title"))%></a></h3>
          <span class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd",CommonString.getFormatPara(m.get("add_date")))%></span> 
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
  </div>






     

