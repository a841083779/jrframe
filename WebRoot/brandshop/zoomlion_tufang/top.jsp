<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ; // 栏目 
	String navFlag = CommonString.getFormatPara(request.getParameter("navFlag")) ;
%>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li><a href="/brandshop/zoomlion_tufang" class="selected">店铺首页</a></li>
      <li><a href="list.jsp" class='<%=(request.getRequestURI().indexOf("list.jsp")!=-1&&catalognum.equals(""))?"cur":"" %>'>全部产品</a></li>
      <li><a href="list.jsp?catalognum=101" class='<%=catalognum.equals("101")?"cur":"" %>'>挖掘机</a></li>
      <li><a href="list.jsp?catalognum=102" class='<%=catalognum.equals("102")?"cur":"" %>'>推土机</a></li>
      <li><a href="list.jsp?catalognum=103" class='<%=catalognum.equals("103")?"cur":"" %>'>装载机</a></li>
      <li><a href="index.jsp#sp01">优惠专区</a></li>
      <li><a href="intro.jsp" class='<%=navFlag.equals("intro")?"cur":"" %>'>品牌介绍</a></li>
      <li><a href="contact.jsp" class='<%=navFlag.equals("contact")?"cur":"" %>'>联系我们</a></li>
    </ul>
    <div class="shopRight">
      <a href="http://e.weibo.com/zoomlionbranding" target="_blank"><img src="/images/shop_weibo.gif" alt="关注中联微博" width="113" height="23" /></a> 
      <a href="javascript:;" onclick="addShop();return false;"><img src="/images/shop_bm.gif" alt="收藏我们" width="113" height="46" /></a>
    </div>
  </div>
 </div>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>