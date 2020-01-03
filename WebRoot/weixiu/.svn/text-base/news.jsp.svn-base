<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.regex.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
    Map brandMap = (Map) application.getAttribute("brandMap");
    Map catalogMap = (Map) application.getAttribute("catalogMap");
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String url = CommonString.getFormatPara(request.getQueryString()) ;  // 调整url，做分页处理
	if(!"".equals(url)){
		if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
			url="" ;
		}else if(url.indexOf("offset")!=-1 ){
			url = "&"+url.substring(url.indexOf("&")+1) ;
		}else{
			url = "&"+url ;
		}
	}
    String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	StringBuffer whereStr = new StringBuffer(" and is_pub=1 and title like '%维修%' and content is not null");
		PageBean pageBean = new PageBean() ;
	    pageBean.setPageSize(25) ;
	    Integer nowPage = 1 ;
	    if(!"".equals(offset) && !"0".equals(offset)){
	 	    nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	    }
	    pageBean.setNowPage(nowPage) ;
	    pageBean.setParams(url) ;
	    pageBean.setCondition(whereStr.toString()) ;
	    pageBean.setFields("title,add_date,id") ;
	    pageBean.setTableName("article") ;
		pageBean.setOrderBy("view_count desc") ;
	    List<Map> newsList = pageBean.getDatasByWebService("Web21sunDBHelper"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta name="renderer" content="webkit">
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="/weixiu/style/style.css" rel="stylesheet" type="text/css" />
<link href="/weixiu/style/weixiu.css" rel="stylesheet" type="text/css" />
<link href="/style/friendly_link.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/citys_weixiu.js"></script>
<title>【工程机械维修】工程机械维修动态 - 铁臂维修 </title>
<meta name="keywords" content="工程机械维修动态,工程机械维修新闻" />
<meta name="description" content="铁臂维修为您提供工程机械产品维修动态, 工程机械维修新闻,买工程机械产品就上铁臂商城。" />
</head>
<body>
<jsp:include page="/weixiu/top.jsp" flush="true" />
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂维修</a>&nbsp;&gt;&gt;&nbsp;维修动态</h3>
</div>
<!-- conternt-->
<div class="contain980 fix mb10">
  <div class="left01">
    
    <div class="newsList" style="border-bottom:#d8dfe9 1px solid;">
      <div class="hd">
        <h3>维修热点</h3>
      </div>
      <div class="bd">
        <ul class="list">
		<%
		        int i=1;
				if (newsList != null && newsList.size() > 0) {
							for (Map oneMap : newsList) {
		 %>
          <li>
            <h3><a target="_blank" href="/news_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm"><%=CommonString.getFormatPara(oneMap.get("title"))%></a></h3>
            <span class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(oneMap.get("pub_date")))%></span>
          </li>
		  <%if(i%5==0){%><li class="line"></li><%}%>
          <%i++;}}%>
        </ul>
        
        <div class="comPage">
          <div class="page" id="pagination">
                 <tags:page pageBean="<%=pageBean%>" />
          </div>
        </div>
      </div>
    </div> 
  </div>
  <!-- right start-->
