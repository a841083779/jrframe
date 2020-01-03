<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> waProductsList = new ArrayList() ;
	List<Map> zhuangProductsList = new ArrayList() ;
	List<Map> tuiProductsList = new ArrayList() ;
	List<Map> heziProductsList = new ArrayList() ;
	String zhuang_sql = "select top 3 * from pro_agent_product_vi where factoryid=139 and catalognum LIKE '101002%'  and is_show=1 AND agentid=1202 " ; 
	String wa_sql = " select top 3 * from pro_agent_product_vi where factoryid=183 and catalognum LIKE '101001%' and zoomlion_hot=11 AND agentid=1202 and is_show=1" ; 
	String tui_sql = " select top 3 * from pro_agent_product_vi where factoryid=154 and catalognum LIKE '101003%' and zoomlion_hot=11 and is_show=1 AND agentid=1202 " ; 
	String hezi_sql = " select top 3 * from pro_agent_product_vi where factoryid=16373 and catalognum LIKE '101001%' and zoomlion_hot=11 and is_show=1 AND agentid=1202 " ; 
	
	heziProductsList = dbHelper.getMapList(hezi_sql+"order by order_no");
	zhuangProductsList = dbHelper.getMapList(zhuang_sql+"order by order_no");
	waProductsList = dbHelper.getMapList(wa_sql+"order by order_no");
	tuiProductsList = dbHelper.getMapList(tui_sql+"order by order_no");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>中远机械 - 中国工程机械商贸网</title>
<meta name="keywords" content="中远机械,中远机械产品报价,中远机械产品,中远机械产品图片,中远机械产品介绍,中远机械介绍" />
<meta name="description" content="中国工程机械商贸网为您提供中远机械介绍,中远机械产品介绍,中远机械产品报价,中远机械产品图片,中远机械产品展示等中远机械产品信息，帮助您全面了解中远机械。" />

<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="scripts/jquery.SuperSlide.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<link href="http://product.21-sun.com/style/brandshop_top.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />


<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
</head>
<body>
<div class="brand_topBar ">
  <div class="contain980 clearfix ">
    <div class="visit_21sun"><a target="_blank" href="http://product.21-sun.com/" title="返回铁臂商城"><img src="http://product.21-sun.com/images/brandshop_toppoint.gif" /> 返回铁臂商城</a></div>
    <script type="text/javascript">
	jQuery(function(){
		jQuery(".loginLinks_new li").hover(function(){
			jQuery(this).toggleClass("hover");
		},function(){
			jQuery(this).removeClass("hover");
		});
	});
	</script>
    <ul class="loginLinks_new">
      <li class=""><a target="_blank" href="http://product.21-sun.com/agent/login.jsp">厂家登录</a></li>
      <li class=""><a target="_blank" href="http://product.21-sun.com/agent/login.jsp">代理商登录</a></li>
    </ul>
    <ul class="tlRight">
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/products/">产品大全</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/brand/">品牌大全</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/news/">行情导购</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/inquiry/">采购询价</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/photo/">产品图库</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/top_list/">排行榜</a></li>
      <li class="tl"><a target="_blank" href="http://product.21-sun.com/agent/">代理商专区</a></li>
      <li onmouseout="hideOther()" onmouseover="showOther()" class="guide"><span class="gt">网站导航</span>
        <ul id="other">
          <li onclick="window.open('http://market.21-sun.com/');" style="color:#434343">供求市场</li>
          <li onclick="window.open('http://news.21-sun.com/');" style="color:#434343">行业动态</li> 
          <li onclick="window.open('http://product.21-sun.com/');" style="color:#434343">整机市场</li>
          <li onclick="window.open('http://www.21-sun.com/part/');" style="color:#434343">配件市场</li>
          <li onclick="window.open('http://www.21-rent.com/');" style="color:#434343">租赁调剂</li>
          <li onclick="window.open('http://www.21part.com/');" style="color:#434343">杰 配 网</li>
          <li onclick="window.open('http://www.21peitao.com/');" style="color:#434343">配 套 网</li>
          <li onclick="window.open('http://www.21-sun.com/supply/');" style="color:#434343">供 应 商</li>
          <li onclick="window.open('http://www.21-cmjob.com/');" style="color:#434343">招聘求职</li>
          <li onclick="window.open('http://data.21-sun.com/');" style="color:#434343">数据分析</li>
          <li onclick="window.open('http://www.21-sun.com/bidding/');" style="color:#434343">招 投 标</li>
          <li onclick="window.open('http://stock.21-sun.com/');" style="color:#434343">行业股市</li>
        </ul>
      </li>
    </ul>
  </div>
