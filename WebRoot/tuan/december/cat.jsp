<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>优买团品牌汇聚，2013年终惠_21-sun优买团</title>
<meta name="keywords" content="21-sun优买团,卡特迷你挖掘机,山工装载机,三一挖掘机,卡特挖机,山推专场,配件,破碎锤" />
<meta name="description" content="21-sun优买团，这里让你购机更轻松，这里是众多终端用户上网购机的首选平台，每天有上万的终端用户汇集在这里选机比价" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
</head>

<body class="tuan">
<div>
  <jsp:include page="include/top.jsp" flush="true"></jsp:include>
  <div class="con clearfix">
    <div class="content recList">
      <ul class="list">
       <li>
        <a target="_blank" href="http://product.21-sun.com/proDetail/306E.shtm"><img width="300" height="265" alt="卡特彼勒306E小型液压挖掘机" src="/tuan/july/images/cat_img02.jpg"><h3>卡特彼勒306E小型液压挖掘机</h3></a>
        <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('20164','');">立即订购</a>
      </li>
       <li>
        <a target="_blank" href="http://product.21-sun.com/proDetail/307E.shtm"><img width="300" height="265" alt="卡特彼勒307E小型液压挖掘机" src="/tuan/july/images/cat_img01.jpg"><h3>卡特彼勒307E小型液压挖掘机</h3></a>
        <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('20163','');">立即订购</a>
      </li>
      <li>
        <a target="_blank" href="http://product.21-sun.com/proDetail/320D2.shtm"><img width="300" height="265" alt="卡特彼勒320D2履带式挖掘机" src="/tuan/december/images/320d2.jpg"><h3>卡特彼勒320D2履带式挖掘机</h3></a>
        <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('20440','');">立即订购</a>
      </li>
      <li>
        <a target="_blank" href="http://product.21-sun.com/proDetail/312DGCSERIES2.shtm"><img width="300" height="265" alt="卡特彼勒312D GC Series 2液压挖掘机" src="/tuan/october/images/proimgs/12d.jpg"><h3>卡特彼勒312D GC Series 2液压挖掘机</h3></a>
        <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('15159','');">立即订购</a>
      </li>
      <li>
        <a target="_blank" href="http://product.21-sun.com/proDetail/313D2.shtm"><img width="300" height="265" alt="卡特彼勒312D GC Series 2液压挖掘机" src="images/313D2.jpg"><h3>卡特彼勒313D2履带式挖掘机</h3></a>
        <a href="javascript:void(0);" target="_self" class="btn" onclick="showinquery('20472','');">立即订购</a>
      </li>
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