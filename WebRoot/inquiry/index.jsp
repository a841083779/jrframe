<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="java.sql.Connection,com.jerehnet.webservice.*,com.jerehnet.util.dbutil.*"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
  // 查询条件
  DBHelper dbHelper = DBHelper.getInstance();
  Connection connection = null;
  try{
  	connection = dbHelper.getConnection();
  String factoryid = CommonString.getFilterStr(request.getParameter("factoryid")) ;
  String factory = CommonString.getFilterStr(request.getParameter("factory")) ;
  String proId= CommonString.getFilterStr(request.getParameter("proId")) ;
  String proName= CommonString.getFilterStr(request.getParameter("proName")) ;
  factoryid = factoryid.replace("-", "").trim();
  if(factoryid.equals("")&&!factory.equals("")){
  	factoryid = factory;
  }
  String catalog = CommonString.getFilterStr(request.getParameter("catalog")) ;
  String province = CommonString.getFilterStr(request.getParameter("province")) ;
  String city = CommonString.getFilterStr(request.getParameter("city")) ;
  catalog = catalog.replace("-", "").trim();
  String area = CommonString.getFormatPara(request.getParameter("area")) ;
  String offset = CommonString.getFormatPara(request.getParameter("offset")) ;  // 偏移量
  String ul_tag = CommonString.getFormatPara(request.getParameter("ul_tag")) ;
  String order = CommonString.getFormatPara(request.getParameter("order"));
  Map brandMap = (HashMap)application.getAttribute("brandMap") ;
  Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
  Map brandUsernMap = (HashMap)application.getAttribute("brandUsernMap") ;
  Map hzpyMap=(HashMap)application.getAttribute("hzpyMap") ;
  Map pyhzMap=(HashMap)application.getAttribute("pyhzMap") ;
  if("0".equals(catalog)){catalog="";}
  if("0".equals(factoryid)){factoryid="";}
  if("0".equals(province)){province="";}
  if("0".equals(city)){city="";}
  if(null == brandUsernMap){
	  brandUsernMap = new HashMap() ;
  }
  //搜索条件
  StringBuffer whereStr = new StringBuffer(" and is_garbage!=1  and product_name!='' ") ;
  if(!"".equals(proId)){
	  whereStr.append(" and product_id="+proId) ;
	  	List<Map> proInfo = dbHelper.getMapList(" select catalognum,factoryid,name  from pro_products where id="+proId,connection) ;
				for(Map proMap : proInfo) {
			     	catalog=CommonString.getFormatPara(proMap.get("catalognum"));
					factoryid=CommonString.getFormatPara(proMap.get("factoryid"));
					proName=CommonString.getFormatPara(proMap.get("name"));
				}
  }
  if(!"".equals(factoryid)&&!"0".equals(factoryid)){
	  whereStr.append(" and factoryid="+factoryid) ;
  }
  if(!"".equals(catalog)&&!"0".equals(catalog)){
	  whereStr.append(" and catanum like '%"+catalog+"%'") ;
  }
  if(!"".equals(area)){
	  whereStr.append(" and contact_address like '%"+area+"%'") ;
  }
  String place="";
  if(!"".equals(province)&&!"0".equals(province)){
      place=(String)hzpyMap.get(province);
	  whereStr.append(" and province like '%"+place+"%'") ;
  }
  String address="";
    if(!"".equals(city)&&!"0".equals(city)){
      address=((String)hzpyMap.get(city)).replace("市","");
	  whereStr.append(" and city like '%"+address+"%'") ;
  }
  whereStr.append(" and product_name is not null and product_name != '' ");
  if("749".equals(factoryid)){
	  whereStr.append(" and (province like '河南%' or province like '甘肃%' )") ;
  }
  //查询询价单
  String tablename = "pro_product_form" ; 
  List<Map> pro_orders = new ArrayList() ;
  PageBean pageBean = new PageBean() ;
  pageBean.setPageSize(15) ;
  Integer nowPage = 1 ;
  if(!"".equals(offset) && !"0".equals(offset)){
	   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
  }
  pageBean.setNowPage(nowPage) ;
  pageBean.setOrderBy(" add_date desc ") ;
  pageBean.setTableName(tablename) ;
  pageBean.setCondition(whereStr.toString()) ;
  pageBean.setFields("id,factoryname,factoryid,cataname,name,mobile_phone,contact_tel,contact_address,product_name,add_date,province,city") ;
  String url = CommonString.getFormatPara(request.getQueryString()) ;
	if(!"".equals(url)){
		if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
			url="" ;
		}else if(url.indexOf("offset")!=-1 ){
			url = "&"+url.substring(url.indexOf("&")+1) ;
		}else{
			url = "&"+url ;
		}
	}
  pageBean.setParams(url) ;
       //查询省市
		List<Map> provinceList = dbHelper.getMapList(" select * from hz_py where province='0' order by id asc ",connection) ;
		//根据产品查询品牌
		List<Map> brandList=null;
		if(!"".equals(catalog)){
		brandList= dbHelper.getMapList("SELECT top 10 * FROM (select id,name from pro_agent_factory where pro_agent_factory.flag=1  )AS b INNER  JOIN  (SELECT factoryid FROM pro_products WHERE catalognum  like '%"+catalog+"%' AND factoryid!=0 GROUP BY factoryid) AS p  ON b.id =p.factoryid  order by id asc",connection) ;
		}
		//TDK部分
		String seo_1=place+address+ ("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid)))+proName+("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)));
		if(seo_1.equals("")){
		   seo_1="工程机械";
		}
		String seo_2=place+address+ ("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid)));
		String seo_3=place+address+("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)));
		String seo_4=("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid)))+("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)));
		String seo_5="";
		if(!seo_2.equals("")||!seo_3.equals("")||!seo_4.equals(""))
		{
		  if(!seo_2.equals("")&&!seo_2.equals(seo_4)){
		      seo_5+=seo_2+"价格表,";
		  }
		  if(!seo_3.equals("")&&!seo_3.equals(seo_2)){
		      seo_5+=seo_3+"价格表,";
		  }
		  if(!seo_4.equals("")&&!seo_3.equals(seo_4)){
		      seo_5+=seo_4+"价格表,";
		  }
		  seo_5+=seo_1+"最新询价单";
		   
		}
		else{
		   seo_5="工程机械价格表,工程机械价格,工程机械,询价单";
		}
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【成交价格】<%=seo_1%>价格表_<%=seo_1%>最新询价单 - 铁臂商城</title>
<meta name="keywords" content="<%=seo_5%>" />
<meta name="description" content="咨询【<%=seo_1%>成交价格】请上铁臂商城,铁臂商城提供最新的<%=seo_1%>价格,帮助您了解<%=seo_1%>价格的最新动态。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script>
 function showCity(obj){
     //$("#city").show();
	 //$("#"+obj).show().siblings('dd').hide();
 }
 function showCata(obj){
    // $("#cataDetail").show();
	// $("#"+obj).show().siblings('dd').hide();
 }
 $(document).ready(function() {
    //$('#city').mouseleave(function(){
		//$(this).hide();
	//})
});
 $(document).ready(function() {
   // $('#cataDetail').mouseleave(function(){
	//	$(this).hide();
	//})
});
 function hideCata(){
  $("#cataDetail").hide();
 }
