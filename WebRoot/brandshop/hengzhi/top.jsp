<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	// 徐工特机 品牌 id  1522
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = " select catalogname,num from pro_factory_category where factoryid=13096 order by num" ;
	List<Map> navCataList = dbHelper.getMapList(sel_sql) ;
%>
<div class="shop_topbg">
  <div class="contain980">
    <h2><img src="images/new_shop_logos.gif" alt="湖南恒至凿岩官方旗舰店" width="434" height="102" /></h2>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/new_shop_bm.gif" alt="收藏本店铺" width="138" height="45" /></a></div>
    <div class="shop_tel">联系厂家：<em>0736-7316820  18229993367</em><br />
    全国免费服务热线：<em>400-0736-016</em></div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li style="background:none;"><a href="./" class="selected">首页HOME</a></li>
      <li><a href="/proDetail/HZCLQ140.shtm" target="_blank">HZCLQ140</a></li>
      <li><a href="/proDetail/HZCLQ120.shtm" target="_blank">HZCLQ120</a></li>
      <li><a href="/proDetail/HZCLY115B.shtm" target="_blank">HZCLY115B</a></li>
      <li><a href="/proDetail/HZCLY115.shtm" target="_blank">HZCLY115</a></li>
      <li><a href="/proDetail/HZCLY115A.shtm" target="_blank">HZCLY115A</a></li>
      <li><a href="/proDetail/HZCL90A.shtm" target="_blank">HZCL90A</a></li>
      <li><a href="/proDetail/HZCL90-46.shtm" target="_blank">HZCL90</a></li>
    </ul>
  </div>
</div>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>