<div class="nre_left" style="float:right">
      <div class="rp clearfix mb10 area">
      <div class="title">
        <h3>热门区域维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">	
            <li><a title="北京维修" href="/0-105500-0.htm">北京</a></li>
			<li><a title="上海维修" href="/0-105300-0.htm">上海</a></li>
			<li><a title="天津维修" href="/0-105690-0.htm">天津</a></li>
			<li><a title="重庆维修" href="/0-105880-0.htm">重庆</a></li>
			<li><a title="石家庄维修" href="/0-106410-0.htm">石家庄</a></li>
			<li><a title="太原维修" href="/0-108310-0.htm">太原</a></li>
			<li><a title="呼和浩特维修" href="/0-109710-0.htm">呼和浩特</a></li>
			<li><a title="沈阳维修" href="/0-120010-0.htm">沈阳</a></li>
			<li><a title="长春维修" href="/0-119010-0.htm">长春</a></li>
			<li><a title="哈尔滨维修" href="/0-122010-0.htm">哈尔滨</a></li>
			<li><a title="南京维修" href="/0-110910-0.htm">南京</a></li>
			<li><a title="杭州维修" href="/0-104210-0.htm">杭州</a></li>
			<li><a title="合肥维修" href="/0-102320-0.htm">合肥</a></li>
			<li><a title="福州维修" href="/0-142010-0.htm">福州</a></li>
			<li><a title="南昌维修" href="/0-103110-0.htm">南昌</a></li>
			<li><a title="济南维修" href="/0-101260-0.htm">济南</a></li>
			<li><a title="郑州维修" href="/0-130010-0.htm">郑州</a></li>
			<li><a title="武汉维修" href="/0-124010-0.htm">武汉</a></li>
			<li><a title="长沙维修" href="/0-126010-0.htm">长沙</a></li>
			<li><a title="广州维修" href="/0-128010-0.htm">广州</a></li>
			<li><a title="南宁维修" href="/0-113010-0.htm">南宁</a></li>
			<li><a title="海口维修" href="/0-141510-0.htm">海口</a></li>
			<li><a title="成都维修" href="/0-139010-0.htm">成都</a></li>
			<li><a title="贵阳维修" href="/0-132010-0.htm">贵阳</a></li>
			<li><a title="昆明维修" href="/0-137010-0.htm">昆明</a></li>
			<li><a title="拉萨维修" href="/0-115010-0.htm">拉萨</a></li>
			<li><a title="西安维修" href="/0-135510-0.htm">西安</a></li>
			<li><a title="兰州维修" href="/0-134010-0.htm">兰州</a></li>
			<li><a title="西宁维修" href="/0-133010-0.htm">西宁</a></li>
			<li><a title="银川维修" href="/0-116010-0.htm">银川</a></li>
			<li><a title="乌鲁木齐维修" href="/0-117010-0.htm">乌鲁木齐</a></li>
        </ul>
      </div>
    </div>

    <div class="rp clearfix mb10 cate">
      <div class="title">
        <h3>热门产品维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
            <li><a target="_blank" title="挖掘机维修" href="/101001-0-0.htm">挖掘机维修</a></li>
			<li><a target="_blank" title="摊铺机维修" href="/104001-0-0.htm">摊铺机维修</a></li>
			<li><a target="_blank" title="沥青搅拌站维修" href="/104009-0-0.htm">沥青搅拌站维修</a></li>
			<li><a target="_blank" title="铣刨机维修" href="/104005-0-0.htm">铣刨机维修</a></li>
			<li><a target="_blank" title="平地机维修" href="/101005-0-0.htm">平地机维修</a></li>
			<li><a target="_blank" title="压路机维修" href="/106001-0-0.htm">压路机维修</a></li>
			<li><a target="_blank" title="混凝土泵车维修" href="/103001-0-0.htm">混凝土泵车维修</a></li>
			<li><a target="_blank" title="截桩机/破桩机维修" href="/105028-0-0.htm">截桩机/破桩机维修</a></li>
			<li><a target="_blank" title="推土机维修" href="/101003-0-0.htm">推土机维修</a></li>
			<li><a target="_blank" title="装载机维修" href="/101002-0-0.htm">装载机维修</a></li>
			<li><a target="_blank" title="铲运机维修" href="/101004-0-0.htm">铲运机维修</a></li>
			<li><a target="_blank" title="自卸卡车维修" href="/101008-0-0.htm">自卸卡车维修</a></li>
			<li><a target="_blank" title="牵引车维修" href="/118004-0-0.htm">牵引车维修</a></li>
			<li><a target="_blank" title="正面吊维修" href="/111001-0-0.htm">正面吊维修</a></li>
			<li><a target="_blank" title="塔式起重机维修" href="/102002-0-0.htm">塔式起重机维修</a></li>
			<li><a target="_blank" title="高空作业车维修" href="/102010-0-0.htm">高空作业车维修</a></li>
			<li><a target="_blank" title="施工升降机维修" href="/102011-0-0.htm">施工升降机维修</a></li>
			<li><a target="_blank" title="专用叉车维修" href="/107010-0-0.htm">专用叉车维修</a></li>
			<li><a target="_blank" title="强夯机维修" href="/105017-0-0.htm">强夯机维修</a></li>
			<li><a target="_blank" title="场桥维修" href="/111006-0-0.htm">场桥维修</a></li>
			<li><a target="_blank" title="消防车维修" href="/118003-0-0.htm">消防车维修</a></li>
			<li><a target="_blank" title="液压剪维修" href="/113002-0-0.htm">液压剪维修</a></li>
        </ul>
      </div>
    </div>

    <div class="rp clearfix mb10 area">
      <div class="title">
        <h3>热门品牌维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
            <li><a target="_blank" title="徐工维修" href="/0-0-209.htm">徐工</a></li>
            <li><a target="_blank" title="三一维修" href="/0-0-133.htm">三一</a></li>
            <li><a target="_blank" title="小松维修" href="/0-0-182.htm">小松</a></li>
            <li><a target="_blank" title="柳工维修" href="/0-0-136.htm">柳工</a></li>
            <li><a target="_blank" title="中联重科维修" href="/0-0-134.htm">中联重科</a></li>
            <li><a target="_blank" title="斗山维修" href="/0-0-192.htm">斗山</a></li>
            <li><a target="_blank" title="卡特彼勒维修" href="/0-0-174.htm">卡特彼勒</a></li>
            <li><a target="_blank" title="沃尔沃维修" href="/0-0-175.htm">沃尔沃</a></li>
            <li><a target="_blank" title="福田雷沃维修" href="/0-0-141.htm">福田雷沃</a></li>
            <li><a target="_blank" title="日立维修" href="/0-0-184.htm">日立</a></li>
            <li><a target="_blank" title="龙工维修" href="/0-0-135.htm">龙工</a></li>
            <li><a target="_blank" title="厦工维修" href="/0-0-139.htm">厦工</a></li>
            <li><a target="_blank" title="神钢维修" href="/0-0-183.htm">神钢</a></li>
            <li><a target="_blank" title="利勃海尔维修" href="/0-0-179.htm">利勃海尔</a></li>
            <li><a target="_blank" title="山河智能维修" href="/0-0-142.htm">山河智能</a></li>
            <li><a target="_blank" title="山东临工维修" href="/0-0-137.htm">山东临工</a></li>
            <li><a target="_blank" title="山推维修" href="/0-0-144.htm">山推</a></li>
            <li><a target="_blank" title="加藤维修" href="/0-0-189.htm">加藤</a></li>
            <li><a target="_blank" title="山重建机维修" href="/0-0-152.htm">山重建机</a></li>
            <li><a target="_blank" title="凯斯维修" href="/0-0-455.htm">凯斯</a></li>
            <li><a target="_blank" title="玉柴维修" href="/0-0-146.htm">玉柴</a></li>
            <li><a target="_blank" title="特雷克斯维修" href="/0-0-176.htm">特雷克斯</a></li>
            <li><a target="_blank" title="卡特重工维修" href="/0-0-178.htm">卡特重工</a></li>
            <li><a target="_blank" title="现代维修" href="/0-0-194.htm">现代</a></li>
            <li><a target="_blank" title="住友维修" href="/0-0-185.htm">住友</a></li>
            <li><a target="_blank" title="一拖维修" href="/0-0-159.htm">一拖</a></li>
            <li><a target="_blank" title="JCB维修" href="/0-0-177.htm">JCB</a></li>
            <li><a target="_blank" title="久保田维修" href="/0-0-187.htm">久保田</a></li>
            <li><a target="_blank" title="徐挖维修" href="/0-0-150.htm">徐挖</a></li>
            <li><a target="_blank" title="沃得重工维修" href="/0-0-149.htm">沃得重工</a></li>
        </ul>
      </div>
    </div>
  </div>
<!-- right end-->
</div>
<!-- conternt end-->
<jsp:include page="/include/index/friendlink_weixiu.htm" flush="true"/>
<jsp:include page="/include/foot.jsp" flush="true"/>
</body>
</html>
