<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;   // 栏目 
String whereStr = " and is_show=1 and factoryid=662" ;
if(!"".equals(catalognum)){
	whereStr += " and catalognum='"+catalognum+"'" ;
}
DBHelper dbHelper = DBHelper.getInstance() ;
PageBean pageBean = new PageBean() ; 
String offset = CommonString.getFormatPara(request.getParameter("offset"));
pageBean.setTableName("pro_products") ;
pageBean.setCondition(whereStr) ;
pageBean.setFields(" factoryname,name,catalogname_spe,catalogname,img2,id,file_name") ;
pageBean.setPageSize(9) ;
pageBean.setIsShowSql(true) ;
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
<title>沃尔华_沃尔华品牌专区 - 中国工程机械商贸网</title>
<meta name="keywords" content="沃尔华,沃尔华挖掘机报价,沃尔华挖掘机,沃尔华挖掘机图片,沃尔华挖掘机介绍,沃尔华介绍" />
<meta name="description" content="中国工程机械商贸网为您提供沃尔华介绍,沃尔华挖掘机介绍,沃尔华挖掘机报价,沃尔华挖掘机图片,沃尔华挖掘机展示等沃尔华挖掘机信息，帮助您全面了解沃尔华。" />
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
     <li class="nav01"><a href="./list.jsp?num=101001001" <%if(catalognum.equals("101001001")){%> class='select'<%} %>>履带挖掘机</a></li>
     <li class="nav01"><a href="./list.jsp?num=101001004" <%if(catalognum.equals("101001004")){%> class='select'<%} %>>轮式挖掘机</a></li>
          </ul>
        </div>
        <div class="shopIntro">
          <div class="title">
            <h2>店铺介绍</h2>
          </div>
          <div class="content">
            <p class="intro">
              <strong class="name">沃尔华集团有限公司</strong>
              <a href="introduce.jsp" target="_blank" style="color:#434343;">沃尔华集团有限公司坐落于素有孔孟之乡的山东省济宁市，诚信为本培育了沃尔华公司的经营文化，深厚的中华文化底蕴铸就了沃尔华人朴实勤劳的工作作风。作为中国五大工程机械产业基地之一的济宁...</a><span class="more"><a href="introduce.jsp" target="_blank">更多&gt;&gt;</a></span>
            </p>
            <ul>
              <li>商　　家：<strong class="name">沃尔华官方旗舰店</strong></li>
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
      
        <div class="listBanner"><img src="images/listbanner.jpg" width="690" height="176" /></div>  
              
        <div class="pukunTitle">
          <h2><span><%if(catalognum.equals("101001001")){%>履带式<%}else if(catalognum.equals("101001004")){ %>轮式<%} %>挖掘机</span></h2>
        </div>
        
        <div class="pukunContent">
          <ul class="shopPros01">
            <%
            	if(null!=productsList && productsList.size()>0){
            		for(Map oneMap:productsList){
            	%>
            <li>
              <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="280" height="185" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a></div>
              <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h3>
              <span class="links"><a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_order.shtm") %>">订单</a> | <a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>">参数</a> | <a target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","_message.shtm") %>">评论</a></span>
              <a class="priceBtn" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');">立即询价</a>
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