<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="java.net.URLEncoder"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%  DBHelper dbHelper = DBHelper.getInstance() ;
	String keywordCheck = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String pageKeyword = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String factoryid=factory;
	String tonandmeter="";
	String order="";
	String catalognum_new=catalog;
	String catalog_first="";
	String catalog_detail="";
	if(catalog.length()>3){catalog_first=catalog.substring(0,3);}else{catalog_first=catalog;}
	if(catalog.length()>6){catalog_detail=catalog.substring(0,6);}else{catalog_detail=catalog;}
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	int nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));
	Map brandMap = (Map)application.getAttribute("brandMap") ;
	Map catalogMap = (Map)application.getAttribute("catalogMap") ;
	if(brandMap==null){
		brandMap=new HashMap();
	}
	if(catalogMap==null){
		catalogMap=new HashMap();
	}
    if(keywordCheck.equals("0")){keywordCheck="";}
	if(keywordCheck.equals("旋挖钻")){keywordCheck="旋挖钻机";}
	if(keywordCheck.equals("塔机")){keywordCheck="塔式起重机";}
	if(keywordCheck.equals("中联")){keywordCheck="中联重科";}
	//if(keywordCheck.equals("临工重托")){keywordCheck="临工特机";}
	if(catalog.equals("")){catalog="0";}
	if(factory.equals("")){factory="0";}
	if(pageKeyword.equals("")){pageKeyword="0";}
	int totalParts = 0;
	String tempCatalog="";
	String tempFactory="";
	if(keywordCheck.indexOf("173979222")>=0){
		  Common.do302(response,"http://product.21-sun.com");
		  return;
	}
	//搜索新	
	String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	/*接收参数*/
	SolrQuery query = new SolrQuery();
	query.setQuery("*:*");	
	List<String> filterQuery = new ArrayList<String>(0);
	
	List<SolrQuery.SortClause> orderList = new ArrayList<SolrQuery.SortClause>();
    if(keywordCheck.equals("全进")){
		orderList.add(SolrQuery.SortClause.desc("id"));
	}
	keywordCheck=keywordCheck.replace("挖机","挖掘机");
	
	nowPage = nowPage <= 0 ? 1 : nowPage;
	List<String> whereList = new ArrayList<String>();
	if(!catalog.equals("0")&&!catalog.equals("")&&catalog.length()>=3){
	   tempCatalog=(CommonString.getFormatPara(catalogMap.get(catalog)));
	}
	if(!factory.equals("0")&&!factory.equals("")){
	    tempFactory=(CommonString.getFormatPara(brandMap.get(factory)));
	}
	
	if(!(tempCatalog+tempFactory).equals("")){
		keywordCheck=(tempCatalog+tempFactory);
	}
	if((keywordCheck+tempFactory+tempCatalog).equals("")){
		
	}else{
	   query.setQuery("title:" + keywordCheck.replace("临工重托","临工特机").replace("卡特","卡特彼勒").replace("挖机","挖掘机").replace("铲车","装载机").replace("轮挖","轮式挖掘机").replace("汽车吊","汽车起重机").replace("随车吊","随车起重机").replace("履带吊","履带起重机").replace("旋挖钻","旋挖钻机").replace("潜孔钻","潜孔钻机").replace("吊车","汽车起重机").replace("钩机","挖掘机").replace("折臂吊","随车起重机").replace("两头忙","挖掘装载机").replace("搅拌车","混凝土搅拌运输车").replace("卡特彼勒彼勒","卡特彼勒") );
	}
	filterQuery.add("year: 1 ");
    /*查询*/				
	int pageSize = 15;
	String [] filterArr = new String [filterQuery.size()];
	filterArr = filterQuery.toArray(filterArr);
	query.addFilterQuery(filterArr);	
	query.setRequestHandler("/jereh");
	query.setSorts(orderList);
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
	TDK_title=(keywordCheck.equals("")?"":keywordCheck+" - ")+"产品搜索 - 铁臂商城";
	TDK_keywords=(keywordCheck.equals("")?"":keywordCheck+",")+"铁臂商城";
	TDK_desc="在铁臂商城中找到了"+totalParts+"条"+keywordCheck+"相关信息，其中包含了"+keywordCheck+"价格表，"+keywordCheck+"图片，"+keywordCheck+"型号大全等信息，买"+keywordCheck+"就上铁臂商城。";
	}else{
	TDK_title=keywordCheck+" - 产品搜索 - 铁臂商城";
	TDK_keywords=keywordCheck+",铁臂商城";
	TDK_desc="在铁臂商城中找到了0件"+keywordCheck+"相关信息，请重新选择，买工程机械就上铁臂商城。";
	}
	
	//Map catalogNewMap = (Map) application.getAttribute("catalogNewMap");//旧类别取新类别
	catalognum_new=catalog;

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
<link href="/new_resources/css/style.css" rel="stylesheet" />
<link href="/new_resources/css/style_common.css" rel="stylesheet" />
<link href="/Static/css/common.css" rel="stylesheet">
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/history/json.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<style>
.txd_filter_plist li {
	border-top: 1px solid #F7F7F7;
	border-bottom: 1px solid #F7F7F7;
	border-left: 1px solid #F7F7F7;
}
</style>
</head>
<body>
<!--topBar-->
<jsp:include page="/include_new/top_index.htm" flush="true"/>
<!--topBar end-->
<!--top-->
<jsp:include page="/include_new/top_search.htm" flush="true"/>
<!--top end-->
<!--nav-->
<jsp:include page="/include_new/catalog_new.htm" flush="true"/>
<!--nav end-->
<!--面包屑-->
<div class="txd_posi">
  <div class="wrap fix">我的位置：<a href="/">搜索结果</a>
    <%if(!keywordCheck.equals("")){%>
    &gt;&gt; <%=keywordCheck%>
    <%}%>
  </div>
