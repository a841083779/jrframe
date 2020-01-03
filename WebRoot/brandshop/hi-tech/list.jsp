<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;   // 栏目 
String whereStr = " and is_show=1 and factoryid=403" ;
if(!"".equals(catalognum)){
	whereStr += " and catalognum_spe='"+catalognum+"'" ;
}
DBHelper dbHelper = DBHelper.getInstance() ;
PageBean pageBean = new PageBean() ; 
String offset = CommonString.getFormatPara(request.getParameter("offset"));
pageBean.setTableName("pro_products") ;
pageBean.setCondition(whereStr) ;
pageBean.setFields(" factoryname,name,catalogname_spe,catalogname,img2,id,file_name") ;
pageBean.setPageSize(9) ;
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
pageBean.setOrderBy("img2 desc") ;
productsList = pageBean.getDatas() ;
if(null==productsList ||productsList.size()==0){
	response.sendRedirect("index.jsp") ;
}
//选出所有的类别
String sel_sql2 = "select  num,catalogname from pro_factory_category where factoryid=403 and len(num)>3" ;
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
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>普堃韩泰克_普堃韩泰克品牌专区 - 中国工程机械商贸网</title>
<meta name="keywords" content="普堃韩泰克,普堃韩泰克产品报价,普堃韩泰克产品,普堃韩泰克产品图片,普堃韩泰克产品介绍,普堃韩泰克介绍" />
<meta name="description" content="中国工程机械商贸网为您提供普堃韩泰克介绍,普堃韩泰克产品介绍,普堃韩泰克产品报价,普堃韩泰克产品图片,普堃韩泰克产品展示等普堃韩泰克产品信息，帮助您全面了解普堃韩泰克。" />
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
              <a href="introduce.jsp" target="_blank" style="color:#434343;">创建于中国风景秀丽的海滨城市烟台。普堃秉承“真挚、求实、发展”的企业理念，为客户提供优质的技术维修支持、始终以满意客户博得客户信赖为基础，致力于成为国际一流企业。 </a><span class="more"><a href="introduce.jsp" target="_blank">更多&gt;&gt;</a></span>
            </p>
            <ul>
              <li>商　　家：<strong class="name">烟台普堃官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：山东</li>
              <li>24小时服务电话：400-666-2850</li>
              <li>联系电话：0535－3451876</li>
              <li>传　　真：0535－2161737</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
          </div>
        </div>
        
      </div>
      <div class="shopRightPart">
      
        <div class="listBanner"><img src="images/listbanner.jpg" width="690" height="250" /></div>  
              
        <div class="pukunTitle">
          <h2><span>普堃韩泰克<%=catalogname %>破碎锤</span></h2>
        </div>
        
        <div class="pukunContent">
          <ul class="list">
            <%
            	if(null!=productsList && productsList.size()>0){
            		for(Map oneMap:productsList){
            	%>
            <li>
              <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="305" height="215" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a></div>
              <div class="intro">
                <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("catalogname_spe"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
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