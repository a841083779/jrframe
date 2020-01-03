<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	// 徐工特机 品牌 id  1522
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = " select catalogname,num from pro_factory_category where factoryid=1236 order by num" ;
	List<Map> navCataList = dbHelper.getMapList(sel_sql) ;
%>
<div class="shop_topbg">
  <div class="contain980">
    <h2><img src="images/new_shop_logos.png" alt="湖南新天和官方旗舰店" width="409" height="100" /></h2> 
    <span class="l" style="padding-top:45px;"><img src="/images/ico.gif" /></span>
    <div class="shop_tel">湖南新天和客服热线：0731-52825566<br />营销热线：0731-52825569 　13875813318</div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li style="background:none;"><a href="./" class="selected">首页HOME</a></li>
            <%
      	if(null!=navCataList && navCataList.size()>0){
      		for(Map oneMap:navCataList){
      			%>
      			  <li><a href=list.jsp?num=<%=CommonString.getFormatPara(oneMap.get("num")) %>><%= CommonString.getFormatPara(oneMap.get("catalogname"))%></a></li>
      			<%
      		}
      	}
      %>
    </ul>
    <a class="qq" href="javascript:;" onclick="addShop();return false ;"><img src="images/new_shop_bm.gif" alt="收藏本店铺" width="128" height="30" /></a>
  </div>
</div>
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/hnxth/', '湖南新天和官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('湖南新天和官方旗舰店','http://product.21-sun.com/brandshop/hnxth/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>