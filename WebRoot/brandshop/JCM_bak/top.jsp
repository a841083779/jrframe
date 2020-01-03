<%@ page language="java" import="com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%
	// 山重建机 品牌 id  403
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select  num,catalogname from pro_factory_category where factoryid=403 and len(num)>3" ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	List<Map> navCataList = dbHelper.getMapList(sel_sql) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;
%><div class="shop_topbg">
  <div class="contain980">
    <h2><img src="images/new_shop_logos.gif" alt="山重建机官方旗舰店" width="232" height="80" />官方旗舰店</h2>
    <div class="shop_tel">
      服务热线：<em>400-000-1000</em>
    </div>
    <div class="clear"></div>
    <div class="shop_bm"><a href="javascript:;" onclick="addShop();return false;"><img src="images/bookmark.gif" alt="收藏本店铺" width="83" height="36" /></a></div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
	  <li class="nav01"><a id="t1" href="./" class="selected">首页</a></li>
      <li class="nav01"><a id="t2" href="list.jsp?num=101"><img src="images/logo1.png" /></a></li>
      <li class="nav01"><a id="t3" href="list.jsp?num=102"><img src="images/logo2.png" /></a></li>
      <li class="nav01"><a id="t4" href="introduce.jsp">关于山建</a></li>
      <li class="nav01"><a id="t5" href="contact.jsp">联系我们</a></li>
    </ul>
  </div>
</div>
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/jcm/', '山重建机官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('山重建机官方旗舰店','http://product.21-sun.com/brandshop/jcm/',"");
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