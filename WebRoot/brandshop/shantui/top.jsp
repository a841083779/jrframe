<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = " select catalogname,num from pro_factory_category where factoryid=1220 order by num" ;
	List<Map> navCataList = dbHelper.getMapList(sel_sql) ;
%>
<div class="shop_topbg">
  <div class="contain980 fix">
    <h2><img src="images/logo.png" alt="林德(中国)叉车有限公司" /></h2>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/bm.png" alt="收藏本店" /></a></div>
  </div>
  <div class="shopNav">
    <div class="contain980 fix">
      <ul>
        <li style="background:none;"><a href="./" class="selected">首页</a></li>
        <li><a href="/proDetail/SL20W.shtm" target="_blank">SL20W</a></li>
        <li><a href="/proDetail/SL50WA.shtm" target="_blank">SL50WA</a></li>
        <li><a href="/proDetail/SL50W-SL50W-2.shtm" target="_blank">SL50W</a></li>
        <li><a href="/proDetail/SL50W-3.shtm" target="_blank">SL50W-3</a></li>
        <li><a href="/proDetail/SL30W.shtm" target="_blank">SL30W</a></li>
        <li><a href="/proDetail/SL50W-5.shtm" target="_blank">SL50W-5</a></li>
        <li><a href="/proDetail/SL60W-2.shtm" target="_blank">SL60W-2</a></li>
        <li><a href="/proDetail/SL80W.shtm" target="_blank">SL80W</a></li>
        <li><a href="/proDetail/SSL750.shtm" target="_blank">SSL750</a></li>
      </ul>
    </div>
  </div>
</div>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>