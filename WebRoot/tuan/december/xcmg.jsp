<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>徐工就在您身边 产品推荐未来合伙人_21-sun优买团</title>
<meta name="keywords" content="21-sun优买团,诚邀合伙人,卡特迷你挖掘机,山工装载机,三一挖掘机,卡特挖机,山推专场,配件,破碎锤" />
<meta name="description" content="21-sun优买团,中国工程机械商贸网13周年感恩回馈客户,梦想新航线未来合伙人,热销机型包括,卡特迷你挖掘机,山工装载机,卡特挖掘机专场,卡特挖机,山推机械等专场优惠" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
</head>

<body class="tuan">
<div>
  <jsp:include page="include/top.jsp" flush="true"></jsp:include>
  <div class="con clearfix">
    <div class="content recList">
      <ul class="list st1">
        <li> <a href="http://product.21-sun.com/proDetail/XE60CA.shtm" target="_blank"><img width="300" height="265" src="http://product.21-sun.com/tuan/august/images/xcmg_img01.jpg" alt="徐工XE60CA挖掘机">
          <h3>徐工XE60CA挖掘机</h3>
          <span>专享价：¥35万</span> </a> <a onclick="showinquery('20260','');" class="btn" target="_self" href="javascript:void(0);">立即订购</a> </li>
        <li> <a href="http://product.21-sun.com/proDetail/XE85C.shtm" target="_blank"><img width="300" height="265" src="/tuan/images/XE85C.jpg" alt="徐工XE85C挖掘机">
          <h3>徐工XE85C挖掘机</h3>
          <span>专享价：¥46万</span> </a> <a onclick="showinquery('16825','');" class="btn" target="_self" href="javascript:void(0);">立即订购</a> </li>
        <li> <a href="http://product.21-sun.com/proDetail/XE135B.shtm" target="_blank"><img width="300" height="265" src="/tuan/images/XE135B.jpg" alt="徐工XE135B挖掘机">
          <h3>徐工XE135B挖掘机</h3>
          <span>专享价：¥62万</span> </a> <a onclick="showinquery('16824','');" class="btn" target="_self" href="javascript:void(0);">立即订购</a> </li>
        <li> <a target="_blank"  href="http://product.21-sun.com/proDetail/XE215C.shtm"><img width="300" height="265" alt="徐工XE215C挖掘机" src="/tuan/images/XE215C.jpg">
          <h3>徐工XE215C挖掘机</h3>
          <span>专享价：¥86万</span> </a> <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('7877','');">立即订购</a> </li>
        <li> <a target="_blank"  href="http://product.21-sun.com/proDetail/XE370CA.shtm"><img width="300" height="265" alt="徐工XE370CA挖掘机" src="/tuan/images/XE370CA.jpg">
          <h3>徐工XE370CA挖掘机</h3>
          <span>专享价：¥165万</span> </a> <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('20274','');">立即订购</a> </li>
        <!--  <li class="xugongPk"></li>-->
          
          
      </ul>
    </div>
  </div>
</div>
<div class="foot">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
</body>
<!-- jbox -->
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript"> 
function showinquery(pid,factoryid){
	jQuery.jBox("iframe:/include/products/product_order.jsp?productid="+pid+"&factoryid="+factoryid, {
	title: "在线询价",
	width: 720,
	height: 435,
	top: '20%',
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
}
</script>
</html>