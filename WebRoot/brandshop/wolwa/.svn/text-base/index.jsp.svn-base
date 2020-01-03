<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select id,name,factoryname,file_name,img2,catalogname_spe,catalognum,zoomlion_hot_pic ,catalogname from pro_products where factoryid=662 and is_show=1 order by zoomlion_hot desc,img2 desc" ;
	String whereStr = " and 1=1" ;
	List<Map> productsList = null ;
	productsList = dbHelper.getMapList(sel_sql) ;
	List<Map> recommondProductsList = new ArrayList() ;
	String rec_sql = "select top 5 * from pro_products where factoryid=662 and is_show=1 and zoomlion_hot=11" ; // 是否热卖推荐
	recommondProductsList = dbHelper.getMapList(rec_sql+"order by order_no") ;
	whereStr += " and factoryid=662" ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>沃尔华_沃尔华品牌专区 - 铁臂商城</title>
<meta name="keywords" content="沃尔华,沃尔华挖掘机报价,沃尔华挖掘机,沃尔华挖掘机图片,沃尔华挖掘机介绍,沃尔华介绍" />
<meta name="description" content="铁臂商城为您提供沃尔华介绍,沃尔华挖掘机介绍,沃尔华挖掘机报价,沃尔华挖掘机图片,沃尔华挖掘机展示等沃尔华挖掘机信息，帮助您全面了解沃尔华。" />
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
	jQuery("#slider .btns").hover(function(){clearInterval(t1)}, function(){t1 = setInterval("showAuto1()",5000);});
})
function showAuto1(){
	n1 = n1 >=(count1 - 1) ? 0 : ++n1;
	jQuery("#slider .points li").eq(n1).trigger('click');
}
function showPre1(){
	n1 = n1 <=0 ? (count1 - 1) : --n1;
	jQuery("#slider .points li").eq(n1).trigger('click');
}
</script>
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"><jsp:param value="0" name="flag"/></jsp:include>
<!--main-->
<div id="slider" class="new_rec">
  <div class="btns">
    <span class="sb_prev" onclick="javascript:showPre1();"></span>
    <span class="sb_next" onclick="javascript:showAuto1();"></span>
  </div>
  <ul class="bgs">
    <li style="background:url(images/banner01.jpg) center top no-repeat;"><a href="list.jsp?num=101001001" target="_blank"></a></li>
    <li style="background:url(images/banner02.jpg) center top no-repeat;" class="hide"><a href="introduce.jsp" target="_blank"></a></li>
  </ul> 
  <ul class="points">
    <li value="1" class="selected"></li>
    <li value="2"></li> 
  </ul> 
</div>

<div class="shopPart02">
  <div class="contain980">
    <div class="part_title">
      <h2>热销推荐</h2>
      <span class="shadow">热销推荐</span>
    </div>
    <ul class="shopPros style02">
       <%
    	if(recommondProductsList!=null && recommondProductsList.size()>=2){
    	for(int i=0;i<=1;i++){
    		Map oneMap = recommondProductsList.get(i) ;
    		%>
      <li><a target="_blank" href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>">
      <img width="450" height="310" src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic")) %>"></a>
      <span class="price">热销机型</span>
        <div class="title"> 
          <a target="_blank" href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>"><h3><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3></a> 
          <a class="buyBtn" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','')" href="javascript:;">立即预定</a> 
        </div>
      </li>
    		<%
    	}
    	}
    %>
    </ul>
    <div class="part_title">
      <h2>产品展示</h2>
      <span class="shadow">产品展示</span>
    </div>
    <div class="shopContain pt15">
      <div class="title">
        <h3>履带式挖掘机</h3>
        <span class="more"><a href="list.jsp?num=101001001">更多&gt;&gt;</a></span>
      </div>
      <ul class="shopPros01">
      <%
      	if(null!=productsList&& productsList.size()>0){
      		int i=0 ;
      		for(Map oneMap:productsList){
      				if(CommonString.getFormatPara(oneMap.get("catalognum")).equals("101001001")){
      					if(i<3){
      						 
      			%>
      	<li>
          <div class="img"><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>"><img width="280" height="185" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>"></a></div>
          <h3><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) +"  "+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h3>
           <span class="links"><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_order.shtm") %>">订单</a> | <a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>">参数</a> | <a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>">评论</a></span> 
          <a class="priceBtn" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','662')" href="javascript:;">立即询价</a> 
        </li>
      			<%
      				}
      					i++ ;
      		}
      		}
      	}
      %>
      </ul>
      <div class="title">
        <h3>轮式挖掘机</h3>
        <span class="more"><a href="list.jsp?num=101001004">更多&gt;&gt;</a></span>
      </div>
      <ul class="shopPros01">
       <%
      	if(null!=productsList&& productsList.size()>0){
      		for(Map oneMap:productsList){
      				if(CommonString.getFormatPara(oneMap.get("catalognum")).equals("101001004")){
      			%>
      	<li>
          <div class="img"><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>"><img width="280" height="185" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>"></a></div>
          <h3><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) +"  "+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h3>
           <span class="links"><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_order.shtm") %>">订单</a> | <a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>">参数</a> | <a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>">评论</a></span> 
          <a class="priceBtn" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','662')" href="javascript:;">立即询价</a> 
        </li>
      			<%
      				}
      		}
      	}
      %>
      </ul>
    </div>
    
  </div>
