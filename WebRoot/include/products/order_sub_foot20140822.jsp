<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="java.sql.Connection"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String whereStr = " 1=1 " ;
	if(!"".equals(catalog)){
		whereStr += " and catanum like '"+catalog+"%'" ;
	}
	if(!"".equals(factoryid)){
		whereStr += " and factoryid ='"+factoryid+"'" ;
	}
	String sql = " select top 10 id,province,city,name,factoryname,cataname,product_name,add_date from pro_product_form where "+whereStr+" order by add_date desc ";
	String cacheKey = "order_sub_foot_01"+catalog+factoryid;
	Connection conn = null ;
	DBHelper dbHelper = DBHelper.getInstance() ;
%>

<cache:cache cron="*/1 * * * *" key="<%=cacheKey%>">
<%	
try{
	conn = dbHelper.getConnection() ;
	List<Map> list = dbHelper.getMapList(sql,conn);
	if(list == null || list.size() <= 0){
%>
<p style="padding:0px 15px;">暂无符合条件的订单</p>
<%
	}else{
	  	for(int i = 0;list != null && i < list.size();i++){
	  %>
<li>
  <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_<%=CommonString.getFormatPara(list.get(i).get("id"))%>.htm" title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("product_name"))%><%=CommonString.getFormatPara(list.get(i).get("cataname"))%>询价单"><%=CommonString.getFormatPara(list.get(i).get("province"))%><%=CommonString.getFormatPara(list.get(i).get("city"))%>的 <%=CommonString.getFormatPara(list.get(i).get("name")).length()>=1?CommonString.getFormatPara(list.get(i).get("name")).substring(0,1):""%>** 用户询问了<font><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("product_name"))%><%=CommonString.getFormatPara(list.get(i).get("cataname"))%></font>的价格</a></div>
  <div class="t3"><%=CommonDate.getFormatDate("MM-dd",list.get(i).get("add_date"))%></div>
</li>
<%
		}
	}
}catch(Exception e){
	e.printStackTrace() ;
}finally{
	DBHelper.freeConnection(conn) ;
}
	  %>
</cache:cache>