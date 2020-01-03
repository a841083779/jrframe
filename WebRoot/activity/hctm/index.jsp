<%@page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<title>促销风暴，多重优惠！</title>
<link href="static/ui/ui.css" rel="stylesheet">
<link href="style/style.css" rel="stylesheet">

</head>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>

<link href="/plugin/dialog/jBox/Skins/GreyBlue/jbox.css" type="text/css" rel="stylesheet"/>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" />


<script type="text/javascript">
function showinquery(pid,factoryid){
	jQuery.jBox("iframe:/activity/hctm/product_order_s.jsp?productid="+pid, {
	title: "在线询价",
	width: 750,
	height: 350,
	top: '10%',	
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
	jQuery(".jbox-title-panel").attr("style","display:none;") ;
	jQuery(".jbox-close").css({width:"48px", height:"48px"});
}
</script>
<body>
<div class="header">
  <div class="wrap">
    <a href="http://product.21-sun.com/tuan/"><h1 class="logo l">铁壁优买团--尽享优惠，为您而省！</h1></a>
    <span class="servTel r"></span>
  </div>
</div>
<div class="banner">
  <img src="static/images/banner.png" alt="尽享优惠，为您而省！">
  <a class="buyNow" href="javascript:;" onClick="showinquery('25663','')">立即抢购 ></a>
</div>
<div class="main">
  <div class="tip">
    <div class="wrap">
      <h2>促销风暴&nbsp;&nbsp;&nbsp;&nbsp;多重优惠</h2>
      <div class="tipList">
        <p>政策一：底盘促销，单台<span>直降<i>8</i>万</span></p>
        <p>政策二：上装促销，单台<span>直降<i>1</i>万</span></p>
        <p>政策三：整车促销，单台<span>直降<i>9</i>万</span></p>
      </div>
    </div>
  </div>
  <div class="cont part_1">
    <div class="title"><div class="titleBgR"><h2>重汽70矿用自卸车，矿山中的霸王车</h2></div></div>
    <div class="detail">
      <p>该车设计符合了我国露天煤矿、大型矿山的矿区道路，适用于路况差、作业环境恶劣的的场所，在矿山作业中具有独到优势。与普通高重心矿用自卸车相比，重汽70矿用车行车更稳、更安全。箱体选用H1250高强板，抗砸耐磨强，维修率低、使用寿命更长，对于特定的用户而言，具有极高的经济效益。</p>
    </div>
  </div>
  <div class="cont part_2">
    <div class="title"><div class="titleBgR"><h2>性&nbsp;&nbsp;&nbsp;&nbsp;能</h2></div></div>
    <div class="detail">
      <ul>
        <li>
          <h3>耐磨抗砸</h3>
          <p>1.选用H1250高强耐磨板，板材屈服度1250MPa、布氏硬度达到HB300以上，强度、韧性是普通材料的3倍；</p>
          <p>2. 采用全新的u型框结构，抗砸耐磨更出众。加宽侧防护，防止石块等对轮胎的冲击，有效保护轮胎、油箱。</p>
        </li>
        <li>
          <h3>安全可靠</h3>
          <p>1.加宽车架，经过多年的矿区作业研究，优化货箱内尺，提高安全性的同时保证承载量；</p>
          <p>2.重心比普通矿用车低160mm，行车更稳，更加安全；</p>
          <p>3.高强耐磨钢板，标载70吨车厢，超强承载，车箱使用寿命延长一倍以上，二手车残值高。</p>
        </li>
        <li>
          <h3>专业高效</h3>
          <p>1.优化底板纵梁和边框结构，焊道数量减少60%，不开焊，维修率减少20%，出勤率高；</p>
          <p>2.宏昌天马185专业矿用油缸，采用新的硅锰材料，动力强劲，工作效率高。</p>
        </li>
      </ul>
    </div>
  </div>
</div>
<div class="mainBottom"></div>
<div class="footer">
  <div class="swrap  fix">
    <div class="l footleft">
      <ul class="fix">
        <li><a href="http://www.21-sun.com/service/guanggao/index.htm" target="_blank" class="link05">广告服务 |</a></li>
        <li><a href="http://www.jerei.com/contact/" class="link05" target="_blank">联系方式 |</a></li>
        <li><a href="http://www.jerei.com/" class="link05" target="_blank">关于我们 |</a></li>
        <li><a href="http://www.jerei.com/news/" class="link05" target="_blank">本网动态 |</a></li>
        <li><a href="http://www.jerei.com/contact/legal.jsp" class="link05" target="_blank">法律声明 |</a></li>
        <li><a href="http://aboutus.21-sun.com/map.htm" class="link05" target="_blank">网站导航 |</a></li>
        <li><a href="http://www.21-sun.com/contact/" class="link05" target="_blank">联系客服</a></li>
      </ul>
      <p>业务联系:(总机)0535-6722555 传真:0535-6723239</p>
      <p><a href="http://www.21-sun.com">中国工程机械商贸网</a> Copyright © 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script></p>
    </div>
    <div class="r footright">
      <p>栏目策划：21-sun编辑部</p>
      <p>栏目支持：21-sun技术与设计部</p>
      <p>联系电话：0535-6921260</p>
    </div>
  </div>
</div>

</body>
<script src="static/lib/seajs/sea.js"></script>
<script src="js/config.js"></script>
<script>
seajs.use('./js/index');
</script>
<div style="display:none">
<script src="http://s11.cnzz.com/z_stat.php?id=1258677099&web_id=1258677099" language="JavaScript"></script>
</div>
</html>
