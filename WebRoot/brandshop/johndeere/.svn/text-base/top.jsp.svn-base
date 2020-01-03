<%@ page language="java" import="com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%
	// 普堃韩泰克 品牌 id  403
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select  num,catalogname from pro_factory_category where factoryid=403 and len(num)>3" ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	List<Map> navCataList = dbHelper.getMapList(sel_sql) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;
%><div class="shop_topbg">
  <div class="contain980">
    <h2><img src="images/logo.png" alt="约翰迪尔官方旗舰店" width="250" height="103" class="png" /></h2>
    <div class="qqico"><a href="#order"><img src="images/qqico.png" width="104" height="35" class="png"/></a></div>
    <div class="tel_sc">
    	<div class="l">
        	<p class="name">约翰迪尔热线：</p>
            <p class="tel">400-6576-555</p>
        </div>
        <div class="r"><a href="" onclick="addShop();return false;"><img src="images/shouc.png" class="png"/></a></div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<div class="shopNav png">
  <div class="contain980" style="overflow:hidden;">
    <ul>
     <li class="nav01" style="width: 120px"><a href="./">首页</a></li>
     <li class="nav01" style="width: 120px"><a href="#aboutdd">公司简介</a></li>
	 
	 <li class="nav01" style="width: 120px"><a href="http://product.21-sun.com/proDetail/E300.shtm" target="_blank" title="约翰迪尔E300挖掘机">E300 LC</a></li>
	      <li class="nav01" style="width: 120px"><a href="http://product.21-sun.com/proDetail/E330.shtm" target="_blank" title="约翰迪尔E330挖掘机">E330 LC</a></li>
     <li class="nav01" style="width: 120px"><a href="http://product.21-sun.com/proDetail/E360-93.shtm" target="_blank" title="约翰迪尔E360挖掘机">E360 LC</a></li>
	 
     <li class="nav01" style="width: 120px"><a href="http://product.21-sun.com/proDetail/E210LC.shtm" target="_blank" title="约翰迪尔E210 LC挖掘机">E210 LC</a></li>
     <li class="nav01" style="width: 120px"><a href="http://product.21-sun.com/proDetail/E240LC.shtm" target="_blank" title="约翰迪尔E240 LC挖掘机">E240 LC</a></li>
     <li class="nav01" style="width: 120px"><a href="http://product.21-sun.com/proDetail/WL56.shtm" target="_blank" title="约翰迪尔WL56 轮式装载机">WL56</a></li>


     <!--  <li class="nav02"><a href="#">HTB系列</a>
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
      </li> -->
    </ul>
  </div>
</div>
<!--<div class="float_qq" id="float_qq">
  <span class="close" onclick="document.getElementById('float_qq').style.display='none'" title="关闭"></span>
  <div class="float_qq_con">
    <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=782584320&site=qq&menu=yes"><img border="0" src="/images/counseling_style_52.png" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
  </div>
  <div class="float_qqbg"></div>  
</div>-->
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/johndeere/', '约翰迪尔官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('约翰迪尔官方旗舰店','http://product.21-sun.com/brandshop/johndeere/',"");
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
		jQuery(this).children("a:first:not('.selected')").toggleClass("selected");
	},function(){
		jQuery(this).removeClass("hover");
		jQuery(this).children("a:first:not('.tag')").removeClass("selected");
	});
})
</script>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>