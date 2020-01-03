<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection,com.jerehnet.util.dbutil.*"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;// 品牌
	String catalogid = CommonString.getFormatPara(request.getParameter("catalogid")) ;// 栏目
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap");
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	ArrayList<Map> allSubCataList = new ArrayList<Map>();
	for(Map subCata : catalogList){
		if(CommonString.getFormatPara(subCata.get("num")).length() == 6){
			allSubCataList.add(subCata);
		}
	}
	
	DBHelper dbHelper = DBHelper.getInstance();
	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
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
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【工程机械图片】挖掘机|装载机|推土机图片大全 - 中国工程机械图片网</title>
<meta name="keywords" content="工程机械图片,挖掘机图片,装载机图片,推土机图片" />
<meta name="description" content="中国工程机械图片网为您提供挖掘机图片,装载机图片,推土机图片等工程机械图片。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/friendly_link.css" rel="stylesheet" type="text/css" />
<style>
  .info a{
   color:#075aad;
  }
  a:link, a:visited {
	color:#666666;
}
a:hover {
	color:#ff6600;
}
.STYLE1 {
	color: #FFFFFF
}
.pllist {
	width:85%;
	float:left;
	min-height:50px;
	overflow:visible;
	position:relative;
	padding-top:23px;
	border-bottom:#ccc 1px dotted;
	margin-right:1%;
	padding-left:8px;
}
.pllist a.plfl {
	position:absolute;
	left:8px;
	top:0px;
	margin:5px;
	font-size:14px;
	font-family:Verdana;
	font-weight:bold;
	color:#3355AC;
	cursor:default;
	float:none;
	padding:0px;
	width:auto;
	text-decoration:none;
}
.pllist a {
	display:inline-block;
	margin:0px 5px;
	font-size:12px;
	line-height:20px;
	height:20px;
	overflow:hidden;
	float:none;
	padding:0px;
	width:auto;
	text-decoration:none;
}

