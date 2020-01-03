<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String factoryid_sub = "1780" ;
	Map factoryinfoMap = dbHelper.getMap("select name,parent_factoryname,full_name,telphone,url,introduce,logo from  pro_agent_factory where id=?",new Object[]{factoryid_sub}) ;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>中联土方机械官方旗舰店 - 铁臂商城</title>
<meta name="keywords" content="中联土方机械,中联土方机械产品报价,中联土方机械产品,中联土方机械产品图片,中联土方机械产品介绍,中联土方机械介绍" />
<meta name="description" content="铁臂商城为您提供中联土方机械介绍,中联土方机械产品介绍,中联土方机械产品报价,中联土方机械产品图片,中联土方机械产品展示等中联土方机械产品信息，帮助您全面了解中联土方机械。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/flag_shop.css" rel="stylesheet" type="text/css" />
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include> 
<!--main-->
<div class="shop_topbg">
  <div class="contain980">
    <h2><img src="/images/shop_logos.png" alt="中联土方机械旗舰店" width="742" height="113" /></h2> 
  </div>
</div>
<jsp:include page="top.jsp" flush="true"><jsp:param value="contact" name="navFlag"/></jsp:include>
<div class="shopPart03">
  <div class="contain980">
    <div class="shopContain shopList">
      <div class="spTitle01">
        <div class="sptbg">
          <h2>联系我们</h2>
          <h3 class="breadCrumbs">您现在的位置：<a href="/brandshop/zoomlion_tufang/">店铺首页</a><em>&gt;</em>联系我们</h3>
        </div>
      </div>
      <div class="shop_Content">
  		 公司简称:<%=CommonString.getFormatPara(factoryinfoMap.get("name")) %><br /><br />
  		 公司全称:<%=CommonString.getFormatPara(factoryinfoMap.get("full_name")) %> <br /><br />
  		 所属集团:<%=CommonString.getFormatPara(factoryinfoMap.get("parent_factoryname")) %> <br /><br />
  		 公司网址:<a href="<%=CommonString.getFormatPara(factoryinfoMap.get("url")) %>" target="_blank"><%=CommonString.getFormatPara(factoryinfoMap.get("url")) %></a> <br /><br />
  		 公司电话:<%=CommonString.getFormatPara(factoryinfoMap.get("telphone")) %>
      </div>
        <jsp:include page="foot.jsp" flush="true"></jsp:include>
    </div>
  <div class="clear"></div> 
  </div> 
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
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
  jQuery(".shopBigBanner .shopBtn").scrollTo(700)
});
</script>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
    if (document.all){
        window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
    }else if (window.sidebar){
        window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
    }
}
function addShop(){　 // 收藏我们
    if (document.all){
        window.external.addFavorite('http://product.21-sun.com', '中联土方机械旗舰店');
    }else if (window.sidebar){
        window.sidebar.addPanel('中联土方机械旗舰店', 'http://www.product.21-sun.com', "");
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
