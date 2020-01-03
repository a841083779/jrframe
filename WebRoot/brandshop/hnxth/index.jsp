<%@ page language="java" import="java.util.*,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>新天和官方旗舰店 - 铁臂商城</title>
<meta name="keywords" content="新天和,新天和产品报价,新天和产品,新天和产品图片,新天和产品介绍,新天和介绍" />
<meta name="description" content="铁臂商城为您提供新天和介绍,新天和产品介绍,新天和产品报价,新天和产品图片,新天和产品展示等新天和产品信息，帮助您全面了解新天和。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop01.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
<script type="text/javascript">
var t = n = 0, count;
jQuery(document).ready(function(){	
	count=jQuery("#slider .bgs li").length;
	jQuery("#slider .bgs li:not(:first-child)").hide();
	jQuery("#slider .points li").click(function() {
		var i = jQuery(this).attr("value") - 1;
		n = i;
		if (i >= count) return;
		jQuery("#slider .bgs li").filter(":visible").fadeOut(800).parent().children().eq(i).fadeIn(800);
		jQuery(this).toggleClass("selected");
		jQuery(this).siblings().removeAttr("class");
	});
	t = setInterval("showAuto()", 4000);
	jQuery("#slider .points li").hover(function(){
		clearInterval(t);
		}, function(){
		t = setInterval("showAuto()", 4000);
		});
})
function showAuto(){
	n = n >=(count - 1) ? 0 : ++n;
	jQuery("#slider .points li").eq(n).trigger('click');
}
</script>
</head>
<body class="flag_shop shopList">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"></jsp:include>
<!--main-->
<div id="slider" class="new_rec">
  <ul class="bgs">
    <li style="background:url(images/new_bigbanner02_02.jpg) center top no-repeat;"><a href="/proDetail/ZYC600B.shtm" target="_blank"></a></li>
    <li style="background:url(images/new_bigbanner01_02.jpg) center top no-repeat; display:none;"><a href="/proDetail/ZYC800B.shtm" target="_blank"></a></li>
    <li style="background:url(images/new_bigbanner03_02.jpg) center top no-repeat; display:none;"><a href="/proDetail/ZYC1000B.shtm" target="_blank"></a></li>
  </ul>
  <ul class="points">
    <li value="1" class="selected"></li>
    <li value="2"></li>
    <li value="3"></li>
  </ul>
</div>
<div class="shopPart01">
  <div class="contain980 pt20">
    <!--<div class="coupon_top">
      <span class="tip">售前咨询<br /><em>09:00-17:00</em></span>
      <ul class="qq">
        <li>
          <em>1</em>
          <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=123456&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:123456:45" alt="点击这里给我发消息" title="点击这里给我发消息"></a>
        </li>
        <li>
          <em>2</em>
          <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=123456&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:123456:45" alt="点击这里给我发消息" title="点击这里给我发消息"></a>
        </li>
        <li>
          <em>3</em>
          <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=123456&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:123456:45" alt="点击这里给我发消息" title="点击这里给我发消息"></a>
        </li>
        <li>
          <em>4</em>
          <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=123456&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:123456:45" alt="点击这里给我发消息" title="点击这里给我发消息"></a>
        </li>
        <li>
          <em>5</em>
          <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=123456&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:123456:45" alt="点击这里给我发消息" title="点击这里给我发消息"></a>
        </li>
        <li>
          <em>6</em>
          <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=123456&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:123456:45" alt="点击这里给我发消息" title="点击这里给我发消息"></a>
        </li>
      </ul>
      <div class="hotLine">湖南新天和售后热线：0731-52825566 　　销售热线：0731-52825555  0731-52825569</div>
    </div>-->
    <div class="proCate">
    <img src="images/pro_catebg.gif" width="980" height="180" />
    <a href="#shopPart04" class="pc01" style="left:252px; top:16px;" title="ZYC系列">ZYC系列</a>
    <a href="#shopPart05" class="pc02" style="left:477px; top:16px;" title="CFG系列">CFG系列</a>
    <a href="#shopPart07" class="pc03" style="left:700px; top:16px;" title="WB系列">WB系列</a>
    <a href="#shopPart06" class="pc04" style="left:252px; top:92px;" title="JBY系列">JBY系列</a>
    <a href="#shopPart07" class="pc05" style="left:477px; top:92px;" title="LGZ系列">LGZ系列</a>
    <a href="#shopPart06" class="pc06" style="left:700px; top:92px;" title="SMW系列">SMW系列</a>
    </div>
    <div class="shadow"><img src="images/part_shadow.png" width="980" height="20" /></div>
  </div>
