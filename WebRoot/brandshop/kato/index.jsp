<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	//加藤  品牌 id  189
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select id,name,factoryname,file_name,img2,catalogname_spe,catalognum,zoomlion_hot_pic ,catalogname from pro_products where factoryid=189 and is_show=1 order by zoomlion_hot desc,img2 desc" ;
	String whereStr = " and 1=1" ;
	List<Map> productsList = null ;
	productsList = dbHelper.getMapList(sel_sql) ;
	whereStr += " and factoryid=189 " ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>加藤（中国）_加藤（中国）官方旗舰店 - 铁臂商城</title>
<meta name="keywords" content="加藤（中国）,加藤挖掘机报价,加藤挖掘机,加藤挖掘机图片,加藤挖掘机介绍,加藤（中国）介绍" />
<meta name="description" content="铁臂商城为您提供加藤（中国）介绍,加藤挖掘机介绍,加藤挖掘机报价,加藤挖掘机图片,加藤挖掘机展示等加藤挖掘机信息，帮助您全面了解加藤（中国）。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/com.css" rel="stylesheet" />
<link href="style/style.css" rel="stylesheet" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script>window.jQuery || document.write('<script src="scripts/jq1.10.2.js"><\/script>')</script>
<!--[if IE 6]>
<script src="scripts/iepng.js"></script>
<script>
   EvPNG.fix('s')
