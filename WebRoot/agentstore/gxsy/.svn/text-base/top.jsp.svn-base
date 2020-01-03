<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.common.CommonString"%><%
String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
%><div class="shop_topbg">
  <div class="contain980 fix tlo">
    <h2 class="logo"><a href="./" title="松宇企业集团"><img src="images/logo.png" alt="松宇企业集团" /></a></h2>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/bm.png" alt="收藏本店" /></a></div>
  </div>
  <div class="shopNav">
    <div class="contain980 fix">
      <ul>
        <li><a href="./" <% if(factoryid.equals("")){ %> class="selected" <%} %>>首页HOME</a></li>
        <li><a href="list.jsp?factoryid=192" <% if(factoryid.equals("192")){ %> class="selected" <%} %>>斗山产品</a></li>
        <li><a href="list.jsp?factoryid=189" <% if(factoryid.equals("189")){ %> class="selected" <%} %>>加藤产品</a></li>
        <li><a href="list.jsp?factoryid=136" <% if(factoryid.equals("136")){ %> class="selected" <%} %>>柳工</a>
          <div class="box">
            <a href="list.jsp?factoryid=136&catalognum=101001">挖掘机</a>
            <a href="list.jsp?factoryid=136&catalognum=101002">装载机</a>
          </div>
        </li>
      </ul>
    </div>
  </div>
</div>
<script type="text/javascript">
//jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1); 
$(document).ready(function() {
    $('.shopNav li').mouseenter(function(){
		$(this).find('.box').show();
	}).mouseleave(function(){
		$(this).find('.box').hide();
	})
});
</script>