</div>

<div class="brand_topbg brand_top">
<div class="top contain980 ">
  <h1><a href="http://product.21-sun.com/" title="铁臂商城"><img width="220" height="72" alt="铁臂商城" src="images/new_logo.png" title="铁臂商城"></a></h1>
  <div class="new_topMid">
    <ul class="news_topSearch">  
        <li class="ntsi">  
          <input type="text" onkeydown="tj2();" name="keyword" id="keyword" maxlength="30" value=""/>
        </li>
        <li class="ntsb">     
          <input type="submit" onclick="tj3();" id="button" value="&nbsp;"/>  
        </li>
          <input type="hidden" name="f" value="product"/> 
    </ul>
      <div class="hotWords">热门搜索： <a target="_blank" href="/search/挖掘机_0_0_0.htm"><b>挖掘机</b></a> <a target="_blank" href="/search/装载机_0_0_0.htm">装载机</a> <a target="_blank" href="/search/起重机_0_0_0.htm">起重机</a> <a target="_blank" href="/search/卡特彼勒挖机_0_0_0.htm" class="link09"> 卡特彼勒挖机</a> </div>
  </div>
          <script>
		  function showOther(){
		  document.getElementById('other').style.display="block";
		  }
		  function hideOther(){
		  document.getElementById('other').style.display="none";
		  }
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
  <div class="topHot" id="topHot">
  <img width="260" height="80" src="images/tu5.gif" />
  </div>
  
  <script type="text/javascript">
  var count3 = 0;
    count3=jQuery(".thl li").length;
	jQuery(".thl li").hide();
	jQuery(".thl li:first").show();
	jQuery("#topHot").show();
	jQuery(".thn li").click(function() {
		var i = jQuery(this).text() - 1;
		n3 = i;
		if (i >= count3) return;
		jQuery(".thl li").filter(":visible").fadeOut(800).parent().children().eq(i).fadeIn(800);
		jQuery(this).toggleClass("on");
		jQuery(this).siblings().removeAttr("class");
	});
	t3 = setInterval("showAuto3()", 11000);
	jQuery("#topHot").hover(function(){clearInterval(t3)}, function(){t3 = setInterval("showAuto3()", 11000);});
  </script>
</div>
</div>


<div class="g_top">
    	<div class="wrap clearfix">
    	<h1 class="logo"><a href="" title=""><img src="images/logo.png" alt=""/></a></h1>
        <a class="collect" href="javascript:void();" onclick="addShop()" title=""><img src="images/collect.png" alt=""/></a>
        <p>原装神钢挖掘机、宣工推土机、<br />厦工机械产品河南地区总代理</p>
        </div>
    </div>
