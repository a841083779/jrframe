<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>宝鼎就在您身边 产品推荐未来合伙人_21-sun优买团</title>
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
      <div class="discount">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="35%" style="color:#ae000d; font-size:24px; font-family:'MicroSoft YaHei'">优惠政策：<br /></td>
            <td width="10%" rowspan="2"><img src="images/bao_banner.jpg" width="75" height="102" /></td>
            <td width="27%" rowspan="2">总重量380kg<br />
              驱动油压120-150Kg/cm2 <br />
              打击频率400-800bpm</td>
            <td width="28%" rowspan="2">全长1699mm<br />
              驱动流量50-90I/min<br />
              配用车重6.0-9.0ton</td>
          </tr>
          <tr>
            <td valign="top" style="font-size:20px; font-family:'MicroSoft YaHei'" >买WY90挖机送破碎锤。</td>
          </tr>
        </table>
      </div>
      <ul class="list">
        <li> <a target="_blank" href="http://product.21-sun.com/proDetail/WY65-6.shtm"><img alt="宝鼎WY65履带挖掘机" src="images/baoding/bao1.jpg">
          <h3>宝鼎WY65履带挖掘机</h3>
          </a> <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('19936','');">立即订购</a> </li>
        <li> <a target="_blank" href="http://product.21-sun.com/proDetail/WYL65-7.shtm"><img alt="宝鼎WY65轮式挖掘机" src="images/baoding/bao2.jpg">
          <h3>宝鼎WY65轮式挖掘机</h3>
          </a> <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('20653','');">立即订购</a> </li>
        <li> <a target="_blank" href="http://product.21-sun.com/proDetail/WY90.shtm"><img alt="宝鼎WY90履带挖掘机" src="images/baoding/bao3.jpg">
          <h3>宝鼎WY90履带挖掘机</h3>
          </a> <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('19935','');">立即订购</a> </li>
        <li> <a target="_blank" href="http://product.21-sun.com/proDetail/WY150.shtm"><img alt="宝鼎WY150履带挖掘机" src="images/baoding/bao4.jpg">
          <h3>宝鼎WY150履带挖掘机</h3>
          </a> <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('19934','');">立即订购</a> </li>
        <li> <a target="_blank" href="http://product.21-sun.com/proDetail/WYL80.shtm "><img alt="宝鼎WYL80轮式挖掘机" src="images/baoding/bao5.jpg">
          <h3>宝鼎WYL80轮式挖掘机</h3>
          </a> <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('20652','');">立即订购</a> </li>
        <li> <a target="_blank" href="http://product.21-sun.com/proDetail/WYL150.shtm "><img alt="宝鼎WYL150轮式挖掘机" src="images/baoding/bao6.jpg">
          <h3>宝鼎WYL150轮式挖掘机</h3>
          </a> <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('20651','');">立即订购</a> </li>
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