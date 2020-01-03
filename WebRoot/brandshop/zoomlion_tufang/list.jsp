<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")) ;   // 栏目 
	String factoryid_sub = CommonString.getFormatPara(request.getParameter("factoryid_sub")) ; // 品牌 id
	String sel_sql = " select catalogname from pro_factory_category where factoryid=? and num =?" ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	PageBean pageBean = new PageBean() ; 
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	pageBean.setTableName("pro_products") ;
	pageBean.setFields(" factoryname,name,catalogname_spe,img2,id,factoryid_sub,file_name") ;
	pageBean.setOrderBy(" order_no desc") ;
	pageBean.setPageSize(20) ;
	Integer nowPage = 1;
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}; // 当前页
	pageBean.setNowPage(nowPage) ;
	if("".equals(factoryid_sub)){
		factoryid_sub = "1780" ;
	}
	Map catalogMap = null ;
	List<Map> productsList = null ;
	String url = CommonString.getFormatPara(request.getQueryString());
	if (!"".equals(url)) {
		if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
			url = "";
		} else if (url.indexOf("offset") != -1) {
			url = "&" + url.substring(url.indexOf("&") + 1);
		} else {
			url = "&" + url;
		}
	}
	pageBean.setParams(url);
	if(!"".equals(factoryid_sub) && !"".equals(catalognum)){
		catalogMap = dbHelper.getMap(sel_sql,new Object[]{factoryid_sub,catalognum}) ;
		pageBean.setCondition(" and factoryid_sub="+factoryid_sub+" and catalognum_spe="+catalognum) ;
	}else{
		catalogMap = dbHelper.getMap(" select catalogname_spe,name,factoryname from pro_products where factoryid_sub=?",new Object[]{factoryid_sub}) ;
		pageBean.setCondition(" and factoryid_sub="+factoryid_sub) ;
	}
	if(null == catalogMap){
		response.sendRedirect("/brandshop/zoomlion_tufang/") ;
		return ;
	}
	productsList = pageBean.getDatas() ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>中联土方机械官方旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="中联土方机械,中联土方机械产品报价,中联土方机械产品,中联土方机械产品图片,中联土方机械产品介绍,中联土方机械介绍" />
<meta name="description" content="中国工程机械商贸网为您提供中联土方机械介绍,中联土方机械产品介绍,中联土方机械产品报价,中联土方机械产品图片,中联土方机械产品展示等中联土方机械产品信息，帮助您全面了解中联土方机械。" />
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
<jsp:include page="top.jsp" flush="true"></jsp:include>

<div class="shopPart03">
  <div class="contain980">
    <div class="shopContain shopList">
      <div class="spTitle01">
        <div class="sptbg">
          <h2><%=catalognum.equals("")?"全部产品":CommonString.getFormatPara(catalogMap.get("catalogname")) %></h2>
          <h3 class="breadCrumbs">您现在的位置：<a href="/brandshop/zoomlion_tufang/">店铺首页</a><em>&gt;</em><%=catalognum.equals("")?"全部产品":CommonString.getFormatPara(catalogMap.get("catalogname")) %></h3>
        </div>
      </div>
      <ul class="shopPros02">
       <%
       if(null!=productsList && productsList.size()>0){
    	   for(Map oneMap:productsList){
    		   %>
    		   <li>
	          <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="<%="/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" width="230" height="178" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"/></a></div>
	          <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname_spe")) %></a></h3>
	          <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="priceBtn">立即询价</a>
	        </li>
    		   <%
    	   }
       }
       %>
      </ul>  
       <div class="shopListPage">
      	<tags:page pageBean="<%=pageBean%>"/>
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
