<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
      String catalog=CommonString.getFormatPara(request.getParameter("catalog")); 
	  String url=CommonString.getFormatPara(request.getRequestURL());
	  System.out.println(url);
%>
<div class="shop_topbg">
  <div class="contain980 fix">
    <h2><a href="http://product.21-sun.com/brandshop/linde/"><img src="images/logo.png" alt="林德(中国)叉车有限公司" /></a></h2>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/bm.png" alt="收藏本店" /></a></div>
    <div class="shop_tel">
      咨询热线：<br />
      800-858-2665 
    </div>
  </div>
  <div class="shopNav">
    <div class="contain980 fix">
      <ul>
        <li><a href="/brandshop/linde/" <%if(catalog.equals("")&&url.indexOf("about")==-1){%>class="selected"<%}%>>首页<i></i></a></li>
        <li><a href="/brandshop/linde/about.jsp" <%if(url.indexOf("about")!=-1){%>class="selected"<%}%>>公司简介<i></i></a></li>
        <li><a href="/brandshop/linde/list.jsp?catalog=107001" <%if(catalog.equals("107001")){%>class="selected"<%}%>>林德内燃叉车<i></i></a></li>
        <li><a href="/brandshop/linde/list.jsp?catalog=107003" <%if(catalog.equals("107003")){%>class="selected"<%}%>>林德电动叉车<i></i></a></li>
        <li><a href="/brandshop/linde/list.jsp?catalog=107005" <%if(catalog.equals("107005")){%>class="selected"<%}%>>林德仓储叉车<i></i></a></li>
        <li><a href="/brandshop/linde/list.jsp?catalog=118004" <%if(catalog.equals("118004")){%>class="selected"<%}%>>林德牵引车<i></i></a></li>
      </ul>
    </div>
  </div>
</div>
<script type="text/javascript">
jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
</script>
<div style="display:none"><script src="http://v1.cnzz.com/stat.php?id=5894563&web_id=5894563" language="JavaScript"></script></div>