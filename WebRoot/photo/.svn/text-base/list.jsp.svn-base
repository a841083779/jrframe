<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection,com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	int factory = CommonString.getFormatInt(request.getParameter("factory")) ;// 品牌
	int catalogid = CommonString.getFormatInt(request.getParameter("catalogid")) ;// 栏目
	int factoryid = CommonString.getFormatInt(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	catalog = catalog.replace("-","");
	if(factory !=0 && factory ==0 ){
		factory = factory ;
	}
	if(catalogid != 0){
		catalog = catalogid+"" ;
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
	
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String keywords = CommonString.getFormatPara(request.getParameter("keywords")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap");
	Map brandUsernMap = (HashMap)application.getAttribute("brandUsernMap") ;
	StringBuffer whereStr = new StringBuffer(" and img2 is not null ") ;
	if(factory!=0){
		whereStr.append(" and factory='"+factory+"'") ;
	}
	if(!"".equals(catalog)){
		whereStr.append(" and catalognum like '%"+catalog+"%'") ;
	}
	
	//拆分吨位
	String[] parttonandmeters = null;
	String firsttonandmeter = "";
	String sectonandmeter = "";
	if (!"".equals(tonandmeter) && !"undefined".equals(tonandmeter)) {
		parttonandmeters = tonandmeter.split("_");
		firsttonandmeter = parttonandmeters[1];
		sectonandmeter = parttonandmeters[2];
		if ("0".equals(parttonandmeters[2])) {
			whereStr.append(" and tonandmeter < " + firsttonandmeter);
		} else if ("1".equals(parttonandmeters[2])) {
			whereStr.append(" and tonandmeter >" + firsttonandmeter);
		} else if ("01".equals(parttonandmeters[2])) {
			whereStr.append(" and tonandmeter =" + firsttonandmeter);
		} else {
			whereStr.append(" and tonandmeter between " + firsttonandmeter + " and " + parttonandmeters[2]);
		}
	}
	
	PageBean pageBean = new PageBean() ; // 分页程序
	pageBean.setPageSize(24) ; // 每页显示条数
	pageBean.setOrderBy(" view_count desc ");
	if(!"".equals(keywords)){
		pageBean.setCondition(" and img2 is not null and (name like '%"+keywords+"%' or catalogname like '%"+keywords+"%' or factoryname like '%"+keywords+"%') ") ;
	}else{
		pageBean.setCondition(whereStr.toString()) ;
	}
	Integer nowPage = 1 ;
	if(!"".equals(offset) && !"0".equals(offset)){
	 nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	}
	pageBean.setNowPage(nowPage) ;   
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
    pageBean.setFields(" id,img2,name,file_name,factoryname,catalogname") ;
    pageBean.setTableName("pro_products") ;
	
	try{
		connection = dbHelper.getConnection();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【<%=keywords%><%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>图片】-<%=keywords%><%=factory==0 ?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>价格表 - 中国工程机械商贸网</title>
<meta name="keywords" content="<%=keywords%><%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>图片,<%=keywords%><%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>,最新<%=keywords%><%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>价格表" />
<meta name="description" content="<%=keywords%><%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>：<%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)))%>图片栏目为您提供<%=keywords%><%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))))%>图片，<%=keywords%><%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))))%>价格表，展示各种角度<%=keywords%><%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))))%>图片，<%=keywords%><%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))))%>价格，了解更多<%=keywords%><%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%= catalog.length()>6?CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))):("".equals(catalog)?"":("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))))%>价格信息请来中国工程机械商贸网。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
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
</style>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/sort.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; <a href="/photo/" >产品图库</a><%=factory==0?"":" &gt;&gt; <a href='/photo/list.jsp?factory="+factory+"'>"+(factory==0?"":CommonString.getFormatPara(brandMap.get(factory))) +"</a>"%><%="".equals(catalog)?"":" &gt;&gt; "+(factory==0?"":CommonString.getFormatPara(brandMap.get(factory))) +("".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog)))%></h3>
</div>
<!--面包屑结束--> 
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
        <jsp:param name="factory" value="<%=factory%>"></jsp:param>
      </jsp:include>
      </ul>
    </div>
    <!--同类热卖排行结束--> 
  </div>
  <!--left end-->
  <%--<cache:cache cron="* * */1 * *">--%>
  <%
	   List<Map> main_picList = pageBean.getDatas() ;  // 根据条件查出的产品
  %>
  <!--right-->
  <div class="w757 r">
    <form name="theform" id="theform">
      <div class="w755 border03 l Condition mb10">
        <div class="ConditionTop">
          <div class="l">
            <%
										if (!"".equals(catalog) || factory!=0) {
									%>
            <span class="reset" onclick="sosuo();">重置</span>
            <%
										}
									%>
            <%
										if (!"".equals(catalog) && !"".equals(catalog)) {
									%>
            <span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("","<%=factory%>","","","<%=order%>")'></a> </span>
            <%
										}
									%>
            <%
										if (factory!=0 && factory!=0) {
									%>
            <span><em><%=factory==0 ? "" : CommonString.getFormatPara(brandMap.get(factory))%></em> <a href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("<%=catalog%>","","","","<%=order%>")'></a> </span>
            <%
										}
									%>
            <%
										if (!"".equals(tonandmeter) && !"".equals(showtonandmeter)) {
									%>
            <span><em><%=showtonandmeter%></em> <a
										href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("<%=catalog%>","<%=factory%>","")'></a> </span>
            <%
										}
									%>
          </div>
          <h3 class="r"><%=keyword%><%=showtonandmeter%><%=factory==0 ? "" : CommonString.getFormatPara(brandMap.get(factory))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog)).equals("起重机械")?"起重机":CommonString.getFormatPara(catalogMap.get(catalog))%></h3>
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
            <dd> <a href="/photo/list.jsp<%=factory==0?"":"?factory="+factory%>" <%if("".equals(catalog)){%> class='select' <%} %>>不限</a> 
            <a href="/photo/list.jsp<%=factory==0?"?catalog=101001":"?factory="+factory+"&catalog=101001"%>" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机</a> 
            <a href="/photo/list.jsp<%=factory==0?"?catalog=101002":"?factory="+factory+"&catalog=101002"%>" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机</a> 
            <a href="/photo/list.jsp<%=factory==0?"?catalog=102":"?factory="+factory+"&catalog=102"%>" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机</a> 
            <a href="/photo/list.jsp<%=factory==0?"?catalog=101003":"?factory="+factory+"&catalog=101003"%>" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机</a> 
            <a href="/photo/list.jsp<%=factory==0?"?catalog=103":"?factory="+factory+"&catalog=103"%>" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土</a> 
            <a href="/photo/list.jsp<%=factory==0?"?catalog=106001":"?factory="+factory+"&catalog=106001"%>" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机</a> 
            <a href="/photo/list.jsp<%=factory==0?"?catalog=101005":"?factory="+factory+"&catalog=101005"%>" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机</a> 
            <a href="/photo/list.jsp<%=factory==0?"?catalog=105003":"?factory="+factory+"&catalog=105003"%>" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻</a> 
            <a href="/photo/list.jsp<%=factory==0?"?catalog=113001":"?factory="+factory+"&catalog=113001"%>" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤</a> 
            <a href="/photo/list.jsp<%=factory==0?"?catalog=104001":"?factory="+factory+"&catalog=104001"%>" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机</a>
              <div id="changethis" class="pbtn"></div>
              <div class="plmore" style="padding-left: 0px; width: 680px;">
            <jsp:include page="/include/products/catalog.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factory%>" name="factoy_id"/>
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
              <a <%if(factory==0){%> class='select' <%} %> href="/photo/list.jsp">不限</a> 
              <!-- 挖掘机 --> 
              <a <%if("133".equals(factory)){%> class='select' <%} %> href="/photo/list.jsp?factory=133<%=catalog.equals("")?"":"&catalog="+catalog%>">三一</a> 
              <!-- 挖掘机 --> 
              <a <%if("182".equals(factory)){%>
											class='select' <%} %> href="/photo/list.jsp?factory=182<%=catalog.equals("")?"":"&catalog="+catalog%>">小松</a> 
              <!-- 挖掘机 --> 
              <a <%if("192".equals(factory)){%>
											class='select' <%} %> href="/photo/list.jsp?factory=192<%=catalog.equals("")?"":"&catalog="+catalog%>">斗山</a> 
              <!-- 挖掘机 --> 
              <a <%if("184".equals(factory)){%>
											class='select' <%} %> href="/photo/list.jsp?factory=184<%=catalog.equals("")?"":"&catalog="+catalog%>">日立</a> 
              <!-- 挖掘机 --> 
              <a <%if("183".equals(factory)){%>
											class='select' <%} %> href="/photo/list.jsp?factory=183<%=catalog.equals("")?"":"&catalog="+catalog%>">神钢</a> 
              <!-- 挖掘机 --> 
              <a <%if("175".equals(factory)){%>
											class='select' <%} %> href="/photo/list.jsp?factory=175<%=catalog.equals("")?"":"&catalog="+catalog%>">沃尔沃</a> 
              <!-- 挖掘机 --> 
              <a <%if("174".equals(factory)){%>
											class='select' <%} %> href="/photo/list.jsp?factory=174<%=catalog.equals("")?"":"&catalog="+catalog%>">卡特彼勒</a> 
              <!-- 挖掘机 --> 
              <a <%if("146".equals(factory)){%>
											class='select' <%} %> href="/photo/list.jsp?factory=146<%=catalog.equals("")?"":"&catalog="+catalog%>">玉柴重工</a> 
              <!-- 挖掘机 --> 
              <a <%if("136".equals(factory)){%>
											class='select' <%} %> href="/photo/list.jsp?factory=136<%=catalog.equals("")?"":"&catalog="+catalog%>">柳工</a> 
              <!-- 挖掘机 --> 
              <a <%if("194".equals(factory)){%>
											class='select' <%} %> href="/photo/list.jsp?factory=194<%=catalog.equals("")?"":"&catalog="+catalog%>">现代京城</a>
            
             <div id="changethis" class="pbtn"></div>
             <div class="plmore" style="padding-left: 0px; width: 680px;">
             <jsp:include page="/include/products/brand.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factory%>" name="factoy_id"/>
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
											onclick="sosuo('<%=catalog%>','<%=factory%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','grab_1_13')"
											<%if("grab_1_13".equals(tonandmeter)){%> class="select" <%}%>>小挖(1T～13T)</a>&nbsp; <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','grab_14_30')"
											<%if("grab_14_30".equals(tonandmeter)){%> class="select"
											<%}%>>中挖(14T～30T)</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','grab_30_1')"
											<%if("grab_30_1".equals(tonandmeter)){%> class="select" <%}%>>大挖(30T以上)</a> </dd>
          </li>
          <li class="cblist" style="display: none;" id="loader">
            <dt> 吨位 </dt>
            <dd> <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factory%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','loader_1_3')"
											<%if("loader_1_3".equals(tonandmeter)){%> class="select"
											<%}%>>3T以下</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','loader_3_01')"
											<%if("loader_3_01".equals(tonandmeter)){%> class="select"
											<%}%>>3T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','loader_3_5')"
											<%if("loader_3_5".equals(tonandmeter)){%> class="select"
											<%}%>>3T～5T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','loader_5_1')"
											<%if("loader_5_1".equals(tonandmeter)){%> class="select"
											<%}%>>5T以上</a> </dd>
          </li>
          <li class="cblist" style="display: none;" id="crane">
            <dt> 吨位 </dt>
            <dd> <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factory%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','crane_1_16')"
											<%if("crane_1_16".equals(tonandmeter)){%> class="select"
											<%}%>>16T以下</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','crane_20_70')"
											<%if("crane_20_70".equals(tonandmeter)){%> class="select"
											<%}%>>20T～70T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factory%>','crane_70_1')"
											<%if("crane_70_1".equals(tonandmeter)){%> class="select"
											<%}%>> 70T以上</a> </dd>
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
      </div>
      <input type="hidden" name="order" id="order" />
      <input type="hidden" name="keyword" id="key_word" />
    </form>
    <div class="w755 r border03">
      <div class="title12">
        <h3 style="float:left"><%=keywords%><%=showtonandmeter%><%=factory==0?"":CommonString.getFormatPara(brandMap.get(factory))%><%="".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))%>图片</h3>
      </div>
      <style type="text/css">
	  .list12 li { height:148px; position:relative; background:url(../images/pbg_new.gif) no-repeat;}
	  .list12 li span.blink { display:block; width:158px; height:20px; line-height:20px; position:absolute; left:0px; bottom:4px; padding-left:5px; color:#B7B7B7}
	  </style>
      <ul class="list12">
        <%
        if(null !=main_picList && main_picList.size()>0){
        	for(Map oneMap:main_picList){
        		%>
        <li>
          <div class="photo"><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>" width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_middle.jpg',2);" /></a></div>
          <h3><a href="detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname"))%>"><%=CommonString.getFormatPara(oneMap.get("factoryname"))%><%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname"))%></a></h3>
          <span class="blink"> 【<a target="_blank" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>">参数</a>】【<a target="_blank" href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).substring(0,CommonString.getFormatPara(oneMap.get("file_name")).indexOf("."))%>_message.shtm">评论</a>】【<a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')"><font color="#ff6000">询价</font></a>】 </span> </li>
        <%
        	}
        }else{
        %>
        <span class="textStyle">暂无信息</span>
        <%
		}
		%>
      </ul>
    </div>
    <div class="w755 l">
      <div id="pagination" class="page">
        <tags:page pageBean="<%=pageBean %>"/>
      </div>
    </div>
  </div>
  <%--</cache:cache>--%>
  <!--right end-->
  <div class="clear"></div>
