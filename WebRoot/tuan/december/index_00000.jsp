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
<script type="text/javascript" src="scripts/jquery.SuperSlide.js"></script>
</head>

<body class="tuan">
<div>
  <jsp:include page="include/top.jsp" flush="true"></jsp:include>
  <div class="con clearfix">
    <div class="home_left mb30">
      <div id="slideBox" class="slideBox">
        <div class="hd">
          <ul>
            <li></li>
            <li></li>
            <li></li>
          </ul>
        </div>
        <div class="bd">
          <ul>
            <li><a href="#" target="_blank" ><img src="images/home_img1.jpg" />
              <h2>十二月优买团——我们的故事</h2>
              <p>这里让你购机更轻松，这里是众多终端用户上网购机的首选平台，每天有上
                万的终端用户汇集在这里选机比价</p>
              <b>查看更多&gt;&gt;</b></a> 
            </li>
            <li><a href="#" target="_blank" ><img src="images/home_img1.jpg" />
              <h2>十二月优买团——我们的故事</h2>
              <p>这里让你购机更轻松，这里是众多终端用户上网购机的首选平台，每天有上
                万的终端用户汇集在这里选机比价</p>
              <b>查看更多&gt;&gt;</b></a> 
            </li>
            <li><a href="#" target="_blank" ><img src="images/home_img1.jpg" />
              <h2>十二月优买团——我们的故事</h2>
              <p>这里让你购机更轻松，这里是众多终端用户上网购机的首选平台，每天有上
                万的终端用户汇集在这里选机比价</p>
              <b>查看更多&gt;&gt;</b></a> 
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="home_right mb30"> <img src="images/home_gift.jpg" />
      <div class="con">
        <div class="text_input"><b>姓　名 ： </b>
          <input type="text" size="20" maxlength="10" />
        </div>
        <div class="selectBox"><b>省　份 ： </b>
          <select name="select" id="select">
            <option>请选择</option>
          </select>
        </div>
        <div class="selectBox"><b>品　牌 ： </b>
          <select >
            <option>请选择</option>
          </select >
        </div>
      </div>
      <div class="con">
        <div class="text_input"><b>手　机 ： </b>
          <input type="text" size="20" maxlength="11" />
        </div>
        <div class="selectBox"><b>城　市 ： </b>
          <select >
            <option>请选择</option>
          </select >
        </div>
      </div>
      <input type="submit" name="button" id="button" value="&nbsp;" class="sumitBtn" />
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
jQuery(".slideBox").slide( { mainCell:".bd ul",effect:'leftLoop',autoPlay:true,interTime:4000} );
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