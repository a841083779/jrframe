<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.Connection,com.jerehnet.webservice.*,java.sql.*,java.util.*,com.jerehnet.util.dbutil.DBHelper,com.jerehnet.util.common.*" errorPage="" %><%
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	if(catalog.equals("0")){
		catalog = "";
	}
	String area = CommonString.getFormatPara(request.getParameter("area"));
	if(area.equals("0")){
		area = "";
	}
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	if(factory.equals("0")){
		factory = "";
	}
	Map brandMap = (Map)application.getAttribute("brandMap");
	Map catalogMap = (Map)application.getAttribute("catalogMap");
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	ArrayList<Map> allSubCataList = new ArrayList<Map>();
	for(Map subCata : catalogList){
		if(CommonString.getFormatPara(subCata.get("num")).length() == 6){
			allSubCataList.add(subCata);
		}
	}
	DBHelper dbHelper = DBHelper.getInstance();
	Connection conn = null;
	try{
		conn = dbHelper.getConnection("web21market");
		
		String areaQuery = "select area_id,area_name,parent_area_id from comm_area where level_id=2 and area_id<>105500 and area_id<>105690 and area_id<>105300 and area_id<>105880 order by node_full_name";
		List<Map> areaList = dbHelper.getMapList(areaQuery);
		LinkedHashMap areaMap = new LinkedHashMap();
		areaMap.put("105500", "北京");
		areaMap.put("105690", "天津");
		areaMap.put("105300", "上海");
		areaMap.put("105880", "重庆");
		for(Map areaM : areaList){
			String area_id = CommonString.getFormatPara(areaM.get("area_id"));
			String area_name = CommonString.getFormatPara(areaM.get("area_name"));
			if(area_name.endsWith("州")){
				area_name = area_name.substring(0, area_name.length()-1);
			}
			area_name = area_name.replace("市", "").replace("地区", "").replace("林区", "").replace("区", "");
			if(area_name.length() < 5){
				areaMap.put(area_id, area_name);
			}
		}
		
		List<Map> provinceList = dbHelper.getMapList("select area_id from comm_area where level_id=1 and area_id<>105499 and area_id<>105290 and area_id<>105689 and area_id<>105879 order by area_name");
		List<Map> cityList = dbHelper.getMapList("select area_id,area_name,parent_area_id from comm_area where level_id=2 and area_id<>105500 and area_id<>105690 and area_id<>105300 and area_id<>105880");
		
		List<Map> factoryList = null;
		List<Map> productList = null;
		String weixiuQuery = "select top 36 id,title,province,city,pub_date from sell_buy_market where is_show=1 and (title like '%维修%' or title like '%保养%')";
		if(!catalog.equals("")){
			weixiuQuery = "select top 15 id,title,province,city,pub_date from sell_buy_market where is_show=1 and (title like '%维修%' or title like '%保养%')";
			weixiuQuery += " and title like '%" + CommonString.getFormatPara(catalogMap.get(catalog)) + "%'";
			
			factoryList = dbHelper.getMapList("select factoryid,max(factoryname) as factoryname from pro_catalog_factory where catalognum like '" + catalog + "%' group by factoryid order by max(order_no) desc");
			
			String productQuery = "select top 5 p.id,p.factoryname,p.name,p.introduce,p.catalogname,p.file_name,p.img2,p.factoryid,p.catalognum,f.usern,f.full_name from pro_products p join pro_agent_factory f on p.factoryid=f.id where p.is_show=1";
			productQuery += " and p.catalognum like '" + catalog + "%'";
			if(!factory.equals("")){
				productQuery += " and p.factoryid=" + factory;
			}
			productQuery += " order by p.id desc, p.view_count desc";
			productList = dbHelper.getMapList(productQuery);
		}
		if(!area.equals("")){
			weixiuQuery += " and title like '%" + CommonString.getFormatPara(areaMap.get(area)) + "%'";
		}
		weixiuQuery += " order by id desc";
		List<Map> weixiuList = dbHelper.getMapList(weixiuQuery, conn);
		
		String newsQuery = "select top 17 title,link_other,html_filename from article where is_pub=1";
		if(!catalog.equals("")){
			newsQuery += " and title like '%" + CommonString.getFormatPara(catalogMap.get(catalog)) + "%'";
		}
		if(!area.equals("")){
			newsQuery += " and title like '%" + CommonString.getFormatPara(areaMap.get(area)) + "%'";
		}
		if(!factory.equals("")){
			newsQuery += " and title like '%" + CommonString.getFormatPara(brandMap.get(factory)) + "%'";
		}
		newsQuery += " order by pub_date desc";
		List<Map> newsList = WEBDBHelper.getMapList(newsQuery, "Web21sunDBHelper");
		
		String companyQuery = "select top 8 id,corporation from webypage where ispublished=1";
		if(!catalog.equals("")){
			companyQuery += " and bussiness like '%" + CommonString.getFormatPara(catalogMap.get(catalog)) + "%'";
		}
		companyQuery += " order by mem_flag desc";
		List<Map> companyList = WEBDBHelper.getMapList(companyQuery, "Web21sunDBHelper");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
	if(catalog.equals("") && area.equals("")){
%>
<title>工程机械维修网 – 提供工程机械维修论坛|维修招聘|工程机械培训信息</title>
<meta name="keywords" content="工程机械维修,工程机械维修论坛,维修培训,维修资料" />
<meta name="description" content="工程机械维修网-提供工程机械维修招聘,维修培训,维修资料资讯,找工程机械维修信息上工程机械维修网!" />
<%
	}else{
		if(!catalog.equals("") && !area.equals("") && !factory.equals("")){
%>
<title>【<%=CommonString.getFormatPara(areaMap.get(area)) + CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修】<%=CommonString.getFormatPara(brandMap.get(factory)) + "|" + CommonString.getFormatPara(areaMap.get(area)) + CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>修理 - 工程机械维修网</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(areaMap.get(area)) + CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修,<%=CommonString.getFormatPara(areaMap.get(area)) + CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>修理" />
<meta name="description" content="<%=CommonString.getFormatPara(areaMap.get(area)) %>工程机械维修网为您提供：<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修知识和<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修资料等大量<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修保养信息。维修<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>上<%=CommonString.getFormatPara(areaMap.get(area)) %>工程机械维修网!" />
<%
		}else if(!catalog.equals("") && !area.equals("")){
%>
<title>【<%=CommonString.getFormatPara(areaMap.get(area)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修】<%=CommonString.getFormatPara(areaMap.get(area)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>修理 - 工程机械维修网</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(areaMap.get(area)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修,<%=CommonString.getFormatPara(areaMap.get(area)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>修理" />
<meta name="description" content="<%=CommonString.getFormatPara(areaMap.get(area)) %>工程机械维修网为您提供：<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>维修知识和<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>维修资料等大量<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>维修保养信息。维修<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>上<%=CommonString.getFormatPara(areaMap.get(area)) %>工程机械维修网!" />
<%
		}else if(!catalog.equals("") && !factory.equals("")){
%>
<title>【<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修】<%=CommonString.getFormatPara(brandMap.get(factory)) + "|" + CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>修理 - 工程机械维修网</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修,<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>修理" />
<meta name="description" content="工程机械维修网为您提供：<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修知识和<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修资料等大量<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修保养信息。维修<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>上工程机械维修网!" />
<%
		}else if(!catalog.equals("")){
%>
<title>【<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>维修】<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>维修资料|培训|论坛 - 工程机械维修网</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>维修,<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>维修资料,<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>手册,<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>维修论坛" />
<meta name="description" content="工程机械维修网为您提供<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>知识,<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>资料,<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>手册等大量信息。维修<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>设备上工程机械维修网!" />
<%
		}else if(!area.equals("")){
%>
<title>【<%=CommonString.getFormatPara(areaMap.get(area)) %>工程机械维修】<%=CommonString.getFormatPara(areaMap.get(area)) %>工程机械设备修理 -工程机械维修网</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(areaMap.get(area)) %>工程机械维修,<%=CommonString.getFormatPara(areaMap.get(area)) %>工程机械设备维修,<%=CommonString.getFormatPara(areaMap.get(area)) %>工程机械设备修理" />
<meta name="description" content="<%=CommonString.getFormatPara(areaMap.get(area)) %>工程机械维修网为您提供<%=CommonString.getFormatPara(areaMap.get(area)) %>工程机械设备维修等大量商贸信息。维修设备上、工程机械维修网!" />
<%
		}
	}
%>
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<link href="/weixiu/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/citys_weixiu.js"></script>
<link href="../style/friendly_link.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	.nav ul.navlist li a { padding: 0px 30px;_padding: 0px 28px; }
</style>
</head>
<body>
<!--top-->
<jsp:include page="top.jsp" flush="true" />
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a href="/">中国工程机械维修网</a>
  <%
	  if(!catalog.equals("")){
  %>
  &nbsp;&gt;&gt;&nbsp;<a href="/<%=catalog %>-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog)) %>维修</a>
  <%
	  }
  %>
  <%
  	  if(!area.equals("")){
  %>
  &nbsp;&gt;&gt;&nbsp;<a href="/<%=catalog %>-<%=area %>-0.htm"><%=CommonString.getFormatPara(areaMap.get(area)) + (catalog.equals("") ? "工程机械" : CommonString.getFormatPara(catalogMap.get(catalog))) %>维修</a>
  <%
  	  }
  %>
  <%
  	  if(!factory.equals("")){
  %>
  &nbsp;&gt;&gt;&nbsp;<a href="/<%=catalog %>-<%=area %>-<%=factory %>.htm"><%=CommonString.getFormatPara(areaMap.get(area)) + CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修</a>
  <%
  	  }
  %>
  </h3>
</div>
<!--top end-->
<!--main-->
<div class="contain980 clearfix">
  <!--left-->
  <div class="reLeft">
  	<%
  		if(catalog.equals("")){
  	%>
    <!--按维修分类查找维修-->
    <div class="rp clearfix mb10 cate">
      <div class="title">
        <h3>按维修分类查找维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list blue">
            <li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("101001")) %>维修" href="/101001-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("101001")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("104001")) %>维修" href="/104001-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("104001")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("104009")) %>维修" href="/104009-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("104009")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("104005")) %>维修" href="/104005-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("104005")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("101005")) %>维修" href="/101005-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("101005")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("106001")) %>维修" href="/106001-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("106001")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("103001")) %>维修" href="/103001-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("103001")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("105028")) %>维修" href="/105028-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("105028")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("101003")) %>维修" href="/101003-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("101003")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("101002")) %>维修" href="/101002-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("101002")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("101004")) %>维修" href="/101004-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("101004")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("101008")) %>维修" href="/101008-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("101008")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("118004")) %>维修" href="/118004-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("118004")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("111001")) %>维修" href="/111001-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("111001")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("102002")) %>维修" href="/102002-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("102002")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("102010")) %>维修" href="/102010-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("102010")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("102011")) %>维修" href="/102011-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("102011")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("107010")) %>维修" href="/107010-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("107010")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("105017")) %>维修" href="/105017-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("105017")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("111006")) %>维修" href="/111006-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("111006")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("118003")) %>维修" href="/118003-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("118003")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("113002")) %>维修" href="/113002-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("113002")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("103014")) %>维修" href="/103014-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("103014")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("103006")) %>维修" href="/103006-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("103006")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("109004")) %>维修" href="/109004-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("109004")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("109002")) %>维修" href="/109002-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("109002")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("110009")) %>维修" href="/110009-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("110009")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("111002")) %>维修" href="/111002-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("111002")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("113001")) %>维修" href="/113001-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("113001")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("110012")) %>维修" href="/110012-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("110012")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("103010")) %>维修" href="/103010-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("103010")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("110005")) %>维修" href="/110005-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("110005")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("105003")) %>维修" href="/105003-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("105003")) %>维修</a></li>
			<li><a target="_blank" title="<%=CommonString.getFormatPara(catalogMap.get("104002")) %>维修" href="/104002-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get("104002")) %>维修</a></li>
        </ul>
      </div>
    </div>
  	<%
  		}
  	%>
    
    <!--按地区查找维修-->
    <div class="rp clearfix mb10 area">
      <div class="title">
        <h3>按地区查找<%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list blue">
        	<%
        		if(!catalog.equals("") || !area.equals("")){
        	%>
        	<li<%=area.equals("") ? " class=\"selected\"" : "" %>><a title="不限地区" href="/<%=catalog.equals("") ? "0" : catalog %>-0-0.htm">不限地区</a></li>
        	<%
        		}
        	%>
            <li<%=area.equals("105500") ? " class=\"selected\"" : "" %>><a title="北京工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-105500-0.htm">北京</a></li>
			<li<%=area.equals("105300") ? " class=\"selected\"" : "" %>><a title="上海工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-105300-0.htm">上海</a></li>
			<li<%=area.equals("105690") ? " class=\"selected\"" : "" %>><a title="天津工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-105690-0.htm">天津</a></li>
			<li<%=area.equals("105880") ? " class=\"selected\"" : "" %>><a title="重庆工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-105880-0.htm">重庆</a></li>
			<li<%=area.equals("106410") ? " class=\"selected\"" : "" %>><a title="石家庄工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-106410-0.htm">石家庄</a></li>
			<li<%=area.equals("108310") ? " class=\"selected\"" : "" %>><a title="太原工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-108310-0.htm">太原</a></li>
			<li<%=area.equals("109710") ? " class=\"selected\"" : "" %>><a title="呼和浩特工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-109710-0.htm">呼和浩特</a></li>
			<li<%=area.equals("120010") ? " class=\"selected\"" : "" %>><a title="沈阳工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-120010-0.htm">沈阳</a></li>
			<li<%=area.equals("119010") ? " class=\"selected\"" : "" %>><a title="长春工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-119010-0.htm">长春</a></li>
			<li<%=area.equals("122010") ? " class=\"selected\"" : "" %>><a title="哈尔滨工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-122010-0.htm">哈尔滨</a></li>
			<li<%=area.equals("110910") ? " class=\"selected\"" : "" %>><a title="南京工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-110910-0.htm">南京</a></li>
			<li<%=area.equals("104210") ? " class=\"selected\"" : "" %>><a title="杭州工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-104210-0.htm">杭州</a></li>
			<li<%=area.equals("102320") ? " class=\"selected\"" : "" %>><a title="合肥工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-102320-0.htm">合肥</a></li>
			<li<%=area.equals("142010") ? " class=\"selected\"" : "" %>><a title="福州工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-142010-0.htm">福州</a></li>
			<li<%=area.equals("103110") ? " class=\"selected\"" : "" %>><a title="南昌工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-103110-0.htm">南昌</a></li>
			<li<%=area.equals("101260") ? " class=\"selected\"" : "" %>><a title="济南工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-101260-0.htm">济南</a></li>
			<li<%=area.equals("130010") ? " class=\"selected\"" : "" %>><a title="郑州工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-130010-0.htm">郑州</a></li>
			<li<%=area.equals("124010") ? " class=\"selected\"" : "" %>><a title="武汉工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-124010-0.htm">武汉</a></li>
			<li<%=area.equals("126010") ? " class=\"selected\"" : "" %>><a title="长沙工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-126010-0.htm">长沙</a></li>
			<li<%=area.equals("128010") ? " class=\"selected\"" : "" %>><a title="广州工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-128010-0.htm">广州</a></li>
			<li<%=area.equals("113010") ? " class=\"selected\"" : "" %>><a title="南宁工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-113010-0.htm">南宁</a></li>
			<li<%=area.equals("141510") ? " class=\"selected\"" : "" %>><a title="海口工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-141510-0.htm">海口</a></li>
			<li<%=area.equals("139010") ? " class=\"selected\"" : "" %>><a title="成都工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-139010-0.htm">成都</a></li>
			<li<%=area.equals("132010") ? " class=\"selected\"" : "" %>><a title="贵阳工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-132010-0.htm">贵阳</a></li>
			<li<%=area.equals("137010") ? " class=\"selected\"" : "" %>><a title="昆明工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-137010-0.htm">昆明</a></li>
			<li<%=area.equals("115010") ? " class=\"selected\"" : "" %>><a title="拉萨工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-115010-0.htm">拉萨</a></li>
			<li<%=area.equals("135510") ? " class=\"selected\"" : "" %>><a title="西安工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-135510-0.htm">西安</a></li>
			<li<%=area.equals("134010") ? " class=\"selected\"" : "" %>><a title="兰州工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-134010-0.htm">兰州</a></li>
			<li<%=area.equals("133010") ? " class=\"selected\"" : "" %>><a title="西宁工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-133010-0.htm">西宁</a></li>
			<li<%=area.equals("116010") ? " class=\"selected\"" : "" %>><a title="银川工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-116010-0.htm">银川</a></li>
			<li<%=area.equals("117010") ? " class=\"selected\"" : "" %>><a title="乌鲁木齐工程机械设备维修、修理" href="/<%=catalog.equals("") ? "0" : catalog %>-117010-0.htm">乌鲁木齐</a></li>
        </ul>
      </div>
    </div>
    
    <%
    	if(factoryList!=null && factoryList.size()>0){
    %>
    <div class="rp clearfix mb10 brands">
      <div class="title">
        <h3><%=CommonString.getFormatPara(catalogMap.get(catalog)) %>维修品牌</h3>
      </div>
      <div class="content rList01">
        <ul class="list blue">
          <li<%=factory.equals("") ? " class=\"selected\"" : "" %>><a href="/<%=catalog %>-<%=area.equals("") ? "0" : area %>-0.htm">不限品牌</a></li>
    <%
    		for(Map factoryMap : factoryList){
    			String factoryid = CommonString.getFormatPara(factoryMap.get("factoryid"));
    			String factoryname = CommonString.getFormatPara(factoryMap.get("factoryname"));
    %>
    <li<%=factory.equals(factoryid) ? " class=\"selected\"" : "" %>><a href="/<%=catalog.equals("") ? "0" : catalog %>-<%=area.equals("") ? "0" : area %>-<%=factoryid %>.htm"><%=factoryname %></a></li>
    <%
    		}
    %>
        </ul>
      </div>
    </div>
    <%
    	}
    %>
    
    <div class="rp clearfix mb10 company">
      <div class="title">
        <h3><%=catalog.equals("") ? "工程机械" : CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修企业<%=area.equals("") ? "" : "(" + CommonString.getFormatPara(areaMap.get(area)) + ")" %></h3>
      </div>
      <div class="content rList01">
        <ul class="list blue">
          <%
              if(companyList!=null && companyList.size()>0){
            	  for(Map company : companyList){
          %>
          <li><a target="_blank" href="http://www.21-sun.com/supply/corpintro.jsp?findid=<%=CommonString.getFormatPara(company.get("id")) %>"><%=CommonString.getFormatPara(company.get("corporation")) %></a></li>
          <%
            	  }
              }
          %>
        </ul>
      </div>
    </div>
    
  </div>
  <!--left end-->
  <!--middle-->
  <div class="reMid">
    <div class="ad mb10" style="width:450px; height:90px;"><a href="http://product.21-sun.com/tuan/december/" target="_blank"><img src="/weixiu/images/ad/ad01.jpg" width="450" height="90" /></a></div>
    
    <div class="rp clearfix mb10 repairList">
      <div class="title">
        <h3><%=catalog.equals("") && area.equals("") ? "最新工程机械" : CommonString.getFormatPara(areaMap.get(area)) + CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修</h3>
        <span class="more"><a target="_blank" href="http://sowa.21-sun.com/?q=<%=("维修 " + CommonString.getFormatPara(areaMap.get(area)) + " " + CommonString.getFormatPara(brandMap.get(factory)) + " " + CommonString.getFormatPara(catalogMap.get(catalog))).trim() %>&f=market">更多&gt;&gt;</a></span>
      </div>
      <div class="content rList01">
        <ul class="list blue">
        	<%
        		if(weixiuList!=null && weixiuList.size()>0){
        			for(Map weixiu : weixiuList){
        				String id = CommonString.getFormatPara(weixiu.get("id"));
        				String title = CommonString.getFormatPara(weixiu.get("title"));
        				String pub_date = CommonDate.getFormatDate("MM-dd HH:mm", weixiu.get("pub_date"));
        	%>
        	<li>
	            <h3><span class="lb">[维修]</span><a href="http://market.21-sun.com/viewSellBuy_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></h3>
	            <span class="time"><%=pub_date %></span>
	        </li>
        	<%
        			}
        		}
        	%>
        </ul>
      </div>
    </div>
    <%
    	if(productList!=null && productList.size()>0){
    %>
    <div class="rp clearfix mb10 productList">
      <div class="title">
        <h3><%=CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>产品</h3>
        <span class="more"><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factory %>&catalog=<%=catalog %>">更多&gt;&gt;</a></span>
      </div>
      <div class="content">
        <ul class="list blue">
        	<%
        		for(Map product : productList){
        			String p_id = CommonString.getFormatPara(product.get("id"));
        			String p_url = "http://product.21-sun.com/proDetail/" + CommonString.getFormatPara(product.get("file_name"));
        			String p_img = "http://product.21-sun.com/uploadfiles/" + CommonString.getFormatPara(product.get("img2"));
        			String p_name = CommonString.getFormatPara((String) product.get("factoryname") + (String) product.get("name") + (String) product.get("catalogname"));
        	%>
        	<li>
        		<a href="<%=p_url %>" target="_blank"><img alt="<%=p_name %>" src="<%=p_img %>" width="130" height="90" class="plimg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" /></a>
        		<div class="w328 r">
        			<h2><a target="_blank" href="<%=p_url %>"><%=p_name %></a></h2>
	        		<span class="info">
	        			<a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(product.get("factoryid"))%>&catalog=<%=CommonString.getFormatPara(product.get("catalognum")).length() >= 6 ? CommonString.getFormatPara(product.get("catalognum")).substring(0, 6) : CommonString.getFormatPara(product.get("catalognum"))%>">
	        				<%=CommonString.getFormatPara((String)product.get("factoryname")) + CommonString.getFormatPara(catalogMap.get((((String)product.get("catalognum")).length() >= 6) ? CommonString.getFormatPara(product.get("catalognum")).substring(0, 6) : CommonString.getFormatPara(product.get("catalognum"))))%>
	        			</a><em>|</em>
	        			<a href="http://photo.21-sun.com/detail_for_<%=p_id %>.htm" target="_balnk">图片</a><em>|</em>
	        			<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(product.get("file_name")).replace(".shtm","_message.shtm")%>" target="_blank">评论</a><br />
	        			<!-- <a href="javascript://void(0);" onclick="showinquery('<%=CommonString.getFormatPara(product.get("id"))%>','')" class="plbtn">询价</a> -->
	        			<a href="http://product.21-sun.com/brand/<%=CommonString.getFormatPara(product.get("usern")) %>/" target="_blank">[<%=CommonString.getFormatPara(product.get("full_name")) %>]</a>
	        			
	        		</span>
        		</div>
        	</li>
        	<%		
        		}
        	%>
        </ul>
      </div>
    </div>
    <%
    	}
    %>
  </div>
  <!--middle end-->
  <!--right-->
  <div class="reRight">
  
    <div class="adlist130x40 clearfix">
      <ul class="list">
        <li><a href="http://ad.21-sun.com/link_to.jsp?paras=101,101,7135&url=http://www.green-belt.cn/" target="_blank"><img src="/weixiu/images/ad/yald120.gif" width="130" height="40" /></a></li>
        <li><a href="http://ad.21-sun.com/link_to.jsp?paras=101,101,5196&url=http://www.liugong.cn/" target="_blank"><img src="/weixiu/images/ad/liugong120.gif" width="130" height="40" /></a></li>
        <li><a href="http://ad.21-sun.com/link_to.jsp?paras=1,5,16&amp;url=http://www.kubota.com.cn/kesco/" target="_blank"><img src="/weixiu/images/ad/jbt120.gif" width="130" height="40" /></a></li>
        <li><a href="http://ad.21-sun.com/link_to.jsp?paras=101,101,5880&url=www.fptindustrial.com.cn" target="_blank"><img src="/weixiu/images/ad/fpt.gif" width="130" height="40" /></a></li>
        <li><a href="http://ad.21-sun.com/link_to.jsp?paras=1,5,18&amp;url=www.isuzupowertrain.com" target="_blank"><img src="/weixiu/images/ad/isuzu1.gif" width="130" height="40" /></a></li>
        <li><a href="http://www.shantui.com/" target="_blank"><img src="/weixiu/images/ad/shantui.gif" width="130" height="40" /></a></li>
        <li><a href="http://ad.21-sun.com/link_to.jsp?paras=1,5,2771&url=http://www.jsjuchao.com/" target="_blank"><img src="/weixiu/images/ad/juchao100.gif" width="130" height="40" /></a></li>
        <li><a href="http://www.ahgrand.com/" target="_blank"><img src="/weixiu/images/ad/grd.gif" width="130" height="40" /></a></li>
      </ul>
    </div>
    <div class="mb10" style="width:270px; height:90px; clear:both;"><a href="http://www.doosan.com/doosaninfracorece/chn/cn/pressRelease.do?cmd=viewPressRelease&no=20131101110149821863&pageNo=1&mode=&sideSearchTxt=&sort=PRESS_DATE&dateStartInput=&dateEndInput=&searchTxtCompare=&searchTxt" target="_blank"><img src="/weixiu/images/ad/ad03.jpg" width="270" height="90" /></a></div>
    
    <div class="rp clearfix mb10">
      <div class="title">
        <h3><%=catalog.equals("") && area.equals("") ? "最新" : CommonString.getFormatPara(areaMap.get(area)) + CommonString.getFormatPara(brandMap.get(factory)) + CommonString.getFormatPara(catalogMap.get(catalog)) %>维修资讯</h3>
      </div>
      <div class="content rList01">
        <ul class="list blue">
        	<%
        		if(newsList!=null && newsList.size()>0){
        			for(Map news : newsList){
        				String news_title = CommonString.getFormatPara(news.get("title"));
        				String news_link_other = CommonString.getFormatPara(news.get("link_other"));
        				String news_html_filename = CommonString.getFormatPara(news.get("html_filename"));
        				String url = news_link_other;
        				if(news_link_other.equals("")){
        					String year = news_html_filename.substring(0,4);
        					String month = news_html_filename.substring(4,6);
        					url = "http://news.21-sun.com/detail/" + year + "/" + month + "/" + news_html_filename;
        				}
        	%>
        	<li><a href="<%=url %>" target="_blank"><%=news_title %></a></li>
        	<%
        			}
        		}
        	%>
        </ul>
      </div>
    </div>
    
    <div class="mb10" style="width:270px; height:265px; clear:both;"><a href="http://www.wajueji.com/cat/index.jsp" target="_blank"><img src="/weixiu/images/ad/ad04.jpg" width="270" height="265" /></a></div>
    
  </div>
  <!--right end-->
  
  <div class="rp clearfix mb10 moreCate">
    <div class="title">
      <h3>更多工程机械维修分类</h3>
    </div>
    <div class="content rList01">
      <ul class="list blue">
      <%
          if(allSubCataList.size() > 0){
        	  for(int i=0; i<allSubCataList.size(); i++){
        		  if(i < 34){
      %>
          <li><a target="_blank" href="/<%=CommonString.getFormatPara(allSubCataList.get(i).get("num")) %>-0-0.htm"><%=CommonString.getFormatPara(allSubCataList.get(i).get("name")) %>维修</a></li>
      <%
        		  }
        	  }
        	  if(allSubCataList.size() > 34){
      %>
      	  <li><a href="javascript://void(0);" onclick="$(this).parents('ul').hide();$(this).parents('ul').siblings('ul').show();">更多...</a></li>
      <%
        	  }
          }
      %>
      </ul>
      <ul class="list blue hide">
      <%
      	if(allSubCataList.size() > 0){
      		for(int i=0; i<allSubCataList.size(); i++){
      %>
          <li><a target="_blank" href="/<%=CommonString.getFormatPara(allSubCataList.get(i).get("num")) %>-0-0.htm"><%=CommonString.getFormatPara(allSubCataList.get(i).get("name")) %>维修</a></li>
      <%
      		}
      	}
      %>
      </ul>
    </div>
  </div>
  
  <div class="rp clearfix mb10 moreArea">
    <div class="title">
      <h3>更多工程机械维修地区</h3>
    </div>
    <div class="content rList01">
      <ul id="area" class="list blue">
      	  <li><a href="/<%=catalog.equals("") ? "0" : catalog %>-105500-0.htm">北京</a></li>
      	  <li><a href="/<%=catalog.equals("") ? "0" : catalog %>-105300-0.htm">上海</a></li>
      	  <li><a href="/<%=catalog.equals("") ? "0" : catalog %>-105690-0.htm">天津</a></li>
      	  <li><a href="/<%=catalog.equals("") ? "0" : catalog %>-105880-0.htm">重庆</a></li>
      <%
      	  for(Map province : provinceList){
      		  String parent_id = CommonString.getFormatPara(province.get("area_id"));
      		  int first_count = 0;
      		  for(Map city : cityList){
      			  if(CommonString.getFormatPara(city.get("parent_area_id")).equals(parent_id)){
      				  first_count++;
      				  if(first_count == 1){
      					  String area_id = CommonString.getFormatPara(city.get("area_id"));
      					  String area_name = CommonString.getFormatPara(city.get("area_name"));
      					  if(area_name.endsWith("州")){
      						  area_name = area_name.substring(0, area_name.length()-1);
      					  }
      					  area_name = area_name.replace("市", "").replace("地区", "").replace("林区", "").replace("区", "");
      					  if(area_name.length() < 5){
      %>
      	  <li><a href="/<%=catalog.equals("") ? "0" : catalog %>-<%=area_id %>-0.htm"><%=area_name %></a></li>
      <%
      					  }
      				  }
      			  }
      		  }
      	  }
      
	      for(Map province : provinceList){
	  		  String parent_id = CommonString.getFormatPara(province.get("area_id"));
	  		  int first_count = 0;
	  		  for(Map city : cityList){
	  			  if(CommonString.getFormatPara(city.get("parent_area_id")).equals(parent_id)){
	  				  first_count++;
	  				  if(first_count == 2){
	  					  String area_id = CommonString.getFormatPara(city.get("area_id"));
    					  String area_name = CommonString.getFormatPara(city.get("area_name"));
    					  if(area_name.endsWith("州")){
      						  area_name = area_name.substring(0, area_name.length()-1);
      					  }
      					  area_name = area_name.replace("市", "").replace("地区", "").replace("林区", "").replace("区", "");
      					  if(area_name.length() < 5){
	  %>
	  	  <li><a href="/<%=catalog.equals("") ? "0" : catalog %>-<%=area_id %>-0.htm"><%=area_name %></a></li>
	  <%
      					  }
	  				  }
	  			  }
	  		  }
	  	  }
	      
	      int last_count = 0;
	      for(Map province : provinceList){
	  		  String parent_id = CommonString.getFormatPara(province.get("area_id"));
	  		  int first_count = 0;
	  		  for(Map city : cityList){
	  			  if(CommonString.getFormatPara(city.get("parent_area_id")).equals(parent_id)){
	  				  first_count++;
	  				  if(first_count == 3){
	  					  String area_id = CommonString.getFormatPara(city.get("area_id"));
    					  String area_name = CommonString.getFormatPara(city.get("area_name"));
    					  if(area_name.endsWith("州")){
      						  area_name = area_name.substring(0, area_name.length()-1);
      					  }
      					  area_name = area_name.replace("市", "").replace("地区", "").replace("林区", "").replace("区", "");
      					  if(area_name.length() < 5){
      						  last_count++;
	  %>
	  	  <li><a href="/0-<%=area_id %>-0.htm"><%=area_name %></a></li>
	  <%
      					  }
	  				  }
	  			  }
	  		  }
	  		  if(last_count == 6){
	  			  break;
	  		  }
	  	  }
      %>
      	  <li><a href="javascript://void(0);" onclick="$('#area').hide();$('#area_all').show();">更多...</a></li>
      </ul>
      <ul id="area_all" class="list blue hide">
      <%
      	  Iterator areaAllIter = areaMap.entrySet().iterator();
      	  while(areaAllIter.hasNext()){
      		  Map.Entry entry = (Map.Entry)areaAllIter.next();
      		  String area_id = CommonString.getFormatPara(entry.getKey());
      		  String area_name = CommonString.getFormatPara(entry.getValue());
      %>
      	  <li><a href="/0-<%=area_id %>-0.htm"><%=area_name %></a></li>
      <%
      	  }
      %>
      </ul>
    </div>
  </div>
  
</div>
<!--main end-->
<%
	if(catalog.equals("") && factory.equals("") && area.equals("")){
%>
<jsp:include page="/include/index/friendlink_weixiu.htm" flush="true"/>
<%
	}
%>
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--end of foot--> 
<div style="display:none;">
	<script src="http://s17.cnzz.com/stat.php?id=5755862&web_id=5755862" language="JavaScript"></script>
</div>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(conn);
	}
%>