<div class="g_nav">
    	<ul class="wrap">
          <li><a href="/agentstore/henanzhongyuan/index.jsp">首页</a></li>
          <li><a href="/agentstore/henanzhongyuan/yuanwa_list.jsp" >原装神钢挖掘机</a></li>
          <li><a href="/agentstore/henanzhongyuan/hezi_list.jsp" >合资神钢挖掘机</a></li>
          <li><a href="/agentstore/henanzhongyuan/tui_list.jsp" >宣工推土机</a></li>
          <li><a href="/agentstore/henanzhongyuan/zhuang_list.jsp">厦工机械产品</a></li>
          <li><a href="#jieshao">公司介绍</a></li>
          <li><a href="#lianxi">联系方式</a></li>
        </ul>
    </div>
       <div class="g_banner" style="padding-top:-50px;">
    	<div class="bd">
          <ul>
            <li><a href="" title=""><img src="images/banner.jpg" alt="" /></a></li>
            <li><a href="" title=""><img src="images/banner2.jpg" alt="" /></a></li>
            <li><a href="" title=""><img src="images/banner3.jpg" alt=""/></a></li>
          </ul>
        </div>
         <div class="hd">
          <ul>
            <li></li>
            <li></li>
            <li></li>
          </ul>
        </div>
         <a class="barr next"></a>
         <a class="barr prev"></a>
         
    </div>
          <script>jQuery(".g_banner").slide({mainCell:".bd ul",effect:"left",autoPlay:true,vis:1}); </script>

	<div class="g_link">
    	<div class="wrap clearfix">
    	<ul class=" ">
          <li><a href="/agentstore/henanzhongyuan/yhwa_list.jsp"><img src="images/a1.jpg" alt=""/></a></li>
          <li><a href="/agentstore/henanzhongyuan/tui_list.jsp"><img src="images/a2.jpg" alt=""/></a></li>
          <li><a href="/agentstore/henanzhongyuan/zhuang_list.jsp"><img src="images/a3.jpg" alt=""/></a></li>
        </ul>
        </div>
    </div>
    <div class="g_pro">
    	<div class="p1 pp"> <a href="http://product.21-sun.com/proDetail/SK200-8.shtm" target="_blank" title="神钢SK200-8挖掘机"><img src="images/pic1.jpg" usemap="#Map" border="0"/></a>
          <map name="Map" id="Map">
         <a href="javascript:;" onclick="showinquery('251','');">   <area shape="rect" coords="490,256,672,302" href="javascript:void();" /></a>
          </map>
    	</div>
        <div class="p2 pp"><a href="http://product.21-sun.com/proDetail/XG806.shtm" target="_blank" title="厦工XG809E挖掘机"><img src="images/pic809.jpg" usemap="#Map2" border="0"/></a>
          <map name="Map2" id="Map2">
          <a href="javascript:;" onclick="showinquery('281','');">  <area shape="rect" coords="991,267,1169,312" href="javascript:void();" /></a>
          </map>
        </div>
    	<div class="p3 pp"><a href="http://product.21-sun.com/proDetail/XG955Ⅲ.shtm" target="_blank" title="厦工XG955Ⅲ轮式装载机"><img src="images/pic3.jpg" usemap="#Map3" border="0"/></a>
          <map name="Map3" id="Map3">
            <a href="javascript:;" onclick="showinquery('20373','');"><area shape="rect" coords="490,218,672,260" href="javascript:void();" /></a>
          </map>
    	</div>
    </div>
    <div class="con1">
    <div class="g_tit">
      <div class="wrap clearfix">
    	<h2>合资神钢挖掘机</h2>
        <a href="/agentstore/henanzhongyuan/hezi_list.jsp"  target="_blank" class="more">查看更多>></a>
      </div>
    </div>
    <ul class="pro1 wrap proList">
    <% 
    	if(waProductsList.size()>0 && waProductsList!=null){
    		for(Map oneMap:waProductsList){
    			%>
    			<li><a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="<%="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="284" height="221"/></a>
                <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></h3>
                <a href="javascript:;" class="order_btn"  onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','');"></a>
               </li>
    			<%
    		}
    	}
    %>
    </ul>
    </div>
    
      <div class="con1">
    <div class="g_tit tit3">
      <div class="wrap clearfix">
    	<h2>原装神钢挖掘机</h2>
        <a href="/agentstore/henanzhongyuan/yuanwa_list.jsp"  target="_blank" class="more">查看更多>></a>
      </div>
    </div>
      <ul class="pro3 wrap proList">
    <% 
    	if(heziProductsList.size()>0 && heziProductsList!=null){
    		for(Map oneMap:heziProductsList){
    			%>
    			<li><a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="<%="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="284" height="221"/></a>
                <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></h3>
                <a href="javascript:;" class="order_btn"  onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','');"></a>
               </li>
    			<%
    		}
    	}
    %>
    </ul>
    </div>
    
    <div class="con2">
    <div class="g_tit tit2">
      <div class="wrap clearfix">
    	<h2>宣工推土机</h2>
        <a href="/agentstore/henanzhongyuan/tui_list.jsp" target="_blank" class="more">查看更多>></a>
      </div>
    </div>
    
    <ul class="pro2 wrap proList">
     <% 
    	if(tuiProductsList.size()>0 && tuiProductsList!=null){
    		for(Map oneMap:tuiProductsList){
    			%>
    			<li><a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="<%="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="284" height="221"/></a>
               <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></h3>
                <a href="javascript:;" class="order_btn"  onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','');"></a>
               </li>
    			<%
    		}
    	}
    %>
    </ul>
    </div>
    <div class="con3">
    <div class="g_tit tit3">
      <div class="wrap clearfix">
    	<h2>厦工机械产品</h2>
        <a href="/agentstore/henanzhongyuan/zhuang_list.jsp" target="_blank" class="more">查看更多>></a>
      </div>
    </div>
    <ul class="pro3 wrap proList">
 <% 
    	if(zhuangProductsList.size()>0 && zhuangProductsList!=null){
    		for(Map oneMap:zhuangProductsList){
    			%>
    			<li><a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="<%="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="284" height="221"/></a>
                <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></h3>
                <a href="javascript:;" class="order_btn"  onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','');"></a>
                </li>
    			<%
    		}
    	}
    %>
      
    </ul>
    </div>
    <div class="con4">
    <div class="g_tit tit4" id="jieshao">
      <div class="wrap clearfix">
    	<h2>公司介绍</h2>
      </div>
    </div>
     <div class="about wrap">
     	<img src="images/about.jpg" style=" margin-bottom:0;"/>
     	<p>　　中远机械集团，创建于2001年，是国内最具规模的工程机械销售、服务代理商之一；集著名品牌机械的销售、租赁、配件维修服务、工程施工于一体；公司在创办初期就秉承“客户第一、团队合作、追求卓越、回报社会”的经营理念，以高品质的品牌产品，完善的销售、服务区域网络管理，地区二级联销体系，全新的规范理念、独特的管理模式，成为业内的典范。<br />
