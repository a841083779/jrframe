<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */14 * *">
<%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String sql ="";
		String usern = CommonString.getFormatPara(request.getParameter("usern"));
		String flag = CommonString.getFormatPara(request.getParameter("flag"));
		String agentid = CommonString.getFormatPara(request.getParameter("agentid"));
		Map agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {agentid},connection);
		if(!"".equals(CommonString.getFormatPara(agentMap.get("parent_id")))&&!"0".equals(CommonString.getFormatPara(agentMap.get("parent_id")))){
			agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {CommonString.getFormatPara(agentMap.get("parent_id"))},connection);
			agentid = CommonString.getFormatPara(agentMap.get("id"));
		}
		if(flag.equals("top")){
		sql = " select top 4 id,img2,file_name,factoryid,factoryname,file_name,name,place,catalognum,catalogname,price_start,price_end from pro_agent_product_vi where agentid = ? and is_show = 1 order by id desc";  //v
		}else if(flag.equals("special")){
		sql = " select top 5 id,img2,file_name,factoryid,factoryname,file_name,name,place,catalognum,catalogname,price_start,price_end from pro_agent_product_vi where agentid = ? and is_show = 1 order by id desc";   //v
        }else{
		sql = " select top 8 id,img2,file_name,factoryid,factoryname,file_name,name,place,catalognum,catalogname,price_start,price_end from pro_agent_product_vi where agentid = ? and is_show = 1 order by id desc";
		}
		List<Map> list = dbHelper.getMapList(sql,new Object[]{agentid},connection);
		Map brandUsernMap = (Map)application.getAttribute("brandUsernMap");
%>
	  <%
	  	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
			String pl=CommonString.getFormatPara(list.get(i).get("factoryname"))+CommonString.getFormatPara(list.get(i).get("catalogname"));
			if(pl.length()>6)
			{
			  pl=pl.substring(0,6)+"...";
			}
	  %>
	  
     <li><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>" title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>">
	 <img width="150" height="115" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(list.get(i).get("img2"))%>" alt="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>" ><strong><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%></strong></a></li>
      <%
			}
		}else{
	  %> 
      	<span class="textStyle">暂无信息</span>
      <%}%>

<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
</cache:cache>