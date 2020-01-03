<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%
    DBHelper dbHelper = DBHelper.getInstance() ;
	String keywordCheck = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String keyword = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String type = CommonString.getFormatPara(request.getParameter("type")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	if(type.equals("")){
		type = "Product";
	}
	String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	//搜索新
	int totalParts = 0; 
	/*接收参数*/
	SolrQuery query = new SolrQuery();
	List<SolrQuery.SortClause> orderList = new ArrayList<SolrQuery.SortClause>();
	orderList.add(SolrQuery.SortClause.desc("view_count"));
	int nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));
	nowPage = nowPage <= 0 ? 1 : nowPage;
	List<String> whereList = new ArrayList<String>();
	if(keywordCheck.equals("")){
		query.setQuery("*:*");
	}else{
	    whereList.add("title:" + keywordCheck);
	    query.setQuery(keywordCheck);
	}
    /*查询*/				
	int pageSize = 10;
	query.setRequestHandler("/jereh");
	String [] whereAry = new String [whereList.size()];
	whereAry = whereList.toArray(whereAry);
	query.addFilterQuery(whereAry);
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【工程机械图片大全|挖掘机图片|装载机图片】- 中国工程机械商贸网</title>
<meta name="keywords" content="工程机械图片,工程机械图库,工程机械图片大全" />
<meta name="description" content="挖掘机图片，装载机图片，国内工程机械图片量最丰富、图片清晰度最高的专业工程机械图片频道。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/new_style.css" rel="stylesheet" type="text/css" />
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
  <h3 class="breadCrumbs"><a href="/">搜索结果</a> &gt;&gt; <a href="/products/">挖掘机</a> </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="np_fix contain980"> 
  <!--left-->
  <div class="w210 l">
  
  
	<div class="w208 border01 l leftPart mb10">
	  <div class="treev1" id="treev1" style="max-height:10000px; overflow-y:hidden;">
	    <ul>
	    <%
	    	for(Map topCat : catalogList){
	    		String topCatNum = CommonString.getFormatPara(topCat.get("num"));
	    		if(topCatNum.length() == 3){
	    			String topCatName = CommonString.getFormatPara(topCat.get("name"));
	    			String topCatId = CommonString.getFormatPara(topCat.get("id"));
	    %>
	    <li class="root" id="cat_<%=topCatNum %>">
	    	<b style="font-size:14px;"><a href="/<%=topCatNum %>-0-0.htm"><%=topCatName %></a></b>
	    	<ul style="display:<%=topCatNum.equals(catalog) || (!catalog.equals("")&&catalog.substring(0, 3).equals(topCatNum)) ? "block" : "none" %>;">
	    <%
				    for(Map subCat : catalogList){
						String subParentId = CommonString.getFormatPara(subCat.get("parentid"));
						if(subParentId.equals(topCatId)){
							String subCatNum = CommonString.getFormatPara(subCat.get("num"));
							String subCatName = CommonString.getFormatPara(subCat.get("name"));
		%>
				<li id="cat_<%=topCatNum %>_<%=subCatNum %>"<%=catalog.equals(subCatNum) ? " class=\"rootCur\"" : "" %>>
					<a href="/<%=subCatNum %>-0-0.htm" class="mainBrand"><big><%=subCatName %></big></a>
		<%
			if(catalog.equals(subCatNum)){
				List<Map> brandList = dbHelper.getMapList("select factoryid,max(factoryname) as factoryname from pro_catalog_factory where catalognum like '" + catalog + "%' group by factoryid order by max(order_no) desc");
				if(brandList!=null && brandList.size()>0){
		%>
				<ul id="cat_<%=topCatNum %>_<%=subCatNum %>_brand">
		<%
					for(Map brand : brandList){
						String brandId = CommonString.getFormatPara(brand.get("factoryid"));
						String brandName = CommonString.getFormatPara(brand.get("factoryname"));
		%>
					<li><a href="/<%=subCatNum %>-<%=brandId %>-0.htm"><%=brandName %></a></li>
		<%
					}
		%>
				</ul>
		<%
				}
			}
		%>
				</li>
		<%
						}
					}
	    %>
	    	</ul>
	    </li>
	    <%
	    		}
	    	}
	    %>
	    </ul>
	  </div>
	  <!--字母检索结束--> 
	</div>
	
	
    <div class="nseleft_listo mb10">
      <ul class="nse_secat_list">
        <li><a href="#">动态</a></li>
        <li class="cur"><a href="#">供应</a>
          <ul>
            <li><a href="#">&middot; 供求</a></li>
            <li><a href="#">&middot; 二手</a></li>
          </ul>
        </li>
        <li><a href="#">二手</a></li>
        <li><a href="#">租赁</a></li>
      </ul>
    </div>
    <div class="Similar nse_left_viewpro">
      <div class="stitle">
        <h3>最近浏览过的产品</h3>
      </div>
      <div class="scontent">
	  
        <ul class="slist">
          <li><a target="_blank" title="新源机械65W-8D轮式挖掘机口碑" href="http://product.21-sun.com/proDetail/65W-8D_message.shtm"><img src="http://product.21-sun.com/uploadfiles//image/2012/09/20120927103409_415.jpg" alt="新源机械65W-8D轮式挖掘机口碑" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="80" height="70">
            <h4>新源机械65W-8D轮式挖掘机口碑</h4>
            </a></li>
          <li><a target="_blank" title="嘉和重工JHL85轮式挖掘机口碑" href="http://product.21-sun.com/proDetail/JHL85_message.shtm"><img src="http://product.21-sun.com/uploadfiles//image/2013/02/20130226114532_361.jpg" alt="嘉和重工JHL85轮式挖掘机口碑" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="80" height="70">
            <h4>嘉和重工JHL85轮式挖掘机口碑</h4>
            </a></li>
          <li><a target="_blank" title="犀牛重工XN60-4L轮式挖掘机口碑" href="http://product.21-sun.com/proDetail/XN60-4L_message.shtm"><img src="http://product.21-sun.com/uploadfiles//image/2012/11/20121105155121_658.jpg" alt="犀牛重工XN60-4L轮式挖掘机口碑" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="80" height="70">
            <h4>犀牛重工XN60-4L轮式挖掘机口碑</h4>
            </a></li>
          <li><a target="_blank" title="神钢SK75-8挖掘机口碑" href="http://product.21-sun.com/proDetail/SK75-8_message.shtm"><img src="http://product.21-sun.com/uploadfiles//image/2013/12/20131230115217_384.jpg" alt="神钢SK75-8挖掘机口碑" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="80" height="70">
            <h4>神钢SK75-8挖掘机口碑</h4>
            </a></li>
          <li><a target="_blank" title="小松PC70-8挖掘机口碑" href="http://product.21-sun.com/proDetail/PC70-8_message.shtm"><img src="http://product.21-sun.com/uploadfiles/11022610035890_0.jpg" alt="小松PC70-8挖掘机口碑" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" width="80" height="70">
            <h4>小松PC70-8挖掘机口碑</h4>
            </a></li>
        </ul>
		
		
      </div>
    </div>
  </div>
  <!--left end--> 
  <!--right-->
  <div class="w757 r">
    <div class="nse_xg_search">相关搜索：<span><a href="#">挖掘机</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href="#">轮式挖掘机</a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<span><a href="#">履带挖掘机</a></span></div>
    <form name="theform" id="theform">
      <div class="w755 border03 l Condition mb10">
        <div class="ConditionTop">
          <div class="l"> <span class="reset" onclick="sosuo();">重置</span> <span><em>装载机</em> <a href="javascript:void(0)" title="取消" class="delete" onclick="sosuo(&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;,&quot;&quot;)"></a> </span> </div>
          <h1 class="r" style="font-size:14px;">装载机</h1>
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
            <dd> <a onclick="sosuo('101002','','');" href="javascript:void(0)" class="select">不限</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','137','')" href="javascript:;">临工</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','136','')" href="javascript:;">柳工</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','138','')" href="javascript:;">山工</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','135','')" href="javascript:;">龙工</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','209','')" href="javascript:;">徐工</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','1777','')" href="javascript:;">英轩重工</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','144','')" href="javascript:;">山推</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','174','')" href="javascript:;">卡特彼勒</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','192','')" href="javascript:;">斗山</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','182','')" href="javascript:;">小松</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','172','')" href="javascript:;">晋工</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','175','')" href="javascript:;">沃尔沃</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','149','')" href="javascript:;">沃得重工</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','157','')" href="javascript:;">力士德</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','141','')" href="javascript:;">福田雷沃</a> 
              
              <!-- 挖掘机 --> 
              <a onclick="sosuo('101002','148','')" href="javascript:;">常林股份</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 680px;">
                
				<div class="pllist"> <a class="plfl"> A-B-C-D-E-F-G </a><br>
                  <a href="/products/prolist.jsp?factory=1185&amp;catalog=101002" target="_top">阿尔多</a> <a href="/products/prolist.jsp?factory=13570&amp;catalog=101002" target="_top">宝鼎</a> <a href="/products/prolist.jsp?factory=1703&amp;catalog=101002" target="_top">甘肃宝龙</a> <a href="/products/prolist.jsp?factory=615&amp;catalog=101002" target="_top">长阳机械</a> <a href="/products/prolist.jsp?factory=148&amp;catalog=101002" target="_top">常林股份</a> <a href="/products/prolist.jsp?factory=485&amp;catalog=101002" target="_top">朝工</a> <a href="/products/prolist.jsp?factory=13576&amp;catalog=101002" target="_top">朝阳建工</a> <a href="/products/prolist.jsp?factory=145&amp;catalog=101002" target="_top">成工</a> <a href="/products/prolist.jsp?factory=1591&amp;catalog=101002" target="_top">楚工龙泰</a> <a href="/products/prolist.jsp?factory=1243&amp;catalog=101002" target="_top">道辰格</a> <a href="/products/prolist.jsp?factory=1218&amp;catalog=101002" target="_top">道胜</a> <a href="/products/prolist.jsp?factory=151&amp;catalog=101002" target="_top">德工</a> <a href="/products/prolist.jsp?factory=140&amp;catalog=101002" target="_top">鼎盛重工</a> <a href="/products/prolist.jsp?factory=1763&amp;catalog=101002" target="_top">东德重工</a> <a href="/products/prolist.jsp?factory=1187&amp;catalog=101002" target="_top">东方红</a> <a href="/products/prolist.jsp?factory=192&amp;catalog=101002" target="_top">斗山</a> <a href="/products/prolist.jsp?factory=1188&amp;catalog=101002" target="_top">福大机械</a> <a href="/products/prolist.jsp?factory=1183&amp;catalog=101002" target="_top">福工</a> <a href="/products/prolist.jsp?factory=141&amp;catalog=101002" target="_top">福田雷沃</a> <a href="/products/prolist.jsp?factory=141&amp;catalog=101002" target="_top">福田雷沃重工</a> <a href="/products/prolist.jsp?factory=1208&amp;catalog=101002" target="_top">福威重工</a> <a href="/products/prolist.jsp?factory=1721&amp;catalog=101002" target="_top">富豪</a> <a href="/products/prolist.jsp?factory=1888&amp;catalog=101002" target="_top">富亿机械</a> <a href="/products/prolist.jsp?factory=477&amp;catalog=101002" target="_top">格瑞德</a> </div>
                <div class="pllist"> <a class="plfl"> H-I-J-K-L-M-N </a> <br>
                  <a href="/products/prolist.jsp?factory=158&amp;catalog=101002" target="_top">合力</a> <a href="/products/prolist.jsp?factory=13641&amp;catalog=101002" target="_top">恒康</a> <a href="/products/prolist.jsp?factory=13626&amp;catalog=101002" target="_top">鸿源</a> <a href="/products/prolist.jsp?factory=1526&amp;catalog=101002" target="_top">华伟重工</a> <a href="/products/prolist.jsp?factory=1512&amp;catalog=101002" target="_top">华中建机</a> <a href="/products/prolist.jsp?factory=13622&amp;catalog=101002" target="_top">惠工</a> <a href="/products/prolist.jsp?factory=177&amp;catalog=101002" target="_top">JCB</a> <a href="/products/prolist.jsp?factory=13176&amp;catalog=101002" target="_top">嘉和重工</a> <a href="/products/prolist.jsp?factory=1352&amp;catalog=101002" target="_top">建德机械</a> <a href="/products/prolist.jsp?factory=487&amp;catalog=101002" target="_top">江麓</a> <a href="/products/prolist.jsp?factory=13657&amp;catalog=101002" target="_top">金城</a> <a href="/products/prolist.jsp?factory=1737&amp;catalog=101002" target="_top">金正神力</a> <a href="/products/prolist.jsp?factory=172&amp;catalog=101002" target="_top">晋工</a> <a href="/products/prolist.jsp?factory=1232&amp;catalog=101002" target="_top">久工</a> <a href="/products/prolist.jsp?factory=1193&amp;catalog=101002" target="_top">巨超重工</a> <a href="/products/prolist.jsp?factory=681&amp;catalog=101002" target="_top">浙江军联</a> <a href="/products/prolist.jsp?factory=174&amp;catalog=101002" target="_top">卡特彼勒</a> <a href="/products/prolist.jsp?factory=14247&amp;catalog=101002" target="_top">开普动力</a> <a href="/products/prolist.jsp?factory=455&amp;catalog=101002" target="_top">凯斯</a> <a href="/products/prolist.jsp?factory=1756&amp;catalog=101002" target="_top">凯威</a> <a href="/products/prolist.jsp?factory=13663&amp;catalog=101002" target="_top">科泰重工</a> <a href="/products/prolist.jsp?factory=13097&amp;catalog=101002" target="_top">莱工</a> <a href="/products/prolist.jsp?factory=1194&amp;catalog=101002" target="_top">蓝翔重工</a> <a href="/products/prolist.jsp?factory=13683&amp;catalog=101002" target="_top">力士</a> <a href="/products/prolist.jsp?factory=157&amp;catalog=101002" target="_top">力士德</a> <a href="/products/prolist.jsp?factory=13687&amp;catalog=101002" target="_top">立藤</a> <a href="/products/prolist.jsp?factory=179&amp;catalog=101002" target="_top">利勃海尔</a> <a href="/products/prolist.jsp?factory=137&amp;catalog=101002" target="_top">临工</a> <a href="/products/prolist.jsp?factory=136&amp;catalog=101002" target="_top">柳工</a> <a href="/products/prolist.jsp?factory=135&amp;catalog=101002" target="_top">龙工</a> <a href="/products/prolist.jsp?factory=14233&amp;catalog=101002" target="_top">龙兴机械</a> <a href="/products/prolist.jsp?factory=1739&amp;catalog=101002" target="_top">鲁青</a> <a href="/products/prolist.jsp?factory=14257&amp;catalog=101002" target="_top">鲁宇重工</a> <a href="/products/prolist.jsp?factory=688&amp;catalog=101002" target="_top">鲁岳</a> <a href="/products/prolist.jsp?factory=13669&amp;catalog=101002" target="_top">路大</a> <a href="/products/prolist.jsp?factory=673&amp;catalog=101002" target="_top">洛阳路通</a> <a href="/products/prolist.jsp?factory=13118&amp;catalog=101002" target="_top">山东鲁工</a> <a href="/products/prolist.jsp?factory=13697&amp;catalog=101002" target="_top">闽工</a> <a href="/products/prolist.jsp?factory=13700&amp;catalog=101002" target="_top">纳科重工</a> <a href="/products/prolist.jsp?factory=1748&amp;catalog=101002" target="_top">农友</a> <a href="/products/prolist.jsp?factory=13699&amp;catalog=101002" target="_top">诺力</a> </div>
                <div class="pllist"> <a class="plfl"> O-P-Q-R-S-T </a><br>
                  <a href="/products/prolist.jsp?factory=13702&amp;catalog=101002" target="_top">欧霸重工</a> <a href="/products/prolist.jsp?factory=486&amp;catalog=101002" target="_top">普什重机</a> <a href="/products/prolist.jsp?factory=1750&amp;catalog=101002" target="_top">全工机械</a> <a href="/products/prolist.jsp?factory=184&amp;catalog=101002" target="_top">日立</a> <a href="/products/prolist.jsp?factory=1216&amp;catalog=101002" target="_top">瑞诺</a> <a href="/products/prolist.jsp?factory=741&amp;catalog=101002" target="_top">江苏上騏</a> <a href="/products/prolist.jsp?factory=133&amp;catalog=101002" target="_top">三一</a> <a href="/products/prolist.jsp?factory=626&amp;catalog=101002" target="_top">森田重机</a> <a href="/products/prolist.jsp?factory=14280&amp;catalog=101002" target="_top">山东海宏</a> <a href="/products/prolist.jsp?factory=1722&amp;catalog=101002" target="_top">山东威猛</a> <a href="/products/prolist.jsp?factory=138&amp;catalog=101002" target="_top">山工</a> <a href="/products/prolist.jsp?factory=142&amp;catalog=101002" target="_top">山河智能</a> <a href="/products/prolist.jsp?factory=454&amp;catalog=101002" target="_top">山猫</a> <a href="/products/prolist.jsp?factory=144&amp;catalog=101002" target="_top">山推</a> <a href="/products/prolist.jsp?factory=1207&amp;catalog=101002" target="_top">山挖重工</a> <a href="/products/prolist.jsp?factory=13718&amp;catalog=101002" target="_top">上力重工</a> <a href="/products/prolist.jsp?factory=14235&amp;catalog=101002" target="_top">神娃机械</a> <a href="/products/prolist.jsp?factory=1720&amp;catalog=101002" target="_top">沈阳山河</a> <a href="/products/prolist.jsp?factory=1728&amp;catalog=101002" target="_top">泰安鲁能</a> </div>
                <div class="pllist"> <a class="plfl"> U-V-W-X-Y-Z </a> <br>
                  <a href="/products/prolist.jsp?factory=1189&amp;catalog=101002" target="_top">威肯</a> <a href="/products/prolist.jsp?factory=1738&amp;catalog=101002" target="_top">威盛</a> <a href="/products/prolist.jsp?factory=14256&amp;catalog=101002" target="_top">威源机械</a> <a href="/products/prolist.jsp?factory=149&amp;catalog=101002" target="_top">沃得重工</a> <a href="/products/prolist.jsp?factory=175&amp;catalog=101002" target="_top">沃尔沃</a> <a href="/products/prolist.jsp?factory=623&amp;catalog=101002" target="_top">犀牛重工</a> <a href="/products/prolist.jsp?factory=139&amp;catalog=101002" target="_top">厦工</a> <a href="/products/prolist.jsp?factory=13175&amp;catalog=101002" target="_top">厦门金华</a> <a href="/products/prolist.jsp?factory=13784&amp;catalog=101002" target="_top">厦强</a> <a href="/products/prolist.jsp?factory=1744&amp;catalog=101002" target="_top">厦盛</a> <a href="/products/prolist.jsp?factory=13783&amp;catalog=101002" target="_top">厦装</a> <a href="/products/prolist.jsp?factory=194&amp;catalog=101002" target="_top">现代</a> <a href="/products/prolist.jsp?factory=1359&amp;catalog=101002" target="_top">现代（山东）</a> <a href="/products/prolist.jsp?factory=182&amp;catalog=101002" target="_top">小松</a> <a href="/products/prolist.jsp?factory=1683&amp;catalog=101002" target="_top">新源机械</a> <a href="/products/prolist.jsp?factory=209&amp;catalog=101002" target="_top">徐工</a> <a href="/products/prolist.jsp?factory=1522&amp;catalog=101002" target="_top">徐工特机</a> <a href="/products/prolist.jsp?factory=150&amp;catalog=101002" target="_top">徐挖</a> <a href="/products/prolist.jsp?factory=867&amp;catalog=101002" target="_top">徐州凯尔</a> <a href="/products/prolist.jsp?factory=155&amp;catalog=101002" target="_top">烟工</a> <a href="/products/prolist.jsp?factory=770&amp;catalog=101002" target="_top">宜工</a> <a href="/products/prolist.jsp?factory=1749&amp;catalog=101002" target="_top">忆辉</a> <a href="/products/prolist.jsp?factory=1777&amp;catalog=101002" target="_top">英轩重工</a> <a href="/products/prolist.jsp?factory=647&amp;catalog=101002" target="_top">永工</a> <a href="/products/prolist.jsp?factory=562&amp;catalog=101002" target="_top">愚公机械</a> <a href="/products/prolist.jsp?factory=143&amp;catalog=101002" target="_top">宇通重工</a> <a href="/products/prolist.jsp?factory=146&amp;catalog=101002" target="_top">玉柴重工</a> <a href="/products/prolist.jsp?factory=14238&amp;catalog=101002" target="_top">约翰迪尔</a> <a href="/products/prolist.jsp?factory=195&amp;catalog=101002" target="_top">詹阳动力</a> <a href="/products/prolist.jsp?factory=13817&amp;catalog=101002" target="_top">正泰</a> <a href="/products/prolist.jsp?factory=13813&amp;catalog=101002" target="_top">中际</a> <a href="/products/prolist.jsp?factory=134&amp;catalog=101002" target="_top">中联重科</a> <a href="/products/prolist.jsp?factory=188&amp;catalog=101002" target="_top">竹内</a> </div>
				  
              </div>
            </dd>
          </li>
          <script type="text/javascript">
	            if('101002'.indexOf("101001")!=-1){
	              jQuery("#grab").attr("style","display:;") ;
	            }
	               if('101002'.indexOf("101002")!=-1){
	              jQuery("#loader").attr("style","display:;") ;
	            }
	               if('101002'.indexOf("102")!=-1){
	              jQuery("#crane").attr("style","display:;") ;
	            }
	          </script>
        </ul>
      </div>
      <input type="hidden" name="order" id="order">
      <input type="hidden" name="keyword" id="key_word">
    </form>
    <div class="nseresult_pro">
      <div class="nse_usedate">找到约<%=totalParts %>条结果（用时0.01秒）</div>
      <ul class="nser_searchList">
        <%
		    for(SolrDocument m : products){
			String id = CommonString.getFormatPara(m.getFieldValue("id"));
			String title = CommonString.getFormatPara(m.getFieldValue("title"));
			String url = CommonString.getFormatPara(m.getFieldValue("url"));
			String link_other = CommonString.getFormatPara(m.getFieldValue("link_other"));
			String intro = CommonString.getFormatPara(m.getFieldValue("intro"));
			if(intro.length()>90){intro=intro.substring(0,90)+"...";}
			String titleAlt = title;
		 	if(title.length()>20){
		 		titleAlt=title;
		 		title=title.substring(0,20)+"...";
			}
		 	
		%>
		
		<li class="pro">
          <div class="proimg"> <a target="_blank" href="<%=url%>"> <img onerror="this.src='/images/nopic.jpg'" src="http://product.21-sun.com/uploadfiles/20081204135907_0.jpg" width="131" height="90"> </a> </div>
          <div class="prointro">
            <h3><a target="_blank" href="<%=url%>" ><%=title%></a> <span class="proLinks">【<a target="_blank" href="<%=url.replace(".shtm","")%>_parameter.shtm" >参数</a>】【<a target="_blank" href="<%=url.replace(".shtm","")%>_pic.shtm" >图片</a>】【<a target="_blank" href="<%=url.replace(".shtm","")%>_order.shtm"><font>询价</font></a>】</span></h3>
            <span class="sc"><%=intro%></span>
            <div class="site"> <a target="_blank" href="<%=url%>" style="color: #4D9724;">http://product.21-sun.com<%=url%></a> </div>
          </div>
        </li>
         <%}%>
      </ul>
    </div>
    <div class="nse_page">
      <div class="paging page" id="pagination"><a class="pre noPre" title="上一页" href="javascript:;"></a> <span class="current"><b>&nbsp;1&nbsp;</b></span><a class="num" href="?offset=8&amp;catalog=101001">&nbsp;2&nbsp;</a><a class="num" href="?offset=16&amp;catalog=101001">&nbsp;3&nbsp;</a><a class="num" href="?offset=24&amp;catalog=101001">&nbsp;4&nbsp;</a><a class="num" href="?offset=32&amp;catalog=101001">&nbsp;5&nbsp;</a><a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a><a class="num" href="?offset=1080&amp;catalog=101001">&nbsp;136&nbsp;</a><a class="num" href="?offset=1088&amp;catalog=101001">&nbsp;137&nbsp;</a><a href="?offset=8&amp;catalog=101001" class="next"></a></div>
      <div class="l nse_allresult">共约<%=totalParts %>条结果</div>
    </div>
  </div>
  <!--right end--> 
</div>
<!--main end--> 
<!--foot search-->
<div class="contain980">
	<div class="nse_foot_search"><span>重新搜索</span><input type="text" class="nse_foot_seinp"/>
	<input type="button" class="nse_foot_sebtn" value="搜索"/></div>
    <div class="telTip">如果没有找到您的信息，请直接致电：<strong>4006-521-526</strong></div>
</div>
<!--foot search end-->
<!--like-->
<div class="contain980 mt10 pb10">
	<div class="nse_youlike">
    	<p class="nse_guesslike">根据浏览猜你喜欢</p>		
		<jsp:include page="/include/search/other_pro_list.jsp" flush="false"/>
    </div>
</div>
<!--like end-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--foot end--> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>