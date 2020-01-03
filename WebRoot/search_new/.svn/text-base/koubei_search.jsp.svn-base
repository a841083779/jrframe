<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="java.net.URLEncoder,java.sql.Connection"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%  DBHelper dbHelper = DBHelper.getInstance() ;
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
	int totalParts = 0;
	String tempCatalog="";
	String tempFactory="";
	//搜索新	
	String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_koubei";
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
	   	query.setQuery("*:*");
	}else{
	   query.setQuery("title:" + keywordCheck+tempFactory+tempCatalog);
	}
    /*查询*/				
	int pageSize = 10;
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
	TDK_title=keywordCheck+" - 口碑搜索 - 铁臂口碑";
	TDK_keywords=keywordCheck+",铁臂口碑";
	TDK_desc="在铁臂口碑中找到了"+totalParts+"条"+keywordCheck+"相关信息，其中包含了"+keywordCheck+"价格表，"+keywordCheck+"产品口碑，"+keywordCheck+"产品点评等信息，买"+keywordCheck+"就上铁臂商城。";
	}else{
	TDK_title=keywordCheck+" - 口碑搜索 - 铁臂口碑";
	TDK_keywords=keywordCheck+",铁臂口碑";
	TDK_desc="在铁臂口碑中找到了0条"+keywordCheck+"相关信息，请重新选择，买工程机械就上铁臂商城。";
	}
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		List<Map> brandList=null;
		if(!"".equals(catalog)&&!"0".equals(catalog)){
		brandList= dbHelper.getMapList("SELECT top 13 id,name FROM pro_agent_factory where flag=1 and is_show=1 and id in (select distinct factoryid from pro_products where is_show=1 and  catalognum like '"+catalog+"%')",connection) ;
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
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
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/new_style.css" rel="stylesheet" type="text/css" />
<link href="../style/friendly_link.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
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
<div class="np_fix contain980"> 
  <!--left-->
  <div class="w210 l">
    <div class="nph_val mb10">
      <ul class="nph_list">
        <li> <a href="/search/<%=keywordCheck%>_0_101_0.htm">土方机械</a>
          <ul style="display:none">
            <li id="cat_101_101001"> <a href="/search/<%=keywordCheck%>_0_101001_0.htm" class="mainBrand"> 挖掘机 </a> </li>
            <li id="cat_101_101002"> <a href="/search/<%=keywordCheck%>_0_101002_0.htm" class="mainBrand"> 装载机 </a> </li>
            <li id="cat_101_101003"> <a href="/search/<%=keywordCheck%>_0_101003_0.htm" class="mainBrand"> 推土机 </a> </li>
            <li id="cat_101_101004"> <a href="/search/<%=keywordCheck%>_0_101004_0.htm" class="mainBrand"> 铲运机 </a> </li>
            <li id="cat_101_101005"> <a href="/search/<%=keywordCheck%>_0_101005_0.htm" class="mainBrand"> 平地机 </a> </li>
            <li id="cat_101_101008"> <a href="/search/<%=keywordCheck%>_0_101008_0.htm" class="mainBrand"> 自卸卡车 </a> </li>
          </ul>
        </li>
        <li> <a href="/search/<%=keywordCheck%>_0_102_0.htm">起重机</a>
          <ul style="display:none">
            <li id="cat_102_102013"> <a href="/search/<%=keywordCheck%>_0_102013_0.htm" class="mainBrand"> 桥梁式起重机 </a> </li>
            <li id="cat_102_102007"> <a href="/search/<%=keywordCheck%>_0_102007_0.htm" class="mainBrand"> 汽车起重机 </a> </li>
            <li id="cat_102_102006"> <a href="/search/<%=keywordCheck%>_0_102006_0.htm" class="mainBrand"> 随车起重机 </a> </li>
            <li id="cat_102_102008"> <a href="/search/<%=keywordCheck%>_0_102008_0.htm" class="mainBrand"> 履带式起重机 </a> </li>
            <li id="cat_102_102002"> <a href="/search/<%=keywordCheck%>_0_102002_0.htm" class="mainBrand"> 塔式起重机 </a> </li>
            <li id="cat_102_102003"> <a href="/search/<%=keywordCheck%>_0_102003_0.htm" class="mainBrand"> 高空作业平台 </a> </li>
            <li id="cat_102_102010"> <a href="/search/<%=keywordCheck%>_0_102010_0.htm" class="mainBrand"> 高空作业车 </a> </li>
            <li id="cat_102_102011"> <a href="/search/<%=keywordCheck%>_0_102011_0.htm" class="mainBrand"> 施工升降机 </a> </li>
            <li id="cat_102_102012"> <a href="/search/<%=keywordCheck%>_0_102012_0.htm" class="mainBrand"> 伸缩臂叉装机 </a> </li>
          </ul>
        </li>
        <li><a href="/search/<%=keywordCheck%>_0_103_0.htm">混凝土机械</a>
          <ul style="display:none">
            <li id="cat_103_103001"> <a href="/search/<%=keywordCheck%>_0_103001_0.htm" class="mainBrand"> 混凝土泵车 </a> </li>
            <li id="cat_103_103017"> <a href="/search/<%=keywordCheck%>_0_103017_0.htm" class="mainBrand"> 车载泵 </a> </li>
            <li id="cat_103_103002"> <a href="/search/<%=keywordCheck%>_0_103002_0.htm" class="mainBrand"> 混凝土搅拌设备 </a> </li>
            <li id="cat_103_103018"> <a href="/search/<%=keywordCheck%>_0_103018_0.htm" class="mainBrand"> 拖泵 </a> </li>
            <li id="cat_103_103019"> <a href="/search/<%=keywordCheck%>_0_103019_0.htm" class="mainBrand"> 混凝土搅拌运输车 </a> </li>
            <li id="cat_103_103020"> <a href="/search/<%=keywordCheck%>_0_103020_0.htm" class="mainBrand"> 输送泵 </a> </li>
            <li id="cat_103_103005"> <a href="/search/<%=keywordCheck%>_0_103005_0.htm" class="mainBrand"> 混凝土布料设备 </a> </li>
            <li id="cat_103_103010"> <a href="/search/<%=keywordCheck%>_0_103010_0.htm" class="mainBrand"> 喷湿机 </a> </li>
            <li id="cat_103_103008"> <a href="/search/<%=keywordCheck%>_0_103008_0.htm" class="mainBrand"> 干粉砂浆生产设备 </a> </li>
            <li id="cat_103_103009"> <a href="/search/<%=keywordCheck%>_0_103009_0.htm" class="mainBrand"> 粉粒物料运输车 </a> </li>
            <li id="cat_103_103011"> <a href="/search/<%=keywordCheck%>_0_103011_0.htm" class="mainBrand"> 沥青砂浆车 </a> </li>
            <li id="cat_103_103012"> <a href="/search/<%=keywordCheck%>_0_103012_0.htm" class="mainBrand"> 干混砂浆生产线 </a> </li>
            <li id="cat_103_103014"> <a href="/search/<%=keywordCheck%>_0_103014_0.htm" class="mainBrand"> 干混砂浆背罐车 </a> </li>
            <li id="cat_103_103015"> <a href="/search/<%=keywordCheck%>_0_103015_0.htm" class="mainBrand"> 其它混凝土设备 </a> </li>
          </ul>
        </li>
        <li><a href="/search/<%=keywordCheck%>_0_104_0.htm">筑养路机械</a>
          <ul style="display:none">
            <li id="cat_104_104008"> <a href="/search/<%=keywordCheck%>_0_104008_0.htm" class="mainBrand"> 稳定土厂拌设备 </a> </li>
            <li id="cat_104_104007"> <a href="/search/<%=keywordCheck%>_0_104007_0.htm" class="mainBrand"> 沥青混合料搅拌设备 </a> </li>
            <li id="cat_104_104006"> <a href="/search/<%=keywordCheck%>_0_104006_0.htm" class="mainBrand"> 稳定土拌合机 </a> </li>
            <li id="cat_104_104005"> <a href="/search/<%=keywordCheck%>_0_104005_0.htm" class="mainBrand"> 铣刨机 </a> </li>
            <li id="cat_104_104002"> <a href="/search/<%=keywordCheck%>_0_104002_0.htm" class="mainBrand"> 养护机械 </a> </li>
            <li id="cat_104_104004"> <a href="/search/<%=keywordCheck%>_0_104004_0.htm" class="mainBrand"> 其它路面机械 </a> </li>
            <li id="cat_104_104001"> <a href="/search/<%=keywordCheck%>_0_104001_0.htm" class="mainBrand"> 摊铺机 </a> </li>
            <li id="cat_104_104009"> <a href="/search/<%=keywordCheck%>_0_104009_0.htm" class="mainBrand"> 沥青搅拌站 </a> </li>
          </ul>
        </li>
        <li><a href="/search/<%=keywordCheck%>_0_105_0.htm">桩工机械</a>
          <ul style="display:none">
            <li id="cat_105_105027"> <a href="/search/<%=keywordCheck%>_0_105027_0.htm" class="mainBrand"> 其它桩工机械 </a> </li>
            <li id="cat_105_105028"> <a href="/search/<%=keywordCheck%>_0_105028_0.htm" class="mainBrand"> 截桩机/破桩机 </a> </li>
            <li id="cat_105_105026"> <a href="/search/<%=keywordCheck%>_0_105026_0.htm" class="mainBrand"> 多轴钻孔机 </a> </li>
            <li id="cat_105_105019"> <a href="/search/<%=keywordCheck%>_0_105019_0.htm" class="mainBrand"> 多功能钻机 </a> </li>
            <li id="cat_105_105018"> <a href="/search/<%=keywordCheck%>_0_105018_0.htm" class="mainBrand"> 长螺旋钻孔机 </a> </li>
            <li id="cat_105_105017"> <a href="/search/<%=keywordCheck%>_0_105017_0.htm" class="mainBrand"> 强夯机 </a> </li>
            <li id="cat_105_105015"> <a href="/search/<%=keywordCheck%>_0_105015_0.htm" class="mainBrand"> 打桩锤 </a> </li>
            <li id="cat_105_105013"> <a href="/search/<%=keywordCheck%>_0_105013_0.htm" class="mainBrand"> 液压步履式桩架 </a> </li>
            <li id="cat_105_105011"> <a href="/search/<%=keywordCheck%>_0_105011_0.htm" class="mainBrand"> 打桩机 </a> </li>
            <li id="cat_105_105016"> <a href="/search/<%=keywordCheck%>_0_105016_0.htm" class="mainBrand"> 连续墙钻机 </a> </li>
            <li id="cat_105_105009"> <a href="/search/<%=keywordCheck%>_0_105009_0.htm" class="mainBrand"> 液压静力压桩机 </a> </li>
            <li id="cat_105_105007"> <a href="/search/<%=keywordCheck%>_0_105007_0.htm" class="mainBrand"> 连续墙抓斗 </a> </li>
            <li id="cat_105_105005"> <a href="/search/<%=keywordCheck%>_0_105005_0.htm" class="mainBrand"> 水平定向钻 </a> </li>
            <li id="cat_105_105004"> <a href="/search/<%=keywordCheck%>_0_105004_0.htm" class="mainBrand"> 潜孔钻机 </a> </li>
            <li id="cat_105_105003"> <a href="/search/<%=keywordCheck%>_0_105003_0.htm" class="mainBrand"> 旋挖钻机 </a> </li>
          </ul>
        </li>
        <li><a href="/search/<%=keywordCheck%>_0_106_0.htm">压实机械</a>
          <ul style="display:none">
            <li id="cat_106_106001"> <a href="/search/<%=keywordCheck%>_0_106001_0.htm" class="mainBrand"> 压路机 </a> </li>
            <li id="cat_106_106003"> <a href="/search/<%=keywordCheck%>_0_106003_0.htm" class="mainBrand"> 压实机 </a> </li>
            <li id="cat_106_106004"> <a href="/search/<%=keywordCheck%>_0_106004_0.htm" class="mainBrand"> 夯实机 </a> </li>
          </ul>
        </li>
        <li><a href="/search/<%=keywordCheck%>_0_107_0.htm">叉车</a>
          <ul style="display:none">
            <li id="cat_107_107010"> <a href="/search/<%=keywordCheck%>_0_107010_0.htm" class="mainBrand"> 专用叉车 </a> </li>
            <li id="cat_107_107005"> <a href="/search/<%=keywordCheck%>_0_107005_0.htm" class="mainBrand"> 仓储叉车 </a> </li>
            <li id="cat_107_107003"> <a href="/search/<%=keywordCheck%>_0_107003_0.htm" class="mainBrand"> 电动叉车 </a> </li>
            <li id="cat_107_107001"> <a href="/search/<%=keywordCheck%>_0_107001_0.htm" class="mainBrand"> 内燃叉车 </a> </li>
          </ul>
        </li>
        <li><a href="/search/<%=keywordCheck%>_0_113_0.htm">破碎设备</a>
          <ul style="display:none">
            <li id="cat_113_113002"> <a href="/search/装载机_0_113002_0.htm" class="mainBrand"> 液压剪 </a> </li>
            <li id="cat_113_113001"> <a href="/search/装载机_0_113001_0.htm" class="mainBrand"> 破碎锤 </a> </li>
          </ul>
        </li>
        <li><a href="/search/<%=keywordCheck%>_0_110_0.htm">地下及矿山机械</a>
          <ul style="display:none">
            <li id="cat_110_110017"> <a href="/search/<%=keywordCheck%>_0_110017_0.htm" class="mainBrand"> 隧道轨道设备 </a> </li>
            <li id="cat_110_110018"> <a href="/search/<%=keywordCheck%>_0_110018_0.htm" class="mainBrand"> 扒渣机 </a> </li>
            <li id="cat_110_110016"> <a href="/search/<%=keywordCheck%>_0_110016_0.htm" class="mainBrand"> 全液压凿岩钻机 </a> </li>
            <li id="cat_110_110015"> <a href="/search/<%=keywordCheck%>_0_110015_0.htm" class="mainBrand"> 输送和辅助设备 </a> </li>
            <li id="cat_110_110014"> <a href="/search/<%=keywordCheck%>_0_110014_0.htm" class="mainBrand"> 连续采煤机和隧道掘进机 </a> </li>
            <li id="cat_110_110013"> <a href="/search/<%=keywordCheck%>_0_110013_0.htm" class="mainBrand"> 装载及搬运设备 </a> </li>
            <li id="cat_110_110012"> <a href="/search/<%=keywordCheck%>_0_110012_0.htm" class="mainBrand"> 筛分机 </a> </li>
            <li id="cat_110_110011"> <a href="/search/<%=keywordCheck%>_0_110011_0.htm" class="mainBrand"> 凿岩机和钻机 </a> </li>
            <li id="cat_110_110010"> <a href="/search/<%=keywordCheck%>_0_110010_0.htm" class="mainBrand"> 凿岩钻车 </a> </li>
            <li id="cat_110_110009"> <a href="/search/<%=keywordCheck%>_0_110009_0.htm" class="mainBrand"> 破碎机 </a> </li>
            <li id="cat_110_110008"> <a href="/search/<%=keywordCheck%>_0_110008_0.htm" class="mainBrand"> 凿岩台车 </a> </li>
            <li id="cat_110_110005"> <a href="/search/<%=keywordCheck%>_0_110005_0.htm" class="mainBrand"> 采煤机 </a> </li>
            <li id="cat_110_110002"> <a href="/search/<%=keywordCheck%>_0_110002_0.htm" class="mainBrand"> 矿用掘进机 </a> </li>
            <li id="cat_110_110001"> <a href="/search/<%=keywordCheck%>_0_110001_0.htm" class="mainBrand"> 盾构掘进机 </a> </li>
          </ul>
        </li>
        <li><a href="/search/<%=keywordCheck%>_0_119_0.htm">煤炭机械</a>
          <ul style="display:none">
            <li id="cat_119_119001"> <a href="/search/<%=keywordCheck%>_0_119001_0.htm" class="mainBrand"> 煤炭机械 </a> </li>
          </ul>
        </li>
        <li><a href="/search/<%=keywordCheck%>_0_109_0.htm">桥梁机械</a>
          <ul style="display:none">
            <li id="cat_109_109006"> <a href="/search/<%=keywordCheck%>_0_109006_0.htm" class="mainBrand"> 砂浆车 </a> </li>
            <li id="cat_109_109005"> <a href="/search/<%=keywordCheck%>_0_109005_0.htm" class="mainBrand"> 检测车 </a> </li>
            <li id="cat_109_109004"> <a href="/search/<%=keywordCheck%>_0_109004_0.htm" class="mainBrand"> 提梁机 </a> </li>
            <li id="cat_109_109002"> <a href="/search/<%=keywordCheck%>_0_109002_0.htm" class="mainBrand"> 运梁车 </a> </li>
            <li id="cat_109_109001"> <a href="/search/<%=keywordCheck%>_0_109001_0.htm" class="mainBrand"> 架桥机 </a> </li>
          </ul>
        </li>
        <li><a href="/search/<%=keywordCheck%>_0_111_0.htm">港口机械</a>
          <ul style="display:none">
            <li id="cat_111_111008"> <a href="/search/<%=keywordCheck%>_0_111008_0.htm" class="mainBrand"> 海工装备 </a> </li>
            <li id="cat_111_111007"> <a href="/search/<%=keywordCheck%>_0_111007_0.htm" class="mainBrand"> 推耙机 </a> </li>
            <li id="cat_111_111006"> <a href="/search/<%=keywordCheck%>_0_111006_0.htm" class="mainBrand"> 场桥 </a> </li>
            <li id="cat_111_111003"> <a href="/search/<%=keywordCheck%>_0_111003_0.htm" class="mainBrand"> 吊具 </a> </li>
            <li id="cat_111_111002"> <a href="/search/<%=keywordCheck%>_0_111002_0.htm" class="mainBrand"> 堆高机 </a> </li>
            <li id="cat_111_111001"> <a href="/search/<%=keywordCheck%>_0_111001_0.htm" class="mainBrand"> 正面吊 </a> </li>
          </ul>
        </li>
        <li><a href="/search/<%=keywordCheck%>_0_118_0.htm">专用汽车</a>
          <ul style="display:none">
            <li id="cat_118_118003"> <a href="/search/<%=keywordCheck%>_0_118003_0.htm" class="mainBrand"> 消防车 </a> </li>
            <li id="cat_118_118004"> <a href="/search/<%=keywordCheck%>_0_118004_0.htm" class="mainBrand"> 牵引车 </a> </li>
            <li id="cat_118_118002"> <a href="/search/<%=keywordCheck%>_0_118002_0.htm" class="mainBrand"> 专用车辆 </a> </li>
          </ul>
        </li>
      </ul>
    </div>
    <div class="Similar nse_left_viewpro">
      <div class="stitle">
        <h3>热评产品推荐</h3>
      </div>
      <div class="scontent">
        <ul class="slist" id="history">
            	<jsp:include page="/include/search/koubei_hot_pro.jsp" flush="true" />

        </ul>
      </div>
    </div>
    <div class="w208 border02 l leftPart02 mb10 pp_hotph nse_left_viewpro Similar" style="margin-top:10px;">
      <div class="stitle">
        <h3>工程机械口碑排行榜</h3>
      </div>
      <ul class="list003" id="brandSubLeftId">
	  <%
	    if(factory.equals("0")){factory="";}
	
	  %>
      	<jsp:include page="/include/koubei/brands.jsp" flush="true">
			<jsp:param name="factoryid" value="<%=factory %>"></jsp:param>
			<jsp:param name="catalog" value="<%=catalog %>"></jsp:param>
		</jsp:include>
      </ul>
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
      <div class="w755 border03 l Condition mb10">
        <div class="ConditionTop" style="display:none">
          <div class="l"> </div>
          <h1 class="r" style="font-size:14px;"></h1>
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
  <dd><a href="/search/<%=keywordCheck%>_0_0_0.htm"  class="select" >不限</a> <a  href="/search/<%=keywordCheck%>_174_0_0.htm" >卡特彼勒</a> <a href="/search/<%=keywordCheck%>_137_0_0.htm" >临工</a> <a  href="/search/<%=keywordCheck%>_136_0_0.htm" >柳工</a> <a  href="/search/<%=keywordCheck%>_138_0_0.htm" >山工</a> <a  href="/search/<%=keywordCheck%>_135_0_0.htm" >龙工</a> <a  href="/search/<%=keywordCheck%>_209_0_0.htm" >徐工</a> <a  href="/search/<%=keywordCheck%>_144_0_0.htm" >山推</a> <a  href="/search/<%=keywordCheck%>_133_0_0.htm" >三一</a> <a  href="/search/<%=keywordCheck%>_192_0_0.htm" >斗山</a> <a  href="/search/<%=keywordCheck%>_182_0_0.htm" >小松</a> <a  href="/search/<%=keywordCheck%>_175_0_0.htm" >沃尔沃</a> <a  href="/search/<%=keywordCheck%>_157_0_0.htm" >力士德</a>
    <div id="changethis" class="pbtn"></div>
    <div class="plmore">
      <div class="pllist"><a class="plfl"><span style="color:#3355AC"> A-B-C-D-E-F-G </span></a><br/>
        <a href="/search/<%=keywordCheck%>_1185_0_0.htm" target="_top">阿尔多</a> <a href="/search/<%=keywordCheck%>_1185_0_0.htm" target="_top">阿尔多机械</a> <a href="/search/<%=keywordCheck%>_180_0_0.htm" target="_top">阿特拉斯</a> <a href="/search/<%=keywordCheck%>_482_0_0.htm" target="_top">阿特拉斯·科普柯</a> <a href="/search/<%=keywordCheck%>_402_0_0.htm" target="_top">艾迪</a> <a href="/search/<%=keywordCheck%>_772_0_0.htm" target="_top">艾思博</a> <a href="/search/<%=keywordCheck%>_14236_0_0.htm" target="_top">安鼎重工</a> <a href="/search/<%=keywordCheck%>_1710_0_0.htm" target="_top">安迈</a> <a href="/search/<%=keywordCheck%>_1169_0_0.htm" target="_top">安丘通用机械</a> <a href="/search/<%=keywordCheck%>_13271_0_0.htm" target="_top">奥津</a> <a href="/search/<%=keywordCheck%>_1778_0_0.htm" target="_top">奥盛特重工</a> <a href="/search/<%=keywordCheck%>_13272_0_0.htm" target="_top">奥泰</a> <a href="/search/<%=keywordCheck%>_484_0_0.htm" target="_top">八达</a> <a href="/search/<%=keywordCheck%>_791_0_0.htm" target="_top">八达重工</a> <a href="/search/<%=keywordCheck%>_13557_0_0.htm" target="_top">巴里巴</a> <a href="/search/<%=keywordCheck%>_1108_0_0.htm" target="_top">百财东洋</a> <a href="/search/<%=keywordCheck%>_13562_0_0.htm" target="_top">百巨建机</a> <a href="/search/<%=keywordCheck%>_13560_0_0.htm" target="_top">百开</a> <a href="/search/<%=keywordCheck%>_13565_0_0.htm" target="_top">百力克</a> <a href="/search/<%=keywordCheck%>_1168_0_0.htm" target="_top">百脉建机</a> <a href="/search/<%=keywordCheck%>_478_0_0.htm" target="_top">邦立重机</a> <a href="/search/<%=keywordCheck%>_13569_0_0.htm" target="_top">宝达</a> <a href="/search/<%=keywordCheck%>_13570_0_0.htm" target="_top">宝鼎</a> <a href="/search/<%=keywordCheck%>_1715_0_0.htm" target="_top">宝骊</a> <a href="/search/<%=keywordCheck%>_13550_0_0.htm" target="_top">宝马格</a> <a href="/search/<%=keywordCheck%>_13558_0_0.htm" target="_top">宝象</a> <a href="/search/<%=keywordCheck%>_13567_0_0.htm" target="_top">暴风雪</a> <a href="/search/<%=keywordCheck%>_1093_0_0.htm" target="_top">北车重工</a> <a href="/search/<%=keywordCheck%>_14144_0_0.htm" target="_top">北方红阳</a> <a href="/search/<%=keywordCheck%>_167_0_0.htm" target="_top">北方交通</a> <a href="/search/<%=keywordCheck%>_13551_0_0.htm" target="_top">北京加隆</a> <a href="/search/<%=keywordCheck%>_186_0_0.htm" target="_top">北起多田野</a> <a href="/search/<%=keywordCheck%>_1714_0_0.htm" target="_top">北山机械</a> <a href="/search/<%=keywordCheck%>_420_0_0.htm" target="_top">贝力特</a> <a href="/search/<%=keywordCheck%>_13556_0_0.htm" target="_top">贝司特</a> <a href="/search/<%=keywordCheck%>_13568_0_0.htm" target="_top">泵虎</a> <a href="/search/<%=keywordCheck%>_13553_0_0.htm" target="_top">边宁荷夫</a> <a href="/search/<%=keywordCheck%>_13566_0_0.htm" target="_top">滨州钻机</a> <a href="/search/<%=keywordCheck%>_13552_0_0.htm" target="_top">波坦</a> <a href="/search/<%=keywordCheck%>_13571_0_0.htm" target="_top">波特重工</a> <a href="/search/<%=keywordCheck%>_13559_0_0.htm" target="_top">博德</a> <a href="/search/<%=keywordCheck%>_1206_0_0.htm" target="_top">博汇机械</a> <a href="/search/<%=keywordCheck%>_13555_0_0.htm" target="_top">博纳地</a> <a href="/search/<%=keywordCheck%>_13624_0_0.htm" target="_top">博洋</a> <a href="/search/<%=keywordCheck%>_683_0_0.htm" target="_top">德国宝峨</a> <a href="/search/<%=keywordCheck%>_1703_0_0.htm" target="_top">甘肃宝龙</a> <a href="/search/<%=keywordCheck%>_825_0_0.htm" target="_top">湖南搏浪沙</a> <a href="/search/<%=keywordCheck%>_13231_0_0.htm" target="_top">天地奔牛</a> <a href="/search/<%=keywordCheck%>_1108_0_0.htm" target="_top">烟台百财</a> <a href="/search/<%=keywordCheck%>_1108_0_0.htm" target="_top">翼龙</a> <a href="/search/<%=keywordCheck%>_13093_0_0.htm" target="_top">重庆博山</a> <a href="/search/<%=keywordCheck%>_13572_0_0.htm" target="_top">沧田重工</a> <a href="/search/<%=keywordCheck%>_13575_0_0.htm" target="_top">昌世</a> <a href="/search/<%=keywordCheck%>_13578_0_0.htm" target="_top">长春神骏</a> <a href="/search/<%=keywordCheck%>_13142_0_0.htm" target="_top">长高一品</a> <a href="/search/<%=keywordCheck%>_13579_0_0.htm" target="_top">长盛机械</a> <a href="/search/<%=keywordCheck%>_615_0_0.htm" target="_top">长阳机械</a> <a href="/search/<%=keywordCheck%>_148_0_0.htm" target="_top">常林股份</a> <a href="/search/<%=keywordCheck%>_485_0_0.htm" target="_top">朝工</a> <a href="/search/<%=keywordCheck%>_13576_0_0.htm" target="_top">朝阳建工</a> <a href="/search/<%=keywordCheck%>_13574_0_0.htm" target="_top">郴筑</a> <a href="/search/<%=keywordCheck%>_145_0_0.htm" target="_top">成工</a> <a href="/search/<%=keywordCheck%>_1591_0_0.htm" target="_top">楚工龙泰</a> <a href="/search/<%=keywordCheck%>_13573_0_0.htm" target="_top">创一</a> <a href="/search/<%=keywordCheck%>_13094_0_0.htm" target="_top">桂林长海</a> <a href="/search/<%=keywordCheck%>_615_0_0.htm" target="_top">杭州永林</a> <a href="/search/<%=keywordCheck%>_13174_0_0.htm" target="_top">湖南长河</a> <a href="/search/<%=keywordCheck%>_147_0_0.htm" target="_top">四川长起</a> <a href="/search/<%=keywordCheck%>_1716_0_0.htm" target="_top">达刚</a> <a href="/search/<%=keywordCheck%>_13587_0_0.htm" target="_top">达力</a> <a href="/search/<%=keywordCheck%>_13580_0_0.htm" target="_top">达宇重工</a> <a href="/search/<%=keywordCheck%>_162_0_0.htm" target="_top">大地</a> <a href="/search/<%=keywordCheck%>_13584_0_0.htm" target="_top">大方</a> <a href="/search/<%=keywordCheck%>_13592_0_0.htm" target="_top">大宏立</a> <a href="/search/<%=keywordCheck%>_13586_0_0.htm" target="_top">大连</a> <a href="/search/<%=keywordCheck%>_13589_0_0.htm" target="_top">大山路桥</a> <a href="/search/<%=keywordCheck%>_171_0_0.htm" target="_top">大信重工</a> <a href="/search/<%=keywordCheck%>_212_0_0.htm" target="_top">戴纳派克</a> <a href="/search/<%=keywordCheck%>_1243_0_0.htm" target="_top">道辰格</a> <a href="/search/<%=keywordCheck%>_1218_0_0.htm" target="_top">道胜</a> <a href="/search/<%=keywordCheck%>_13588_0_0.htm" target="_top">道维施</a> <a href="/search/<%=keywordCheck%>_151_0_0.htm" target="_top">德工</a> <a href="/search/<%=keywordCheck%>_489_0_0.htm" target="_top">德基机械</a> <a href="/search/<%=keywordCheck%>_13597_0_0.htm" target="_top">德科达</a> <a href="/search/<%=keywordCheck%>_213_0_0.htm" target="_top">德玛格</a> <a href="/search/<%=keywordCheck%>_13598_0_0.htm" target="_top">德通</a> <a href="/search/<%=keywordCheck%>_13595_0_0.htm" target="_top">德亿重工</a> <a href="/search/<%=keywordCheck%>_140_0_0.htm" target="_top">鼎盛重工</a> <a href="/search/<%=keywordCheck%>_14222_0_0.htm" target="_top">东倡机械</a> <a href="/search/<%=keywordCheck%>_1351_0_0.htm" target="_top">东达</a> <a href="/search/<%=keywordCheck%>_1351_0_0.htm" target="_top">东达桩工</a> <a href="/search/<%=keywordCheck%>_1763_0_0.htm" target="_top">东德重工</a> <a href="/search/<%=keywordCheck%>_1187_0_0.htm" target="_top">东方红</a> <a href="/search/<%=keywordCheck%>_13591_0_0.htm" target="_top">东方冶矿</a> <a href="/search/<%=keywordCheck%>_1755_0_0.htm" target="_top">东风</a> <a href="/search/<%=keywordCheck%>_405_0_0.htm" target="_top">东空</a> <a href="/search/<%=keywordCheck%>_14169_0_0.htm" target="_top">东立机械</a> <a href="/search/<%=keywordCheck%>_13583_0_0.htm" target="_top">东泷</a> <a href="/search/<%=keywordCheck%>_13590_0_0.htm" target="_top">东蒙机械</a> <a href="/search/<%=keywordCheck%>_1717_0_0.htm" target="_top">东南机械</a> <a href="/search/<%=keywordCheck%>_163_0_0.htm" target="_top">东岳重工</a> <a href="/search/<%=keywordCheck%>_1098_0_0.htm" target="_top">斗昌</a> <a href="/search/<%=keywordCheck%>_192_0_0.htm" target="_top">斗山</a> <a href="/search/<%=keywordCheck%>_1122_0_0.htm" target="_top">山东大汉</a> <a href="/search/<%=keywordCheck%>_1195_0_0.htm" target="_top">重庆大江</a> <a href="/search/<%=keywordCheck%>_671_0_0.htm" target="_top">方圆集团</a> <a href="/search/<%=keywordCheck%>_1120_0_0.htm" target="_top">丰汇技术</a> <a href="/search/<%=keywordCheck%>_1729_0_0.htm" target="_top">丰田</a> <a href="/search/<%=keywordCheck%>_1188_0_0.htm" target="_top">福大机械</a> <a href="/search/<%=keywordCheck%>_215_0_0.htm" target="_top">福格勒</a> <a href="/search/<%=keywordCheck%>_1183_0_0.htm" target="_top">福工</a> <a href="/search/<%=keywordCheck%>_141_0_0.htm" target="_top">福田雷沃</a> <a href="/search/<%=keywordCheck%>_141_0_0.htm" target="_top">福田雷沃重工</a> <a href="/search/<%=keywordCheck%>_1208_0_0.htm" target="_top">福威重工</a> <a href="/search/<%=keywordCheck%>_165_0_0.htm" target="_top">抚顺起重机</a> <a href="/search/<%=keywordCheck%>_164_0_0.htm" target="_top">抚挖</a> <a href="/search/<%=keywordCheck%>_1225_0_0.htm" target="_top">抚挖锦重</a> <a href="/search/<%=keywordCheck%>_1721_0_0.htm" target="_top">富豪</a> <a href="/search/<%=keywordCheck%>_1888_0_0.htm" target="_top">富亿机械</a> <a href="/search/<%=keywordCheck%>_1124_0_0.htm" target="_top">富友正和</a> <a href="/search/<%=keywordCheck%>_13630_0_0.htm" target="_top">湖南飞涛</a> <a href="/search/<%=keywordCheck%>_682_0_0.htm" target="_top">山东福临</a> <a href="/search/<%=keywordCheck%>_14252_0_0.htm" target="_top">冈研</a> <a href="/search/<%=keywordCheck%>_13604_0_0.htm" target="_top">高达</a> <a href="/search/<%=keywordCheck%>_492_0_0.htm" target="_top">高马科</a> <a href="/search/<%=keywordCheck%>_534_0_0.htm" target="_top">高远路业</a> <a href="/search/<%=keywordCheck%>_1754_0_0.htm" target="_top">高远圣工</a> <a href="/search/<%=keywordCheck%>_13606_0_0.htm" target="_top">格鲁夫</a> <a href="/search/<%=keywordCheck%>_477_0_0.htm" target="_top">格瑞德</a> <a href="/search/<%=keywordCheck%>_13603_0_0.htm" target="_top">格瑞特</a> <a href="/search/<%=keywordCheck%>_423_0_0.htm" target="_top">工兵</a> <a href="/search/<%=keywordCheck%>_776_0_0.htm" target="_top">工兵国际</a> <a href="/search/<%=keywordCheck%>_417_0_0.htm" target="_top">古河</a> <a href="/search/<%=keywordCheck%>_13605_0_0.htm" target="_top">谷登机械</a> <a href="/search/<%=keywordCheck%>_424_0_0.htm" target="_top">广林</a> <a href="/search/<%=keywordCheck%>_1116_0_0.htm" target="_top">广西建机</a> <a href="/search/<%=keywordCheck%>_13608_0_0.htm" target="_top">国发</a> <a href="/search/<%=keywordCheck%>_1369_0_0.htm" target="_top">国机重工</a> <a href="/search/<%=keywordCheck%>_776_0_0.htm" target="_top">连云港工兵</a> <a href="/search/<%=keywordCheck%>_776_0_0.htm" target="_top">连云港工兵GBPSC</a> </div>
      <div class="pllist"> <a class="plfl"><span style="color:#3355AC"> H-I-J-K-L-M-N </span></a> <br/>
        <a href="/search/<%=keywordCheck%>_1109_0_0.htm" target="_top">海斗</a> <a href="/search/<%=keywordCheck%>_13611_0_0.htm" target="_top">海华筑机</a> <a href="/search/<%=keywordCheck%>_203_0_0.htm" target="_top">海诺</a> <a href="/search/<%=keywordCheck%>_1091_0_0.htm" target="_top">海山</a> <a href="/search/<%=keywordCheck%>_1733_0_0.htm" target="_top">海斯特</a> <a href="/search/<%=keywordCheck%>_1105_0_0.htm" target="_top">海特</a> <a href="/search/<%=keywordCheck%>_13620_0_0.htm" target="_top">海天路矿</a> <a href="/search/<%=keywordCheck%>_1128_0_0.htm" target="_top">海威斯帝尔</a> <a href="/search/<%=keywordCheck%>_664_0_0.htm" target="_top">海州机械</a> <a href="/search/<%=keywordCheck%>_415_0_0.htm" target="_top">韩川</a> <a href="/search/<%=keywordCheck%>_1112_0_0.htm" target="_top">韩工</a> <a href="/search/<%=keywordCheck%>_14253_0_0.htm" target="_top">韩农</a> <a href="/search/<%=keywordCheck%>_421_0_0.htm" target="_top">韩宇</a> <a href="/search/<%=keywordCheck%>_216_0_0.htm" target="_top">悍马</a> <a href="/search/<%=keywordCheck%>_426_0_0.htm" target="_top">悍狮</a> <a href="/search/<%=keywordCheck%>_814_0_0.htm" target="_top">捍宇</a> <a href="/search/<%=keywordCheck%>_1734_0_0.htm" target="_top">杭叉</a> <a href="/search/<%=keywordCheck%>_13628_0_0.htm" target="_top">杭重威施诺</a> <a href="/search/<%=keywordCheck%>_1724_0_0.htm" target="_top">杭州市政</a> <a href="/search/<%=keywordCheck%>_1525_0_0.htm" target="_top">合矿</a> <a href="/search/<%=keywordCheck%>_158_0_0.htm" target="_top">合力</a> <a href="/search/<%=keywordCheck%>_13632_0_0.htm" target="_top">和盛达</a> <a href="/search/<%=keywordCheck%>_1103_0_0.htm" target="_top">黑金钢</a> <a href="/search/<%=keywordCheck%>_13623_0_0.htm" target="_top">恒端</a> <a href="/search/<%=keywordCheck%>_13641_0_0.htm" target="_top">恒康</a> <a href="/search/<%=keywordCheck%>_1761_0_0.htm" target="_top">恒诺机械</a> <a href="/search/<%=keywordCheck%>_1508_0_0.htm" target="_top">恒日重工</a> <a href="/search/<%=keywordCheck%>_1735_0_0.htm" target="_top">恒润高科</a> <a href="/search/<%=keywordCheck%>_13614_0_0.htm" target="_top">恒升</a> <a href="/search/<%=keywordCheck%>_170_0_0.htm" target="_top">恒特</a> <a href="/search/<%=keywordCheck%>_1147_0_0.htm" target="_top">恒天九五</a> <a href="/search/<%=keywordCheck%>_13636_0_0.htm" target="_top">恒兴机械</a> <a href="/search/<%=keywordCheck%>_13096_0_0.htm" target="_top">恒至凿岩</a> <a href="/search/<%=keywordCheck%>_13613_0_0.htm" target="_top">红旗</a> <a href="/search/<%=keywordCheck%>_13639_0_0.htm" target="_top">宏昌</a> <a href="/search/<%=keywordCheck%>_13633_0_0.htm" target="_top">宏达</a> <a href="/search/<%=keywordCheck%>_13609_0_0.htm" target="_top">宏大</a> <a href="/search/<%=keywordCheck%>_13629_0_0.htm" target="_top">宏建机械</a> <a href="/search/<%=keywordCheck%>_13618_0_0.htm" target="_top">宏力</a> <a href="/search/<%=keywordCheck%>_217_0_0.htm" target="_top">鸿达</a> <a href="/search/<%=keywordCheck%>_202_0_0.htm" target="_top">鸿得利重工</a> <a href="/search/<%=keywordCheck%>_13626_0_0.htm" target="_top">鸿源</a> <a href="/search/<%=keywordCheck%>_819_0_0.htm" target="_top">虎霸集团</a> <a href="/search/<%=keywordCheck%>_13617_0_0.htm" target="_top">虎力</a> <a href="/search/<%=keywordCheck%>_13577_0_0.htm" target="_top">华贝尔</a> <a href="/search/<%=keywordCheck%>_13627_0_0.htm" target="_top">华丰</a> <a href="/search/<%=keywordCheck%>_13634_0_0.htm" target="_top">华光机械</a> <a href="/search/<%=keywordCheck%>_206_0_0.htm" target="_top">华力重工</a> <a href="/search/<%=keywordCheck%>_13640_0_0.htm" target="_top">华南重工</a> <a href="/search/<%=keywordCheck%>_1725_0_0.htm" target="_top">华骐</a> <a href="/search/<%=keywordCheck%>_1727_0_0.htm" target="_top">华强京工</a> <a href="/search/<%=keywordCheck%>_1731_0_0.htm" target="_top">华山</a> <a href="/search/<%=keywordCheck%>_1220_0_0.htm" target="_top">华通道胜</a> <a href="/search/<%=keywordCheck%>_1526_0_0.htm" target="_top">华伟重工</a> <a href="/search/<%=keywordCheck%>_1512_0_0.htm" target="_top">华中建机</a> <a href="/search/<%=keywordCheck%>_13625_0_0.htm" target="_top">华重</a> <a href="/search/<%=keywordCheck%>_13622_0_0.htm" target="_top">惠工</a> <a href="/search/<%=keywordCheck%>_14283_0_0.htm" target="_top">惠龙机械</a> <a href="/search/<%=keywordCheck%>_13616_0_0.htm" target="_top">惠山</a> <a href="/search/<%=keywordCheck%>_203_0_0.htm" target="_top">辽宁海诺</a> <a href="/search/<%=keywordCheck%>_845_0_0.htm" target="_top">宁波韩锐</a> <a href="/search/<%=keywordCheck%>_217_0_0.htm" target="_top">山东鸿达</a> <a href="/search/<%=keywordCheck%>_1176_0_0.htm" target="_top">威海海泰</a> <a href="/search/<%=keywordCheck%>_14111_0_0.htm" target="_top">无锡环球</a> <a href="/search/<%=keywordCheck%>_893_0_0.htm" target="_top">烟台海德</a> <a href="/search/<%=keywordCheck%>_1091_0_0.htm" target="_top">烟台海山</a> <a href="/search/<%=keywordCheck%>_177_0_0.htm" target="_top">JCB</a> <a href="/search/<%=keywordCheck%>_1127_0_0.htm" target="_top">甘肃建工</a> <a href="/search/<%=keywordCheck%>_1159_0_0.htm" target="_top">广州京龙</a> <a href="/search/<%=keywordCheck%>_554_0_0.htm" target="_top">吉公</a> <a href="/search/<%=keywordCheck%>_1524_0_0.htm" target="_top">吉尼</a> <a href="/search/<%=keywordCheck%>_1229_0_0.htm" target="_top">吉星</a> <a href="/search/<%=keywordCheck%>_1157_0_0.htm" target="_top">济南吉宏</a> <a href="/search/<%=keywordCheck%>_1179_0_0.htm" target="_top">济南建机</a> <a href="/search/<%=keywordCheck%>_13655_0_0.htm" target="_top">冀中能源</a> <a href="/search/<%=keywordCheck%>_189_0_0.htm" target="_top">加藤</a> <a href="/search/<%=keywordCheck%>_13645_0_0.htm" target="_top">佳乐</a> <a href="/search/<%=keywordCheck%>_13654_0_0.htm" target="_top">佳一</a> <a href="/search/<%=keywordCheck%>_1145_0_0.htm" target="_top">佳弋建机</a> <a href="/search/<%=keywordCheck%>_13656_0_0.htm" target="_top">嘉成</a> <a href="/search/<%=keywordCheck%>_13176_0_0.htm" target="_top">嘉和重工</a> <a href="/search/<%=keywordCheck%>_407_0_0.htm" target="_top">甲南</a> <a href="/search/<%=keywordCheck%>_1352_0_0.htm" target="_top">建德机械</a> <a href="/search/<%=keywordCheck%>_13659_0_0.htm" target="_top">建丰机械</a> <a href="/search/<%=keywordCheck%>_1736_0_0.htm" target="_top">建研机械</a> <a href="/search/<%=keywordCheck%>_1357_0_0.htm" target="_top">建友机械</a> <a href="/search/<%=keywordCheck%>_479_0_0.htm" target="_top">江淮重工</a> <a href="/search/<%=keywordCheck%>_13643_0_0.htm" target="_top">江加</a> <a href="/search/<%=keywordCheck%>_487_0_0.htm" target="_top">江麓</a> <a href="/search/<%=keywordCheck%>_816_0_0.htm" target="_top">江苏骏马</a> <a href="/search/<%=keywordCheck%>_13647_0_0.htm" target="_top">江苏路通</a> <a href="/search/<%=keywordCheck%>_1355_0_0.htm" target="_top">矫马</a> <a href="/search/<%=keywordCheck%>_13657_0_0.htm" target="_top">金城</a> <a href="/search/<%=keywordCheck%>_13651_0_0.htm" target="_top">金茂</a> <a href="/search/<%=keywordCheck%>_13653_0_0.htm" target="_top">金源</a> <a href="/search/<%=keywordCheck%>_1737_0_0.htm" target="_top">金正神力</a> <a href="/search/<%=keywordCheck%>_1132_0_0.htm" target="_top">锦城建机</a> <a href="/search/<%=keywordCheck%>_1586_0_0.htm" target="_top">劲工</a> <a href="/search/<%=keywordCheck%>_172_0_0.htm" target="_top">晋工</a> <a href="/search/<%=keywordCheck%>_1759_0_0.htm" target="_top">京城长野</a> <a href="/search/<%=keywordCheck%>_166_0_0.htm" target="_top">京城重工</a> <a href="/search/<%=keywordCheck%>_401_0_0.htm" target="_top">惊天液压</a> <a href="/search/<%=keywordCheck%>_13649_0_0.htm" target="_top">精功</a> <a href="/search/<%=keywordCheck%>_13650_0_0.htm" target="_top">靖江（JJCC）</a> <a href="/search/<%=keywordCheck%>_187_0_0.htm" target="_top">久保田</a> <a href="/search/<%=keywordCheck%>_1232_0_0.htm" target="_top">久工</a> <a href="/search/<%=keywordCheck%>_13652_0_0.htm" target="_top">久润</a> <a href="/search/<%=keywordCheck%>_197_0_0.htm" target="_top">酒井</a> <a href="/search/<%=keywordCheck%>_1193_0_0.htm" target="_top">巨超重工</a> <a href="/search/<%=keywordCheck%>_13648_0_0.htm" target="_top">聚龙</a> <a href="/search/<%=keywordCheck%>_679_0_0.htm" target="_top">军恒斯帕克</a> <a href="/search/<%=keywordCheck%>_1142_0_0.htm" target="_top">娄底南方</a> <a href="/search/<%=keywordCheck%>_1094_0_0.htm" target="_top">上海工程机械厂</a> <a href="/search/<%=keywordCheck%>_1130_0_0.htm" target="_top">无锡巨神</a> <a href="/search/<%=keywordCheck%>_681_0_0.htm" target="_top">浙江军联</a> <a href="/search/<%=keywordCheck%>_1135_0_0.htm" target="_top">包头凯捷</a> <a href="/search/<%=keywordCheck%>_160_0_0.htm" target="_top">广西开元</a> <a href="/search/<%=keywordCheck%>_13667_0_0.htm" target="_top">卡萨阁蓝地</a> <a href="/search/<%=keywordCheck%>_174_0_0.htm" target="_top">卡特彼勒</a> <a href="/search/<%=keywordCheck%>_178_0_0.htm" target="_top">卡特重工</a> <a href="/search/<%=keywordCheck%>_14247_0_0.htm" target="_top">开普动力</a> <a href="/search/<%=keywordCheck%>_1322_0_0.htm" target="_top">凯雷</a> <a href="/search/<%=keywordCheck%>_13661_0_0.htm" target="_top">凯联</a> <a href="/search/<%=keywordCheck%>_480_0_0.htm" target="_top">凯莫尔</a> <a href="/search/<%=keywordCheck%>_455_0_0.htm" target="_top">凯斯</a> <a href="/search/<%=keywordCheck%>_1756_0_0.htm" target="_top">凯威</a> <a href="/search/<%=keywordCheck%>_13682_0_0.htm" target="_top">凯兴</a> <a href="/search/<%=keywordCheck%>_1118_0_0.htm" target="_top">科曼萨 杰牌</a> <a href="/search/<%=keywordCheck%>_13664_0_0.htm" target="_top">科尼乐重工</a> <a href="/search/<%=keywordCheck%>_13663_0_0.htm" target="_top">科泰重工</a> <a href="/search/<%=keywordCheck%>_14243_0_0.htm" target="_top">科友机械</a> <a href="/search/<%=keywordCheck%>_13666_0_0.htm" target="_top">科筑</a> <a href="/search/<%=keywordCheck%>_1779_0_0.htm" target="_top">克拉士</a> <a href="/search/<%=keywordCheck%>_13665_0_0.htm" target="_top">克瑞</a> <a href="/search/<%=keywordCheck%>_14265_0_0.htm" target="_top">孔山重工</a> <a href="/search/<%=keywordCheck%>_13668_0_0.htm" target="_top">坤宇重装</a> <a href="/search/<%=keywordCheck%>_1144_0_0.htm" target="_top">昆明力神</a> <a href="/search/<%=keywordCheck%>_13705_0_0.htm" target="_top">青岛科尼乐</a> <a href="/search/<%=keywordCheck%>_824_0_0.htm" target="_top">6409塔吊</a> <a href="/search/<%=keywordCheck%>_13631_0_0.htm" target="_top">河南路畅</a> <a href="/search/<%=keywordCheck%>_13097_0_0.htm" target="_top">莱工</a> <a href="/search/<%=keywordCheck%>_1194_0_0.htm" target="_top">蓝翔重工</a> <a href="/search/<%=keywordCheck%>_543_0_0.htm" target="_top">雷奥科技</a> <a href="/search/<%=keywordCheck%>_1718_0_0.htm" target="_top">雷萨重机</a> <a href="/search/<%=keywordCheck%>_13681_0_0.htm" target="_top">黎明</a> <a href="/search/<%=keywordCheck%>_412_0_0.htm" target="_top">力博士</a> <a href="/search/<%=keywordCheck%>_13678_0_0.htm" target="_top">力尔美</a> <a href="/search/<%=keywordCheck%>_13683_0_0.htm" target="_top">力士</a> <a href="/search/<%=keywordCheck%>_157_0_0.htm" target="_top">力士德</a> <a href="/search/<%=keywordCheck%>_13687_0_0.htm" target="_top">立藤</a> <a href="/search/<%=keywordCheck%>_13676_0_0.htm" target="_top">立新</a> <a href="/search/<%=keywordCheck%>_179_0_0.htm" target="_top">利勃海尔</a> <a href="/search/<%=keywordCheck%>_13677_0_0.htm" target="_top">利洲</a> <a href="/search/<%=keywordCheck%>_13684_0_0.htm" target="_top">联丰机械</a> <a href="/search/<%=keywordCheck%>_13686_0_0.htm" target="_top">辽原筑机</a> <a href="/search/<%=keywordCheck%>_204_0_0.htm" target="_top">辽筑</a> <a href="/search/<%=keywordCheck%>_1742_0_0.htm" target="_top">林德</a> <a href="/search/<%=keywordCheck%>_13680_0_0.htm" target="_top">林泰阁</a> <a href="/search/<%=keywordCheck%>_137_0_0.htm" target="_top">临工</a> <a href="/search/<%=keywordCheck%>_1509_0_0.htm" target="_top">灵升机械</a> <a href="/search/<%=keywordCheck%>_1181_0_0.htm" target="_top">凌虹建设机械</a> <a href="/search/<%=keywordCheck%>_1180_0_0.htm" target="_top">凌云建机</a> <a href="/search/<%=keywordCheck%>_136_0_0.htm" target="_top">柳工</a> <a href="/search/<%=keywordCheck%>_135_0_0.htm" target="_top">龙工</a> <a href="/search/<%=keywordCheck%>_14233_0_0.htm" target="_top">龙兴机械</a> <a href="/search/<%=keywordCheck%>_1739_0_0.htm" target="_top">鲁青</a> <a href="/search/<%=keywordCheck%>_14257_0_0.htm" target="_top">鲁宇重工</a> <a href="/search/<%=keywordCheck%>_688_0_0.htm" target="_top">鲁岳</a> <a href="/search/<%=keywordCheck%>_207_0_0.htm" target="_top">陆德筑机</a> <a href="/search/<%=keywordCheck%>_13688_0_0.htm" target="_top">路宝</a> <a href="/search/<%=keywordCheck%>_13679_0_0.htm" target="_top">路达</a> <a href="/search/<%=keywordCheck%>_13669_0_0.htm" target="_top">路大</a> <a href="/search/<%=keywordCheck%>_13673_0_0.htm" target="_top">路德克</a> <a href="/search/<%=keywordCheck%>_13670_0_0.htm" target="_top">路虹</a> <a href="/search/<%=keywordCheck%>_13675_0_0.htm" target="_top">路维</a> <a href="/search/<%=keywordCheck%>_13674_0_0.htm" target="_top">路星</a> <a href="/search/<%=keywordCheck%>_552_0_0.htm" target="_top">绿地</a> <a href="/search/<%=keywordCheck%>_1709_0_0.htm" target="_top">滦州重工</a> <a href="/search/<%=keywordCheck%>_1231_0_0.htm" target="_top">洛建</a> <a href="/search/<%=keywordCheck%>_673_0_0.htm" target="_top">洛阳路通</a> <a href="/search/<%=keywordCheck%>_13118_0_0.htm" target="_top">山东鲁工</a> <a href="/search/<%=keywordCheck%>_1509_0_0.htm" target="_top">厦门灵升</a> <a href="/search/<%=keywordCheck%>_1231_0_0.htm" target="_top">一拖</a> <a href="/search/<%=keywordCheck%>_13689_0_0.htm" target="_top">玛连尼</a> <a href="/search/<%=keywordCheck%>_418_0_0.htm" target="_top">麦恩</a> <a href="/search/<%=keywordCheck%>_13693_0_0.htm" target="_top">曼尼通</a> <a href="/search/<%=keywordCheck%>_14262_0_0.htm" target="_top">曼托瓦尼</a> <a href="/search/<%=keywordCheck%>_13692_0_0.htm" target="_top">梅狮</a> <a href="/search/<%=keywordCheck%>_1743_0_0.htm" target="_top">美科斯</a> <a href="/search/<%=keywordCheck%>_13095_0_0.htm" target="_top">美通筑机</a> <a href="/search/<%=keywordCheck%>_13696_0_0.htm" target="_top">美卓</a> <a href="/search/<%=keywordCheck%>_422_0_0.htm" target="_top">猛士</a> <a href="/search/<%=keywordCheck%>_13697_0_0.htm" target="_top">闽工</a> <a href="/search/<%=keywordCheck%>_13691_0_0.htm" target="_top">闽科</a> <a href="/search/<%=keywordCheck%>_13737_0_0.htm" target="_top">明山路桥</a> <a href="/search/<%=keywordCheck%>_1125_0_0.htm" target="_top">明威塔机</a> <a href="/search/<%=keywordCheck%>_13694_0_0.htm" target="_top">摩纳凯</a> <a href="/search/<%=keywordCheck%>_1126_0_0.htm" target="_top">牡丹江</a> <a href="/search/<%=keywordCheck%>_13695_0_0.htm" target="_top">牡丹江专用汽车</a> <a href="/search/<%=keywordCheck%>_13700_0_0.htm" target="_top">纳科重工</a> <a href="/search/<%=keywordCheck%>_1209_0_0.htm" target="_top">南车北京时代</a> <a href="/search/<%=keywordCheck%>_200_0_0.htm" target="_top">南方路机</a> <a href="/search/<%=keywordCheck%>_1134_0_0.htm" target="_top">南京绿野</a> <a href="/search/<%=keywordCheck%>_13698_0_0.htm" target="_top">南侨</a> <a href="/search/<%=keywordCheck%>_169_0_0.htm" target="_top">南特</a> <a href="/search/<%=keywordCheck%>_1748_0_0.htm" target="_top">农友</a> <a href="/search/<%=keywordCheck%>_14186_0_0.htm" target="_top">诺尔</a> <a href="/search/<%=keywordCheck%>_1585_0_0.htm" target="_top">诺克机械</a> <a href="/search/<%=keywordCheck%>_13699_0_0.htm" target="_top">诺力</a> <a href="/search/<%=keywordCheck%>_1585_0_0.htm" target="_top">诺森机械</a> </div>
      <div class="pllist"> <a class="plfl"><span style="color:#3355AC"> O-P-Q-R-S-T </span></a><br/>
        <a href="/search/<%=keywordCheck%>_13702_0_0.htm" target="_top">欧霸重工</a> <a href="/search/<%=keywordCheck%>_13701_0_0.htm" target="_top">欧亚机械</a> <a href="/search/<%=keywordCheck%>_199_0_0.htm" target="_top">普茨迈斯特</a> <a href="/search/<%=keywordCheck%>_403_0_0.htm" target="_top">普堃韩泰克</a> <a href="/search/<%=keywordCheck%>_486_0_0.htm" target="_top">普什重机</a> <a href="/search/<%=keywordCheck%>_14217_0_0.htm" target="_top">三一帕尔菲格</a> <a href="/search/<%=keywordCheck%>_156_0_0.htm" target="_top">上海彭浦</a> <a href="/search/<%=keywordCheck%>_1184_0_0.htm" target="_top">奇瑞迪凯重科</a> <a href="/search/<%=keywordCheck%>_14232_0_0.htm" target="_top">千里马</a> <a href="/search/<%=keywordCheck%>_582_0_0.htm" target="_top">勤牛</a> <a href="/search/<%=keywordCheck%>_13708_0_0.htm" target="_top">青山</a> <a href="/search/<%=keywordCheck%>_1750_0_0.htm" target="_top">全工机械</a> <a href="/search/<%=keywordCheck%>_198_0_0.htm" target="_top">全进重工</a> <a href="/search/<%=keywordCheck%>_13704_0_0.htm" target="_top">泉成机械</a> <a href="/search/<%=keywordCheck%>_13706_0_0.htm" target="_top">泉工</a> <a href="/search/<%=keywordCheck%>_13703_0_0.htm" target="_top">泉筑</a> <a href="/search/<%=keywordCheck%>_13707_0_0.htm" target="_top">群峰智能</a> <a href="/search/<%=keywordCheck%>_1139_0_0.htm" target="_top">四川强力</a> <a href="/search/<%=keywordCheck%>_686_0_0.htm" target="_top">厦门七天阳</a> <a href="/search/<%=keywordCheck%>_196_0_0.htm" target="_top">日工</a> <a href="/search/<%=keywordCheck%>_184_0_0.htm" target="_top">日立</a> <a href="/search/<%=keywordCheck%>_173_0_0.htm" target="_top">熔盛机械</a> <a href="/search/<%=keywordCheck%>_409_0_0.htm" target="_top">锐马</a> <a href="/search/<%=keywordCheck%>_425_0_0.htm" target="_top">瑞工</a> <a href="/search/<%=keywordCheck%>_13709_0_0.htm" target="_top">瑞龙重工(欧盟技术)</a> <a href="/search/<%=keywordCheck%>_1216_0_0.htm" target="_top">瑞诺</a> <a href="/search/<%=keywordCheck%>_14211_0_0.htm" target="_top">润邦机械</a> <a href="/search/<%=keywordCheck%>_14281_0_0.htm" target="_top">若鞍亿科技</a> <a href="/search/<%=keywordCheck%>_805_0_0.htm" target="_top">烟台锐泰</a> <a href="/search/<%=keywordCheck%>_810_0_0.htm" target="_top">烟台润弘</a> <a href="/search/<%=keywordCheck%>_741_0_0.htm" target="_top">江苏上騏</a> <a href="/search/<%=keywordCheck%>_13724_0_0.htm" target="_top">赛格玛</a> <a href="/search/<%=keywordCheck%>_1762_0_0.htm" target="_top">赛力斯特</a> <a href="/search/<%=keywordCheck%>_13717_0_0.htm" target="_top">赛奇</a> <a href="/search/<%=keywordCheck%>_868_0_0.htm" target="_top">赛通重工</a> <a href="/search/<%=keywordCheck%>_14248_0_0.htm" target="_top">赛宇重工</a> <a href="/search/<%=keywordCheck%>_14187_0_0.htm" target="_top">三驾机械</a> <a href="/search/<%=keywordCheck%>_13740_0_0.htm" target="_top">三力机械</a> <a href="/search/<%=keywordCheck%>_13749_0_0.htm" target="_top">三笠</a> <a href="/search/<%=keywordCheck%>_13732_0_0.htm" target="_top">三联机械</a> <a href="/search/<%=keywordCheck%>_13721_0_0.htm" target="_top">三菱</a> <a href="/search/<%=keywordCheck%>_13748_0_0.htm" target="_top">三隆重工</a> <a href="/search/<%=keywordCheck%>_13725_0_0.htm" target="_top">三洋重工</a> <a href="/search/<%=keywordCheck%>_133_0_0.htm" target="_top">三一</a> <a href="/search/<%=keywordCheck%>_1711_0_0.htm" target="_top">扫地王</a> <a href="/search/<%=keywordCheck%>_1711_0_0.htm" target="_top">扫地王集团</a> <a href="/search/<%=keywordCheck%>_626_0_0.htm" target="_top">森田重机</a> <a href="/search/<%=keywordCheck%>_13730_0_0.htm" target="_top">森源</a> <a href="/search/<%=keywordCheck%>_13713_0_0.htm" target="_top">森远</a> <a href="/search/<%=keywordCheck%>_1221_0_0.htm" target="_top">山宝</a> <a href="/search/<%=keywordCheck%>_14280_0_0.htm" target="_top">山东海宏</a> <a href="/search/<%=keywordCheck%>_1123_0_0.htm" target="_top">山东华夏</a> <a href="/search/<%=keywordCheck%>_13744_0_0.htm" target="_top">山东汇强</a> <a href="/search/<%=keywordCheck%>_13747_0_0.htm" target="_top">山东明龙</a> <a href="/search/<%=keywordCheck%>_1722_0_0.htm" target="_top">山东威猛</a> <a href="/search/<%=keywordCheck%>_138_0_0.htm" target="_top">山工</a> <a href="/search/<%=keywordCheck%>_142_0_0.htm" target="_top">山河智能</a> <a href="/search/<%=keywordCheck%>_454_0_0.htm" target="_top">山猫</a> <a href="/search/<%=keywordCheck%>_13731_0_0.htm" target="_top">山美</a> <a href="/search/<%=keywordCheck%>_1304_0_0.htm" target="_top">山特维克</a> <a href="/search/<%=keywordCheck%>_144_0_0.htm" target="_top">山推</a> <a href="/search/<%=keywordCheck%>_13723_0_0.htm" target="_top">山推格林</a> <a href="/search/<%=keywordCheck%>_1207_0_0.htm" target="_top">山挖重工</a> <a href="/search/<%=keywordCheck%>_152_0_0.htm" target="_top">山重建机</a> <a href="/search/<%=keywordCheck%>_668_0_0.htm" target="_top">陕建机械</a> <a href="/search/<%=keywordCheck%>_1753_0_0.htm" target="_top">陕汽</a> <a href="/search/<%=keywordCheck%>_13728_0_0.htm" target="_top">陕西科尼乐</a> <a href="/search/<%=keywordCheck%>_691_0_0.htm" target="_top">上海华建</a> <a href="/search/<%=keywordCheck%>_13735_0_0.htm" target="_top">上海建冶</a> <a href="/search/<%=keywordCheck%>_201_0_0.htm" target="_top">上海金泰</a> <a href="/search/<%=keywordCheck%>_211_0_0.htm" target="_top">上海施维英</a> <a href="/search/<%=keywordCheck%>_13733_0_0.htm" target="_top">上海威力特</a> <a href="/search/<%=keywordCheck%>_13715_0_0.htm" target="_top">上海西芝</a> <a href="/search/<%=keywordCheck%>_13718_0_0.htm" target="_top">上力重工</a> <a href="/search/<%=keywordCheck%>_1113_0_0.htm" target="_top">神斧</a> <a href="/search/<%=keywordCheck%>_183_0_0.htm" target="_top">神钢</a> <a href="/search/<%=keywordCheck%>_1523_0_0.htm" target="_top">神马科技</a> <a href="/search/<%=keywordCheck%>_14235_0_0.htm" target="_top">神娃机械</a> <a href="/search/<%=keywordCheck%>_13746_0_0.htm" target="_top">沈阳广成</a> <a href="/search/<%=keywordCheck%>_830_0_0.htm" target="_top">沈阳三洋</a> <a href="/search/<%=keywordCheck%>_1720_0_0.htm" target="_top">沈阳山河</a> <a href="/search/<%=keywordCheck%>_1090_0_0.htm" target="_top">盛利达</a> <a href="/search/<%=keywordCheck%>_618_0_0.htm" target="_top">盛隆</a> <a href="/search/<%=keywordCheck%>_190_0_0.htm" target="_top">石川岛</a> <a href="/search/<%=keywordCheck%>_168_0_0.htm" target="_top">石煤</a> <a href="/search/<%=keywordCheck%>_13727_0_0.htm" target="_top">世邦</a> <a href="/search/<%=keywordCheck%>_14255_0_0.htm" target="_top">世工机械</a> <a href="/search/<%=keywordCheck%>_13710_0_0.htm" target="_top">世联</a> <a href="/search/<%=keywordCheck%>_14251_0_0.htm" target="_top">世鑫源机械</a> <a href="/search/<%=keywordCheck%>_413_0_0.htm" target="_top">世运</a> <a href="/search/<%=keywordCheck%>_13711_0_0.htm" target="_top">仕高玛</a> <a href="/search/<%=keywordCheck%>_13714_0_0.htm" target="_top">首钢泰晟</a> <a href="/search/<%=keywordCheck%>_13719_0_0.htm" target="_top">双力</a> <a href="/search/<%=keywordCheck%>_13745_0_0.htm" target="_top">双牛</a> <a href="/search/<%=keywordCheck%>_419_0_0.htm" target="_top">水山</a> <a href="/search/<%=keywordCheck%>_14300_0_0.htm" target="_top">水山（民盛）</a> <a href="/search/<%=keywordCheck%>_13729_0_0.htm" target="_top">思嘉特</a> <a href="/search/<%=keywordCheck%>_13751_0_0.htm" target="_top">思拓瑞克</a> <a href="/search/<%=keywordCheck%>_13722_0_0.htm" target="_top">斯贝柯</a> <a href="/search/<%=keywordCheck%>_1102_0_0.htm" target="_top">斯达格思</a> <a href="/search/<%=keywordCheck%>_14279_0_0.htm" target="_top">斯泰克</a> <a href="/search/<%=keywordCheck%>_1117_0_0.htm" target="_top">四川建机</a> <a href="/search/<%=keywordCheck%>_13742_0_0.htm" target="_top">四通重工</a> <a href="/search/<%=keywordCheck%>_13739_0_0.htm" target="_top">嵩山重工</a> <a href="/search/<%=keywordCheck%>_868_0_0.htm" target="_top">徐州赛通</a> <a href="/search/<%=keywordCheck%>_1227_0_0.htm" target="_top">中国现代</a> <a href="/search/<%=keywordCheck%>_1138_0_0.htm" target="_top">重庆升力</a> <a href="/search/<%=keywordCheck%>_14221_0_0.htm" target="_top">TCM</a> <a href="/search/<%=keywordCheck%>_774_0_0.htm" target="_top">长沙天为</a> <a href="/search/<%=keywordCheck%>_1719_0_0.htm" target="_top">德威土行孙</a> <a href="/search/<%=keywordCheck%>_14261_0_0.htm" target="_top">江苏泰信</a> <a href="/search/<%=keywordCheck%>_827_0_0.htm" target="_top">上海腾迈</a> <a href="/search/<%=keywordCheck%>_1730_0_0.htm" target="_top">台励福</a> <a href="/search/<%=keywordCheck%>_538_0_0.htm" target="_top">太腾机械</a> <a href="/search/<%=keywordCheck%>_1728_0_0.htm" target="_top">泰安鲁能</a> <a href="/search/<%=keywordCheck%>_404_0_0.htm" target="_top">泰戈</a> <a href="/search/<%=keywordCheck%>_406_0_0.htm" target="_top">泰科</a> <a href="/search/<%=keywordCheck%>_1353_0_0.htm" target="_top">泰石克</a> <a href="/search/<%=keywordCheck%>_176_0_0.htm" target="_top">特雷克斯</a> <a href="/search/<%=keywordCheck%>_476_0_0.htm" target="_top">天地重工</a> <a href="/search/<%=keywordCheck%>_13754_0_0.htm" target="_top">天顺长城</a> <a href="/search/<%=keywordCheck%>_13755_0_0.htm" target="_top">天宇</a> <a href="/search/<%=keywordCheck%>_13752_0_0.htm" target="_top">田中铁工</a> <a href="/search/<%=keywordCheck%>_620_0_0.htm" target="_top">铁兵</a> <a href="/search/<%=keywordCheck%>_1758_0_0.htm" target="_top">铁建重工</a> <a href="/search/<%=keywordCheck%>_218_0_0.htm" target="_top">铁拓机械</a> <a href="/search/<%=keywordCheck%>_1726_0_0.htm" target="_top">通亚汽车</a> <a href="/search/<%=keywordCheck%>_1211_0_0.htm" target="_top">同力重工</a> <a href="/search/<%=keywordCheck%>_13753_0_0.htm" target="_top">土力机械</a> <a href="/search/<%=keywordCheck%>_210_0_0.htm" target="_top">拓能重机</a> <a href="/search/<%=keywordCheck%>_1760_0_0.htm" target="_top">无锡泰特</a> </div>
      <div class="pllist"> <a class="plfl"><span style="color:#3355AC"> U-V-W-X-Y-Z </span></a> <br/>
        <a href="/search/<%=keywordCheck%>_614_0_0.htm" target="_top">万邦重科</a> <a href="/search/<%=keywordCheck%>_1140_0_0.htm" target="_top">威海固恒</a> <a href="/search/<%=keywordCheck%>_1189_0_0.htm" target="_top">威肯</a> <a href="/search/<%=keywordCheck%>_491_0_0.htm" target="_top">威猛</a> <a href="/search/<%=keywordCheck%>_1738_0_0.htm" target="_top">威盛</a> <a href="/search/<%=keywordCheck%>_14256_0_0.htm" target="_top">威源机械</a> <a href="/search/<%=keywordCheck%>_214_0_0.htm" target="_top">维特根</a> <a href="/search/<%=keywordCheck%>_14263_0_0.htm" target="_top">潍柴特种车</a> <a href="/search/<%=keywordCheck%>_149_0_0.htm" target="_top">沃得重工</a> <a href="/search/<%=keywordCheck%>_662_0_0.htm" target="_top">沃尔华</a> <a href="/search/<%=keywordCheck%>_175_0_0.htm" target="_top">沃尔沃</a> <a href="/search/<%=keywordCheck%>_1160_0_0.htm" target="_top">五羊建机</a> <a href="/search/<%=keywordCheck%>_680_0_0.htm" target="_top">宜兴巍宇</a> <a href="/search/<%=keywordCheck%>_687_0_0.htm" target="_top">无锡雪桃</a> <a href="/search/<%=keywordCheck%>_13778_0_0.htm" target="_top">西安路邦</a> <a href="/search/<%=keywordCheck%>_1589_0_0.htm" target="_top">西贝</a> <a href="/search/<%=keywordCheck%>_13777_0_0.htm" target="_top">西尔玛</a> <a href="/search/<%=keywordCheck%>_13177_0_0.htm" target="_top">西林</a> <a href="/search/<%=keywordCheck%>_623_0_0.htm" target="_top">犀牛重工</a> <a href="/search/<%=keywordCheck%>_13786_0_0.htm" target="_top">夏洲重工</a> <a href="/search/<%=keywordCheck%>_139_0_0.htm" target="_top">厦工</a> <a href="/search/<%=keywordCheck%>_13175_0_0.htm" target="_top">厦门金华</a> <a href="/search/<%=keywordCheck%>_13784_0_0.htm" target="_top">厦强</a> <a href="/search/<%=keywordCheck%>_1744_0_0.htm" target="_top">厦盛</a> <a href="/search/<%=keywordCheck%>_13783_0_0.htm" target="_top">厦装</a> <a href="/search/<%=keywordCheck%>_410_0_0.htm" target="_top">先锋</a> <a href="/search/<%=keywordCheck%>_194_0_0.htm" target="_top">现代</a> <a href="/search/<%=keywordCheck%>_1359_0_0.htm" target="_top">现代（山东）</a> <a href="/search/<%=keywordCheck%>_1741_0_0.htm" target="_top">小橋</a> <a href="/search/<%=keywordCheck%>_182_0_0.htm" target="_top">小松</a> <a href="/search/<%=keywordCheck%>_13787_0_0.htm" target="_top">协兴</a> <a href="/search/<%=keywordCheck%>_13785_0_0.htm" target="_top">欣融</a> <a href="/search/<%=keywordCheck%>_13814_0_0.htm" target="_top">新波臣</a> <a href="/search/<%=keywordCheck%>_1236_0_0.htm" target="_top">新天和</a> <a href="/search/<%=keywordCheck%>_13779_0_0.htm" target="_top">新型</a> <a href="/search/<%=keywordCheck%>_13098_0_0.htm" target="_top">新宇机械</a> <a href="/search/<%=keywordCheck%>_1683_0_0.htm" target="_top">新源机械</a> <a href="/search/<%=keywordCheck%>_690_0_0.htm" target="_top">新筑股份</a> <a href="/search/<%=keywordCheck%>_692_0_0.htm" target="_top">鑫国重机</a> <a href="/search/<%=keywordCheck%>_1235_0_0.htm" target="_top">信达</a> <a href="/search/<%=keywordCheck%>_1097_0_0.htm" target="_top">星邦重工</a> <a href="/search/<%=keywordCheck%>_205_0_0.htm" target="_top">星马汽车</a> <a href="/search/<%=keywordCheck%>_13788_0_0.htm" target="_top">雄辉</a> <a href="/search/<%=keywordCheck%>_209_0_0.htm" target="_top">徐工</a> <a href="/search/<%=keywordCheck%>_1522_0_0.htm" target="_top">徐工特机</a> <a href="/search/<%=keywordCheck%>_150_0_0.htm" target="_top">徐挖</a> <a href="/search/<%=keywordCheck%>_544_0_0.htm" target="_top">徐威重科</a> <a href="/search/<%=keywordCheck%>_1129_0_0.htm" target="_top">徐州建机</a> <a href="/search/<%=keywordCheck%>_867_0_0.htm" target="_top">徐州凯尔</a> <a href="/search/<%=keywordCheck%>_154_0_0.htm" target="_top">宣工</a> <a href="/search/<%=keywordCheck%>_13619_0_0.htm" target="_top">雪狼</a> <a href="/search/<%=keywordCheck%>_14112_0_0.htm" target="_top">烟台信人</a> <a href="/search/<%=keywordCheck%>_1152_0_0.htm" target="_top">济南圆鑫</a> <a href="/search/<%=keywordCheck%>_1643_0_0.htm" target="_top">江苏意玛</a> <a href="/search/<%=keywordCheck%>_14250_0_0.htm" target="_top">青岛雅凯</a> <a href="/search/<%=keywordCheck%>_562_0_0.htm" target="_top">山东愚公</a> <a href="/search/<%=keywordCheck%>_1092_0_0.htm" target="_top">山东圆友</a> <a href="/search/<%=keywordCheck%>_408_0_0.htm" target="_top">上海友一</a> <a href="/search/<%=keywordCheck%>_13805_0_0.htm" target="_top">亚工</a> <a href="/search/<%=keywordCheck%>_13798_0_0.htm" target="_top">亚洁</a> <a href="/search/<%=keywordCheck%>_1148_0_0.htm" target="_top">亚特</a> <a href="/search/<%=keywordCheck%>_155_0_0.htm" target="_top">烟工</a> <a href="/search/<%=keywordCheck%>_191_0_0.htm" target="_top">洋马</a> <a href="/search/<%=keywordCheck%>_13795_0_0.htm" target="_top">业豪</a> <a href="/search/<%=keywordCheck%>_13738_0_0.htm" target="_top">一鼎重工</a> <a href="/search/<%=keywordCheck%>_13803_0_0.htm" target="_top">一帆机械</a> <a href="/search/<%=keywordCheck%>_159_0_0.htm" target="_top">一拖</a> <a href="/search/<%=keywordCheck%>_13800_0_0.htm" target="_top">依格曼</a> <a href="/search/<%=keywordCheck%>_770_0_0.htm" target="_top">宜工</a> <a href="/search/<%=keywordCheck%>_161_0_0.htm" target="_top">移山</a> <a href="/search/<%=keywordCheck%>_13791_0_0.htm" target="_top">亿龙机械</a> <a href="/search/<%=keywordCheck%>_13801_0_0.htm" target="_top">亿通正龙</a> <a href="/search/<%=keywordCheck%>_1749_0_0.htm" target="_top">忆辉</a> <a href="/search/<%=keywordCheck%>_13792_0_0.htm" target="_top">易山重工</a> <a href="/search/<%=keywordCheck%>_13808_0_0.htm" target="_top">益鑫</a> <a href="/search/<%=keywordCheck%>_1751_0_0.htm" target="_top">银锚</a> <a href="/search/<%=keywordCheck%>_13232_0_0.htm" target="_top">银起</a> <a href="/search/<%=keywordCheck%>_13793_0_0.htm" target="_top">英达</a> <a href="/search/<%=keywordCheck%>_1777_0_0.htm" target="_top">英轩重工</a> <a href="/search/<%=keywordCheck%>_1930_0_0.htm" target="_top">永安机械</a> <a href="/search/<%=keywordCheck%>_647_0_0.htm" target="_top">永工</a> <a href="/search/<%=keywordCheck%>_843_0_0.htm" target="_top">永茂</a> <a href="/search/<%=keywordCheck%>_13806_0_0.htm" target="_top">尤尼克</a> <a href="/search/<%=keywordCheck%>_562_0_0.htm" target="_top">愚公机械</a> <a href="/search/<%=keywordCheck%>_13802_0_0.htm" target="_top">宇泰</a> <a href="/search/<%=keywordCheck%>_143_0_0.htm" target="_top">宇通重工</a> <a href="/search/<%=keywordCheck%>_146_0_0.htm" target="_top">玉柴重工</a> <a href="/search/<%=keywordCheck%>_13796_0_0.htm" target="_top">豫弘重工</a> <a href="/search/<%=keywordCheck%>_13794_0_0.htm" target="_top">原进</a> <a href="/search/<%=keywordCheck%>_1092_0_0.htm" target="_top">圆友</a> <a href="/search/<%=keywordCheck%>_13799_0_0.htm" target="_top">远东</a> <a href="/search/<%=keywordCheck%>_13736_0_0.htm" target="_top">远华机械</a> <a href="/search/<%=keywordCheck%>_14238_0_0.htm" target="_top">约翰迪尔</a> <a href="/search/<%=keywordCheck%>_13797_0_0.htm" target="_top">岳首</a> <a href="/search/<%=keywordCheck%>_13804_0_0.htm" target="_top">粤工</a> <a href="/search/<%=keywordCheck%>_13807_0_0.htm" target="_top">运想重工</a> <a href="/search/<%=keywordCheck%>_1757_0_0.htm" target="_top">安徽中达</a> <a href="/search/<%=keywordCheck%>_1136_0_0.htm" target="_top">江苏正兴</a> <a href="/search/<%=keywordCheck%>_767_0_0.htm" target="_top">凌宇汽车</a> <a href="/search/<%=keywordCheck%>_13209_0_0.htm" target="_top">山东众和</a> <a href="/search/<%=keywordCheck%>_1095_0_0.htm" target="_top">上海振中</a> <a href="/search/<%=keywordCheck%>_13821_0_0.htm" target="_top">泽通</a> <a href="/search/<%=keywordCheck%>_195_0_0.htm" target="_top">詹阳动力</a> <a href="/search/<%=keywordCheck%>_13811_0_0.htm" target="_top">浙江赤道</a> <a href="/search/<%=keywordCheck%>_1119_0_0.htm" target="_top">浙江建机</a> <a href="/search/<%=keywordCheck%>_14220_0_0.htm" target="_top">浙江振中</a> <a href="/search/<%=keywordCheck%>_13817_0_0.htm" target="_top">正泰</a> <a href="/search/<%=keywordCheck%>_13816_0_0.htm" target="_top">郑州鼎盛</a> <a href="/search/<%=keywordCheck%>_813_0_0.htm" target="_top">郑州富岛（川岛）</a> <a href="/search/<%=keywordCheck%>_13824_0_0.htm" target="_top">中材建科</a> <a href="/search/<%=keywordCheck%>_13810_0_0.htm" target="_top">中方机械</a> <a href="/search/<%=keywordCheck%>_1214_0_0.htm" target="_top">中国重汽</a> <a href="/search/<%=keywordCheck%>_13819_0_0.htm" target="_top">中海恒通</a> <a href="/search/<%=keywordCheck%>_1219_0_0.htm" target="_top">中环动力</a> <a href="/search/<%=keywordCheck%>_1106_0_0.htm" target="_top">中集华骏</a> <a href="/search/<%=keywordCheck%>_13813_0_0.htm" target="_top">中际</a> <a href="/search/<%=keywordCheck%>_1951_0_0.htm" target="_top">中建机械</a> <a href="/search/<%=keywordCheck%>_542_0_0.htm" target="_top">中交西筑</a> <a href="/search/<%=keywordCheck%>_134_0_0.htm" target="_top">中联重科</a> <a href="/search/<%=keywordCheck%>_553_0_0.htm" target="_top">中龙建机</a> <a href="/search/<%=keywordCheck%>_13820_0_0.htm" target="_top">中青林</a> <a href="/search/<%=keywordCheck%>_13812_0_0.htm" target="_top">中升</a> <a href="/search/<%=keywordCheck%>_1131_0_0.htm" target="_top">中昇建机</a> <a href="/search/<%=keywordCheck%>_1682_0_0.htm" target="_top">中铁二十局</a> <a href="/search/<%=keywordCheck%>_1151_0_0.htm" target="_top">中文实业</a> <a href="/search/<%=keywordCheck%>_13823_0_0.htm" target="_top">中意</a> <a href="/search/<%=keywordCheck%>_13815_0_0.htm" target="_top">中誉鼎力</a> <a href="/search/<%=keywordCheck%>_188_0_0.htm" target="_top">竹内</a> <a href="/search/<%=keywordCheck%>_185_0_0.htm" target="_top">住友</a> <a href="/search/<%=keywordCheck%>_13809_0_0.htm" target="_top">筑马</a> <a href="/search/<%=keywordCheck%>_13818_0_0.htm" target="_top">钻通</a> </div>
    </div>
  </dd>
</li>
        </ul>
      </div>
      <input type="hidden" name="order" id="order">
      <input type="hidden" name="keyword" id="key_word">
    </form>
    <div class="nseresult_pro">
      <div class="nse_usedate">找到约<%=totalParts %>条结果</div>
      <div class="plList nkb_pro_list np_fix">
        <ul>
		
		<%  
		String title_hl = "";
        int i = 0;
		for(SolrDocument m : products){	
			String img=CommonString.getFormatPara(m.getFieldValue("img2"));
			String id = CommonString.getFormatPara(m.getFieldValue("id"));
			String product_id = CommonString.getFormatPara(m.getFieldValue("product_id"));
			int is_help =Integer.parseInt( CommonString.getFormatPara(m.getFieldValue("is_help")));
			String title = CommonString.getFormatPara(m.getFieldValue("title"));
			int score1 = Integer.parseInt(CommonString.getFormatPara(m.getFieldValue("score1")));
			int score2 = Integer.parseInt(CommonString.getFormatPara(m.getFieldValue("score2")));
			int score3 = Integer.parseInt(CommonString.getFormatPara(m.getFieldValue("score3")));
			int score4 = Integer.parseInt(CommonString.getFormatPara(m.getFieldValue("score4")));
			String username =CommonString.getFormatPara(m.getFieldValue("username"));
            String catalognum=CommonString.getFormatPara(m.getFieldValue("catalognum"));
			String catalogname=CommonString.getFormatPara(m.getFieldValue("catalogname"));
			String factoryid=CommonString.getFormatPara(m.getFieldValue("factoryid"));
			String factoryname=CommonString.getFormatPara(m.getFieldValue("factoryname"));
			String content=CommonString.getFormatPara(m.getFieldValue("content"));
	
            if(content.length()>20){content=content.substring(0,20)+"...";}
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
            <div class="l">
              <div class="plimg"> <a href="http://koubei.21-sun.com/detail/<%=id%>.htm" target="_blank" title="<%=titleAlt%>"> <img src="http://product.21-sun.com//uploadfiles/<%=img%>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=titleAlt%>" title="<%=titleAlt%>"> </a></div>
              <a target="_blank" href="http://koubei.21-sun.com/compare_<%=product_id%>.htm" class="pldb">加入对比+</a>
            </div>
            <div class="content">
              <div class="np_fix">
                <h3><a href="http://koubei.21-sun.com/list/<%=product_id%>.htm" target="_blank" title="<%=titleAlt%>"><%=title_hl.equals("") ? title : title_hl %></a></h3>
                <span class="time" style="display:none">2014-08-22 23:23</span> </div>
              <div class="plinfo01"><span class="plname"><%=username%>评论</span></div>
              <div class="w100 np_fix">
                <p class="textContent"><%=content%><a title="查看全文" href="http://koubei.21-sun.com/detail/<%=id%>.htm" target="_blank" style="color:red;">查看全文&gt;&gt;</a></p>
                <div class="r plt">网友评分 <font><%=(score1+score2+score3+score4)/4%></font> 分</div>
              </div>
              <div class="n_kb_add_pf">
                <p class="pftitle">网友评分</p>
                <ul class="np_fix nkb_pflist np_fix" style="width:70%;float:left">
                  <li><span class="nkb_pfwz">价格：</span>
                    <div id="pricescore_<%=id %>" title="" ></div>
                    <span class="nkb_pffs"><%=score1 %>分</span></li>
                  <li><span class="nkb_pfwz">性能：</span>
                    <div id="abilityscore_<%=id %>" title="" ></div>
                    <span class="nkb_pffs"><%=score2 %>分</span></li>
                  <li><span class="nkb_pfwz">质量：</span>
                    <div id="qualityscore_<%=id %>" title=""></div>
                    <span class="nkb_pffs"><%=score3 %>分</span></li>
                  <li><span class="nkb_pfwz">售后：</span>
                    <div id="servicescore_<%=id %>" title=""></div>
                    <span class="nkb_pffs"><%=score4 %>分</span></li>
                </ul>
           <script language="javascript" type="text/javascript">
	            var s1_<%=id %> = (parseInt(<%=score1 %>,10)/20);
	  			var s2_<%=id %> = (parseInt(<%=score2 %>,10)/20);
	  			var s3_<%=id %> = (parseInt(<%=score3 %>,10)/20);
	  			var s4_<%=id %> = (parseInt(<%=score4 %>,10)/20);

	            //获得评论分数
	          	jQuery("#pricescore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s1_<%=id %>
	          	});
	          	jQuery("#abilityscore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s2_<%=id %>
	          	});
	          	jQuery("#qualityscore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s3_<%=id %>
	          	});
	          	jQuery("#servicescore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s4_<%=id %>
	          	});
              </script>
                <div style="float:left"><a href="http://koubei.21-sun.com/list/<%=product_id%>.htm#sentComment" target="_blank"><img src="/koubei/images/temp/1_05.png" alt="发表评论" width="120" height="27"></a></div>
              </div>
              <div class="nkb_moregg" style="clear:both"><a href="http://koubei.21-sun.com/0-<%=factoryid%>-0.htm" title="<%=factoryname%>"><%=factoryname%></a>
			  &nbsp;&nbsp;|&nbsp;&nbsp;<span><a href="http://koubei.21-sun.com/<%=catalognum%>-<%=factoryid%>-0.htm" title="<%=factoryname+catalogname%>"><%=factoryname+catalogname%></a>
			  &nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://koubei.21-sun.com/comment-<%=catalognum%>-<%=factoryid%>-0-0-0.htm" target="_blank" title="更多<%=factoryname+catalogname%>">更多<%=factoryname+catalogname%>口碑</a>
			  &nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://koubei.21-sun.com/list/<%=product_id%>.htm#00b" target="_blank" title="询<%=titleAlt%>最低价">询最低价</a>
			  &nbsp;&nbsp;|&nbsp;&nbsp;<span class="youk"><a href="javascript:void(0)" >
			  <b style="color:red">有用</b></a> (<span id=""><%=is_help%></span>)</span></span></div>
            </div>
          </li>
		    <%i++;}%>
        </ul>
      </div>
    </div>
    <div class="nse_page">
       <tags:koubei_page_search nowPage="<%=nowPage%>" total="<%=totalParts %>"  totalPage="<%=pageCount%>" factory="<%=factory%>" catalog="<%=catalog%>" keyword="<%=pageKeyword%>" />
      <div class="l nse_allresult">共约<%=totalParts %>条结果</div>
    </div>
  </div>
  <!--right end--> 
  
</div>
<!--main end--> 
<!--foot search-->
<div class="contain980">
  <div class="nse_foot_search"><span>重新搜索</span>
    <input type="text" class="nse_foot_seinp"/>
    <input type="button" class="nse_foot_sebtn" value="搜索"/>
  </div>
  <div class="telTip">如果没有找到您的信息，请直接致电：<strong>4006-521-526</strong></div>
</div>
<!--foot search end--> 
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