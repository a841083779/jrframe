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
    <h2><img src="images/new_shop_logos.gif" alt="江苏华通动力重工旗舰店" width="434" height="102" /></h2>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/new_shop_bm.gif" alt="收藏本店铺" width="149" height="35" /></a></div>
    <div class="shop_tel">江苏华通动力客服热线：400-660-2278<br />
      销售热线：0511-84423116　84420569</div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li><a href="./" class="selected">首页</a></li>
      <%
      	if(null!=navCataList && navCataList.size()>0){
      		for(Map oneMap:navCataList){
      			%>
      			  <li><a href=#<%=CommonString.getFormatPara(oneMap.get("num")) %>><%= CommonString.getFormatPara(oneMap.get("catalogname"))%></a></li>
      			<%
      		}
      	}
      %>
    </ul>
  </div>
</div>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>