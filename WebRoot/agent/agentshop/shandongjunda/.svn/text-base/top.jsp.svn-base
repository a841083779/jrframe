<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	// 徐工特机 品牌 id  1522
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = " select catalogname,num from pro_factory_category where factoryid=1220 order by num" ;
	List<Map> navCataList = dbHelper.getMapList(sel_sql) ;
%>
<div class="shop_topbg">
  <div class="contain980">
    <h2><img src="images/new_shop_logos.jpg" alt="山东骏大" width="373" height="80" />山东骏大官方旗舰店</h2>
    <div class="shop_tel">
      客服热线：<em>400-6186-777</em>
    </div>
    <div class="clear"></div>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/new_shop_bm.png" alt="收藏本店铺" width="117" height="40" /></a></div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li style="background:none;"><a href="./" class="selected">首 页HOME</a></li>
      <li><a href="#hot_rec">热销推荐HOT</a></li>
      <li><a href="#excavator">挖掘机EXCAVATOR</a></li>
      <!--
      <%
      	if(null!=navCataList && navCataList.size()>0){
      		for(Map oneMap:navCataList){
      			%>
      			  <li><a href=#<%=CommonString.getFormatPara(oneMap.get("num")) %>><%= CommonString.getFormatPara(oneMap.get("catalogname"))%></a></li>
      			<%
      		}
      	}
      %>-->
    </ul>
  </div>
</div>
