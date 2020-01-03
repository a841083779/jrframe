<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
%>
<div class="shop_topbg">
  <div class="contain980">
    <h2><img src="images/new_shop_logos.png" alt="千里马官方旗舰店" width="241" height="56" /><span><strong>千里马官方旗舰店</strong></span></h2>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/new_shop_bm.png" alt="收藏本店铺" width="140" height="56" /></a></div>
  </div>
</div>
<script type="text/javascript">
jQuery(function(){
	jQuery(".shopNav li").hover(function(){
		jQuery(this).toggleClass("hover");
	},function(){
		jQuery(this).removeClass("hover");
	});
})
</script>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li style="background:none;"><a href="./" class='<%=factoryid.equals("")?"selected":"" %>'>首页HOME</a></li>
      <li><a href="list.jsp?factoryid=192" class='<%=factoryid.equals("192")?"selected":"" %>'>斗山产品</a>
        <dl>
          <dd><a   href="list.jsp?factoryid=192&amp;catanum=101001">挖掘机</a></dd>
          <dd><a   href="list.jsp?factoryid=192&amp;catanum=101002">装载机</a></dd> 
          <dd><a   href="list.jsp?factoryid=192&amp;catanum=101008">铰接式自卸卡车</a></dd>
          <dd><a   href="list.jsp?factoryid=192&amp;catanum=113001">破碎锤</a></dd>
        </dl>
      </li>
      <li><a href="list.jsp?factoryid=137" class='<%=factoryid.equals("137")?"selected":"" %>'>临工产品</a>
        <dl>
         <dd><a href="list.jsp?factoryid=137&catanum=101001"  >液压挖掘机</a></dd>
          <dd><a href="list.jsp?factoryid=137&catanum=101002"  >装载机</a></dd>
          <dd><a href="list.jsp?factoryid=137&catanum=106001"  >压路机</a></dd>
        </dl>
      </li>
      <li><a href="list.jsp?factoryid=454" class='<%=factoryid.equals("454")?"selected":"" %>'>山猫滑移产品</a>
        <dl>
          <dd><a href="list.jsp?factoryid=454&catanum=101002"  >装载机</a></dd> 
          <dd><a href="list.jsp?factoryid=454&catanum=101001"  >挖掘机</a></dd>
        </dl>
      </li>
      <li><a href="list.jsp?factoryid=1661" class='<%=factoryid.equals("1661")?"selected":"" %>'>千里马产品</a>
        <dl>
          <dd><a href="list.jsp?factoryid=1661&catanum=113001" >破碎锤</a></dd>
          <dd><a href="list.jsp?factoryid=1661&catanum=33333">再制造产品</a></dd>
        </dl>
      </li>
    </ul>
    <div class="tel">千里马集团全国统一客服热线：<strong>400-889-6977</strong><br />
    销售热线：027-83382896 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13871282300</div>
  </div>
</div>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>