</div>

<div class="shopPart02">
  <div class="contain980">
    <div class="title">
      <h3><img src="images/titlebg01.png" alt="新品推荐" width="980" height="45" /></h3>
      </div>
    <div class="content">
      <ul class="list">
        <li><a href="/proDetail/ZYC60B.shtm" target="_blank" title="新天和ZYC60B液压静力压桩机"><img src="images/part02_img01.jpg" alt="新天和ZYC60B液压静力压桩机" width="408" height="342" /></a></li>
        <li><a href="/proDetail/ZYC1000B-B.shtm" target="_blank" title="新天和ZYC1000B-B液压静力压桩机"><img src="images/part02_img02.jpg" alt="新天和ZYC1000B-B，液压静力压桩机" width="481" height="342" /></a></li>
        <li><a href="/proDetail/ZYC600B.shtm" target="_blank" title="新天和ZYC600B液压静力压桩机"><img src="images/part02_img03.jpg" alt="新天和ZYC600B液压静力压桩机" width="232" height="350" /></a></li>
        <li><a href="/proDetail/ZYC700B.shtm" target="_blank" title="新天和ZYC700B液压静力压桩机"><img src="images/part02_img04.jpg" alt="新天和ZYC700B液压静力压桩机" width="232" height="350" /></a></li>
        <li><a href="/proDetail/ZYC800B.shtm" target="_blank" title="新天和ZYC800B液压静力压桩机"><img src="images/part02_img05.jpg" alt="新天和ZYC800B液压静力压桩机" width="396" height="350" /></a></li>
      </ul>
    </div>
    <div class="shadow"><img src="images/part_shadow.png" width="980" height="20" /></div>
  </div>
</div>
<div class="shopPart03">
  <div class="contain980">
    <div class="title">
      <h3><img src="images/titlebg02.png" alt="推荐产品" width="980" height="45" /></h3>
       </div>
    <div class="content">
      <ul class="list">
        <li><a href="/proDetail/CFG-30.shtm" target="_blank" title="新天和CFG30液压步履式长螺旋钻机"><img src="images/part03_img01.jpg" alt="新天和CFG30液压步履式长螺旋钻机" width="334" height="442" /></a></li>
        <li><a href="/proDetail/SMW85.shtm" target="_blank" title="新天和SMW85工法桩机"><img src="images/part03_img02.jpg" alt="新天和SMW85工法桩机" width="334" height="442" /></a></li>
      </ul>
    </div>
    <div class="shadow"><img src="images/part_shadow.png" width="980" height="20" /></div>
  </div>
