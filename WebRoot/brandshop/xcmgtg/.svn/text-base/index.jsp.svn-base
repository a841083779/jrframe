<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "  select top 8 * from pro_products where factoryid=1522 and catalognum_spe=? and is_show=1" ;
	List<Map> productsList = null ;
	
	List<Map> recommondProductsList = new ArrayList() ;
	String rec_sql = " select top 4 * from pro_products where factoryid=1522 and zoomlion_hot=11 and is_show=1" ; // 是否热卖推荐
	recommondProductsList = dbHelper.getMapList(rec_sql) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>徐工特机官方旗舰店 - 铁臂商城</title>
<meta name="keywords" content="徐工特机,徐工特机产品报价,徐工特机产品,徐工特机产品图片,徐工特机产品介绍,徐工特机介绍" />
<meta name="description" content="铁臂商城为您提供徐工特机介绍,徐工特机产品介绍,徐工特机产品报价,徐工特机产品图片,徐工特机产品展示等徐工特机产品信息，帮助您全面了解徐工特机。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/flag_shop01.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"></jsp:include>
<!--main-->
<div class="new_rec" style="background:#ffb605 url(/images/new_bigbanner.jpg) center top no-repeat;">
  <a href="/proDetail/XT750.shtm" target="_blank"></a>
</div>
<div class="shopPart01">
  <div class="contain980 pt20 pb20">
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
      <div class="icon"><img src="/images/ico.gif" alt="旗舰店放心购" width="80" height="17" /></div>
      <div class="hotLine">徐工集团统一客服热线：400-110-9999　　销售热线：0516-85554212　87899099</div>
    </div>
    <div class="coupon">
      <p class="text"><strong>优惠政策：给予每台订单返1000元现金的优惠支持。</strong><br />
        返利流程：<br />
        1. 用户在线提交指定机型订单，用户将收到21-sun发送的优惠提醒短信。<br />
        2. 21-sun将订单信息反馈至厂家及代理商<br />
        3. 用户线下成交<br />
        4. 用户按短信提示，返回21-sun提交成交信息（姓名+电话+成交机型）<br />
        5. 21-sun核实用户信息后，短信通知用户到21-sun平台上提交身份验证信息（身份证扫描件、购机合同扫描件、用户同设备的合影、银行账户信息等）<br />
        6. 21-sun再次审核后，确定要返利的用户名单。返利将以一个季度为单位，通过全年巡展活动，邀约用户到达现场，进行奖金颁发，无法到达现场的用户，将以一个季度为单位进行汇款。
      </p>
      <div class="img"><a href="javascript:;"><img src="/images/new_coupon_img.png" alt="网上购机优惠券" width="244" height="232" /></a></div>
    </div>
  <div class="clear"></div>
  </div>
</div>
<div class="shopPart02">
  <div class="contain980">
    <ul class="shopPros style01">
    <%
    	if(recommondProductsList!=null && recommondProductsList.size()>=2){
    	for(int i=0;i<=1;i++){
    		Map oneMap = recommondProductsList.get(i) ;
    		%>
    	  <li> <a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" width="465" height="365" /></a><span class="price">20万</span>
        <div class="title">
           <a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><h3><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname_spe")) %></h3></a>
          <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','')" class="buyBtn">立即预定</a>
        </div>
       </li>
    		<%
    	}
    	}
    %>
    </ul>
    <div class="shadow01"></div>
    <ul class="shopPros style02">
     <%
     	if(null!=recommondProductsList && recommondProductsList.size()>=4){
     		for(int i=2;i<=3;i++){
     			Map oneMap = recommondProductsList.get(i) ;
     			%>
     	<li> <a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" width="465" height="365" /></a><span class="price">20万</span>
        <div class="title">
          <a href="<%="/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><h3><%=CommonString.getFormatPara(oneMap.get("name")) +CommonString.getFormatPara(oneMap.get("catalogname_spe"))%></h3></a>
          <a href="javascript:;"  onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','')" class="buyBtn">立即预定</a>
        </div>
       </li>
     			<%
     		}
     	}
     %>
    </ul>
    <div class="shadow02"></div>
  </div>
