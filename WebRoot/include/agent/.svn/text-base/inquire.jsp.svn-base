<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%	
	String agentid = CommonString.getFormatPara(request.getParameter("agentid"));
	String sql = " select top 7 id,factoryname,cataname,product_name,add_date,name,mobile_phone,province,city from pro_product_form where agentid = ? and product_id is not null and product_id != ''  order by add_date desc ";
	List<Map> list = DBHelper.getInstance().getMapList(sql,new Object[]{agentid});
%>
<%
	if(list != null && list.size() > 0){
%>
<div class="w100 l h10px whitebg"></div>
<div class="sLeftPart">
  <div class="sTitle">
    <h2>在线询价</h2>
  </div>
  <div class="sContent">
    <ul class="xjlist">
    <%for(int i = 0;list != null && i < list.size();i++){%>
      <li> <span class="ltitle"><%=CommonString.getFormatPara(list.get(i).get("province"))%><%=CommonString.getFormatPara(list.get(i).get("city"))%>的 <%=CommonString.getFormatPara(list.get(i).get("name")).length()>=1?CommonString.getFormatPara(list.get(i).get("name")).substring(0,1):""%>** 询：</span> <span class="r"><%=CommonDate.getFormatDate("MM-dd",CommonString.getFormatPara(list.get(i).get("add_date")))%></span> <span class="linfo"> <a href="/inquiry/detail_for_<%=CommonString.getFormatPara(list.get(i).get("id"))%>.htm" target="_blank"><font title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("product_name"))%><%=CommonString.getFormatPara(list.get(i).get("cataname"))%>"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("product_name"))%><%=CommonString.getFormatPara(list.get(i).get("cataname"))%></font>的价格</a></span> </li>
    <%}%>
    </ul>
  </div>
</div>
<%}%>