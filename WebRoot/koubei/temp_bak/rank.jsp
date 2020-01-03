<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.Common"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="java.sql.Connection"%><%@page import="com.jerehnet.util.common.CommonApplication"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");
	String catalog="";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>工程机械产品口碑排行榜_工程机械口碑排名 – 铁臂口碑</title>
<meta name="keywords" content="工程机械产品口碑排行榜,口碑最好的工程机械产品" />
<meta name="description" content="铁臂口碑工程机械产品口碑排行榜为您提供工程机械产品口碑排行信息，真实工程机械产品用户用机体验与口碑评价,让您选择工程机械产品更新省心,放心。买工程机械产品就上铁臂商城。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/koubei/style/koubei.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript">
//导航选中状态
var jrChannel='3#0'
</script>
</head>
<body>
<!--top-->
<jsp:include page="include/top.jsp" flush="true" />
<!--top end-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a title="铁臂口碑" href="/">铁臂口碑</a> &gt;&gt; 工程机械口碑排行榜</h3>
</div>
<div class="contain980 fix mb10 np_fix">
  <!--left-->
  <div class="w210 l">
    <div id="leftId">
      <div class="leftTab">
        <ul>
          <li class="ltcur"><a style="width:210px;" >产品类别</a></li>
        </ul>
      </div>
      <div class="w208 border01 l leftPart mb10">
        <div style="max-height:10000px; overflow-y:hidden;" id="treev1" class="treev1">
          <ul>
		    <%
	    	for(Map topCat : catalogList){
	    		String topCatNum = CommonString.getFormatPara(topCat.get("num"));
	    		if(topCatNum.length() == 3){
	    			String topCatName = CommonString.getFormatPara(topCat.get("name"));
	    			String topCatId = CommonString.getFormatPara(topCat.get("id"));
	    %>
	    <li class="root" id="cat_<%=topCatNum %>">
	    	<b style="font-size:14px;"><a href="/rank_<%=topCatNum %>.htm"><%=topCatName %></a></b>
	    	<ul style="display:<%=topCatNum.equals(catalog) || (!catalog.equals("")&&catalog.substring(0, 3).equals(topCatNum)) ? "block" : "none" %><%if(catalog.equals("")&&topCatNum.equals("101")){%>block<%}%>;">
	    <%
				    for(Map subCat : catalogList){
						String subParentId = CommonString.getFormatPara(subCat.get("parentid"));
						if(subParentId.equals(topCatId)){
							String subCatNum = CommonString.getFormatPara(subCat.get("num"));
							String subCatName = CommonString.getFormatPara(subCat.get("name"));
		%>
				<li id="cat_<%=topCatNum %>_<%=subCatNum %>"<%=catalog.equals(subCatNum) ? " class=\"rootCur\"" : "" %>>
					<a href="/rank_<%=subCatNum %>.htm" class="mainBrand"><big><%=subCatName %></big></a>
				</li>
		<%
						}
					}
	    %>
	    	</ul>
	    </li>
	    <%}}%>	
          </ul>
        </div>
        <!--字母检索结束--> 
      </div>
    </div>
  </div>
  <!--left end-->
  <!--right-->
  <div class="w757 r mb10">
    <div class="fix newRank">
      <div class="rcl-box fix">
        <jsp:include page="/include/koubei/koubei_rank.htm" flush="true" />
      </div>
    </div>
  </div>
  <!--right end-->
</div>
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--end of foot-->

<style type="text/css">
/*对联广告*/
/*左侧*/
#ads01 { position:fixed; left:0px; top:80px; z-index:999999; width:42px; height:350px;}
* html #ads01 {position:absolute; left:expression(eval(document.documentElement.scrollLeft)); top:expression(eval(document.documentElement.scrollTop)+100);}
/*右侧*/
#ads02 { position:fixed; right:0px; top:80px; z-index:99999; width:42px; height:350px;}
* html #ads02 {position:absolute; left:expression(eval(document.documentElement.scrollLeft+document.documentElement.clientWidth-this.offsetWidth)-(parseInt(this.currentStyle.marginLeft,0)||0)-(parseInt(this.currentStyle.marginRight,0)||0)); top:expression(eval(document.documentElement.scrollTop)+100);}
.hide { display:none;}
.ads_big { display:none;}
#ads01.ads_hover,#ads02.ads_hover { width:95px!important;}
.ads_hover .ads_small { display:none;}
.ads_hover .ads_big { display:block;}
/*对联广告结束*/
</style>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
<!--对联广告-->
<div id="ads02" class="ads_hover">
<a href="http://product.21-sun.com/activity/koubei/index.jsp" target="blank" style="display:block;"><img src="http://product.21-sun.com/images/kb_dl20140702.jpg" width="95" height="330" class="ads_big" /></a>
<img src="http://news.21-sun.com/images/close_x.gif" width="39" height="13" alt="关闭" title="关闭" onclick="document.getElementById('ads02').className='hide';" style="cursor:pointer; margin-top:1px; float:right;" />
</div>
<!--对联广告结束-->
</body>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/superslide.js"></script>
<script type="text/javascript">
var len = $('.kbSlider .hd li').length - 1;
var leftwidth = len * 34;
$(".kbSlider").slide({ titCell:".hd li", mainCell:".bd ul",effect:"leftLoop",vis:1,scroll:1,autoPlay:true,interTime:4000,startFun:function(i){
	$('.kbSlider .hd ul').children('li').eq(i).css('width',520 - leftwidth).siblings().removeAttr('style')
}});
</script>
</html>