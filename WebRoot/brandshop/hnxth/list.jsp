<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
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
pageBean.setFields(" factoryname,name,catalogname_spe,catalogname,img2,id,factoryid_sub,file_name") ;
pageBean.setPageSize(8) ;
pageBean.setIsShowSql(true) ;
Integer nowPage = 1;
if (!"".equals(offset) && !"0".equals(offset)) {
	nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
}; // 当前页
pageBean.setNowPage(nowPage) ;
if("".equals(factoryid_sub)){
	factoryid_sub = "1236" ;
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
pageBean.setOrderBy("name asc") ;
if(!"".equals(factoryid_sub) && !"".equals(catalognum)){
	catalogMap = dbHelper.getMap(sel_sql,new Object[]{factoryid_sub,catalognum}) ;
	pageBean.setCondition(" and is_show=1 and factoryid="+factoryid_sub+" and catalognum_spe="+catalognum) ;
}else{
	catalogMap = dbHelper.getMap(" select catalogname_spe,name,factoryname from pro_products where factoryid_sub=?",new Object[]{factoryid_sub}) ;
	pageBean.setCondition(" and is_show=1 and factoryid_sub="+factoryid_sub) ;
}
if(null == catalogMap){
//	response.sendRedirect("/brandshop/hnxth/") ;
//	return ;
}
//pageBean.setIsShowSql(true) ;
productsList = pageBean.getDatas() ;

//选出所有的类别
String sel_sql2 = " select num,catalogname from dbo.pro_factory_category where factoryid=1236 order by id" ;
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>新天和官方旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="新天和,新天和产品报价,新天和产品,新天和产品图片,新天和产品介绍,新天和介绍" />
<meta name="description" content="中国工程机械商贸网为您提供新天和介绍,新天和产品介绍,新天和产品报价,新天和产品图片,新天和产品展示等新天和产品信息，帮助您全面了解新天和。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop01.css" rel="stylesheet" type="text/css" />
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
<body class="flag_shop shopList">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<div class="shop_topbg">
  <div class="contain980">
    <h2><img src="images/new_shop_logos.png" alt="湖南新天和官方旗舰店" width="409" height="100" /></h2> 
    <span class="l" style="padding-top:45px;"><img src="/images/ico.gif" /></span>
    <div class="shop_tel">湖南新天和客服热线：0731-52825566<br />营销热线：0731-52825569 　13875985255</div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li style="background:none;"><a href="./" class="<%=catalognum.equals("")?"selected":"" %>">首页HOME</a></li>
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
    <a class="qq" href="javascript:;" onclick="addShop();return false ;"><img src="images/new_shop_bm.gif" alt="收藏本店铺" width="128" height="30" /></a>
  </div>
</div>
<!--main-->
<div class="listPart">
  <div class="contain980 pt20 clearfix">
    <div class="shopContain clearfix">
      <div class="shopLeftPart">
        <h2>产品分类</h2>
        <ul class="shopListMenu">
          <%
          	if(null!=catalogList && catalogList.size()>0){
          		for(int i=0;i<catalogList.size();i++){
          			Map oneMap = catalogList.get(i) ;
          			%>
          			 <li class="<%=catalognum.equals(CommonString.getFormatPara(oneMap.get("num")))?"select":"" %>"><a href="list.jsp?num=<%=CommonString.getFormatPara(oneMap.get("num")) %>"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></li>
          			<%
          		}
          	}
          %>
        </ul>
        
        <div class="shopIntro">
          <div class="title">
            <h2>店铺介绍</h2>
          </div>
          <div class="content">
            <p class="intro">
              <strong class="name">湖南新天和工程设备有限公司</strong>
              <a href="introduce.jsp" target="_blank" style="color:#434343;">位于国家级经济技术开发区--湖南湘潭九华示范区，占地100亩，注册资本2800万元，专业研发、生产、销售高性能、环保型工程机械产品，自营机械设备进出口业务。主要产品有</a>
              <span class="more"><a href="introduce.jsp" target="_blank">更多&gt;&gt;</a></span>
            </p>
            <ul>
              <li>商　　家：<strong class="name">新天和官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：湖南</li>
              <!--<li>服务电话：0731-52825555</li>-->
              <li>营销热线：0731-52825569</li>
              <li>售后热线：0731-52825566</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
            <div class="clearfix" style="padding:5px 20px;">
              <!-- <span class="l"><a href="javascript:;" onclick="addShop();">收藏店铺</a></span>-->
              <!-- <span class="r"><a href="/brand/hnxth/" target="_blank">关注店铺</a></span>  -->
            </div>
          </div>
        </div>
        
      </div>
      <div class="shopRightPart">
        <div class="listBanner">
        <a href="/brandshop/hnxth/" target="_blank" title="湖南新天和工程设备有限公司">
        <img src="images/listbanner.jpg" width="650" height="210" />
        </a>
        </div>
        <div class="partList">
          <ul>
           <%
        	if(null!=productsList && productsList.size()>0){
        		for(Map oneMap:productsList){
        			%>
            <li> <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>" class="img"><img onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%>" /></a>
              <div class="intro">
                <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h3>
                <span class="l"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a><em>|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>" target="_blank">评论</a></span> <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="plBtn">立即询价</a> </div>
            </li>
        			<%
        		}
        	}
        %>
          </ul>
        </div>
        <div class="shopListPage" style="<%=pageBean.getPageCount()<=1?"display:none;":"" %>width:400px;float:left;">
         <tags:page pageBean="<%=pageBean %>"/>
        </div>
      </div>
    </div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<div class="footbg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot-->
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com', '湖南新天和官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('湖南新天和官方旗舰店', 'http://product.21-sun.com',"");
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