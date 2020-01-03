<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;   // 栏目 
String factoryid_sub = CommonString.getFormatPara(request.getParameter("factoryid_sub")) ; // 品牌 id
String sel_sql = " select catalogname from pro_factory_category where factoryid=? and num =?" ;
DBHelper dbHelper = DBHelper.getInstance() ;
PageBean pageBean = new PageBean() ; 
String offset = CommonString.getFormatPara(request.getParameter("offset"));
pageBean.setTableName("pro_products") ;
pageBean.setFields(" factoryname,name,catalogname_spe,img2,id,factoryid_sub,file_name") ;
pageBean.setOrderBy(" order_no desc") ;
pageBean.setPageSize(21) ;
// pageBean.setIsShowSql(true) ;
Integer nowPage = 1;
if (!"".equals(offset) && !"0".equals(offset)) {
	nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
}; // 当前页
pageBean.setNowPage(nowPage) ;
if("".equals(factoryid_sub)){
	factoryid_sub = "1522" ;
}
pageBean.setIsShowSql(true) ;
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
	pageBean.setCondition(" and is_show=1 and factoryid="+factoryid_sub+" and catalognum_spe="+catalognum) ;
}else{
	catalogMap = dbHelper.getMap(" select catalogname_spe,name,factoryname from pro_products where factoryid_sub=?",new Object[]{factoryid_sub}) ;
	pageBean.setCondition(" and is_show=1 and factoryid_sub="+factoryid_sub) ;
}
if(null == catalogMap){
	response.sendRedirect("/brandshop/xcmgtg/") ;
	return ;
}
//pageBean.setIsShowSql(true) ;
productsList = pageBean.getDatas() ;

//选出所有的类别
String sel_sql2 = " select num,catalogname from dbo.pro_factory_category where factoryid=1522 order by id" ;
List<Map> catalogList = dbHelper.getMapList(sel_sql2) ;
String catalogname = "" ;
if(null!=catalogList && catalogList.size()>0){
	for(Map oneMap:catalogList){
		if(catalognum.equals(CommonString.getFormatPara(oneMap.get("num")))){
			catalogname = CommonString.getFormatPara(oneMap.get("catalogname")) ;
			break ;
		}
	}
}
	Map enCatalogNumMap = new HashMap() ;
	enCatalogNumMap.put("101","Wheel Loader") ; // 轮式装载机
	enCatalogNumMap.put("102","Mine Loader") ; // 矿用装载机系列
	enCatalogNumMap.put("103","Backhoe Loader") ; // 挖掘装载机系列
	enCatalogNumMap.put("104","Slide Loader") ; // 滑移装载机系列
	enCatalogNumMap.put("106","Telescopic Handler") ;  // 伸缩臂叉装车、叉车	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>徐工特机官方旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="徐工特机,徐工特机产品报价,徐工特机产品,徐工特机产品图片,徐工特机产品介绍,徐工特机介绍" />
<meta name="description" content="中国工程机械商贸网为您提供徐工特机介绍,徐工特机产品介绍,徐工特机产品报价,徐工特机产品图片,徐工特机产品展示等徐工特机产品信息，帮助您全面了解徐工特机。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/flag_shop01.css" rel="stylesheet" type="text/css" />
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
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
    <h2><img src="/images/new_shop_logos.png" alt="中联土石方机械旗舰店" width="452" height="100" /></h2> 
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="/images/new_shop_bm.png" alt="收藏本店铺" width="150" height="35" /></a></div>
    <div class="shop_ads"><img src="/images/new_shop_ads.png" alt="网上购机有千元现金拿" width="78" height="39" /></div>
    <div class="shop_tel">徐工集团统一客服热线：400-110-9999<br />销售热线：0516-85554212　87899099</div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li><a href="./" class="<%=catalognum.equals("")?"selected":"" %>">首页</a></li>
      <%
      if(null!=catalogList && catalogList.size()>0){
    	  for(Map oneMap:catalogList){
        		%>
        		<li><a href="list.jsp?num=<%=CommonString.getFormatPara(oneMap.get("num")) %>" class="<%=CommonString.getFormatPara(oneMap.get("num")).equals(catalognum)?"selected":"" %>"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></li>
        		<%
        	}
      }
      %>
    </ul>
  </div>
</div>
<div class="shopPart03">
  <div class="contain980 pt20 clearfix" style="_overflow:hidden;">
    <div class="shopContain">
      <div class="shopLeftPart">
        <h2>所有产品分类&gt;&gt;</h2>
        <ul class="shopListMenu">
          <%
          	if(null!=catalogList && catalogList.size()>0){
          		for(int i=0;i<catalogList.size();i++){
          			Map oneMap = catalogList.get(i) ;
          			%>
          			 <li class="<%=catalognum.equals(CommonString.getFormatPara(oneMap.get("num")))?"select":"" %>"><a href="?num=<%=CommonString.getFormatPara(oneMap.get("num")) %>"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></li>
          			<%
          		}
          	}
          %>
        </ul>
      </div>
      <div class="shopRightPart">
      	<div class="title">
          <h3><strong><%=catalogname %></strong>
             <span class="en"><em>XCMG  Products list</em><br />
             <%=CommonString.getFormatPara(enCatalogNumMap.get(catalognum)) %>
             </span>
          </h3>
         </div>
        <ul class="shopPros01" style="padding-bottom:0px;">
        <%
        	if(null!=productsList && productsList.size()>0){
        		for(Map oneMap:productsList){
        			%>
        	<li>
            <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="225" height="212" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"/></a></div>
            <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname_spe"))%></a></h3>
            <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span>
            <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="priceBtn">立即询价</a>
          </li>
        			<%
        		}
        	}
        %>
        </ul>
        <div class="shopListPage">
         <tags:page pageBean="<%=pageBean %>"/>
        </div>
      </div>
    </div>
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
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
    if (document.all){
        window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
    }else if (window.sidebar){
        window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
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
DK.load('scripts/core.js', function(){ 
	DK.index.init();
});
</script> 
</body>
</html>