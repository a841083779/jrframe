<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	// 徐工特机 品牌 id  1522
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = " select catalogname,num from pro_factory_category where factoryid=1522 order by num" ;
	List<Map> navCataList = dbHelper.getMapList(sel_sql) ;
%>
<div class="shop_topbg">
  <div class="contain980">
    <h2><img src="/images/new_shop_logos.png" alt="中联土石方机械旗舰店" width="452" height="100" /></h2> 
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="/images/new_shop_bm.png" alt="收藏本店铺" width="150" height="35" /></a></div>
    <div class="shop_ads"><img src="/images/new_shop_ads.png" alt="网上购机有千元现金拿" width="78" height="39" /></div>
    <div class="shop_tel">徐工集团统一客服热线：400-110-9999<br />销售热线：0516-85554212　87899099</div>
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