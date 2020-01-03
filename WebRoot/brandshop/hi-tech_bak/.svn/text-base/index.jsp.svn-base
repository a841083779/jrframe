<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select * from pro_agent_product_vi where agentid=1062 and factoryid=194 and is_show=1" ;
	String whereStr = " where 1=1" ;
	List<Map> productsList = null ;
	
	List<Map> recommondProductsList = new ArrayList() ;
	String rec_sql = "select top 9 * from pro_agent_product_vi where agentid=1062 and factoryid=194 and is_show=1 and zoomlion_hot=11" ; // 是否热卖推荐
	recommondProductsList = dbHelper.getMapList(rec_sql+"order by order_no") ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>烟台普堃官方旗舰店 - 铁臂商城</title>
<meta name="keywords" content="烟台普堃,烟台普堃产品报价,烟台普堃产品,烟台普堃产品图片,烟台普堃介绍,烟台普堃代理商" />
<meta name="description" content="铁臂商城为您提供烟台普堃介绍,烟台普堃产品介绍,烟台普堃产品报价,烟台普堃产品图片,烟台普堃产品展示等烟台普堃产品信息，帮助您全面了解烟台普堃。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
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
var t1 = n1 = 0, count1;
jQuery(document).ready(function(){	
	count1=jQuery("#slider .bgs li").length;
	jQuery("#slider .bgs li:not(:first-child)").hide();
	jQuery("#slider .points li").click(function() {
		var i = jQuery(this).attr("value") - 1;
		n1 = i;
		if (i >= count1) return;
		jQuery("#slider .bgs li").filter(":visible").fadeOut(800).parent().children().eq(i).fadeIn(800);
		jQuery(this).toggleClass("selected");
		jQuery(this).siblings().removeAttr("class");
	});
	t1 = setInterval("showAuto1()", 5000);
	jQuery("#slider .points li").hover(function(){clearInterval(t1)}, function(){t1 = setInterval("showAuto1()",5000);});
})
function showAuto1(){
	n1 = n1 >=(count1 - 1) ? 0 : ++n1;
	jQuery("#slider .points li").eq(n1).trigger('click');
}
</script>
<script type="text/javascript" src="/scripts/jquery.SuperSlide.js"></script>
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"></jsp:include>
<!--main-->
<div id="slider" class="new_rec">
  <ul class="bgs">
    <li><a href="#" target="_blank"><img src="images/new_bigbanner1.jpg" width="980" height="410" /></a></li>
    <li style="display:none;"><a href="#" target="_blank"><img src="images/new_bigbanner2.jpg" width="980" height="410" /></a></li>
  </ul>
  <ul class="points">
    <li value="1" class="selected"></li>
    <li value="2"></li>
  </ul>
</div>
<div class="pukunPart pukunPart01 clearfix">
  <div class="tel"><img src="images/logo_pukun.png" width="299" height="75" class="pukun_logo" />24小时服务热线：<em>400-666-2180</em></div>
  <div class="proshow">
    <span class="l">
    <img src="images/pro_title.gif" width="134" height="61" /><br />
    <a href="#" title="查看更多"><img src="images/more.gif" alt="查看更多" width="67" height="28" /></a>
    </span>
    <div id="proShow">
      <div class="hd"> 
        <a class="newsImgprev"></a>
        <a class="newsImgnext"></a> 
      </div>
      <div class="bd">
        <ul class="picList">
          <li><a href="#" title="HTB系列破碎锤"><img src="images/pukun_img01.jpg" width="170" height="150" alt="HTB系列破碎锤" /></a></li>
          <li><a href="#" title="HTB系列破碎锤"><img src="images/pukun_img01.jpg" width="170" height="150" alt="HTB系列破碎锤" /></a></li>
          <li><a href="#" title="HTB系列破碎锤"><img src="images/pukun_img01.jpg" width="170" height="150" alt="HTB系列破碎锤" /></a></li>
          <li><a href="#" title="HTB系列破碎锤"><img src="images/pukun_img01.jpg" width="170" height="150" alt="HTB系列破碎锤" /></a></li>
        </ul>
      </div>
    </div>
    <script type="text/javascript">
	jQuery("#proShow").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"leftLoop",vis:1,scroll:1,autoPlay:true});
    </script> 
  </div>
