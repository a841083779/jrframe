<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String sql = " select top 48 id,factoryname,cataname,product_name,add_date,name,mobile_phone from pro_product_form order by id desc ";
	List <Map>list = DBHelper.getInstance().getMapList(sql);
%>
<ul>
<%
	for(int i = 0;list != null && i < list.size();i++){
%>
  <li>
    <div class="t2"><a target="_blank" href="/inquiry/detail_for_<%=CommonString.getFormatPara(list.get(i).get("id"))%>.htm"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("product_name"))%><%=CommonString.getFormatPara(list.get(i).get("cataname"))%></a></div>
    <div class="t3"><%=CommonDate.getFormatDate("MM月dd日",list.get(i).get("add_date"))%></div>
    <div class="t4"><%=CommonString.getFormatPara(list.get(i).get("name")).length()>=1?CommonString.getFormatPara(list.get(i).get("name")).substring(0,1)+"***":CommonString.getFormatPara(list.get(i).get("name"))%></div>
    <div class="t5"><%=CommonString.getFormatPara(list.get(i).get("mobile_phone")).length()>=4?CommonString.getFormatPara(list.get(i).get("mobile_phone")).substring(0,3):CommonString.getFormatPara(list.get(i).get("mobile_phone"))%>******<%=CommonString.getFormatPara(list.get(i).get("mobile_phone")).length()>=4?CommonString.getFormatPara(list.get(i).get("mobile_phone")).substring(CommonString.getFormatPara(list.get(i).get("mobile_phone")).length()-4):CommonString.getFormatPara(list.get(i).get("mobile_phone"))%></div>
  </li>
<%
	}
%>  
</ul>