</div>
<div class="shopPart04">
  <a id="shopPart04" class="spp"></a>
  <div class="contain980">
    <div class="w100 l mb10">
    <a href="list.jsp?num=101" target="_blank">
    <img src="images/titlebg03.jpg" alt="ZYC系列，液压静力压桩机" width="980" height="138" />
    </a>
    </div>
    <div class="partList">
      <ul>
        <li>
          <a href="/proDetail/ZYC60B.shtm" target="_blank" title="新天和ZYC60B液压静力压桩机" class="img"><img src="images/part_03.jpg" alt="新天和ZYC60B液压静力压桩机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/ZYC60B.shtm" target="_blank">新天和ZYC60B液压静力压桩机</a></h3>
            <span class="l"><a href="/proDetail/ZYC60B.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/ZYC60B_message.shtm" target="_blank">评论</a></span>
            <a onclick="showinquery('9167','')" href="javascript:;" class="plBtn">立即询价</a>
          </div>
        </li>
        <li>
          <a href="/proDetail/ZYC240B-B.shtm" target="_blank" title="新天和ZYC240B-B液压静力压桩机" class="img"><img src="images/part_03-05.jpg" alt="新天和ZYC240B-B液压静力压桩机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/ZYC240B-B.shtm" target="_blank">新天和ZYC240B-B液压静力压桩机</a></h3>
            <span class="l"><a href="/proDetail/ZYC240B-B.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/ZYC240B-B_message.shtm" target="_blank">评论</a></span>
            <a onclick="showinquery('9176','')" href="javascript:;" class="plBtn">立即询价</a>
          </div>
        </li>
        <li>
          <a href="/proDetail/ZYC400B-B.shtm" target="_blank" title="新天和ZYC400B-B液压静力压桩机" class="img"><img src="images/part_03-07.jpg" alt="新天和ZYC400B-B液压静力压桩机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/ZYC400B-B.shtm" target="_blank" >新天和ZYC400B-B液压静力压桩机</a></h3>
            <span class="l"><a href="/proDetail/ZYC400B-B.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/ZYC400B-B_message.shtm" target="_blank">评论</a></span>
            <a onclick="showinquery('9180','')" href="javascript:;" class="plBtn">立即询价</a>
          </div>
        </li>
        <li>
          <a href="/proDetail/ZYC600B-B.shtm" target="_blank" title="新天和ZYC600B-B液压静力压桩机" class="img"><img src="images/part_03-12.jpg" alt="新天和ZYC600B-B液压静力压桩机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/ZYC600B-B.shtm" target="_blank">新天和ZYC600B-B液压静力压桩机</a></h3>
            <span class="l"><a href="/proDetail/ZYC600B-B.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/ZYC600B-B_message.shtm" target="_blank">评论</a></span>
            <a onclick="showinquery('9185','')" href="javascript:;"  class="plBtn">立即询价</a>
          </div>
        </li>
        <li>
          <a href="/proDetail/ZYC800B.shtm" target="_blank" title="新天和ZYC800B液压静力压桩机" class="img"><img src="images/part_03-13.jpg" alt="新天和ZYC800B液压静力压桩机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/ZYC800B.shtm" target="_blank">新天和ZYC800B液压静力压桩机</a></h3>
            <span class="l"><a href="/proDetail/ZYC800B.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/ZYC800B_message.shtm" target="_blank">评论</a></span>
            <a href="javascript:;" onclick="showinquery('9189','')"  class="plBtn">立即询价</a>
          </div>
        </li>
        <li>
          <a href="/proDetail/ZYC1000B-B.shtm" target="_blank" title="新天和ZYC1000B-B液压静力压桩机" class="img"><img src="images/part_03-14.jpg" alt="新天和ZYC1000B-B液压静力压桩机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/ZYC1000B-B.shtm" target="_blank">新天和ZYC1000B-B液压静力压桩机</a></h3>
            <span class="l"><a href="/proDetail/ZYC1000B-B.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/ZYC1000B-B_message.shtm" target="_blank">评论</a></span>
             <a href="javascript:;" onclick="showinquery('9196','')"  class="plBtn">立即询价</a>
          </div>
        </li>
      </ul>
      <div class="moreBtn"><a href="list.jsp?num=101" target="_blank">更多&gt;&gt;</a></div>
    </div>
  <div class="shadow"><img src="images/part_shadow.png" width="980" height="20" /></div>  
  </div>
</div>
<div class="shopPart05"> <a id="shopPart05" class="spp"></a>
  <div class="contain980">
    <div class="w100 l mb10">
    <a href="list.jsp?num=102" target="_blank">
    <img src="images/titlebg04.jpg" alt="CFG系列，液压步履式长螺旋钻机" width="980" height="138" />
    </a>
    </div>
    <div class="partList">
      <ul>
        <li> <a href="/proDetail/CFG-20.shtm" target="_blank" title="新天和CFG20液压步履式长螺旋钻机" class="img"><img src="images/part_03-19.jpg" alt="新天和CFG20液压步履式长螺旋钻机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/CFG-20.shtm" target="_blank">新天和CFG20液压步履式长螺旋钻机</a></h3>
            <span class="l"><a href="/proDetail/CFG-20.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/CFG-20_message.shtm" target="_blank">评论</a></span> 
            <a onclick="showinquery('9200','')" href="javascript:;" class="plBtn">立即询价</a>
             </div>
        </li>
        <li> <a href="/proDetail/CFG-26.shtm" target="_blank" title="新天和CFG26液压步履式长螺旋钻机" class="img"><img src="images/part_03-20.jpg" alt="新天和CFG26液压步履式长螺旋钻机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/CFG-26.shtm" target="_blank">新天和CFG26液压步履式长螺旋钻机</a></h3>
            <span class="l"><a href="/proDetail/CFG-26.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/CFG-26_message.shtm" target="_blank">评论</a></span> <a onclick="showinquery('9201','')" href="javascript:;" class="plBtn">立即询价</a> </div>
        </li>
        <li> <a href="/proDetail/CFG-30.shtm" target="_blank" title="新天和CFG30液压步履式长螺旋钻机" class="img"><img src="images/part_03-18.jpg" alt="新天和CFG30液压步履式长螺旋钻机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/CFG-30.shtm" target="_blank">新天和CFG30液压步履式长螺旋钻机</a></h3>
            <span class="l"><a href="/proDetail/CFG-30.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/CFG-30_message.shtm" target="_blank">评论</a></span> <a onclick="showinquery('9202','')" href="javascript:;" class="plBtn">立即询价</a> </div>
        </li>
      </ul>
      <div class="moreBtn"><a href="list.jsp?num=102" target="_blank">更多&gt;&gt;</a></div>
    </div>
    <div class="shadow"><img src="images/part_shadow.png" width="980" height="20" /></div>
  </div>
