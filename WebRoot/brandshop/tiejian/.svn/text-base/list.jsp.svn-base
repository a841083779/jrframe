<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
String catalognum = CommonString.getFilterStr(request.getParameter("num")) ;   // 栏目 
if(catalognum.indexOf("<script")!=-1||catalognum.indexOf("alert")!=-1||catalognum.indexOf("src=")!=-1||catalognum.indexOf("onmouseover")!=-1){
catalognum="";
}
String whereStr = " and is_show=1 and factoryid=1758" ;
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
String sel_sql2 = "select num,catalogname from pro_factory_category where factoryid=1758" ;
List<Map> catalogList = dbHelper.getMapList(sel_sql2) ;
String catalogname = "" ;
if(catalognum.equals("101")){
	catalogname = "全断面隧道掘进机";
}else if(catalognum.equals("102")){
	catalogname = "矿山法隧道机械";
}else if(catalognum.equals("106")){
	catalogname = "桩基础机械";
}else if(catalognum.equals("105")){
	catalogname = "搅拌运输车";
}else if(catalognum.equals("104")){
	catalogname = "混凝土搅拌设备";
}else if(catalognum.equals("103")){
	catalogname = "混凝土泵车";
}
//厂家信息
Map m = dbHelper.getMap("select * from pro_agent_factory where id = '1758'");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=catalogname %>履带式挖掘机_铁建重工_铁建重工品牌专区 - 中国工程机械商贸网</title>
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
</head>
<body class="flag_shop shopList">
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
            <li class="<%=catalognum.equals("101")?"select":"" %>"><a href="list.jsp?num=101">全断面隧道掘进机</a></li>
            <li class="<%=catalognum.equals("102")?"select":"" %>"><a href="list.jsp?num=102">矿山法隧道机械</a></li>
            <li class="<%=catalognum.equals("106")?"select":"" %>"><a href="list.jsp?num=106">桩基础机械</a></li>
            <li class="<%=catalognum.equals("105")?"select":"" %>"><a href="list.jsp?num=105">搅拌运输车</a></li>
            <li class="<%=catalognum.equals("104")?"select":"" %>"><a href="list.jsp?num=104">混凝土搅拌设备</a></li>
            <li class="<%=catalognum.equals("103")?"select":"" %>"><a href="list.jsp?num=103">混凝土泵车</a></li>
          </ul>
        </div>
        <div class="shopIntro">
          <div class="title">
            <h2>店铺介绍</h2>
          </div>
          <div class="content">
            <p class="intro"> <strong class="name"><%=CommonString.getFormatPara(m.get("full_name"))%></strong> <a href="introduce.jsp" target="_blank" style="color:#434343;">前身为中铁轨道系统集团，是集高端轨道装备和重型机械装备研究、设计、制造、施工于一体的大型专业化集团，在湖南、四川、河北和甘肃等地建立了多个制造基地，在长沙、北京、上海等地建立了11个研究院，技术中心拥有专业研发人员800余人。 </a><span class="more"><a href="introduce.jsp">更多&gt;&gt;</a></span> </p>
            <ul>
              <li>商　　家：<strong class="name"><%=CommonString.getFormatPara(m.get("name"))%>官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：湖南省长沙经济技术开发区东七路88号</li>
              <li>服务电话：400-895-6789</li>
              <li>联系电话：0086-0731-84071802</li>
              <li>传　　真：0086-0731-84071700</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
          </div>
        </div>
      </div>
      <div class="shopRightPart">
        <div class="listBanner"><img src="images/listbanner01.jpg" width="690" height="220" /></div>
        <div class="strongTitle">
          <h2><span>铁建重工<%=catalogname %></span></h2>
        </div>
        <div class="listContain">
          <ul class="list">
            <%
            	if(null!=productsList && productsList.size()>0){
            		for(Map oneMap:productsList){
            	%>
            <li><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img src="/uploadfiles<%=CommonString.getFormatPara(oneMap.get("img2")) %>" width="305" height="215" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" />
              <h3><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %></h3></a>
              <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">参数</a><em class="w">|</em><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm", "_message.shtm") %>" target="_blank">评论</a></span>
              <a href="javascript://void(0);" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid_sub")) %>');" class="btn">立即订购</a>
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