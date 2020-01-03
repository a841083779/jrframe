<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select id,name,file_name,img2,factoryname,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalognum,catalogname,zoomlion_hot from pro_products where factoryid=1758 and is_show=1 order by zoomlion_hot desc,order_no desc" ;
	List<Map> productsList = null ;
	productsList = dbHelper.getMapList(sel_sql) ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>铁建重工_铁建重工品牌专区 - 中国工程机械商贸网</title>
<meta name="keywords" content="铁建重工,铁建重工挖掘机报价,铁建重工挖掘机,铁建重工挖掘机图片,铁建重工挖掘机介绍,铁建重工介绍" />
<meta name="description" content="中国工程机械商贸网为您提供铁建重工介绍,铁建重工挖掘机介绍,铁建重工挖掘机报价,铁建重工挖掘机图片,铁建重工挖掘机展示等铁建重工挖掘机信息，帮助您全面了解铁建重工。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if (IE 6)]>
<script type="text/javascript" src="/scripts/iepng.js"></script>
<script type="text/javascript">
   EvPNG.fix('.png'); 
</script>
<![endif]-->
<script type="text/javascript">
var t1 = n1 = 0, count1,paseState1=0;
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
	jQuery("#slider .slider_btns a").hover(function(){clearInterval(t1)}, function(){t1 = setInterval("showAuto1()",5000);});
})
function showAuto1(){
	if(paseState1==0){
		n1 = n1 >=(count1 - 1) ? 0 : ++n1;
		jQuery("#slider .points li").eq(n1).trigger('click');
	}
}
function showPre1(){
	n1 = n1 <=0 ? (count1 - 1) : --n1;
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
    <li style="display:block; background:url(images/bigbanner01.jpg) center top no-repeat;"></li>
    <li style="background:url(images/bigbanner01.jpg) center top no-repeat;"></li>
  </ul>
  <ul class="points">
    <li value="1" class="selected"></li>
    <li value="2"></li> 
  </ul>
  <div class="slider_btns">
  <a class="prev" onclick="javascript:showPre1();" href="javascript:void(0);"></a>
  <a class="next" onclick="javascript:showAuto1();" href="javascript:void(0);"></a>
  </div>
</div>

<div class="proNav png">
  <ul>
    <li><a href="#lp01">盾构掘进机</a></li>
    <li><a href="#lp02">隧道轨道设备</a></li>
    <li><a href="#lp03">混凝土泵车</a></li>
    <li><a href="#lp04">混凝土搅拌设备</a></li>
    <li><a href="#lp05">混凝土搅拌运输车</a></li>
    <li><a href="#lp06">旋挖钻机</a></li>
    <li><a href="#lp07">其它混凝土设备</a></li>
  </ul>
</div>

<div class="contain980 sliderRec">
  <a class="prev"></a>
  <a class="next"></a>
  <div class="bd">
    <ul>
      <%
      	if(productsList!=null && productsList.size()>0){
      		for(Map oneMap : productsList){
      			if(CommonString.getFormatPara(oneMap.get("zoomlion_hot")).equals("11")){
      %>
      <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank"><img src="/uploadfiles<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>" width="157" height="104" />
        <h3><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3>
      </a></li>
      <%
      			}
      		}
      	}
      %>
    </ul>
  </div>
</div>
<script type="text/javascript">
$(".sliderRec").slide({ mainCell:".bd ul",effect:"leftLoop",vis:5,scroll:1,autoPlay:false,interTime:4000,prevCell:".prev",nextCell:".next"});
</script>

<div class="ilistPart">
  <div class="listTitle" id="lp01">
    <h3>盾构掘进机</h3>
    <span class="more"><a href="list.jsp?num=101">查看更多<em>&gt;&gt;</em></a></span>
  </div>
  <div class="listContain">
    <ul class="list">
      <%
	       if(null!=productsList && productsList.size()>0){
	    	   Map oneMap = null ;
	    	   int sum=1;
	    	   for(int i=0;i<productsList.size();i++){
	    		   oneMap = (HashMap)productsList.get(i) ;
	    		   if(CommonString.getFormatPara(oneMap.get("catalognum")).startsWith("110001") && sum<=4){
	    			   sum++ ;
	    			   %>
	    	  <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" />
		        <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3></a>
		        <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a><em class="w">|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm", "_message.shtm") %>" target="_blank">评论</a></span>
		        <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="btn">立即订购</a>
		      </li>
	    			   <%
	    		   }
	    	   }
	       }
	    %>
    </ul>
  </div>
</div>

<div class="ilistPart">
  <div class="listTitle" id="lp02">
    <h3>隧道轨道设备</h3>
    <span class="more"><a href="list.jsp?num=102">查看更多<em>&gt;&gt;</em></a></span>
  </div>
  <div class="listContain">
    <ul class="list">
      <%
	       if(null!=productsList && productsList.size()>0){
	    	   Map oneMap = null ;
	    	   int sum=1;
	    	   for(int i=0;i<productsList.size();i++){
	    		   oneMap = (HashMap)productsList.get(i) ;
	    		   if(CommonString.getFormatPara(oneMap.get("catalognum")).startsWith("110017") && sum<=4){
	    			   sum++ ;
	    			   %>
	    	  <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" />
		        <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3></a>
		        <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a><em class="w">|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm", "_message.shtm") %>" target="_blank">评论</a></span>
		        <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="btn">立即订购</a>
		      </li>
	    			   <%
	    		   }
	    	   }
	       }
	    %>
    </ul>
  </div>
</div>

<div class="ilistPart">
  <div class="listTitle" id="lp03">
    <h3>混凝土泵车</h3>
    <span class="more"><a href="list.jsp?num=103">查看更多<em>&gt;&gt;</em></a></span>
  </div>
  <div class="listContain">
    <ul class="list">
      <%
	       if(null!=productsList && productsList.size()>0){
	    	   Map oneMap = null ;
	    	   int sum=1;
	    	   for(int i=0;i<productsList.size();i++){
	    		   oneMap = (HashMap)productsList.get(i) ;
	    		   if(CommonString.getFormatPara(oneMap.get("catalognum")).startsWith("103001") && sum<=4){
	    			   sum++ ;
	    			   %>
	    	  <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" />
		        <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3></a>
		        <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a><em class="w">|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm", "_message.shtm") %>" target="_blank">评论</a></span>
		        <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="btn">立即订购</a>
		      </li>
	    			   <%
	    		   }
	    	   }
	       }
	    %>
    </ul>
  </div>
</div>

<div class="ilistPart">
  <div class="listTitle" id="lp04">
    <h3>混凝土搅拌设备</h3>
    <span class="more"><a href="list.jsp?num=104">查看更多<em>&gt;&gt;</em></a></span>
  </div>
  <div class="listContain">
    <ul class="list">
      <%
	       if(null!=productsList && productsList.size()>0){
	    	   Map oneMap = null ;
	    	   int sum=1;
	    	   for(int i=0;i<productsList.size();i++){
	    		   oneMap = (HashMap)productsList.get(i) ;
	    		   if(CommonString.getFormatPara(oneMap.get("catalognum")).startsWith("103002") && sum<=4){
	    			   sum++ ;
	    			   %>
	    	  <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" />
		        <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3></a>
		        <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a><em class="w">|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm", "_message.shtm") %>" target="_blank">评论</a></span>
		        <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="btn">立即订购</a>
		      </li>
	    			   <%
	    		   }
	    	   }
	       }
	    %>
    </ul>
  </div>
</div>

<div class="ilistPart">
  <div class="listTitle" id="lp05">
    <h3>混凝土搅拌运输车</h3>
    <span class="more"><a href="list.jsp?num=105">查看更多<em>&gt;&gt;</em></a></span>
  </div>
  <div class="listContain">
    <ul class="list">
      <%
	       if(null!=productsList && productsList.size()>0){
	    	   Map oneMap = null ;
	    	   int sum=1;
	    	   for(int i=0;i<productsList.size();i++){
	    		   oneMap = (HashMap)productsList.get(i) ;
	    		   if(CommonString.getFormatPara(oneMap.get("catalognum")).startsWith("103006") && sum<=4){
	    			   sum++ ;
	    			   %>
	    	  <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" />
		        <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3></a>
		        <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a><em class="w">|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm", "_message.shtm") %>" target="_blank">评论</a></span>
		        <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="btn">立即订购</a>
		      </li>
	    			   <%
	    		   }
	    	   }
	       }
	    %>
    </ul>
  </div>
</div>

<div class="ilistPart">
  <div class="listTitle" id="lp06">
    <h3>旋挖钻机</h3>
    <span class="more"><a href="list.jsp?num=106">查看更多<em>&gt;&gt;</em></a></span>
  </div>
  <div class="listContain">
    <ul class="list">
      <%
	       if(null!=productsList && productsList.size()>0){
	    	   Map oneMap = null ;
	    	   int sum=1;
	    	   for(int i=0;i<productsList.size();i++){
	    		   oneMap = (HashMap)productsList.get(i) ;
	    		   if(CommonString.getFormatPara(oneMap.get("catalognum")).startsWith("105003") && sum<=4){
	    			   sum++ ;
	    			   %>
	    	  <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" />
		        <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3></a>
		        <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a><em class="w">|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm", "_message.shtm") %>" target="_blank">评论</a></span>
		        <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="btn">立即订购</a>
		      </li>
	    			   <%
	    		   }
	    	   }
	       }
	    %>
    </ul>
  </div>
</div>

<div class="ilistPart">
  <div class="listTitle" id="lp07">
    <h3>其它混凝土设备</h3>
    <span class="more"><a href="list.jsp?num=107">查看更多<em>&gt;&gt;</em></a></span>
  </div>
  <div class="listContain">
    <ul class="list">
      <%
	       if(null!=productsList && productsList.size()>0){
	    	   Map oneMap = null ;
	    	   int sum=1;
	    	   for(int i=0;i<productsList.size();i++){
	    		   oneMap = (HashMap)productsList.get(i) ;
	    		   if(CommonString.getFormatPara(oneMap.get("catalognum")).startsWith("103015") && sum<=4){
	    			   sum++ ;
	    			   %>
	    	  <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" />
		        <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3></a>
		        <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a><em class="w">|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm", "_message.shtm") %>" target="_blank">评论</a></span>
		        <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="btn">立即订购</a>
		      </li>
	    			   <%
	    		   }
	    	   }
	       }
	    %>
    </ul>
  </div>
</div>


<div class="contain980 shopPart08" style="height:455px;">
  <div class="strongTitle">
    <h2>产品订单</h2>
    <span class="more"><a href="/inquiry/?factory=1758" target="_blank">查看更多<em>&gt;&gt;</em></a></span>
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
       pageBean.setCondition(" and factoryid=1758 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
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
      <div class="page" style="margin-left:450px;width:500px;clear:both;float:left;"><tags:page pageBean="<%=pageBean%>" /></div>
    </div>
  </div>
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
  jQuery(".proNav").scrollTo(700);
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