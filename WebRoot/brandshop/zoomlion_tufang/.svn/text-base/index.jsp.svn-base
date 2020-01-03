<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	String whereStr = " and factoryid_sub=1780 " ;  // 中联土方 id='1780'
	DBHelper dbHelper = DBHelper.getInstance() ;
	String factoryid_sub = "1780" ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>中联土方机械官方旗舰店 - 铁臂商城</title>
<meta name="keywords" content="中联土方机械,中联土方机械产品报价,中联土方机械产品,中联土方机械产品图片,中联土方机械产品介绍,中联土方机械介绍" />
<meta name="description" content="铁臂商城为您提供中联土方机械介绍,中联土方机械产品介绍,中联土方机械产品报价,中联土方机械产品图片,中联土方机械产品展示等中联土方机械产品信息，帮助您全面了解中联土方机械。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/flag_shop.css" rel="stylesheet" type="text/css" />
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--main-->
<div class="shop_topbg">
  <div class="contain980">
    <h2><img src="/images/shop_logos.png" alt="中联土方机械旗舰店" width="742" height="113" /></h2> 
  </div>
</div>
<jsp:include page="top.jsp" flush="true"><jsp:param value="1" name="navFlag"/></jsp:include>
<div class="shopBigBanner" style="background:url(/images/shop_bigbannerbg.jpg) center top no-repeat;">
  <div class="contain980"><img src="/images/shop_bigbanner.jpg" width="980" height="587" /></div>
  <div class="shopBtn">
    <a href="#sp01" title="优惠政策" class="btn"></a>
    <a href="#sp02" title="推荐产品" class="btn"></a>
    <a href="#sp03" title="热卖排行" class="btn"></a>
    <a href="#sp04" title="更多产品" class="btn"></a>
  </div>
</div>
<div class="shopPart01">
  <div class="contain980 pt15">
    <h2 class="spTitle" id="sp01"><img src="/images/shop_title_01.gif" alt="网上购机优惠" width="418" height="61" /></h2>
    <div class="coupon">
      <p class="text"><strong>优惠政策：给予每台订单返1000元现金的优惠支持。</strong><br />
        返利流程：<br />
        1. 用户在线提交指定机型订单，用户将收到21-sun发送的优惠提醒短信。<br />
        2. 21-sun将订单信息反馈至厂家及代理商<br />
        3. 用户线下成交<br />
        4. 用户按短信提示，返回21-sun提交成交信息（姓名+电话+成交机型）<br />
        5. 21-sun核实用户信息后，短信通知用户到21-sun平台上提交身份验证信息（身份证扫描件、购机合同扫描件、用户同设备的合影、银行账户信息等）<br />
        6. 21-sun再次审核后，确定要返利的用户名单。返利将以一个季度为单位，通过全年巡展活动，邀约用户到达现场，进行奖金颁发，无法到达现场的用户，将以一个季度为单位进行汇款。
      </p>
      <div class="img"><img src="/images/coupon_img.png" width="226" height="225" /></div>
    </div>
  <div class="clear"></div>
  </div>
</div>
<div class="shopPart02">
  <div class="contain980">
    <h2 class="spTitle" id="sp02"><img src="/images/shop_title_02.gif" alt="推荐产品" width="432" height="60" /></h2>
    <ul class="shopPros">
      <li>
      <a href="/proDetail/ZE360E.shtm" target="_blank"><img src="/images/shop_proimg01.jpg" width="980" height="468" /></a>
      <!-- <a href="/proDetail/ZD160SH-3.shtm" class="shopBtn" target="_blank">我要在线询价</a> -->
      </li><!--  onclick="showinquery('11759','1780');" -->
      <li>
       <a href="/proDetail/ZD320-3.shtm" target="_blank"><img src="/images/shop_proimg02.jpg" width="980" height="468" target="_blank"/></a>
     <!--   <a href="/proDetail/ZY65C.shtm" target="_blank" class="shopBtn">我要在线询价</a>  -->
      </li><!--  -->
    </ul>
  <div class="clear"></div>
  </div>
</div>
<div class="shopPart03">
  <div class="contain980">
    <h2 class="spTitle" id="sp03"><img src="/images/shop_title_03.gif" alt="热卖排行榜" width="432" height="60" /></h2>
    <div class="shopContain">
      <ul class="shopPros01"><!-- 产品热卖 -->
      <%
      	String sel_sql2 = " select top 4 id,name,factoryid_sub factoryid,factoryname,catalognum_spe catalognum,catalogname_spe catalogname,img2,file_name from pro_products where factoryid_sub=? and zoomlion_hot=11" ;
      	List<Map> hotProductsList = dbHelper.getMapList(sel_sql2,new Object[]{factoryid_sub}) ;
      	if(null!=hotProductsList && hotProductsList.size()>0){
      		for(Map oneMap:hotProductsList){
      			%>
      		  <li>
	          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="<%= "/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2"))%>" width="455" height="320" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"/></a></div>
	          <h3><a href="#"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
	          <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>');" class="priceBtn">立即询价</a>
		       </li>
      			<%
      		}
      	}
      %>
      </ul>
    </div>
  <div class="clear"></div>
  </div>
  <div class="shop_morePro">
    <div class="contain980">
      <h2 class="spTitle" id="sp04"><img src="/images/shop_title_04.gif" alt="更多产品推荐" width="200" height="42" /></h2>
      <div class="shopContain">
        <ul class="shopPros02"><!-- 12个更多产品推荐 中联土方 1780-->
        <%
        	String sel_sql = " select  id,factoryname,name,catalogname_spe,img2,factoryid_sub,file_name from pro_products where factoryid_sub=?" ;
        	List<Map> moreProductsList = dbHelper.getMapList(sel_sql,new Object[]{factoryid_sub}) ;
        	if(null!=moreProductsList && moreProductsList.size()>0){
        		for(Map oneMap:moreProductsList){
        			%>
        			<li>
		            <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname_spe")) %>"><img src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" width="230" height="178"  onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" /></a></div>
		            <h3><a href="#" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname_spe")) %>"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname_spe")) %></a></h3>
		            <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="priceBtn">立即询价</a>
		           </li>
        			<%
        		}
        	}
        %>
        </ul>  
        <jsp:include page="foot.jsp" flush="true"></jsp:include>
      </div>
    <div class="clear"></div> 
    </div> 
  </div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
    if (document.all){
        window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
    }else if (window.sidebar){
        window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
    }
}
function addShop(){　 // 收藏我们
    if (document.all){
        window.external.addFavorite('http://product.21-sun.com', '中联土方机械旗舰店');
    }else if (window.sidebar){
        window.sidebar.addPanel('中联土方机械旗舰店', 'http://www.product.21-sun.com', "");
    }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
</script> 
</body>
</html>