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
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	int nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));
	Map brandMap = (Map)application.getAttribute("brandMap") ;
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
    if(keywordCheck.equals("0")){keywordCheck="";}
	if(catalog.equals("")){catalog="0";}
	if(factory.equals("")){factory="0";}
	if(pageKeyword.equals("")){pageKeyword="0";}
	int totalParts1 = 0;
	int totalParts2 = 0;
	int totalParts3 = 0;
	String tempCatalog="";
	String tempFactory="";
	
	//搜索维修知识
	//搜索新	
	String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_weixiu";
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
	if((keywordCheck+tempFactory+tempCatalog).equals("")){
	   	query.setQuery("infoType:1");
	}else{
	   query.setQuery("title:" + keywordCheck+tempFactory+tempCatalog+" and infoType:1 ");
	}
    /*查询*/				
	int pageSize = 15;
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
	totalParts1 = (int)res.getResults().getNumFound();
	SolrDocumentList infoList = res.getResults();
	
	
	
	//搜索维修产品
	//搜索新	
	httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_weixiu";
	server = new HttpSolrServer(httpUrl);
	/*接收参数*/
	query = new SolrQuery();
	orderList = new ArrayList<SolrQuery.SortClause>();
	orderList.add(SolrQuery.SortClause.desc("id"));
	nowPage = nowPage <= 0 ? 1 : nowPage;
	if(!catalog.equals("0")&&!catalog.equals("")&&catalog.length()>3){
	   tempCatalog=(CommonString.getFormatPara(catalogMap.get(catalog)));
	}
	if(!factory.equals("0")&&!factory.equals("")){
	    tempFactory=(CommonString.getFormatPara(brandMap.get(factory)));
	}
	if((keywordCheck+tempFactory+tempCatalog).equals("")){
	   	query.setQuery("infoType:2");
	}else{
	    query.setQuery("title:" + keywordCheck+tempFactory+tempCatalog+" and infoType:2 ");
	}
    /*查询*/				
	pageSize = 15;
	query.setRequestHandler("/jereh");
	//query.setSorts(orderList);
	query.setRows(pageSize);
	query.setStart((nowPage - 1) * pageSize);
	/* 高亮 */
	query.setHighlight(true);
	query.setHighlightSimplePre("<span style='color:red;'>");
	query.setHighlightSimplePost("</span>");
	query.setParam("hl.fl", "title");
    res = server.query(query);
	totalParts2 = (int)res.getResults().getNumFound();
	SolrDocumentList proList = res.getResults();
	
	
	//搜索维修代理商
	//搜索新	
	httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_agent";
	server = new HttpSolrServer(httpUrl);
	/*接收参数*/
	query = new SolrQuery();
	orderList = new ArrayList<SolrQuery.SortClause>();
	orderList.add(SolrQuery.SortClause.desc("id"));
	nowPage = nowPage <= 0 ? 1 : nowPage;
	if(!catalog.equals("0")&&!catalog.equals("")&&catalog.length()>3){
	   tempCatalog=(CommonString.getFormatPara(catalogMap.get(catalog)));
	}
	if(!factory.equals("0")&&!factory.equals("")){
	    tempFactory=(CommonString.getFormatPara(brandMap.get(factory)));
	}
	if((keywordCheck+tempFactory+tempCatalog).equals("")){
	   	query.setQuery("*:*");
	}else{
	   query.setQuery("title:" + keywordCheck+tempFactory+tempCatalog);
	}
    /*查询*/				
	pageSize = 15;
	query.setRequestHandler("/jereh");
	//query.setSorts(orderList);
	query.setRows(pageSize);
	query.setStart((nowPage - 1) * pageSize);
	/* 高亮 */
	query.setHighlight(true);
	query.setHighlightSimplePre("<span style='color:red;'>");
	query.setHighlightSimplePost("</span>");
	query.setParam("hl.fl", "title");
	res = server.query(query);
	totalParts3 = (int)res.getResults().getNumFound();
	SolrDocumentList agentList = res.getResults();
	
	
	String TDK_title="";String TDK_keywords="";String TDK_desc="";
	if(totalParts1>0||totalParts2>0||totalParts3>0){
	TDK_title=(keywordCheck.equals("")?"":keywordCheck+" - ")+"产品搜索 - 铁臂商城";
	TDK_keywords=(keywordCheck.equals("")?"":keywordCheck+",")+"铁臂商城";
	TDK_desc="在铁臂商城中找到了"+totalParts1+"条"+keywordCheck+"相关信息，其中包含了"+keywordCheck+"价格表，"+keywordCheck+"图片，"+keywordCheck+"型号大全等信息，买"+keywordCheck+"就上铁臂商城。";
	}else{
	TDK_title=keywordCheck+" - 产品搜索 - 铁臂商城";
	TDK_keywords=keywordCheck+",铁臂商城";
	TDK_desc="在铁臂商城中找到了0件"+keywordCheck+"相关信息，请重新选择，买工程机械就上铁臂商城。";
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=totalParts1+totalParts2+totalParts3%></title>
<meta name="keywords" content="工程机械图片,工程机械图库,工程机械图片大全" />
<meta name="description" content="挖掘机图片，装载机图片，国内工程机械图片量最丰富、图片清晰度最高的专业工程机械图片频道。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/new_style.css" rel="stylesheet" type="text/css" />
<link href="../weixiu/style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/friendly_link.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top_search.jsp" flush="true"/>
<!--top end--> 
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">搜索结果</a> &gt;&gt; <%=keywordCheck%> </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 fix"> 
  <!--left-->
  <div class="w210 l">
    <div class="nph_val mb10">
      <ul class="nph_list">
        <li> <a href="/search/挖掘机_0_101_0.htm">维修知识</a></li>
        <li> <a href="/search/挖掘机_0_101_0.htm">产品维修</a></li>
        <li> <a href="/search/挖掘机_0_101_0.htm">维修网点</a></li>
      </ul>
    </div>
    <div class="w208 border02 l leftPart02 mb10 np_addpcat Similar nse_left_viewpro">
      <div class="stitle Sborder">
        <h3>热门维修知识</h3>
      </div>
      <ul class="list003" id="brandProductList">
        <li class="top3">
          <h4> <a title="查看龙工LG6220D挖掘机" target="_blank" href="#"> [维修] 三一挖掘机好不好 </a></h4>
        </li>
        <li class="top3">
          <h4> <a title="查看龙工LG6220D挖掘机" target="_blank" href="#"> [维修] 三一挖掘机好不好 </a></h4>
        </li>
        <li class="top3">
          <h4> <a title="查看龙工LG6220D挖掘机" target="_blank" href="#"> [维修] 三一挖掘机好不好 </a></h4>
        </li>
        <li class="top3">
          <h4> <a title="查看龙工LG6220D挖掘机" target="_blank" href="#"> [维修] 三一挖掘机好不好 </a></h4>
        </li>
        <li class="top3">
          <h4> <a title="查看龙工LG6220D挖掘机" target="_blank" href="#"> [维修] 三一挖掘机好不好</a></h4>
        </li>
        <li class="top3">
          <h4> <a title="查看龙工LG6220D挖掘机" target="_blank" href="#"> [维修] 三一挖掘机好不好 </a></h4>
        </li>
      </ul>
    </div>
    <div class="Similar nse_left_viewpro Sborder">
      <div class="stitle">
        <h3>热门产品维修</h3>
      </div>
      <div class="scontent">
        <ul class="slist" id="history">
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
        </ul>
      </div>
    </div>
    <div class="rp clearfix mb10 area Similar nse_left_viewpro Sborder mt10">
      <div class="stitle">
        <h3>热门维修网点</h3>
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
    <div class="Similar nse_left_viewpro Sborder">
      <div class="stitle">
        <h3>相关产品</h3>
      </div>
      <div class="scontent">
        <ul class="slist" id="history">
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
          <li><a href="#" target="_blank" title="三一SY265C-9挖掘机"><img title="三一SY265C-9挖掘机" alt="三一SY265C-9挖掘机" src="1.jgp" onerror="this.src='/images/nopic.gif'" width="90" height="50">
            <h4> 三一SY265C-9挖掘机</h4>
            </a></li>
        </ul>
      </div>
    </div>
  </div>
  <!--left end--> 
  <!--right-->
  <div class="w757 r">
	 <% 
	    if(!keywordCheck.equals("")){
    	UIRelated uiRelated = new UIRelated();
    	out.print(uiRelated.related(request));
		}
     %>
	 <form name="theform" id="theform">
      <div class="border03 l Condition mb10 nwx_net_sea">
        <div class="ConditionTop">
          <div class="l"> </div>
          <h1 class="r" style="font-size:14px;">工程机械维修大全</h1>
        </div>
        <ul class="ConditionBottom">
          <script type="text/javascript">
	  jQuery(document).ready(function(){
		  jQuery(".pbtn").click(function(){
			  jQuery(this).next("div").slideToggle(0)
			  .siblings(".plmore:visible").slideUp(0);
			  jQuery(this).toggleClass("pbon");
			  jQuery(this).siblings(".pbon").removeClass("pbon");
		  });	
	  });
	  </script>
          <li class="cblist">
            <dt> 区域 </dt>
            <dd> <a href="/0-0-0.htm" class="select">不限</a> <a title="北京" href="/0-105500-0.htm">北京</a> <a title="上海" href="/0-105300-0.htm">上海</a> <a title="天津" href="/0-105690-0.htm">天津</a> <a title="重庆" href="/0-105880-0.htm">重庆</a> <a title="石家庄" href="/0-106410-0.htm">石家庄</a> <a title="太原" href="/0-108310-0.htm">太原</a> <a title="呼和浩特" href="/0-109710-0.htm">呼和浩特</a> <a title="沈阳" href="/0-120010-0.htm">沈阳</a> <a title="长春" href="/0-119010-0.htm">长春</a> <a title="哈尔滨" href="/0-122010-0.htm">哈尔滨</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 660px;">
                <div class="pllist"> <a href="/0-105500-0.htm">北京</a> <a href="/0-105690-0.htm">天津</a> <a href="/0-105300-0.htm">上海</a> <a href="/0-105880-0.htm">重庆</a> <a href="/0-101990-0.htm">安庆</a> <a href="/0-102400-0.htm">蚌埠</a> <a href="/0-102980-0.htm">亳州</a> <a href="/0-103030-0.htm">巢湖</a> <a href="/0-102190-0.htm">池州</a> <a href="/0-102600-0.htm">滁州</a> <a href="/0-102690-0.htm">阜阳</a> <a href="/0-102320-0.htm">合肥</a> <a href="/0-102550-0.htm">淮北</a> <a href="/0-102480-0.htm">淮南</a> <a href="/0-102110-0.htm">黄山</a> <a href="/0-102900-0.htm">六安</a> <a href="/0-101940-0.htm">马鞍山</a> <a href="/0-102780-0.htm">宿州</a> <a href="/0-101890-0.htm">铜陵</a> <a href="/0-101810-0.htm">芜湖</a> <a href="/0-102240-0.htm">宣城</a> <a href="/0-142010-0.htm">福州</a> <a href="/0-142770-0.htm">龙岩</a> <a href="/0-142660-0.htm">南平</a> <a href="/0-142850-0.htm">宁德</a> <a href="/0-142220-0.htm">莆田</a> <a href="/0-142410-0.htm">泉州</a> <a href="/0-142280-0.htm">三明</a> <a href="/0-142150-0.htm">厦门</a> <a href="/0-142540-0.htm">漳州</a> <a href="/0-134140-0.htm">白银</a> <a href="/0-134650-0.htm">定西</a> <a href="/0-134920-0.htm">甘南</a> <a href="/0-134100-0.htm">嘉峪关</a> <a href="/0-134110-0.htm">金昌</a> <a href="/0-134480-0.htm">酒泉</a> <a href="/0-134010-0.htm">兰州</a> <a href="/0-134830-0.htm">临夏</a> <a href="/0-134730-0.htm">陇南</a> <a href="/0-134400-0.htm">平凉</a> <a href="/0-134560-0.htm">庆阳</a> <a href="/0-134200-0.htm">天水</a> <a href="/0-134280-0.htm">武威</a> <a href="/0-134330-0.htm">张掖</a> <a href="/0-129270-0.htm">潮州</a> <a href="/0-129250-0.htm">东莞</a> <a href="/0-128440-0.htm">佛山</a> <a href="/0-128010-0.htm">广州</a> <a href="/0-129040-0.htm">河源</a> <a href="/0-128840-0.htm">惠州</a> <a href="/0-128500-0.htm">江门</a> <a href="/0-129310-0.htm">揭阳</a> <a href="/0-128680-0.htm">茂名</a> <a href="/0-128900-0.htm">梅州</a> <a href="/0-129160-0.htm">清远</a> <a href="/0-128250-0.htm">汕头</a> <a href="/0-128990-0.htm">汕尾</a> <a href="/0-128330-0.htm">韶关</a> <a href="/0-128140-0.htm">深圳</a> <a href="/0-129110-0.htm">阳江</a> <a href="/0-129370-0.htm">云浮</a> <a href="/0-128580-0.htm">湛江</a> <a href="/0-128750-0.htm">肇庆</a> <a href="/0-129260-0.htm">中山</a> <a href="/0-128210-0.htm">珠海</a> <a href="/0-113790-0.htm">百色</a> <a href="/0-113510-0.htm">北海</a> <a href="/0-114160-0.htm">崇左</a> <a href="/0-113560-0.htm">防城港</a> <a href="/0-113660-0.htm">贵港</a> <a href="/0-113250-0.htm">桂林</a> <a href="/0-113970-0.htm">河池</a> <a href="/0-113920-0.htm">贺州</a> <a href="/0-114090-0.htm">来宾</a> <a href="/0-113140-0.htm">柳州</a> <a href="/0-113010-0.htm">南宁</a> <a href="/0-113610-0.htm">钦州</a> <a href="/0-113430-0.htm">梧州</a> <a href="/0-113720-0.htm">玉林</a> <a href="/0-132320-0.htm">安顺</a> <a href="/0-132500-0.htm">毕节</a> <a href="/0-132010-0.htm">贵阳</a> <a href="/0-132120-0.htm">六盘水</a> <a href="/0-132680-0.htm">黔东南</a> <a href="/0-132850-0.htm">黔南</a> <a href="/0-132590-0.htm">黔西南</a> <a href="/0-132390-0.htm">铜仁</a> <a href="/0-132170-0.htm">遵义</a> <a href="/0-141650-0.htm">澄迈县</a> <a href="/0-141590-0.htm">儋州</a> <a href="/0-141630-0.htm">定安县</a> <a href="/0-141620-0.htm">东方</a> <a href="/0-141510-0.htm">海口</a> <a href="/0-141660-0.htm">临高县</a> <a href="/0-141580-0.htm">琼海</a> <a href="/0-141560-0.htm">三亚</a> <a href="/0-141640-0.htm">屯昌县</a> <a href="/0-141610-0.htm">万宁</a> <a href="/0-141600-0.htm">文昌</a> <a href="/0-141570-0.htm">五指山</a> <a href="/0-107280-0.htm">保定</a> <a href="/0-107840-0.htm">沧州</a> <a href="/0-107720-0.htm">承德</a> <a href="/0-106880-0.htm">邯郸</a> <a href="/0-108120-0.htm">衡水</a> <a href="/0-108010-0.htm">廊坊</a> <a href="/0-106800-0.htm">秦皇岛</a> <a href="/0-106410-0.htm">石家庄</a> <a href="/0-106650-0.htm">唐山</a> <a href="/0-107080-0.htm">邢台</a> <a href="/0-107540-0.htm">张家口</a> <a href="/0-130820-0.htm">安阳</a> <a href="/0-130630-0.htm">鹤壁</a> <a href="/0-131760-0.htm">济源</a> <a href="/0-130520-0.htm">焦作</a> <a href="/0-130140-0.htm">开封</a> <a href="/0-130250-0.htm">洛阳</a> <a href="/0-131060-0.htm">漯河</a> <a href="/0-131190-0.htm">南阳</a> <a href="/0-130410-0.htm">平顶山</a> <a href="/0-130920-0.htm">濮阳</a> <a href="/0-131120-0.htm">三门峡</a> <a href="/0-131330-0.htm">商丘</a> <a href="/0-130690-0.htm">新乡</a> <a href="/0-131430-0.htm">信阳</a> <a href="/0-130990-0.htm">许昌</a> <a href="/0-130010-0.htm">郑州</a> <a href="/0-131540-0.htm">周口</a> <a href="/0-131650-0.htm">驻马店</a> <a href="/0-122650-0.htm">大庆</a> <a href="/0-123380-0.htm">大兴安岭</a> <a href="/0-122010-0.htm">哈尔滨</a> <a href="/0-122470-0.htm">鹤岗</a> <a href="/0-123200-0.htm">黑河</a> <a href="/0-122370-0.htm">鸡西</a> <a href="/0-122930-0.htm">佳木斯</a> <a href="/0-123090-0.htm">牡丹江</a> <a href="/0-123040-0.htm">七台河</a> <a href="/0-122200-0.htm">齐齐哈尔</a> <a href="/0-122560-0.htm">双鸭山</a> <a href="/0-123270-0.htm">绥化</a> <a href="/0-122750-0.htm">伊春</a> <a href="/0-124700-0.htm">鄂州</a> <a href="/0-125030-0.htm">恩施</a> <a href="/0-124820-0.htm">黄冈</a> <a href="/0-124150-0.htm">黄石</a> <a href="/0-124640-0.htm">荆门</a> <a href="/0-124410-0.htm">荆州</a> <a href="/0-125130-0.htm">潜江</a> <a href="/0-125150-0.htm">神农架</a> <a href="/0-124320-0.htm">十堰</a> <a href="/0-125000-0.htm">随州</a> <a href="/0-125140-0.htm">天门</a> <a href="/0-124010-0.htm">武汉</a> <a href="/0-125120-0.htm">仙桃</a> <a href="/0-124930-0.htm">咸宁</a> <a href="/0-124220-0.htm">襄樊</a> <a href="/0-124740-0.htm">孝感</a> <a href="/0-124500-0.htm">宜昌</a> <a href="/0-126010-0.htm">长沙</a> <a href="/0-126630-0.htm">常德</a> <a href="/0-126850-0.htm">郴州</a> <a href="/0-126270-0.htm">衡阳</a> <a href="/0-127090-0.htm">怀化</a> <a href="/0-127220-0.htm">娄底</a> <a href="/0-126400-0.htm">邵阳</a> <a href="/0-126210-0.htm">湘潭</a> <a href="/0-127280-0.htm">湘西</a> <a href="/0-126780-0.htm">益阳</a> <a href="/0-126970-0.htm">永州</a> <a href="/0-126530-0.htm">岳阳</a> <a href="/0-126730-0.htm">张家界</a> <a href="/0-126110-0.htm">株洲</a> <a href="/0-119550-0.htm">白城</a> <a href="/0-119420-0.htm">白山</a> <a href="/0-119010-0.htm">长春</a> <a href="/0-119120-0.htm">吉林</a> <a href="/0-119290-0.htm">辽源</a> <a href="/0-119220-0.htm">四平</a> <a href="/0-119490-0.htm">松原</a> <a href="/0-119340-0.htm">通化</a> <a href="/0-111260-0.htm">常州</a> <a href="/0-111630-0.htm">淮安</a> <a href="/0-111550-0.htm">连云港</a> <a href="/0-110910-0.htm">南京</a> <a href="/0-111460-0.htm">南通</a> <a href="/0-111340-0.htm">苏州</a> <a href="/0-112040-0.htm">宿迁</a> <a href="/0-111970-0.htm">泰州</a> <a href="/0-111050-0.htm">无锡</a> <a href="/0-111140-0.htm">徐州</a> <a href="/0-111720-0.htm">盐城</a> <a href="/0-111820-0.htm">扬州</a> <a href="/0-111900-0.htm">镇江</a> <a href="/0-103950-0.htm">抚州</a> <a href="/0-103510-0.htm">赣州</a> <a href="/0-103700-0.htm">吉安</a> <a href="/0-103200-0.htm">景德镇</a> <a href="/0-103310-0.htm">九江</a> <a href="/0-103110-0.htm">南昌</a> <a href="/0-103250-0.htm">萍乡</a> <a href="/0-104070-0.htm">上饶</a> <a href="/0-103440-0.htm">新余</a> <a href="/0-103840-0.htm">宜春</a> <a href="/0-103470-0.htm">鹰潭</a> <a href="/0-120260-0.htm">鞍山</a> <a href="/0-120420-0.htm">本溪</a> <a href="/0-121000-0.htm">朝阳</a> <a href="/0-120150-0.htm">大连</a> <a href="/0-120490-0.htm">丹东</a> <a href="/0-120340-0.htm">抚顺</a> <a href="/0-120710-0.htm">阜新</a> <a href="/0-121080-0.htm">葫芦岛</a> <a href="/0-120560-0.htm">锦州</a> <a href="/0-120790-0.htm">辽阳</a> <a href="/0-120870-0.htm">盘锦</a> <a href="/0-120010-0.htm">沈阳</a> <a href="/0-120920-0.htm">铁岭</a> <a href="/0-120640-0.htm">营口</a> <a href="/0-110790-0.htm">阿拉善盟</a> <a href="/0-110390-0.htm">巴彦淖尔</a> <a href="/0-109810-0.htm">包头</a> <a href="/0-109950-0.htm">赤峰</a> <a href="/0-110170-0.htm">鄂尔多斯</a> <a href="/0-109710-0.htm">呼和浩特</a> <a href="/0-110260-0.htm">呼伦贝尔</a> <a href="/0-110080-0.htm">通辽</a> <a href="/0-109910-0.htm">乌海</a> <a href="/0-110470-0.htm">乌兰察布</a> <a href="/0-110590-0.htm">兴安盟</a> <a href="/0-116170-0.htm">固原</a> <a href="/0-116080-0.htm">石嘴山</a> <a href="/0-116120-0.htm">吴忠</a> <a href="/0-116010-0.htm">银川</a> <a href="/0-116230-0.htm">中卫</a> <a href="/0-133320-0.htm">果洛</a> <a href="/0-133160-0.htm">海北</a> <a href="/0-133090-0.htm">海东</a> <a href="/0-133260-0.htm">海南</a> <a href="/0-133460-0.htm">海西</a> <a href="/0-133210-0.htm">黄南</a> <a href="/0-133010-0.htm">西宁</a> <a href="/0-133390-0.htm">玉树</a> <a href="/0-101650-0.htm">滨州</a> <a href="/0-101470-0.htm">德州</a> <a href="/0-101590-0.htm">东营</a> <a href="/0-101130-0.htm">菏泽</a> <a href="/0-101260-0.htm">济南</a> <a href="/0-100930-0.htm">济宁</a> <a href="/0-101230-0.htm">莱芜</a> <a href="/0-101380-0.htm">聊城</a> <a href="/0-100640-0.htm">临沂</a> <a href="/0-100120-0.htm">青岛</a> <a href="/0-100250-0.htm">日照</a> <a href="/0-101060-0.htm">泰安</a> <a href="/0-100570-0.htm">威海</a> <a href="/0-100300-0.htm">潍坊</a> <a href="/0-100430-0.htm">烟台</a> <a href="/0-100770-0.htm">枣庄</a> <a href="/0-100840-0.htm">淄博</a> <a href="/0-108600-0.htm">长治</a> <a href="/0-108420-0.htm">大同</a> <a href="/0-108740-0.htm">晋城</a> <a href="/0-108880-0.htm">晋中</a> <a href="/0-109290-0.htm">临汾</a> <a href="/0-109470-0.htm">吕梁</a> <a href="/0-108810-0.htm">朔州</a> <a href="/0-108310-0.htm">太原</a> <a href="/0-109140-0.htm">忻州</a> <a href="/0-108540-0.htm">阳泉</a> <a href="/0-109000-0.htm">运城</a> <a href="/0-136490-0.htm">安康</a> <a href="/0-135700-0.htm">宝鸡</a> <a href="/0-136240-0.htm">汉中</a> <a href="/0-136600-0.htm">商洛</a> <a href="/0-135650-0.htm">铜川</a> <a href="/0-135980-0.htm">渭南</a> <a href="/0-135510-0.htm">西安</a> <a href="/0-135830-0.htm">咸阳</a> <a href="/0-136100-0.htm">延安</a> <a href="/0-136360-0.htm">榆林</a> <a href="/0-140520-0.htm">阿坝</a> <a href="/0-140420-0.htm">巴中</a> <a href="/0-139010-0.htm">成都</a> <a href="/0-140180-0.htm">达州</a> <a href="/0-139420-0.htm">德阳</a> <a href="/0-140660-0.htm">甘孜</a> <a href="/0-140120-0.htm">广安</a> <a href="/0-139590-0.htm">广元</a> <a href="/0-139790-0.htm">乐山</a> <a href="/0-140850-0.htm">凉山</a> <a href="/0-139340-0.htm">泸州</a> <a href="/0-140260-0.htm">眉山</a> <a href="/0-139490-0.htm">绵阳</a> <a href="/0-139730-0.htm">内江</a> <a href="/0-139910-0.htm">南充</a> <a href="/0-139280-0.htm">攀枝花</a> <a href="/0-139670-0.htm">遂宁</a> <a href="/0-140330-0.htm">雅安</a> <a href="/0-140010-0.htm">宜宾</a> <a href="/0-140470-0.htm">资阳</a> <a href="/0-139210-0.htm">自贡</a> <a href="/0-115660-0.htm">阿里</a> <a href="/0-115100-0.htm">昌都</a> <a href="/0-115010-0.htm">拉萨</a> <a href="/0-115740-0.htm">林芝</a> <a href="/0-115540-0.htm">那曲</a> <a href="/0-115350-0.htm">日喀则</a> <a href="/0-115220-0.htm">山南</a> <a href="/0-117320-0.htm">阿克苏</a> <a href="/0-118100-0.htm">阿拉尔</a> <a href="/0-118010-0.htm">阿勒泰</a> <a href="/0-117190-0.htm">哈密</a> <a href="/0-117230-0.htm">和田</a> <a href="/0-117420-0.htm">喀什</a> <a href="/0-117100-0.htm">克拉玛依</a> <a href="/0-118090-0.htm">石河子</a> <a href="/0-117930-0.htm">塔城</a> <a href="/0-118110-0.htm">图木舒克</a> <a href="/0-117150-0.htm">吐鲁番</a> <a href="/0-117010-0.htm">乌鲁木齐</a> <a href="/0-118120-0.htm">五家渠</a> <a href="/0-137360-0.htm">保山</a> <a href="/0-138070-0.htm">楚雄</a> <a href="/0-138180-0.htm">大理</a> <a href="/0-138310-0.htm">德宏</a> <a href="/0-138420-0.htm">迪庆</a> <a href="/0-137890-0.htm">红河</a> <a href="/0-137010-0.htm">昆明</a> <a href="/0-137540-0.htm">丽江</a> <a href="/0-137710-0.htm">临沧</a> <a href="/0-138370-0.htm">怒江</a> <a href="/0-137600-0.htm">普洱</a> <a href="/0-137160-0.htm">曲靖</a> <a href="/0-137800-0.htm">文山</a> <a href="/0-138030-0.htm">西双版纳</a> <a href="/0-137260-0.htm">玉溪</a> <a href="/0-137420-0.htm">昭通</a> <a href="/0-104210-0.htm">杭州</a> <a href="/0-104670-0.htm">湖州</a> <a href="/0-104590-0.htm">嘉兴</a> <a href="/0-104800-0.htm">金华</a> <a href="/0-105120-0.htm">丽水</a> <a href="/0-104350-0.htm">宁波</a> <a href="/0-104900-0.htm">衢州</a> <a href="/0-104730-0.htm">绍兴</a> <a href="/0-105020-0.htm">台州</a> <a href="/0-104470-0.htm">温州</a> <a href="/0-104970-0.htm">舟山</a> </div>
              </div>
            </dd>
          </li>
          <li class="cblist">
            <dt> 类别 </dt>
            <dd> <a href="/0-0-0.htm" class="select">不限</a> <a href="/101001-0-0.htm">挖掘机维修</a> <a href="/101002-0-0.htm">装载机维修</a> <a href="/102-0-0.htm">起重机维修</a> <a href="/101003-0-0.htm">推土机维修</a> <a href="/103-0-0.htm">混凝土维修</a> <a href="/106001-0-0.htm">压路机维修</a> <a href="/101005-0-0.htm">平地机维修</a> <a href="/105003-0-0.htm">旋挖钻维修</a> <a href="/113001-0-0.htm">破碎锤维修</a> <a href="/104001-0-0.htm">摊铺机维修</a> <a href="/107-0-0.htm">叉车维修</a> <a href="/104-0-0.htm">筑养路维修</a> <a href="/105-0-0.htm">桩工维修</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 660px;">
                <div class="pllist"> <a href="/101-0-0.htm" class="plfl" target="_top"> <strong style="color:#3355AC">土方机械维修</strong> </a> <br>
                  <a href="/101003-0-0.htm" target="_top"> 推土机维修 </a> <a href="/101002-0-0.htm" target="_top"> 装载机维修 </a> <a href="/101001-0-0.htm" target="_top"> 挖掘机维修 </a> <a href="/101005-0-0.htm" target="_top"> 平地机维修 </a> <a href="/101004-0-0.htm" target="_top"> 铲运机维修 </a> <a href="/101008-0-0.htm" target="_top"> 自卸卡车维修 </a> </div>
                <div class="pllist"> <a href="/102-0-0.htm" class="plfl" target="_top"> <strong style="color:#3355AC">起重机维修</strong> </a> <br>
                  <a href="/102013-0-0.htm" target="_top"> 桥梁式起重机维修 </a> <a href="/102012-0-0.htm" target="_top"> 伸缩臂叉装机维修 </a> <a href="/102002-0-0.htm" target="_top"> 塔式起重机维修 </a> <a href="/102011-0-0.htm" target="_top"> 施工升降机维修 </a> <a href="/102010-0-0.htm" target="_top"> 高空作业车维修 </a> <a href="/102007-0-0.htm" target="_top"> 汽车起重机维修</a> <a href="/102008-0-0.htm" target="_top"> 履带式起重机维修 </a> <a href="/102006-0-0.htm" target="_top"> 随车起重机维修 </a> <a href="/102003-0-0.htm" target="_top"> 高空作业平台维修 </a> </div>
                <div class="pllist"> <a href="/103-0-0.htm" class="plfl" target="_top"><strong style="color:#3355AC"> 混凝土机械维修</strong> </a> <br>
                  <a href="/103008-0-0.htm" target="_top"> 干粉砂浆生产设备维修 </a> <a href="/103009-0-0.htm" target="_top"> 粉粒物料运输车维修 </a> <a href="/103005-0-0.htm" target="_top"> 混凝土布料设备维修 </a> <a href="/103006-0-0.htm" target="_top"> 混凝土搅拌运输车维修 </a> <a href="/103015-0-0.htm" target="_top"> 其它混凝土设备维修 </a> <a href="/103012-0-0.htm" target="_top"> 干混砂浆生产线维修 </a> <a href="/103011-0-0.htm" target="_top"> 沥青砂浆车维修 </a> <a href="/103014-0-0.htm" target="_top"> 干混砂浆背罐车维修 </a> <a href="/103002-0-0.htm" target="_top"> 混凝土搅拌设备维修 </a> <a href="/103001-0-0.htm" target="_top"> 混凝土泵车维修 </a> <a href="/103010-0-0.htm" target="_top"> 喷湿机维修 </a> </div>
                <div class="pllist"> <a href="/104-0-0.htm" class="plfl" target="_top"> <strong style="color:#3355AC">筑养路机械维修</strong> </a> <br>
                  <a href="/104006-0-0.htm" target="_top"> 稳定土拌合机维修 </a> <a href="/104005-0-0.htm" target="_top"> 铣刨机维修 </a> <a href="/104008-0-0.htm" target="_top"> 稳定土厂拌设备维修 </a> <a href="/104007-0-0.htm" target="_top"> 沥青混合料搅拌设备维修 </a> <a href="/104009-0-0.htm" target="_top"> 沥青搅拌站维修 </a> <a href="/104004-0-0.htm" target="_top"> 其它路面机械维修 </a> <a href="/104001-0-0.htm" target="_top"> 摊铺机维修 </a> <a href="/104002-0-0.htm" target="_top"> 养护机械维修 </a> </div>
                <div class="pllist"> <a href="/105-0-0.htm" class="plfl" target="_top"> <strong style="color:#3355AC">桩工机械维修</strong> </a> <br>
                  <a href="/105017-0-0.htm" target="_top"> 强夯机维修 </a> <a href="/105018-0-0.htm" target="_top"> 长螺旋钻孔机维修 </a> <a href="/105009-0-0.htm" target="_top"> 液压静力压桩机维修 </a> <a href="/105019-0-0.htm" target="_top"> 多功能钻机维修 </a> <a href="/105007-0-0.htm" target="_top"> 连续墙抓斗维修 </a> <a href="/105028-0-0.htm" target="_top"> 截桩机/破桩机维修 </a> <a href="/105011-0-0.htm" target="_top"> 打桩机维修 </a> <a href="/105016-0-0.htm" target="_top"> 连续墙钻机维修 </a> <a href="/105015-0-0.htm" target="_top"> 打桩锤维修 </a> <a href="/105027-0-0.htm" target="_top"> 其它桩工机械维修 </a> <a href="/105026-0-0.htm" target="_top"> 多轴钻孔机维修 </a> <a href="/105013-0-0.htm" target="_top"> 液压步履式桩架维修 </a> <a href="/105003-0-0.htm" target="_top"> 旋挖钻机维修 </a> <a href="/105004-0-0.htm" target="_top"> 潜孔钻机维修 </a> <a href="/105005-0-0.htm" target="_top"> 水平定向钻维修 </a> </div>
                <div class="pllist"> <a href="/106-0-0.htm" class="plfl" target="_top"> <strong style="color:#3355AC">压实机械维修 </strong></a> <br>
                  <a href="/106004-0-0.htm" target="_top"> 夯实机维修 </a> <a href="/106003-0-0.htm" target="_top"> 压实机维修 </a> <a href="/106001-0-0.htm" target="_top"> 压路机维修 </a> </div>
                <div class="pllist"> <a href="/107-0-0.htm" class="plfl" target="_top"> <strong style="color:#3355AC">叉车维修</strong> </a> <br>
                  <a href="/107010-0-0.htm" target="_top"> 专用叉车维修 </a> <a href="/107001-0-0.htm" target="_top"> 内燃叉车维修 </a> <a href="/107003-0-0.htm" target="_top"> 电动叉车维修 </a> <a href="/107005-0-0.htm" target="_top"> 仓储叉车维修 </a> </div>
                <div class="pllist"> <a href="/109-0-0.htm" class="plfl" target="_top"> <strong style="color:#3355AC">桥梁机械维修</strong> </a> <br>
                  <a href="/109004-0-0.htm" target="_top"> 提梁机维修 </a> <a href="/109005-0-0.htm" target="_top"> 检测车维修 </a> <a href="/109002-0-0.htm" target="_top"> 运梁车维修 </a> <a href="/109006-0-0.htm" target="_top"> 砂浆车维修 </a> <a href="/109001-0-0.htm" target="_top"> 架桥机维修 </a> </div>
                <div class="pllist"> <a href="/110-0-0.htm" class="plfl" target="_top"> <strong style="color:#3355AC">地下及矿山机械维修</strong> </a> <br>
                  <a href="/110010-0-0.htm" target="_top"> 凿岩钻车维修 </a> <a href="/110008-0-0.htm" target="_top"> 凿岩台车维修 </a> <a href="/110009-0-0.htm" target="_top"> 破碎机维修 </a> <a href="/110011-0-0.htm" target="_top"> 凿岩机和钻机维修 </a> <a href="/110012-0-0.htm" target="_top"> 筛分机维修 </a> <a href="/110013-0-0.htm" target="_top"> 装载及搬运设备维修 </a> <a href="/110014-0-0.htm" target="_top"> 连续采煤机和隧道掘进机维修 </a> <a href="/110005-0-0.htm" target="_top"> 采煤机维修 </a> <a href="/110015-0-0.htm" target="_top"> 输送和辅助设备维修 </a> <a href="/110002-0-0.htm" target="_top"> 矿用掘进机维修 </a> <a href="/110016-0-0.htm" target="_top"> 全液压凿岩钻机维修 </a> <a href="/110017-0-0.htm" target="_top"> 隧道轨道设备维修 </a> <a href="/110001-0-0.htm" target="_top"> 盾构掘进机维修 </a> </div>
                <div class="pllist"> <a href="/111-0-0.htm" class="plfl" target="_top"> <strong style="color:#3355AC">港口机械维修</strong> </a> <br>
                  <a href="/111003-0-0.htm" target="_top"> 吊具维修 </a> <a href="/111001-0-0.htm" target="_top"> 正面吊维修 </a> <a href="/111002-0-0.htm" target="_top"> 堆高机维修 </a> <a href="/111007-0-0.htm" target="_top"> 推耙机维修 </a> <a href="/111006-0-0.htm" target="_top"> 场桥维修 </a> </div>
                <div class="pllist"> <a href="/113-0-0.htm" class="plfl" target="_top"><strong style="color:#3355AC"> 破碎设备维修</strong> </a> <br>
                  <a href="/113002-0-0.htm" target="_top"> 液压剪维修 </a> <a href="/113001-0-0.htm" target="_top"> 破碎锤维修 </a> </div>
                <div class="pllist"> <a href="/118-0-0.htm" class="plfl" target="_top"><strong style="color:#3355AC"> 专用汽车维修</strong> </a> <br>
                  <a href="/118004-0-0.htm" target="_top"> 牵引车维修 </a> <a href="/118002-0-0.htm" target="_top"> 专用车辆维修 </a> <a href="/118003-0-0.htm" target="_top"> 消防车维修 </a> </div>
                <div class="pllist"> <a href="/119-0-0.htm" class="plfl" target="_top"><strong style="color:#3355AC"> 煤炭机械维修</strong> </a> <br>
                  <a href="/119001-0-0.htm" target="_top"> 煤炭机械维修 </a> </div>
              </div>
            </dd>
          </li>
          <li class="cblist">
            <dt> 品牌 </dt>
            <dd> <a class="select" href="/0-0-0.htm">不限</a> <a href="/0-0-133.htm">三一</a> <a href="/0-0-182.htm">小松</a> <a href="/0-0-192.htm">斗山</a> <a href="/0-0-184.htm">日立</a> <a href="/0-0-183.htm">神钢</a> <a href="/0-0-175.htm">沃尔沃</a> <a href="/0-0-174.htm">卡特彼勒</a> <a href="/0-0-146.htm">玉柴重工</a> <a href="/0-0-136.htm">柳工</a> <a href="/0-0-194.htm">现代京城</a> <a href="/0-0-134.htm">中联重科</a> <a href="/0-0-209.htm">徐工</a> <a href="/0-0-139.htm">厦工</a> <a href="/0-0-135.htm">龙工</a> <a href="/0-0-141.htm">福田雷沃</a> <a href="/0-0-137.htm">临工</a> <a href="/0-0-144.htm">山推</a> <a href="/0-0-152.htm">山重建机</a> <a href="/0-0-189.htm">加藤</a> <a href="/0-0-455.htm">凯斯</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 660px;">
                <div class="pllist"> <a class="plfl"> <span style="color:#3355AC"> A-B-C-D-E-F-G</span> </a><br>
                  <a href="/0-0-1185.htm" target="_top">阿尔多</a> <a href="/0-0-1185.htm" target="_top">阿尔多机械</a> <a href="/0-0-180.htm" target="_top">阿特拉斯</a> <a href="/0-0-482.htm" target="_top">阿特拉斯·科普柯</a> <a href="/0-0-402.htm" target="_top">艾迪</a> <a href="/0-0-772.htm" target="_top">艾思博</a> <a href="/0-0-14236.htm" target="_top">安鼎重工</a> <a href="/0-0-1710.htm" target="_top">安迈</a> <a href="/0-0-1169.htm" target="_top">安丘通用机械</a> <a href="/0-0-13271.htm" target="_top">奥津</a> <a href="/0-0-1778.htm" target="_top">奥盛特重工</a> <a href="/0-0-13272.htm" target="_top">奥泰</a> <a href="/0-0-484.htm" target="_top">八达</a> <a href="/0-0-791.htm" target="_top">八达重工</a> <a href="/0-0-13557.htm" target="_top">巴里巴</a> <a href="/0-0-1108.htm" target="_top">百财东洋</a> <a href="/0-0-13562.htm" target="_top">百巨建机</a> <a href="/0-0-13560.htm" target="_top">百开</a> <a href="/0-0-13565.htm" target="_top">百力克</a> <a href="/0-0-1168.htm" target="_top">百脉建机</a> <a href="/0-0-478.htm" target="_top">邦立重机</a> <a href="/0-0-13569.htm" target="_top">宝达</a> <a href="/0-0-13570.htm" target="_top">宝鼎</a> <a href="/0-0-1715.htm" target="_top">宝骊</a> <a href="/0-0-13550.htm" target="_top">宝马格</a> <a href="/0-0-13558.htm" target="_top">宝象</a> <a href="/0-0-13567.htm" target="_top">暴风雪</a> <a href="/0-0-1093.htm" target="_top">北车重工</a> <a href="/0-0-14144.htm" target="_top">北方红阳</a> <a href="/0-0-167.htm" target="_top">北方交通</a> <a href="/0-0-13551.htm" target="_top">北京加隆</a> <a href="/0-0-186.htm" target="_top">北起多田野</a> <a href="/0-0-1714.htm" target="_top">北山机械</a> <a href="/0-0-420.htm" target="_top">贝力特</a> <a href="/0-0-13556.htm" target="_top">贝司特</a> <a href="/0-0-13568.htm" target="_top">泵虎</a> <a href="/0-0-13553.htm" target="_top">边宁荷夫</a> <a href="/0-0-13566.htm" target="_top">滨州钻机</a> <a href="/0-0-13552.htm" target="_top">波坦</a> <a href="/0-0-13571.htm" target="_top">波特重工</a> <a href="/0-0-13559.htm" target="_top">博德</a> <a href="/0-0-1206.htm" target="_top">博汇机械</a> <a href="/0-0-13555.htm" target="_top">博纳地</a> <a href="/0-0-13624.htm" target="_top">博洋</a> <a href="/0-0-683.htm" target="_top">德国宝峨</a> <a href="/0-0-1703.htm" target="_top">甘肃宝龙</a> <a href="/0-0-825.htm" target="_top">湖南搏浪沙</a> <a href="/0-0-13231.htm" target="_top">天地奔牛</a> <a href="/0-0-1108.htm" target="_top">烟台百财</a> <a href="/0-0-1108.htm" target="_top">翼龙</a> <a href="/0-0-13093.htm" target="_top">重庆博山</a> <a href="/0-0-13572.htm" target="_top">沧田重工</a> <a href="/0-0-13575.htm" target="_top">昌世</a> <a href="/0-0-13578.htm" target="_top">长春神骏</a> <a href="/0-0-13142.htm" target="_top">长高一品</a> <a href="/0-0-13579.htm" target="_top">长盛机械</a> <a href="/0-0-615.htm" target="_top">长阳机械</a> <a href="/0-0-148.htm" target="_top">常林股份</a> <a href="/0-0-485.htm" target="_top">朝工</a> <a href="/0-0-13576.htm" target="_top">朝阳建工</a> <a href="/0-0-13574.htm" target="_top">郴筑</a> <a href="/0-0-145.htm" target="_top">成工</a> <a href="/0-0-1591.htm" target="_top">楚工龙泰</a> <a href="/0-0-13573.htm" target="_top">创一</a> <a href="/0-0-13094.htm" target="_top">桂林长海</a> <a href="/0-0-615.htm" target="_top">杭州永林</a> <a href="/0-0-13174.htm" target="_top">湖南长河</a> <a href="/0-0-147.htm" target="_top">四川长起</a> <a href="/0-0-1716.htm" target="_top">达刚</a> <a href="/0-0-13587.htm" target="_top">达力</a> <a href="/0-0-13580.htm" target="_top">达宇重工</a> <a href="/0-0-162.htm" target="_top">大地</a> <a href="/0-0-13584.htm" target="_top">大方</a> <a href="/0-0-13592.htm" target="_top">大宏立</a> <a href="/0-0-13586.htm" target="_top">大连</a> <a href="/0-0-13589.htm" target="_top">大山路桥</a> <a href="/0-0-171.htm" target="_top">大信重工</a> <a href="/0-0-212.htm" target="_top">戴纳派克</a> <a href="/0-0-1243.htm" target="_top">道辰格</a> <a href="/0-0-1218.htm" target="_top">道胜</a> <a href="/0-0-13588.htm" target="_top">道维施</a> <a href="/0-0-151.htm" target="_top">德工</a> <a href="/0-0-489.htm" target="_top">德基机械</a> <a href="/0-0-13597.htm" target="_top">德科达</a> <a href="/0-0-213.htm" target="_top">德玛格</a> <a href="/0-0-13598.htm" target="_top">德通</a> <a href="/0-0-13595.htm" target="_top">德亿重工</a> <a href="/0-0-140.htm" target="_top">鼎盛重工</a> <a href="/0-0-14222.htm" target="_top">东倡机械</a> <a href="/0-0-1351.htm" target="_top">东达</a> <a href="/0-0-1351.htm" target="_top">东达桩工</a> <a href="/0-0-1763.htm" target="_top">东德重工</a> <a href="/0-0-1187.htm" target="_top">东方红</a> <a href="/0-0-13591.htm" target="_top">东方冶矿</a> <a href="/0-0-1755.htm" target="_top">东风</a> <a href="/0-0-405.htm" target="_top">东空</a> <a href="/0-0-14169.htm" target="_top">东立机械</a> <a href="/0-0-13583.htm" target="_top">东泷</a> <a href="/0-0-13590.htm" target="_top">东蒙机械</a> <a href="/0-0-1717.htm" target="_top">东南机械</a> <a href="/0-0-163.htm" target="_top">东岳重工</a> <a href="/0-0-1098.htm" target="_top">斗昌</a> <a href="/0-0-192.htm" target="_top">斗山</a> <a href="/0-0-1122.htm" target="_top">山东大汉</a> <a href="/0-0-1195.htm" target="_top">重庆大江</a> <a href="/0-0-671.htm" target="_top">方圆集团</a> <a href="/0-0-1120.htm" target="_top">丰汇技术</a> <a href="/0-0-1729.htm" target="_top">丰田</a> <a href="/0-0-1188.htm" target="_top">福大机械</a> <a href="/0-0-215.htm" target="_top">福格勒</a> <a href="/0-0-1183.htm" target="_top">福工</a> <a href="/0-0-141.htm" target="_top">福田雷沃</a> <a href="/0-0-141.htm" target="_top">福田雷沃重工</a> <a href="/0-0-1208.htm" target="_top">福威重工</a> <a href="/0-0-165.htm" target="_top">抚顺起重机</a> <a href="/0-0-164.htm" target="_top">抚挖</a> <a href="/0-0-1225.htm" target="_top">抚挖锦重</a> <a href="/0-0-1721.htm" target="_top">富豪</a> <a href="/0-0-1888.htm" target="_top">富亿机械</a> <a href="/0-0-1124.htm" target="_top">富友正和</a> <a href="/0-0-13630.htm" target="_top">湖南飞涛</a> <a href="/0-0-682.htm" target="_top">山东福临</a> <a href="/0-0-14252.htm" target="_top">冈研</a> <a href="/0-0-13604.htm" target="_top">高达</a> <a href="/0-0-492.htm" target="_top">高马科</a> <a href="/0-0-534.htm" target="_top">高远路业</a> <a href="/0-0-1754.htm" target="_top">高远圣工</a> <a href="/0-0-13606.htm" target="_top">格鲁夫</a> <a href="/0-0-477.htm" target="_top">格瑞德</a> <a href="/0-0-13603.htm" target="_top">格瑞特</a> <a href="/0-0-423.htm" target="_top">工兵</a> <a href="/0-0-776.htm" target="_top">工兵国际</a> <a href="/0-0-417.htm" target="_top">古河</a> <a href="/0-0-13605.htm" target="_top">谷登机械</a> <a href="/0-0-424.htm" target="_top">广林</a> <a href="/0-0-1116.htm" target="_top">广西建机</a> <a href="/0-0-13608.htm" target="_top">国发</a> <a href="/0-0-1369.htm" target="_top">国机重工</a> <a href="/0-0-776.htm" target="_top">连云港工兵</a> <a href="/0-0-776.htm" target="_top">连云港工兵GBPSC</a> </div>
                <div class="pllist"> <a class="plfl"> <span style="color:#3355AC">H-I-J-K-L-M-N</span> </a> <br>
                  <a href="0-0-1109.htm" target="_top">海斗</a> <a href="0-0-13611.htm" target="_top">海华筑机</a> <a href="0-0-203.htm" target="_top">海诺</a> <a href="0-0-1091.htm" target="_top">海山</a> <a href="0-0-1733.htm" target="_top">海斯特</a> <a href="0-0-1105.htm" target="_top">海特</a> <a href="0-0-13620.htm" target="_top">海天路矿</a> <a href="0-0-1128.htm" target="_top">海威斯帝尔</a> <a href="0-0-664.htm" target="_top">海州机械</a> <a href="0-0-415.htm" target="_top">韩川</a> <a href="0-0-1112.htm" target="_top">韩工</a> <a href="0-0-14253.htm" target="_top">韩农</a> <a href="0-0-421.htm" target="_top">韩宇</a> <a href="0-0-216.htm" target="_top">悍马</a> <a href="0-0-426.htm" target="_top">悍狮</a> <a href="0-0-814.htm" target="_top">捍宇</a> <a href="0-0-1734.htm" target="_top">杭叉</a> <a href="0-0-13628.htm" target="_top">杭重威施诺</a> <a href="0-0-1724.htm" target="_top">杭州市政</a> <a href="0-0-1525.htm" target="_top">合矿</a> <a href="0-0-158.htm" target="_top">合力</a> <a href="0-0-13632.htm" target="_top">和盛达</a> <a href="0-0-1103.htm" target="_top">黑金钢</a> <a href="0-0-13623.htm" target="_top">恒端</a> <a href="0-0-13641.htm" target="_top">恒康</a> <a href="0-0-1761.htm" target="_top">恒诺机械</a> <a href="0-0-1508.htm" target="_top">恒日重工</a> <a href="0-0-1735.htm" target="_top">恒润高科</a> <a href="0-0-13614.htm" target="_top">恒升</a> <a href="0-0-170.htm" target="_top">恒特</a> <a href="0-0-1147.htm" target="_top">恒天九五</a> <a href="0-0-13636.htm" target="_top">恒兴机械</a> <a href="0-0-13096.htm" target="_top">恒至凿岩</a> <a href="0-0-13613.htm" target="_top">红旗</a> <a href="0-0-13639.htm" target="_top">宏昌</a> <a href="0-0-13633.htm" target="_top">宏达</a> <a href="0-0-13609.htm" target="_top">宏大</a> <a href="0-0-13629.htm" target="_top">宏建机械</a> <a href="0-0-13618.htm" target="_top">宏力</a> <a href="0-0-217.htm" target="_top">鸿达</a> <a href="0-0-202.htm" target="_top">鸿得利重工</a> <a href="0-0-13626.htm" target="_top">鸿源</a> <a href="0-0-819.htm" target="_top">虎霸集团</a> <a href="0-0-13617.htm" target="_top">虎力</a> <a href="0-0-13577.htm" target="_top">华贝尔</a> <a href="0-0-13627.htm" target="_top">华丰</a> <a href="0-0-13634.htm" target="_top">华光机械</a> <a href="0-0-206.htm" target="_top">华力重工</a> <a href="0-0-13640.htm" target="_top">华南重工</a> <a href="0-0-1725.htm" target="_top">华骐</a> <a href="0-0-1727.htm" target="_top">华强京工</a> <a href="0-0-1731.htm" target="_top">华山</a> <a href="0-0-1220.htm" target="_top">华通动力</a> <a href="0-0-1526.htm" target="_top">华伟重工</a> <a href="0-0-1512.htm" target="_top">华中建机</a> <a href="0-0-13625.htm" target="_top">华重</a> <a href="0-0-13622.htm" target="_top">惠工</a> <a href="0-0-14283.htm" target="_top">惠龙机械</a> <a href="0-0-13616.htm" target="_top">惠山</a> <a href="0-0-203.htm" target="_top">辽宁海诺</a> <a href="0-0-845.htm" target="_top">宁波韩锐</a> <a href="0-0-217.htm" target="_top">山东鸿达</a> <a href="0-0-1176.htm" target="_top">威海海泰</a> <a href="0-0-14111.htm" target="_top">无锡环球</a> <a href="0-0-893.htm" target="_top">烟台海德</a> <a href="0-0-1091.htm" target="_top">烟台海山</a> <a href="0-0-177.htm" target="_top">JCB</a> <a href="0-0-1127.htm" target="_top">甘肃建工</a> <a href="0-0-1159.htm" target="_top">广州京龙</a> <a href="0-0-554.htm" target="_top">吉公</a> <a href="0-0-1524.htm" target="_top">吉尼</a> <a href="0-0-1229.htm" target="_top">吉星</a> <a href="0-0-1157.htm" target="_top">济南吉宏</a> <a href="0-0-1179.htm" target="_top">济南建机</a> <a href="0-0-13655.htm" target="_top">冀中能源</a> <a href="0-0-189.htm" target="_top">加藤</a> <a href="0-0-13645.htm" target="_top">佳乐</a> <a href="0-0-13654.htm" target="_top">佳一</a> <a href="0-0-1145.htm" target="_top">佳弋建机</a> <a href="0-0-13656.htm" target="_top">嘉成</a> <a href="0-0-13176.htm" target="_top">嘉和重工</a> <a href="0-0-407.htm" target="_top">甲南</a> <a href="0-0-1352.htm" target="_top">建德机械</a> <a href="0-0-13659.htm" target="_top">建丰机械</a> <a href="0-0-1736.htm" target="_top">建研机械</a> <a href="0-0-1357.htm" target="_top">建友机械</a> <a href="0-0-479.htm" target="_top">江淮重工</a> <a href="0-0-13643.htm" target="_top">江加</a> <a href="0-0-487.htm" target="_top">江麓</a> <a href="0-0-816.htm" target="_top">江苏骏马</a> <a href="0-0-13647.htm" target="_top">江苏路通</a> <a href="0-0-1355.htm" target="_top">矫马</a> <a href="0-0-13657.htm" target="_top">金城</a> <a href="0-0-13651.htm" target="_top">金茂</a> <a href="0-0-13653.htm" target="_top">金源</a> <a href="0-0-1737.htm" target="_top">金正神力</a> <a href="0-0-1132.htm" target="_top">锦城建机</a> <a href="0-0-1586.htm" target="_top">劲工</a> <a href="0-0-172.htm" target="_top">晋工</a> <a href="0-0-1759.htm" target="_top">京城长野</a> <a href="0-0-166.htm" target="_top">京城重工</a> <a href="0-0-401.htm" target="_top">惊天液压</a> <a href="0-0-13649.htm" target="_top">精功</a> <a href="0-0-13650.htm" target="_top">靖江（JJCC）</a> <a href="0-0-187.htm" target="_top">久保田</a> <a href="0-0-1232.htm" target="_top">久工</a> <a href="0-0-13652.htm" target="_top">久润</a> <a href="0-0-197.htm" target="_top">酒井</a> <a href="0-0-1193.htm" target="_top">巨超重工</a> <a href="0-0-13648.htm" target="_top">聚龙</a> <a href="0-0-679.htm" target="_top">军恒斯帕克</a> <a href="0-0-1142.htm" target="_top">娄底南方</a> <a href="0-0-1094.htm" target="_top">上海工程机械厂</a> <a href="0-0-1130.htm" target="_top">无锡巨神</a> <a href="0-0-681.htm" target="_top">浙江军联</a> <a href="0-0-1135.htm" target="_top">包头凯捷</a> <a href="0-0-160.htm" target="_top">广西开元</a> <a href="0-0-13667.htm" target="_top">卡萨阁蓝地</a> <a href="0-0-174.htm" target="_top">卡特彼勒</a> <a href="0-0-178.htm" target="_top">卡特重工</a> <a href="0-0-14247.htm" target="_top">开普动力</a> <a href="0-0-1322.htm" target="_top">凯雷</a> <a href="0-0-13661.htm" target="_top">凯联</a> <a href="0-0-480.htm" target="_top">凯莫尔</a> <a href="0-0-455.htm" target="_top">凯斯</a> <a href="0-0-1756.htm" target="_top">凯威</a> <a href="0-0-13682.htm" target="_top">凯兴</a> <a href="0-0-1118.htm" target="_top">科曼萨 杰牌</a> <a href="0-0-13664.htm" target="_top">科尼乐重工</a> <a href="0-0-13663.htm" target="_top">科泰重工</a> <a href="0-0-14243.htm" target="_top">科友机械</a> <a href="0-0-13666.htm" target="_top">科筑</a> <a href="0-0-1779.htm" target="_top">克拉士</a> <a href="0-0-13665.htm" target="_top">克瑞</a> <a href="0-0-14265.htm" target="_top">孔山重工</a> <a href="0-0-13668.htm" target="_top">坤宇重装</a> <a href="0-0-1144.htm" target="_top">昆明力神</a> <a href="0-0-13705.htm" target="_top">青岛科尼乐</a> <a href="0-0-824.htm" target="_top">6409塔吊</a> <a href="0-0-13631.htm" target="_top">河南路畅</a> <a href="0-0-13097.htm" target="_top">莱工</a> <a href="0-0-1194.htm" target="_top">蓝翔重工</a> <a href="0-0-543.htm" target="_top">雷奥科技</a> <a href="0-0-1718.htm" target="_top">雷萨重机</a> <a href="0-0-13681.htm" target="_top">黎明</a> <a href="0-0-412.htm" target="_top">力博士</a> <a href="0-0-13678.htm" target="_top">力尔美</a> <a href="0-0-13683.htm" target="_top">力士</a> <a href="0-0-157.htm" target="_top">力士德</a> <a href="0-0-13687.htm" target="_top">立藤</a> <a href="0-0-13676.htm" target="_top">立新</a> <a href="0-0-179.htm" target="_top">利勃海尔</a> <a href="0-0-13677.htm" target="_top">利洲</a> <a href="0-0-13684.htm" target="_top">联丰机械</a> <a href="0-0-13686.htm" target="_top">辽原筑机</a> <a href="0-0-204.htm" target="_top">辽筑</a> <a href="0-0-1742.htm" target="_top">林德</a> <a href="0-0-13680.htm" target="_top">林泰阁</a> <a href="0-0-137.htm" target="_top">临工</a> <a href="0-0-1509.htm" target="_top">灵升机械</a> <a href="0-0-1181.htm" target="_top">凌虹建设机械</a> <a href="0-0-1180.htm" target="_top">凌云建机</a> <a href="0-0-136.htm" target="_top">柳工</a> <a href="0-0-135.htm" target="_top">龙工</a> <a href="0-0-14233.htm" target="_top">龙兴机械</a> <a href="0-0-1739.htm" target="_top">鲁青</a> <a href="0-0-14257.htm" target="_top">鲁宇重工</a> <a href="0-0-688.htm" target="_top">鲁岳</a> <a href="0-0-207.htm" target="_top">陆德筑机</a> <a href="0-0-13688.htm" target="_top">路宝</a> <a href="0-0-13679.htm" target="_top">路达</a> <a href="0-0-13669.htm" target="_top">路大</a> <a href="0-0-13673.htm" target="_top">路德克</a> <a href="0-0-13670.htm" target="_top">路虹</a> <a href="0-0-13675.htm" target="_top">路维</a> <a href="0-0-13674.htm" target="_top">路星</a> <a href="0-0-552.htm" target="_top">绿地</a> <a href="0-0-1709.htm" target="_top">滦州重工</a> <a href="0-0-1231.htm" target="_top">洛建</a> <a href="0-0-673.htm" target="_top">洛阳路通</a> <a href="0-0-13118.htm" target="_top">山东鲁工</a> <a href="0-0-1509.htm" target="_top">厦门灵升</a> <a href="0-0-1231.htm" target="_top">一拖</a> <a href="0-0-13689.htm" target="_top">玛连尼</a> <a href="0-0-418.htm" target="_top">麦恩</a> <a href="0-0-13693.htm" target="_top">曼尼通</a> <a href="0-0-14262.htm" target="_top">曼托瓦尼</a> <a href="0-0-13692.htm" target="_top">梅狮</a> <a href="0-0-1743.htm" target="_top">美科斯</a> <a href="0-0-13095.htm" target="_top">美通筑机</a> <a href="0-0-13696.htm" target="_top">美卓</a> <a href="0-0-422.htm" target="_top">猛士</a> <a href="0-0-13697.htm" target="_top">闽工</a> <a href="0-0-13691.htm" target="_top">闽科</a> <a href="0-0-13737.htm" target="_top">明山路桥</a> <a href="0-0-1125.htm" target="_top">明威塔机</a> <a href="0-0-13694.htm" target="_top">摩纳凯</a> <a href="0-0-1126.htm" target="_top">牡丹江</a> <a href="0-0-13695.htm" target="_top">牡丹江专用汽车</a> <a href="0-0-13700.htm" target="_top">纳科重工</a> <a href="0-0-1209.htm" target="_top">南车北京时代</a> <a href="0-0-200.htm" target="_top">南方路机</a> <a href="0-0-1134.htm" target="_top">南京绿野</a> <a href="0-0-13698.htm" target="_top">南侨</a> <a href="0-0-169.htm" target="_top">南特</a> <a href="0-0-1748.htm" target="_top">农友</a> <a href="0-0-14186.htm" target="_top">诺尔</a> <a href="0-0-1585.htm" target="_top">诺克机械</a> <a href="0-0-13699.htm" target="_top">诺力</a> <a href="0-0-1585.htm" target="_top">诺森机械</a> </div>
                <div class="pllist"> <a class="plfl"> <span style="color:#3355AC"> O-P-Q-R-S-T </span></a><br>
                  <a href="0-0-13702.htm" target="_top">欧霸重工</a> <a href="0-0-13701.htm" target="_top">欧亚机械</a> <a href="0-0-199.htm" target="_top">普茨迈斯特</a> <a href="0-0-403.htm" target="_top">普堃韩泰克</a> <a href="0-0-486.htm" target="_top">普什重机</a> <a href="0-0-14217.htm" target="_top">三一帕尔菲格</a> <a href="0-0-156.htm" target="_top">上海彭浦</a> <a href="0-0-1184.htm" target="_top">奇瑞迪凯重科</a> <a href="0-0-14232.htm" target="_top">千里马</a> <a href="0-0-582.htm" target="_top">勤牛</a> <a href="0-0-13708.htm" target="_top">青山</a> <a href="0-0-1750.htm" target="_top">全工机械</a> <a href="0-0-198.htm" target="_top">全进重工</a> <a href="0-0-13704.htm" target="_top">泉成机械</a> <a href="0-0-13706.htm" target="_top">泉工</a> <a href="0-0-13703.htm" target="_top">泉筑</a> <a href="0-0-13707.htm" target="_top">群峰智能</a> <a href="0-0-1139.htm" target="_top">四川强力</a> <a href="0-0-686.htm" target="_top">厦门七天阳</a> <a href="0-0-196.htm" target="_top">日工</a> <a href="0-0-184.htm" target="_top">日立</a> <a href="0-0-173.htm" target="_top">熔盛机械</a> <a href="0-0-409.htm" target="_top">锐马</a> <a href="0-0-425.htm" target="_top">瑞工</a> <a href="0-0-13709.htm" target="_top">瑞龙重工(欧盟技术)</a> <a href="0-0-1216.htm" target="_top">瑞诺</a> <a href="0-0-14211.htm" target="_top">润邦机械</a> <a href="0-0-14281.htm" target="_top">若鞍亿科技</a> <a href="0-0-805.htm" target="_top">烟台锐泰</a> <a href="0-0-810.htm" target="_top">烟台润弘</a> <a href="0-0-741.htm" target="_top">江苏上騏</a> <a href="0-0-13724.htm" target="_top">赛格玛</a> <a href="0-0-1762.htm" target="_top">赛力斯特</a> <a href="0-0-13717.htm" target="_top">赛奇</a> <a href="0-0-868.htm" target="_top">赛通重工</a> <a href="0-0-14248.htm" target="_top">赛宇重工</a> <a href="0-0-14187.htm" target="_top">三驾机械</a> <a href="0-0-13740.htm" target="_top">三力机械</a> <a href="0-0-13749.htm" target="_top">三笠</a> <a href="0-0-13732.htm" target="_top">三联机械</a> <a href="0-0-13721.htm" target="_top">三菱</a> <a href="0-0-13748.htm" target="_top">三隆重工</a> <a href="0-0-13725.htm" target="_top">三洋重工</a> <a href="0-0-133.htm" target="_top">三一</a> <a href="0-0-1711.htm" target="_top">扫地王</a> <a href="0-0-1711.htm" target="_top">扫地王集团</a> <a href="0-0-626.htm" target="_top">森田重机</a> <a href="0-0-13730.htm" target="_top">森源</a> <a href="0-0-13713.htm" target="_top">森远</a> <a href="0-0-1221.htm" target="_top">山宝</a> <a href="0-0-14280.htm" target="_top">山东海宏</a> <a href="0-0-1123.htm" target="_top">山东华夏</a> <a href="0-0-13744.htm" target="_top">山东汇强</a> <a href="0-0-13747.htm" target="_top">山东明龙</a> <a href="0-0-1722.htm" target="_top">山东威猛</a> <a href="0-0-138.htm" target="_top">山工</a> <a href="0-0-142.htm" target="_top">山河智能</a> <a href="0-0-454.htm" target="_top">山猫</a> <a href="0-0-13731.htm" target="_top">山美</a> <a href="0-0-1304.htm" target="_top">山特维克</a> <a href="0-0-144.htm" target="_top">山推</a> <a href="0-0-13723.htm" target="_top">山推格林</a> <a href="0-0-1207.htm" target="_top">山挖重工</a> <a href="0-0-152.htm" target="_top">山重建机</a> <a href="0-0-668.htm" target="_top">陕建机械</a> <a href="0-0-1753.htm" target="_top">陕汽</a> <a href="0-0-13728.htm" target="_top">陕西科尼乐</a> <a href="0-0-691.htm" target="_top">上海华建</a> <a href="0-0-13735.htm" target="_top">上海建冶</a> <a href="0-0-201.htm" target="_top">上海金泰</a> <a href="0-0-211.htm" target="_top">上海施维英</a> <a href="0-0-13733.htm" target="_top">上海威力特</a> <a href="0-0-13715.htm" target="_top">上海西芝</a> <a href="0-0-13718.htm" target="_top">上力重工</a> <a href="0-0-1113.htm" target="_top">神斧</a> <a href="0-0-183.htm" target="_top">神钢</a> <a href="0-0-1523.htm" target="_top">神马科技</a> <a href="0-0-14235.htm" target="_top">神娃机械</a> <a href="0-0-13746.htm" target="_top">沈阳广成</a> <a href="0-0-830.htm" target="_top">沈阳三洋</a> <a href="0-0-1720.htm" target="_top">沈阳山河</a> <a href="0-0-1090.htm" target="_top">盛利达</a> <a href="0-0-618.htm" target="_top">盛隆</a> <a href="0-0-190.htm" target="_top">石川岛</a> <a href="0-0-168.htm" target="_top">石煤</a> <a href="0-0-13727.htm" target="_top">世邦</a> <a href="0-0-14255.htm" target="_top">世工机械</a> <a href="0-0-13710.htm" target="_top">世联</a> <a href="0-0-14251.htm" target="_top">世鑫源机械</a> <a href="0-0-413.htm" target="_top">世运</a> <a href="0-0-13711.htm" target="_top">仕高玛</a> <a href="0-0-13714.htm" target="_top">首钢泰晟</a> <a href="0-0-13719.htm" target="_top">双力</a> <a href="0-0-13745.htm" target="_top">双牛</a> <a href="0-0-419.htm" target="_top">水山</a> <a href="0-0-14300.htm" target="_top">水山（民盛）</a> <a href="0-0-13729.htm" target="_top">思嘉特</a> <a href="0-0-13751.htm" target="_top">思拓瑞克</a> <a href="0-0-13722.htm" target="_top">斯贝柯</a> <a href="0-0-1102.htm" target="_top">斯达格思</a> <a href="0-0-14279.htm" target="_top">斯泰克</a> <a href="0-0-1117.htm" target="_top">四川建机</a> <a href="0-0-13742.htm" target="_top">四通重工</a> <a href="0-0-13739.htm" target="_top">嵩山重工</a> <a href="0-0-868.htm" target="_top">徐州赛通</a> <a href="0-0-1227.htm" target="_top">中国现代</a> <a href="0-0-1138.htm" target="_top">重庆升力</a> <a href="0-0-14221.htm" target="_top">TCM</a> <a href="0-0-774.htm" target="_top">长沙天为</a> <a href="0-0-1719.htm" target="_top">德威土行孙</a> <a href="0-0-14261.htm" target="_top">江苏泰信</a> <a href="0-0-827.htm" target="_top">上海腾迈</a> <a href="0-0-1730.htm" target="_top">台励福</a> <a href="0-0-538.htm" target="_top">太腾机械</a> <a href="0-0-1728.htm" target="_top">泰安鲁能</a> <a href="0-0-404.htm" target="_top">泰戈</a> <a href="0-0-406.htm" target="_top">泰科</a> <a href="0-0-1353.htm" target="_top">泰石克</a> <a href="0-0-176.htm" target="_top">特雷克斯</a> <a href="0-0-476.htm" target="_top">天地重工</a> <a href="0-0-13754.htm" target="_top">天顺长城</a> <a href="0-0-13755.htm" target="_top">天宇</a> <a href="0-0-13752.htm" target="_top">田中铁工</a> <a href="0-0-620.htm" target="_top">铁兵</a> <a href="0-0-1758.htm" target="_top">铁建重工</a> <a href="0-0-218.htm" target="_top">铁拓机械</a> <a href="0-0-1726.htm" target="_top">通亚汽车</a> <a href="0-0-1211.htm" target="_top">同力重工</a> <a href="0-0-13753.htm" target="_top">土力机械</a> <a href="0-0-210.htm" target="_top">拓能重机</a> <a href="0-0-1760.htm" target="_top">无锡泰特</a> </div>
                <div class="pllist"> <a class="plfl"> <span style="color:#3355AC"> U-V-W-X-Y-Z</span></a> <br>
                  <a href="0-0-614.htm" target="_top">万邦重科</a> <a href="0-0-1140.htm" target="_top">威海固恒</a> <a href="0-0-1189.htm" target="_top">威肯</a> <a href="0-0-491.htm" target="_top">威猛</a> <a href="0-0-1738.htm" target="_top">威盛</a> <a href="0-0-14256.htm" target="_top">威源机械</a> <a href="0-0-214.htm" target="_top">维特根</a> <a href="0-0-14263.htm" target="_top">潍柴特种车</a> <a href="0-0-149.htm" target="_top">沃得重工</a> <a href="0-0-662.htm" target="_top">沃尔华</a> <a href="0-0-175.htm" target="_top">沃尔沃</a> <a href="0-0-1160.htm" target="_top">五羊建机</a> <a href="0-0-680.htm" target="_top">宜兴巍宇</a> <a href="0-0-687.htm" target="_top">无锡雪桃</a> <a href="0-0-13778.htm" target="_top">西安路邦</a> <a href="0-0-1589.htm" target="_top">西贝</a> <a href="0-0-13777.htm" target="_top">西尔玛</a> <a href="0-0-13177.htm" target="_top">西林</a> <a href="0-0-623.htm" target="_top">犀牛重工</a> <a href="0-0-13786.htm" target="_top">夏洲重工</a> <a href="0-0-139.htm" target="_top">厦工</a> <a href="0-0-13175.htm" target="_top">厦门金华</a> <a href="0-0-13784.htm" target="_top">厦强</a> <a href="0-0-1744.htm" target="_top">厦盛</a> <a href="0-0-13783.htm" target="_top">厦装</a> <a href="0-0-410.htm" target="_top">先锋</a> <a href="0-0-194.htm" target="_top">现代</a> <a href="0-0-1359.htm" target="_top">现代（山东）</a> <a href="0-0-1741.htm" target="_top">小橋</a> <a href="0-0-182.htm" target="_top">小松</a> <a href="0-0-13787.htm" target="_top">协兴</a> <a href="0-0-13785.htm" target="_top">欣融</a> <a href="0-0-13814.htm" target="_top">新波臣</a> <a href="0-0-1236.htm" target="_top">新天和</a> <a href="0-0-13779.htm" target="_top">新型</a> <a href="0-0-13098.htm" target="_top">新宇机械</a> <a href="0-0-1683.htm" target="_top">新源机械</a> <a href="0-0-690.htm" target="_top">新筑股份</a> <a href="0-0-692.htm" target="_top">鑫国重机</a> <a href="0-0-1235.htm" target="_top">信达</a> <a href="0-0-1097.htm" target="_top">星邦重工</a> <a href="0-0-205.htm" target="_top">星马汽车</a> <a href="0-0-13788.htm" target="_top">雄辉</a> <a href="0-0-209.htm" target="_top">徐工</a> <a href="0-0-1522.htm" target="_top">徐工特机</a> <a href="0-0-150.htm" target="_top">徐挖</a> <a href="0-0-544.htm" target="_top">徐威重科</a> <a href="0-0-1129.htm" target="_top">徐州建机</a> <a href="0-0-867.htm" target="_top">徐州凯尔</a> <a href="0-0-154.htm" target="_top">宣工</a> <a href="0-0-13619.htm" target="_top">雪狼</a> <a href="0-0-14112.htm" target="_top">烟台信人</a> <a href="0-0-1152.htm" target="_top">济南圆鑫</a> <a href="0-0-1643.htm" target="_top">江苏意玛</a> <a href="0-0-14250.htm" target="_top">青岛雅凯</a> <a href="0-0-562.htm" target="_top">山东愚公</a> <a href="0-0-1092.htm" target="_top">山东圆友</a> <a href="0-0-408.htm" target="_top">上海友一</a> <a href="0-0-13805.htm" target="_top">亚工</a> <a href="0-0-13798.htm" target="_top">亚洁</a> <a href="0-0-1148.htm" target="_top">亚特</a> <a href="0-0-155.htm" target="_top">烟工</a> <a href="0-0-191.htm" target="_top">洋马</a> <a href="0-0-13795.htm" target="_top">业豪</a> <a href="0-0-13738.htm" target="_top">一鼎重工</a> <a href="0-0-13803.htm" target="_top">一帆机械</a> <a href="0-0-159.htm" target="_top">一拖</a> <a href="0-0-13800.htm" target="_top">依格曼</a> <a href="0-0-770.htm" target="_top">宜工</a> <a href="0-0-161.htm" target="_top">移山</a> <a href="0-0-13791.htm" target="_top">亿龙机械</a> <a href="0-0-13801.htm" target="_top">亿通正龙</a> <a href="0-0-1749.htm" target="_top">忆辉</a> <a href="0-0-13792.htm" target="_top">易山重工</a> <a href="0-0-13808.htm" target="_top">益鑫</a> <a href="0-0-1751.htm" target="_top">银锚</a> <a href="0-0-13232.htm" target="_top">银起</a> <a href="0-0-13793.htm" target="_top">英达</a> <a href="0-0-1777.htm" target="_top">英轩重工</a> <a href="0-0-1930.htm" target="_top">永安机械</a> <a href="0-0-647.htm" target="_top">永工</a> <a href="0-0-843.htm" target="_top">永茂</a> <a href="0-0-13806.htm" target="_top">尤尼克</a> <a href="0-0-16327.htm" target="_top">友一机械</a> <a href="0-0-562.htm" target="_top">愚公机械</a> <a href="0-0-13802.htm" target="_top">宇泰</a> <a href="0-0-143.htm" target="_top">宇通重工</a> <a href="0-0-146.htm" target="_top">玉柴重工</a> <a href="0-0-13796.htm" target="_top">豫弘重工</a> <a href="0-0-13794.htm" target="_top">原进</a> <a href="0-0-1092.htm" target="_top">圆友</a> <a href="0-0-13799.htm" target="_top">远东</a> <a href="0-0-13736.htm" target="_top">远华机械</a> <a href="0-0-14238.htm" target="_top">约翰迪尔</a> <a href="0-0-13797.htm" target="_top">岳首</a> <a href="0-0-13804.htm" target="_top">粤工</a> <a href="0-0-13807.htm" target="_top">运想重工</a> <a href="0-0-1757.htm" target="_top">安徽中达</a> <a href="0-0-1136.htm" target="_top">江苏正兴</a> <a href="0-0-767.htm" target="_top">凌宇汽车</a> <a href="0-0-13209.htm" target="_top">山东众和</a> <a href="0-0-1095.htm" target="_top">上海振中</a> <a href="0-0-13821.htm" target="_top">泽通</a> <a href="0-0-195.htm" target="_top">詹阳动力</a> <a href="0-0-13811.htm" target="_top">浙江赤道</a> <a href="0-0-1119.htm" target="_top">浙江建机</a> <a href="0-0-14220.htm" target="_top">浙江振中</a> <a href="0-0-13817.htm" target="_top">正泰</a> <a href="0-0-13816.htm" target="_top">郑州鼎盛</a> <a href="0-0-813.htm" target="_top">郑州富岛（川岛）</a> <a href="0-0-13824.htm" target="_top">中材建科</a> <a href="0-0-13810.htm" target="_top">中方机械</a> <a href="0-0-1214.htm" target="_top">中国重汽</a> <a href="0-0-13819.htm" target="_top">中海恒通</a> <a href="0-0-1219.htm" target="_top">中环动力</a> <a href="0-0-1106.htm" target="_top">中集华骏</a> <a href="0-0-13813.htm" target="_top">中际</a> <a href="0-0-1951.htm" target="_top">中建机械</a> <a href="0-0-542.htm" target="_top">中交西筑</a> <a href="0-0-134.htm" target="_top">中联重科</a> <a href="0-0-553.htm" target="_top">中龙建机</a> <a href="0-0-13820.htm" target="_top">中青林</a> <a href="0-0-13812.htm" target="_top">中升</a> <a href="0-0-1131.htm" target="_top">中昇建机</a> <a href="0-0-1682.htm" target="_top">中铁二十局</a> <a href="0-0-1151.htm" target="_top">中文实业</a> <a href="0-0-13823.htm" target="_top">中意</a> <a href="0-0-13815.htm" target="_top">中誉鼎力</a> <a href="0-0-188.htm" target="_top">竹内</a> <a href="0-0-185.htm" target="_top">住友</a> <a href="0-0-13809.htm" target="_top">筑马</a> <a href="0-0-13818.htm" target="_top">钻通</a> </div>
              </div>
            </dd>
          </li>
        </ul>
      </div>
    </form>
    <div class="nseresult_pro pic_searchval">
      <div class="nse_usedate" style="display:none">找到约11105条结果</div>
      <!--维修知识-->
      <div class="rp clearfix mb10 nwx_zxlist repairList border0 mt10">
        <div class="title border04">
          <h3>维修知识</h3>
          <a style=" float:right; padding-right:25px;" href="#">更多</a> </div>
        <div class="content r_add">
          <ul class="list blue">
		<%  
		String title_hl = "";
		for(SolrDocument m : infoList){	
			String id = CommonString.getFormatPara(m.getFieldValue("id"));
			String title = CommonString.getFormatPara(m.getFieldValue("title"));
            String pub_date=CommonString.getFormatPara(m.getFieldValue("pub_date"));
			//if(pub_date.length()>9){pub_date=pub_date.substring(0,9);}else{pub_date="2014";}
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
              <h3 style="width:450px"> <span class="lb">
			  <a target="_blank" href="http://weixiu.21-sun.com/info_232.htm" title="维修" style="color: #ff6600">[维修]</a> </span> 
			  <a target="_blank" href="http://weixiu.21-sun.com/info_232.htm" title="<%=title%>"><%=title%></a></h3>
              <span class="time"><%=pub_date%></span> </li>
           <%}%>
          </ul>
        </div>
      </div>
      <!--产品维修-->
      <div class="rp clearfix mb10 nwx_zxlist repairList border0">
        <div class="title border04">
          <h3>产品维修</h3>
          <a style=" float:right; padding-right:25px;" href="#">更多</a> </div>
        <div class="content r_add">
          <ul class="list blue">
		 <%  
		 title_hl = "";
		 for(SolrDocument m : proList){	
			String img=CommonString.getFormatPara(m.getFieldValue("img"));
			String id = CommonString.getFormatPara(m.getFieldValue("id"));
			String title = CommonString.getFormatPara(m.getFieldValue("title"));
			String url = CommonString.getFormatPara(m.getFieldValue("url"));
			String link_other = CommonString.getFormatPara(m.getFieldValue("link_other"));
			String intro = CommonString.getFormatPara(m.getFieldValue("intro"));
			if(res.getHighlighting().get(id) != null){
				Map<String, List<String>> hl = res.getHighlighting().get(id);
				if(hl.get("title") != null){
					title_hl = hl.get("title").get(0);
				}
			}
			if(intro.length()>90){intro=intro.substring(0,90)+"...";}
			String titleAlt = title;
		 	if(title.length()>20){
		 		titleAlt=title;
		 		title=title.substring(0,20)+"...";
			}
		%>
            <li>
              <h3 style="width:450px"> <span class="lb"> <a href="#" title="维修" style="color: #ff6600">[维修]</a> </span> <a target="_blank" href="#" title="日立ZAXIS系列液压挖掘机的保险丝检修方法">日立ZAXIS系列液压挖掘机的保险丝检修方法</a></h3>
              <span class="time">2014-08-22</span> </li>
            <li>
           <%}%>
          </ul>
        </div>
      </div>
      <!--维修网点-->
      <div class="rp clearfix mb10 nwx_zxlist repairList border0">
        <div class="title border04">
          <h3>维修网点</h3>
          <a style=" float:right; padding-right:25px;" href="#">更多</a> </div>
        <div class="content r_add">
          <ul class="list blue">
           		  		<%  
		 title_hl = "";
		for(SolrDocument m : agentList){	
			String img=CommonString.getFormatPara(m.getFieldValue("img"));
			String id = CommonString.getFormatPara(m.getFieldValue("id"));
			String title = CommonString.getFormatPara(m.getFieldValue("title"));
			String url = CommonString.getFormatPara(m.getFieldValue("url"));
			String link_other = CommonString.getFormatPara(m.getFieldValue("link_other"));
			String intro = CommonString.getFormatPara(m.getFieldValue("intro"));
			if(res.getHighlighting().get(id) != null){
				Map<String, List<String>> hl = res.getHighlighting().get(id);
				if(hl.get("title") != null){
					title_hl = hl.get("title").get(0);
				}
			}
			if(intro.length()>90){intro=intro.substring(0,90)+"...";}
			String titleAlt = title;
		 	if(title.length()>20){
		 		titleAlt=title;
		 		title=title.substring(0,20)+"...";
			}
		%> 
			<li>
              <h3 style="width:450px"> <span class="lb"> <a href="#" title="维修" style="color: #ff6600">[维修]</a> </span> <a target="_blank" href="#" title="日立ZAXIS系列液压挖掘机的保险丝检修方法">日立ZAXIS系列液压挖掘机的保险丝检修方法</a></h3>
              <span class="time">2014-08-22</span> </li>
          <%}%>
          </ul>
        </div>
      </div>
    </div>
    <div class="nse_page">
      <div class="paging page" id="pagination"><a class="pre noPre" title="上一页" href="javascript:;"></a> <span class="current"><b>&nbsp;1&nbsp;</b></span><a class="num" href="/search/挖掘机_0_0_2.htm">&nbsp;2&nbsp;</a><a class="num" href="/search/挖掘机_0_0_3.htm">&nbsp;3&nbsp;</a><a class="num" href="/search/挖掘机_0_0_4.htm">&nbsp;4&nbsp;</a><a class="num" href="/search/挖掘机_0_0_5.htm">&nbsp;5&nbsp;</a><a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a><a class="num" href="/search/挖掘机_0_0_73.htm">&nbsp;73&nbsp;</a><a class="num" href="/search/挖掘机_0_0_74.htm">&nbsp;74&nbsp;</a><a href="/search/挖掘机_0_0_2.htm" class="next"></a></div>
      <div class="l nse_allresult">共约1105条结果</div>
    </div>
  </div>
</div>
<!--main end--> 
<!--foot search 有搜索结果时出现-->
<div class="contain980">
  <div class="nse_foot_search"><span>重新搜索</span>
    <input onkeypress="tj();" value="挖掘机" name="keyword" id="keywords" type="text" class="nse_foot_seinp">
    <input type="submit" class="nse_foot_sebtn" value="搜索" onclick="tj();">
  </div>
  <div class="telTip">如果没有找到您的信息，请直接致电：<strong>4006-521-526</strong></div>
  <script>
		  function tj(){
		  	  if(jQuery('#keywords').val()==''){
		     jQuery('#keywords').focus();
			 return false;
		  }
		  var keyword=jQuery('#keywords').val();
		  window.location.href="/search/"+keyword+"_0_0_0.htm";
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