</div>
<!--面包屑结束-->
<!--main-->
<!--有搜索结果-->
<%if(totalParts>0){%>
<div class="txd_nmain">
  <div class="wrap fix">
    <!--left-->
    <div class="txd_nleft">
      <div class="txd_nlant">按条件选机</div>
      <div class="txd_filter t_tab">
        <!--
				<ul class="txd_filter_tkeyl fix" style="margin-bottom:0px">
					<li class="t_tab_key" style="width:49%">按类别</li>
					<li  style="width:1%;background-color: #F7F7F7;height:15px;margin-top:10px"></li>	
					<li class="t_tab_key" style="width:49%">按品牌</li>
				</ul>
				-->
        <div style="height:10px;width:211px;background-color: #F7F7F7;"></div>
        <div class="t_tab_val hide ">
          <div style="background-color: #F7F7F7;height:1150px">
            <div class="txd_filter_val">
              <ul class="fix txd_filter_plist txd_filter_plist_cat">
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001#main"  title="挖掘机/属具">挖掘机/属具</a>
                  <div class="txd_filter_pnc"  style="background-color: white">
                    <ul class="fix">
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001001#main"  title="履带挖掘机">履带挖掘机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001004#main"  title="轮式挖掘机">轮式挖掘机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001007#main"  title="特种挖掘机">特种挖掘机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001098#main"  title="破碎器">破碎器 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001099#main"  title="液压剪">液压剪 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002#main"  title="装载机">装载机</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002003#main"  title="履带装载机">履带装载机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002004#main"  title="特种装载机">特种装载机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002007#main"  title="轮式装载机">轮式装载机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002008#main"  title="挖掘装载机">挖掘装载机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002009#main"  title="滑移装载机">滑移装载机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002010#main"  title="叉装机">叉装机 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003#main"  title="推土机">推土机</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003001#main"  title="履带推土机">履带推土机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003004#main"  title="轮式推土机">轮式推土机 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005#main"  title="平地/铲运机">平地/铲运机</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005001#main"  title="铲运机">铲运机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005002#main"  title="平地机">平地机 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008#main"  title="自卸车/矿卡">自卸车/矿卡</a>
                  <div class="txd_filter_pnc"  style="background-color: white">
                    <ul class="fix">
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008001#main"  title="铰接式自卸卡车">铰接式自卸卡车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008002#main"  title="钢性自卸卡车">钢性自卸卡车 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102#main"  title="起重机">起重机</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102002#main"  title="塔式起重机">塔式起重机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102003#main"  title="高空作业车/平台">高空作业车/平台 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102006#main"  title="随车起重机">随车起重机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102007#main"  title="汽车起重机">汽车起重机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102008#main"  title="履带起重机">履带起重机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102011#main"  title="施工升降机">施工升降机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102012#main"  title="伸缩臂叉装机">伸缩臂叉装机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102013#main"  title="龙门/桥梁起重机">龙门/桥梁起重机 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103#main"  title="混凝土设备">混凝土设备</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001#main"  title="混凝土泵车">混凝土泵车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103002#main"  title="混凝土搅拌站/车/楼">混凝土搅拌站</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103005#main"  title="混凝土布料杆/车">混凝土布料杆/车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103008#main"  title="砂浆设备">砂浆设备 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103015#main"  title="其他混凝土设备">其他混凝土设备 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103017#main"  title="车载泵">车载泵 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103018#main"  title="拖泵">拖泵 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103019#main"  title="混凝土搅拌运输车">混凝土搅拌运输车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103020#main"  title="混凝土输送泵">混凝土输送泵 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103010#main"  title="喷湿机">喷湿机 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104#main"  title="路面机械">路面机械</a>
                  <div class="txd_filter_pnc"  style="background-color: white">
                    <ul class="fix">
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104001#main"  title="摊铺机">摊铺机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104002#main"  title="再生/修补机械">再生/修补机械 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104003#main"  title="开槽机/灌缝机">开槽机/灌缝机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104004#main"  title="路面破碎机">路面破碎机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104005#main"  title="铣刨机">铣刨机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104009#main"  title="沥青搅拌/转运">沥青搅拌/转运 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104008#main"  title="稳定土厂拌设备">稳定土厂拌设备 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104006#main"  title="沥青洒布/碎石散布机">沥青洒布机 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105#main"  title="钻机/桩机">钻机/桩机</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105003#main"  title="旋挖钻机">旋挖钻机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105004#main"  title="潜孔钻机">潜孔钻机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105005#main"  title="水平定向钻">水平定向钻 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105007#main"  title="连续墙设备">连续墙设备 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105009#main"  title="压桩/打桩机">压桩/打桩机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105018#main"  title="螺旋钻机">螺旋钻机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105027#main"  title="其他钻机">其他钻机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105028#main"  title="截桩机/破桩机">截桩机/破桩机 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001#main"  title="压路机/压实机/夯">压实机械</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001001#main"  title="单钢轮压路机">单钢轮压路机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001002#main"  title="双钢轮压路机">双钢轮压路机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001003#main"  title="三钢轮压路机">三钢轮压路机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001005#main"  title="轮胎压路机">轮胎压路机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001004#main"  title="手扶压路机">手扶压路机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001020#main"  title="压实机">压实机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001021#main"  title="夯实机">夯实机 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107#main"  title="叉车">叉车</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107011#main"  title="内燃平衡重叉车">内燃平衡重叉车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107012#main"  title="电动式叉车">电动式叉车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107013#main"  title="侧面叉车">侧面叉车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107014#main"  title="前移">前移 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107015#main"  title="电动/手动搬运车">电动/手动搬运车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107016#main"  title="堆垛车/堆高车">堆垛车/堆高车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107017#main"  title="其他叉车">其他叉车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107018#main"  title="仓储叉车">仓储叉车 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109#main"  title="桥梁机械">桥梁机械</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=109001#main"  title="架桥机">架桥机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=109002#main"  title="运梁车">运梁车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=109004#main"  title="提梁机">提梁机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=109005#main"  title="检测车">检测车 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110#main"  title="矿山/煤矿机械">矿山/煤矿机械</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110001#main"  title="盾构机">盾构机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110002#main"  title="掘进机">掘进机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110008#main"  title="凿岩车/凿岩钻机">凿岩车/凿岩钻机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110009#main"  title="矿石破碎机">矿石破碎机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110012#main"  title="筛分机">筛分机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110013#main"  title="输送/转载设备">输送/转载设备 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110018#main"  title="扒渣机">扒渣机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110019#main"  title="采煤机">采煤机 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111#main"  title="港口机械">港口机械</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111001#main"  title="正面吊">正面吊</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111002#main"  title="码头堆高机">码头堆高机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111003#main"  title="卸船机">卸船机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111004#main"  title="门式起重机">门式起重机 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111007#main"  title="推耙机">推耙机 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118#main"  title="专用车辆">专用车辆</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118001#main"  title="普通载货车">普通载货车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118013#main"  title="公路牵引车">公路牵引车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118004#main"  title="场地牵引车">场地牵引车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118003#main"  title="消防车">消防车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118012#main"  title="清障车">清障车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118005#main"  title="冷藏车">冷藏车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118007#main"  title="粉罐车">粉罐车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118008#main"  title="油罐车">油罐车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118009#main"  title="液罐车">液罐车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118010#main"  title="翻斗车">翻斗车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118011#main"  title="渣土车">渣土车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118014#main"  title="半挂车">半挂车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118002#main"  title="其他专用车">其他专用车 </a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111#main"  title="环卫车辆">环卫车辆</a>
                  <div class="txd_filter_pnc" style="background-color: white">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122001#main"  title="扫地车">扫地车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122002#main"  title="垃圾车">垃圾车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122003#main"  title="清雪车">清雪车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122004#main"  title="洒水车">洒水车 </a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122005#main"  title="污水/粪便车">污水/粪便车 </a></li>
                    </ul>
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!--left end-->
    <div class="txd_nright">
      <div class="txd_plant fix" style="margin-top: -10px;">
        <div class="tpl_title"><span style="color:#fe6000;font-weight: bolder;"><%=keywordCheck%></span> 搜索结果</div>
      </div>
      <div class="txd_sx_plist">
        <ul class="fix" id="ssresultlist">
          <!--搜索第一位置广告-->
		  <li><img src="/images/cat_zbs_990.png"></li>

		   <%if(totalParts>0&&((keywordCheck+tempFactory+tempCatalog).equals("微挖")||(keywordCheck+tempFactory+tempCatalog).equals("微挖"))&&nowPage<=1){%>
<li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/3015.shtm" title="卡特彼勒301.5挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2018/10/20181016160528_803.jpg" alt="卡特彼勒301.5挖掘机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/3015.shtm" target="_blank" title="卡特彼勒301.5挖掘机">卡特彼勒301.5挖掘机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">Cat<sup>®</sup>301.5迷你型挖掘机以紧凑的尺寸，澎湃的动力和出色的性能，助您轻松应对各种应用场合。全天候舒适体验可调节腕托有助于您全天舒适工作。易于操作控制装置易于使用，直<a class="ssresult" href="/proDetail/3015.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=174&amp;catalog=101001">卡特挖掘机/属具</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=31806" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/3015_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/3015_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/3015_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('31806','')">询最低价</a></div>
          </li>
		   <%}%>
	
		   <%if(totalParts>0&&((keywordCheck+tempFactory+tempCatalog).equals("叉装机")||(keywordCheck+tempFactory+tempCatalog).equals("轮式叉装机"))&&nowPage<=1){%>
 <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/JGM791FT50KN.shtm" title="晋工JGM791FT50KN叉装机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2017/10/20171020150358_116.jpg" alt="晋工JGM791FT50KN叉装机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/JGM791FT50KN.shtm" target="_blank" title="晋工JGM791FT50KN叉装机">晋工JGM791FT50KN叉装机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">采用潍柴WP12国Ⅲ电控高压共轨发动机，满足国Ⅲ排放要求；采用定轴式电液换档变速箱，档位前四后三，具有强制换低档功能（KD键功能），操纵简便，工作效率高；负荷传感全液<a class="ssresult" href="/proDetail/JGM791FT50KN.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=172&amp;catalog=101002">晋工装载机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=30259" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/JGM791FT50KN_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/JGM791FT50KN_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/JGM791FT50KN_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('30259','')">询最低价</a></div>
          </li>
		   <%}%>
		   
		   <%if(totalParts>0&&((keywordCheck+tempFactory+tempCatalog).equals("轮式挖掘机"))&&nowPage<=1){%>
<li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/JGM907LN-8.shtm" title="晋工JGM907LN-8轮式挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2017/10/20171020133543_797.jpg" alt="晋工JGM907LN-8轮式挖掘机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/JGM907LN-8.shtm" target="_blank" title="晋工JGM907LN-8轮式挖掘机">晋工JGM907LN-8轮式挖掘机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">液压系统·高质量的进口液压零部件；·为晋工轮挖量身匹配的多路阀，力量更大，速度更快；·回转、提臂复合动作时间短，作业效率高；·推土铲及支腿油缸安装单向阀，防止油<a class="ssresult" href="/proDetail/JGM907LN-8.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=172&amp;catalog=101001">晋工挖掘机/属具</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=30238" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/JGM907LN-8_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/JGM907LN-8_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/JGM907LN-8_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('30238','')">询最低价</a></div>
          </li>
		   <%}%>
		   
		  
		  
		  
		  	   <%if(totalParts>0&&((keywordCheck+tempFactory+tempCatalog).equals("轮挖"))&&nowPage<=1){%>
<li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/BD95W-9ALSWJJ.shtm" title="宝鼎BD95W-9A轮式挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2018/05/31/20180531115921_749.png" alt="宝鼎BD95W-9A轮式挖掘机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/BD95W-9ALSWJJ.shtm" target="_blank" title="宝鼎BD95W-9A轮式挖掘机">宝鼎BD95W-9A轮式挖掘机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">2018年年初经过了前期高密度的实地工况试验，宝鼎液压机械有限公司近日正式对外发布了一款小型号轮式挖掘机产品-BD95W-9A型轮式挖掘机，该型挖掘机采用了智能电子油门设计<a class="ssresult" href="/proDetail/BD95W-9ALSWJJ.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=13570&amp;catalog=101001">宝鼎挖掘机/属具</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=31695" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/BD95W-9ALSWJJ_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/BD95W-9ALSWJJ_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/BD95W-9ALSWJJ_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('31695','')">询最低价</a></div>
          </li>
		  
		  <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/JGM907LN-8.shtm" title="晋工JGM907LN-8轮式挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2017/10/20171020133543_797.jpg" alt="晋工JGM907LN-8轮式挖掘机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/JGM907LN-8.shtm" target="_blank" title="晋工JGM907LN-8轮式挖掘机">晋工JGM907LN-8轮式挖掘机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">液压系统·高质量的进口液压零部件；·为晋工轮挖量身匹配的多路阀，力量更大，速度更快；·回转、提臂复合动作时间短，作业效率高；·推土铲及支腿油缸安装单向阀，防止油<a class="ssresult" href="/proDetail/JGM907LN-8.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=172&amp;catalog=101001">晋工挖掘机/属具</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=30238" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/JGM907LN-8_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/JGM907LN-8_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/JGM907LN-8_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('30238','')">询最低价</a></div>
          </li>
		   <%}%>
		   <%if(totalParts>0&&((keywordCheck+tempFactory+tempCatalog).equals("河南挖掘机")||(keywordCheck+tempFactory+tempCatalog).equals("河南挖机"))&&nowPage<=1){%>
			<li>
				
					<h3><a href="http://ad.21-sun.com/link_to.jsp?paras=122,273,7912&amp;url=http://www.hngcjx.com/" target="_blank">河南凯隆工程机械有限公司</a></h3>
						
          <span class="sc"><p>主要经营产品小松PC35、PC56、PC60、PC100、PC110、PC130、PC160、PC200、PC210、PC220、PC240、PC270、PC300、PC360、PC400&nbsp;、PC450、PC650等挖掘机</p></span>
          <div class="site"><a style="color: #4D9724;" href="http://ad.21-sun.com/link_to.jsp?paras=122,273,7912&amp;url=http://www.hngcjx.com/" target="_blank">http://www.hngcjx.com/</a></div>
          
        </li>
		   <%}%>
          <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("挖掘机")&&nowPage<=1){%>
          <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/336D2XE-D2LXE.shtm" title="卡特彼勒336D2 XE/D2 L XE挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2015/02/20150228134314_14.jpg" alt="卡特彼勒336D2 XE/D2 L XE挖掘机"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a  class="ssresult" href="/proDetail/336D2XE-D2LXE.shtm" target="_blank" title="卡特彼勒336D2 XE/D2 L XE挖掘机">卡特彼勒336D2 XE/D2 L XE挖掘机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">操作台人性化设计让您全天保持极佳的舒适度和生产率。驾驶室结构和底座驾驶室外壳通过粘性橡胶安装座固定在机架上，不仅减振降噪，还能提高您的舒适度。底部周边使用粗大的<a class="ssresult"  href="/proDetail/336D2XE-D2LXE.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=174&amp;catalog=101001">卡特挖掘机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=23905" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/336D2XE-D2LXE_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult"  href="/proDetail/336D2XE-D2LXE_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult"  href="/proDetail/336D2XE-D2LXE_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a  href="javascript:;" onclick="showinquery('23905','')">询最低价</a></div>
          </li>
          <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/SY60C-9(2013K).shtm" title="三一SY60C-9挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2013/05/16/20130516144012_910.jpg" alt="三一SY60C-9挖掘机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/SY60C-9(2013K).shtm" target="_blank" title="三一SY60C-9挖掘机">三一SY60C-9挖掘机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">·节能环保：欧Ⅱ标准环保发动机，采用全新控制器实时精确控制燃油喷射，燃油燃烧更充分，在效率相当的情况下较上一代降低油耗更低；·高效持久：采用独创的DOMCS动态寻优<a class="ssresult" href="/proDetail/SY60C-9(2013K).shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=133&amp;catalog=101001">三一挖掘机/属具</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=18534" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/SY60C-9(2013K)_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/SY60C-9(2013K)_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/SY60C-9(2013K)_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('18534','')">询最低价</a></div>
          </li>
          <%}%>
          <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("起重机")&&nowPage<=1){%>
		  <li>
						<div class="tsx_pimg"><a class="ssresult" href="/proDetail/SCC550E.shtm" title="三一SCC550E常规吊装系列履带起重机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2015/08/20150813144634_246.jpg" alt="三一SCC550E常规吊装系列履带起重机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
						<div class="tsx_pnr">
							<h2 class="txs_ptitle"><!--<i class="txs_tag2">推广</i>--><a class="ssresult" href="/proDetail/SCC550E.shtm" target="_blank" title="三一SCC550E常规吊装系列履带起重机">三一SCC550E常规吊装系列履带起重机</a><!--<i class="txs_tag">停产在售</i>--></h2>
							<div class="txs_psum">●安全的控制系统：工作和安装两种操作模式方便可靠；选配有水平度实时显示、离机停止动作、紧急电气控制、防雷击保护、行走自动调向、闭路监控等功能，安全及监控装置齐全<a class="ssresult" href="/proDetail/SCC550E.shtm" target="_blank">[查看详情]</a></div>
							<div class="txs_plink">
								<a class="ssresult" href="/products/prolist.jsp?factory=133&amp;catalog=102008">三一履带式起重机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=1618" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/SCC550E_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/SCC550E_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/SCC550E_message.shtm" target="_blank">口碑</a>
							</div>
						</div>
						<div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('1618','')">询最低价</a></div>
		</li>
          <%}%>
	 <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("旋挖钻")&&nowPage<=1){%>
          <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/KR80-25.shtm" title="江苏泰信KR80A小型旋挖钻机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2014/01/21/20140121093501_90.jpg" alt="江苏泰信KR80A小型旋挖钻机"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a  class="ssresult" href="/proDetail/KR80-25.shtm" target="_blank" title="江苏泰信KR80A小型旋挖钻机">江苏泰信KR80A小型旋挖钻机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">领先的整体运输式全液压旋挖钻机，实现运输状态与施工状态快速转换；与天津大学数控与液压技术研究所合作研制的高性能液压系统和控制系统，实现钻机的高效施工和实时监控；<a class="ssresult" href="/proDetail/KR80-25.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=14261&amp;catalog=105003">江苏泰信旋挖钻机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=20905" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/KR80-25_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/KR80-25_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/KR80-25_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('20905','')">询最低价</a></div>
          </li>
		  <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/SR250.shtm" title="三一SR250旋挖钻机" target="_blank"><img src="http://product.21-sun.com/uploadfiles/sy/1259293645225.jpg" alt="三一SR250旋挖钻机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/SR250.shtm" target="_blank" title="三一SR250旋挖钻机">三一SR250旋挖钻机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">经典机型SR250主要面向直径Φ1.0m-Φ1.5m、深度50m以内的中小型工民建及市政桩基础工程，是粘土层、卵石层、泥岩层等中、强风化地质的理想机型。高效率主卷扬快速合流技术<a class="ssresult" href="/proDetail/SR250.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=133&amp;catalog=105003">三一旋挖钻机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=2552" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/SR250_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/SR250_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/SR250_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('2552','')">询最低价</a></div>
          </li>
          <%}%>
          <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("旋挖钻机")&&nowPage<=1){%>
          <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/KR80-25.shtm" title="江苏泰信KR80A小型旋挖钻机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2014/01/21/20140121093501_90.jpg" alt="江苏泰信KR80A小型旋挖钻机"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a  class="ssresult" href="/proDetail/KR80-25.shtm" target="_blank" title="江苏泰信KR80A小型旋挖钻机">江苏泰信KR80A小型旋挖钻机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">领先的整体运输式全液压旋挖钻机，实现运输状态与施工状态快速转换；与天津大学数控与液压技术研究所合作研制的高性能液压系统和控制系统，实现钻机的高效施工和实时监控；<a class="ssresult" href="/proDetail/KR80-25.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=14261&amp;catalog=105003">江苏泰信旋挖钻机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=20905" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/KR80-25_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/KR80-25_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/KR80-25_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('20905','')">询最低价</a></div>
          </li>
		  <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/SR250.shtm" title="三一SR250旋挖钻机" target="_blank"><img src="http://product.21-sun.com/uploadfiles/sy/1259293645225.jpg" alt="三一SR250旋挖钻机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/SR250.shtm" target="_blank" title="三一SR250旋挖钻机">三一SR250旋挖钻机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">经典机型SR250主要面向直径Φ1.0m-Φ1.5m、深度50m以内的中小型工民建及市政桩基础工程，是粘土层、卵石层、泥岩层等中、强风化地质的理想机型。高效率主卷扬快速合流技术<a class="ssresult" href="/proDetail/SR250.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=133&amp;catalog=105003">三一旋挖钻机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=2552" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/SR250_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/SR250_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/SR250_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('2552','')">询最低价</a></div>
          </li>
          <%}%>
          <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("大挖")&&nowPage<=1){%>
          <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/336D2XE-D2LXE.shtm" title="卡特彼勒336D2 XE/D2 L XE挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2015/02/20150228134314_14.jpg" alt="卡特彼勒336D2 XE/D2 L XE挖掘机"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/336D2XE-D2LXE.shtm" target="_blank" title="卡特彼勒336D2 XE/D2 L XE挖掘机">卡特彼勒336D2 XE/D2 L XE挖掘机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">操作台人性化设计让您全天保持极佳的舒适度和生产率。驾驶室结构和底座驾驶室外壳通过粘性橡胶安装座固定在机架上，不仅减振降噪，还能提高您的舒适度。底部周边使用粗大的<a class="ssresult" href="/proDetail/336D2XE-D2LXE.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=174&amp;catalog=101001">卡特挖掘机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=23905" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/336D2XE-D2LXE_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/336D2XE-D2LXE_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/336D2XE-D2LXE_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('23905','')">询最低价</a></div>
          </li>
          <%}%>
          <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("推土机")&&nowPage<=1){%>
<li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/SEM822.shtm" title="山工机械SEM822推土机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2015/04/20150414114453_85.jpg" alt="山工机械SEM822推土机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/SEM822.shtm" target="_blank" title="山工机械SEM822推土机">山工机械SEM822推土机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">传承于卡特彼勒第三代推土机的自动双回路电控静液压传动系统,作业效率同比高出30%120年卡特彼勒推土机设计及制造经验和40年的静液压传动经验带来成熟的技术和高传动效率；<a class="ssresult" href="/proDetail/SEM822.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=138&amp;catalog=101003">山工机械推土机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=23993" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/SEM822_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/SEM822_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/SEM822_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('23993','')">询最低价</a></div>
          </li>
          <%}%>
          <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("压路机")&&nowPage<=1){%>
<li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/SEM522.shtm" title="山工机械SEM522单钢轮压路机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2015/04/20150414115032_964.jpg" alt="山工机械SEM522单钢轮压路机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/SEM522.shtm" target="_blank" title="山工机械SEM522单钢轮压路机">山工机械SEM522单钢轮压路机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">可前倾驾驶室·业内独有的可前倾翻式驾驶室,对液压泵、变速箱、液压管路和电路系统等进行检修维护更方便·标配手动翻转驾驶室·选配液压翻转驾驶室卡特彼勒专利豆荚型振动<a class="ssresult" href="/proDetail/SEM522.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=138&amp;catalog=106001">山工机械压路机/压实机/夯</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=23997" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/SEM522_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/SEM522_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/SEM522_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('23997','')">询最低价</a></div>
          </li>
		  <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/SPR260.shtm" title="三一SPR260-5轮胎压路机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2015/02/20150215113933_574.jpg" alt="三一SPR260-5轮胎压路机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/SPR260.shtm" target="_blank" title="三一SPR260-5轮胎压路机">三一SPR260-5轮胎压路机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">首创自动喷油技术行业首创自动喷油技术，确保轮胎不粘沥青，省钱、省心，气动喷油无需油泵,稳定工作的保障真空加油，2分钟内即可加满油箱,无需人工倒油，可省一个抹油工，<a class="ssresult" href="/proDetail/SPR260.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=133&amp;catalog=106001">三一压路机/压实机/夯</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=7295" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/SPR260_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/SPR260_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/SPR260_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('7295','')">询最低价</a></div>
          </li>
		  <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/CLG614H.shtm" title="柳工CLG614H振动压路机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2015/12/20151231145536_473.jpg" alt="柳工CLG614H振动压路机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/CLG614H.shtm" target="_blank" title="柳工CLG614H振动压路机">柳工CLG614H振动压路机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">CLG614H型系列振动压路机为重型液压双驱动振动压路机，主要适用于各种材料的基础层、次基础层及填方的压实作业，是建设高等级公路、机场、港口、堤坝及工业建筑工地的理想<a class="ssresult" href="/proDetail/CLG614H.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=136&amp;catalog=106001">柳工压路机/压实机/夯</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=12566" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/CLG614H_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/CLG614H_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/CLG614H_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('12566','')">询最低价</a></div>
          </li>
          <%}%>
          <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("平地机")&&nowPage<=1){%>
<li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/SEM919.shtm" title="山工机械SEM919自行式平地机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2016/04/20160414090436_818.jpg" alt="山工机械SEM919自行式平地机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/SEM919.shtm" target="_blank" title="山工机械SEM919自行式平地机">山工机械SEM919自行式平地机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">宽敞舒适的驾驶室·驾驶室位于前车架上,可清晰看到牵引架、转盘、铲刀的位置,有利于驾驶员更精确控制铲刀定位·高大宽敞(高1.9米),可站立操作,容积大30%·折腰动作时可清晰<a class="ssresult" href="/proDetail/SEM919.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=138&amp;catalog=101005">山工机械平地机/铲运机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=10965" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/SEM919_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/SEM919_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/SEM919_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('10965','')">询最低价</a></div>
          </li>
		  
		  <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/CLG422.shtm" title="柳工CLG422自行式平地机" target="_blank"><img src="http://product.21-sun.com/uploadfiles/lg/1315565596125.jpg" alt="柳工CLG422自行式平地机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/CLG422.shtm" target="_blank" title="柳工CLG422自行式平地机">柳工CLG422自行式平地机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">独创吸风式散热系统吸风式散热系统允许弯曲通道进风，对散热器风阻的敏感性低，散热效率远高于吹风式散热系统，长时间使用后更显其高效、耐用。散热风扇由马达独立驱动，更<a class="ssresult" href="/proDetail/CLG422.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=136&amp;catalog=101005">柳工平地机/铲运机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=10012" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/CLG422_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/CLG422_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/CLG422_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('10012','')">询最低价</a></div>
          </li>
          <%}%>
          <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("装载机")&&nowPage<=1){%>
<li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/SEM656D-2.shtm" title="山工SEM656D轮式装载机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2016/04/20160414082732_458.jpg" alt="山工SEM656D轮式装载机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/SEM656D-2.shtm" target="_blank" title="山工SEM656D轮式装载机">山工SEM656D轮式装载机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">可靠耐用：重载车架,成熟的定轴式传动系统,重载工况大修周期同比延长。作业高效：引领行业的单变量液压系统、优化传动系统,铲装效率大幅提升。经济节能：优化低速发动机、<a class="ssresult" href="/proDetail/SEM656D-2.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=138&amp;catalog=101002">山工装载机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=28548" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/SEM656D-2_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/SEM656D-2_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/SEM656D-2_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('28548','')">询最低价</a></div>
          </li>
          <%}%>
          <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("装载机")&&nowPage<=1){%>
          <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/FL955F-ETX.shtm" title="雷沃FL955F-ETX+轮式装载机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2013/08/20130812141616_938.jpg" alt="雷沃FL955F-ETX+轮式装载机"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/FL955F-ETX.shtm" target="_blank" title="雷沃FL955F-ETX+轮式装载机">雷沃FL955F-ETX+轮式装载机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">更可靠1.厚重造车，整机自重行业领先；索玛桥结构，加强型桥体，超大承载能力；密闭箱型摇臂结构，强度提升40%。2.铲斗主切削板采用特种耐磨型材，抗磨性能提高30%。3.前后<a class="ssresult" href="/proDetail/FL955F-ETX.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=141&amp;catalog=101002">雷沃装载机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=10089" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/FL955F-ETX_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/FL955F-ETX_parameter.shtm" target="_blank">参数</a><em>|</em><a  class="ssresult" href="/proDetail/FL955F-ETX_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('10089','')">询最低价</a></div>
          </li>
		  <li><!--20151216添加-->
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/YX655.shtm" title="英轩重工YX655轮式装载机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2015/09/20150906101703_207.jpg" alt="英轩重工YX655轮式装载机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/YX655.shtm" target="_blank" title="英轩重工YX655轮式装载机">英轩重工YX655轮式装载机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">●全景车窗，外观时尚；高强度整体式框架结构，安全性高；密封减震性好，●豪华座椅，可选装空调，给用户提供舒适的操作环境；●采用符合非公路II阶段排放要求的节能型低速<a class="ssresult" href="/proDetail/YX655.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=1777&amp;catalog=101002">英轩重工装载机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=15106" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/YX655_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/YX655_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/YX655_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('15106','')">询最低价</a></div>
          </li>
          <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/LG933L.shtm" title="山东临工LG933L轮式装载机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2014/08/20140814154724_167.jpg" alt="山东临工LG933L轮式装载机"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/LG933L.shtm" target="_blank" title="山东临工LG933L轮式装载机">山东临工LG933L轮式装载机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">LG933L是一款适合散装物料的短轴距、高性价比机型，整机掘起力大，转弯半径小，操作灵活，作业效率高，广泛应用于港口、建筑工地、砂石厂、木料场等场合。1、配置符合国Ⅱ<a class="ssresult" href="/proDetail/LG933L.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=137&amp;catalog=101002">山东临工装载机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=7179" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/LG933L_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/LG933L_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/LG933L_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('7179','')">询最低价</a></div>
          </li>
          <%}%>
          <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("轮式装载机")&&nowPage<=1){%>
          <li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/LG933L.shtm" title="山东临工LG933L轮式装载机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2014/08/20140814154724_167.jpg" alt="山东临工LG933L轮式装载机"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/LG933L.shtm" target="_blank" title="山东临工LG933L轮式装载机">山东临工LG933L轮式装载机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">LG933L是一款适合散装物料的短轴距、高性价比机型，整机掘起力大，转弯半径小，操作灵活，作业效率高，广泛应用于港口、建筑工地、砂石厂、木料场等场合。1、配置符合国Ⅱ<a class="ssresult" href="/proDetail/LG933L.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=137&amp;catalog=101002">山东临工装载机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=7179" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/LG933L_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/LG933L_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/LG933L_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('7179','')">询最低价</a></div>
          </li>
          <%}%>
		  
		  
		            <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("摊铺机")&&nowPage<=1){%>
		<li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/512.shtm" title="柳工CLG512履带式摊铺机" target="_blank"><img src="http://product.21-sun.com/uploadfiles/lg/1313029193842.jpg" alt="柳工CLG512履带式摊铺机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/512.shtm" target="_blank" title="柳工CLG512履带式摊铺机">柳工CLG512履带式摊铺机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">精心设计便捷维护整机操作系统实现“一键通”，中位联锁，操作简易；国内技术领先的履带液压自动张紧装置，免维护。电液自动举升的顶蓬，方便转场和运输；电液自动整体翻转<a class="ssresult" href="/proDetail/512.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=136&amp;catalog=104001">柳工摊铺机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=2769" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/512_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/512_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/512_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('2769','')">询最低价</a></div>
          </li>
          <%}%>
		  
		            <%if(totalParts>0&&(keywordCheck+tempFactory+tempCatalog).equals("铣刨机")&&nowPage<=1){%>
		<li>
            <div class="tsx_pimg"><a class="ssresult" href="/proDetail/CLG51002.shtm" title="柳工CLG5100-2两驱-铣刨机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2015/06/20150605101825_754.jpg" alt="柳工CLG5100-2两驱-铣刨机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="/proDetail/CLG51002.shtm" target="_blank" title="柳工CLG5100-2两驱-铣刨机">柳工CLG5100-2两驱-铣刨机</a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum">柳工CLG5100-2两驱-铣刨机<a class="ssresult" href="/proDetail/CLG51002.shtm" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=136&amp;catalog=104005">柳工铣刨机</a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=25050" target="_blank">订单</a><em>|</em><a class="ssresult" href="/proDetail/CLG51002_pic.shtm" target="_blank">图片</a><em>|</em><a class="ssresult" href="/proDetail/CLG51002_parameter.shtm" target="_blank">参数</a><em>|</em><a class="ssresult" href="/proDetail/CLG51002_message.shtm" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('25050','')">询最低价</a></div>
          </li>
          <%}%>
		  
          <%	  
							if (totalParts>0) {				
								for(SolrDocument m : products){
			                        String img=CommonString.getFormatPara(m.getFieldValue("img"));
			                        String id = CommonString.getFormatPara(m.getFieldValue("id"));
			                        String title = CommonString.getFormatPara(m.getFieldValue("title")).replace("^r","<sup>®</sup>");
			                        String url = CommonString.getFormatPara(m.getFieldValue("url"));
			                        //String link_other = CommonString.getFormatPara(m.getFieldValue("link_other"));
			                        String file_name = CommonString.getFormatPara(m.getFieldValue("url"));
			                        String intro = CommonString.getFormatPara(m.getFieldValue("intro")).replace("^r","<sup>®</sup>");
                                    if(intro.length()>180){intro=intro.substring(0,180)+"...";}									
                                    String factory_id=CommonString.getFormatPara(m.getFieldValue("factoryid"));
                                    String factoryname=CommonString.getFormatPara(m.getFieldValue("factoryname")).replace("卡特彼勒","卡特");	
                                    String catalognum=CommonString.getFormatPara(m.getFieldValue("catalognum"));
									if(catalognum.length()>=6){catalognum=catalognum.substring(0,6);}
                                    String cataname=CommonString.getFormatPara(m.getFieldValue("catalogname"));	
                                    %>
								<li <%if((keywordCheck+tempFactory+tempCatalog).equals("搅拌车")&&(id.equals("13134")||id.equals("11111"))||factory_id.equals("204")){%> style="display:none"<%}%>>
            <div class="tsx_pimg"><a class="ssresult" href="<%=file_name%>" title="<%=title%>" target="_blank"><img src="<%=img%>" alt="<%=title%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></a></div>
            <div class="tsx_pnr">
              <h2 class="txs_ptitle">
                <!--<i class="txs_tag2">推广</i>-->
                <a class="ssresult" href="<%=file_name%>" target="_blank" title="<%=title%>"><%=title%></a>
                <!--<i class="txs_tag">停产在售</i>-->
              </h2>
              <div class="txs_psum"><%=intro%><a class="ssresult" href="<%=file_name%>" target="_blank">[查看详情]</a></div>
              <div class="txs_plink"> <a class="ssresult" href="/products/prolist.jsp?factory=<%=factory_id%>&catalog=<%=catalognum%>"><%=factoryname%><%=CommonString.getFormatPara(catalogMap.get(catalognum)).replace("混凝土泵车","泵车").replace("混凝土布料设备","布料机")%></a><em>|</em><a class="ssresult" href="/inquiry/index.jsp?proId=<%=id%>" target="_blank">订单</a><em>|</em><a class="ssresult" href="<%=file_name.replace(".shtm","_pic.shtm")%>" target="_blank">图片</a><em>|</em><a class="ssresult" href="<%=file_name.replace(".shtm","_parameter.shtm")%>" target="_blank">参数</a><em>|</em><a class="ssresult" href="<%=file_name.replace(".shtm","_message.shtm")%>" target="_blank">口碑</a> </div>
            </div>
            <div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('<%=id%>','')">询最低价</a></div>
          </li>
          <%}}%>
        </ul>
      </div>
      <div class="txd_bottomtel fix">如果没有找到您的信息，请直接重新搜索</div>
      <div class="txd_page fix">
        <div class="paging page" id="pagination">
          <tags:page_search nowPage="<%=nowPage%>" total="<%=totalParts %>"  totalPage="<%=pageCount%>" factory="<%=factory%>" catalog="<%=catalog%>" keyword="<%=pageKeyword%>" />
        </div>
      </div>
    </div>
  </div>
