<%@ page language="java" import="com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%
	// 铁建重工 品牌 id  403
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select  num,catalogname from pro_factory_category where factoryid=403 and len(num)>3" ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	List<Map> navCataList = dbHelper.getMapList(sel_sql) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;
%>
<div class="shopTop png">
  <div class="shop_topbg png">
    <div class="contain980">
      <h2><img src="images/new_shop_logos.gif" alt="铁建重工官方旗舰店" width="115" height="108" /> 铁建重工官方旗舰店</h2>
      <div class="shop_tel">科技创新时空</div>
      <div class="shop_bm"><a href="javascript:;" onclick="addShop();return false;"><img src="images/bookmark.gif" alt="收藏本店铺" width="116" height="59" /></a></div>
      <div class="tel400">联系电话：<em>4008956789</em></div>
    </div>
  </div>
  <div class="shopNav png">
    <div class="contain980">
      <ul>
        <li class="nav01" style="background:none;"><a href="./" class="selected">首页</a></li>
        <li class="nav01"><a href="list.jsp?num=101">全断面隧道掘进机</a></li>
        <li class="nav01"><a href="list.jsp?num=102">矿山法隧道机械</a></li>
        <li class="nav01"><a href="list.jsp?num=106">桩基础机械</a></li>
        <li class="nav01"><a href="list.jsp?num=105">搅拌运输车</a></li>
        <li class="nav01"><a href="list.jsp?num=104">混凝土搅拌设备</a></li>
        <li class="nav01"><a href="list.jsp?num=103">混凝土泵车</a></li>
      </ul>
    </div>
  </div>
</div>
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/tiejian/', '铁建重工官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('铁建重工官方旗舰店','http://product.21-sun.com/brandshop/tiejian/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery(function(){
	jQuery(".strongContent li").hover(function(){
		jQuery(this).toggleClass("hover");
	},function(){
		jQuery(this).removeClass("hover");
	});
	jQuery(".shopNav li").hover(function(){
		jQuery(this).toggleClass("hover");
		jQuery(this).children("a:first:not('.selected')").toggleClass("selected");
	},function(){
		jQuery(this).removeClass("hover");
		jQuery(this).children("a:first:not('.tag')").removeClass("selected");
	});
})
var thisUrl = window.location.href;
jQuery(".contain980 li a").removeClass("selected");
if(thisUrl.indexOf("introduce.jsp") >= 0){
	jQuery("#t4").addClass("selected");
}else if(thisUrl.indexOf("contact.jsp") >= 0){
	jQuery("#t5").addClass("selected");
}else if(thisUrl.indexOf("102") >= 0){
	jQuery("#t3").addClass("selected");
}else if(thisUrl.indexOf("101") >= 0){
	jQuery("#t2").addClass("selected");
}else{
	jQuery("#t1").addClass("selected");
}
</script>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>