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
//	response.sendRedirect("/brandshop/hi-tech/") ;
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
<title>烟台普堃官方旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="烟台普堃,烟台普堃产品报价,烟台普堃产品,烟台普堃产品图片,烟台普堃产品介绍,烟台普堃介绍" />
<meta name="description" content="中国工程机械商贸网为您提供烟台普堃介绍,烟台普堃产品介绍,烟台普堃产品报价,烟台普堃产品图片,烟台普堃产品展示等烟台普堃产品信息，帮助您全面了解烟台普堃。" />
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
</head>
<body class="flag_shop shopList">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"></jsp:include>
<!--main-->
<div class="listPart">
  <div class="contain980 pt20 clearfix">
    <div class="shopContain clearfix">
      <div class="shopLeftPart">
        <div class="shopmenu">
          <h2>产品列表</h2>
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
        </div>
        <div class="shopIntro">
          <div class="title">
            <h2>店铺介绍</h2>
          </div>
          <div class="content">
            <p class="intro">
              <strong class="name">烟台普堃液压设备有限公司</strong>
              <a href="introduce.jsp" target="_blank" style="color:#434343;">创建于中国风景秀丽的海滨城市烟台。普堃秉承“真挚、求实、发展”的企业理念，为客户提供优质的技术维修支持、始终以满意客户博得客户信赖为基础，致力于成为国际一流</a>
              <span class="more"><a href="introduce.jsp" target="_blank">更多&gt;&gt;</a></span>
            </p>
            <ul>
              <li>商　　家：<strong class="name">烟台普堃官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：山东</li>
              <li>24小时服务电话：400-666-2850</li>
              <li>联系电话：0535－3451876</li>
              <li>传　　真：0535－3451870</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
          </div>
        </div>
        
      </div>
      <div class="shopRightPart">
      
        <div class="listBanner"><img src="images/listbanner.jpg" width="690" height="250" /></div>  
              
        <div class="pukunTitle">
          <h2><span>HTB系列破碎锤</span></h2>
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
        
        
        <div class="shopListPage" style="<%=pageBean.getPageCount()<=1?"display:none;":"" %>width:400px;float:left;">
         <tags:page pageBean="<%=pageBean %>"/>
        </div>
      </div>
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
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com', '湖南烟台普堃官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('湖南烟台普堃官方旗舰店', 'http://product.21-sun.com',"");
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