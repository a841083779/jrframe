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
<title>山东骏大官方旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="山东骏大,山东骏大产品报价,山东骏大产品,山东骏大产品图片,山东骏大介绍,山东骏大代理商" />
<meta name="description" content="中国工程机械商贸网为您提供山东骏大介绍,山东骏大产品介绍,山东骏大产品报价,山东骏大产品图片,山东骏大产品展示等山东骏大产品信息，帮助您全面了解山东骏大。" />
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
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"></jsp:include>
<!--main-->
<div id="slider" class="new_rec">
  <ul class="bgs">
    <li><a href="/proDetail/R305LC-9.shtm" target="_blank"><img src="images/new_bigbanner1.jpg" width="1180" height="530" /></a></li>
    <li style="display:none;"><a href="/proDetail/R225LC-9T.shtm" target="_blank"><img src="images/new_bigbanner2.jpg" width="1000" height="530" /></a></li>
  </ul>
  <ul class="points">
    <li value="1" class="selected"></li>
    <li value="2"></li>
  </ul>
</div>
<script type="text/javascript">
jQuery(document).ready(function() {
    jQuery(".shopWrapper li").hover(function(){
		jQuery(this).find(".cover").stop(true,false).animate({"top":"0px"},300);
		    },function(){
		jQuery(this).find(".cover").stop(true,false).animate({"top":"312px"},300);
	});
});
</script>
<div class="shopWrapper clearfix mb15">
  <ul>
    <li style="width:334px;"><a href="/proDetail/R55-7.shtm" target="_blank"><img src="images/jd_pro01.jpg" width="334" height="312" /><img src="images/hyundai_cover.png" class="cover" /></a></li>
    <li><a href="/proDetail/R80-9.shtm" target="_blank"><img src="images/jd_pro02.jpg" width="333" height="312" /><img src="images/hyundai_cover.png" class="cover" /></a></li>
    <li><a href="/proDetail/R150LC-9.shtm" target="_blank"><img src="images/jd_pro03.jpg" width="333" height="312" /><img src="images/hyundai_cover.png" class="cover" /></a></li>
  </ul>
<div class="clear"></div>  
</div>

<div class="shopWrapper01 hotSale clearfix">
  <div class="title">
  <a href="javascript:;" name="hot_rec"></a>
    <h2><span>HOT SALE</span> | 热销推荐</h2>
    <span class="more"><a href="#" style="display:none;">More&gt;&gt;</a></span>
  </div>
  <div class="contain hotList">
    <ul class="list">
    <%
    	if(null!=recommondProductsList && recommondProductsList.size()>0){
    		Map oneMap = null ;
    		for(int i=0;i<recommondProductsList.size();i++){
    			oneMap = (HashMap)recommondProductsList.get(i) ;
    			%>
      <li>
        <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>"><img onerror="this.src='/images/nopic.gif'" src="/uploadfiles/<%= CommonString.getFormatPara(oneMap.get("img2"))%>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>" width="298" height="206" />
        <div class="ct">
          <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3>
          <span class="more">详情</span>
        </div>
        </a>
      </li>
    			<%
    		}
    	}
    %>
    </ul>
  </div>
  <div class="w100 l pt15"><a href="/proDetail/R265LC-9-67.shtm" target="_blank"><img src="images/jd_probanner.jpg" alt="ROBEX R265LC-9" width="970" height="420" /></a></div>
</div>

<div class="shopWrapper01 clearfix">
  <div class="title">
   <a href="javascript:;" name="excavator"></a>
    <h2><img src="images/hyundai.gif" alt="HYUNDAI" width="185" height="57" />
      <span class="name">挖掘机<em>Excavator</em>
      </span>
    </h2>
    <span class="more"><a href="#" style="display:none;">More&gt;&gt;</a></span>
  </div>
  <div class="contain proList">
  <%
  whereStr = " and catalognum like '101001%'" ;
  productsList = dbHelper.getMapList(sel_sql+whereStr) ;
  %>
    <ul class="list">
    <%
    	if(null!=productsList &&productsList.size()>0){
    		for(Map oneMap:productsList){
    	%>
      <li>
        <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img onerror='this.src="/images/nopic.gif"' src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%>" width="298" height="206" />
        <div class="ct">
          <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname"))%></h3>
          <span class="more myMore" value="<%=CommonString.getFormatPara(oneMap.get("id")) %>">立即询价</span>
        </div>
        </a>
      </li>
    	<%		
    		}
    	}
    %>
    </ul>
  </div>
</div>
</div>
<div class="contain980 shopPart08" style="height:486px;">
  <div class="partTitle">
    <h2>山东骏大产品订单</h2>
        <a name="to_order" href="#">&nbsp;</a>
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
      <div class="page" style="margin-left:467px;width:500px;clear:both;float:left;"><tags:page pageBean="<%=pageBean%>" /></div></div>
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
jQuery(function(){
	jQuery(".shopPros01 li").hover(function(){
		jQuery(this).toggleClass("hover");
	},function(){
		jQuery(this).removeClass("hover");
	});
})
</script> 
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