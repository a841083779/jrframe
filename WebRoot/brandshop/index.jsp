<%@ page language="java" import="java.util.*,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="工程机械,工程机械产品中心" />
<meta name="description" content="工程机械产品大全涵盖了挖掘机、装载机、起重机等各种工程机械产品。找挖掘机、装载机请来中国工程机械商贸网。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>湖南新天和官方旗舰店_中国工程机械商贸网21-sun.com</title>
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
	jQuery("#slider .bgs li").hover(function(){
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
<body class="flag_shop">
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
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
<!--<div class="shopPart01">
  <div class="contain980 pt20">
    <div class="coupon_top">
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
    </div>
    
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
</div>-->
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
    <div class="w100 l mb20">
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
    <div class="w100 l mb20">
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
    </div>
    <div class="shadow"><img src="images/part_shadow.png" width="980" height="20" /></div>
  </div>
</div>
<div class="shopPart06">
  <a id="shopPart06" class="spp"></a>
  <div class="contain980">
    <div class="w100 l mb20">
    <a href="list.jsp?num=103" target="_blank">
    <img src="images/titlebg05.jpg" alt="SMW系列，工法桩机，JBY系列，液压步履式桩架" width="980" height="138" border="0" usemap="#Map2" />
    <map name="Map2" id="Map2">
      <area shape="rect" coords="3,3,478,133" href="list.jsp?num=103" target="_blank" />
      <area shape="rect" coords="516,4,981,138" href="list.jsp?num=104" target="_blank"  />
    </map>
    </div>
    </a>
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
    <div class="w100 l mb20">
    <a href="list.jsp?num=105" target="_blank">
    <img src="images/titlebg06.jpg" alt="LGZ系列，液压步履式螺杆桩机，WB系列，沥青路面微波养护机" width="980" height="138" border="0" usemap="#Map" />
    <map name="Map" id="Map">  
      <area shape="rect" coords="5,4,475,131" href="list.jsp?num=105" target="_blank" />
      <area shape="rect" coords="538,4,973,137"  href="list.jsp?num=106" target="_blank" />
    </map>
    </a>
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
  </div>
</div>

<!--main end--> 
<!--foot-->
<div class="footbg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot-->
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
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>