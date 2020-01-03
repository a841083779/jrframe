<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String province = "";
	String city = "";
	String ip  = Common.getIp(request);
	//ip="119.180.60.125";
	String objStr = Tools.getMyProvinceAndCity(ip);
		JSONObject obj = new JSONObject(objStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>优买团-工程机械团购、工程机械购机、工程机械打折，购买超级优惠_中国工程机械商贸网</title>
<meta name="keywords" content="工程机械团购,工程机械购机大全,工程机械交易中心" />
<meta name="description" content="中国工程机械商贸网发起为大宗采购商,整机厂家,代理商,VIP会员,终端用户提供专属、高效、长期交易平台,贴心服务,共享优惠,咨询热线:0535-6727793" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="scripts/jquery.SuperSlide.js"></script>
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
</head>
<body>
<div class="top">
  <div class="wrap">
	<div class="logo"><img src='images/logo.gif'/></div>
    <div class="img mr30"> <img src='images/ymt.gif'/></div>
    <div class="city">
    	<span><%=city%></span>
    </div>
    <div class="search">
    	<input name="keyword" id="keyword" type="text" class="txt" onKeyDown="tj2();"/>
        <input type="button" class="btn" onclick="tj3();"/>
    </div>
	<script>
		  function tj2(){
		  if((event.ctrlKey&&window.event.keyCode==13)||window.event.keyCode==13) {
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("/search/"+keyword+"_0_0_0.htm","target");
		  }
		  }
		  
		  		  		  function tj3(){
		
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("/search/"+keyword+"_0_0_0.htm","target");
		 
		  }
	</script>
    <div class="tel">
    	<img src='images/tel.gif'/>
    </div>
  </div>
</div>
<div class="nav">
	<ul class="wrap">
    	<li class="quick">快速导航</li>
		<li><a href="index.jsp">首页</a></li>
        <li><a href="index.jsp?catalog=101001">挖掘机</a></li>
        <li><a href="index.jsp?catalog=101002">装载机</a></li>
        <li><a href="part.jsp">配件</a></li>
        <li><a href="index.jsp?catalog=113001">破碎锤</a></li>
        <li><a href="index.jsp?catalog=other">其他设备</a></li>
        <li><a href="http://koubei.21-sun.com">铁臂口碑</a></li>
        <li><a href="activity.jsp">专题活动</a></li>
    </ul>
</div>
<div class="actCon wrap">
	<div class="con1">
    	<div class="slideImg">
        	<div class="bd">
            	<ul>
                 <li><a href="http://product.21-sun.com/tuan/cat/" target="_blank" title="卡特彼勒机型争霸江湖，总有一款随你笑看风云"><img src="images/cat_wjjlx.jpg" alt="卡特彼勒机型争霸江湖，总有一款随你笑看风云" width="757" height="365" /></a></li>
                  <li ><a href="http://product.21-sun.com/tuan/zzj/" target="_blank" title="铁臂为您提供优质的产品，诱人的价格。 铁臂价格便宜，服务不打折"><img src="images/zzjhdlx.jpg" alt="铁臂为您提供优质的产品，诱人的价格。 铁臂价格便宜，服务不打折" width="757" height="365" /></a></li>
                <li><a href="http://product.21-sun.com/tuan/201405/" target="_blank" title="5月优买团促销活动"><img src="images/tb_ymt.jpg" alt="5月优买团促销活动" width="757" height="365" /></a></li> 
        <li><a href="http://product.21-sun.com//tuan/201404/yh/" target="_blank" title="4月优买团促销活动"><img src="images/bn.jpg" alt="4月优买团促销活动" width="757" height="365" /></a></li> 
     
       <li><a href="http://product.21-sun.com/activity/rongrun/index.jsp" target="_blank" title="购龙工50系列节能环保机型，共筑绿色中国梦"><img src="images/rongrun.jpg" alt="购龙工50系列节能环保机型，共筑绿色中国梦" width="757" height="365" /></a></li>
        
        <li><a href="http://product.21-sun.com/tuan/doosan_ganen/index.htm" target="_blank" title="斗山感恩回馈"><img src="images/ds.jpg" alt="斗山感恩回馈" width="757" height="365" /></a></li>
        <li><a href="http://product.21-sun.com/tuan/activity/index.htm" target="_blank" title="卡特彼勒装载机"><img src="images/kate.jpg" alt="卡特彼勒装载机" width="757" height="365" /></a></li>
       
                </ul>
            </div>
            <div class="hd">
            	<ul></ul>
            </div>
        	
        </div>
        <script type="text/javascript">jQuery(".slideImg").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:"<li><a></a></li>",effect:"left",autoPlay:true,pnLoop:true,vis:1}); </script>
        <div class="l"> 
        	<a href="http://product.21-sun.com/proDetail/307E.shtm" target="_blank"><img src='images/a-2.jpg'/></a>
            <a href="http://product.21-sun.com/proDetail/LG6060D.shtm" target="_blank"><img src='images/a-3.jpg'/></a>
        </div>
    </div>
  <div class="retrieval">
  	<form>
    	<label>检索您感兴趣的活动:</label>
    	<select><option>按年份检索</option></select>
        <select><option>按活动类型检索</option></select>
        <input type="text" class="txt" value="按活动标题"/>
    	<input type='button' class="js btn" value="检索"/>
        <input type='button' class="reset btn" value='重置'/>
    </form>
  </div>
 	<dl class="d1">
    	<dt class="dt">优买团活动</dt>
        <dd><a href="http://product.21-sun.com/tuan/zzj/" target="_blank">
        	<img src='images/zzjzt.jpg' alt=""/>
            <h3>我们就在你身边</h3>
            <p>铁臂为您提供优质的产品，诱人的价格。 铁臂价格便宜，服务不打折。