　　中远机械集团目前主要战略合作的企业有：厦门海翼集团、神钢集团(日本)、成都神钢集团(合资)、河北钢铁集团；现为河南、安徽、江苏省的神钢、厦工等品牌的唯一授权省级总代理商，旗下六家子公司，一所职业技术学校，六家子公司下设分公司39个，办事处27个，服务站32个，管辖二级代理17个，网络密集，辐射范围覆盖3个省份。<br />
        
        　　集团公司现拥有正式员工613人，销售、服务车辆231辆，旗下设立机械租赁工程部、配件服务中心等独立产业单位，拥有经授权的国外、国内原厂配件供应，以专业的维修队伍和设备运输车辆服务于用户群体。</p>
     	<p>　　集团公司专注于工程机械行业发展，坚持以人为本、海纳百川的企业发展思路，通过自身实力整合资源、优化渠道关系进行多元化发<br />
     	  展、打造多元化产业链，坚持“一切以满足客户需求”为中心，争创“最佳印象、最佳选择”的品牌代理商形象，一马当先、做工程机械行业的开拓者、领跑者！</p>
     </div>
    </div>
<div class="con5" id="lianxi">
    	<div class="g_tit tit5">
          <div class="wrap clearfix">
            <h2>联系方式</h2>
       
          </div>
        </div>
    	<div class="wrap fix">
         <table border="0" cellpadding="0" cellspacing="0" width="50%">
            <tbody>
              <tr>
                <td><strong>[中远机械集团]<br />
</strong>神钢挖掘机、厦工机械产品、宣工推土机总代理<strong><br />
              </strong>地址：郑州市郑东新区绿地原盛国际<br />
                  邮　编：450000<br />

                网　址：<a href="http://www.hnzyjx.com.cn">http://www.hnzyjx.com.cn/</a></td>
              </tr>
              
              <tr>
                <td><strong>[销售部]　</strong>电话：0371-86001111   传真：0371-0371-86226610</td>
              </tr>
            </tbody>
          </table>
                    <table border="0" cellpadding="0" cellspacing="0" width="50%">
            <tbody>
              <tr>
                <td><p><strong>[河南成钢工程机械有限公司]</strong></p>
                  <p>合资神钢挖掘机总代理<strong><br />
                  </strong>地　址：河南省郑州经济开发区北一路36号<br />
                  邮　编：450016 <br />
                  邮　箱：<a href="mailto:sales@cggcjx.com">sales@cggcjx.com</a><br />
                网　址：<a href="http://www.cggcjx.com/">http://www.cggcjx.com/</a>　</p></td>
              </tr>
              <tr>
                <td><strong>[服务热线]</strong> 400-118-7977</td>
              </tr>
            </tbody>
          </table>
          <table border="0" cellpadding="0" cellspacing="0" width="50%">
            <tbody>
              <tr>
                <td><strong>[河南中远工程机械有限公司]<br />