</div>
<div class="shopPart03">
  <div class="contain980">
    <div class="shopContain" id="101">
      <div class="title">
        <h3><strong>轮式装载机系列</strong><span class="en"><em>XCMG  Products list</em><br />Wheel Loader</span></h3>
        <span class="more"><a href="list.jsp?num=101" target="_blank">更多&gt;</a></span>
      </div>
      <div class="bigRec"><a href="/proDetail/LW180.shtm" target="_blank"><img src="/images/new_shop_proimgs01.jpg" width="940" height="380" /></a><span class="price">20万</span></div>
      <ul class="shopPros01">
     <%
    	 productsList = dbHelper.getMapList(sel_sql,new Object[]{"101"}) ;
     	 if(null!=productsList && productsList.size()>0){
     		 for(Map oneMap:productsList){
     			 %>
     	 <li>
          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="225" height="212" /></a></div>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
          <a href="javascript:;" onclick='showinquery(<%=CommonString.getFormatPara(oneMap.get("id")) %>,1522)' class="priceBtn">立即询价</a>
         </li>
     			 <%
     		 }
     	 }
     %>
      </ul>
    </div>
    <div class="shopContain" id="102">
      <div class="title">
        <h3><strong>矿用装载机系列</strong><span class="en"><em>XCMG  Products list</em><br />Mine Loader</span></h3>
        <span class="more"><a href="list.jsp?num=102" target="_blank">更多&gt;</a></span>
      </div>
      <div class="bigRec"><a href="http://product.21-sun.com/proDetail/LW220-7.shtm" target="_blank"><img src="/images/new_shop_proimgs03.jpg" width="940" height="380" /></a><span class="price">20万</span></div>
      <ul class="shopPros01">
       <%
    	 productsList = dbHelper.getMapList(sel_sql,new Object[]{"102"}) ;
     	 if(null!=productsList && productsList.size()>0){
     		 for(Map oneMap:productsList){
     			 %>
     	 <li>
          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="225" height="212" /></a></div>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
          <a href="javascript:;" onclick='showinquery(<%=CommonString.getFormatPara(oneMap.get("id")) %>,1522)' class="priceBtn">立即询价</a>
         </li>
     			 <%
     		 }
     	 }
     %>
      </ul>
    </div>
    
    <div class="shopContain" id="103">
      <div class="title">
        <h3><strong>挖掘装载机系列</strong><span class="en"><em>XCMG  Products list</em><br />Backhoe Loader </span></h3>
        <span class="more"><a href="list.jsp?num=103" target="_blank">更多&gt;</a></span>
      </div>
      <div class="bigRec"><a href="/proDetail/WZ30-25-88.shtm" target="_blank"><img src="/images/new_shop_proimgs04.jpg" width="940" height="380" /></a><span class="price">20万</span></div>
      <ul class="shopPros01">
        <%
    	 productsList = dbHelper.getMapList(sel_sql,new Object[]{"103"}) ;
     	 if(null!=productsList && productsList.size()>0){
     		 for(Map oneMap:productsList){
     			 %>
     	 <li>
          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="225" height="212" /></a></div>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
          <a href="javascript:;" onclick='showinquery(<%=CommonString.getFormatPara(oneMap.get("id")) %>,1522)' class="priceBtn">立即询价</a>
         </li>
     			 <%
     		 }
     	 }
     %>
      </ul>
    </div>
    
    <div class="shopContain" id="104">
      <div class="title">
        <h3><strong>滑移装载机系列</strong><span class="en"><em>XCMG  Products list</em><br />Slide Loader </span></h3>
        <span class="more"><a href="list.jsp?num=104" target="_blank">更多&gt;</a></span>
      </div>
      <div class="bigRec"><a href="/proDetail/XT750.shtm" target="_blank"><img src="/images/new_shop_proimgs05.jpg" width="940" height="380" /></a><span class="price">20万</span></div>
      <ul class="shopPros01">
        <%
    	 productsList = dbHelper.getMapList(sel_sql,new Object[]{"104"}) ;
     	 if(null!=productsList && productsList.size()>0){
     		 for(Map oneMap:productsList){
     			 %>
     	 <li>
          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="225" height="212" /></a></div>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
          <a href="javascript:;" onclick='showinquery(<%=CommonString.getFormatPara(oneMap.get("id")) %>,1522)' class="priceBtn">立即询价</a>
         </li>
     			 <%
     		 }
     	 }
     %>
      </ul>
    </div>
    
    <div class="shopContain" id="106">
    <a name='105'></a>
      <div class="title">
        <h3><strong>伸缩臂叉装车、叉车</strong><span class="en"><em>XCMG  Products list</em><br />Telescopic Handler</span></h3>
        <span class="more"><a href="list.jsp?num=106" target="_blank">更多&gt;</a></span>
      </div>
      <div class="bigRec"><a href="/proDetail/XT550CD.shtm" target="_blank"><img src="/images/new_shop_proimgs06.jpg" width="940" height="380" /></a><span class="price">20万</span></div>
      <ul class="shopPros01">
        <%
    	 productsList = dbHelper.getMapList(sel_sql,new Object[]{"106"}) ;
     	 if(null!=productsList && productsList.size()>0){
     		 for(Map oneMap:productsList){
     			 %>
     	 <li>
          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="225" height="212" /></a></div>
          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
          <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
          <a href="javascript:;" onclick='showinquery(<%=CommonString.getFormatPara(oneMap.get("id")) %>,1522)' class="priceBtn">立即询价</a>
         </li>
     			 <%
     		 }
     	 }
     %>
      </ul>
    </div>
    
  <div class="clear"></div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/brandshop/include/foot.jsp" flush="true"></jsp:include>
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
function addCookie(){　 // 加入收藏夹
     try{
       window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
   }catch (e){
       try{
           window.sidebar.addPanel('http://product.21-sun.com', '21-sun产品中心');
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
function addShop(){　 // 收藏我们
 try{
       window.external.addFavorite('http://product.21-sun.com', '中联土石方机械旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('http://product.21-sun.com', '中联土石方机械旗舰店');
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>