</div>

<div class="contain980 about">
  <div class="part_title">
    <h2>公司简介</h2>
    <span class="shadow">公司简介</span>
  </div>
  <div class="content">
    <div class="img"><a href="introduce.jsp"><img src="images/about_img.jpg" width="331" height="262" /></a></div>
    <div class="intro">
    <a href="introduce.jsp" target="_blank">  　　沃尔华集团有限公司坐落于素有孔孟之乡的山东省济宁市，诚信为本培育了沃尔华公司的经营文化，深厚的中华文化底蕴铸就了沃尔华人朴实勤劳的工作作风。作为中国五大工程机械产业基地之一的济宁，不仅拥有像山推和日本小松这样的工程机械行业的大型企业，而且更有众多的中小型配套件生产厂。得天独厚的环境优势造就了沃尔华的崛起，在七年多的公司历程中吸引和培养了一大批工程机械的专业人才。<br />
    　　沃尔华集团公司，是按照现代化企业标准建立的高新技术企业，总投资7.5亿元，占地面积237亩，建有现代化厂房80000余平方米，技术研究中心及综合办公大楼8000余平方米，是集研发、生产、销售为一体的液压挖掘机、工程机械配件及液压泵阀的专业生产企业。是目前国内极少集整机、配件和液压泵阀系统生产于一体的企业之一，为逐步形成公司先进的核心技术打下了坚实的基础。集团现有员工657人（其中研发人员45人），公司管理人员均具有大学本科以上学历，具有较高的管理水平。
    </a><br />
    <div style="text-align:right; font-family:宋体; padding:10px 0px;"><a href="introduce.jsp" target="_blank">查看更多&gt;&gt;</a></div>
    </div>
  </div>
<div class="clear"></div>  
</div>

<div class="contain980 shopPart08">
  <div class="part_title">
    <h2>产品订单</h2>
    <span class="shadow">产品订单</span>
  </div>
  <div class="content">
    <div class="w978 border03 l list08">
      <div class="order_title">
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
       pageBean.setCondition(" and factoryid=662 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(nowPage) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
       %>
        <h3>沃尔华产品订单</h3>
        <span class="more"><a href="/inquiry/?factory=662" target="_blank">更多&gt;&gt;</a></span>
      </div>
      <div class="title08">
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
  <div class="volwa_bottom">
      <h3 class="l"><img src="images/volwa_bottom-logo.gif" alt="沃尔华集团有限公司" width="172" height="90" /></h3>
      <div class="volwaInfo">
        <strong>沃尔华集团有限公司</strong><br />
        <span style="color:#808080;">地址：山东省济宁市任城经济开发区山博路8号</span><br />
        国内销售电话：<strong class="tel">0537-2569666 2560011</strong>　传真：<strong class="tel">0537-2569088</strong> 
      </div>
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