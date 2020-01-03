<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="* * */3 * *">
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> inquiryList= null ;
	String catalogname = CommonString.getFormatPara(request.getParameter("catalogname")) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;
	inquiryList = dbHelper.getMapList("select top 4 id,province,city,add_date,name,product_name,cataname,factoryname from pro_product_form where is_deleted=0  and catanum like '"+catalognum+"%' order by id desc") ;
%>
    <%
        if(null != inquiryList && inquiryList.size()>0){
	%>
  <div class="p_2_2">
    <div class="comBox01 mb10">
      <div class="hd fix">
        <h3><%=catalogname%>最新询价单</h3>
        <span class="more"><a target="_blank" href="http://product.21-sun.com/inquiry/0_0_0_<%=catalognum%>_0.shtm" title="更多<%=catalogname%>询价单">更多</a></span>
      </div>
      <div class="bd fix">
        <ul>
	<%      
        	for(Map oneMap:inquiryList){
           String fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("product_name"))+CommonString.getFormatPara(oneMap.get("cataname"));
		   if(fullName.length()>10){
		   fullName=fullName.substring(0,10)+"...";
		   }
			
    %>
          <li> <span class="ltitle"><%=CommonString.getFormatPara(oneMap.get("province"))%><%=CommonString.getFormatPara(oneMap.get("city"))%>的<%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %>：</span> <span class="r"><%=CommonDate.getFormatDate("yyyy-MM-dd",CommonString.getFormatPara(oneMap.get("add_date")))%></span> <span class="linfo"> <a href="http://product.21-sun.com/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" target="_blank"><font title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%>询问<%=CommonString.getFormatPara(oneMap.get("product_name"))%><%=CommonString.getFormatPara(oneMap.get("cataname"))%>"><%=fullName%></font>的价格</a></span> </li>

      <%}%>
        </ul>
      </div>
    </div>
  </div> 
	<%}%>
</cache:cache>

       