</div>
<div class="shopWrapper01 hotSale clearfix">
  <div class="title">
    <h2><span>HOT SALE</span> | 热销推荐</h2>
    <span class="tlogo"><img src="images/logo_pukun.png" width="150" height="38" /></span>
  </div>
  <div class="contain hotList">
    <ul class="list hlist01">
      <li>
        <div class="img"><a href="http://www.pukun.net/products/index.jsp" target="_blank"><img src="images/10031813273311_0.jpg" alt="HTB系列破碎锤-三角型破碎锤" width="540" height="260" />
        <img class="imglogo" src="images/logo_pukun.png" width="150" height="38" />
        <img class="hotico" src="images/hot_ico.png" width="97" height="71" /></a></div>
        <div class="intro">
          <h3><a href="http://www.pukun.net/products/index.jsp" target="_blank">HTB系列破碎锤-三角型破碎锤</a></h3>
          <span class="more"><a href="http://www.pukun.net/products/index.jsp" target="_blank">详细产品</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="http://www.pukun.net/products/index.jsp" target="_blank"><img src="images/10030817382688_0.jpg" alt="HTB系列破碎锤-塔型破碎锤" width="540" height="260" />
        <img class="imglogo" src="images/logo_pukun.png" width="150" height="38" />
        <img class="hotico" src="images/hot_ico.png" width="97" height="71" /></a></div>
        <div class="intro">
          <h3><a href="http://www.pukun.net/products/index.jsp" target="_blank">HTB系列破碎锤-塔型破碎锤</a></h3>
          <span class="more"><a href="http://www.pukun.net/products/index.jsp" target="_blank">详细产品</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="http://www.pukun.net/products/index.jsp" target="_blank"><img src="images/11122318085835_0.jpg" alt="HTB系列破碎锤-静音型破碎锤" width="540" height="260" />
        <img class="imglogo" src="images/logo_pukun.png" width="150" height="38" />
        <img class="hotico" src="images/hot_ico.png" width="97" height="71" /></a></div>
        <div class="intro">
          <h3><a href="http://www.pukun.net/products/index.jsp" target="_blank">HTB系列破碎锤-静音型破碎锤</a></h3>
          <span class="more"><a href="http://www.pukun.net/products/index.jsp" target="_blank">详细产品</a></span>
        </div>
      </li>
    </ul>
    <ul class="list hlist02">
      <li>
        <div class="img"><a href="http://www.pukun.net/products/htbzdh.jsp" target="_blank"><img src="images/10031811143584_0.jpg" alt="HTB系列振动夯" width="350" height="400" />
        <img class="imglogo" src="images/logo_pukun.png" width="150" height="38" />
        <img class="hotico" src="images/hot_ico.png" width="97" height="71" /></a></div>
        <div class="intro">
          <h3><a href="http://www.pukun.net/products/htbzdh.jsp" target="_blank">HTB系列振动夯</a></h3>
          <span class="more"><a href="http://www.pukun.net/products/htbzdh.jsp" target="_blank">详细产品</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="http://www.pukun.net/products/htbyyj.jsp" target="_blank"><img src="images/11102008503374_0.jpg" alt="HTB系列液压剪" width="350" height="400" />
        <img class="imglogo" src="images/logo_pukun.png" width="150" height="38" />
        <img class="hotico" src="images/hot_ico.png" width="97" height="71" /></a></div>
        <div class="intro">
          <h3><a href="http://www.pukun.net/products/htbyyj.jsp" target="_blank">HTB系列液压剪</a></h3>
          <span class="more"><a href="http://www.pukun.net/products/htbyyj.jsp" target="_blank">详细产品</a></span>
        </div>
      </li>
    </ul>
  </div>
</div>
</div>
<div class="pukunPart clearfix">
  <div class="pukunTitle">
    <h2><img src="images/logo_pukun.png" width="96" height="24" class="title_logo" /> <span>HTB系列破碎锤</span></h2>
    <span class="more"><a href="#" target="_blank">More</a></span>
  </div>
  <div class="pukunContent">
    <ul class="list">
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
    </ul>
    <ul class="list pukunList02">
      <li>
        <h2>HTB系列快速连接器</h2>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <h2>HTB系列振动夯</h2>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <h2>HTB系列液压剪</h2>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
    </ul>  
  </div>
