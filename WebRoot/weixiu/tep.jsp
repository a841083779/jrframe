<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection,com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
	<cache:cache  cron="* * * */2 *">
<%
	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;// 品牌
	String catalogid = CommonString.getFormatPara(request.getParameter("catalogid")) ;// 栏目
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String province = CommonString.getFilterStr(request.getParameter("province")) ;
    String city = CommonString.getFilterStr(request.getParameter("city")) ;
	String show_province="";
	String show_city="";
	if(!"".equals(factory) && "".equals(factoryid)){
		factoryid = factory ;
	}
	if(!"".equals(catalogid) && "".equals(catalog)){
		catalog = catalogid ;
	}
	//参数过滤
	if(factoryid.equals("0")){factoryid="";}
	if(catalog.equals("0")){catalog="";}
	if(province.equals("0")){province="";}
	if(city.equals("0")){city="";}
	
	
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map hzpyMap=(HashMap)application.getAttribute("hzpyMap") ;
    Map pyhzMap=(HashMap)application.getAttribute("pyhzMap") ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap");
	Map brandUsernMap = (HashMap)application.getAttribute("brandUsernMap") ;
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String url = CommonString.getFormatPara(request.getQueryString()) ;
	String showtonandmeter = "";
	if ("grab_1_13".equals(tonandmeter)) {
		showtonandmeter = "小挖(1T~13T)";
	} else if ("grab_14_30".equals(tonandmeter)) {
		showtonandmeter = "中挖(14T~30T)";
	} else if ("grab_30_1".equals(tonandmeter)) {
		showtonandmeter = "大挖(30T以上)";
	} else if ("loader_1_3".equals(tonandmeter)) {
		showtonandmeter = "3T以下";
	} else if ("loader_3_01".equals(tonandmeter)) {
		showtonandmeter = "3T";
	} else if ("loader_3_5".equals(tonandmeter)) {
		showtonandmeter = "3T~5T";
	} else if ("crane_1_16".equals(tonandmeter)) {
		showtonandmeter = "16T以下";
	} else if ("crane_20_70".equals(tonandmeter)) {
		showtonandmeter = "20T~70T";
	} else if ("crane_70_1".equals(tonandmeter)) {
		showtonandmeter = "70T以上";
	} else {
		showtonandmeter = "";
	}
	
   //搜索条件
   	String whereStr = " and flag = 2 and is_show = 1 ";
	String brand =factoryid;           //品牌
    String model =catalog;          //类别
	if(!"".equals(province)){
	       show_province=(String)hzpyMap.get(province);
	       whereStr += " and ( address like '%"+show_province+"%' or city like '%"+show_province+"%' ) ";
	}
    if(!"".equals(city)){
	       show_city=(String)hzpyMap.get(city);
           whereStr += " and ( address like '%"+show_city+"%' or city like '%"+show_city+"%' ) ";		   
	}
	//如果有品牌，首先查询出该品牌的全部代理商
	if(!"".equals(brand)){
			whereStr += " and ( agent_fac LIKE '%"+brand+",%' OR agent_fac LIKE '%,"+brand+"%' or agent_fac = '"+brand+"' ) ";
		//	whereStr += " and agent_fac in  ( '"+brand+"' ) ";
	}
	//如果有代理类型
	if(!"".equals(model)){
				whereStr += " and id in ( ";
				whereStr += " select distinct agent_id from pro_agent_products ";
				whereStr += " where product_id in ( select id from pro_products where catalognum like '"+model+"%' and is_show = 1 ) ";
				whereStr += " ) ";   
	}
    String orderByStr = " id desc";
   //拆分吨位
	String[] parttonandmeters = null;
	String firsttonandmeter = "";
	String sectonandmeter = "";
	        PageBean pageBean = new PageBean();
			Integer nowPage = 1 ;
		    if(!"".equals(offset) && !"0".equals(offset)){
	             nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	        }
			
    String 	areaName="";
	if(province.equals("")){areaName+=CommonString.getFormatPara(hzpyMap.get(province));}
	if(city.equals("")){areaName+=CommonString.getFormatPara(hzpyMap.get(city));}
	
	//TDK
	String title="【维修网点】工程机械维修中心_工程机械售后服务 - 铁臂维修";
	String keywords="工程机械维修网点,工程机械维修中心,工程机械售后服务,铁臂维修";
	String description="铁臂维修包括所有工程机械品牌的维修网点，帮助您快速解决工程机械故障难题，买工程机械就上铁臂商城。";
    try{	
	        connection = dbHelper.getConnection();
			pageBean.setTableName("pro_agent_factory");  
			pageBean.setFields("id,full_name,agent_fac_name,city,usern,telphone,is_qijiandian,is_made");
			pageBean.setCondition(whereStr);
			pageBean.setIsShowSql(true);
			pageBean.setOrderBy(orderByStr);
			pageBean.setNowPage(nowPage);
			pageBean.setPageSize(18);
			List<Map> agents = pageBean.getDatas(connection);
			//查询省市
		    List<Map> provinceList = dbHelper.getMapList(" select * from hz_py where province='0' order by id asc ",connection) ;
			List <Map> sanylist=null;
			List <Map> catlist=null;
			List <Map> xcmglist=null;
			List <Map> zoomlionlist=null;
			List <Map> volvolist=null;
			if(factoryid.equals("")&&catalog.equals("")){
			//三一代理商
			//String sql_sany = " select top 9 full_name,is_qijiandian,is_made,usern from pro_agent_factory where flag = 2 and is_show = 1 and agent_fac like '%133%' order by view_count desc";
			//sanylist= (List <Map>)dbHelper.getMapList(sql_sany,new Object[]{});
			//卡特代理商
			//String sql_cat = " select top 9 full_name,is_qijiandian,is_made,usern  from pro_agent_factory where flag = 2 and is_show = 1 and agent_fac like '%174%'  order by view_count desc";
			//catlist= (List <Map>)dbHelper.getMapList(sql_cat,new Object[]{});		   
		   //徐工代理商
			//String sql_xcmg = " select top 9 full_name,is_qijiandian,is_made,usern  from pro_agent_factory where flag = 2 and is_show = 1 and agent_fac like '%209%'  order by view_count desc";
			//xcmglist= (List <Map>)dbHelper.getMapList(sql_xcmg,new Object[]{});		   
			//中联代理商
			//String sql_zoomlion = " select top 9 full_name,is_qijiandian,is_made,usern  from pro_agent_factory where flag = 2 and is_show = 1 and agent_fac like '%134%'  order by view_count desc";
			//zoomlionlist= (List <Map>)dbHelper.getMapList(sql_zoomlion,new Object[]{});		   
			//沃尔沃代理商
			//String sql_volvo = " select top 9 full_name,is_qijiandian,is_made,usern  from pro_agent_factory where flag = 2 and is_show = 1 and agent_fac like '%175%'  order by view_count desc";
      		//volvolist= (List <Map>)dbHelper.getMapList(sql_volvo,new Object[]{});		   
			}
			
			if(!factoryid.equals("")||!catalog.equals("")||!(show_province+show_city).equals("")){
			String catabrand=CommonString.getFormatPara(brandMap.get(factoryid))+CommonString.getFormatPara(catalogMap.get(catalog));
		    title="【电话】"+(show_province+show_city+("".equals(catabrand)?"工程机械":catabrand))+"维修网点_"+(show_province+show_city+("".equals(catabrand)?"工程机械":catabrand))+"维修中心_"+(show_province+show_city+("".equals(catabrand)?"工程机械":catabrand))+"维修 - 铁臂维修";
			keywords=(show_province+show_city+("".equals(catabrand)?"工程机械":catabrand))+"地维修网点,"+(show_province+show_city+("".equals(catabrand)?"工程机械":catabrand))+"维修中心,铁臂维修";
			description="铁臂维修包括"+(show_province+show_city+("".equals(catabrand)?"工程机械":catabrand))+"维修网点，帮您快速解决"+(show_province+show_city+("".equals(catabrand)?"工程机械":catabrand))+"维修问题，买"+(show_province+show_city+("".equals(catabrand)?"工程机械":catabrand))+"就上铁臂商城。";
			}
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="/weixiu/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/friendly_link.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/citys_weixiu.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
<title><%=title%></title>
<meta name="keywords" content="<%=keywords%>" />
<meta name="description" content="<%=description%>" />
</head>
<body>
<jsp:include page="/weixiu/top.jsp" flush="true" />
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="http://weixiu.21-sun.com/">铁臂维修</a>
   <%="".equals(show_province+show_city)?"":" &gt;&gt; <a href='"+("".equals(province)?"0-":province+"-")+("".equals(city)?"0-":city+"-")+"0-0.htm'>"+("".equals(show_province+show_city)?"":show_province+show_city)+"</a>"%>
   <%="".equals(factoryid)?"":" &gt;&gt; <a href='/0-0-"+factoryid+"-0.htm'>"+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +"</a>"%>
   <%="".equals(catalog)?"":" &gt;&gt; <a href='/0-0-0-"+catalog+".htm'>"+("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))) +"</a>"%>
   <%=(!"".equals(catalog)&&!"".equals(factoryid)||!"".equals(show_province+show_city)&&!"".equals(factoryid)||!"".equals(catalog)&&!"".equals(show_province+show_city))?" &gt;&gt; "+show_province+show_city+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))):""%>
   <%=("".equals(catalog)&&"".equals(factoryid)&&"".equals(show_province+show_city))?"":" &gt;&gt; "+show_province+show_city+(  "".equals( ("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid)))+("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))))?"工程机械":("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog)))  )+"维修网点"%></h3>
</div>
<div class="contain980 clearfix">
  <!--left-->
  <div class="nre_left">
      <%if(catalog.equals("")&&factoryid.equals("")){%>
	     <jsp:include page="/include/weixiu/left_pro_list_agent.jsp" flush="true">
	            <jsp:param value="<%=areaName%>" name="areaName"/>
                <jsp:param value="<%=factoryid%>" name="factoryid"/>
         </jsp:include>
		  <jsp:include page="/include/weixiu/left_factory_list_agent.jsp" flush="true" >
	  	        <jsp:param value="<%=catalog%>" name="catalog"/>
				<jsp:param value="<%=areaName%>" name="areaName"/>
         </jsp:include>
	  <%}%>
      <!--产品-->
	  <%if(catalog.equals("")&&!factoryid.equals("")){%>
      <jsp:include page="/include/weixiu/left_pro_list_agent.jsp" flush="true">
	            <jsp:param value="<%=areaName%>" name="areaName"/>
                <jsp:param value="<%=factoryid%>" name="factoryid"/>
      </jsp:include>
	  <%}%>
	  <!--品牌-->
	   <%if(factoryid.equals("")&&!catalog.equals("")){%>
	  <jsp:include page="/include/weixiu/left_factory_list_agent.jsp" flush="true" >
	  	        <jsp:param value="<%=catalog%>" name="catalog"/>
				<jsp:param value="<%=areaName%>" name="areaName"/>
      </jsp:include>
	   <%}%>
	  <!--产品品牌-->
	  <%
	  String cataNum="";
	  if(!catalog.equals("")&&!factoryid.equals("")){
	   if(catalog.length()>3){cataNum=catalog.substring(0,3);}else{cataNum=catalog;}
	  %>
	  	  <jsp:include page="/include/weixiu/left_cata_list_agent.jsp" flush="true" >
	  	        <jsp:param value="<%=cataNum%>" name="cataNum"/>
				<jsp:param value="<%=areaName%>" name="areaName"/>
          </jsp:include>
		  
		  <jsp:include page="/include/weixiu/left_factory_list_agent.jsp" flush="true" >
	  	        <jsp:param value="<%=catalog%>" name="catalog"/>
				<jsp:param value="<%=areaName%>" name="areaName"/>
           </jsp:include>
	  <%}%>
	  <!--区域-->
      <jsp:include page="/include/weixiu/left_area_list_agent.jsp" flush="true">
	  	  	    <jsp:param value="<%=catalog%>" name="catalog"/>
                <jsp:param value="<%=factoryid%>" name="factoryid"/>
	  </jsp:include>
  </div>
  <!--left end-->
  <!--right-->
  <div class="nre_right">
    <!--分类查找-->
    <form name="theform" id="theform">
      <div class="border03 l Condition mb10 nwx_net_sea">
        <div class="ConditionTop">
          <div class="l">
            <%if (!"".equals(catalog) || !"".equals(factoryid)||!"".equals(province)) {%>
            <a href="/0-0-0-0.htm"> <span class="reset">重置</span></a>
            <%}%>
            <%if (!"".equals(catalog) && !"".equals(catalog)) {%>
            <span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%></em> 
			<a href="/<%="".equals(province)?"0":province%>-<%="".equals(city)?"0":city%>-<%="".equals(factoryid)?"0":factoryid%>-0.htm" title="取消" class="delete" ></a> </span>
            <%}%>
            <%if (!"".equals(factoryid) && !"".equals(factoryid)) {%>
            <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em>
			<a href="/<%="".equals(province)?"0":province%>-<%="".equals(city)?"0":city%>-0-<%="".equals(catalog)?"0":catalog%>.htm" title="取消" class="delete"></a> </span>
            <%}%>
			
			<%if (!"".equals(city) && !"".equals(city)) {%>
            <span><em><%=show_city%></em> <a href="/<%="".equals(province)?"0":province%>-0-<%="".equals(factoryid)?"0":factoryid%>-<%="".equals(catalog)?"0":catalog%>.htm" title="取消" class="delete"></a> </span>
            <%}%>
			<%if (!"".equals(province) && !"".equals(province)) {%>
            <span><em><%=show_province%></em> <a href="/0-0-<%="".equals(factoryid)?"0":factoryid%>-<%="".equals(catalog)?"0":catalog%>.htm" title="取消" class="delete"></a> </span>
            <%}%>
			
			
            <%if (!"".equals(tonandmeter) && !"".equals(showtonandmeter)) {%>
            <span><em><%=showtonandmeter%></em> <a href="javascript:void(0)" title="取消" class="delete" onclick='sosuo("<%=catalog%>","<%=factoryid%>","")'></a> </span>
            <%}%>
          </div>
          <h1 class="r" style="font-size:14px;"><%="".equals(catalog+factoryid+show_province+show_city)?"工程机械":""%><%="".equals(show_province)?"":show_province%><%="".equals(show_city)?"":show_city%><%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%>维修网点</h1>
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
          <%if("".equals(province)||("beijing".equals(province))||("xijiang".equals(province))||("xizang".equals(province))||("guangxi".equals(province))||("ningxia".equals(province))||("neimenggu".equals(province))||("shanghai".equals(province))||("tianjin".equals(province))||("chongqing".equals(province)) ){%>
          <li class="cblist">
            <dt> 省份 </dt>
            <dd> 
			  <a <%if("0".equals(province)||"".equals(province)){%> class='select' <%}%> href="/0-0-0-0.htm"  class='select' >不限</a>
              <a <%if("hebei".equals(province)){%> class='select' <%}%>  href="/hebei-0-0-0.htm" >河北</a>
              <a <%if("shanxi".equals(province)){%> class='select' <%}%> href="/shanxi-0-0-0.htm" >山西</a>
              <a <%if("liaoning".equals(province)){%> class='select' <%}%> href="/liaoning-0-0-0.htm" >辽宁</a>
              <a <%if("jilin".equals(province)){%> class='select' <%}%> href="/jilin-0-0-0.htm" >吉林</a>
              <a <%if("heilongjiang".equals(province)){%> class='select' <%}%> href="/heilongjiang-0-0-0.htm" >黑龙江</a>
              <a <%if("jiangsu".equals(province)){%> class='select' <%}%> href="/jiangsu-0-0-0.htm" >江苏</a>
              <a <%if("zhejiang".equals(province)){%> class='select' <%}%> href="/zhejiang-0-0-0.htm" >浙江</a>
              <a <%if("anhui".equals(province)){%> class='select' <%}%> href="/anhui-0-0-0.htm" >安徽</a>
              <a <%if("fujian".equals(province)){%> class='select' <%}%> href="/fujian-0-0-0.htm" >福建</a>
              <a <%if("jiangxi".equals(province)){%> class='select' <%}%> href="/jiangxi-0-0-0.htm" >江西</a>
              <a <%if("shandong".equals(province)){%> class='select' <%}%> href="/shandong-0-0-0.htm" >山东</a>
              <a <%if("henan".equals(province)){%> class='select' <%}%> href="/henan-0-0-0.htm" >河南</a>
              <a <%if("hubei".equals(province)){%> class='select' <%}%> href="/hubei-0-0-0.htm" >湖北</a>
              <a <%if("hunan".equals(province)){%> class='select' <%}%> href="/hunan-0-0-0.htm" >湖南</a>
              <a <%if("guangdong".equals(province)){%> class='select' <%}%> href="/guangdong-0-0-0.htm" >广东</a>
              <a <%if("hainan".equals(province)){%> class='select' <%}%> href="/hainan-0-0-0.htm" >海南</a>
              <a <%if("sichuan".equals(province)){%> class='select' <%}%> href="/sichuan-0-0-0.htm" >四川</a>
              <a <%if("guzhou".equals(province)){%> class='select' <%}%>  href="/guzhou-0-0-0.htm" >贵州</a>
              <a <%if("yunnan".equals(province)){%> class='select' <%}%>  href="/yunnan-0-0-0.htm" >云南</a>
              <a <%if("shanx".equals(province)){%> class='select' <%}%>  href="/shanx-0-0-0.htm" >陕西</a>
              <a <%if("gansu".equals(province)){%> class='select' <%}%>  href="/gansu-0-0-0.htm" >甘肃</a>
              <a <%if("qinghai".equals(province)){%> class='select' <%}%>  href="/qinghai-0-0-0.htm" >青海</a>
              <a <%if("beijing".equals(province)){%> class='select' <%}%>  href="/beijing-0-0-0.htm" >北京</a>
              <a <%if("xinjiang".equals(province)){%> class='select' <%}%>  href="/xinjiang-0-0-0.htm" >新疆</a>
              <a <%if("xizang".equals(province)){%> class='select' <%}%>  href="/xizang-0-0-0.htm" >西藏</a>
              <a <%if("guangxi".equals(province)){%> class='select' <%}%>  href="/guangxi-0-0-0.htm" >广西</a>
              <a <%if("ningxia".equals(province)){%> class='select' <%}%>  href="/ningxia-0-0-0.htm" >宁夏</a>
              <a <%if("neimenggu".equals(province)){%> class='select' <%}%>  href="/neimenggu-0-0-0.htm" >内蒙古</a>
              <a <%if("shanghai".equals(province)){%> class='select' <%}%>  href="/shanghai-0-0-0.htm" >上海</a>
              <a <%if("tianjin".equals(province)){%> class='select' <%}%>  href="/tianjin-0-0-0.htm" >天津</a>
              <a <%if("chongqing".equals(province)){%> class='select' <%}%>  href="/chongqing-0-0-0.htm" >重庆</a>
          </li>
          <%}%>
          <%if("".equals(province)||("beijing".equals(province))||("xijiang".equals(province))||("xizang".equals(province))||("guangxi".equals(province))||("ningxia".equals(province))||("neimenggu".equals(province))||("shanghai".equals(province))||("tianjin".equals(province))||("chongqing".equals(province))){}else{%>
          <li class="cblist" id="city" <%if("".equals(province)||("beijing".equals(province))||("xijiang".equals(province))||("xizang".equals(province))||("guangxi".equals(province))||("ningxia".equals(province))||("neimenggu".equals(province))||("shanghai".equals(province))||("tianjin".equals(province))||("chongqing".equals(province))){%>style="display:none"<%}%>>
            <dt> 城市 </dt>
            <%for(Map provinceInfo : provinceList) {%>
            <dd id="<%=CommonString.getFormatPara(provinceInfo.get("pinyin"))%>" class="city" <%if(province.equals(CommonString.getFormatPara(provinceInfo.get("pinyin"))) ){%> style="display:block;"<%}else{%> style="display:none;"   <%}%>>
            <%
		  List<Map> cityList = dbHelper.getMapList(" select * from hz_py where province='"+CommonString.getFormatPara(provinceInfo.get("hanzi"))+"' order by id desc ",connection) ;
           if(cityList.size()>0){	
   		      	for(Map cityeInfo : cityList) {
		%>
            <a <%if(CommonString.getFormatPara(cityeInfo.get("pinyin")).equals(city)){%> class='select' <%} %> href="/weixiu/<%=CommonString.getFormatPara(provinceInfo.get("pinyin"))%>-<%=CommonString.getFormatPara(cityeInfo.get("pinyin"))%>-<%=factoryid.equals("")?"0":factoryid%>-<%=catalog.equals("")?"0":catalog%>.htm"><%=CommonString.getFormatPara(cityeInfo.get("hanzi"))%></a>
            <%}}else{%>
            <%}%>
            </dd>
            <%}%>
          </li>
          <%}%>
          <li class="cblist">
            <dt> 类别 </dt>
            <input type="hidden" name="factory" id="factory_id" />
            <input type="hidden" name="catalog" id="catalognum" />
            <dd> <a href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-0.htm" <%if("".equals(catalog)){%> class='select' <%} %>>不限</a>
			<a href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101001.htm" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机</a> 
			<a href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101002.htm" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机</a> <a href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-102.htm" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机</a> <a href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101003.htm" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机</a> <a href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-103.htm" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土</a> <a href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-106001.htm" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机</a> <a href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-101005.htm" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机</a> <a href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-105003.htm" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻</a> <a href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-113001.htm" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤</a> <a href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=factoryid.equals("")?"0":factoryid%>-104001.htm" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 660px;">
          <jsp:include page="/include/weixiu/catalog_network.jsp" flush="true">
		  	  <jsp:param value="<%=province%>" name="province"/>
			  <jsp:param value="<%=city%>" name="city"/>
              <jsp:param value="<%=catalog%>" name="catalog"/>
              <jsp:param value="<%=factoryid%>" name="factoy_id"/>
              <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
              <jsp:param value="<%=order%>" name="order"/>
              <jsp:param value="photo" name="flag"/>
          </jsp:include>
              </div>
            </dd>
          </li>
          <li class="cblist">
            <dt> 品牌 </dt>
            <dd>
              <%if (!"".equals(catalog)) {%>
              <a  href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-0-<%=catalog.equals("")?"0":catalog%>.htm" <%if("".equals(factoryid)){%>  class="select" <%} %>>不限</a>
              <% List<Map> recommend_brands = dbHelper.getMapList(" select catalognum,catalogname,factoryid,factoryname from pro_catalog_factory where catalognum ='" + catalog+ "' order by order_no desc",connection);
				if (null != recommend_brands && recommend_brands.size() > 0) {
														int i = 0;
														for (Map oneMap : recommend_brands) {
															i++;
															if (i == 11) {
																break;
															}
										%>
              <!-- 挖掘机 -->
              <a  href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>-<%=catalog.equals("")?"0":catalog%>.htm"
											<%if(CommonString.getFormatPara(oneMap.get("factoryid")).equals(factoryid)){%>
											class="select" <%} %>><%=CommonString.getFormatPara(oneMap.get("factoryname"))%></a>
              <%
											}
													}
												} else {
										%>
              <a <%if("".equals(factoryid)){%> class='select' <%} %> href="/0-0-0-0.htm">不限</a>
              <!-- 挖掘机 -->
              <a <%if("133".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-133-<%=catalog.equals("")?"0":catalog%>.htm">三一</a>
              <!-- 挖掘机 -->
              <a <%if("182".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-182-<%=catalog.equals("")?"0":catalog%>.htm">小松</a>
              <!-- 挖掘机 -->
              <a <%if("192".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-192-<%=catalog.equals("")?"0":catalog%>.htm">斗山</a>
              <!-- 挖掘机 -->
              <a <%if("184".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-184-<%=catalog.equals("")?"0":catalog%>.htm">日立</a>
              <!-- 挖掘机 -->
              <a <%if("183".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-183-<%=catalog.equals("")?"0":catalog%>.htm">神钢</a>
              <!-- 挖掘机 -->
              <a <%if("175".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-175-<%=catalog.equals("")?"0":catalog%>.htm">沃尔沃</a>
              <!-- 挖掘机 -->
              <a <%if("174".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-174-<%=catalog.equals("")?"0":catalog%>.htm">卡特彼勒</a>
              <!-- 挖掘机 -->
              <a <%if("146".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-146-<%=catalog.equals("")?"0":catalog%>.htm">玉柴重工</a>
              <!-- 挖掘机 -->
              <a <%if("136".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-136-<%=catalog.equals("")?"0":catalog%>.htm">柳工</a> <a <%if("134".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-134-<%=catalog.equals("")?"0":catalog%>.htm">中联重科</a> <a <%if("209".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-209-<%=catalog.equals("")?"0":catalog%>.htm">徐工</a> <a <%if("139".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-139-<%=catalog.equals("")?"0":catalog%>.htm">厦工</a> <a <%if("135".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-135-<%=catalog.equals("")?"0":catalog%>.htm">龙工</a> <a <%if("141".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-141-<%=catalog.equals("")?"0":catalog%>.htm">福田雷沃</a> <a <%if("137".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-137-<%=catalog.equals("")?"0":catalog%>.htm">临工</a> <a <%if("144".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-144-<%=catalog.equals("")?"0":catalog%>.htm">山推</a> <a <%if("152".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-152-<%=catalog.equals("")?"0":catalog%>.htm">山重建机</a> <a <%if("189".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-189-<%=catalog.equals("")?"0":catalog%>.htm">加藤</a> <a <%if("455".equals(factoryid)){%> class='select' <%} %> href="/<%=province.equals("")?"0":province%>-<%=city.equals("")?"0":city%>-455-<%=catalog.equals("")?"0":catalog%>.htm">凯斯</a>
              <%}%>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 660px;">
        <jsp:include page="/include/weixiu/brand_network.jsp" flush="true">
		    <jsp:param value="<%=province%>" name="province"/>
			<jsp:param value="<%=city%>" name="city"/>
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
            <jsp:param value="<%=order%>" name="order"/>
            <jsp:param value="photo" name="flag"/>
         </jsp:include>
              </div>
            </dd>
          </li>
          <script type="text/javascript">
	            if('<%=catalog%>'.indexOf("101001")!=-1){
	              jQuery("#grab").attr("style","display:;") ;
	            }
	               if('<%=catalog%>'.indexOf("101002")!=-1){
	              jQuery("#loader").attr("style","display:;") ;
	            }
	               if('<%=catalog%>'.indexOf("102")!=-1){
	              jQuery("#crane").attr("style","display:;") ;
	            }
	          </script>
        </ul>
        <input type="hidden" name="order" id="order" />
        <input type="hidden" name="keyword" id="key_word" />
      </div>
    </form>
    <!--分类查找结束-->
    <!--网点-->
    <%if(factoryid.equals("")&&catalog.equals("")&&(show_province+show_city).equals("")){%>
  <div class="border03 l mb10 nwx_wxwdlist">
      <div class="title">
        <h3>三一维修网点</h3>
      </div>
      <div class="nwx_wxwdval">
        <ul class="np_fix list">  
          <li><a href="http://product.21-sun.com/agent/hfxy/" target="_blank" title="合肥湘元工程机械有限公司">合肥湘元工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/hnzw/" target="_blank" title="湖南中旺集团">湖南中旺集团</a></li>
          <li><a href="http://product.21-sun.com/agent/tyjj/" target="_blank" title="太原建机工程有限公司">太原建机工程有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/gzsl/" target="_blank" title="贵州三龙机电设备有限公司">贵州三龙机电设备有限公司</a></li>
          <li><a href="http://product.21-sun.com/agentstore/ytht/" target="_blank" title="烟台开发区宏通机械有限公司">烟台开发区宏通机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/cqzb/" target="_blank" title="重庆智邦工程机械设备有限公司">重庆智邦工程机械设备有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/slsb/" target="_blank" title="宜昌四力工程矿山设备有限公司">宜昌四力工程矿山设备有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/rdgm/" target="_blank" title="云南睿德工贸有限公司">云南睿德工贸有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/mrt/" target="_blank" title="福建闽瑞通工程机械有限公司">福建闽瑞通工程机械有限公司</a></li>
        </ul>
      </div>
    </div>
    <div class="border03 l mb10 nwx_wxwdlist">
      <div class="title">
        <h3>卡特维修网点</h3>
      </div>
      <div class="nwx_wxwdval">
        <ul class="np_fix list">
          <li><a href="http://product.21-sun.com/agent/lxh/" target="_blank" title="利星行机械有限公司">利星行机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/wst/" target="_blank" title="威斯特中国有限公司">威斯特中国有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/ycmt/" target="_blank" title="易初明通投资有限公司">易初明通投资有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/xcjixie/" target="_blank" title="信昌机器工程有限公司">信昌机器工程有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/zhjx/" target="_blank" title="中华机械股份有限公司">中华机械股份有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/lxxjxyxgs hnwxz/" target="_blank" title="利星行机械有限公司 淮南维修站">利星行机械有限公司 淮南维修站</a></li>
          <li><a href="http://product.21-sun.com/agent/lxxjxyxgs hbwxz/" target="_blank" title="利星行机械有限公司 淮北维修站">利星行机械有限公司 淮北维修站</a></li>
          <li><a href="http://product.21-sun.com/agent/lxxjxyxgs xcfwz/" target="_blank" title="利星行机械有限公司 宣城服务站">利星行机械有限公司 宣城服务站</a></li>
          <li><a href="http://product.21-sun.com/agent/lxxjxyxgs szwxz/" target="_blank" title="利星行机械有限公司 宿州维修站">利星行机械有限公司 宿州维修站</a></li>
        </ul>
      </div>
    </div>
    <div class="border03 l mb10 nwx_wxwdlist">
      <div class="title">
        <h3>徐工维修网点</h3>
      </div>
      <div class="nwx_wxwdval">
        <ul class="np_fix list">
          <li><a href="http://product.21-sun.com/agent/jshr/" target="_blank" title="江苏恒日工程机械有限公司">江苏恒日工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/qdstd/" target="_blank" title="青岛森泰达工程机械有限公司">青岛森泰达工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/lnyuhua/" target="_blank" title="裕华集团">裕华集团</a></li>
          <li><a href="http://product.21-sun.com/agent/tajw/" target="_blank" title="山东凯骋工程机械有限公司">山东凯骋工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/cqzb/" target="_blank" title="重庆智邦工程机械设备有限公司">重庆智邦工程机械设备有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/ychg/" target="_blank" title="盐城韩工机械设备有限公司">盐城韩工机械设备有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/weite/" target="_blank" title="武汉市威特工程机械有限公司">武汉市威特工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/thxk/" target="_blank" title="广州市天汇徐科工程机械有限公司">广州市天汇徐科工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/qdxg/" target="_blank" title="青岛徐工机械销售服务有限公司">青岛徐工机械销售服务有限公司</a></li>
        </ul>
      </div>
    </div>
    <div class="border03 l mb10 nwx_wxwdlist">
      <div class="title">
        <h3>中联维修网点</h3>
      </div>
      <div class="nwx_wxwdval">
        <ul class="np_fix list">
          <li><a href="http://product.21-sun.com/agent/cdwt/" target="_blank" title="四川新沃特工程机械有限公司">四川新沃特工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/cqzb/" target="_blank" title="重庆智邦工程机械设备有限公司">重庆智邦工程机械设备有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/hzguojian/" target="_blank" title="杭州国建工程设备有限公司">杭州国建工程设备有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/scym/" target="_blank" title="四川优曼工程机械有限公司">四川优曼工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/scjflk/" target="_blank" title="四川吉峰联科工程机械有限公司">四川吉峰联科工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/skgt/" target="_blank" title="山东神卡钢特机械有限公司">山东神卡钢特机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/ahky/" target="_blank" title="安徽阔源工程机械有限公司">安徽阔源工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/ynlz/" target="_blank" title="云南龙中联科机械设备有限公司">云南龙中联科机械设备有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/gxlk/" target="_blank" title="广西科联机械有限公司">广西科联机械有限公司</a></li>
        </ul>
      </div>
    </div>
    <div class="border03 l mb10 nwx_wxwdlist">
      <div class="title">
        <h3>沃尔沃维修网点</h3>
      </div>
      <div class="nwx_wxwdval">
        <ul class="np_fix list">
          <li><a href="http://product.21-sun.com/agent/bjrsj/" target="_blank" title="北京融世杰机械设备有限公司">北京融世杰机械设备有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/jnty/" target="_blank" title="济南天业工程机械有限公司">济南天业工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/cdfs/" target="_blank" title="成都福盛工程机械有限公司">成都福盛工程机械有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/whzn/" target="_blank" title="武汉中南工程机械设备有限责任公司">武汉中南工程机械设备有限责任公司</a></li>
          <li><a href="http://product.21-sun.com/agent/henanwtong/" target="_blank" title="河南沃通建筑设备有限公司">河南沃通建筑设备有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/sxwy/" target="_blank" title="山西沃源建筑设备有限公司">山西沃源建筑设备有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/whhl/" target="_blank" title="芜湖华立工程机械有限责任公司">芜湖华立工程机械有限责任公司</a></li>
          <li><a href="http://product.21-sun.com/agent/bjss/" target="_blank" title="北京盛世创业科技有限公司">北京盛世创业科技有限公司</a></li>
          <li><a href="http://product.21-sun.com/agent/cqrh/" target="_blank" title="重庆瑞豪建筑设备技术服务有限公司">重庆瑞豪建筑设备技术服务有限公司</a></li>
        </ul>
      </div>
    </div>

    <%}else{%>
    <ul style="display:none">
      <li> <a class="selected" href="">工程机械代理商</a> </li>
    </ul>
    <ul class="agent_ti" style="width:725px;">
      <li class="g1">代理商</li>
      <li class="g2">代理区域</li>
      <li class="g3" style="width:135px;">主营品牌</li>
      <li class="g5">联系电话</li>
    </ul>
    <div class="agent_li" style="height: auto;width:725px;">
      <%
        if(null !=agents && agents.size()>0){
		int i=0;
		for(Map oneMap:agents){
	  %>
      <ul style="width:725px;"  class="libg0<%=((i%2)+1)%>">
        <%if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://product.21-sun.com/agentstore/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://<%=CommonString.getFormatPara(oneMap.get("usern"))%>.product.21-sun.com" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://product.21-sun.com/agentshop02/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}else{%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://product.21-sun.com/agent/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}%>
        <li class="g2"><span title="<%=CommonString.getFormatPara(oneMap.get("city"))%>"><%=CommonString.getFormatPara(oneMap.get("city"))%></span></li>
        <li class="g3" style="width:135px;"><span title="<%=CommonString.getFormatPara(oneMap.get("agent_fac_name"))%>"><%=CommonString.getFormatPara(oneMap.get("agent_fac_name"))%></span></li>
        <li class="g5" style="overflow:hidden;"><a id="seePhone_<%=CommonString.getFormatPara(oneMap.get("id"))%>" href="javascript:void(0);" onclick="lianXiDianHua('<%=CommonString.getFormatPara(oneMap.get("id"))%>');">点击查看联系电话</a></li>
      </ul>
      <%i++;}}%>
    </div>
    <%}%>
    <!--网点结束-->
    <!--询价单-->
    <jsp:include page="/include/weixiu/order_list.jsp"  flush="true">
    <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
    <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
	<jsp:param name="province" value="<%=show_province%>"></jsp:param>
    <jsp:param name="city" value="<%=show_city%>"></jsp:param>
    </jsp:include>
    <!--询价单结束-->
  </div>
  <!--right end-->
</div>

<style>
.new_v_foot_list{ width:980px; margin:0 auto; text-align:left; margin-bottom:10px;}
.new_v_foot_list .adnf_list ul li{ float:left;  margin:0 6px 0;white-space:nowrap; padding: 6px 0;}
.new_v_foot_list .adnf_list ul li a{  display:inline-block;}
.new_v_foot_list .adnf_list ul li a:hover{ color:#ff6600}
.new_v_foot_list .adnf_title{ font-size:14px; font-weight:bold; border-bottom:1px solid #ccc; padding:7px 0; margin-bottom:5px; font-family:微软雅黑;}
.nleft_one .list003 { height:210px; overflow:auto;}
  </style>

 <!--首页默认显示的热门挖掘机和装载机厂家--> 
<%if(catalog.equals("")&&factoryid.equals("")&&province.equals("")&&city.equals("")){%>  
<style>
.allCatalog .list li {width: 133px;}
</style>
    <div class="allCatalog">
  	<ul class="list" style="border-width: 0 0px 1px 0px;">
<li><a title="徐工挖掘机维修网点" href="/0-0-209-101001.htm">徐工挖掘机维修网点</a></li>
<li><a title="三一挖掘机维修网点" href="/0-0-133-101001.htm">三一挖掘机维修网点</a></li>
<li><a title="小松挖掘机维修网点" href="/0-0-182-101001.htm">小松挖掘机维修网点</a></li>
<li><a title="柳工挖掘机维修网点" href="/0-0-136-101001.htm">柳工挖掘机维修网点</a></li>
<li><a title="中联重科挖掘机维修网点" href="/0-0-134-101001.htm">中联重科挖掘机维修网点</a></li>
<li><a title="斗山挖掘机维修网点" href="/0-0-192-101001.htm">斗山挖掘机维修网点</a></li>
<li><a title="卡特彼勒挖掘机维修网点" href="/0-0-174-101001.htm">卡特彼勒挖掘机维修网点</a></li>
<li><a title="沃尔沃挖掘机维修网点" href="/0-0-175-101001.htm">沃尔沃挖掘机维修网点</a></li>
<li><a title="福田雷沃挖掘机维修网点" href="/0-0-141-101001.htm">福田雷沃挖掘机维修网点</a></li>
<li><a title="日立挖掘机维修网点" href="/0-0-184-101001.htm">日立挖掘机维修网点</a></li>
<li><a title="龙工挖掘机维修网点" href="/0-0-135-101001.htm">龙工挖掘机维修网点</a></li>
<li><a title="厦工挖掘机维修网点" href="/0-0-139-101001.htm">厦工挖掘机维修网点</a></li>
<li><a title="神钢挖掘机维修网点" href="/0-0-183-101001.htm">神钢挖掘机维修网点</a></li>
<li><a title="利勃海尔挖掘机维修网点" href="/0-0-179-101001.htm">利勃海尔挖掘机维修网点</a></li>

    </ul>
  </div>

    <div class="allCatalog" style="padding-top:5px;padding-bottom:5px;">
  	<ul class="list" style="border-width: 0 0px 0px 0px;">
<li><a title="徐工装载机维修网点" href="/0-0-209-101002.htm">徐工装载机维修网点</a></li>
<li><a title="三一装载机维修网点" href="/0-0-133-101002.htm">三一装载机维修网点</a></li>
<li><a title="小松装载机维修网点" href="/0-0-182-101002.htm">小松装载机维修网点</a></li>
<li><a title="柳工装载机维修网点" href="/0-0-136-101002.htm">柳工装载机维修网点</a></li>
<li><a title="中联重科装载机维修网点" href="/0-0-134-101002.htm">中联重科装载机维修网点</a></li>
<li><a title="斗山装载机维修网点" href="/0-0-192-101002.htm">斗山装载机维修网点</a></li>
<li><a title="卡特彼勒装载机维修网点" href="/0-0-174-101002.htm">卡特彼勒装载机维修网点</a></li>
<li><a title="沃尔沃装载机维修网点" href="/0-0-175-101002.htm">沃尔沃装载机维修网点</a></li>
<li><a title="福田雷沃装载机维修网点" href="/0-0-141-101002.htm">福田雷沃装载机维修网点</a></li>
<li><a title="日立装载机维修网点" href="/0-0-184-101002.htm">日立装载机维修网点</a></li>
<li><a title="龙工装载机维修网点" href="/0-0-135-101002.htm">龙工装载机维修网点</a></li>
<li><a title="厦工装载机维修网点" href="/0-0-139-101002.htm">厦工装载机维修网点</a></li>

<li><a title="山东临工装载机维修网点" href="/0-0-137-101002.htm">山东临工装载机维修网点</a></li>
 <li><a title="山推装载机维修网点" href="/0-0-144-101002.htm">山推装载机维修网点</a></li>

    </ul>
  </div>

<%}%>  
  
<%
    String catalogname="";
	String factoryname="";
    if(!catalog.equals("")){
    catalogname=CommonString.getFormatPara(catalogMap.get(catalog));
%>
<!--副导航-->
    <div class="new_v_foot_list">
    <div class="adnf_title">更多品牌<%=catalogname %>维修网点</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/weixiu/related_brand_agent.jsp" flush="true">
     <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
     <jsp:param name="catalogName" value="<%=catalogname%>"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
</div>
  <!--副导航-->
<%}else if(!factoryid.equals("")){
factoryname=CommonString.getFormatPara(brandMap.get(factoryid));
%>
<!--副导航-->
    <div class="new_v_foot_list">
    <div class="adnf_title">更多<%=factoryname %>产品维修网点</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/weixiu/related_pro_agent.jsp" flush="true">
     <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
     <jsp:param name="factoryName" value="<%=factoryname%>"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
</div>
<!--副导航-->
<%}else if(!(province+city).equals("")){%>
<!--副导航-->
    <div class="new_v_foot_list">
    <div class="adnf_title">更多工程机械维修分类</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/weixiu/related_area_agent.jsp" flush="true">
     <jsp:param name="province" value="<%=province%>"></jsp:param>
	 <jsp:param name="city" value="<%=city%>"></jsp:param>
     <jsp:param name="areaName" value="<%=show_province+show_city%>"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
</div>
<!--副导航-->
<%}%>

<jsp:include page="/include/foot.jsp" flush="true"/>
<script type="text/javascript">
    var nowBrand = '<%=factoryid %>';
	var nowCatalog = '<%=catalog %>';
	var nowBrandName = '';
	var nowCatalogName = '';
	var nowProvince = '';
	var nowCity = '';
//下拉
$.fn.sele=function() {
	var ev=($(this).data('sele')?$(this).data('sele').act:'mouseenter').split(" ");
	$(this).bind(ev[0],function(){sele_show(this,ev[0])}).bind('mouseleave',function(){sele_hide(this)});
	function sele_show(me,evt){
		$(me).find('.sele_').stop(1,0).show().children('a').click(function(event){
			event.stopPropagation();
			if(!$(this).attr('target')){
				event.preventDefault();
				if($(me).find('.btn').length){
					$(me).find('.btn').attr('href',$(this).attr('href'))
				};
				$(this).parent().hide().parents('.sele').find('span').text($(this).text());
			}
		})
	};
	function sele_hide(me){
		$(me).find('.sele_').stop(1,0).hide()
	};
};
var $sele=$('.sele');
$sele.each(function(i) {$(this).css('z-index',$sele.length-i).sele()});

	function seePhone(id){
		jQuery.post("/tools/ajax.jsp",{flag:'viewPhoneClickCount',id:id});
		var xunjia_user = jQuery.cookies.get("xunjia_user");
		var xunjia_phone = jQuery.cookies.get("xunjia_phone");
		var xunjia_catalog = jQuery.cookies.get("xunjia_catalog");
		var xunjia_catalog_name = jQuery.cookies.get("xunjia_catalog_name");
		var xunjia_brand = jQuery.cookies.get("xunjia_brand");
		var xunjia_brand_name = jQuery.cookies.get("xunjia_brand_name");
		jQuery.post("/tools/ajax.jsp",{
			flag : 'seePhone',
			name : xunjia_user,
			mobile_phone : xunjia_phone,
			catalog : xunjia_catalog,
			catalogName : xunjia_catalog_name,
			brand : xunjia_brand ,
			brandName : xunjia_brand_name ,
			id : id
		},function(data){
			jQuery("#seePhone_"+id).addClass("gcur");
			jQuery("#seePhone_"+id).html(data);
			jQuery("#seePhone_"+id).attr("tip_title",data);
			jQuery("#seePhone_"+id).removeAttr("onclick");
			jQuery("#seePhone_"+id).yitip();
			var singleTitleTip = jQuery("#seePhone_"+id).yitip("api");
			singleTitleTip.setPosition("rightMiddle");
		});
	}
	function lianXiDianHua(id){
		jQuery.jBox("iframe:/include/agent/show_phone.jsp?id="+id,{
			title : "查看联系电话",
			width : 400,
			height : 290,
			top: '35%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return false;
				}
				return true;
			}
		});
	}
		function zaiXianXunJia(id){
		var url = '/include/agent/enquiry.jsp?id='+id;
		if(nowBrand!=''){
			url += "&nowBrand="+nowBrand;
		}
		if(nowBrandName!=''){
			url += "&nowBrandName="+nowBrandName;
		}
		if(nowCatalog!=''){
			url += "&nowCatalog="+nowCatalog;
		}
		if(nowCatalogName!=''){
			url += "&nowCatalogName="+nowCatalogName;
		}
		jQuery.jBox("iframe:"+url,{
			title : "在线询价",
			width : 550,
			height : 380,
			top: '25%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return false;
				}
				return true;
			}
		});
	}
</script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
</cache:cache>