</script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">
        <a href="/">铁臂商城</a> &gt;&gt; <%="".equals(url)?"采购询价":"<a href='/inquiry/'>采购询价</a>" %>
        <%="".equals(place+address)?"":" &gt;&gt; <a href='/inquiry/"+(province.equals("")?"0":province)+"_"+(city.equals("")?"0":city)+"_0_0_0.shtm'>"+place+address+"</a>"%> 
		<%="".equals(catalog)?"".equals(factoryid)?"":" &gt;&gt; "+ CommonString.getFormatPara(brandMap.get(factoryid)): "".equals(factoryid)?"":" &gt;&gt; <a href='/inquiry/0_0_"+(factoryid.equals("")?"0":factoryid)+"_0_0.shtm'>"+CommonString.getFormatPara(brandMap.get(factoryid))+"</a>"%> 
        <a href="/inquiry/0_0_0_<%=catalog.equals("")?"0":catalog%>_0.shtm"><%="".equals(catalog)?"":" &gt;&gt; "+CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog))%></a>
        <a href="/inquiry/<%=(province.equals("")?"0":province)%>_<%=(city.equals("")?"0":city)%>_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>_0.shtm">
				<%if((!(place+address).equals(""))||!factoryid.equals("")){%>
		<%="".equals(catalog)?"":" &gt;&gt; "+((place+address).equals("")?"":(place+address))+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid))) +CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog))%>
		<%}%>
		</a> 
        <%="".equals(catalog)?"":" &gt;&gt; "+((place+address).equals("")?"":(place+address))+("".equals(factoryid)?"":CommonString.getFormatPara(brandMap.get(factoryid)))+ proName+CommonString.getFormatPara(catalogMap.get(catalog.length()>=6?catalog.substring(0,6):catalog))+"价格"%> </h3>
