<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;   // 栏目 
String whereStr = " and is_show=1 and factoryid=141 and catalognum like '101002%'" ;
if(!"".equals(catalognum)){
	whereStr += " and catalognum_spe='"+catalognum+"'" ;
}
DBHelper dbHelper = DBHelper.getInstance() ;
PageBean pageBean = new PageBean() ; 
String offset = CommonString.getFormatPara(request.getParameter("offset"));
pageBean.setTableName("pro_products") ;
pageBean.setCondition(whereStr) ;
pageBean.setFields(" factoryname,name,catalogname_spe,catalogname,img2,id,file_name") ;
pageBean.setPageSize(20) ;
// pageBean.setIsShowSql(true) ;
Integer nowPage = 1;
if (!"".equals(offset) && !"0".equals(offset)) {
	nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
}; // 当前页 
pageBean.setNowPage(nowPage) ;
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
productsList = pageBean.getDatas() ;
if(null==productsList ||productsList.size()==0){
	response.sendRedirect("index.jsp") ;
}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>雷沃装载机_雷沃装载机品牌专区 - 中国工程机械商贸网</title>
<meta name="keywords" content="雷沃装载机,雷沃装载机报价,雷沃装载机,雷沃装载机图片,雷沃装载机介绍,雷沃装载机介绍" />
<meta name="description" content="中国工程机械商贸网为您提供雷沃装载机介绍,雷沃装载机介绍,雷沃装载机报价,雷沃装载机图片,雷沃装载机展示等雷沃装载机信息，帮助您全面了解雷沃装载机。" />
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
<body class="flag_shop shopList channel_content">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"></jsp:include>
<!--main-->
<div class="listPart">
  <div class="contain980 clearfix">
    <div class="shopContain clearfix">
      <div class="shopLeftPart">
        <div class="shopmenu">
          <h2>产品列表</h2>
          <ul class="shopListMenu">
            <li class="select"><a href="list.jsp">装载机</a></li>
          </ul>
        </div>
        <div class="shopIntro">
          <div class="title">
            <h2>店铺介绍</h2>
          </div>
          <div class="content">
            <p class="intro">
              <strong class="name">福田雷沃国际重工股份有限公司</strong>
              <a href="introduce.jsp" target="_blank" style="color:#434343;">是一家以工程机械、农业装备、车辆、发动机、核心零部件为主体业务的大型产业装备制造企业，2012年，福田雷沃重工凭借在“内涵增长、结构调整、全球化”方面的卓越表现。 </a><span class="more"><a href="introduce.jsp" target="_blank">更多&gt;&gt;</a></span>
            </p>
            <ul>
              <li>商　　家：<strong class="name">福田雷沃官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：山东</li>
              <li>服务电话：400-8293-888</li>
              <li>联系电话：+86-536-7638388</li>
              <li>传　　真：+86-536-2288631</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
          </div>
        </div>
        
      </div>
      <div class="shopRightPart">
      
        <div class="listBanner"><img src="images/listbanner.jpg" width="690" height="250" /></div>  
              
        <div class="strongTitle">
          <h2><span>福田雷沃装载机</span></h2>
        </div>
        
        <div class="strongContent">
          <ul class="list">
            <%
            	if(null!=productsList && productsList.size()>0){
            		for(Map oneMap:productsList){
            	%>
            <li>
              <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" title="<%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="305" height="215" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a></div>
              <div class="intro">
                <h3><a title="<%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
                <span class="xunjia"><a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');">立即询价</a></span>
              </div>
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
<div class="flagshopbg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot-->
<script type="text/javascript">
jQuery("body").bind("contextmenu", function() {
  return false;
});
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>