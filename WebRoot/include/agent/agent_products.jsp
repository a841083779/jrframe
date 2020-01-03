<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String usern = CommonString.getFormatPara(request.getParameter("usern"));
		String agentid = CommonString.getFormatPara(request.getParameter("agentid"));
		Map agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {agentid},connection);
		if(!"".equals(CommonString.getFormatPara(agentMap.get("parent_id")))&&!"0".equals(CommonString.getFormatPara(agentMap.get("parent_id")))){
			agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {CommonString.getFormatPara(agentMap.get("parent_id"))},connection);
			agentid = CommonString.getFormatPara(agentMap.get("id"));
		}
		String sql = " select top 20 id,img2,file_name,factoryid,factoryname,file_name,name,place,catalognum,catalogname,price_start,price_end from pro_agent_product_vi where agentid = ? and is_show = 1 ";
		List<Map> list = dbHelper.getMapList(sql,new Object[]{agentid},connection);
		Map brandUsernMap = (Map)application.getAttribute("brandUsernMap");
%><div class="w695 border03 l mb10 agentPro">
  <div class="title13">
    <h2>代理产品</h2>
    <span style="float:right; line-height:29px; padding-right:8px; font-family:宋体"><a href="/agent/<%=usern%>/agent_products.shtm">更多>></a></span>
  </div>
  <%
  	if(list != null && list.size() > 0){
  %>
  <ul class="ti">
    <li class="a6" style="width:124px;">图片</li>
    <li class="a7" style="width:93px;">品牌</li>
    <li class="a8">机型</li>
    <li class="a9" style="width:99px;">类别</li>
	<li class="a9" style="width:103px;">品类</li>
    <li class="a10">询价</li>
  </ul>
  <%
	}
  %>
  <div class="li">
	  <%
	  	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
			String pl=CommonString.getFormatPara(list.get(i).get("factoryname"))+CommonString.getFormatPara(list.get(i).get("catalogname"));
			if(pl.length()>6)
			{
			  pl=pl.substring(0,6)+"...";
			}
	  %>
        <ul>
          <li class="a6" style="width:119px;"><a href="/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(list.get(i).get("img2"))%>" width="70" height="50" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" /></a></li>
          <li class="a7" style="width:93px;"><a href="/brand/<%=brandUsernMap.get(CommonString.getFormatPara(list.get(i).get("factoryid")))%>/" target="_blank"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%></a></li>
          <li class="a8">
		   <a target="_blank" href="/inquiry/index.jsp?proId=<%=CommonString.getFormatPara(list.get(i).get("id"))%>&proName=<%=CommonString.getFormatPara(list.get(i).get("name"))%>"><%=CommonString.getFormatPara(list.get(i).get("name"))%>价格</a></li>
          <li class="a9" style="width:99px;"><a target="_blank" href="/products/prolist.jsp?catalog=<%=CommonString.getFormatPara(list.get(i).get("catalognum"))%>"><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%></a></li>
          <li class="a9" style="width:103px;"><a title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>" target="_blank" style="color:#fe6000" href="/products/prolist.jsp?factory=<%=CommonString.getFormatPara(list.get(i).get("factoryid"))%>&catalog=<%=CommonString.getFormatPara(list.get(i).get("catalognum"))%>"><%=pl%></a></li>  
		 <li class="a10"><a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(list.get(i).get("id")) %>','<%=CommonString.getFormatPara(list.get(i).get("factoryid"))%>')"  class="plbtn">询价</a></li>
        </ul>
      <%
			}
		}else{
	  %> 
      	<span class="textStyle">暂无信息</span>
      <%}%>
  </div>
</div>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>