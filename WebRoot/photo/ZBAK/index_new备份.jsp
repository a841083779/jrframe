<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection,com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;// 品牌
	String catalogid = CommonString.getFormatPara(request.getParameter("catalogid")) ;// 栏目
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap");
	
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
<link href="../style/friendly_link.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; 产品图库</h3>
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
  <%--<cache:cache cron="* */6 * * *">--%>
  <%
  	List<Map> products_pic = dbHelper.getMapList(" select top 24 id,img2,add_date,factoryname,catalogname,name from pro_products where img2 is not null and img2 != '' order by id desc ") ;
  %>
  <!--right-->
  <style type="text/css">
  .mb20 { margin-bottom:20px;}
  .photoParts { width:755px; float:left; border:1px solid #DEE3E7;}
  .photoParts .content { width:100%; float:left; overflow:hidden;}
  ul.pbList { width:960px; float:left; padding:8px 0px;}
  ul.pbList li { width:125px; height:78px; float:left; border-right:#e3ecf1 1px solid;}
  ul.pbList li a { display:block; width:100px; height:78px; text-align:center; margin:0 auto; cursor:default;}
  ul.pbList li a img { display:block; width:100px; height:50px;}
  .modelList { width:100%; float:left;}
  .modelList .mll { width:100%; float:left;}
  .modelList .mll .mt { width:715px; height:24px; line-height:24px; float:left; padding:10px 20px 0px;}
  .modelList .mll .mt h3 { width:auto; float:left;}
  .modelList .mll .mt span.more { width:auto; float:right; font-family:宋体;}
  </style>
  <div class="w757 r">
    <div class="wfull l photoTop">
      <h3>产品图片</h3>
      <div class="photoSelect">
        <form id="theform" name="theform">
          <div align="right" class="selectContain">
            <div id="faker-factoryid" class="faker" style="display: inline-block; position: relative; vertical-align: top; width: 120px; height: 17px; float: none;">
              <select style="width: 120px; position: absolute; left: -2000px;" name="factoryid" id="factoryid">
                <option value="" selected="selected">选择品牌</option>
                <option value="0" custom="0" disabled="true" caption="true">热门</option>
                <option value="133" custom="133">三一</option>
                <option value="209" custom="209">徐工</option>
                <option value="136" custom="136">柳工</option>
                <option value="182" custom="182">小松</option>
                <option value="192" custom="192">斗山</option>
                <option value="134" custom="134">中联重科</option>
                <option value="135" custom="135">龙工</option>
                <option value="139" custom="139">厦工</option>
                <option value="175" custom="175">沃尔沃</option>
                <option value="144" custom="144">山推</option>
                <option value="137" custom="137">临工</option>
                <option value="141" custom="141">福田雷沃</option>
                <option value="A" custom="A" disabled="true" caption="true">A</option>
                <option value="180" custom="180">阿特拉斯</option>
                <option value="402" custom="402">艾迪</option>
                <option value="482" custom="482">阿特拉斯·科普柯</option>
                <option value="772" custom="772">艾思博</option>
                <option value="1169" custom="1169">安丘通用</option>
                <option value="1185" custom="1185">阿尔多机械</option>
                <option value="1710" custom="1710">安迈</option>
                <option value="1778" custom="1778">奥盛特重工</option>
                <option value="B" custom="B" disabled="true" caption="true">B</option>
                <option value="167" custom="167">北方交通</option>
                <option value="186" custom="186">北起多田野</option>
                <option value="420" custom="420">贝力特</option>
                <option value="478" custom="478">邦立重机</option>
                <option value="484" custom="484">八达</option>
                <option value="791" custom="791">八达重工</option>
                <option value="825" custom="825">搏浪沙</option>
                <option value="1093" custom="1093">北车重工</option>
                <option value="1108" custom="1108">百财</option>
                <option value="1168" custom="1168">百脉建机</option>
                <option value="1206" custom="1206">博汇机械</option>
                <option value="1234" custom="1234">博亚</option>
                <option value="1703" custom="1703">甘肃宝龙</option>
                <option value="1714" custom="1714">北山机械</option>
                <option value="1715" custom="1715">宝骊</option>
                <option value="13093" custom="13093">重庆博山</option>
                <option value="13231" custom="13231">天地奔牛</option>
              </select>
              <div class="fakerWrap" style="position: relative; width: 100%; -moz-user-select: none;">
                <div id="faker-factoryid-head" class="fakerHead">
                  <div>选择品牌</div>
                </div>
              </div>
            </div>
            <div id="faker-catalogid" class="faker" style="display: inline-block; position: relative; vertical-align: top; width: 160px; height: 17px; float: none;">
              <select style="width: 160px; position: absolute; left: -2000px;" disabled="" name="catalogid" id="catalogid">
                <option value="" selected="selected"> 选择机型&#12288;&#12288; </option>
              </select>
              <div class="fakerWrap disabled" style="position: relative; width: 100%; -moz-user-select: none;">
                <div id="faker-catalogid-head" class="fakerHead">
                  <div> 选择机型&#12288;&#12288; </div>
                </div>
              </div>
            </div>
          </div>
        </form>
        <a onclick="submitYN();" class="photbtn" href="javascript:void(0)">查看图片</a> </div>
    </div>
    
    <div class="photoParts mb20">
      <div class="hbTitle">
        <h2>热门品牌</h2>
      </div>
      <div class="content">
        <ul class="pbList">
          <li><a href="#" title="江苏华通动力"><img src="../images/photo_brandimg01.gif" alt="江苏华通动力" width="100" height="50" />江苏华通动力</a></li>
          <li><a href="#" title="江苏华通动力"><img src="../images/photo_brandimg01.gif" alt="江苏华通动力" width="100" height="50" />江苏华通动力</a></li>
          <li><a href="#" title="江苏华通动力"><img src="../images/photo_brandimg01.gif" alt="江苏华通动力" width="100" height="50" />江苏华通动力</a></li>
          <li><a href="#" title="江苏华通动力"><img src="../images/photo_brandimg01.gif" alt="江苏华通动力" width="100" height="50" />江苏华通动力</a></li>
          <li><a href="#" title="江苏华通动力"><img src="../images/photo_brandimg01.gif" alt="江苏华通动力" width="100" height="50" />江苏华通动力</a></li>
          <li><a href="#" title="江苏华通动力"><img src="../images/photo_brandimg01.gif" alt="江苏华通动力" width="100" height="50" />江苏华通动力</a></li>
        </ul>
      </div>
    </div>
    
    <div class="photoParts">
      <div class="hbTitle">
        <h2>热门机型</h2>
      </div>
      <div class="content">
        <ul class="modelList">
          <li class="mll">
            <div class="mt">
              <h3>挖掘机</h3>
              <span class="more"><a href="#">更多&gt;&gt;</a></span>
            </div>
            <ul class="list12">
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
            </ul>
            
            <div class="mt">
              <h3>挖掘机</h3>
              <span class="more"><a href="#">更多&gt;&gt;</a></span>
            </div>
            <ul class="list12">
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
            </ul>
            
            <div class="mt">
              <h3>挖掘机</h3>
              <span class="more"><a href="#">更多&gt;&gt;</a></span>
            </div>
            <ul class="list12">
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
            </ul>
            
            <div class="mt">
              <h3>挖掘机</h3>
              <span class="more"><a href="#">更多&gt;&gt;</a></span>
            </div>
            <ul class="list12">
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
            </ul>
            
            <div class="mt">
              <h3>挖掘机</h3>
              <span class="more"><a href="#">更多&gt;&gt;</a></span>
            </div>
            <ul class="list12">
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
              <li>
                <div class="photo"><a target="_blank" href="detail_for_16062.htm"><img width="135" height="100" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" title="诺克机械NKB190破碎锤" alt="诺克机械NKB190破碎锤" src="/uploadfiles//image/2013/04/20130403105055_325.jpg"></a></div>
                <h3><a target="_blank" href="detail_for_16062.htm">诺克机械NKB190破碎锤</a></h3>
              </li>
            </ul>
            
          </li>
        </ul>
      </div>
    </div>  
    
  </div>
  <!--right end-->
  <%--</cache:cache>--%>
  <div class="clear"></div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/index/friendlink.htm" flush="false"/>
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--end of foot--> 
<!--图片轮换--> 
<script src="/scripts/jquery.tools.min.js" type="text/javascript"></script> 
<script>
	//左侧
	jQuery.ajax({
		url:"/include/left.jsp",
		type:"post",
		data:{"flag":"product","factoryid":"","catalog":"","url":"/photo/list.jsp"},
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
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>