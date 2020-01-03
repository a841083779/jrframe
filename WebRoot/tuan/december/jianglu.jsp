<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>江麓就在您身边 产品推荐未来合伙人_21-sun优买团</title>
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
      <ul class="list st2">
        <li> <a href="http://product.21-sun.com/proDetail/CNE60.shtm" target="_blank"><img src="http://192.168.40.222:10031/tuan/images/CN90.jpg" alt="江麓CN90挖掘机" width="300" height="265" />
          <h3>江麓CN90挖掘机</h3>
           <span>送1万元配件，<br />加18000元再送锤</span>
          </a> <a onclick="showinquery('7958','');" class="btn" target="_self" href="javascript:void(0);">立即订购</a> </li>
        <li> <a href="http://product.21-sun.com/proDetail/CNE85.shtm" target="_blank"><img src="http://192.168.40.222:10031/tuan/images/CN150LC.jpg" alt="江麓CN150LC挖掘机" width="300" height="265" />
          <h3>江麓CN150LC挖掘机</h3>
           <span>送1万元配件，<br />加20000元再送锤</span>
          </a> <a onclick="showinquery('7959','');" class="btn" target="_self" href="javascript:void(0);">立即订购</a> </li>
        <li> <a href="http://product.21-sun.com/proDetail/CN225LC.shtm" target="_blank"><img src="http://192.168.40.222:10031/tuan/images/CN225LC.jpg" alt="江麓CN265LC挖掘机" width="300" height="265" />
          <h3>江麓CN225LC挖掘机</h3>
           <span>送1.5万元配件，<br/>加35000元再送锤</span>
          </a> <a onclick="showinquery('13103','');" class="btn" target="_self" href="javascript:void(0);">立即订购</a> </li>
        <li> <a href="http://product.21-sun.com/proDetail/CN330.shtm" target="_blank"><img src="http://192.168.40.222:10031/tuan/images/CN330LC.jpg" alt="江麓CN330LC挖掘机" width="300" height="265" />
          <h3>江麓CN330LC挖掘机</h3>
           <span>送1万元配件，<br />加50000元再送锤</span>
          </a> <a onclick="showinquery('10121','');" class="btn" target="_self" href="javascript:void(0);">立即订购</a> </li>
        <li> <a href="http://product.21-sun.com/proDetail/CN450LC.shtm" target="_blank"><img src="http://192.168.40.222:10031/tuan/images/CN450LC.jpg" alt="江麓CN450LC挖掘机" width="300" height="265" />
          <h3>江麓CN450LC挖掘机</h3>
          </a> <a onclick="showinquery('18929','');" class="btn" target="_self" href="javascript:void(0);">立即订购</a> </li>
        <li> <a href="http://product.21-sun.com/proDetail/JLW60.shtm" target="_blank"><img src="http://192.168.40.222:10031/tuan/images/CN70.jpg" alt="江麓CN70挖掘机" width="300" height="265" />
          <h3>江麓CN70挖掘机</h3>
           <span>全款31.5万元<br />按揭(打包价)35.5万元(首付5万,按揭两年)</span>
          </a> <a onclick="showinquery('5214','');" class="btn" target="_self" href="javascript:void(0);">立即订购</a> </li>
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