<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%

%>
<div class="shop_topbg">
  <div class="contain980 fix" style="position:relative; z-index:5;">
    <h2><img src="images/logo.png" alt="重庆国杰三一代理商旗舰店" /></h2>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/bm.png" alt="收藏本店" /></a></div>
  </div>
  <div class="shopNav pngfix">
    <div class="contain980 fix">
      <ul>
        <li><a href="/brandshop/gjjx/" class="selected">首页</a></li>
        <li><a href="#tuijian">推荐产品</a></li>
        <li><a href="/brandshop/gjjx/list.jsp">三一挖掘机</a></li>
        <li><a href="#introduce">公司介绍<i></i></a></li>
        <li><a href="#contact">联系方式<i></i></a></li>
      </ul>
    </div>
  </div>
</div>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>