</strong>厦工机械产品、宣工推土机总代理<strong><br />
              </strong>地　址：河南郑州市南三环与郑尉路交叉口向南800m路西<br />
                  邮　编：450000<br />

                网　址：<a href="http://www.zygcjx.com/">http://www.zygcjx.com/</a>　　</td>
              </tr>
              <tr>
                <td><strong>[服务热线]　</strong>400-110-9777  </td>
              </tr>
              <tr>
                <td><strong>[销售部]　</strong>电话：0371-66711177   传真：0371-66879000</td>
              </tr>
            </tbody>
          </table>
           <table border="0" cellpadding="0" cellspacing="0" width="50%">
            <tbody>
              <tr>
                <td><strong>[河南纵申工程机械销售有限公司]<br />
                </strong>原装神钢挖掘机总代理<strong><br />
                  </strong>地　址：河南省郑州市经济开发区经北一路36号<br />
                  邮　编：450016 <br />
                  邮　箱：<a href="mailto:sales@cggcjx.com">sales@cggcjx.com</a><br />
                  网　址：<a href=" www.zsgcjx.com">http://www.zsgcjx.com</a>　
                 </td>
              </tr>
              <tr>
                <td><strong>[服务热线]</strong>400-118-7977</td>
              </tr>

            </tbody>
          </table>
          <table border="0" cellpadding="0" cellspacing="0" width="50%">
            <tbody>
              <tr>
                <td><strong>[安徽中远工程机械销售有限公司]<br />
                  </strong>地　址：合肥市庐阳区大杨产业园（四里河路与绣春路交叉口）厦工机械办公楼<br />
                  邮　编：230000<br />
                  邮　箱：<a href="mailto:xgma@zygcjx.com">xgma@zygcjx.com</a><br />
                网　址：<a href="http://www.ah-xg.com/">http://www.ah-xg.com</a>       <a href="http://www.ahzyjx.com/">http://www.ahzyjx.com</a></td>
              </tr>
              <tr>
                <td><strong>[服务热线]　</strong>400-110-9777</td>
              </tr>
              <tr>
                <td><strong>[销售部]　</strong>电话：0551-7176888   传真：0551-7176999</td>  </tr>
            </tbody>
          </table>
            <table border="0" cellpadding="0" cellspacing="0" width="50%">
            <tbody>
              <tr>
                <td><strong>[河南方鼎企业管理咨询有限责任公司]<br />
                  </strong>地　址：郑州市管城区紫金山路世纪联华超市广场A座1单19层<br />
             <tr>
                <td><strong>[电话]　</strong>0371-66396662</td>
              </tr>
             
            </tbody>
          </table>
         

    </div>
