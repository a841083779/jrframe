<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* */2 * * *">
<%
	String id = CommonString.getFormatPara(request.getParameter("id"));
	String sql = " select top 10 id,factoryname,product_name,cataname,mobile_phone,province,city,add_date from pro_product_form where is_deleted=0 and product_name is not null and product_name != '' and product_id = ? order by add_date desc,id desc ";
	List <Map>list = (List <Map>)DBHelper.getInstance().getMapList(sql,new Object[]{id});
%>
<div class="w755 border03 l mb10 list08">
  <ul class="ti">
    <li class="i1">编号</li>
    <li class="i2">询价产品</li>
    <li class="i3">联系人</li>
    <li class="i4">电话</li>
    <li class="i5">询价品牌</li>
    <li class="i6">询价区域</li>
    <li class="i7">询价时间</li>
  </ul>
  <div class="li">
  <%
     if(list != null && list.size() > 0){
  	for(int i = 0;i < list.size(); i++){
  %>
    <ul class="libg0<%=i%2+1%>">
      <li class="i1"><%=i+1%></li>
      <li class="i2"><a title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("product_name"))%><%=CommonString.getFormatPara(list.get(i).get("cataname"))%>" href="/inquiry/detail_for_<%=CommonString.getFormatPara(list.get(i).get("id"))%>.htm"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("product_name"))%><%=CommonString.getFormatPara(list.get(i).get("cataname"))%></a></li>
      <li class="i3"><%=CommonString.getFormatPara(list.get(i).get("name")).length()>=1?CommonString.getFormatPara(list.get(i).get("name")).substring(0,1)+"***":"***"%></li>
      <li class="i4"><%=CommonString.getFormatPara(list.get(i).get("mobile_phone")).length()>=3?CommonString.getFormatPara(list.get(i).get("mobile_phone")).substring(0,2)+"****":"****"%><%=CommonString.getFormatPara(list.get(i).get("mobile_phone")).length()>=7?CommonString.getFormatPara(list.get(i).get("mobile_phone")).substring(CommonString.getFormatPara(list.get(i).get("mobile_phone")).length()-2,CommonString.getFormatPara(list.get(i).get("mobile_phone")).length()):""%></li>
      <li class="i5"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%></li>
      <li class="i6"><%=CommonString.getFormatPara(list.get(i).get("province"))+CommonString.getFormatPara(list.get(i).get("city"))%></li>
      <li class="i7"><%=CommonString.getFormatPara(list.get(i).get("add_date")).length() >= 16?CommonString.getFormatPara(list.get(i).get("add_date")).substring(0,16):CommonString.getFormatPara(list.get(i).get("add_date"))%></li>
    </ul>
   <%
	}
     }else{
    	 %>
             <div align="center"><strong>暂无询价信息</strong></div>
    	 <%
     }
   %>
  </div>
  <!--翻页-->
  <!-- 
  <div class="w755 l">
    <div id="pagination" class="page"> <span> <a onclick="goToTop();" href="#" target="_self" class="goTop">返回顶部</a> </span> </div>
  </div>
   -->
  <!--翻页--> 
</div>
  </cache:cache>