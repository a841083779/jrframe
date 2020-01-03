<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=141 and is_show=1 and catalognum like '101002%' and zoomlion_hot=11 order by zoomlion_hot desc,name" ;
	String whereStr = " where 1=1" ;
	List<Map> productsList = null ;
	productsList = dbHelper.getMapList(sel_sql) ;
	List<Map> recommondProductsList = new ArrayList() ;
	String rec_sql = "select top 5 * from pro_products where factoryid=141 and is_show=1 and zoomlion_hot=11 and catalognum like '101002%'" ; // 是否热卖推荐
	recommondProductsList = dbHelper.getMapList(rec_sql+"order by order_no") ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>雷沃装载机_雷沃装载机品牌专区 - 铁臂商城</title>
<meta name="keywords" content="雷沃装载机,雷沃装载机报价,雷沃装载机,雷沃装载机图片,雷沃装载机介绍,雷沃装载机介绍" />
<meta name="description" content="铁臂商城为您提供雷沃装载机介绍,雷沃装载机介绍,雷沃装载机报价,雷沃装载机图片,雷沃装载机展示等雷沃装载机信息，帮助您全面了解雷沃装载机。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<style type="text/css">
.flag_shop .strongPart.strongPart01.clearfix .proList01 .list li a h3 {
	font-family: Verdana, Geneva, sans-serif;
}
</style>
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
<jsp:include page="top.jsp" flush="true"><jsp:param value="0" name="flag"/></jsp:include>
<!--main-->
<div id="slider" class="new_rec">
  <ul class="bgs">
    <li style="background-image:url(images/new_bigbanner1.jpg); display:block;"><a href="/proDetail/FL956F-ETX(LNG).shtm" target="_blank"></a></li>
    <li style="background-image:url(images/new_bigbanner2.jpg);"><a href="/proDetail/FL966F-ETX.shtm" target="_blank"></a></li>
    <li style="background-image:url(images/new_bigbanner3.jpg);"><a href="/proDetail/FL933.shtm" target="_blank"></a></li>
  </ul> 
  <ul class="points">
    <li value="1" class="selected"></li>
    <li value="2"></li>
    <li value="3"></li>
  </ul> 
</div>
<div class="strongPart strongPart01 clearfix">
  <div class="recTitle" id="hotRec"><img src="images/rec_title.gif" alt="热门推荐" width="259" height="65" /></div>
  <div class="proimg">
  <a href="/proDetail/FL956F-ETX(LNG).shtm" target="_blank"><img src="images/pro_img01.jpg" width="980" height="435" /></a></div>
  <div class="proList01">
    <ul class="list">
       <li>
	        <a href="/proDetail/FL920F.shtm" title="雷沃轮式装载机FL920F-II" target="_blank">
	        <img src="images/tui-01.jpg" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="雷沃轮式装载机FL920F-II" width="473" height="270" class="img" />
	        <h3>FL920F-II</h3>
	        </a>
	        <a href="/proDetail/FL920F.shtm" target="_blank" class="btn">查看详情</a>  
	    </li>
	    <li>
	        <a href="/proDetail/FL933.shtm" title="雷沃轮式装载机FL933" target="_blank">
	        <img src="http://product.21-sun.com/uploadfiles/image/2013/08/20130826141112_738.jpg" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="雷沃轮式装载机FL933" width="473" height="270" class="img" />
	        <h3>FL933</h3>
	        </a>
	        <a href="/proDetail/FL935E.shtm" target="_blank" class="btn">查看详情</a>  
	    </li>
	    <li>
	        <a href="/proDetail/FL955F-ETX.shtm" title="雷沃轮式装载机FL955F-ETX+" target="_blank">
	        <img src="images/tui-02.jpg" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="雷沃轮式装载机FL955F-ETX+" width="473" height="270" class="img" />
	        <h3>FL955F-ETX+</h3>
	        </a>
	        <a href="/proDetail/FL955F-ETX.shtm" target="_blank" class="btn">查看详情</a>  
	    </li>
	    <li>
	        <a href="/proDetail/FL956F-ETX.shtm" title="雷沃轮式装载机FL956F-ETX+" target="_blank">
	        <img src="/uploadfiles/image/2013/08/20130812141102_61.jpg" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="雷沃轮式装载机FL956F-ETX+" width="473" height="270" class="img" />
	        <h3>FL956F-ETX+</h3>
	        </a>
	        <a href="/proDetail/FL956F-ETX.shtm" target="_blank" class="btn">查看详情</a>  
	    </li>
    </ul>
  </div>

</div>
<div class="strongPart clearfix">
  <div class="proimg"><a href="/proDetail/FL936F-ETX.shtm" target="_blank"><img src="images/pro_img03.jpg" width="980" height="435" /></a></div>
  <div class="strongContent">
    <ul class="list">  
    <%
       if(null!=productsList && productsList.size()>0){
    	   Map oneMap = null ;
    	   int sum=1;
    	   for(int i=0;i<productsList.size();i++){
    		   oneMap = (HashMap)productsList.get(i) ;
    		   if(sum<=11){
    			   sum++ ;
    			   %>
		    	<li>
		        <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank">
                <!-- <img src="images/logo_x.png" class="logo_x" /> -->
                <img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" class="img_d" /></a></div>
		        <div class="intro">
		          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank"><%="雷沃装载机<br>"+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
		          <span class="xunjia"><a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');">点击询价</a></span>
		        </div>
		      </li>
    			   <%
    		   }
    	   }
       }
    %>
    <li class="more">
      <div class="img"><a href="list.jsp" title="点击查看更多"></a></div>
      <div class="intro"></div>
    </li>
    </ul>
  </div>
</div>

<div class="contain980 shopPart08" style="height:502px;">
  <div class="strongTitle">
    <h2>产品订单</h2>
    <span class="more"><a href="/inquiry/?factory=141" target="_blank">查看更多</a></span>
    <a name="to_order" id="to_order">&nbsp;</a>
  </div>
  <div class="content">
    <div class="w978 border03 l list08">
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
       pageBean.setCondition(" and factoryid=141 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(nowPage) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
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
  jQuery(".shopNav").scrollTo(700);
  $(".proList01 li").hover(function(){
	  $(this).addClass("hover");
	    },function(){
	  $(this).removeClass("hover");	  
	});
	
	jQuery("html, body").scrollTop(0).animate({scrollTop:jQuery(".shop_topbg").offset().top},1);
});
//$(".strongContent").each(function(index, element) {
//    $(this).find('li').eq(3).addClass("fourth")
//});
</script> 
<script type="text/javascript">
jQuery("body").bind("contextmenu", function() {
  return false;
});
jQuery(".myMore").click(function(){
	showinquery(jQuery(this).attr("value"),'')
	return false ;
}) ;
  $(function(){
  setTimeout(function(){
  	    var url = window.location.toString();
	    var id = url.split("#")[1];
	    if(id){
	        var t = $("#"+id).offset().top;
	        $(window).scrollTop(t);
	    }
  },600) ;
}); 
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>