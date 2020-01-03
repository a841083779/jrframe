<%@ page language="java" import="com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%
	// 沃尔华 品牌 id  403
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select  num,catalogname from pro_factory_category where factoryid=403 and len(num)>3" ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	String topflag = CommonString.getFormatPara(request.getParameter("topflag")) ;
	List<Map> navCataList = dbHelper.getMapList(sel_sql) ;
	String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;
%><div class="shop_topbg">
  <div class="contain980">
    <h2><img src="images/new_shop_logos.gif" alt="沃尔华官方旗舰店" width="255" height="103" />沃尔华官方旗舰店</h2>
    <div class="shop_tel">
      国内销售电话：<em>0537-2569666</em><br />
      <em>0537-2560011</em>
    </div>
    <div class="clear"></div>
    <div class="shop_bm"><a href="javascript:;" onclick="addShop();return false;"><img src="images/bookmark.gif" alt="收藏本店铺" width="145" height="46" /></a></div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
     <li class="nav01"><a href="./" <%if(catalognum.equals("")&&topflag.equals("")){%> class='selected'<%} %>>首页</a></li>
     <li class="nav01"><a href="./list.jsp?num=101001001" <%if(catalognum.equals("101001001")){%> class='selected'<%} %>>履带式挖掘机</a></li>
     <li class="nav01"><a href="./list.jsp?num=101001004" <%if(catalognum.equals("101001004")){%> class='selected'<%} %>>轮式挖掘机</a></li>
     <li class="nav01"><a href="./introduce.jsp" <%if(topflag.equals("0")){%>class='selected'<%} %>>公司介绍</a></li>
    </ul>
  </div>
</div>
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/volwa/', '沃尔华官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('沃尔华官方旗舰店','http://product.21-sun.com/brandshop/volwa/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery(function(){
	jQuery(".shopNav li").hover(function(){
		jQuery(this).toggleClass("hover");
	},function(){
		jQuery(this).removeClass("hover");
	});
})
</script>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>