</div>
<!--right end-->
</div>
<%}else{%>
<!--无搜索结果-->
<div  style="display:none"></div>
<div class="contain1190">
  <div class="nser_nots mb10">非常抱歉，没有找到与“<span><%=keywordCheck%></span>”相关的商品</div>
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
        <li class="cblist" id="grab" style="display:;">
          <dt> 热门<br>
            品牌 </dt>
          <dd> <a href="/search/三一重工_0_0_0.htm">三一重工</a> <a href="/search/徐工_0_0_0.htm">徐工</a> <a href="/search/中联重科_0_0_0.htm">中联重科</a> <a href="/search/柳工_0_0_0.htm">柳工</a> <a href="/search/山推_0_0_0.htm">山推</a> <a href="/search/临工_0_0_0.htm">临工</a> <a href="/search/雷沃_0_0_0.htm">雷沃</a> <a href="/search/龙工_0_0_0.htm">龙工</a> <a href="/search/小松_0_0_0.htm">小松</a> <a href="/search/卡特_0_0_0.htm">卡特</a> <a href="/search/沃尔沃_0_0_0.htm">沃尔沃</a> <a href="/search/利勃海尔_0_0_0.htm">利勃海尔</a> <a href="/search/神钢_0_0_0.htm">神钢</a> <a href="/search/日立_0_0_0.htm">日立</a> <a href="/search/酒井_0_0_0.htm">酒井</a> <a href="/search/杰西博_0_0_0.htm">杰西博</a> </dd>
        </li>
      </ul>
    </div>
  </div>
  <div class="np_fix n_seach_no">
    <div class=" border03 l Condition mb10">
      <ul class="ConditionBottom">
        <li class="cblist" id="grab" style="display:;">
          <dt> 热门<br>
            产品 </dt>
          <dd> <a href="/search/挖掘机_0_0_0.htm">挖掘机</a> <a href="/search/装载机_0_0_0.htm">装载机</a> <a href="/search/推土机_0_0_0.htm">推土机</a> <a href="/search/平地机_0_0_0.htm">平地机</a> <a href="/search/自卸卡车_0_0_0.htm">自卸卡车</a> <a href="/search/铲运机_0_0_0.htm">铲运机</a> <a href="/search/塔式起重机_0_0_0.htm">塔式起重机</a> <a href="/search/汽车起重机_0_0_0.htm">汽车起重机</a> <a href="/search/履带式起重机_0_0_0.htm">履带式起重机</a> <a href="/search/高空作业平台_0_0_0.htm">高空作业平台</a> <a href="/search/高空作业车_0_0_0.htm">高空作业车</a> <a href="/search/随车起重机_0_0_0.htm">随车起重机</a> <a href="/search/施工升降机_0_0_0.htm">施工升降机</a> <a href="/search/伸缩臂叉装机_0_0_0.htm">伸缩臂叉装机</a> <a href="/search/泵车_0_0_0.htm">泵车</a> <a href="/search/车载泵_0_0_0.htm">车载泵</a> <a href="/search/拖泵_0_0_0.htm">拖泵</a> <a href="/search/输送泵_0_0_0.htm">输送泵</a> <a href="/search/混凝土搅拌设备_0_0_0.htm">混凝土搅拌设备</a> <a href="/search/混凝土布料设备_0_0_0.htm">混凝土布料设备</a> <a href="/search/混凝土搅拌运输车_0_0_0.htm">混凝土搅拌运输车</a> <a href="/search/干粉砂浆生产设备_0_0_0.htm">干粉砂浆生产设备</a> <a href="/search/粉粒物料运输车_0_0_0.htm">粉粒物料运输车</a> <a href="/search/其它混凝土设备_0_0_0.htm">其它混凝土设备</a> <a href="/search/干混砂浆生产线_0_0_0.htm">干混砂浆生产线</a> <a href="/search/沥青砂浆车_0_0_0.htm">沥青砂浆车</a> <a href="/search/干混砂浆背罐车_0_0_0.htm">干混砂浆背罐车</a> <a href="/search/喷湿机_0_0_0.htm">喷湿机</a> <a href="/search/摊铺机_0_0_0.htm">摊铺机</a> <a href="/search/养护机械_0_0_0.htm">养护机械</a> <a href="/search/其它路面机械_0_0_0.htm">其它路面机械</a> <a href="/search/沥青混合料搅拌设备_0_0_0.htm">沥青混合料搅拌设备</a> <a href="/search/铣刨机_0_0_0.htm">铣刨机</a> <a href="/search/稳定土厂拌设备_0_0_0.htm">稳定土厂拌设备</a> <a href="/search/沥青搅拌站_0_0_0.htm">沥青搅拌站</a> <a href="/search/稳定土拌合机_0_0_0.htm">稳定土拌合机</a> <a href="/search/旋挖钻机_0_0_0.htm">旋挖钻机</a> <a href="/search/液压静力压桩机_0_0_0.htm">液压静力压桩机</a> <a href="/search/打桩机_0_0_0.htm">打桩机</a> <a href="/search/水平定向钻_0_0_0.htm">水平定向钻</a> <a href="/search/连续墙抓斗_0_0_0.htm">连续墙抓斗</a> <a href="/search/长螺旋钻孔机_0_0_0.htm">长螺旋钻孔机</a> <a href="/search/打桩锤_0_0_0.htm">打桩锤</a> <a href="/search/潜孔钻机_0_0_0.htm">潜孔钻机</a> <a href="/search/多功能钻机_0_0_0.htm">多功能钻机</a> <a href="/search/强夯机_0_0_0.htm">强夯机</a> <a href="/search/液压步履式桩架_0_0_0.htm">液压步履式桩架</a> <a href="/search/多轴钻孔机_0_0_0.htm">多轴钻孔机</a> <a href="/search/连续墙钻机_0_0_0.htm">连续墙钻机</a> <a href="/search/截桩机_0_0_0.htm">截桩机</a> <a href="/search/其它桩工机械_0_0_0.htm">其它桩工机械</a> <a href="/search/压路机_0_0_0.htm">压路机</a> <a href="/search/压实机_0_0_0.htm">压实机</a> <a href="/search/夯实机_0_0_0.htm">夯实机</a> <a href="/search/内燃叉车_0_0_0.htm">内燃叉车</a> <a href="/search/电动叉车_0_0_0.htm">电动叉车</a> <a href="/search/仓储叉车_0_0_0.htm">仓储叉车</a> <a href="/search/破碎锤_0_0_0.htm">破碎锤</a> <a href="/search/液压剪_0_0_0.htm">液压剪</a> <a href="/search/凿岩机和钻机_0_0_0.htm">凿岩机和钻机</a> <a href="/search/输送和辅助设备_0_0_0.htm">输送和辅助设备</a> <a href="/search/破碎机_0_0_0.htm">破碎机</a> <a href="/search/装载及搬运设备_0_0_0.htm">装载及搬运设备</a> <a href="/search/连续采煤机和隧道掘进机_0_0_0.htm">连续采煤机和隧道掘进机</a> <a href="/search/矿用掘进机_0_0_0.htm">矿用掘进机</a> <a href="/search/采煤机_0_0_0.htm">采煤机</a> <a href="/search/凿岩台车_0_0_0.htm">凿岩台车</a> <a href="/search/筛分机_0_0_0.htm">筛分机</a> <a href="/search/全液压凿岩钻机_0_0_0.htm">全液压凿岩钻机</a> <a href="/search/盾构掘进机_0_0_0.htm">盾构掘进机</a> <a href="/search/凿岩钻车_0_0_0.htm">凿岩钻车</a> <a href="/search/检测车_0_0_0.htm">检测车</a> <a href="/search/运梁车_0_0_0.htm">运梁车</a> <a href="/search/架桥机_0_0_0.htm">架桥机</a> <a href="/search/提梁机_0_0_0.htm">提梁机</a> <a href="/search/砂浆车_0_0_0.htm">砂浆车</a> <a href="/search/堆高机_0_0_0.htm">堆高机</a> <a href="/search/正面吊_0_0_0.htm">正面吊</a> <a href="/search/场桥_0_0_0.htm">场桥</a> <a href="/search/推耙机_0_0_0.htm">推耙机</a> <a href="/search/吊具_0_0_0.htm">吊具</a> <a href="/search/专用车辆_0_0_0.htm">专用车辆</a> <a href="/search/消防车_0_0_0.htm">消防车</a> <a href="/search/牵引车_0_0_0.htm">牵引车</a> </dd>
        </li>
      </ul>
    </div>
  </div>
  <div class="border03 n_se_nopro">
    <div class="n_se_nopro_t1">热门产品推荐</div>
    <div class="n_sepro_list">
      <ul class="tabList01 np_fix">
        <jsp:include page="/include/search/hot_pro_list.jsp" flush="false"/>
      </ul>
    </div>
  </div>
  <div class="telTip mt10">如果没有找到您的信息，请直接重新搜索</div>
</div>
<%}%>
<!--main end-->
<%if(totalParts>0){%>
<!--foot search 有搜索结果时出现-->
<div class="contain1190">
  <div class="nse_foot_search"><span>重新搜索</span>
    <input onkeypress="tj();" value="<%=keywordCheck%>"  name="keyword" id="keywords" type="text" class="nse_foot_seinp"/>
    <input type="submit" class="nse_foot_sebtn" value="搜索" onclick="tj();" />
  </div>
  <div class="telTip">如果没有找到您的信息，请直接重新搜索</div>
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
<!--foot search end-->
<!--like-->
<div class="contain1190 mt10 pb10">
  <div class="nse_youlike">
    <p class="nse_guesslike">根据浏览猜你喜欢</p>
    <jsp:include page="/include/search/other_pro_list_new.jsp" flush="false"/>
  </div>
</div>
<!--like end-->
<%}%>
<!--foot-->
<style>
.f_ewm{ margin-right:0;}
</style>
<jsp:include page="/include/new_foot_index.htm" flush="true"/>
<!--foot end-->
<script type="text/javascript" src="/new_resources/js/sele_t.js"></script>
<script type="text/javascript"  src="/new_resources/js/new_common.js"></script>
 
<script type="text/javascript">
$('.pro_searlist_xjcat .cat_miao_close').click(function(){
	$('.pro_searlist_xjcat').hide();
});

		jQuery.ajax({
		url:'/tools/ajax.jsp?flag=search_log&keywords=<%=pageKeyword%>',
		async:false,
		cache:false,
		success:function(data){
			
 
		}
	    });
</script>
</body>
</html>