</div>
<!--面包屑结束-->
<!--main-->
<div class="contain980 mb10">
<!--left-->
	<jsp:include page="/include/agent/left_inquiry.jsp" flush="true"></jsp:include>
<!--left end-->
<!--right-->
<div class="w757 r">
  <div class="w755 border03 l Condition mb10">
    <div class="ConditionTop">
      <div class="l">
        <%if (!"".equals(catalog) || !"".equals(factoryid)) {%>
        <span class="reset" ><a href="/inquiry/">重置</a></span>
        <%}%>

        <%if (!"".equals(catalog) && !"".equals(catalog)) {%>
        <span><em>
		<%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_0_0.shtm" title="取消" class="delete" ></a> </span>
        <%}%>
        <%if (!"".equals(factoryid) && !"".equals(factoryid)) {%>
        <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_0_<%=catalog.equals("")?"0":catalog%>_0.shtm" title="取消" class="delete" ></a> </span>
        <%}%>
			    <%if (!"".equals(place) && !"".equals(place)) {%>
        <span><em><%=place%></em> <a href="/inquiry/0_0_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>_0.shtm" title="取消" class="delete" ></a> </span>
        <%}%>
      </div>
      <h1 class="r" style="font-size:14px;"><strong><%=place%><%=address%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(proName) ? "" : proName%><%="".equals(catalog) ? "工程机械" : CommonString.getFormatPara(catalogMap.get(catalog))%>价格</strong></h1>
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
        <dd> <a href="/inquiry/0_0_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>_0.shtm" <%if("0".equals(province)||"".equals(province)){%> class='select' <%} %>>不限</a>
       		<%for(Map provinceInfo : provinceList) {%>
			<a onmouseover="showCity('<%=CommonString.getFormatPara(provinceInfo.get("pinyin"))%>')"   href="/inquiry/<%=CommonString.getFormatPara(provinceInfo.get("pinyin"))%>_0_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>_0.shtm" <%if(CommonString.getFormatPara(provinceInfo.get("pinyin")).equals(province)){%> class='select' <%} %>><%=CommonString.getFormatPara(provinceInfo.get("hanzi"))%></a> 
            <%}%>
      </li>
	  <%}%>
      <li class="cblist" id="city" <%if("".equals(province)||("beijing".equals(province))||("xijiang".equals(province))||("xizang".equals(province))||("guangxi".equals(province))||("ningxia".equals(province))||("neimenggu".equals(province))||("shanghai".equals(province))||("tianjin".equals(province))||("chongqing".equals(province))){%>style="display:none"<%}%>>
        <dt> 城市 </dt>
		<%for(Map provinceInfo : provinceList) {%>
        <dd id="<%=CommonString.getFormatPara(provinceInfo.get("pinyin"))%>" class="city" <%if(province.equals(CommonString.getFormatPara(provinceInfo.get("pinyin"))) ){%> style="display:block;"<%}else{%> style="display:none;"   <%}%>>
		<%
		  List<Map> cityList = dbHelper.getMapList(" select * from hz_py where province='"+CommonString.getFormatPara(provinceInfo.get("hanzi"))+"' order by id desc ",connection) ;
           if(cityList.size()>0){	
   		      	for(Map cityeInfo : cityList) {
		%>
		<a href="/inquiry/<%=CommonString.getFormatPara(provinceInfo.get("pinyin"))%>_<%=CommonString.getFormatPara(cityeInfo.get("pinyin"))%>_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>_0.shtm "><%=CommonString.getFormatPara(cityeInfo.get("hanzi"))%></a> 
		<%}}else{%>
		    
		<%}%>
		</dd>
        <%}%>	
      </li>
	  
      <li class="cblist">
        <dt> 类别 </dt>
        <dd>
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_0_0.shtm" <%if("0".equals(catalog)||"".equals(catalog)){%> class='select' <%} %>>不限</a> 
		<a onmouseover="showCata('101001')" href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001_0.shtm" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机</a> 
		<a onmouseover="showCata('101002')" href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002_0.shtm" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机</a>
		<a onmouseover="showCata('102')" href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_102_0.shtm" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机</a> 
		<a onmouseover="showCata('101003')" href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101003_0.shtm" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机</a> 
		<a onmouseover="showCata('103')" href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103_0.shtm" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土</a> 
		<a onmouseover="showCata('106001')" href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001_0.shtm" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机</a>
		<a onmouseover="hideCata()" href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101005_0.shtm" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机</a>
		<a onmouseover="hideCata()" href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_105003_0.shtm" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻</a>
		<a onmouseover="hideCata()" href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_113001_0.shtm" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤</a> 
		<a onmouseover="showCata('104001')" href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001_0.shtm" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机</a>
          <div id="changethis" class="pbtn"></div>
          <div class="plmore" style="padding-left: 0px; width: 680px;;">
            <jsp:include page="/include/products/catalog_inquiry.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=order%>" name="order"/>
			<jsp:param value="<%=province%>" name="province"/>
			<jsp:param value="<%=city%>" name="city"/>
            </jsp:include>
          </div>
        </dd>
      </li>
	  
      <li class="cblist" id="cataDetail" style="display:none">
        <dt> </dt>
        <dd id="101001"> <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001001_0.shtm" >履带式挖掘机</a> 
		                 <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001004_0.shtm" >轮式挖掘机</a> 
						 <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001006_0.shtm" >正铲挖掘机</a>
						 <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001008_0.shtm" >反铲挖掘机</a> 
						 <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101001007_0.shtm" >其它挖掘机</a> </dd>
        <dd id="101002"> <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002007_0.shtm">轮式装载机</a>
                  		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002009_0.shtm">滑移装载机</a> 
						<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002008_0.shtm">挖掘装载机</a> 
						 <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002003_0.shtm">履带式装载机</a>
						 <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002010_0.shtm">叉装机</a> 
						 <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101002004_0.shtm">其它装载机</a> </dd>
        <dd id="102"> <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_102002_0.shtm">塔式起重机</a>
             		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_102007_0.shtm">汽车起重机</a> 
					<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_102008_0.shtm">履带式起重机</a>
					<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_102006_0.shtm"> 随车起重机</a> </dd>
        <dd id="101003"> <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101003001_0.shtm"> 履带推土机</a>
		                 <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_101003004_0.shtm"> 轮式推土机</a> </dd>
        <dd id="103"> <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103001_0.shtm">泵车</a> 
		              <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103017_0.shtm">车载泵</a> 
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103018_0.shtm">拖泵</a> 
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103020_0.shtm">输送泵</a> 
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103002_0.shtm">混凝土搅拌设备</a> 
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103005_0.shtm">混凝土布料设备</a>
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103019_0.shtm">混凝土搅拌运输车</a> 
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103008_0.shtm">干粉砂浆生产设备</a> 
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103009_0.shtm">粉粒物料运输车</a> 
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103015_0.shtm">其它混凝土设备</a> 
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103012_0.shtm">干混砂浆生产线</a> 
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103011_0.shtm">沥青砂浆车</a> 
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103014_0.shtm">干混砂浆背罐车</a> 
					  <a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_103010_0.shtm">喷湿机</a>
		</dd>

		 
        <dd id="106001">
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001001_0.shtm">单钢轮压路机</a> 
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001002_0.shtm">双钢轮压路机</a> 
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001009_0.shtm">振动压路机</a>
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001005_0.shtm">轮胎压路机</a> 
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001003_0.shtm">三轮压路机</a>
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001004_0.shtm">光轮压路机</a>
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001006_0.shtm">冲击式压路机</a> 
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_106001008_0.shtm">静碾压路机</a> </dd>
        <dd id="104001">
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001002_0.shtm">履带式摊铺机</a> 
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001001_0.shtm">轮式摊铺机</a>
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001005_0.shtm">滑模摊铺机</a>
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001004_0.shtm">熨平板</a>
		<a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=factoryid.equals("")?"0":factoryid%>_104001006_0.shtm">混凝土摊铺机</a> </dd>        
      </li>
	  
	  
	  
	  <%if(catalog.equals("")){%>
      <li class="cblist">
        <dt> 品牌 </dt>
        <dd>
 
          <a <%if("".equals(factoryid)){%> class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_0_<%=catalog.equals("")?"0":catalog%>_0.shtm">不限</a>
       
	          
          <a <%if("174".equals(factoryid)){%>  class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_174_<%=catalog.equals("")?"0":catalog%>_0.shtm">卡特彼勒</a>
											
          <a <%if("133".equals(factoryid)){%> class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_133_<%=catalog.equals("")?"0":catalog%>_0.shtm">三一</a>
     
          <a <%if("182".equals(factoryid)){%>
											class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_182_<%=catalog.equals("")?"0":catalog%>_0.shtm">小松</a>
   
          <a <%if("192".equals(factoryid)){%>
											class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_192_<%=catalog.equals("")?"0":catalog%>_0.shtm">斗山</a>

          <a <%if("184".equals(factoryid)){%>
											class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_184_<%=catalog.equals("")?"0":catalog%>_0.shtm">日立</a>
 
          <a <%if("183".equals(factoryid)){%>
											class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_183_<%=catalog.equals("")?"0":catalog%>_0.shtm">神钢</a>

          <a <%if("175".equals(factoryid)){%>
											class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_175_<%=catalog.equals("")?"0":catalog%>_0.shtm">沃尔沃</a>       
          <a <%if("146".equals(factoryid)){%>
											class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_146_<%=catalog.equals("")?"0":catalog%>_0.shtm">玉柴重工</a>
        
          <a <%if("136".equals(factoryid)){%>
											class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_136_<%=catalog.equals("")?"0":catalog%>_0.shtm">柳工</a>
         
          <a <%if("194".equals(factoryid)){%>
											class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_194_<%=catalog.equals("")?"0":catalog%>_0.shtm">现代京城</a>
		  <a <%if("1220".equals(factoryid)){%>
											class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_1220_<%=catalog.equals("")?"0":catalog%>_0.shtm">华通动力</a>

          <div id="changethis" class="pbtn"></div>
          <div class="plmore" style="padding-left: 0px; width: 680px;">
            <jsp:include page="/include/products/brand_inquiry.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=order%>" name="order"/>
			<jsp:param value="<%=province%>" name="province"/>
			<jsp:param value="<%=city%>" name="city"/>
            </jsp:include>
          </div>
        </dd>
      </li>
	  <%}else{%>
	   <li class="cblist">
        <dt> 品牌 </dt>
        <dd>
 
          <a <%if("".equals(factoryid)){%> class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_0_<%=catalog.equals("")?"0":catalog%>_0.shtm">不限</a>
	      <%    
		        if(brandList.size()>0&&brandList!=null){	
   		      	for(Map brandInfo : brandList) {
		  %>
		  <a <%if(CommonString.getFormatPara(brandInfo.get("id")).equals(factoryid)){%> class='select' <%} %> href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=CommonString.getFormatPara(brandInfo.get("id"))%>_<%=catalog.equals("")?"0":catalog%>_0.shtm"><%=CommonString.getFormatPara(brandInfo.get("name"))%></a>
            <%}}%>
          <div id="changethis" class="pbtn"></div>
          <div class="plmore" style="padding-left: 0px; width: 680px;">
            <jsp:include page="/include/products/brand_inquiry.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=order%>" name="order"/>
			<jsp:param value="<%=province%>" name="province"/>
			<jsp:param value="<%=city%>" name="city"/>
            </jsp:include>
          </div>
        </dd>
      </li>
	  <%}%>
	  
	  
      <!-- 广告投放 -->
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
  </div>
  <cache:cache cron="*/1 * * * *">
    <%
	  pro_orders = pageBean.getDatas() ;
	%>
    <!--<div style="padding-bottom:6px;"><a href="http://ad.21-sun.com/link_to.jsp?paras=12,17,2779&url=http://product.21-sun.com/case/ " target="_blank"><img src="/ads/ad01.jpg" width="757" height="78" /></a></div>-->
    <!--询价列表-->
    <div class="w755 border03 l mb10 list08">
      <div class="title08 listTop">
        <h2 style="font-size:14px;color:#075cac"><b><%=(place+address)%><%= CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog)?"工程机械":CommonString.getFormatPara(catalogMap.get(catalog))%>询价单总数：<%=pageBean.getTotal() %></b> </h2>
        <div class="r"> <%=pageBean.getUpPageBar() %> </div>
      </div>
      <ul class="ti">
        <li class="i1">编号</li>
        <li class="i2" style="width:182px;">询价产品</li>
        <li class="i3">联系人</li>
        <li class="i4">电话</li>
        <li class="i5">询价品牌</li>
        <li class="i6">询价区域</li>
        <li class="i7">询价时间</li>
      </ul>
      <div class="li" id="showorders">
        <%
		String cDate = CommonDate.getToday("yyyy-MM-dd HH:mm");
         if(pro_orders.size()>0){
        	Iterator iter = pro_orders.iterator() ;
        	Map oneMap = new HashMap() ;
        	int i = 1 ;
        	String showtel = "" ; 
        	while(iter.hasNext())
        	{
        		oneMap = (HashMap)iter.next() ;
        		showtel = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("contact_tel")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
        		
        		if(showtel.length()>7&&showtel.length()<=20){
        			showtel = showtel.substring(0,2)+"***"+showtel.substring(showtel.length()-2) ;
        		}else if(showtel.length()>3){
        			showtel = showtel.substring(0,4)+"***" ;
        		}else
        		{
        			showtel = showtel+"***" ;
        		}
				String addDate = (CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date"));
				if(cDate.compareTo(addDate) < 0){
					addDate = cDate;	
				}
        		%>
        <ul class="libg01">
          <li class="i1"><%=i %></li>
          <%if("".equals(province)&&"".equals(city)){%>
          <li class="i2" style="text-align:left;width:178px;"><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
          <%}else{%>
          <li class="i2" style="text-align:left;width:178px;"><a href="/inquiry/area_for_<%=CommonString.getFormatPara(oneMap.get("id"))%>_<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
          <%}%>
          <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
          <li class="i4"><%=showtel %></li>
          <li class="i5"><a href="/inquiry/<%=province.equals("")?"0":province%>_<%=city.equals("")?"0":city%>_<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>_<%=catalog.equals("")?"0":catalog%>_0.shtm
"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
          <li class="i6"><a href="/inquiry/<%if((String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("province")))==null){%>0<%}else{%><%=(String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("province"))) %><%}%>_0_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>_0.shtm"><%="".equals(CommonString.getFormatPara(oneMap.get("province")))?"-":CommonString.getFormatPara(oneMap.get("province"))  %></a>
		  <a href="/inquiry/<%if((String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("province")))==null){%>0<%}else{%><%=(String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("province"))) %><%}%>_<%if(((String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("city"))))==null){%>0<%}else{%><%=((String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("city")))) %><%}%>_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>_0.shtm"><%="".equals(CommonString.getFormatPara(oneMap.get("city")))?"-":CommonString.getFormatPara(oneMap.get("city"))  %></a></li>
		  <li class="i7"><%=addDate %></li>
        </ul>
        <%
        		i++;
        	}
         }else{
        	 out.println("<li class='i2' style='width:100%;text-align:center;'>暂无订单!</li>") ;
         }
        %>
      </div>
      <!--翻页-->
      <div class="w755 l">
        <div id="pagination" class="page">
		  <%
		     if("".equals(catalog)){catalog="0";}
            if("".equals(factoryid)){factoryid="0";}
            if("".equals(province)){province="0";}
            if("".equals(city)){city="0";}
		  %>
          <tags:page_new pageBean="<%=pageBean %>"   province="<%=province %>" city="<%=city %>"  factoryid="<%=factoryid%>"  catalog="<%=catalog%>" />
        </div>
      </div>
      <!--翻页-->
    </div>
    <!--询价列表结束-->
  </cache:cache>
</div>
<!--right end-->
<div class="clear"></div>
<!--main end-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--end of foot-->
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript">
	//左侧
	//jQuery.ajax({
		//url:"/include/left.jsp",
		//type:"post",
		//data:{"flag":"product","factoryid":"<%=factoryid%>","catalog":"<%=catalog%>","url":"/inquiry/"},
		//success:function(data){
			//jQuery("#leftId").html(jQuery.trim(data));	
		//}
	//})
	jQuery("#iqCate ul:gt(0) li").bind("click",function(){
		jQuery("#iqCate ul:gt(0) li").removeClass("ilcur") ;
		jQuery(this).addClass("ilcur") ;
		if(""!=jQuery.trim(jQuery(this).text())){
			jQuery("#area").val(jQuery.trim(jQuery(this).text())) ;
		}
		if(""==jQuery("#area").val()){
			jQuery("#area").removeAttr("name") ;
		}
		if(""==jQuery("#factoryid").val()){
			jQuery("#factoryid").removeAttr("name") ;
		}
		if(""==jQuery.trim(jQuery("#catalog").val()) || null == jQuery("#catalog").val()){
			jQuery("#catalog").removeAttr("name") ;
		}
		 jQuery("#ul_tag").val(jQuery(this).parent().parent().attr("id")) ;
    	 jQuery("#theform").submit() ;
  }) ;
	jQuery("#showorders ul").hover(function(){
	 jQuery(this).toggleClass("libg02") ; 
	}) ;
 //jQuery('html, body').animate({scrollTop: 211}, 0);

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