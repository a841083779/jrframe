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
	String weixiuType = CommonString.getFormatPara(request.getParameter("weixiuType")) ;
	String keywordCheck = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String pageKeyword = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String province = CommonString.getFormatPara(request.getParameter("province"));
	String city = CommonString.getFormatPara(request.getParameter("city"));
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	int nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));
	Map brandMap = (Map)application.getAttribute("brandMap") ;
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
    if(keywordCheck.equals("0")){keywordCheck="";}
	if(catalog.equals("")){catalog="0";}
	if(factory.equals("")){factory="0";}
	if(province.equals("")){province="0";}
	if(city.equals("")){city="0";}
	if(pageKeyword.equals("")){pageKeyword="0";}
	int totalParts = 0;
	String tempCatalog="";
	String tempFactory="";
	SolrDocumentList infoList=null;
	SolrDocumentList proList=null;
	SolrDocumentList agentList=null;
	QueryResponse res=null;
	int pageCount = 0;
	if(weixiuType.equals("info")){
	String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_weixiu";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	/*接收参数*/
	SolrQuery query = new SolrQuery();
	nowPage = nowPage <= 0 ? 1 : nowPage;
	List<String> whereList = new ArrayList<String>();
	if(!catalog.equals("0")&&!catalog.equals("")&&catalog.length()>3){
	   tempCatalog=(CommonString.getFormatPara(catalogMap.get(catalog)));
	}
	if(!factory.equals("0")&&!factory.equals("")){
	    tempFactory=(CommonString.getFormatPara(brandMap.get(factory)));
	}
	if((keywordCheck+tempFactory+tempCatalog).equals("")){
	   	query.setQuery("*:*");
	}else{
	    query.setQuery(keywordCheck+tempFactory+tempCatalog);
	}
	List<String> filterQuery = new ArrayList<String>(0);
	filterQuery.add("infoType:1")	;
   	String [] filterArr = new String [filterQuery.size()];
	filterArr = filterQuery.toArray(filterArr);
	query.addFilterQuery(filterArr);
    /*查询*/				
	int pageSize = 20;
	query.setRequestHandler("/jereh");
	query.setRows(pageSize);
	query.setStart((nowPage - 1) * pageSize);
	/* 高亮 */
	query.setHighlight(true);
	query.setHighlightSimplePre("<span style='color:red;'>");
	query.setHighlightSimplePost("</span>");
	query.setParam("hl.fl", "title");
	 res = server.query(query);
	totalParts = (int)res.getResults().getNumFound();
	 pageCount = totalParts / pageSize + (totalParts % pageSize > 0 ? 1 : 0);
	infoList = res.getResults();
	}
	if(weixiuType.equals("pro")){
	String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_weixiu";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	/*接收参数*/
	SolrQuery query = new SolrQuery();
	nowPage = nowPage <= 0 ? 1 : nowPage;
	List<String> whereList = new ArrayList<String>();
	if(!catalog.equals("0")&&!catalog.equals("")&&catalog.length()>3){
	   tempCatalog=(CommonString.getFormatPara(catalogMap.get(catalog)));
	}
	if(!factory.equals("0")&&!factory.equals("")){
	    tempFactory=(CommonString.getFormatPara(brandMap.get(factory)));
	}
	if((keywordCheck+tempFactory+tempCatalog).equals("")){
	   	query.setQuery("*:*");
	}else{
	    query.setQuery(keywordCheck+tempFactory+tempCatalog);
	}
	List<String> filterQuery = new ArrayList<String>(0);
	filterQuery.add("infoType:2")	;
   	String [] filterArr = new String [filterQuery.size()];
	filterArr = filterQuery.toArray(filterArr);
	query.addFilterQuery(filterArr);
    /*查询*/				
	int pageSize = 10;
	query.setRequestHandler("/jereh");
	query.setRows(pageSize);
	query.setStart((nowPage - 1) * pageSize);
	/* 高亮 */
	query.setHighlight(true);
	query.setHighlightSimplePre("<span style='color:red;'>");
	query.setHighlightSimplePost("</span>");
	query.setParam("hl.fl", "title");
	 res = server.query(query);
	totalParts = (int)res.getResults().getNumFound();
	pageCount = totalParts / pageSize + (totalParts % pageSize > 0 ? 1 : 0);		
	proList = res.getResults();
	}
	
	if(weixiuType.equals("agent")){
    String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_agent";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	/*接收参数*/
	SolrQuery query = new SolrQuery();
	nowPage = nowPage <= 0 ? 1 : nowPage;
	List<String> whereList = new ArrayList<String>();
	if(!catalog.equals("0")&&!catalog.equals("")&&catalog.length()>3){
	   tempCatalog=(CommonString.getFormatPara(catalogMap.get(catalog)));
	}
	if(!factory.equals("0")&&!factory.equals("")){
	    tempFactory=(CommonString.getFormatPara(brandMap.get(factory)));
	}
	if((keywordCheck+tempFactory+tempCatalog).equals("")){
	   	query.setQuery("*:*");
	}else{
	    query.setQuery("full_name:" + keywordCheck+tempFactory+tempCatalog);
	}
    /*查询*/				
	int pageSize = 10;
	query.setRequestHandler("/jereh");
	query.setRows(pageSize);
	query.setStart((nowPage - 1) * pageSize);
	/* 高亮 */
	query.setHighlight(true);
	query.setHighlightSimplePre("<span style='color:red;'>");
	query.setHighlightSimplePost("</span>");
	query.setParam("hl.fl", "title");
	 res = server.query(query);
	totalParts = (int)res.getResults().getNumFound();
	pageCount = totalParts / pageSize + (totalParts % pageSize > 0 ? 1 : 0);
	agentList = res.getResults();
	}
	String TDK_title="";String TDK_keywords="";String TDK_desc="";
	if(!weixiuType.equals("0")&&!weixiuType.equals("")&&totalParts<=0){
	TDK_title=keywordCheck+" - 口碑搜索 - 铁臂维修";
	TDK_keywords=keywordCheck+",铁臂维修";
	TDK_desc="在铁臂维修中找到了0条"+keywordCheck+"相关信息，请重新选择，买工程机械就上铁臂商城。";
	}else{
	if(weixiuType.equals("0")||weixiuType.equals("")){totalParts=300;}
	TDK_title=keywordCheck+" - 维修搜索 - 铁臂维修";
	TDK_keywords=keywordCheck+",铁臂维修";
	TDK_desc="在铁臂维修中找到了"+totalParts+"条"+keywordCheck+"相关信息，其中包含了"+keywordCheck+"维修知识大全，"+keywordCheck+"维修网点，"+keywordCheck+"维修动态等信息，买工程机械就上铁臂商城。";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=TDK_title%></title>
<meta name="keywords" content="<%=TDK_title%>" />
<meta name="description" content="<%=TDK_desc%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="/weixiu/style/style.css" rel="stylesheet" type="text/css" />
<link href="/weixiu/style/weixiu.css" rel="stylesheet" type="text/css" />
<link href="/style/friendly_link.css" rel="stylesheet" type="text/css" />
<link href="/dealer/style/style.css" rel="stylesheet" type="text/css" />
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
<%if(weixiuType.equals("0")||weixiuType.equals("")){%>
<!--没有选择类别搜索结果综合首页-->
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
    <jsp:include page="/include/search/weixiu_left_info.jsp" flush="true"/>
    <jsp:include page="/include/search/weixiu_left_pro.jsp" flush="true"/>
    <div class="rp clearfix mb10 area Similar nse_left_viewpro Sborder mt10">
      <div class="stitle">
        <h3>热门维修网点</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
          <li><a title="北京维修" href="/0_<%=keywordCheck%>_105500_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">北京</a></li>
          <li><a title="上海维修" href="/0_<%=keywordCheck%>_105300_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">上海</a></li>
          <li><a title="天津维修" href="/0_<%=keywordCheck%>_105690_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">天津</a></li>
          <li><a title="重庆维修" href="/0_<%=keywordCheck%>_105880_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">重庆</a></li>
          <li><a title="石家庄维修" href="/0_<%=keywordCheck%>_106410_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">石家庄</a></li>
          <li><a title="太原维修" href="/0_<%=keywordCheck%>_108310_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">太原</a></li>
          <li><a title="呼和浩特维修" href="/0_<%=keywordCheck%>_109710_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">呼和浩特</a></li>
          <li><a title="沈阳维修" href="/0_<%=keywordCheck%>_120010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">沈阳</a></li>
          <li><a title="长春维修" href="/0_<%=keywordCheck%>_119010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">长春</a></li>
          <li><a title="哈尔滨维修" href="/0_<%=keywordCheck%>_122010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">哈尔滨</a></li>
          <li><a title="南京维修" href="/0_<%=keywordCheck%>_110910_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">南京</a></li>
          <li><a title="杭州维修" href="/0_<%=keywordCheck%>_104210_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">杭州</a></li>
          <li><a title="合肥维修" href="/0_<%=keywordCheck%>_102320_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">合肥</a></li>
          <li><a title="福州维修" href="/0_<%=keywordCheck%>_142010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">福州</a></li>
          <li><a title="南昌维修" href="/0_<%=keywordCheck%>_103110_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">南昌</a></li>
          <li><a title="济南维修" href="/0_<%=keywordCheck%>_101260_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">济南</a></li>
          <li><a title="郑州维修" href="/0_<%=keywordCheck%>_130010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">郑州</a></li>
          <li><a title="武汉维修" href="/0_<%=keywordCheck%>_124010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">武汉</a></li>
          <li><a title="长沙维修" href="/0_<%=keywordCheck%>_126010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">长沙</a></li>
          <li><a title="广州维修" href="/0_<%=keywordCheck%>_128010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">广州</a></li>
          <li><a title="南宁维修" href="/0_<%=keywordCheck%>_113010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">南宁</a></li>
          <li><a title="海口维修" href="/0_<%=keywordCheck%>_141510_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">海口</a></li>
          <li><a title="成都维修" href="/0_<%=keywordCheck%>_139010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">成都</a></li>
          <li><a title="贵阳维修" href="/0_<%=keywordCheck%>_132010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">贵阳</a></li>
          <li><a title="昆明维修" href="/0_<%=keywordCheck%>_137010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">昆明</a></li>
          <li><a title="拉萨维修" href="/0_<%=keywordCheck%>_115010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">拉萨</a></li>
          <li><a title="西安维修" href="/0_<%=keywordCheck%>_135510_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">西安</a></li>
          <li><a title="兰州维修" href="/0_<%=keywordCheck%>_134010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">兰州</a></li>
          <li><a title="西宁维修" href="/0_<%=keywordCheck%>_133010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">西宁</a></li>
          <li><a title="银川维修" href="/0_<%=keywordCheck%>_116010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">银川</a></li>
          <li><a title="乌鲁木齐维修" href="/0_<%=keywordCheck%>_117010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">乌鲁木齐</a></li>
        </ul>
      </div>
    </div>
  </div>
  <!--left end-->
  <!--right-->
  <div class="w757 r">
    <% 
	    if(!keywordCheck.equals("")&&1==2){
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
	        <jsp:include page="/include/search/weixiu_select.jsp" flush="true">
		      <jsp:param value="<%=keywordCheck%>" name="keywordCheck"/>
			  <jsp:param value="<%=weixiuType%>" name="weixiuType"/>
              <jsp:param value="<%=catalog%>" name="catalog"/>
              <jsp:param value="<%=factory%>" name="factory"/>
              <jsp:param value="<%=province%>" name="province"/>
              <jsp:param value="<%=city%>" name="city"/>
          </jsp:include>  
        </ul>
      </div>
    </form>
    <div class="nseresult_pro pic_searchval">
      <!--维修知识-->
      <jsp:include page="/include/search/weixiu_index_info.jsp" flush="true">
		      <jsp:param value="<%=keywordCheck%>" name="keyword"/>
              <jsp:param value="<%=catalog%>" name="catalog"/>
              <jsp:param value="<%=factory%>" name="factory"/>
              <jsp:param value="<%=province%>" name="province"/>
              <jsp:param value="<%=city%>" name="city"/>
          </jsp:include>
      <!--产品维修-->
      <jsp:include page="/include/search/weixiu_index_pro.jsp" flush="true">
			  <jsp:param value="<%=keywordCheck%>" name="keyword"/>
              <jsp:param value="<%=catalog%>" name="catalog"/>
              <jsp:param value="<%=factory%>" name="factory"/>
              <jsp:param value="<%=province%>" name="province"/>
              <jsp:param value="<%=city%>" name="city"/>
        </jsp:include>
      <!--维修网点-->
      <jsp:include page="/include/search/weixiu_index_agent.jsp" flush="true">
			  <jsp:param value="<%=keywordCheck%>" name="keyword"/>
              <jsp:param value="<%=catalog%>" name="catalog"/>
              <jsp:param value="<%=factory%>" name="factory"/>
              <jsp:param value="<%=province%>" name="province"/>
              <jsp:param value="<%=city%>" name="city"/>
		</jsp:include>
    </div>
  </div>
</div>
<!--main end-->
<%}else if(totalParts>0){%>
<!--如果选择了类别并且搜索结果不为0-->
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
    <jsp:include page="/include/search/weixiu_left_info.jsp" flush="true"/>
    <jsp:include page="/include/search/weixiu_left_pro.jsp" flush="true"/>
    <div class="rp clearfix mb10 area Similar nse_left_viewpro Sborder mt10">
      <div class="stitle">
        <h3>热门维修网点</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
          <li><a title="北京维修" href="/0_<%=keywordCheck%>_105500_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">北京</a></li>
          <li><a title="上海维修" href="/0_<%=keywordCheck%>_105300_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">上海</a></li>
          <li><a title="天津维修" href="/0_<%=keywordCheck%>_105690_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">天津</a></li>
          <li><a title="重庆维修" href="/0_<%=keywordCheck%>_105880_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">重庆</a></li>
          <li><a title="石家庄维修" href="/0_<%=keywordCheck%>_106410_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">石家庄</a></li>
          <li><a title="太原维修" href="/0_<%=keywordCheck%>_108310_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">太原</a></li>
          <li><a title="呼和浩特维修" href="/0_<%=keywordCheck%>_109710_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">呼和浩特</a></li>
          <li><a title="沈阳维修" href="/0_<%=keywordCheck%>_120010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">沈阳</a></li>
          <li><a title="长春维修" href="/0_<%=keywordCheck%>_119010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">长春</a></li>
          <li><a title="哈尔滨维修" href="/0_<%=keywordCheck%>_122010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">哈尔滨</a></li>
          <li><a title="南京维修" href="/0_<%=keywordCheck%>_110910_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">南京</a></li>
          <li><a title="杭州维修" href="/0_<%=keywordCheck%>_104210_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">杭州</a></li>
          <li><a title="合肥维修" href="/0_<%=keywordCheck%>_102320_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">合肥</a></li>
          <li><a title="福州维修" href="/0_<%=keywordCheck%>_142010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">福州</a></li>
          <li><a title="南昌维修" href="/0_<%=keywordCheck%>_103110_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">南昌</a></li>
          <li><a title="济南维修" href="/0_<%=keywordCheck%>_101260_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">济南</a></li>
          <li><a title="郑州维修" href="/0_<%=keywordCheck%>_130010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">郑州</a></li>
          <li><a title="武汉维修" href="/0_<%=keywordCheck%>_124010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">武汉</a></li>
          <li><a title="长沙维修" href="/0_<%=keywordCheck%>_126010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">长沙</a></li>
          <li><a title="广州维修" href="/0_<%=keywordCheck%>_128010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">广州</a></li>
          <li><a title="南宁维修" href="/0_<%=keywordCheck%>_113010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">南宁</a></li>
          <li><a title="海口维修" href="/0_<%=keywordCheck%>_141510_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">海口</a></li>
          <li><a title="成都维修" href="/0_<%=keywordCheck%>_139010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">成都</a></li>
          <li><a title="贵阳维修" href="/0_<%=keywordCheck%>_132010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">贵阳</a></li>
          <li><a title="昆明维修" href="/0_<%=keywordCheck%>_137010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">昆明</a></li>
          <li><a title="拉萨维修" href="/0_<%=keywordCheck%>_115010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">拉萨</a></li>
          <li><a title="西安维修" href="/0_<%=keywordCheck%>_135510_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">西安</a></li>
          <li><a title="兰州维修" href="/0_<%=keywordCheck%>_134010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">兰州</a></li>
          <li><a title="西宁维修" href="/0_<%=keywordCheck%>_133010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">西宁</a></li>
          <li><a title="银川维修" href="/0_<%=keywordCheck%>_116010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">银川</a></li>
          <li><a title="乌鲁木齐维修" href="/0_<%=keywordCheck%>_117010_<%=city%>_<%=factory%>_<%=catalog%>_0.htm">乌鲁木齐</a></li>
        </ul>
      </div>
    </div>
  </div>
  <!--left end-->
  <!--right-->
  <div class="w757 r">
    <% 
	    if(!keywordCheck.equals("")&&1==2){
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
		 <jsp:include page="/include/search/weixiu_select.jsp" flush="true">
		      <jsp:param value="<%=keywordCheck%>" name="keywordCheck"/>
			  <jsp:param value="<%=weixiuType%>" name="weixiuType"/>
              <jsp:param value="<%=catalog%>" name="catalog"/>
              <jsp:param value="<%=factory%>" name="factory"/>
              <jsp:param value="<%=province%>" name="province"/>
              <jsp:param value="<%=city%>" name="city"/>
          </jsp:include>    
        </ul>
      </div>
    </form>
    <%if(weixiuType.equals("info")){%>
    <div class="nseresult_pro pic_searchval">
      <div class="nse_usedate" style="display:none">找到约<%=totalParts %>条结果</div>
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
              <h3 style="width:450px"> <span class="lb"> <a  target="_blank" href="http://weixiu.21-sun.com/knowledge/" title="维修知识" style="color: #ff6600">[维修知识]</a> </span> <a target="_blank" href="http://weixiu.21-sun.com/info_<%=id%>.htm" title="<%=title%>"><%=title%></a></h3>
              <span    class="time"><%=pub_date%></span> </li>
            <%}%>
          </ul>
        </div>
      </div>
    </div>
    <%}else if(weixiuType.equals("pro")){%>
    <div class="nseresult_pro pic_searchval">
      <div class="nse_usedate">找到约<%=totalParts %>条结果</div>
      <!--产品维修-->
      <div class="rp clearfix mb10 nwx_zxlist repairList border0">
        <div class="title border04">
          <h3>产品维修</h3>
          <a style=" float:right; padding-right:25px;" href="#">更多</a> </div>
        <div class="content r_add">
          <%  
		String title_hl = "";
		for(SolrDocument m : proList){	
			String id = CommonString.getFormatPara(m.getFieldValue("id"));
			String title = CommonString.getFormatPara(m.getFieldValue("title"));
            String img=CommonString.getFormatPara(m.getFieldValue("img"));
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
		int waiguandafang=CommonString.getFormatInt(m.getFieldValue("waiguandafang"));
		int caozuoshushi=CommonString.getFormatInt(m.getFieldValue("caozuoshushi"));
		int youhaodi=CommonString.getFormatInt(m.getFieldValue("youhaodi"));
		int dongliqiangjin=CommonString.getFormatInt(m.getFieldValue("dongliqiangjin"));
		int caozuojianbian=CommonString.getFormatInt(m.getFieldValue("caozuojianbian"));
		int xingnengzhuoyue=CommonString.getFormatInt(m.getFieldValue("xingnengzhuoyue"));
		int jienenghuanbao=CommonString.getFormatInt(m.getFieldValue("jienenghuanbao"));
		int guzhangludi=CommonString.getFormatInt(m.getFieldValue("guzhangludi"));
		int shouhoufuwu=CommonString.getFormatInt(m.getFieldValue("shouhoufuwu"));
		int jishouzuiai=CommonString.getFormatInt(m.getFieldValue("jishouzuiai"));
		int baoyangbianjie=CommonString.getFormatInt(m.getFieldValue("baoyangbianjie"));
		int kuanchangshushi=CommonString.getFormatInt(m.getFieldValue("kuanchangshushi"));
		int zaoyindi=CommonString.getFormatInt(m.getFieldValue("zaoyindi"));		
		%>
          <div class="pro_detail_head clearfix pro_weixiu_sear">
            <div class="_img" style=" width:160px; margin-right:20px;"> <img onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"  src="<%=img%>" title="<%=title%>" alt="<%=title%>"> </div>
            <div class="_detail pro_weixiu">
              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tbody>
                  <tr>
                    <td colspan="2" class="n"><%=title%></td>
                  </tr>
                  <tr>
                    <th style="text-align:left"><strong>配置：</strong></th>
                    <td><a onclick="vote('waiguandafang');" style="cursor:pointer;"><span class="_cell">外观大方(<span id="num_waiguandafang"><%=waiguandafang%></span>)</span></a> <a onclick="vote('caozuoshushi');" style="cursor:pointer;"><span class="_cell">操作舒适(<span id="num_caozuoshushi"><%=caozuoshushi%></span>)</span></a> <a onclick="vote('youhaodi');" style="cursor:pointer;"><span class="_cell">油耗低(<span id="num_youhaodi"><%=youhaodi%></span>)</span></a> <a onclick="vote('dongliqiangjin');" style="cursor:pointer;"><span class="_cell">动力强劲(<span id="num_dongliqiangjin"><%=dongliqiangjin%></span>)</span></a></td>
                  </tr>
                  <tr>
                    <th style="text-align:left"><strong>优势：</strong></th>
                    <td><a onclick="vote('caozuojianbian');" style="cursor:pointer;"><span class="_cell">操作简便(<span id="num_caozuojianbian"><%=caozuojianbian%></span>)</span></a> <a onclick="vote('xingnengzhuoyue');" style="cursor:pointer;"><span class="_cell">性能卓越(<span id="num_xingnengzhuoyue"><%=xingnengzhuoyue%></span>)</span></a> <a onclick="vote('jienenghuanbao');" style="cursor:pointer;"><span class="_cell">节能环保(<span id="num_jienenghuanbao"><%=jienenghuanbao%></span>)</span></a> <a onclick="vote('guzhangludi');" style="cursor:pointer;"><span class="_cell">故障率低(<span id="num_guzhangludi"><%=guzhangludi%></span>)</span></a> <a onclick="vote('shouhoufuwu');" style="cursor:pointer;"><span class="_cell">售后服务体系保障(<span id="num_shouhoufuwu"><%=shouhoufuwu%></span>)</span></a></td>
                  </tr>
                  <tr>
                    <th style="text-align:left"><strong>其它：</strong></th>
                    <td><a onclick="vote('jishouzuiai');" style="cursor:pointer;"><span class="_cell">机手最爱(<span id="num_jishouzuiai"><%=jishouzuiai%></span>)</span></a> <a onclick="vote('baoyangbianjie');" style="cursor:pointer;"><span class="_cell">保养便捷(<span id="num_baoyangbianjie"><%=baoyangbianjie%></span>)</span></a> <a onclick="vote('kuanchangshushi');" style="cursor:pointer;"><span class="_cell">宽敞舒适(<span id="num_kuanchangshushi"><%=kuanchangshushi%></span>)</span></a> <a onclick="vote('zaoyindi');" style="cursor:pointer;"><span class="_cell">噪音低(<span id="num_zaoyindi"><%=zaoyindi%></span>)</span></a></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <%}%>
          <!--产品维修 end-->
        </div>
      </div>
    </div>
    <%}else if(weixiuType.equals("agent")){%>
    <div class="nseresult_pro pic_searchval">
      <div class="nse_usedate">找到约<%=totalParts %>条结果</div>
      <!--网点-->
      <div class="rp clearfix mb10 nwx_zxlist repairList border0">
        <div class="agent_list border0">
          <ul class="fix">
            <%  
		String title_hl = "";
        int i = 0;
		for(SolrDocument m : agentList){	
			String id = CommonString.getFormatPara(m.getFieldValue("id"));
			String logo=CommonString.getFormatPara(m.getFieldValue("logo"));
			String full_name = CommonString.getFormatPara(m.getFieldValue("full_name"));
			if(res.getHighlighting().get(id) != null){
				Map<String, List<String>> hl = res.getHighlighting().get(id);
				if(hl.get("full_name") != null){
					title_hl = hl.get("full_name").get(0);
				}
			}
			String title = CommonString.getFormatPara(m.getFieldValue("title"));
            String citys= CommonString.getFormatPara(m.getFieldValue("city"));
			String address= CommonString.getFormatPara(m.getFieldValue("address"));
			if(citys.length()>20){citys=citys.substring(0,20)+"...";}
            String usern=CommonString.getFormatPara(m.getFieldValue("usern"));
            String agent_name=CommonString.getFormatPara(m.getFieldValue("agent_fac_name"));

		%>
            <li><em class="nm"><%=i+1%></em> <a href="http://dealer.21-sun.com/<%=usern%>/" target="blank" title="<%=full_name%>"> <img onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" src="http://product.21-sun.com/uploadfiles/<%=logo%>" class="agimg"></a>
              <div class="intro">
                <h2><a target="_blank" href="http://dealer.21-sun.com/<%=usern%>/" title="<%=full_name%>"><%=title_hl.equals("") ? full_name : title_hl %></a></h2>
                <div class="text">
                  <dl>
                    <strong>主营品牌：</strong> [<%=agent_name%>]
                  </dl>
                  <dl>
                    <strong>代理区域：</strong> <%=citys%>
                  </dl>
                  <dl>
                    <strong>详细地址：</strong> <%=address.equals("")?"暂无":address%>
                  </dl>
                  <dl>
                    <strong>公司网址：</strong> <a target="_blank" href="http://dealer.21-sun.com/<%=usern%>/" title="http://dealer.21-sun.com/hfxy/">http://dealer.21-sun.com/<%=usern%>/</a>
                  </dl>
                </div>
              </div>
            </li>
            <%i++;}%>
          </ul>
        </div>
      </div>
    </div>
    <%}%>
    <div class="nse_page">
      <tags:weixiu_page_search nowPage="<%=nowPage%>" total="<%=totalParts %>"  totalPage="<%=pageCount%>" factory="<%=factory%>" catalog="<%=catalog%>" keyword="<%=pageKeyword%>" />
      <div class="l nse_allresult">共约<%=totalParts %>条结果</div>
    </div>
  </div>
</div>
<!--main end-->
<%}else{%>
<!--如果选择了类别并且搜索结果为0-->
<div class="contain980">
  <div class="nser_nots mb10">非常抱歉，没有找到与"<span><%=keywordCheck%></span>"相关的维修信息</div>
  <jsp:include page="/include/search/weixiu_info_list.jsp" flush="true"/>
  <jsp:include page="/include/search/weixiu_pro_list.jsp" flush="true"/>
  <jsp:include page="/include/search/weixiu_agent_list.jsp" flush="true"/>
</div>
<%}%>
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