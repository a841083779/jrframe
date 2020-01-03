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
    <h2><img src="images/new_shop_logos.gif" alt="烟台普堃官方旗舰店" width="250" height="103" />烟台普堃官方旗舰店</h2>
    <div class="shop_tel">
      联系电话：<em>0535-3451876</em><br />
      传　　真：<em>0535-3451870</em>
    </div>
    <div class="clear"></div>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/bookmark.gif" alt="收藏本店铺" width="66" height="56" /></a></div>
    <div class="shop_qq"><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=123456&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:123456:51" alt="点击这里给我发消息" title="点击这里给我发消息"/></a></div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li class="nav01"><a href="./">首页HOME</a></li>
      <li class="nav02"><a href="#">HTB系列</a>
        <dl>
          <dd><a href="#">破碎锤</a></dd>
          <dd><a href="#">快速连接器</a></dd>
          <dd><a href="#">振动夯</a></dd>
          <dd><a href="#">液压剪</a></dd>
          <dd><a href="#">配件</a></dd>
        </dl>
      </li>
      <li class="nav03"><a href="#">ENB系列</a>
        <dl>
          <dd><a href="#">破碎锤</a></dd>
          <dd><a href="#">快速连接器</a></dd>
          <dd><a href="#">振动夯</a></dd>
          <dd><a href="#">液压剪</a></dd>
          <dd><a href="#">配件</a></dd>
        </dl>
      </li>
      <li class="nav04"><a href="#">RGB系列</a>
        <dl>
          <dd><a href="#">破碎锤</a></dd>
          <dd><a href="#">快速连接器</a></dd>
          <dd><a href="#">振动夯</a></dd>
          <dd><a href="#">液压剪</a></dd>
          <dd><a href="#">配件</a></dd>
        </dl>
      </li>
      <li class="nav05"><a href="#">PKB系列</a>
        <dl>
          <dd><a href="#">破碎锤</a></dd>
          <dd><a href="#">快速连接器</a></dd>
          <dd><a href="#">振动夯</a></dd>
          <dd><a href="#">液压剪</a></dd>
          <dd><a href="#">配件</a></dd>
        </dl>
      </li>
    </ul>
  </div>
</div>
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/pukun/', '烟台普堃官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('烟台普堃官方旗舰店','http://product.21-sun.com/brandshop/pukun/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery(function(){
	jQuery(".pukunContent li").hover(function(){
		jQuery(this).toggleClass("hover");
	},function(){
		jQuery(this).removeClass("hover");
	});
	jQuery(".shopNav li").hover(function(){
		jQuery(this).toggleClass("hover");
		jQuery(this).children("a:first").toggleClass("selected");
	},function(){
		jQuery(this).removeClass("hover");
		jQuery(this).children("a:first").removeClass("selected");
	});
})
</script>