</script>
<![endif]-->
</head>
<body>
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<div class="max_wrap">
   <!--头部-->
   <div class="head">
      <div class="wrap fix">
        <h1 class="l logo"><a href="./" title="加藤（中国）官方旗舰店"><img src="images/logo.jpg" alt="加藤（中国）官方旗舰店" /></a></h1>
         <div class="r head_r"><img src="images/lo_r.jpg" border="0" usemap="#Map"  title="咨询热线"/>
           <map name="Map" id="Map">
             <area shape="rect" coords="197,17,250,63" href="javascript:;" onclick="addShop();return false;" title="收藏店铺" />
           </map>
         </div>
      </div>
   </div>
   <div class="nav">
      <ul class="wrap fix">
         <li><a href="./">首页</a></li>
         <li><a href="/proDetail/HD308R.shtm" target="_blank" title="加藤HD308R履带式挖掘机">HD308R</a></li>
         <li><a href="/proDetail/HD512R.shtm" target="_blank" title="加藤HD512R履带式挖掘机">HD512R</a></li>
         <li><a href="/proDetail/HD820R.shtm" target="_blank" title="加藤HD820R履带式挖掘机">HD820R</a></li>
         <li><a href="/proDetail/HD820V.shtm" target="_blank" title="加藤HD820V履带式挖掘机">HD820V</a></li>
         <li><a href="/proDetail/HD1023R.shtm" target="_blank" title="加藤HD1023R履带式挖掘机">HD1023R</a></li>
         <li><a href="/proDetail/HD1430R.shtm" target="_blank" title="加藤HD1430R履带式挖掘机">HD1430R</a></li>
         <li><a href="/proDetail/HD1638R.shtm" target="_blank" title="加藤HD1638R履带式挖掘机">HD1638R</a></li>
         <li><a href="/proDetail/HD2048R.shtm" target="_blank" title="加藤HD2048R履带式挖掘机">HD2048R</a></li>
      </ul>
   </div>
   <!--导航-->
   <!--banner -->
   <div class="slide banner">
      <div class="ban_c"><a href="/proDetail/HD308R.shtm" target="_blank" title="加藤HD308R履带式挖掘机"><img src="images/banner308.jpg" /></a></div>
      <div class="ban_c"><a href="/proDetail/HD820R.shtm" target="_blank" title="加藤HD820R履带式挖掘机"><img src="images/banner.jpg" /></a></div>
      <div class="ban_c"><a href="/proDetail/HD1430R.shtm" target="_blank" title="加藤HD1430R履带式挖掘机"><img src="images/banner1430.jpg" /></a></div>
   </div>
   <!--banner-->
   <!--特别推荐-->
   <div class="wrap">
      <div class="box" style="margin-top:-28px;position: relative;">
         <div class="channelT">
            <div class="channelN">特别推荐</div>
         </div>
         <ul class="box1_ul">
            <li><a href="/proDetail/HD1638R.shtm" target="_blank" title="加藤HD1638R履带式挖掘机"><img src="images/hd1638.jpg" /></a></li>
            <li><a href="/proDetail/HD1430R.shtm" target="_blank" title="加藤HD1430R履带式挖掘机"><img src="images/pro_ba1.jpg" /></a></li>
            <li><a href="/proDetail/HD820R.shtm" target="_blank" title="加藤HD820R履带式挖掘机"><img src="images/hd820.jpg" /></a></li>
         </ul>
      </div>
      <div class="box">
         <div class="channelT">
            <div class="channelN">热销产品</div>
         </div>
         <ul class="box2_ul">
            <li><a href="/proDetail/HD308R.shtm" target="_blank" title="加藤HD308R履带式挖掘机"><img src="http://product.21-sun.com/uploadfiles//image/2012/12/20121210133318_928.jpg" /></a>
               <p class="pl10"><a href="/proDetail/HD308R.shtm" target="_blank" title="加藤HD308R履带式挖掘机">加藤HD308R履带式挖掘机</a><br />
                  <a href="/proDetail/HD308R_order.shtm" target="_blank">订单</a> | <a href="/proDetail/HD308R.shtm" target="_blank">参数</a> | <a href="/proDetail/HD308R_message.shtm" target="_blank">评论</a></p>
               <p class="box2_jg"><a href="javascript:;" onclick="showinquery('15095','189')">立即询价</a></p>
            </li>
            <li><a href="/proDetail/HD512R.shtm" target="_blank" title="加藤HD512R履带式挖掘机"><img src="http://product.21-sun.com/uploadfiles//image/2012/12/20121210133723_305.jpg" /></a>
               <p><a href="/proDetail/HD512R.shtm" target="_blank" title="加藤HD512R履带式挖掘机">加藤HD512R履带式挖掘机</a><br />
                  <a href="/proDetail/HD512R_order.shtm" target="_blank">订单</a> | <a href="/proDetail/HD512R.shtm" target="_blank">参数</a> | <a href="/proDetail/HD512R_message.shtm" target="_blank">评论</a></p>
               <p class="box2_jg"><a href="javascript:;" onclick="showinquery('7435','189')">立即询价</a></p>
            </li>
            <li><a href="/proDetail/HD820R.shtm" target="_blank" title="加藤HD820R履带式挖掘机"><img src="http://product.21-sun.com/uploadfiles//image/2012/12/20121210134011_438.jpg" /></a>
               <p><a href="/proDetail/HD820R.shtm" target="_blank" title="加藤HD820R履带式挖掘机">加藤HD820R履带式挖掘机</a><br />
                  <a href="/proDetail/HD820R_order.shtm" target="_blank">订单</a> | <a href="/proDetail/HD820R.shtm" target="_blank">参数</a> | <a href="/proDetail/HD820R_message.shtm" target="_blank">评论</a></p>
               <p class="box2_jg"><a href="javascript:;" onclick="showinquery('7436','189')">立即询价</a></p>
            </li>
            <li><a href="/proDetail/HD820V.shtm" target="_blank" title="加藤HD820V履带式挖掘机"><img src="http://product.21-sun.com/uploadfiles//image/2012/12/20121210133616_812.jpg" /></a>
               <p><a href="/proDetail/HD820V.shtm" target="_blank" title="加藤HD820V履带式挖掘机">加藤HD820V履带式挖掘机</a><br />
                  <a href="/proDetail/HD820V_order.shtm" target="_blank">订单</a> | <a href="/proDetail/HD820V.shtm" target="_blank">参数</a> | <a href="/proDetail/HD820V_message.shtm" target="_blank">评论</a></p>
               <p class="box2_jg"><a href="javascript:;" onclick="showinquery('7437','189')">立即询价</a></p>
            </li>
            <li><a href="/proDetail/HD1023R.shtm" target="_blank" title="加藤HD1023R履带式挖掘机"><img src="http://product.21-sun.com/uploadfiles//image/2012/12/20121210133512_456.jpg" /></a>
               <p><a href="/proDetail/HD1023R.shtm" target="_blank" title="加藤HD1023R履带式挖掘机">加藤HD1023R履带式挖掘机</a><br />
                  <a href="/proDetail/HD1023R_order.shtm" target="_blank">订单</a> | <a href="/proDetail/HD1023R.shtm" target="_blank">参数</a> | <a href="/proDetail/HD1023R_message.shtm" target="_blank">评论</a></p>
               <p class="box2_jg"><a href="javascript:;" onclick="showinquery('13093','189')">立即询价</a></p>
            </li>
            <li><a href="/proDetail/HD1430R.shtm" target="_blank" title="加藤HD1430R履带式挖掘机"><img src="http://product.21-sun.com/uploadfiles//image/2012/12/20121210134122_444.jpg" /></a>
               <p><a href="/proDetail/HD1430R.shtm" target="_blank" title="加藤HD1430R履带式挖掘机">加藤HD1430R履带式挖掘机</a><br />
                  <a href="/proDetail/HD1430R_order.shtm" target="_blank">订单</a> | <a href="/proDetail/HD1430R.shtm" target="_blank">参数</a> | <a href="/proDetail/HD1430R_message.shtm" target="_blank">评论</a></p>
               <p class="box2_jg"><a href="javascript:;" onclick="showinquery('7439','189')">立即询价</a></p>
            </li>
            <li><a href="/proDetail/HD1638R.shtm" target="_blank" title="加藤HD1638R履带式挖掘机"><img src="http://product.21-sun.com/uploadfiles//image/2013/12/20131210103413_71.jpg" width="310" height="240" /></a>
               <p class="pl10"><a href="/proDetail/HD1638R.shtm" target="_blank" title="加藤HD1638R履带式挖掘机">加藤HD1638R履带式挖掘机</a><br />
                  <a href="/proDetail/HD1638R_order.shtm" target="_blank">订单</a> | <a href="/proDetail/HD1638R.shtm" target="_blank">参数</a> | <a href="/proDetail/HD1638R_message.shtm" target="_blank">评论</a></p>
               <p class="box2_jg"><a href="javascript:;" onclick="showinquery('20677','189')">立即询价</a></p>
            </li>
            <li><a href="/proDetail/HD2048R.shtm" target="_blank" title="加藤HD2048R履带式挖掘机"><img src="http://product.21-sun.com/uploadfiles//image/2012/12/20121210133916_863.jpg" /></a>
               <p class="pl10"><a href="/proDetail/HD2048R.shtm" target="_blank" title="加藤HD2048R履带式挖掘机">加藤HD2048R履带式挖掘机</a><br />
                  <a href="/proDetail/HD2048R_order.shtm" target="_blank">订单</a> | <a href="/proDetail/HD2048R.shtm" target="_blank">参数</a> | <a href="/proDetail/HD2048R_message.shtm" target="_blank">评论</a></p>
               <p class="box2_jg"><a href="javascript:;" onclick="showinquery('15096','189')">立即询价</a></p>
            </li>
         </ul>
      </div>
      <div class="box" style="margin-top:34px;">
         <div class="channelT">
            <div class="channelN">公司简介</div>
         </div>
         <div class="box3">
            <div> 自1895年建立以来，我们就凭借独创的先进技术和不懈的创新精神，在工程机械领域里一直扮演着开拓者的角色，也正因如此，我们才会赢得世界范围内广大客户的信赖和好评。今后我们仍将继续努力，朝着不可比拟的技术领域进发。</div>
            <div class="box3_be">
               <div class="l box3_be_l"><img src="images/about.jpg" /></div>
               <div class="r box3_be_r">我们遵循“通过优质产品贡献社会”的理念已有一百一十余年。
                  我们一直致力于开发各种产业机械，工程机械，以满足不断发展变化的时代需求。
                  毫不夸张的说，我们公司的科技发展轨迹，就是段原创技术开发的历史。自公司创立以来，我们就注重创造力，并以创新精神不断推动技术革新。<br />
                  早在20世纪初期，我们便开始制造内燃机，之后又逐步开发液压汽车起重机和液压挖掘机。近年来，又研制开发出了越野轮胎起重机、全路面起重机以及其他多种机械，加藤在工程机械行业中领导了一场翻天覆地的变革。
                  我们凭借多年积攒的丰富经验和坚实业绩，让KATO品牌赢得了世界范围内的爱戴和信赖。
                  我们把21世纪看作新飞跃的世纪,是迈向未来的全新开始。为了迎接来自未来的新机遇,新挑战,我们提出了“Innovations For The Future”的口号。作为一个全球性企业，我们将继续在各个方面大胆革新，努力提高企业价值,为建设富裕社会做出自己的贡献。<br />
                  今后也请继续给予我们帮助和支持。</div>
            </div>
         </div>
      </div>
      <div class="box" style="margin-top:26px;">
         <div class="channelT">
            <div class="channelN">联系我们</div>
         </div>
         <div class="box4">
            <div class="box4_ll">株式会社 加藤制作所<br />
               总部地址：日本 东京都品川区东大井1丁目9番37号<br />
               邮编：140-0011 <br />
               电话：81-3-3458-1115（海外营业部）<br />
               传真：81-3-3458-1163 <br />
               邮箱：<a href="mailto:marketing@kato-works.com" rel="nofollow">marketing@kato-works.com</a><br />
            </div>
            <div class="box4_cc">加藤(中国)工程机械有限公司<br />
               地址：中国 江苏省昆山市长江北路华扬科学工业园 <br />
               邮编：215313 <br />
               电话：0512-57065000 <br />
               传真：0512-57065065<br />
            </div>
            <div class="box4_rr">天津长久恒力工程机械有限公司（销售总公司）<br />
               地址：天津武清创业总部C10楼 <br />
               邮编：301700<br />
               电话：022-22931819<br />
               传真：022-22931809</div>
         </div>
      </div>
         <div class="box" style="margin-top:20px;">
         <div class="channelT">
            <div class="channelN">产品订单</div>
         </div>
           <div class="border03 l list08" style="margin-top: 10px; width:998px;">
      <div class="title08">
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
       pageBean.setCondition(" and factoryid=189 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(nowPage) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
       %>
        <h3><b>询价总数：<font id="total1"><%=pageBean.getTotal() %></font></b> - 采购询价</h3>
        <span>共有<font id="total2"><%=pageBean.getTotal()  %></font>个符合条件</span> 
         <a name="to_order" id="to_order">&nbsp;</a>
        </div>
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
    <div class="page paging" style="margin-left:450px;width:500px;clear:both;float:left;"><tags:page pageBean="<%=pageBean%>" /></div></div>
  </div>
         </div>
   </div>
</div>
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
<script src="scripts/comm.js" type="text/javascript"></script>
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/kato/', '加藤（中国）官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('加藤（中国）官方旗舰店','http://product.21-sun.com/brandshop/kato/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery("body").bind("contextmenu", function() {
	  return false;
	});
</script>
</body>
</html>