.allCatalog { width:980px; margin:20px auto; clear:both; }
.allCatalog .mt { width: 968px; height: 33px; line-height: 34px; padding-left: 10px; background: url(../images/mtbg.gif) top repeat-x; border: #dfe3e6 1px solid; }
.allCatalog .mt h3 { width: auto; font-size: 14px; color: #396fb5; }
.allCatalog .list { width:978px; border: #dfe3e6 1px solid; border-width:0 1px 1px 1px; }
.allCatalog .list li { width:163px; height:25px; line-height:25px; float:left; text-indent: 19px; text-overflow: ellipsis; white-space: nowrap; overflow: hidden; }
.allCatalog .list li a:hover { color:#ff6600; }
</style>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a href="http://photo.21-sun.com/">中国工程机械图片网</a></h3>
</div>
<!--面包屑结束--> 
<!--广告-->
<div class="contain980 mb10"><script language="javascript" type="text/javascript">
writeflashhtml("_swf=/images/hy.swf", "_width=980", "_height=60" ,"_wmode=opaque");
</script></div>
<!--广告结束--> 
<!--main-->
<div class="contain980 mb10"> 
  <!--left-->
  <div class="w210 l"> 
    <!--热门品牌-->
    <div id="leftId"> </div>
    <!--热门品牌结束--> 
    <!--同类热卖排行-->
    <div class="w208 border02 l leftPart02 mb10">
      <h2><%=keyword%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>最新关注 </h2>
      <ul class="list03">
        <jsp:include page="/include/photo/pro_left.jsp" flush="true">
        <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
        <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
        </jsp:include>
      </ul>
    </div>
    <!--同类热卖排行结束--> 
  </div>
  <!--left end-->

  <!--right-->
  <div class="w757 r">
    <form name="theform" id="theform" action="/list.jsp">
      <div class="w755 border03 l Condition mb10">
        <div class="ConditionTop">
          <div class="l">
            <%
										if (!"".equals(catalog) || !"".equals(factoryid)) {
									%>
            <span class="reset" onclick="sosuo();">重置</span>
            <%
										}
									%>
            <%
										if (!"".equals(catalog) && !"".equals(catalog)) {
									%>
            <span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("","<%=factoryid%>","","","<%=order%>")'></a> </span>
            <%
										}
									%>
            <%
										if (!"".equals(factoryid) && !"".equals(factoryid)) {
									%>
            <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("<%=catalog%>","","","","<%=order%>")'></a> </span>
            <%
										}
									%>
            <%
										if (!"".equals(tonandmeter) && !"".equals(showtonandmeter)) {
									%>
            <span><em><%=showtonandmeter%></em> <a
										href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("<%=catalog%>","<%=factoryid%>","")'></a> </span>
            <%
										}
									%>
          </div>
          <h3 class="r">筛选条件<%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></h3>
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
            <dt> 类别 </dt>
            <input type="hidden" name="factory" id="factory_id" />
            <input type="hidden" name="catalog" id="catalognum" />
            <dd> <a href="/list.jsp<%=factoryid.equals("")?"":"?factory="+factoryid%>" <%if("".equals(catalog)){%> class='select' <%} %>>不限</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=101001":"?factory="+factoryid+"&catalog=101001"%>" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=101002":"?factory="+factoryid+"&catalog=101002"%>" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=102":"?factory="+factoryid+"&catalog=102"%>" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=101003":"?factory="+factoryid+"&catalog=101003"%>" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=103":"?factory="+factoryid+"&catalog=103"%>" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=106001":"?factory="+factoryid+"&catalog=106001"%>" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=101005":"?factory="+factoryid+"&catalog=101005"%>" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=105003":"?factory="+factoryid+"&catalog=105003"%>" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=113001":"?factory="+factoryid+"&catalog=113001"%>" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤</a> 
            <a href="/list.jsp<%=factoryid.equals("")?"?catalog=104001":"?factory="+factoryid+"&catalog=104001"%>" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 680px;;">
            <jsp:include page="/include/products/catalog.jsp" flush="true">
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
              <%
											if (!"".equals(catalog)) {
										%>
              <a onclick="sosuo('<%=catalog%>','','<%=tonandmeter%>');"
											href="javascript:void(0)" <%if("".equals(factoryid)){%>
											class="select" <%} %>>不限</a>
              <%
											List<Map> recommend_brands = dbHelper
															.getMapList(" select catalognum,catalogname,factoryid,factoryname from pro_catalog_factory where catalognum ='" + catalog
																	+ "' order by order_no desc",connection);
													if (null != recommend_brands && recommend_brands.size() > 0) {
														int i = 0;
														for (Map oneMap : recommend_brands) {
															i++;
															if (i == 11) {
																break;
															}
										%>
              <!-- 挖掘机 --> 
              <a
											onclick="sosuo('<%=catalog%>','<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>','<%=tonandmeter%>')"
											href="javascript:;"
											<%if(CommonString.getFormatPara(oneMap.get("factoryid")).equals(factoryid)){%>
											class="select" <%} %>><%=CommonString.getFormatPara(oneMap.get("factoryname"))%></a>
              <%
											}
													}
												} else {
										%>
              <a <%if("".equals(factoryid)){%> class='select' <%} %> href="/list.jsp">不限</a> 
              <!-- 挖掘机 --> 
              <a <%if("133".equals(factoryid)){%> class='select' <%} %> href="/list.jsp?factory=133<%=catalog.equals("")?"":"&catalog="+catalog%>">三一</a> 
              <!-- 挖掘机 --> 
              <a <%if("182".equals(factoryid)){%>
											class='select' <%} %> href="/list.jsp?factory=182<%=catalog.equals("")?"":"&catalog="+catalog%>">小松</a> 
              <!-- 挖掘机 --> 
              <a <%if("192".equals(factoryid)){%>
											class='select' <%} %> href="/list.jsp?factory=192<%=catalog.equals("")?"":"&catalog="+catalog%>">斗山</a> 
              <!-- 挖掘机 --> 
              <a <%if("184".equals(factoryid)){%>
											class='select' <%} %> href="/list.jsp?factory=184<%=catalog.equals("")?"":"&catalog="+catalog%>">日立</a> 
              <!-- 挖掘机 --> 
              <a <%if("183".equals(factoryid)){%>
											class='select' <%} %> href="/list.jsp?factory=183<%=catalog.equals("")?"":"&catalog="+catalog%>">神钢</a> 
              <!-- 挖掘机 --> 
              <a <%if("175".equals(factoryid)){%>
											class='select' <%} %> href="/list.jsp?factory=175<%=catalog.equals("")?"":"&catalog="+catalog%>">沃尔沃</a> 
              <!-- 挖掘机 --> 
              <a <%if("174".equals(factoryid)){%>
											class='select' <%} %> href="/list.jsp?factory=174<%=catalog.equals("")?"":"&catalog="+catalog%>">卡特彼勒</a> 
              <!-- 挖掘机 --> 
              <a <%if("146".equals(factoryid)){%>
											class='select' <%} %> href="/list.jsp?factory=146<%=catalog.equals("")?"":"&catalog="+catalog%>">玉柴重工</a> 
              <!-- 挖掘机 --> 
              <a <%if("136".equals(factoryid)){%>
											class='select' <%} %> href="/list.jsp?factory=136<%=catalog.equals("")?"":"&catalog="+catalog%>">柳工</a> 
              <!-- 挖掘机 --> 
              <a <%if("194".equals(factoryid)){%>
											class='select' <%} %> href="/list.jsp?factory=194<%=catalog.equals("")?"":"&catalog="+catalog%>">现代京城</a>
              <%
											}
										%>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 680px;">
             <jsp:include page="/include/products/brand.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
            <jsp:param value="<%=order%>" name="order"/>
            <jsp:param value="photo" name="flag"/>
            </jsp:include>
              </div>
            </dd>
          </li>
          <li class="cblist" id="grab" style="display: none;">
            <dt> 吨位 </dt>
            <dd>
              <input type="hidden" name="tonandmeter" id="tonandmeter" />
              <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_1_13')"
											<%if("grab_1_13".equals(tonandmeter)){%> class="select" <%}%>>小挖(1T～13T)</a>&nbsp; <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_14_30')"
											<%if("grab_14_30".equals(tonandmeter)){%> class="select"
											<%}%>>中挖(14T～30T)</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_30_1')"
											<%if("grab_30_1".equals(tonandmeter)){%> class="select" <%}%>>大挖(30T以上)</a> </dd>
          </li>
          <li class="cblist" style="display: none;" id="loader">
            <dt> 吨位 </dt>
            <dd> <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_1_3')"
											<%if("loader_1_3".equals(tonandmeter)){%> class="select"
											<%}%>>3T以下</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_3_01')"
											<%if("loader_3_01".equals(tonandmeter)){%> class="select"
											<%}%>>3T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_3_5')"
											<%if("loader_3_5".equals(tonandmeter)){%> class="select"
											<%}%>>3T～5T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_5_1')"
											<%if("loader_5_1".equals(tonandmeter)){%> class="select"
											<%}%>>5T以上</a> </dd>
          </li>
          <li class="cblist" style="display: none;" id="crane">
            <dt> 吨位 </dt>
            <dd> <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_1_16')"
											<%if("crane_1_16".equals(tonandmeter)){%> class="select"
											<%}%>>16T以下</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_20_70')"
											<%if("crane_20_70".equals(tonandmeter)){%> class="select"
											<%}%>>20T～70T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_70_1')"
											<%if("crane_70_1".equals(tonandmeter)){%> class="select"
											<%}%>> 70T以上</a> </dd>
          </li>
        </ul>
      </div>
      <input type="hidden" name="order" id="order" />
      <input type="hidden" name="keyword" id="key_word" />
    </form>
    <style type="text/css">
	.mb20 { margin-bottom:20px;}
	.photoParts { width:755px; float:left; border:1px solid #DEE3E7;}
	.photoParts .content { width:100%; float:left; overflow:hidden;}
	ul.pbList { width:960px; float:left; padding:8px 0px;}
	ul.pbList li { width:125px; height:78px; float:left; border-right:#e3ecf1 1px solid;}
	ul.pbList li a { display:block; width:100px; height:78px; text-align:center; margin:0 auto; cursor:default;}
	ul.pbList li a img { display:block; width:100px; height:50px;}
	.modelList { width:100%; float:left;}
	.modelList .mll { width:100%; float:left; border-bottom:#dfe3e6 1px solid;}
	.modelList .mll .mt { width:735px; height:34px; line-height:34px; float:left; padding:0px 10px 0px; background:url(../images/mtbg.gif) top repeat-x; border-bottom:#dfe3e6 1px solid;}
	.modelList .mll .mt h3 { width:auto; float:left; font-size:14px; color:#396fb5;}
	.modelList .mll .mt span.more { width:auto; float:right; font-family:宋体;}
	.list12 { padding-top:5px;}
	.list12 li { position:relative; height:148px; background:url(../images/pbg_new.gif) no-repeat;}
	.list12 li span.blink { display:block; width:158px; height:20px; line-height:20px; position:absolute; left:0px; bottom:4px; padding-left:5px; color:#B7B7B7}
	.hbTitle span.more { width:auto; float:right; font:100 12px/28px 宋体; padding-right:10px;}
	</style>
    <div class="photoParts mb20">
      <div class="hbTitle">
        <h2>热门品牌</h2>
        <span class="more"><a target="_blank" href="http://product.21-sun.com/brand/">更多&gt;&gt;</a></span>
      </div>
      <div class="content">
        <ul class="pbList">
          <li><a href="/list.jsp?factory=133" title="三一" style="cursor:pointer"><img src="../images/sany.jpg" alt="三一" width="100" height="50" />三一</a></li>
          <li><a href="/list.jsp?factory=209" title="徐工" style="cursor:pointer"><img src="../images/xcmg.jpg" alt="徐工" width="100" height="50" />徐工</a></li>
          <li><a href="/list.jsp?factory=134" title="中联" style="cursor:pointer"><img src="../images/photo_brandimg04.gif" alt="中联" width="100" height="50" />中联</a></li>
          <li><a href="/list.jsp?factory=136" title="柳工" style="cursor:pointer"><img src="../images/photo_brand_lg.gif" alt="柳工" width="100" height="50" />柳工</a></li>
          <li><a href="/list.jsp?factory=144" title="山推" style="cursor:pointer"><img src="../images/photo_brand_st.gif" alt="山推" width="100" height="50" />山推</a></li>
          <li><a href="/list.jsp?factory=137" title="临工" style="cursor:pointer"><img src="../images/photo_brand_lingong.gif" alt="临工" width="100" height="50" />临工</a></li>
        </ul>
      </div>
    </div>
    <div class="photoParts">
      <div class="hbTitle">
        <h2>热门机型</h2>
      </div>
      <div class="content">
        <cache:cache cron="* * */1 * *">
        <ul class="modelList">
          <li class="mll">
          <%
			List<Map> list1 = dbHelper.getMapList(" select top 4 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where catalognum like '101001%' and img2 is not null and img2 != '' order by view_count desc ",connection) ;
		%>
            <div class="mt">
              <h3>挖掘机</h3>
              <span class="more"><a target="_blank" href="/list.jsp?catalog=101001">更多&gt;&gt;</a></span> </div>
            <ul class="list12">
              <%
				Map m = null;
				for(int i = 0;list1 != null && i < list1.size();i++){
					m = list1.get(i);
			%>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>"></a></div>
                <h3><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%></a></h3>
                <span class="blink"> 【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>参数">参数</a>】【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).substring(0,CommonString.getFormatPara(m.get("file_name")).indexOf("."))%>_message.shtm" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>口碑">口碑</a>】【<a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(m.get("id"))%>','')"><font color="#ff6000">询价</font></a>】 </span> </li>
              <%
			  		m = null;
				}
				list1 = null;
			%>
            </ul>
          </li>
          <li class="mll">
          <%
			list1 = dbHelper.getMapList(" select top 4 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where catalognum like '101002%' and img2 is not null and img2 != '' order by view_count desc ",connection) ;
		%>
            <div class="mt">
              <h3>装载机</h3>
              <span class="more"><a target="_blank" href="/list.jsp?catalog=101002">更多&gt;&gt;</a></span> </div>
            <ul class="list12">
              <%
				for(int i = 0;list1 != null && i < list1.size();i++){
					m = list1.get(i);
			%>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>"></a></div>
                <h3><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%></a></h3>
                <span class="blink"> 【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>参数">参数</a>】【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).substring(0,CommonString.getFormatPara(m.get("file_name")).indexOf("."))%>_message.shtm" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>口碑">口碑</a>】【<a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(m.get("id"))%>','')"><font color="#ff6000">询价</font></a>】 </span> </li>
              <%
			  		m = null;
				}
				list1 = null;
			%>
            </ul>
          </li>
          <li class="mll">
          <%
			list1 = dbHelper.getMapList(" select top 4 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where catalognum like '102%' and img2 is not null and img2 != '' order by view_count desc ",connection) ;
		%>
            <div class="mt">
              <h3>起重机</h3>
              <span class="more"><a target="_blank" href="/list.jsp?catalog=102">更多&gt;&gt;</a></span> </div>
            <ul class="list12">
              <%
				for(int i = 0;list1 != null && i < list1.size();i++){
					m = list1.get(i);
			%>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>"></a></div>
                <h3><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%></a></h3>
                <span class="blink"> 【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>参数">参数</a>】【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).substring(0,CommonString.getFormatPara(m.get("file_name")).indexOf("."))%>_message.shtm" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>口碑">口碑</a>】【<a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(m.get("id"))%>','')"><font color="#ff6000">询价</font></a>】 </span> </li>
              <%
			  		m = null;
				}
				list1 = null;
			%>
            </ul>
          </li>
          <li class="mll">
          <%
			list1 = dbHelper.getMapList(" select top 4 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where catalognum like '101003%' and img2 is not null and img2 != '' order by view_count desc ",connection) ;
		%>
            <div class="mt">
              <h3>推土机</h3>
              <span class="more"><a target="_blank" href="/list.jsp?catalog=101003">更多&gt;&gt;</a></span> </div>
            <ul class="list12">
              <%
				for(int i = 0;list1 != null && i < list1.size();i++){
					m = list1.get(i);
			%>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>"></a></div>
                <h3><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%></a></h3>
                <span class="blink"> 【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>参数">参数</a>】【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).substring(0,CommonString.getFormatPara(m.get("file_name")).indexOf("."))%>_message.shtm" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>口碑">口碑</a>】【<a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(m.get("id"))%>','')"><font color="#ff6000">询价</font></a>】 </span> </li>
              <%
			  		m = null;
				}
				list1 = null;
			%>
            </ul>
          </li>
          <li class="mll">
          <%
			list1 = dbHelper.getMapList(" select top 4 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where catalognum like '103%' and img2 is not null and img2 != '' order by view_count desc ",connection) ;
		%>
            <div class="mt">
              <h3>混凝土</h3>
              <span class="more"><a target="_blank" href="/list.jsp?catalog=103">更多&gt;&gt;</a></span> </div>
            <ul class="list12">
              <%
				for(int i = 0;list1 != null && i < list1.size();i++){
					m = list1.get(i);
			%>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>"></a></div>
                <h3><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%></a></h3>
                <span class="blink"> 【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>参数">参数</a>】【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).substring(0,CommonString.getFormatPara(m.get("file_name")).indexOf("."))%>_message.shtm" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>口碑">口碑</a>】【<a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(m.get("id"))%>','')"><font color="#ff6000">询价</font></a>】 </span> </li>
              <%
			  		m = null;
				}
				list1 = null;
			%>
            </ul>
          </li>
          <li class="mll">
          <%
			list1 = dbHelper.getMapList(" select top 4 id,img2,add_date,factoryname,catalogname,name,file_name from pro_products where catalognum like '106001%' and img2 is not null and img2 != '' order by view_count desc ",connection) ;
		%>
            <div class="mt">
              <h3>压路机</h3>
              <span class="more"><a target="_blank" href="/list.jsp?catalog=106001">更多&gt;&gt;</a></span> </div>
            <ul class="list12">
              <%
				for(int i = 0;list1 != null && i < list1.size();i++){
					m = list1.get(i);
			%>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(m.get("img2")) %>"></a></div>
                <h3><a target="_blank" href="detail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%></a></h3>
                <span class="blink"> 【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>参数">参数</a>】【<a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(m.get("file_name")).substring(0,CommonString.getFormatPara(m.get("file_name")).indexOf("."))%>_message.shtm" target="_blank" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("name"))%><%=CommonString.getFormatPara(m.get("catalogname"))%>口碑">口碑</a>】【<a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(m.get("id"))%>','')"><font color="#ff6000">询价</font></a>】 </span> </li>
              <%
			  		m = null;
				}
				list1 = null;
			%>
            </ul>
          </li>
        </ul>
        </cache:cache>
      </div>
    </div>
  </div>
  <!--right end-->
  <div class="clear"></div>
  <div class="allCatalog">
  	<div class="mt">
  		<h3>产品图库</h3>
  	</div>
  	<ul class="list">
  	<%
    	if(allSubCataList.size() > 0){
    		for(int i=0; i<allSubCataList.size(); i++){
    %>
        <li><a title="<%=CommonString.getFormatPara(allSubCataList.get(i).get("name")) %>图片" href="/list.jsp?catalog=<%=CommonString.getFormatPara(allSubCataList.get(i).get("num")) %>"><%=CommonString.getFormatPara(allSubCataList.get(i).get("name")) %>图片</a></li>
    <%
    		}
    	}
    %>
  	<div class="clear"></div>
  	</ul>
  </div>
</div>
<!--main end--> 
<!--link-->
<!--#include virtual="/include/index/friendlink_photo.htm"-->
<!--end of link-->
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--end of foot--> 
<!--图片轮换--> 
<script src="/scripts/jquery.tools.min.js" type="text/javascript"></script> 
<script>
	//左侧
	jQuery.ajax({
		url:"/include/left.jsp",
		type:"post",
		data:{"flag":"product","factoryid":"","catalog":"","url":"/list.jsp"},
		success:function(data){
			jQuery("#leftId").html(jQuery.trim(data));	
		}
	})

	jQuery(document).ready(function() {
		jQuery("#chained").scrollable({circular: true, mousewheel: false}).navigator().autoscroll({
		interval: 8000
		});
	});
	function sosuo(catalog,factoryid,tonandmeter,id,order,keyword){
		jQuery("#catalognum").val(catalog) ;
		jQuery("#factory_id").val(factoryid) ;
		jQuery("#tonandmeter").val(tonandmeter) ;
		jQuery("#key_word").val(keyword);
		jQuery("#order").val(order) ;
		if(''==jQuery.trim(catalog)){
			jQuery("#catalognum").remove() ;
		}
		if(''==jQuery.trim(factoryid)){
		jQuery("#factory_id").remove() ;
		}
		if(''==jQuery.trim(tonandmeter)) {
		jQuery("#tonandmeter").remove() ;
		}
		if(''==jQuery.trim(order)){
		jQuery("#order").remove() ;
		}
		if(''==keyword||undefined ==keyword){
		jQuery("#key_word").removeAttr("name") ;
		}
		//jQuery("#theform").attr("action","") ;
		jQuery("#theform").attr("method","get") ;
		jQuery("#theform").submit() ;
	}
</script> 
<!--图片轮换--> 
<script type="text/javascript" src="/scripts/sort.js"></script>
<div style="display:none"><script src="http://s17.cnzz.com/stat.php?id=5752121&web_id=5752121" language="JavaScript"></script></div>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>