</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
<dd><a href="http://product.21-sun.com/tuan/201405/" target="_blank">
        	<img src='images/d1.jpg' alt=""/>
            <h3>五月优买团</h3>
            <p>五月优惠促销，新机、配件促销,买工程机械就来铁臂商城</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com//tuan/201404/yh/" target="_blank">
        	<img src='images/d2.jpg' alt=""/>
            <h3>四月优买团'非TA不嫁'</h3>
            <p>4月优买团新机,配件，挖掘机优惠促销</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/tuan/201403/jzfb/" target="_blank">
        	<img src='images/d3.jpg' alt=""/>
            <h3>三月优买团——惊折风暴</h3>
            <p>惊折风暴，优惠来袭，新机、二手机、配件促销,买工程机械就来铁臂商城</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/tuan/201401/ym/index.htm" target="_blank">
        	<img src='images/d4.jpg' alt=""/>
            <h3>优买团2014年1月优惠促销</h3>
            <p>21-sun优买团，这里让你购机更轻松，这里是众多终端用户上网购机的首选平台，每天有上万的终端用户汇集在这里选机比价</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/tuan/december/" target="_blank">
        	<img src='images/d5.jpg' alt=""/>
            <h3>十二月优买团——2013年终惠</h3>
            <p>优买团品牌汇聚，2013年终惠</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/tuan/november/" target="_blank">
        	<img src='images/d6.jpg' alt=""/>
            <h3>十一月优买团——我们的故事</h3>
            <p>每天有上万的终端用户汇集在这里选机比价，最终这里汇集了他们和我们的故事。</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/tuan/october/" target="_blank">
        	<img src='images/d7.jpg' alt=""/>
            <h3>十月优买团，待我长发及腰，拖我回家可好</h3>
            <p>10月优买团优惠购机,卡特新品,三一新品,小松挖掘机,龙工装载机,山推压路机。</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/tuan/september/" target="_blank">
        	<img src='images/d8.jpg' alt=""/>
            <h3>优买团9月优惠购机</h3>
            <p>品牌英雄汇，全民盛宴，卡特挖掘机，小松挖掘机，三一挖掘机，山推装载机，山工装载机，龙工装载机等专场优惠。</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/tuan/august/index.htm" target="_blank">
        	<img src='images/d9.jpg' alt=""/>
            <h3>八月优买团，梦想新航线，未来合伙人</h3>
            <p>徐工挖掘机专场、江麓挖掘机专场、斯帕克破碎锤专场、山工装载机专场、卡特挖掘机专场、三一挖掘机专场大型促销活动 。</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
     </dd>
         <dd><a href="http://ad.21-sun.com/link_to.jsp?paras=12,0,100034&url=http://product.21-sun.com/tuan/july/" target="_blank">
        	<img src='images/d10.jpg' alt=""/>
            <h3>奋起吧，优买团！</h3>
            <p>7月优买团优惠购机,卡特迷你挖掘机,山工装载机,三一挖掘机,卡特配件,日立配件,江麓挖掘机,福田挖掘机。</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/tuan/june/" target="_blank">
        	<img src='images/d11.jpg' alt=""/>
            <h3>六月逆袭，优买团优惠购机</h3>
            <p>在优买团下订单皆可享受超值优惠政策,包括三一、卡特、山工、徐工、江麓、福田挖掘机、烟台军恒斯帕克破碎锤专场优惠。</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://ad.21-sun.com/link_to.jsp?paras=0,0,100023&url=http://product.21-sun.com/tuan/may/" target="_blank">
        	<img src='images/d12.jpg' alt=""/>
            <h3>优买团5月优惠购机</h3>
            <p>徐工挖掘机专场、江麓挖掘机专场、斯帕克破碎锤专场、山工装载机专场、卡特挖掘机专场、三一挖掘机专场大型促销活动 。</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://ad.21-sun.com/link_to.jsp?paras=1,0,100016&url=http://product.21-sun.com/tuan/april/" target="_blank">
        	<img src='images/d13.jpg' alt=""/>
            <h3>4月优买团大事件掀起万人团购劲爆狂潮</h3>
            <p>山工平地机免费试驾、临沂亚华三一挖机订货会期间，订机客户，均可享受三重优惠大礼、湖南中旺购机送破碎锤、浙江永弘斗山挖机促销、杭州威格尔不用抽奖，不靠运气，买就送！相同配置比价格，相同价格比配置，徐工最优！</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
        </dd>
       
    </dl> 
    <dl class="d1">
    	<dt class="dt">企业活动</dt>
        <dd><a href="http://product.21-sun.com/tuan/cat/" target="_blank">
        	<img src='images/cat.jpg' alt=""/>
            <h3>“效”傲江湖 智勇对决</h3>
            <p>卡特彼勒机型争霸江湖，总有一款随你笑看风云。