</div>
<div class="con6" id="to_order">
<div class="g_tit tit6">
          <div class="wrap clearfix">
            <h2>产品订单</h2>
       
          </div>
        </div>
        
        
        
                 <%
   	    String offset = CommonString.getFormatPara(request.getParameter("offset"));
       List<Map> orderList = null ;
       PageBean pageBean = new  PageBean() ;
       pageBean.setPageSize(10) ;
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
       pageBean.setTableName("pro_product_form") ;
       pageBean.setFields("factoryid ,id, factoryname,product_name,contact_address,cataname,name,mobile_phone,province,city,add_date") ;
       pageBean.setCondition(" and (factoryid=183 and catanum LIKE '101001%') OR (factoryid=139 and catanum LIKE '101002%') or (factoryid=154 and catanum LIKE '101003%')  and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(nowPage) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
       %>
  <div class="wrap clearfix">
    <div class="border03 l list08">
      <div class="title08">
       
    <h3><b>询价总数：<%=pageBean.getTotal() %></b> - 采购询价</h3>
        <span>共有<font><%=pageBean.getTotal() %></font>个符合条件</span> </div>
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
	  if(null!=orderList && orderList.size()>0){
		  int k = orderList.size()>10?10:orderList.size() ;
      	 String showtel = "" ; 
      	 Map oneMap = null ;
	  	 for(int i=0;i<k;i++){
	  		oneMap = orderList.get(i) ;
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
                <li class="i2" style="width:265px;"><a href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
                <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
                <li class="i4"><%=showtel %></li>
                <li class="i5"><a target="_blank" href="http://product.21-sun.com/inquiry/0_0_<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>_0_0.shtm"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
                <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
                <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
              </ul>
              <%
	  	 }
	  }
	  %>
      </div>
    </div>
  <div class="page" style="margin-left:450px;width:500px;clear:both;float:left;">
              <tags:page pageBean="<%=pageBean%>" />
            </div>

</div>


<div class="bottombg">
<div class="proFoot" style="width:980px; height:170px; margin:0 auto; clear:both; position:relative;">
<div class="fewm" style="position:absolute; right:-18px; top:36px; width:160px; text-align:center;"><img width="90" height="90" src="images/ewm_new.gif"><br/>关注铁臂商城<br/>抢先查询新品信息</div>
  <link type="text/css" href="http://www.21-sun.com/00css/new_21sun_include.css" rel="stylesheet"/>
  <div class="New_website">
    <div class="New_linksContain">
      <strong><span onclick="window.open('http://www.21-sun.com');" class="New_links">中国工程机械商贸网</span>旗下网站：</strong>
      <span onclick="window.open('http://part.21-sun.com/');" class="New_links">中国工程机械配件网</span>
      <span onclick="window.open('http://www.21-cmjob.com/');" class="New_links">中国工程机械人才网</span>
      <span onclick="window.open('http://www.21-rent.com/');" class="New_links">中国工程机械租赁网</span>
      <span onclick="window.open('http://www.21-used.com/');" class="New_links">中国工程机械二手网</span>
      <span onclick="window.open('http://www.21part.com/');" class="New_links">配件商城</span>
      <span onclick="window.open('http://www.21peitao.com/');" class="New_links">配套网</span>
      <span onclick="window.open('http://www.cmbol.com/');" class="New_links">工程机械外贸网</span>
      <span onclick="window.open('http://product.21-sun.com/');" class="New_links">铁臂商城</span>
    </div>
  </div>
  <div class="New_foot">
    <span onclick="window.open('http://www.21-sun.com/service/guanggao/index.htm');" class="New_links">广告服务</span><em>|</em>
    <span onclick="window.open('http://www.jerei.com/contact/');" class="New_links">联系方式</span><em>|</em>
    <span onclick="window.open('http://www.jerei.com/');" class="New_links">关于我们</span><em>|</em>
    <span onclick="window.open('http://www.jerei.com/news/');" class="New_links">本网动态</span><em>|</em>
    <span onclick="window.open('http://www.jerei.com/contact/legal.jsp');" class="New_links">法律声明</span><em>|</em>
    <span onclick="window.open('http://aboutus.21-sun.com/map.htm');" class="New_links">网站导航</span><em>|</em>
    <span onclick="window.open('http://www.21-sun.com/contact/');" class="New_links">联系客服</span><br/>
    产品询价专线：4006-521-526<br/>
    <span onclick="window.open('http://www.21-sun.com');" class="New_links">中国工程机械商贸网</span>
    Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script>2014
  </div>
  <!-- Baidu Button BEGIN -->
    <div style="width:300px; margin:0px auto;">
    <div style="padding-left:50px;" class="bdsharebuttonbox bdshare-button-style0-16" data-bd-bind="1409046586027">
    <a data-cmd="more" class="bds_more" href="#"></a><a title="分享到QQ空间" data-cmd="qzone" class="bds_qzone" href="#"></a><a title="分享到新浪微博" data-cmd="tsina" class="bds_tsina" href="#"></a><a title="分享到腾讯微博" data-cmd="tqq" class="bds_tqq" href="#"></a><a title="分享到人人网" data-cmd="renren" class="bds_renren" href="#"></a><a title="分享到微信" data-cmd="weixin" class="bds_weixin" href="#"></a></div>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>
    </div>
    <!-- Baidu Button END -->
</div>

 <script type="text/javascript">
function addShop(){　
    try{
       window.external.addFavorite('http://product.21-sun.com/agentstore/henanzhongyuan/', '中远机械投资集团');
   }catch (e){
       try{
           window.sidebar.addPanel('中远机械官方旗舰店','http://product.21-sun.com/agentstore/henanzhongyuan/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
</div>
</body>
</html>