</div>
<!--main end--> 
<!--最新订单-->
<div class="contain980 mb10">
  <div class="title04">
    <h2><%=factory==0 ? "" : CommonString.getFormatPara(brandMap.get(factory))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>最新订单 </h2>
    <span><a
						href="/inquiry/?<%=factory==0 ? "" : "factory=" + factory + "&"%><%="".equals(catalog) ? "" : "catalog=" + catalog%>"
						target="_blank">更多&gt;&gt;</a> </span> </div>
  <div class="list04">
    <div id="MarqueeDiv"
						style="width: 978px; height: auto; overflow: hidden;">
      <ul>
        <jsp:include page="/include/products/order_sub_foot.jsp"
								flush="true">
        <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
        <jsp:param name="factory" value="<%=factory%>"></jsp:param>
        </jsp:include>
      </ul>
    </div>
  </div>
  <div class="clear"></div>
</div>
<!--最新订单结束--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true"/>
<!--end of foot--> 
<!--图片轮换--> 
<script src="/scripts/jquery.tools.min.js" type="text/javascript"></script> 
<script type="text/javascript">
	//左侧
	jQuery.ajax({
		url:"/include/left.jsp",
		type:"post",
		data:{"flag":"product","factory":"<%=factory%>","catalog":"<%=catalog%>","url":"/photo/list.jsp"},
		success:function(data){
			jQuery("#leftId").html(jQuery.trim(data));	
		}
	})

	jQuery(document).ready(function() {
		jQuery("#chained").scrollable({circular: true, mousewheel: false}).navigator().autoscroll({
			interval: 8000
		});
	});
	function sosuopic(catalog,factory){
		jQuery("#catalogid").attr("value",catalog) ;
     	jQuery("#factory_id").val(jQuery.trim(factory)) ;
     	if(""==jQuery.trim(catalog)){
     	   jQuery("#catalogid").removeAttr("name") ;
     	   jQuery("#catalogid").remove() ;
     	}
     	if(""==jQuery.trim(factory)){
     		jQuery("#factory_id").removeAttr("name") ;
     	    jQuery("#factory_id").remove() ;
     	}
     	if(""==jQuery.trim(factory) && ""==jQuery.trim(catalog)){
     	    jQuery("#theform").attr("method","post") ;
     	}
		jQuery("#theform").attr("action","list.jsp") ;
    	jQuery("#theform").submit() ;
	}
	
</script> 
<!--图片轮换-->
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>