是灵动的306E？是中坚力量320DGC？还是大块头有大智慧的349D？总有一款让你运筹帷幄，效傲江湖。
</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
        </dd>
        <dd><a href="http://product.21-sun.com/activity/rongrun/index.jsp" target="_blank">
        	<img src='images/rongrunx.jpg' alt=""/>
            <h3>与龙工“秘密”约会</h3>
            <p>购龙工50系列节能环保机型，共筑绿色中国梦</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
        </dd>
<dd><a href="http://product.21-sun.com/tuan/juhe/" target="_blank">
        	<img src='images/d14.jpg' alt=""/>
            <h3>广州巨和聚爱狂欢实惠到家</h3>
            <p>和合集团8周年，和心相伴合力共赢，聚爱狂欢实惠到家，相约和合好事连连</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/tuan/doosan_ganen/index.htm" target="_blank">
        	<img src='images/d15.jpg' alt=""/>
            <h3>斗山感恩回馈大型让利促销</h3>
            <p>每天有上万的终端用户汇集在这里选机比价，最终这里汇集了他们和我们的故事。</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
    </dd>
        <dd><a href="http://product.21-sun.com/tuan/sany_spring/index.jsp" target="_blank">
        	<img src='images/d16.jpg' alt=""/>
            <h3>广东三一春季大型订</h3>
            <p>品质三一，相约一世</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://ad.21-sun.com/link_to.jsp?paras=12,17,100015&url=http://product.21-sun.com/tuan/semsj/" target="_blank">
        	<img src='images/d17.jpg' alt=""/>
            <h3>山工平地机免费试用火热招募中</h3>
            <p>好机械用过才知道！山工机械支持您对品质的苛刻，给您长达2周时间免费试用山工平地机，<br>
              在试用后订购更可获得价值5000元的配件！<br>
            试用机会全国仅限10名，2013年4月15日&mdash;5月15日报名参加，还能赢取精美平地机模型。</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/activity/hthsy/" target="_blank">
        	<img src='images/d18.jpg' alt=""/>
            <h3>宏通好声音，三一挖掘机乐享惠</h3>
            <p>2013年3月18日，潍坊三一重机宏通机械大型订货会。全系产品全城乐享惠！三重大礼等你拿！一重礼：活动注册礼上礼！二重礼：全系产品大促销 挑战底线！三重礼：购机抽大奖！</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/activity/yhsy/" target="_blank">
        	<img src='images/d19.jpg' alt=""/>
            <h3>约惠三一，中旺大型订货会</h3>
            <p>2013年3月17日，湖南中旺三一挖掘机线上购机活动全系产品全城乐享惠！购SY60-SY185机型客户一等奖：3.8万皮卡车（1名）、二等奖：13180元代金券（2名）、三等奖：3180元配件（12名）等。</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
      </dd>
        <dd><a href="http://product.21-sun.com/activity/yhqg/index.jsp" target="_blank">
        	<img src='images/d20.jpg' alt=""/>
            <h3>斗山315抢购</h3>
            <p>2013年3月15日10:00-10:30，斗山山东地区挖掘机抢购会活动拉开帷幕。最高优惠8.5折购买DX345LC挖掘机，DX380LC挖掘机3年6000小时超长保修期及15000元优惠券等以及参与即可获得参与活动产品2000小时保养配件及5000元优惠券。</p>
            <div class="view"><em>阅读全部</em></div>
            </a>
        </dd>
    </dl>  
</div>
<div class="bottom">
	<div class="wrap">
	<span class="l">中国工程机械商贸网 Copyright © 2000-2014 </span>	
    <div class="r">客服：9:00-21:00<em>|</em>4006-521-526</div>
    </div>
 </div>
</body>
</html>