</div>
<div class="pukunPart clearfix">
  <div class="pukunTitle">
    <h2><img src="images/logo_pukun.png" width="96" height="24" class="title_logo" /> <span>HTB系列配件</span></h2>
    <span class="more"><a href="#" target="_blank">More</a></span>
  </div>
  <div class="pukunContent">
    <ul class="list">
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
    </ul>
  </div>
</div>
<div class="pukunPart clearfix pukunPart02">
  <div class="pukunTitle">
    <h2><img src="images/logo_pukun.png" width="96" height="24" class="title_logo" /> <span>ENB系列破碎锤</span></h2>
    <span class="more"><a href="#" target="_blank">More</a></span>
  </div>
  <div class="pukunContent">
    <ul class="list">
      <li class="bannerImg"><img src="images/punkun_img02.jpg" width="225" height="275" /></li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
    </ul>
  </div>
</div>
<div class="pukunPart clearfix pukunPart02">
  <div class="pukunTitle">
    <h2><img src="images/logo_pukun.png" width="96" height="24" class="title_logo" /> <span>RGB系列破碎锤</span></h2>
    <span class="more"><a href="#" target="_blank">More</a></span>
  </div>
  <div class="pukunContent">
    <ul class="list">
      <li class="bannerImg"><img src="images/punkun_img03.jpg" width="225" height="275" /></li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
    </ul>
  </div>
</div>
<div class="pukunPart clearfix pukunPart02">
  <div class="pukunTitle">
    <h2><img src="images/logo_pukun.png" width="96" height="24" class="title_logo" /> <span>PKB系列破碎锤</span></h2>
    <span class="more"><a href="#" target="_blank">More</a></span>
  </div>
  <div class="pukunContent">
    <ul class="list">
      <li class="bannerImg"><img src="images/punkun_img04.jpg" width="225" height="275" /></li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
      <li>
        <div class="img"><a href="#" target="_blank"><img src="images/punkun_img01.jpg" width="305" height="215" /></a></div>
        <div class="intro">
          <h3><a href="#" target="_blank">HTB系列-三角型破碎锤</a></h3>
          <span class="xunjia"><a href="#">立即询价</a></span>
        </div>
      </li>
    </ul>
  </div>
</div>
<div class="contain980 shopPart08" style="height:486px;">
  <div class="pukunTitle">
    <h2>烟台普堃产品订单</h2>
    <span class="more"><a href="/inquiry/" target="_blank">&nbsp;</a></span>
  </div>
  <div class="content">
    <div class="w978 border03 l list08">
      <div class="title08">
      <%
   	    String offset = CommonString.getFormatPara(request.getParameter("offset"));
       List<Map> orderList = null ;
       PageBean pageBean = new  PageBean() ;
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
       pageBean.setTableName("pro_agent_products_form") ;
       pageBean.setFields("factory_id factoryid ,id,factory_name factoryname,product_name,contact_address,cata_name cataname,user_name name,contact_tel mobile_phone,province,city,add_date") ;
       pageBean.setPageSize(10) ;
       pageBean.setCondition(" and factory_id=194 and agent_id=1062 and factory_name <>'' and factory_name is not null and user_name is not null and user_name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(nowPage) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
    //    pageBean.setIsShowSql(true) ;
       orderList = pageBean.getDatas() ;
       %>
        <h3><b>询价总数：<%=pageBean.getTotal() %></b> - 采购询价</h3>
        <span>共有<font><%=pageBean.getTotal()  %></font>个符合条件</span> </div>
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
            <li class="i2"><a href="/inquiry/details_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
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
      <div class="page" style="margin-left:450px;width:500px;clear:both;float:left;"><tags:page pageBean="<%=pageBean%>" /></div></div>
    </div>
  </div>
<div class="clear"></div>
</div>
<!--main end--> 
<!--foot-->
<div class="flagshopbg">
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
  jQuery(".shopNav").scrollTo(700)
});
</script> 
<script type="text/javascript">
jQuery("body").bind("contextmenu", function() {
  return false;
});
jQuery(".myMore").click(function(){
	showinquery(jQuery(this).attr("value"),'')
	return false ;
}) ;
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>