</div>
<div class="shopPart06">
  <a id="shopPart06" class="spp"></a>
  <div class="contain980">
    <div class="w100 l mb10">
    <img src="images/titlebg05.jpg" alt="SMW系列，工法桩机，JBY系列，液压步履式桩架" width="980" height="138" border="0" usemap="#Map2" />
    <map name="Map2" id="Map2">
      <area shape="rect" coords="3,3,478,133" href="list.jsp?num=103" target="_blank" />
      <area shape="rect" coords="516,4,981,138" href="list.jsp?num=104" target="_blank"  />
    </map>
    </div>
    
    <div class="partList">
      <ul>
        <li>
          <a href="/proDetail/SMW65.shtm" target="_blank" title="新天和SMW65工法桩机" class="img"><img src="images/part06img01.jpg" alt="新天和SMW65工法桩机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/SMW65.shtm" target="_blank">新天和SMW65工法桩机</a></h3>
            <span class="l"><a href="/proDetail/SMW65.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/SMW65_message.shtm" target="_blank">评论</a></span>
            <a onclick="showinquery('9204','')" href="javascript:;" class="plBtn">立即询价</a>
          </div>
          <div class="moreBtn"><a href="list.jsp?num=103" target="_blank">更多&gt;&gt;</a></div>
        </li>
        <li>
          <a href="/proDetail/JBY-80B.shtm" target="_blank" title="新天和JBY80B液压步履式桩架" class="img"><img src="images/part06img02.jpg" alt="新天和JBY80B液压步履式桩架" /></a>
          <div class="intro">
            <h3><a href="/proDetail/JBY-80B.shtm" target="_blank">新天和JBY80B液压步履式桩架</a></h3>
            <span class="l"><a href="/proDetail/JBY-80B.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/JBY-80B_message.shtm" target="_blank">评论</a></span>
            <a onclick="showinquery('9199','')" href="javascript:;" class="plBtn">立即询价</a>
          </div>
          <div class="moreBtn"><a href="list.jsp?num=104" target="_blank">更多&gt;&gt;</a></div>
        </li>
      </ul>
    </div>
    <div class="shadow"><img src="images/part_shadow.png" width="980" height="20" /></div>  
  </div>
</div>

<div class="shopPart07">
<a id="shopPart07" class="spp"></a>
  <div class="contain980">
    <div class="w100 l mb10">
    <img src="images/titlebg06.jpg" alt="LGZ系列，液压步履式螺杆桩机，WB系列，沥青路面微波养护机" width="980" height="138" border="0" usemap="#Map" />
    <map name="Map" id="Map">  
      <area shape="rect" coords="5,4,475,131" href="list.jsp?num=105" target="_blank" />
      <area shape="rect" coords="538,4,973,137"  href="list.jsp?num=106" target="_blank" />
    </map>
    </div>
    <div class="partList">
      <ul>
        <li>
          <a href="/proDetail/LGZ20.shtm" target="_blank" title="新天和LGZ20液压步履式螺杆桩机" class="img"><img src="images/part07img01.jpg" alt="新天和LGZ20液压步履式螺杆桩机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/LGZ20.shtm" target="_blank">新天和LGZ20液压步履式螺杆桩机</a></h3>
            <span class="l"><a href="/proDetail/LGZ20.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/LGZ20_message.shtm" target="_blank">评论</a></span>
            <a onclick="showinquery('9206','')" href="javascript:;" class="plBtn">立即询价</a>
          </div>
          <div class="moreBtn"><a href="list.jsp?num=105" target="_blank">更多&gt;&gt;</a></div>
        </li>
        <li>
          <a href="/proDetail/TWB-81.shtm" target="_blank" title="新天和TWB81沥青路面微波养护机" class="img"><img src="images/part07img02.jpg" alt="新天和TWB81沥青路面微波养护机" /></a>
          <div class="intro">
            <h3><a href="/proDetail/TWB-81.shtm" target="_blank">新天和TWB81沥青路面微波养护机</a></h3>
            <span class="l"><a href="/proDetail/TWB-81.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/TWB-81_message.shtm" target="_blank">评论</a></span>
            <a onclick="showinquery('9203','')" href="javascript:;" class="plBtn">立即询价</a>
          </div>
          <div class="moreBtn"><a href="list.jsp?num=106" target="_blank">更多&gt;&gt;</a></div>
        </li>
      </ul>
    </div>
    <div class="shadow"><img src="images/part_shadow.png" width="980" height="20" /></div>
  </div>
