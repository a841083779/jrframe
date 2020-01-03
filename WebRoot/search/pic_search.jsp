<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="java.net.URLEncoder,java.sql.Connection"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<% 
    DBHelper dbHelper = DBHelper.getInstance() ;
	String keywordCheck = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String pageKeyword = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String picType = CommonString.getFormatPara(request.getParameter("picType")) ;
    Connection connection = null;
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	int nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));
	Map brandMap = (Map)application.getAttribute("brandMap") ;
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
    if(keywordCheck.equals("0")){keywordCheck="";}
	if(catalog.equals("")){catalog="0";}
	if(factory.equals("")){factory="0";}
	if(pageKeyword.equals("")){pageKeyword="0";}
	int totalParts = 0;
	String tempCatalog="";
	String tempFactory="";
	String whereStr="";
	//搜索新	
	String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_pic";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	/*接收参数*/
	SolrQuery query = new SolrQuery();
	List<SolrQuery.SortClause> orderList = new ArrayList<SolrQuery.SortClause>();
	orderList.add(SolrQuery.SortClause.desc("id"));
	nowPage = nowPage <= 0 ? 1 : nowPage;
	List<String> whereList = new ArrayList<String>();
	if(!catalog.equals("0")&&!catalog.equals("")&&catalog.length()>3){
	   tempCatalog=(CommonString.getFormatPara(catalogMap.get(catalog)));
	}
	if(!factory.equals("0")&&!factory.equals("")){
	    tempFactory=(CommonString.getFormatPara(brandMap.get(factory)));
	}
	List<String> filterQuery = new ArrayList<String>(0);
	if((keywordCheck+tempFactory+tempCatalog).equals("")){
	    query.setQuery("*:*");
	}else if(!pageKeyword.equals("产品图片")&&!pageKeyword.equals("行业图片")&&!pageKeyword.equals("施工图片")&&!pageKeyword.equals("维修图片")&&!pageKeyword.equals("展会图片")&&!pageKeyword.equals("趣味图片"))
	{
	   	//filterQuery.add("title:" + keywordCheck+tempFactory+tempCatalog);
	    query.setQuery(keywordCheck+tempFactory+tempCatalog);

	}
	if(picType.equals("0")){
		filterQuery.add("infoType:0")	;
	}else{
	   	filterQuery.add("sort_num:"+picType)	;
	}
    /*查询*/	
   	String [] filterArr = new String [filterQuery.size()];
	filterArr = filterQuery.toArray(filterArr);
	query.addFilterQuery(filterArr);
	int pageSize = 16;
	query.setRequestHandler("/jereh");
	//query.setSorts(orderList);
	query.setRows(pageSize);
	query.setStart((nowPage - 1) * pageSize);
	/* 高亮 */
	query.setHighlight(true);
	query.setHighlightSimplePre("<span style='color:red;'>");
	query.setHighlightSimplePost("</span>");
	query.setParam("hl.fl", "title");
	QueryResponse res = server.query(query);
	totalParts = (int)res.getResults().getNumFound();
	int pageCount = totalParts / pageSize + (totalParts % pageSize > 0 ? 1 : 0);
	SolrDocumentList products = res.getResults();
	String TDK_title="";String TDK_keywords="";String TDK_desc="";
	if(totalParts>0){
	TDK_title=keywordCheck+" - 图库搜索 - 铁臂图库";
	TDK_keywords=keywordCheck+",铁臂图库";
	TDK_desc="在铁臂图库中找到了"+totalParts+"张"+keywordCheck+"相关高清图片，其中包含了"+keywordCheck+"产品图片，"+keywordCheck+"施工图片，"+keywordCheck+"维修图片，"+keywordCheck+"展会图片，"+keywordCheck+"行业图片，"+keywordCheck+"趣味图片等信息，买"+keywordCheck+"就上铁臂商城。";
	}else{
	TDK_title=keywordCheck+" - 图库搜索 - 铁臂图库";
	TDK_keywords=keywordCheck+",铁臂图库";
	TDK_desc="在铁臂图库中找到了0张"+keywordCheck+"相关高清图片，请重新选择，买工程机械就上铁臂商城。";
	}
	try{
		connection = dbHelper.getConnection();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=TDK_title%></title>
<meta name="keywords" content="<%=TDK_keywords%>" />
<meta name="description" content="<%=TDK_desc%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="/style/friendly_link.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top_photo_news_search.jsp" flush="true"/>
<!--top end--> 
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">搜索结果</a> &gt;&gt; <%=keywordCheck%> </h3>
</div>
<!--面包屑结束--> 
<%if(totalParts>0){%>
<!--main-->
<div class="contain980 fix">
	<div class="w210 l">
    	<div class="nph_val mb10">
          <ul class="nph_list">
            <li> <a href="/<%=keywordCheck%>_0_0_0_0.htm">产品图片</a></li>
            <li> <a href="/<%=keywordCheck%>_107001_0_0_0.htm">行业图片</a></li>
            <li> <a href="/<%=keywordCheck%>_107003_0_0_0.htm">施工图片</a></li>
            <li> <a href="/<%=keywordCheck%>_107004_0_0_0.htm">维修图片</a></li>
            <li> <a href="/<%=keywordCheck%>_107005_0_0_0.htm">展会图片</a></li>
			<li> <a href="/<%=keywordCheck%>_107006_0_0_0.htm">趣味图片</a></li>

          </ul>
        </div>
        <div class="share_kbimg">
        	<a href="http://product.21-sun.com/activity/koubei2/" target="_blank"><img src="../images/new_pro/share_kbimg.jpg" width="210" height="470"/></a>
        </div>
    </div>
    <div class="w757 r">
    <%  
	    if(!keywordCheck.equals("")&&1==2){
    	UIRelated uiRelated = new UIRelated();
    	out.print(uiRelated.related(request));
		}
     %>        
	<form name="theform" id="theform">
      <div class="w755 border03 l Condition mb10">
        <div class="ConditionTop">
        	<h1 class="r" style="font-size:14px;">铁臂图片</h1>
        </div>
        <ul class="ConditionBottom">
          <script type="text/javascript">
	  jQuery(document).ready(function() {
		  jQuery(".pbtn").click(function(){
			  jQuery(this).next("div").slideToggle(0)
			  .siblings(".plmore:visible").slideUp(0);
			  jQuery(this).toggleClass("pbon");
			  jQuery(this).siblings(".pbon").removeClass("pbon");
		  });	
	  });
	  </script>
<li class="cblist">
  <dt> 品牌 </dt>
  <dd><a href="/<%=keywordCheck%>_0_0_0_0.htm" <%if(factory.equals("0")){%> class="select"<%}%> >不限</a>
  <a  href="/<%=keywordCheck%>_0_174_0_0.htm" <%if(factory.equals("174")){%> class="select"<%}%> >卡特彼勒</a> 
  <a href="/<%=keywordCheck%>_0_137_0_0.htm" <%if(factory.equals("137")){%> class="select"<%}%> >临工</a>
  <a  href="/<%=keywordCheck%>_0_136_0_0.htm" <%if(factory.equals("136")){%> class="select"<%}%> >柳工</a>
  <a  href="/<%=keywordCheck%>_0_138_0_0.htm" <%if(factory.equals("138")){%> class="select"<%}%> >山工</a> 
  <a  href="/<%=keywordCheck%>_0_135_0_0.htm" <%if(factory.equals("135")){%> class="select"<%}%> >龙工</a>
  <a  href="/<%=keywordCheck%>_0_209_0_0.htm" <%if(factory.equals("209")){%> class="select"<%}%> >徐工</a>
  <a  href="/<%=keywordCheck%>_0_144_0_0.htm" <%if(factory.equals("144")){%> class="select"<%}%> >山推</a> 
  <a  href="/<%=keywordCheck%>_0_133_0_0.htm" <%if(factory.equals("133")){%> class="select"<%}%> >三一</a>
  <a  href="/<%=keywordCheck%>_0_192_0_0.htm" <%if(factory.equals("192")){%> class="select"<%}%> >斗山</a>
  <a  href="/<%=keywordCheck%>_0_182_0_0.htm" <%if(factory.equals("182")){%> class="select"<%}%> >小松</a> 
  <a  href="/<%=keywordCheck%>_0_175_0_0.htm" <%if(factory.equals("175")){%> class="select"<%}%> >沃尔沃</a>
  <a  href="/<%=keywordCheck%>_0_157_0_0.htm" <%if(factory.equals("157")){%> class="select"<%}%> >力士德</a>
    <div id="changethis" class="pbtn"></div>
    <div class="plmore">
      <div class="pllist"><a class="plfl"><span style="color:#3355AC"> A-B-C-D-E-F-G </span></a><br/>
        <a href="/<%=keywordCheck%>_0_1185_0_0.htm" target="_top">阿尔多</a> <a href="/<%=keywordCheck%>_0_1185_0_0.htm" target="_top">阿尔多机械</a> <a href="/<%=keywordCheck%>_0_180_0_0.htm" target="_top">阿特拉斯</a> <a href="/<%=keywordCheck%>_0_482_0_0.htm" target="_top">阿特拉斯·科普柯</a> <a href="/<%=keywordCheck%>_0_402_0_0.htm" target="_top">艾迪</a> <a href="/<%=keywordCheck%>_0_772_0_0.htm" target="_top">艾思博</a> <a href="/<%=keywordCheck%>_0_14236_0_0.htm" target="_top">安鼎重工</a> <a href="/<%=keywordCheck%>_0_1710_0_0.htm" target="_top">安迈</a> <a href="/<%=keywordCheck%>_0_1169_0_0.htm" target="_top">安丘通用机械</a> <a href="/<%=keywordCheck%>_0_13271_0_0.htm" target="_top">奥津</a> <a href="/<%=keywordCheck%>_0_1778_0_0.htm" target="_top">奥盛特重工</a> <a href="/<%=keywordCheck%>_0_13272_0_0.htm" target="_top">奥泰</a> <a href="/<%=keywordCheck%>_0_484_0_0.htm" target="_top">八达</a> <a href="/<%=keywordCheck%>_0_791_0_0.htm" target="_top">八达重工</a> <a href="/<%=keywordCheck%>_0_13557_0_0.htm" target="_top">巴里巴</a> <a href="/<%=keywordCheck%>_0_1108_0_0.htm" target="_top">百财东洋</a> <a href="/<%=keywordCheck%>_0_13562_0_0.htm" target="_top">百巨建机</a> <a href="/<%=keywordCheck%>_0_13560_0_0.htm" target="_top">百开</a> <a href="/<%=keywordCheck%>_0_13565_0_0.htm" target="_top">百力克</a> <a href="/<%=keywordCheck%>_0_1168_0_0.htm" target="_top">百脉建机</a> <a href="/<%=keywordCheck%>_0_478_0_0.htm" target="_top">邦立重机</a> <a href="/<%=keywordCheck%>_0_13569_0_0.htm" target="_top">宝达</a> <a href="/<%=keywordCheck%>_0_13570_0_0.htm" target="_top">宝鼎</a> <a href="/<%=keywordCheck%>_0_1715_0_0.htm" target="_top">宝骊</a> <a href="/<%=keywordCheck%>_0_13550_0_0.htm" target="_top">宝马格</a> <a href="/<%=keywordCheck%>_0_13558_0_0.htm" target="_top">宝象</a> <a href="/<%=keywordCheck%>_0_13567_0_0.htm" target="_top">暴风雪</a> <a href="/<%=keywordCheck%>_0_1093_0_0.htm" target="_top">北车重工</a> <a href="/<%=keywordCheck%>_0_14144_0_0.htm" target="_top">北方红阳</a> <a href="/<%=keywordCheck%>_0_167_0_0.htm" target="_top">北方交通</a> <a href="/<%=keywordCheck%>_0_13551_0_0.htm" target="_top">北京加隆</a> <a href="/<%=keywordCheck%>_0_186_0_0.htm" target="_top">北起多田野</a> <a href="/<%=keywordCheck%>_0_1714_0_0.htm" target="_top">北山机械</a> <a href="/<%=keywordCheck%>_0_420_0_0.htm" target="_top">贝力特</a> <a href="/<%=keywordCheck%>_0_13556_0_0.htm" target="_top">贝司特</a> <a href="/<%=keywordCheck%>_0_13568_0_0.htm" target="_top">泵虎</a> <a href="/<%=keywordCheck%>_0_13553_0_0.htm" target="_top">边宁荷夫</a> <a href="/<%=keywordCheck%>_0_13566_0_0.htm" target="_top">滨州钻机</a> <a href="/<%=keywordCheck%>_0_13552_0_0.htm" target="_top">波坦</a> <a href="/<%=keywordCheck%>_0_13571_0_0.htm" target="_top">波特重工</a> <a href="/<%=keywordCheck%>_0_13559_0_0.htm" target="_top">博德</a> <a href="/<%=keywordCheck%>_0_1206_0_0.htm" target="_top">博汇机械</a> <a href="/<%=keywordCheck%>_0_13555_0_0.htm" target="_top">博纳地</a> <a href="/<%=keywordCheck%>_0_13624_0_0.htm" target="_top">博洋</a> <a href="/<%=keywordCheck%>_0_683_0_0.htm" target="_top">德国宝峨</a> <a href="/<%=keywordCheck%>_0_1703_0_0.htm" target="_top">甘肃宝龙</a> <a href="/<%=keywordCheck%>_0_825_0_0.htm" target="_top">湖南搏浪沙</a> <a href="/<%=keywordCheck%>_0_13231_0_0.htm" target="_top">天地奔牛</a> <a href="/<%=keywordCheck%>_0_1108_0_0.htm" target="_top">烟台百财</a> <a href="/<%=keywordCheck%>_0_1108_0_0.htm" target="_top">翼龙</a> <a href="/<%=keywordCheck%>_0_13093_0_0.htm" target="_top">重庆博山</a> <a href="/<%=keywordCheck%>_0_13572_0_0.htm" target="_top">沧田重工</a> <a href="/<%=keywordCheck%>_0_13575_0_0.htm" target="_top">昌世</a> <a href="/<%=keywordCheck%>_0_13578_0_0.htm" target="_top">长春神骏</a> <a href="/<%=keywordCheck%>_0_13142_0_0.htm" target="_top">长高一品</a> <a href="/<%=keywordCheck%>_0_13579_0_0.htm" target="_top">长盛机械</a> <a href="/<%=keywordCheck%>_0_615_0_0.htm" target="_top">长阳机械</a> <a href="/<%=keywordCheck%>_0_148_0_0.htm" target="_top">常林股份</a> <a href="/<%=keywordCheck%>_0_485_0_0.htm" target="_top">朝工</a> <a href="/<%=keywordCheck%>_0_13576_0_0.htm" target="_top">朝阳建工</a> <a href="/<%=keywordCheck%>_0_13574_0_0.htm" target="_top">郴筑</a> <a href="/<%=keywordCheck%>_0_145_0_0.htm" target="_top">成工</a> <a href="/<%=keywordCheck%>_0_1591_0_0.htm" target="_top">楚工龙泰</a> <a href="/<%=keywordCheck%>_0_13573_0_0.htm" target="_top">创一</a> <a href="/<%=keywordCheck%>_0_13094_0_0.htm" target="_top">桂林长海</a> <a href="/<%=keywordCheck%>_0_615_0_0.htm" target="_top">杭州永林</a> <a href="/<%=keywordCheck%>_0_13174_0_0.htm" target="_top">湖南长河</a> <a href="/<%=keywordCheck%>_0_147_0_0.htm" target="_top">四川长起</a> <a href="/<%=keywordCheck%>_0_1716_0_0.htm" target="_top">达刚</a> <a href="/<%=keywordCheck%>_0_13587_0_0.htm" target="_top">达力</a> <a href="/<%=keywordCheck%>_0_13580_0_0.htm" target="_top">达宇重工</a> <a href="/<%=keywordCheck%>_0_162_0_0.htm" target="_top">大地</a> <a href="/<%=keywordCheck%>_0_13584_0_0.htm" target="_top">大方</a> <a href="/<%=keywordCheck%>_0_13592_0_0.htm" target="_top">大宏立</a> <a href="/<%=keywordCheck%>_0_13586_0_0.htm" target="_top">大连</a> <a href="/<%=keywordCheck%>_0_13589_0_0.htm" target="_top">大山路桥</a> <a href="/<%=keywordCheck%>_0_171_0_0.htm" target="_top">大信重工</a> <a href="/<%=keywordCheck%>_0_212_0_0.htm" target="_top">戴纳派克</a> <a href="/<%=keywordCheck%>_0_1243_0_0.htm" target="_top">道辰格</a> <a href="/<%=keywordCheck%>_0_1218_0_0.htm" target="_top">道胜</a> <a href="/<%=keywordCheck%>_0_13588_0_0.htm" target="_top">道维施</a> <a href="/<%=keywordCheck%>_0_151_0_0.htm" target="_top">德工</a> <a href="/<%=keywordCheck%>_0_489_0_0.htm" target="_top">德基机械</a> <a href="/<%=keywordCheck%>_0_13597_0_0.htm" target="_top">德科达</a> <a href="/<%=keywordCheck%>_0_213_0_0.htm" target="_top">德玛格</a> <a href="/<%=keywordCheck%>_0_13598_0_0.htm" target="_top">德通</a> <a href="/<%=keywordCheck%>_0_13595_0_0.htm" target="_top">德亿重工</a> <a href="/<%=keywordCheck%>_0_140_0_0.htm" target="_top">鼎盛重工</a> <a href="/<%=keywordCheck%>_0_14222_0_0.htm" target="_top">东倡机械</a> <a href="/<%=keywordCheck%>_0_1351_0_0.htm" target="_top">东达</a> <a href="/<%=keywordCheck%>_0_1351_0_0.htm" target="_top">东达桩工</a> <a href="/<%=keywordCheck%>_0_1763_0_0.htm" target="_top">东德重工</a> <a href="/<%=keywordCheck%>_0_1187_0_0.htm" target="_top">东方红</a> <a href="/<%=keywordCheck%>_0_13591_0_0.htm" target="_top">东方冶矿</a> <a href="/<%=keywordCheck%>_0_1755_0_0.htm" target="_top">东风</a> <a href="/<%=keywordCheck%>_0_405_0_0.htm" target="_top">东空</a> <a href="/<%=keywordCheck%>_0_14169_0_0.htm" target="_top">东立机械</a> <a href="/<%=keywordCheck%>_0_13583_0_0.htm" target="_top">东泷</a> <a href="/<%=keywordCheck%>_0_13590_0_0.htm" target="_top">东蒙机械</a> <a href="/<%=keywordCheck%>_0_1717_0_0.htm" target="_top">东南机械</a> <a href="/<%=keywordCheck%>_0_163_0_0.htm" target="_top">东岳重工</a> <a href="/<%=keywordCheck%>_0_1098_0_0.htm" target="_top">斗昌</a> <a href="/<%=keywordCheck%>_0_192_0_0.htm" target="_top">斗山</a> <a href="/<%=keywordCheck%>_0_1122_0_0.htm" target="_top">山东大汉</a> <a href="/<%=keywordCheck%>_0_1195_0_0.htm" target="_top">重庆大江</a> <a href="/<%=keywordCheck%>_0_671_0_0.htm" target="_top">方圆集团</a> <a href="/<%=keywordCheck%>_0_1120_0_0.htm" target="_top">丰汇技术</a> <a href="/<%=keywordCheck%>_0_1729_0_0.htm" target="_top">丰田</a> <a href="/<%=keywordCheck%>_0_1188_0_0.htm" target="_top">福大机械</a> <a href="/<%=keywordCheck%>_0_215_0_0.htm" target="_top">福格勒</a> <a href="/<%=keywordCheck%>_0_1183_0_0.htm" target="_top">福工</a> <a href="/<%=keywordCheck%>_0_141_0_0.htm" target="_top">福田雷沃</a> <a href="/<%=keywordCheck%>_0_141_0_0.htm" target="_top">福田雷沃重工</a> <a href="/<%=keywordCheck%>_0_1208_0_0.htm" target="_top">福威重工</a> <a href="/<%=keywordCheck%>_0_165_0_0.htm" target="_top">抚顺起重机</a> <a href="/<%=keywordCheck%>_0_164_0_0.htm" target="_top">抚挖</a> <a href="/<%=keywordCheck%>_0_1225_0_0.htm" target="_top">抚挖锦重</a> <a href="/<%=keywordCheck%>_0_1721_0_0.htm" target="_top">富豪</a> <a href="/<%=keywordCheck%>_0_1888_0_0.htm" target="_top">富亿机械</a> <a href="/<%=keywordCheck%>_0_1124_0_0.htm" target="_top">富友正和</a> <a href="/<%=keywordCheck%>_0_13630_0_0.htm" target="_top">湖南飞涛</a> <a href="/<%=keywordCheck%>_0_682_0_0.htm" target="_top">山东福临</a> <a href="/<%=keywordCheck%>_0_14252_0_0.htm" target="_top">冈研</a> <a href="/<%=keywordCheck%>_0_13604_0_0.htm" target="_top">高达</a> <a href="/<%=keywordCheck%>_0_492_0_0.htm" target="_top">高马科</a> <a href="/<%=keywordCheck%>_0_534_0_0.htm" target="_top">高远路业</a> <a href="/<%=keywordCheck%>_0_1754_0_0.htm" target="_top">高远圣工</a> <a href="/<%=keywordCheck%>_0_13606_0_0.htm" target="_top">格鲁夫</a> <a href="/<%=keywordCheck%>_0_477_0_0.htm" target="_top">格瑞德</a> <a href="/<%=keywordCheck%>_0_13603_0_0.htm" target="_top">格瑞特</a> <a href="/<%=keywordCheck%>_0_423_0_0.htm" target="_top">工兵</a> <a href="/<%=keywordCheck%>_0_776_0_0.htm" target="_top">工兵国际</a> <a href="/<%=keywordCheck%>_0_417_0_0.htm" target="_top">古河</a> <a href="/<%=keywordCheck%>_0_13605_0_0.htm" target="_top">谷登机械</a> <a href="/<%=keywordCheck%>_0_424_0_0.htm" target="_top">广林</a> <a href="/<%=keywordCheck%>_0_1116_0_0.htm" target="_top">广西建机</a> <a href="/<%=keywordCheck%>_0_13608_0_0.htm" target="_top">国发</a> <a href="/<%=keywordCheck%>_0_1369_0_0.htm" target="_top">国机重工</a> <a href="/<%=keywordCheck%>_0_776_0_0.htm" target="_top">连云港工兵</a> <a href="/<%=keywordCheck%>_0_776_0_0.htm" target="_top">连云港工兵GBPSC</a> </div>
      <div class="pllist"> <a class="plfl"><span style="color:#3355AC"> H-I-J-K-L-M-N </span></a> <br/>
        <a href="/<%=keywordCheck%>_0_1109_0_0.htm" target="_top">海斗</a> <a href="/<%=keywordCheck%>_0_13611_0_0.htm" target="_top">海华筑机</a> <a href="/<%=keywordCheck%>_0_203_0_0.htm" target="_top">海诺</a> <a href="/<%=keywordCheck%>_0_1091_0_0.htm" target="_top">海山</a> <a href="/<%=keywordCheck%>_0_1733_0_0.htm" target="_top">海斯特</a> <a href="/<%=keywordCheck%>_0_1105_0_0.htm" target="_top">海特</a> <a href="/<%=keywordCheck%>_0_13620_0_0.htm" target="_top">海天路矿</a> <a href="/<%=keywordCheck%>_0_1128_0_0.htm" target="_top">海威斯帝尔</a> <a href="/<%=keywordCheck%>_0_664_0_0.htm" target="_top">海州机械</a> <a href="/<%=keywordCheck%>_0_415_0_0.htm" target="_top">韩川</a> <a href="/<%=keywordCheck%>_0_1112_0_0.htm" target="_top">韩工</a> <a href="/<%=keywordCheck%>_0_14253_0_0.htm" target="_top">韩农</a> <a href="/<%=keywordCheck%>_0_421_0_0.htm" target="_top">韩宇</a> <a href="/<%=keywordCheck%>_0_216_0_0.htm" target="_top">悍马</a> <a href="/<%=keywordCheck%>_0_426_0_0.htm" target="_top">悍狮</a> <a href="/<%=keywordCheck%>_0_814_0_0.htm" target="_top">捍宇</a> <a href="/<%=keywordCheck%>_0_1734_0_0.htm" target="_top">杭叉</a> <a href="/<%=keywordCheck%>_0_13628_0_0.htm" target="_top">杭重威施诺</a> <a href="/<%=keywordCheck%>_0_1724_0_0.htm" target="_top">杭州市政</a> <a href="/<%=keywordCheck%>_0_1525_0_0.htm" target="_top">合矿</a> <a href="/<%=keywordCheck%>_0_158_0_0.htm" target="_top">合力</a> <a href="/<%=keywordCheck%>_0_13632_0_0.htm" target="_top">和盛达</a> <a href="/<%=keywordCheck%>_0_1103_0_0.htm" target="_top">黑金钢</a> <a href="/<%=keywordCheck%>_0_13623_0_0.htm" target="_top">恒端</a> <a href="/<%=keywordCheck%>_0_13641_0_0.htm" target="_top">恒康</a> <a href="/<%=keywordCheck%>_0_1761_0_0.htm" target="_top">恒诺机械</a> <a href="/<%=keywordCheck%>_0_1508_0_0.htm" target="_top">恒日重工</a> <a href="/<%=keywordCheck%>_0_1735_0_0.htm" target="_top">恒润高科</a> <a href="/<%=keywordCheck%>_0_13614_0_0.htm" target="_top">恒升</a> <a href="/<%=keywordCheck%>_0_170_0_0.htm" target="_top">恒特</a> <a href="/<%=keywordCheck%>_0_1147_0_0.htm" target="_top">恒天九五</a> <a href="/<%=keywordCheck%>_0_13636_0_0.htm" target="_top">恒兴机械</a> <a href="/<%=keywordCheck%>_0_13096_0_0.htm" target="_top">恒至凿岩</a> <a href="/<%=keywordCheck%>_0_13613_0_0.htm" target="_top">红旗</a> <a href="/<%=keywordCheck%>_0_13639_0_0.htm" target="_top">宏昌</a> <a href="/<%=keywordCheck%>_0_13633_0_0.htm" target="_top">宏达</a> <a href="/<%=keywordCheck%>_0_13609_0_0.htm" target="_top">宏大</a> <a href="/<%=keywordCheck%>_0_13629_0_0.htm" target="_top">宏建机械</a> <a href="/<%=keywordCheck%>_0_13618_0_0.htm" target="_top">宏力</a> <a href="/<%=keywordCheck%>_0_217_0_0.htm" target="_top">鸿达</a> <a href="/<%=keywordCheck%>_0_202_0_0.htm" target="_top">鸿得利重工</a> <a href="/<%=keywordCheck%>_0_13626_0_0.htm" target="_top">鸿源</a> <a href="/<%=keywordCheck%>_0_819_0_0.htm" target="_top">虎霸集团</a> <a href="/<%=keywordCheck%>_0_13617_0_0.htm" target="_top">虎力</a> <a href="/<%=keywordCheck%>_0_13577_0_0.htm" target="_top">华贝尔</a> <a href="/<%=keywordCheck%>_0_13627_0_0.htm" target="_top">华丰</a> <a href="/<%=keywordCheck%>_0_13634_0_0.htm" target="_top">华光机械</a> <a href="/<%=keywordCheck%>_0_206_0_0.htm" target="_top">华力重工</a> <a href="/<%=keywordCheck%>_0_13640_0_0.htm" target="_top">华南重工</a> <a href="/<%=keywordCheck%>_0_1725_0_0.htm" target="_top">华骐</a> <a href="/<%=keywordCheck%>_0_1727_0_0.htm" target="_top">华强京工</a> <a href="/<%=keywordCheck%>_0_1731_0_0.htm" target="_top">华山</a> <a href="/<%=keywordCheck%>_0_1220_0_0.htm" target="_top">华通道胜</a> <a href="/<%=keywordCheck%>_0_1526_0_0.htm" target="_top">华伟重工</a> <a href="/<%=keywordCheck%>_0_1512_0_0.htm" target="_top">华中建机</a> <a href="/<%=keywordCheck%>_0_13625_0_0.htm" target="_top">华重</a> <a href="/<%=keywordCheck%>_0_13622_0_0.htm" target="_top">惠工</a> <a href="/<%=keywordCheck%>_0_14283_0_0.htm" target="_top">惠龙机械</a> <a href="/<%=keywordCheck%>_0_13616_0_0.htm" target="_top">惠山</a> <a href="/<%=keywordCheck%>_0_203_0_0.htm" target="_top">辽宁海诺</a> <a href="/<%=keywordCheck%>_0_845_0_0.htm" target="_top">宁波韩锐</a> <a href="/<%=keywordCheck%>_0_217_0_0.htm" target="_top">山东鸿达</a> <a href="/<%=keywordCheck%>_0_1176_0_0.htm" target="_top">威海海泰</a> <a href="/<%=keywordCheck%>_0_14111_0_0.htm" target="_top">无锡环球</a> <a href="/<%=keywordCheck%>_0_893_0_0.htm" target="_top">烟台海德</a> <a href="/<%=keywordCheck%>_0_1091_0_0.htm" target="_top">烟台海山</a> <a href="/<%=keywordCheck%>_0_177_0_0.htm" target="_top">JCB</a> <a href="/<%=keywordCheck%>_0_1127_0_0.htm" target="_top">甘肃建工</a> <a href="/<%=keywordCheck%>_0_1159_0_0.htm" target="_top">广州京龙</a> <a href="/<%=keywordCheck%>_0_554_0_0.htm" target="_top">吉公</a> <a href="/<%=keywordCheck%>_0_1524_0_0.htm" target="_top">吉尼</a> <a href="/<%=keywordCheck%>_0_1229_0_0.htm" target="_top">吉星</a> <a href="/<%=keywordCheck%>_0_1157_0_0.htm" target="_top">济南吉宏</a> <a href="/<%=keywordCheck%>_0_1179_0_0.htm" target="_top">济南建机</a> <a href="/<%=keywordCheck%>_0_13655_0_0.htm" target="_top">冀中能源</a> <a href="/<%=keywordCheck%>_0_189_0_0.htm" target="_top">加藤</a> <a href="/<%=keywordCheck%>_0_13645_0_0.htm" target="_top">佳乐</a> <a href="/<%=keywordCheck%>_0_13654_0_0.htm" target="_top">佳一</a> <a href="/<%=keywordCheck%>_0_1145_0_0.htm" target="_top">佳弋建机</a> <a href="/<%=keywordCheck%>_0_13656_0_0.htm" target="_top">嘉成</a> <a href="/<%=keywordCheck%>_0_13176_0_0.htm" target="_top">嘉和重工</a> <a href="/<%=keywordCheck%>_0_407_0_0.htm" target="_top">甲南</a> <a href="/<%=keywordCheck%>_0_1352_0_0.htm" target="_top">建德机械</a> <a href="/<%=keywordCheck%>_0_13659_0_0.htm" target="_top">建丰机械</a> <a href="/<%=keywordCheck%>_0_1736_0_0.htm" target="_top">建研机械</a> <a href="/<%=keywordCheck%>_0_1357_0_0.htm" target="_top">建友机械</a> <a href="/<%=keywordCheck%>_0_479_0_0.htm" target="_top">江淮重工</a> <a href="/<%=keywordCheck%>_0_13643_0_0.htm" target="_top">江加</a> <a href="/<%=keywordCheck%>_0_487_0_0.htm" target="_top">江麓</a> <a href="/<%=keywordCheck%>_0_816_0_0.htm" target="_top">江苏骏马</a> <a href="/<%=keywordCheck%>_0_13647_0_0.htm" target="_top">江苏路通</a> <a href="/<%=keywordCheck%>_0_1355_0_0.htm" target="_top">矫马</a> <a href="/<%=keywordCheck%>_0_13657_0_0.htm" target="_top">金城</a> <a href="/<%=keywordCheck%>_0_13651_0_0.htm" target="_top">金茂</a> <a href="/<%=keywordCheck%>_0_13653_0_0.htm" target="_top">金源</a> <a href="/<%=keywordCheck%>_0_1737_0_0.htm" target="_top">金正神力</a> <a href="/<%=keywordCheck%>_0_1132_0_0.htm" target="_top">锦城建机</a> <a href="/<%=keywordCheck%>_0_1586_0_0.htm" target="_top">劲工</a> <a href="/<%=keywordCheck%>_0_172_0_0.htm" target="_top">晋工</a> <a href="/<%=keywordCheck%>_0_1759_0_0.htm" target="_top">京城长野</a> <a href="/<%=keywordCheck%>_0_166_0_0.htm" target="_top">京城重工</a> <a href="/<%=keywordCheck%>_0_401_0_0.htm" target="_top">惊天液压</a> <a href="/<%=keywordCheck%>_0_13649_0_0.htm" target="_top">精功</a> <a href="/<%=keywordCheck%>_0_13650_0_0.htm" target="_top">靖江（JJCC）</a> <a href="/<%=keywordCheck%>_0_187_0_0.htm" target="_top">久保田</a> <a href="/<%=keywordCheck%>_0_1232_0_0.htm" target="_top">久工</a> <a href="/<%=keywordCheck%>_0_13652_0_0.htm" target="_top">久润</a> <a href="/<%=keywordCheck%>_0_197_0_0.htm" target="_top">酒井</a> <a href="/<%=keywordCheck%>_0_1193_0_0.htm" target="_top">巨超重工</a> <a href="/<%=keywordCheck%>_0_13648_0_0.htm" target="_top">聚龙</a> <a href="/<%=keywordCheck%>_0_679_0_0.htm" target="_top">军恒斯帕克</a> <a href="/<%=keywordCheck%>_0_1142_0_0.htm" target="_top">娄底南方</a> <a href="/<%=keywordCheck%>_0_1094_0_0.htm" target="_top">上海工程机械厂</a> <a href="/<%=keywordCheck%>_0_1130_0_0.htm" target="_top">无锡巨神</a> <a href="/<%=keywordCheck%>_0_681_0_0.htm" target="_top">浙江军联</a> <a href="/<%=keywordCheck%>_0_1135_0_0.htm" target="_top">包头凯捷</a> <a href="/<%=keywordCheck%>_0_160_0_0.htm" target="_top">广西开元</a> <a href="/<%=keywordCheck%>_0_13667_0_0.htm" target="_top">卡萨阁蓝地</a> <a href="/<%=keywordCheck%>_0_174_0_0.htm" target="_top">卡特彼勒</a> <a href="/<%=keywordCheck%>_0_178_0_0.htm" target="_top">卡特重工</a> <a href="/<%=keywordCheck%>_0_14247_0_0.htm" target="_top">开普动力</a> <a href="/<%=keywordCheck%>_0_1322_0_0.htm" target="_top">凯雷</a> <a href="/<%=keywordCheck%>_0_13661_0_0.htm" target="_top">凯联</a> <a href="/<%=keywordCheck%>_0_480_0_0.htm" target="_top">凯莫尔</a> <a href="/<%=keywordCheck%>_0_455_0_0.htm" target="_top">凯斯</a> <a href="/<%=keywordCheck%>_0_1756_0_0.htm" target="_top">凯威</a> <a href="/<%=keywordCheck%>_0_13682_0_0.htm" target="_top">凯兴</a> <a href="/<%=keywordCheck%>_0_1118_0_0.htm" target="_top">科曼萨 杰牌</a> <a href="/<%=keywordCheck%>_0_13664_0_0.htm" target="_top">科尼乐重工</a> <a href="/<%=keywordCheck%>_0_13663_0_0.htm" target="_top">科泰重工</a> <a href="/<%=keywordCheck%>_0_14243_0_0.htm" target="_top">科友机械</a> <a href="/<%=keywordCheck%>_0_13666_0_0.htm" target="_top">科筑</a> <a href="/<%=keywordCheck%>_0_1779_0_0.htm" target="_top">克拉士</a> <a href="/<%=keywordCheck%>_0_13665_0_0.htm" target="_top">克瑞</a> <a href="/<%=keywordCheck%>_0_14265_0_0.htm" target="_top">孔山重工</a> <a href="/<%=keywordCheck%>_0_13668_0_0.htm" target="_top">坤宇重装</a> <a href="/<%=keywordCheck%>_0_1144_0_0.htm" target="_top">昆明力神</a> <a href="/<%=keywordCheck%>_0_13705_0_0.htm" target="_top">青岛科尼乐</a> <a href="/<%=keywordCheck%>_0_824_0_0.htm" target="_top">6409塔吊</a> <a href="/<%=keywordCheck%>_0_13631_0_0.htm" target="_top">河南路畅</a> <a href="/<%=keywordCheck%>_0_13097_0_0.htm" target="_top">莱工</a> <a href="/<%=keywordCheck%>_0_1194_0_0.htm" target="_top">蓝翔重工</a> <a href="/<%=keywordCheck%>_0_543_0_0.htm" target="_top">雷奥科技</a> <a href="/<%=keywordCheck%>_0_1718_0_0.htm" target="_top">雷萨重机</a> <a href="/<%=keywordCheck%>_0_13681_0_0.htm" target="_top">黎明</a> <a href="/<%=keywordCheck%>_0_412_0_0.htm" target="_top">力博士</a> <a href="/<%=keywordCheck%>_0_13678_0_0.htm" target="_top">力尔美</a> <a href="/<%=keywordCheck%>_0_13683_0_0.htm" target="_top">力士</a> <a href="/<%=keywordCheck%>_0_157_0_0.htm" target="_top">力士德</a> <a href="/<%=keywordCheck%>_0_13687_0_0.htm" target="_top">立藤</a> <a href="/<%=keywordCheck%>_0_13676_0_0.htm" target="_top">立新</a> <a href="/<%=keywordCheck%>_0_179_0_0.htm" target="_top">利勃海尔</a> <a href="/<%=keywordCheck%>_0_13677_0_0.htm" target="_top">利洲</a> <a href="/<%=keywordCheck%>_0_13684_0_0.htm" target="_top">联丰机械</a> <a href="/<%=keywordCheck%>_0_13686_0_0.htm" target="_top">辽原筑机</a> <a href="/<%=keywordCheck%>_0_204_0_0.htm" target="_top">辽筑</a> <a href="/<%=keywordCheck%>_0_1742_0_0.htm" target="_top">林德</a> <a href="/<%=keywordCheck%>_0_13680_0_0.htm" target="_top">林泰阁</a> <a href="/<%=keywordCheck%>_0_137_0_0.htm" target="_top">临工</a> <a href="/<%=keywordCheck%>_0_1509_0_0.htm" target="_top">灵升机械</a> <a href="/<%=keywordCheck%>_0_1181_0_0.htm" target="_top">凌虹建设机械</a> <a href="/<%=keywordCheck%>_0_1180_0_0.htm" target="_top">凌云建机</a> <a href="/<%=keywordCheck%>_0_136_0_0.htm" target="_top">柳工</a> <a href="/<%=keywordCheck%>_0_135_0_0.htm" target="_top">龙工</a> <a href="/<%=keywordCheck%>_0_14233_0_0.htm" target="_top">龙兴机械</a> <a href="/<%=keywordCheck%>_0_1739_0_0.htm" target="_top">鲁青</a> <a href="/<%=keywordCheck%>_0_14257_0_0.htm" target="_top">鲁宇重工</a> <a href="/<%=keywordCheck%>_0_688_0_0.htm" target="_top">鲁岳</a> <a href="/<%=keywordCheck%>_0_207_0_0.htm" target="_top">陆德筑机</a> <a href="/<%=keywordCheck%>_0_13688_0_0.htm" target="_top">路宝</a> <a href="/<%=keywordCheck%>_0_13679_0_0.htm" target="_top">路达</a> <a href="/<%=keywordCheck%>_0_13669_0_0.htm" target="_top">路大</a> <a href="/<%=keywordCheck%>_0_13673_0_0.htm" target="_top">路德克</a> <a href="/<%=keywordCheck%>_0_13670_0_0.htm" target="_top">路虹</a> <a href="/<%=keywordCheck%>_0_13675_0_0.htm" target="_top">路维</a> <a href="/<%=keywordCheck%>_0_13674_0_0.htm" target="_top">路星</a> <a href="/<%=keywordCheck%>_0_552_0_0.htm" target="_top">绿地</a> <a href="/<%=keywordCheck%>_0_1709_0_0.htm" target="_top">滦州重工</a> <a href="/<%=keywordCheck%>_0_1231_0_0.htm" target="_top">洛建</a> <a href="/<%=keywordCheck%>_0_673_0_0.htm" target="_top">洛阳路通</a> <a href="/<%=keywordCheck%>_0_13118_0_0.htm" target="_top">山东鲁工</a> <a href="/<%=keywordCheck%>_0_1509_0_0.htm" target="_top">厦门灵升</a> <a href="/<%=keywordCheck%>_0_1231_0_0.htm" target="_top">一拖</a> <a href="/<%=keywordCheck%>_0_13689_0_0.htm" target="_top">玛连尼</a> <a href="/<%=keywordCheck%>_0_418_0_0.htm" target="_top">麦恩</a> <a href="/<%=keywordCheck%>_0_13693_0_0.htm" target="_top">曼尼通</a> <a href="/<%=keywordCheck%>_0_14262_0_0.htm" target="_top">曼托瓦尼</a> <a href="/<%=keywordCheck%>_0_13692_0_0.htm" target="_top">梅狮</a> <a href="/<%=keywordCheck%>_0_1743_0_0.htm" target="_top">美科斯</a> <a href="/<%=keywordCheck%>_0_13095_0_0.htm" target="_top">美通筑机</a> <a href="/<%=keywordCheck%>_0_13696_0_0.htm" target="_top">美卓</a> <a href="/<%=keywordCheck%>_0_422_0_0.htm" target="_top">猛士</a> <a href="/<%=keywordCheck%>_0_13697_0_0.htm" target="_top">闽工</a> <a href="/<%=keywordCheck%>_0_13691_0_0.htm" target="_top">闽科</a> <a href="/<%=keywordCheck%>_0_13737_0_0.htm" target="_top">明山路桥</a> <a href="/<%=keywordCheck%>_0_1125_0_0.htm" target="_top">明威塔机</a> <a href="/<%=keywordCheck%>_0_13694_0_0.htm" target="_top">摩纳凯</a> <a href="/<%=keywordCheck%>_0_1126_0_0.htm" target="_top">牡丹江</a> <a href="/<%=keywordCheck%>_0_13695_0_0.htm" target="_top">牡丹江专用汽车</a> <a href="/<%=keywordCheck%>_0_13700_0_0.htm" target="_top">纳科重工</a> <a href="/<%=keywordCheck%>_0_1209_0_0.htm" target="_top">南车北京时代</a> <a href="/<%=keywordCheck%>_0_200_0_0.htm" target="_top">南方路机</a> <a href="/<%=keywordCheck%>_0_1134_0_0.htm" target="_top">南京绿野</a> <a href="/<%=keywordCheck%>_0_13698_0_0.htm" target="_top">南侨</a> <a href="/<%=keywordCheck%>_0_169_0_0.htm" target="_top">南特</a> <a href="/<%=keywordCheck%>_0_1748_0_0.htm" target="_top">农友</a> <a href="/<%=keywordCheck%>_0_14186_0_0.htm" target="_top">诺尔</a> <a href="/<%=keywordCheck%>_0_1585_0_0.htm" target="_top">诺克机械</a> <a href="/<%=keywordCheck%>_0_13699_0_0.htm" target="_top">诺力</a> <a href="/<%=keywordCheck%>_0_1585_0_0.htm" target="_top">诺森机械</a> </div>
      <div class="pllist"> <a class="plfl"><span style="color:#3355AC"> O-P-Q-R-S-T </span></a><br/>
        <a href="/<%=keywordCheck%>_0_13702_0_0.htm" target="_top">欧霸重工</a> <a href="/<%=keywordCheck%>_0_13701_0_0.htm" target="_top">欧亚机械</a> <a href="/<%=keywordCheck%>_0_199_0_0.htm" target="_top">普茨迈斯特</a> <a href="/<%=keywordCheck%>_0_403_0_0.htm" target="_top">普堃韩泰克</a> <a href="/<%=keywordCheck%>_0_486_0_0.htm" target="_top">普什重机</a> <a href="/<%=keywordCheck%>_0_14217_0_0.htm" target="_top">三一帕尔菲格</a> <a href="/<%=keywordCheck%>_0_156_0_0.htm" target="_top">上海彭浦</a> <a href="/<%=keywordCheck%>_0_1184_0_0.htm" target="_top">奇瑞迪凯重科</a> <a href="/<%=keywordCheck%>_0_14232_0_0.htm" target="_top">千里马</a> <a href="/<%=keywordCheck%>_0_582_0_0.htm" target="_top">勤牛</a> <a href="/<%=keywordCheck%>_0_13708_0_0.htm" target="_top">青山</a> <a href="/<%=keywordCheck%>_0_1750_0_0.htm" target="_top">全工机械</a> <a href="/<%=keywordCheck%>_0_198_0_0.htm" target="_top">全进重工</a> <a href="/<%=keywordCheck%>_0_13704_0_0.htm" target="_top">泉成机械</a> <a href="/<%=keywordCheck%>_0_13706_0_0.htm" target="_top">泉工</a> <a href="/<%=keywordCheck%>_0_13703_0_0.htm" target="_top">泉筑</a> <a href="/<%=keywordCheck%>_0_13707_0_0.htm" target="_top">群峰智能</a> <a href="/<%=keywordCheck%>_0_1139_0_0.htm" target="_top">四川强力</a> <a href="/<%=keywordCheck%>_0_686_0_0.htm" target="_top">厦门七天阳</a> <a href="/<%=keywordCheck%>_0_196_0_0.htm" target="_top">日工</a> <a href="/<%=keywordCheck%>_0_184_0_0.htm" target="_top">日立</a> <a href="/<%=keywordCheck%>_0_173_0_0.htm" target="_top">熔盛机械</a> <a href="/<%=keywordCheck%>_0_409_0_0.htm" target="_top">锐马</a> <a href="/<%=keywordCheck%>_0_425_0_0.htm" target="_top">瑞工</a> <a href="/<%=keywordCheck%>_0_13709_0_0.htm" target="_top">瑞龙重工(欧盟技术)</a> <a href="/<%=keywordCheck%>_0_1216_0_0.htm" target="_top">瑞诺</a> <a href="/<%=keywordCheck%>_0_14211_0_0.htm" target="_top">润邦机械</a> <a href="/<%=keywordCheck%>_0_14281_0_0.htm" target="_top">若鞍亿科技</a> <a href="/<%=keywordCheck%>_0_805_0_0.htm" target="_top">烟台锐泰</a> <a href="/<%=keywordCheck%>_0_810_0_0.htm" target="_top">烟台润弘</a> <a href="/<%=keywordCheck%>_0_741_0_0.htm" target="_top">江苏上騏</a> <a href="/<%=keywordCheck%>_0_13724_0_0.htm" target="_top">赛格玛</a> <a href="/<%=keywordCheck%>_0_1762_0_0.htm" target="_top">赛力斯特</a> <a href="/<%=keywordCheck%>_0_13717_0_0.htm" target="_top">赛奇</a> <a href="/<%=keywordCheck%>_0_868_0_0.htm" target="_top">赛通重工</a> <a href="/<%=keywordCheck%>_0_14248_0_0.htm" target="_top">赛宇重工</a> <a href="/<%=keywordCheck%>_0_14187_0_0.htm" target="_top">三驾机械</a> <a href="/<%=keywordCheck%>_0_13740_0_0.htm" target="_top">三力机械</a> <a href="/<%=keywordCheck%>_0_13749_0_0.htm" target="_top">三笠</a> <a href="/<%=keywordCheck%>_0_13732_0_0.htm" target="_top">三联机械</a> <a href="/<%=keywordCheck%>_0_13721_0_0.htm" target="_top">三菱</a> <a href="/<%=keywordCheck%>_0_13748_0_0.htm" target="_top">三隆重工</a> <a href="/<%=keywordCheck%>_0_13725_0_0.htm" target="_top">三洋重工</a> <a href="/<%=keywordCheck%>_0_133_0_0.htm" target="_top">三一</a> <a href="/<%=keywordCheck%>_0_1711_0_0.htm" target="_top">扫地王</a> <a href="/<%=keywordCheck%>_0_1711_0_0.htm" target="_top">扫地王集团</a> <a href="/<%=keywordCheck%>_0_626_0_0.htm" target="_top">森田重机</a> <a href="/<%=keywordCheck%>_0_13730_0_0.htm" target="_top">森源</a> <a href="/<%=keywordCheck%>_0_13713_0_0.htm" target="_top">森远</a> <a href="/<%=keywordCheck%>_0_1221_0_0.htm" target="_top">山宝</a> <a href="/<%=keywordCheck%>_0_14280_0_0.htm" target="_top">山东海宏</a> <a href="/<%=keywordCheck%>_0_1123_0_0.htm" target="_top">山东华夏</a> <a href="/<%=keywordCheck%>_0_13744_0_0.htm" target="_top">山东汇强</a> <a href="/<%=keywordCheck%>_0_13747_0_0.htm" target="_top">山东明龙</a> <a href="/<%=keywordCheck%>_0_1722_0_0.htm" target="_top">山东威猛</a> <a href="/<%=keywordCheck%>_0_138_0_0.htm" target="_top">山工</a> <a href="/<%=keywordCheck%>_0_142_0_0.htm" target="_top">山河智能</a> <a href="/<%=keywordCheck%>_0_454_0_0.htm" target="_top">山猫</a> <a href="/<%=keywordCheck%>_0_13731_0_0.htm" target="_top">山美</a> <a href="/<%=keywordCheck%>_0_1304_0_0.htm" target="_top">山特维克</a> <a href="/<%=keywordCheck%>_0_144_0_0.htm" target="_top">山推</a> <a href="/<%=keywordCheck%>_0_13723_0_0.htm" target="_top">山推格林</a> <a href="/<%=keywordCheck%>_0_1207_0_0.htm" target="_top">山挖重工</a> <a href="/<%=keywordCheck%>_0_152_0_0.htm" target="_top">山重建机</a> <a href="/<%=keywordCheck%>_0_668_0_0.htm" target="_top">陕建机械</a> <a href="/<%=keywordCheck%>_0_1753_0_0.htm" target="_top">陕汽</a> <a href="/<%=keywordCheck%>_0_13728_0_0.htm" target="_top">陕西科尼乐</a> <a href="/<%=keywordCheck%>_0_691_0_0.htm" target="_top">上海华建</a> <a href="/<%=keywordCheck%>_0_13735_0_0.htm" target="_top">上海建冶</a> <a href="/<%=keywordCheck%>_0_201_0_0.htm" target="_top">上海金泰</a> <a href="/<%=keywordCheck%>_0_211_0_0.htm" target="_top">上海施维英</a> <a href="/<%=keywordCheck%>_0_13733_0_0.htm" target="_top">上海威力特</a> <a href="/<%=keywordCheck%>_0_13715_0_0.htm" target="_top">上海西芝</a> <a href="/<%=keywordCheck%>_0_13718_0_0.htm" target="_top">上力重工</a> <a href="/<%=keywordCheck%>_0_1113_0_0.htm" target="_top">神斧</a> <a href="/<%=keywordCheck%>_0_183_0_0.htm" target="_top">神钢</a> <a href="/<%=keywordCheck%>_0_1523_0_0.htm" target="_top">神马科技</a> <a href="/<%=keywordCheck%>_0_14235_0_0.htm" target="_top">神娃机械</a> <a href="/<%=keywordCheck%>_0_13746_0_0.htm" target="_top">沈阳广成</a> <a href="/<%=keywordCheck%>_0_830_0_0.htm" target="_top">沈阳三洋</a> <a href="/<%=keywordCheck%>_0_1720_0_0.htm" target="_top">沈阳山河</a> <a href="/<%=keywordCheck%>_0_1090_0_0.htm" target="_top">盛利达</a> <a href="/<%=keywordCheck%>_0_618_0_0.htm" target="_top">盛隆</a> <a href="/<%=keywordCheck%>_0_190_0_0.htm" target="_top">石川岛</a> <a href="/<%=keywordCheck%>_0_168_0_0.htm" target="_top">石煤</a> <a href="/<%=keywordCheck%>_0_13727_0_0.htm" target="_top">世邦</a> <a href="/<%=keywordCheck%>_0_14255_0_0.htm" target="_top">世工机械</a> <a href="/<%=keywordCheck%>_0_13710_0_0.htm" target="_top">世联</a> <a href="/<%=keywordCheck%>_0_14251_0_0.htm" target="_top">世鑫源机械</a> <a href="/<%=keywordCheck%>_0_413_0_0.htm" target="_top">世运</a> <a href="/<%=keywordCheck%>_0_13711_0_0.htm" target="_top">仕高玛</a> <a href="/<%=keywordCheck%>_0_13714_0_0.htm" target="_top">首钢泰晟</a> <a href="/<%=keywordCheck%>_0_13719_0_0.htm" target="_top">双力</a> <a href="/<%=keywordCheck%>_0_13745_0_0.htm" target="_top">双牛</a> <a href="/<%=keywordCheck%>_0_419_0_0.htm" target="_top">水山</a> <a href="/<%=keywordCheck%>_0_14300_0_0.htm" target="_top">水山（民盛）</a> <a href="/<%=keywordCheck%>_0_13729_0_0.htm" target="_top">思嘉特</a> <a href="/<%=keywordCheck%>_0_13751_0_0.htm" target="_top">思拓瑞克</a> <a href="/<%=keywordCheck%>_0_13722_0_0.htm" target="_top">斯贝柯</a> <a href="/<%=keywordCheck%>_0_1102_0_0.htm" target="_top">斯达格思</a> <a href="/<%=keywordCheck%>_0_14279_0_0.htm" target="_top">斯泰克</a> <a href="/<%=keywordCheck%>_0_1117_0_0.htm" target="_top">四川建机</a> <a href="/<%=keywordCheck%>_0_13742_0_0.htm" target="_top">四通重工</a> <a href="/<%=keywordCheck%>_0_13739_0_0.htm" target="_top">嵩山重工</a> <a href="/<%=keywordCheck%>_0_868_0_0.htm" target="_top">徐州赛通</a> <a href="/<%=keywordCheck%>_0_1227_0_0.htm" target="_top">中国现代</a> <a href="/<%=keywordCheck%>_0_1138_0_0.htm" target="_top">重庆升力</a> <a href="/<%=keywordCheck%>_0_14221_0_0.htm" target="_top">TCM</a> <a href="/<%=keywordCheck%>_0_774_0_0.htm" target="_top">长沙天为</a> <a href="/<%=keywordCheck%>_0_1719_0_0.htm" target="_top">德威土行孙</a> <a href="/<%=keywordCheck%>_0_14261_0_0.htm" target="_top">江苏泰信</a> <a href="/<%=keywordCheck%>_0_827_0_0.htm" target="_top">上海腾迈</a> <a href="/<%=keywordCheck%>_0_1730_0_0.htm" target="_top">台励福</a> <a href="/<%=keywordCheck%>_0_538_0_0.htm" target="_top">太腾机械</a> <a href="/<%=keywordCheck%>_0_1728_0_0.htm" target="_top">泰安鲁能</a> <a href="/<%=keywordCheck%>_0_404_0_0.htm" target="_top">泰戈</a> <a href="/<%=keywordCheck%>_0_406_0_0.htm" target="_top">泰科</a> <a href="/<%=keywordCheck%>_0_1353_0_0.htm" target="_top">泰石克</a> <a href="/<%=keywordCheck%>_0_176_0_0.htm" target="_top">特雷克斯</a> <a href="/<%=keywordCheck%>_0_476_0_0.htm" target="_top">天地重工</a> <a href="/<%=keywordCheck%>_0_13754_0_0.htm" target="_top">天顺长城</a> <a href="/<%=keywordCheck%>_0_13755_0_0.htm" target="_top">天宇</a> <a href="/<%=keywordCheck%>_0_13752_0_0.htm" target="_top">田中铁工</a> <a href="/<%=keywordCheck%>_0_620_0_0.htm" target="_top">铁兵</a> <a href="/<%=keywordCheck%>_0_1758_0_0.htm" target="_top">铁建重工</a> <a href="/<%=keywordCheck%>_0_218_0_0.htm" target="_top">铁拓机械</a> <a href="/<%=keywordCheck%>_0_1726_0_0.htm" target="_top">通亚汽车</a> <a href="/<%=keywordCheck%>_0_1211_0_0.htm" target="_top">同力重工</a> <a href="/<%=keywordCheck%>_0_13753_0_0.htm" target="_top">土力机械</a> <a href="/<%=keywordCheck%>_0_210_0_0.htm" target="_top">拓能重机</a> <a href="/<%=keywordCheck%>_0_1760_0_0.htm" target="_top">无锡泰特</a> </div>
      <div class="pllist"> <a class="plfl"><span style="color:#3355AC"> U-V-W-X-Y-Z </span></a> <br/>
        <a href="/<%=keywordCheck%>_0_614_0_0.htm" target="_top">万邦重科</a> <a href="/<%=keywordCheck%>_0_1140_0_0.htm" target="_top">威海固恒</a> <a href="/<%=keywordCheck%>_0_1189_0_0.htm" target="_top">威肯</a> <a href="/<%=keywordCheck%>_0_491_0_0.htm" target="_top">威猛</a> <a href="/<%=keywordCheck%>_0_1738_0_0.htm" target="_top">威盛</a> <a href="/<%=keywordCheck%>_0_14256_0_0.htm" target="_top">威源机械</a> <a href="/<%=keywordCheck%>_0_214_0_0.htm" target="_top">维特根</a> <a href="/<%=keywordCheck%>_0_14263_0_0.htm" target="_top">潍柴特种车</a> <a href="/<%=keywordCheck%>_0_149_0_0.htm" target="_top">沃得重工</a> <a href="/<%=keywordCheck%>_0_662_0_0.htm" target="_top">沃尔华</a> <a href="/<%=keywordCheck%>_0_175_0_0.htm" target="_top">沃尔沃</a> <a href="/<%=keywordCheck%>_0_1160_0_0.htm" target="_top">五羊建机</a> <a href="/<%=keywordCheck%>_0_680_0_0.htm" target="_top">宜兴巍宇</a> <a href="/<%=keywordCheck%>_0_687_0_0.htm" target="_top">无锡雪桃</a> <a href="/<%=keywordCheck%>_0_13778_0_0.htm" target="_top">西安路邦</a> <a href="/<%=keywordCheck%>_0_1589_0_0.htm" target="_top">西贝</a> <a href="/<%=keywordCheck%>_0_13777_0_0.htm" target="_top">西尔玛</a> <a href="/<%=keywordCheck%>_0_13177_0_0.htm" target="_top">西林</a> <a href="/<%=keywordCheck%>_0_623_0_0.htm" target="_top">犀牛重工</a> <a href="/<%=keywordCheck%>_0_13786_0_0.htm" target="_top">夏洲重工</a> <a href="/<%=keywordCheck%>_0_139_0_0.htm" target="_top">厦工</a> <a href="/<%=keywordCheck%>_0_13175_0_0.htm" target="_top">厦门金华</a> <a href="/<%=keywordCheck%>_0_13784_0_0.htm" target="_top">厦强</a> <a href="/<%=keywordCheck%>_0_1744_0_0.htm" target="_top">厦盛</a> <a href="/<%=keywordCheck%>_0_13783_0_0.htm" target="_top">厦装</a> <a href="/<%=keywordCheck%>_0_410_0_0.htm" target="_top">先锋</a> <a href="/<%=keywordCheck%>_0_194_0_0.htm" target="_top">现代</a> <a href="/<%=keywordCheck%>_0_1359_0_0.htm" target="_top">现代（山东）</a> <a href="/<%=keywordCheck%>_0_1741_0_0.htm" target="_top">小橋</a> <a href="/<%=keywordCheck%>_0_182_0_0.htm" target="_top">小松</a> <a href="/<%=keywordCheck%>_0_13787_0_0.htm" target="_top">协兴</a> <a href="/<%=keywordCheck%>_0_13785_0_0.htm" target="_top">欣融</a> <a href="/<%=keywordCheck%>_0_13814_0_0.htm" target="_top">新波臣</a> <a href="/<%=keywordCheck%>_0_1236_0_0.htm" target="_top">新天和</a> <a href="/<%=keywordCheck%>_0_13779_0_0.htm" target="_top">新型</a> <a href="/<%=keywordCheck%>_0_13098_0_0.htm" target="_top">新宇机械</a> <a href="/<%=keywordCheck%>_0_1683_0_0.htm" target="_top">新源机械</a> <a href="/<%=keywordCheck%>_0_690_0_0.htm" target="_top">新筑股份</a> <a href="/<%=keywordCheck%>_0_692_0_0.htm" target="_top">鑫国重机</a> <a href="/<%=keywordCheck%>_0_1235_0_0.htm" target="_top">信达</a> <a href="/<%=keywordCheck%>_0_1097_0_0.htm" target="_top">星邦重工</a> <a href="/<%=keywordCheck%>_0_205_0_0.htm" target="_top">星马汽车</a> <a href="/<%=keywordCheck%>_0_13788_0_0.htm" target="_top">雄辉</a> <a href="/<%=keywordCheck%>_0_209_0_0.htm" target="_top">徐工</a> <a href="/<%=keywordCheck%>_0_1522_0_0.htm" target="_top">徐工特机</a> <a href="/<%=keywordCheck%>_0_150_0_0.htm" target="_top">徐挖</a> <a href="/<%=keywordCheck%>_0_544_0_0.htm" target="_top">徐威重科</a> <a href="/<%=keywordCheck%>_0_1129_0_0.htm" target="_top">徐州建机</a> <a href="/<%=keywordCheck%>_0_867_0_0.htm" target="_top">徐州凯尔</a> <a href="/<%=keywordCheck%>_0_154_0_0.htm" target="_top">宣工</a> <a href="/<%=keywordCheck%>_0_13619_0_0.htm" target="_top">雪狼</a> <a href="/<%=keywordCheck%>_0_14112_0_0.htm" target="_top">烟台信人</a> <a href="/<%=keywordCheck%>_0_1152_0_0.htm" target="_top">济南圆鑫</a> <a href="/<%=keywordCheck%>_0_1643_0_0.htm" target="_top">江苏意玛</a> <a href="/<%=keywordCheck%>_0_14250_0_0.htm" target="_top">青岛雅凯</a> <a href="/<%=keywordCheck%>_0_562_0_0.htm" target="_top">山东愚公</a> <a href="/<%=keywordCheck%>_0_1092_0_0.htm" target="_top">山东圆友</a> <a href="/<%=keywordCheck%>_0_408_0_0.htm" target="_top">上海友一</a> <a href="/<%=keywordCheck%>_0_13805_0_0.htm" target="_top">亚工</a> <a href="/<%=keywordCheck%>_0_13798_0_0.htm" target="_top">亚洁</a> <a href="/<%=keywordCheck%>_0_1148_0_0.htm" target="_top">亚特</a> <a href="/<%=keywordCheck%>_0_155_0_0.htm" target="_top">烟工</a> <a href="/<%=keywordCheck%>_0_191_0_0.htm" target="_top">洋马</a> <a href="/<%=keywordCheck%>_0_13795_0_0.htm" target="_top">业豪</a> <a href="/<%=keywordCheck%>_0_13738_0_0.htm" target="_top">一鼎重工</a> <a href="/<%=keywordCheck%>_0_13803_0_0.htm" target="_top">一帆机械</a> <a href="/<%=keywordCheck%>_0_159_0_0.htm" target="_top">一拖</a> <a href="/<%=keywordCheck%>_0_13800_0_0.htm" target="_top">依格曼</a> <a href="/<%=keywordCheck%>_0_770_0_0.htm" target="_top">宜工</a> <a href="/<%=keywordCheck%>_0_161_0_0.htm" target="_top">移山</a> <a href="/<%=keywordCheck%>_0_13791_0_0.htm" target="_top">亿龙机械</a> <a href="/<%=keywordCheck%>_0_13801_0_0.htm" target="_top">亿通正龙</a> <a href="/<%=keywordCheck%>_0_1749_0_0.htm" target="_top">忆辉</a> <a href="/<%=keywordCheck%>_0_13792_0_0.htm" target="_top">易山重工</a> <a href="/<%=keywordCheck%>_0_13808_0_0.htm" target="_top">益鑫</a> <a href="/<%=keywordCheck%>_0_1751_0_0.htm" target="_top">银锚</a> <a href="/<%=keywordCheck%>_0_13232_0_0.htm" target="_top">银起</a> <a href="/<%=keywordCheck%>_0_13793_0_0.htm" target="_top">英达</a> <a href="/<%=keywordCheck%>_0_1777_0_0.htm" target="_top">英轩重工</a> <a href="/<%=keywordCheck%>_0_1930_0_0.htm" target="_top">永安机械</a> <a href="/<%=keywordCheck%>_0_647_0_0.htm" target="_top">永工</a> <a href="/<%=keywordCheck%>_0_843_0_0.htm" target="_top">永茂</a> <a href="/<%=keywordCheck%>_0_13806_0_0.htm" target="_top">尤尼克</a> <a href="/<%=keywordCheck%>_0_562_0_0.htm" target="_top">愚公机械</a> <a href="/<%=keywordCheck%>_0_13802_0_0.htm" target="_top">宇泰</a> <a href="/<%=keywordCheck%>_0_143_0_0.htm" target="_top">宇通重工</a> <a href="/<%=keywordCheck%>_0_146_0_0.htm" target="_top">玉柴重工</a> <a href="/<%=keywordCheck%>_0_13796_0_0.htm" target="_top">豫弘重工</a> <a href="/<%=keywordCheck%>_0_13794_0_0.htm" target="_top">原进</a> <a href="/<%=keywordCheck%>_0_1092_0_0.htm" target="_top">圆友</a> <a href="/<%=keywordCheck%>_0_13799_0_0.htm" target="_top">远东</a> <a href="/<%=keywordCheck%>_0_13736_0_0.htm" target="_top">远华机械</a> <a href="/<%=keywordCheck%>_0_14238_0_0.htm" target="_top">约翰迪尔</a> <a href="/<%=keywordCheck%>_0_13797_0_0.htm" target="_top">岳首</a> <a href="/<%=keywordCheck%>_0_13804_0_0.htm" target="_top">粤工</a> <a href="/<%=keywordCheck%>_0_13807_0_0.htm" target="_top">运想重工</a> <a href="/<%=keywordCheck%>_0_1757_0_0.htm" target="_top">安徽中达</a> <a href="/<%=keywordCheck%>_0_1136_0_0.htm" target="_top">江苏正兴</a> <a href="/<%=keywordCheck%>_0_767_0_0.htm" target="_top">凌宇汽车</a> <a href="/<%=keywordCheck%>_0_13209_0_0.htm" target="_top">山东众和</a> <a href="/<%=keywordCheck%>_0_1095_0_0.htm" target="_top">上海振中</a> <a href="/<%=keywordCheck%>_0_13821_0_0.htm" target="_top">泽通</a> <a href="/<%=keywordCheck%>_0_195_0_0.htm" target="_top">詹阳动力</a> <a href="/<%=keywordCheck%>_0_13811_0_0.htm" target="_top">浙江赤道</a> <a href="/<%=keywordCheck%>_0_1119_0_0.htm" target="_top">浙江建机</a> <a href="/<%=keywordCheck%>_0_14220_0_0.htm" target="_top">浙江振中</a> <a href="/<%=keywordCheck%>_0_13817_0_0.htm" target="_top">正泰</a> <a href="/<%=keywordCheck%>_0_13816_0_0.htm" target="_top">郑州鼎盛</a> <a href="/<%=keywordCheck%>_0_813_0_0.htm" target="_top">郑州富岛（川岛）</a> <a href="/<%=keywordCheck%>_0_13824_0_0.htm" target="_top">中材建科</a> <a href="/<%=keywordCheck%>_0_13810_0_0.htm" target="_top">中方机械</a> <a href="/<%=keywordCheck%>_0_1214_0_0.htm" target="_top">中国重汽</a> <a href="/<%=keywordCheck%>_0_13819_0_0.htm" target="_top">中海恒通</a> <a href="/<%=keywordCheck%>_0_1219_0_0.htm" target="_top">中环动力</a> <a href="/<%=keywordCheck%>_0_1106_0_0.htm" target="_top">中集华骏</a> <a href="/<%=keywordCheck%>_0_13813_0_0.htm" target="_top">中际</a> <a href="/<%=keywordCheck%>_0_1951_0_0.htm" target="_top">中建机械</a> <a href="/<%=keywordCheck%>_0_542_0_0.htm" target="_top">中交西筑</a> <a href="/<%=keywordCheck%>_0_134_0_0.htm" target="_top">中联重科</a> <a href="/<%=keywordCheck%>_0_553_0_0.htm" target="_top">中龙建机</a> <a href="/<%=keywordCheck%>_0_13820_0_0.htm" target="_top">中青林</a> <a href="/<%=keywordCheck%>_0_13812_0_0.htm" target="_top">中升</a> <a href="/<%=keywordCheck%>_0_1131_0_0.htm" target="_top">中昇建机</a> <a href="/<%=keywordCheck%>_0_1682_0_0.htm" target="_top">中铁二十局</a> <a href="/<%=keywordCheck%>_0_1151_0_0.htm" target="_top">中文实业</a> <a href="/<%=keywordCheck%>_0_13823_0_0.htm" target="_top">中意</a> <a href="/<%=keywordCheck%>_0_13815_0_0.htm" target="_top">中誉鼎力</a> <a href="/<%=keywordCheck%>_0_188_0_0.htm" target="_top">竹内</a> <a href="/<%=keywordCheck%>_0_185_0_0.htm" target="_top">住友</a> <a href="/<%=keywordCheck%>_0_13809_0_0.htm" target="_top">筑马</a> <a href="/<%=keywordCheck%>_0_13818_0_0.htm" target="_top">钻通</a> </div>
    </div>
  </dd>
</li>

        </ul>
      </div>
      <input type="hidden" name="order" id="order">
      <input type="hidden" name="keyword" id="key_word">
    </form>
        <div class="nseresult_pro pic_searchval">
          <div class="nse_usedate">找到约<%=totalParts %>条结果</div>
          <ul class="pic_search_list fix">
	    <%  
		String title_hl = "";
        int i = 0;
		for(SolrDocument m : products){	
			String img=CommonString.getFormatPara(m.getFieldValue("img"));
			String id = CommonString.getFormatPara(m.getFieldValue("id"));
			String title = CommonString.getFormatPara(m.getFieldValue("title"));
			int counts=1;
			String url ="";
            String proType=CommonString.getFormatPara(m.getFieldValue("infoType"));
			if(proType.equals("1")){
			url="http://photo.21-sun.com/ndetail_for_"+id+".htm";
			Map sub1 = dbHelper.getMap(" select count(id) as count  from pro_photo where is_show=1 and group_id= '"+id+"'") ;
			if(sub1!=null){
		    counts=CommonString.getFormatInt(sub1.get("count"))+1;
			}			
			}else if(proType.equals("0")){
			url="http://photo.21-sun.com/detail_for_"+id+".htm";
			Map sub2 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where is_show=1 and product_id= '"+id+"'") ;
			if(sub2!=null){
		    counts=CommonString.getFormatInt(sub2.get("count"))+1;
			}
			}
			if(res.getHighlighting().get(id) != null){
				Map<String, List<String>> hl = res.getHighlighting().get(id);
				if(hl.get("title") != null){
					title_hl = hl.get("title").get(0);
				}
			}
			String titleAlt = title;
		 	if(title.length()>20){
		 		titleAlt=title;
		 		title=title.substring(0,20)+"...";
			}
		 %>
          	<li>
            	<a href="<%=url%>" title="<%=titleAlt%>" target="_blank">
                	<img  src="<%=img%>" alt="<%=titleAlt%>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"/>
                    <div class="pse_title"><%=title%></div>
                    <p class="pse_all">共<%=counts%>张图</p>
                </a>
            </li>
         <%i++;}%>
          </ul>
        </div>
        <div class="nse_page">
	  <%
	     if(factory.equals("")){factory="0";}
		 if(catalog.equals("")){catalog="0";}
	   %>
           <tags:photo_page_search nowPage="<%=nowPage%>" total="<%=totalParts %>"  totalPage="<%=pageCount%>" factory="<%=factory%>" catalog="<%=catalog%>" keyword="<%=pageKeyword%>" />
      		<div class="l nse_allresult">共约<%=totalParts %>条结果</div>
   		 </div>
    </div>
</div>
<!--main end-->
<%}else{%>
<div class="contain980 fix">
	<div class="nser_nots mb10">非常抱歉，没有找到与“<span><%=keywordCheck%></span>”相关的图片</div>
    <div class="nose_youcan">您可以通过以下方式进行查找内容</div>
    <div class="np_fix n_seach_no">
      <div class=" border03 l Condition mb10">
        <ul class="ConditionBottom">
          <script type="text/javascript">
        jQuery(document).ready(function() {
            jQuery(".pbtn").click(function(){
                jQuery(this).next("div").slideToggle(0)
                .siblings(".plmore:visible").slideUp(0);
                jQuery(this).toggleClass("pbon");
                jQuery(this).siblings(".pbon").removeClass("pbon");
            });	
        });
        </script>
 <li class="cblist" id="grab" >
  <dt> 热门<br>
    品牌 </dt>
  <dd> <a href="/三一重工_0_0_0_0.htm">三一重工</a> <a href="/徐工_0_0_0_0.htm">徐工</a> <a href="/中联重科_0_0_0_0.htm">中联重科</a> <a href="/柳工_0_0_0_0.htm">柳工</a> <a href="/山推_0_0_0_0.htm">山推</a> <a href="/临工_0_0_0_0.htm">临工</a> <a href="/福田雷沃_0_0_0_0.htm">福田雷沃</a> <a href="/龙工_0_0_0_0.htm">龙工</a> <a href="/小松_0_0_0_0.htm">小松</a> <a href="/卡特_0_0_0_0.htm">卡特</a> <a href="/沃尔沃_0_0_0_0.htm">沃尔沃</a> <a href="/利勃海尔_0_0_0_0.htm">利勃海尔</a> <a href="/神钢_0_0_0_0.htm">神钢</a> <a href="/日立_0_0_0_0.htm">日立</a> <a href="/酒井_0_0_0_0.htm">酒井</a> <a href="/杰西博_0_0_0_0.htm">杰西博</a> </dd>
</li>
        </ul>
      </div>
    </div>
<div class="np_fix n_seach_no">
  <div class=" border03 l Condition mb10">
    <ul class="ConditionBottom">
      <li class="cblist" id="grab" >
        <dt> 热门<br>
          产品 </dt>
        <dd> <a href="/挖掘机_0_0_0_0.htm">挖掘机</a> <a href="/装载机_0_0_0_0.htm">装载机</a> <a href="/推土机_0_0_0_0.htm">推土机</a> <a href="/平地机_0_0_0_0.htm">平地机</a> <a href="/自卸卡车_0_0_0_0.htm">自卸卡车</a> <a href="/铲运机_0_0_0_0.htm">铲运机</a> <a href="/塔式起重机_0_0_0_0.htm">塔式起重机</a> <a href="/汽车起重机_0_0_0_0.htm">汽车起重机</a> <a href="/履带式起重机_0_0_0_0.htm">履带式起重机</a> <a href="/高空作业平台_0_0_0_0.htm">高空作业平台</a> <a href="/高空作业车_0_0_0_0.htm">高空作业车</a> <a href="/随车起重机_0_0_0_0.htm">随车起重机</a> <a href="/施工升降机_0_0_0_0.htm">施工升降机</a> <a href="/伸缩臂叉装机_0_0_0_0.htm">伸缩臂叉装机</a> <a href="/泵车_0_0_0_0.htm">泵车</a> <a href="/车载泵_0_0_0_0.htm">车载泵</a> <a href="/拖泵_0_0_0_0.htm">拖泵</a> <a href="/输送泵_0_0_0_0.htm">输送泵</a> <a href="/混凝土搅拌设备_0_0_0_0.htm">混凝土搅拌设备</a> <a href="/混凝土布料设备_0_0_0_0.htm">混凝土布料设备</a> <a href="/混凝土搅拌运输车_0_0_0_0.htm">混凝土搅拌运输车</a> <a href="/干粉砂浆生产设备_0_0_0_0.htm">干粉砂浆生产设备</a> <a href="/粉粒物料运输车_0_0_0_0.htm">粉粒物料运输车</a> <a href="/其它混凝土设备_0_0_0_0.htm">其它混凝土设备</a> <a href="/干混砂浆生产线_0_0_0_0.htm">干混砂浆生产线</a> <a href="/沥青砂浆车_0_0_0_0.htm">沥青砂浆车</a> <a href="/干混砂浆背罐车_0_0_0_0.htm">干混砂浆背罐车</a> <a href="/喷湿机_0_0_0_0.htm">喷湿机</a> <a href="/摊铺机_0_0_0_0.htm">摊铺机</a> <a href="/养护机械_0_0_0_0.htm">养护机械</a> <a href="/其它路面机械_0_0_0_0.htm">其它路面机械</a> <a href="/沥青混合料搅拌设备_0_0_0_0.htm">沥青混合料搅拌设备</a> <a href="/铣刨机_0_0_0_0.htm">铣刨机</a> <a href="/稳定土厂拌设备_0_0_0_0.htm">稳定土厂拌设备</a> <a href="/沥青搅拌站_0_0_0_0.htm">沥青搅拌站</a> <a href="/稳定土拌合机_0_0_0_0.htm">稳定土拌合机</a> <a href="/旋挖钻机_0_0_0_0.htm">旋挖钻机</a> <a href="/液压静力压桩机_0_0_0_0.htm">液压静力压桩机</a> <a href="/打桩机_0_0_0_0.htm">打桩机</a> <a href="/水平定向钻_0_0_0_0.htm">水平定向钻</a> <a href="/连续墙抓斗_0_0_0_0.htm">连续墙抓斗</a> <a href="/长螺旋钻孔机_0_0_0_0.htm">长螺旋钻孔机</a> <a href="/打桩锤_0_0_0_0.htm">打桩锤</a> <a href="/潜孔钻机_0_0_0_0.htm">潜孔钻机</a> <a href="/多功能钻机_0_0_0_0.htm">多功能钻机</a> <a href="/强夯机_0_0_0_0.htm">强夯机</a> <a href="/液压步履式桩架_0_0_0_0.htm">液压步履式桩架</a> <a href="/多轴钻孔机_0_0_0_0.htm">多轴钻孔机</a> <a href="/连续墙钻机_0_0_0_0.htm">连续墙钻机</a> <a href="/截桩机_0_0_0_0.htm">截桩机</a> <a href="/其它桩工机械_0_0_0_0.htm">其它桩工机械</a> <a href="/压路机_0_0_0_0.htm">压路机</a> <a href="/压实机_0_0_0_0.htm">压实机</a> <a href="/夯实机_0_0_0_0.htm">夯实机</a> <a href="/内燃叉车_0_0_0_0.htm">内燃叉车</a> <a href="/电动叉车_0_0_0_0.htm">电动叉车</a> <a href="/仓储叉车_0_0_0_0.htm">仓储叉车</a> <a href="/破碎锤_0_0_0_0.htm">破碎锤</a> <a href="/液压剪_0_0_0_0.htm">液压剪</a> <a href="/凿岩机和钻机_0_0_0_0.htm">凿岩机和钻机</a> <a href="/输送和辅助设备_0_0_0_0.htm">输送和辅助设备</a> <a href="/破碎机_0_0_0_0.htm">破碎机</a> <a href="/装载及搬运设备_0_0_0_0.htm">装载及搬运设备</a> <a href="/连续采煤机和隧道掘进机_0_0_0_0.htm">连续采煤机和隧道掘进机</a> <a href="/矿用掘进机_0_0_0_0.htm">矿用掘进机</a> <a href="/采煤机_0_0_0_0.htm">采煤机</a> <a href="/凿岩台车_0_0_0_0.htm">凿岩台车</a> <a href="/筛分机_0_0_0_0.htm">筛分机</a> <a href="/全液压凿岩钻机_0_0_0_0.htm">全液压凿岩钻机</a> <a href="/盾构掘进机_0_0_0_0.htm">盾构掘进机</a> <a href="/凿岩钻车_0_0_0_0.htm">凿岩钻车</a> <a href="/检测车_0_0_0_0.htm">检测车</a> <a href="/运梁车_0_0_0_0.htm">运梁车</a> <a href="/架桥机_0_0_0_0.htm">架桥机</a> <a href="/提梁机_0_0_0_0.htm">提梁机</a> <a href="/砂浆车_0_0_0_0.htm">砂浆车</a> <a href="/堆高机_0_0_0_0.htm">堆高机</a> <a href="/正面吊_0_0_0_0.htm">正面吊</a> <a href="/场桥_0_0_0_0.htm">场桥</a> <a href="/推耙机_0_0_0_0.htm">推耙机</a> <a href="/吊具_0_0_0_0.htm">吊具</a> <a href="/专用车辆_0_0_0_0.htm">专用车辆</a> <a href="/消防车_0_0_0_0.htm">消防车</a> <a href="/牵引车_0_0_0_0.htm">牵引车</a> </dd>
      </li>
    </ul>
  </div>
</div>

    <div class="np_fix n_seach_no">
      <div class=" border03 l Condition mb10">
        <ul class="ConditionBottom">
          <script type="text/javascript">
        jQuery(document).ready(function() {
            jQuery(".pbtn").click(function(){
                jQuery(this).next("div").slideToggle(0)
                .siblings(".plmore:visible").slideUp(0);
                jQuery(this).toggleClass("pbon");
                jQuery(this).siblings(".pbon").removeClass("pbon");
            });	
        });
        </script>
          <li class="cblist" id="grab">
            <dt> 图片<br>分类</dt>
            <dd> 
               <a href="/产品图片_0_0_0_0.htm">产品图片</a>
               <a href="/行业图片_107001_0_0_0.htm">行业图片</a>
               <a href="/施工图片_107003_0_0_0.htm">施工图片</a>
               <a href="/维修图片_107004_0_0_0.htm">维修图片</a>
               <a href="/展会图片_107005_0_0_0.htm">展会图片</a>
			   <a href="/趣味图片_107006_0_0_0.htm">趣味图片</a>          
            </dd>
          </li>
        </ul>
      </div>
    </div>
    <div class="pho_pic_val pic_se_nodata_like">
    	<div class="hot_t">热门图片推荐</div>
        <div class="phopic_list">
        	<ul class="fix">
            <jsp:include page="/include/search/photo_hot_pic.jsp" flush="false"/>
            </ul>
        </div>
    </div>
</div>

<%}%>
<!--foot search 有搜索结果时出现-->
<div class="contain980">  
	<div class="nse_foot_search"><span>重新搜索</span><input onkeypress="tj();" value="<%=keywordCheck%>" name="keyword" id="keywords" type="text" class="nse_foot_seinp">
	<input type="submit" class="nse_foot_sebtn" value="搜索" onclick="tj();"></div>
    <div class="telTip">如果没有找到您的信息，请直接致电：<strong>4006-521-526</strong></div>

		<script>
		  function tj(){
		  	  if(jQuery('#keywords').val()==''){
		     jQuery('#keywords').focus();
			  alert("请输入搜索内容！");
			 return false;
		  }
		  var keyword=jQuery('#keywords').val();
		  window.location.href="/"+keyword+"_0_0_0_0.htm";
		  }
		</script>
</div>
<!--foot search 有搜索结果时出现结束-->
<!--like-->
<div class="contain980 mt10 pb10">
  <div class="nse_youlike">
    <p class="nse_guesslike">根据浏览猜你喜欢</p>
    <jsp:include page="/include/search/guess_like.jsp" flush="false"/>
  </div>
</div>
<!--like end-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--foot end--> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>