<%@ page language="java" import="com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%
	// 普堃韩泰克 品牌 id  403
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select  num,catalogname from pro_factory_category where factoryid=403 and len(num)>3" ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	List<Map> navCataList = dbHelper.getMapList(sel_sql) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;
%><div class="shop_topbg">
  <div class="contain980">
    <h2><img src="images/new_shop_logos.gif" alt="烟台普堃官方旗舰店" width="250" height="103" />烟台普堃官方旗舰店</h2>
    <div class="shop_tel">
      联系电话：<em>0535-3451876</em><br />
      传　　真：<em>0535-3451870</em>
    </div>
    <div class="clear"></div>
    <div class="shop_bm"><a href="javascript:;" onclick="addShop();return false;"><img src="images/bookmark.gif" alt="收藏本店铺" width="66" height="56" /></a></div>
    <div class="welcome">欢迎光临PUKUN！</div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <%
      	 if(null!=navCataList && navCataList.size()>0){
      		 %>
      		 <li class="nav01"><a href="./" <%if("0".equals(flag)){%>class='selected tag'<%} %>>首页HOME</a></li>
      		 <%
      		 for(Map oneMap:navCataList){
      			 %>
      			 <li class="nav01"><a href="list.jsp?num=<%=CommonString.getFormatPara(oneMap.get("num")) %>" <%if(CommonString.getFormatPara(oneMap.get("num")).equals(catalognum)){%>class='selected tag'<%} %>><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></li>
      			 <%
      		 }
      	 }
      %>
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
<div class="float_qq" id="float_qq">
  <span class="close" onclick="document.getElementById('float_qq').style.display='none'" title="关闭"></span>
  <div class="float_qq_con">
    <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=782584320&site=qq&menu=yes"><img border="0" src="/images/counseling_style_52.png" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
  </div>
  <div class="float_qqbg"></div>  
</div>
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/hi-tech/', '烟台普堃官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('烟台普堃官方旗舰店','http://product.21-sun.com/brandshop/hi-tech/',"");
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