</div>

<div class="shopPart08">
  <a id="shopPart08" class="spp"></a>
  <div class="contain980">
    <div class="title">
      <h3><img width="980" height="45" alt="推荐产品" src="images/titlebg07.png"></h3>
      <span class="more"><a href="/inquiry/?factory=1236" target="_blank">更多&gt;&gt;</a></span>
    </div>
    <div class="content">
    
      <div class="w978 border03 l list08">
        <div class="title08">
       <%
       	DBHelper dbHelper = DBHelper.getInstance() ;
       	String order_sql = "select factoryid,id,factoryname,product_name,contact_address,cataname,name,mobile_phone,province,city,add_date from pro_product_form where factoryid=1236 and product_name is not null and product_name != '' order by add_date desc" ;
        List<Map> pro_orders = dbHelper.getMapList(order_sql) ;
       %>
          <h3><b>询价总数：<%=pro_orders.size() %></b> - 采购询价</h3>
          <span>共有<font><%=pro_orders.size() %></font>个符合条件</span> </div>
        <ul class="ti">
          <li class="i1">编号</li>
          <li class="i2">询价产品</li>
          <li class="i3">联系人</li>
          <li class="i4">电话</li>
          <li class="i5">询价品牌</li>
          <li class="i6">询价区域</li>
          <li class="i7">询价时间</li>
        </ul>
        <div class="li">
	  <%
	  if(null!=pro_orders && pro_orders.size()>0){
		  int k = pro_orders.size()>10?10:pro_orders.size() ;
      	 String showtel = "" ; 
      	 Map oneMap = null ;
	  	 for(int i=0;i<k;i++){
	  		oneMap = pro_orders.get(i) ;
    		showtel = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("contact_tel")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
    		
    		if(showtel.length()>7&&showtel.length()<=20){
    			showtel = showtel.substring(0,3)+"***"+showtel.substring(showtel.length()-3) ;
    		}else if(showtel.length()>3){
    			showtel = showtel.substring(0,4)+"***" ;
    		}else
    		{
    			showtel = showtel+"***" ;
    		}
    		%>
    		 <ul class="libg01">
            <li class="i1"><%=i+1 %></li>
            <li class="i2"><a href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
            <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
            <li class="i4"><%=showtel %></li>
            <li class="i5"><a target="_blank" href="/inquiry/?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
            <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
            <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
          </ul>
    		<%
    		
	  	 }
	  }
	  %>
        </div>
      </div>
    </div>
  <div class="clear"></div>  
  </div>
  <!--foot-->
<div class="footbg" style="background: none repeat scroll 0 0 transparent;">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
  <!--end of foot-->
</div>
<!--main end--> 
<script type="text/javascript">
(function(jQuery){
 jQuery.extend(jQuery.fn,{
 scrollTo:function(time,to){
 time=time||800;
 to=to||1;
            jQuery('a[href*=#]', this).click(function(){
                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && 
location.hostname == this.hostname) {
      var jQuerytarget = jQuery(this.hash);
     jQuerytarget = jQuerytarget.length && jQuerytarget || jQuery('[name=' + this.hash.slice(1) + ']');
                    if (jQuerytarget.length) {
                        if (to == 1) {
                            jQuery('html,body').animate({
                                scrollTop: jQuerytarget.offset().top
                            }, time);
                        }
                        else if(to==2){
                            jQuery('html,body').animate({
                                scrollLeft: jQuerytarget.offset().left
                            }, time);
                        }else{
alert('argument error');
  }
                        return false;
                    }
                }
            });
  }
 });
})(jQuery);
</script>
<script type="text/javascript" language="javascript">
jQuery(function(){
  jQuery(".proCate").scrollTo(700)
});
</script>
<script type="text/javascript">
jQuery("body").bind("contextmenu", function() {
  return false;
});
</script> 
<script type="text/javascript" language="javascript">
//营销宝统计
jQuery(function(){
  jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'1236'} ,
    	success:function(msg){
    	}
    }) ;
});
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=38266406&site=qq&menu=yes" class="floatQQ"><img border="0" src="http://wpa.qq.com/pa?p=2:38266406:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
</body>
</html>