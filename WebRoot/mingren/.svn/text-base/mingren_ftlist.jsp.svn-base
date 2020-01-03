<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.common.*,com.jerehnet.webservice.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	//相关人物
	List<Map> lr = null;
	PageBean pageBean = new PageBean();
	pageBean.setFields("*") ;
	pageBean.setPageSize(24);
	pageBean.setTableName("people_lundao_detail");
	Integer nowPage = 1;
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	if("".equals(offset) || Integer.parseInt(offset)<=0){
		offset = "0" ;
	}
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}
	String url = CommonString.getFormatPara(request.getQueryString());
	if (!"".equals(url)) {
		if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
			url = "";
		} else if (url.indexOf("offset") != -1) {
			url = "&" + url.substring(url.indexOf("&") + 1);
		} else {
			url = "&" + url;
		}
	}
	String w = " and 1=1 ";
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
		if(factory.equals("0")){factory="";}

	Map brandMap = (Map)application.getAttribute("brandMap") ;
	String factoryname = brandMap.get(factory)!=null?(String)brandMap.get(factory):"";
	if(!factory.equals("")){
		w += " and person like '%"+factoryname+"%' ";	
	}
	pageBean.setNowPage(nowPage);
	pageBean.setCondition(w);
	pageBean.setParams(url);
	pageBean.setOrderBy("id desc");
	lr = pageBean.getDatasByWebService("Web21sunDBHelper");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=factoryname.equals("")?"工程机械":factoryname%>名人访谈 - 铁臂名人堂</title>
<meta name="keywords" content="<%=factoryname.equals("")?"工程机械":factoryname%>名人访谈,<%=factoryname.equals("")?"工程机械":factoryname%>名人对话" />
<meta name="description" content="铁臂名人堂为您提供<%=factoryname.equals("")?"工程机械":factoryname%>名人访谈和<%=factoryname.equals("")?"工程机械":factoryname%>名人对话内容，找<%=factoryname.equals("")?"工程机械":factoryname%>名人访谈，就上铁臂名人堂。" />
<meta name="renderer" content="webkit">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="mingren.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<!--[if IE 6]><script src="/scripts/pngfix.js">/* s,i,.pngfix,.pngimg img */</script><![endif]-->
</head>
<body class="mingren_none">
<!--top-->
<jsp:include page="/include/top_mingren.jsp" flush="true"/>
<!--top end--> 
<jsp:include page="/mingren/tongji.jsp"/>

<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> <a href="/">首页</a> &gt; <a href="/ftlist/">名人访谈</a><%if(!factoryname.equals("")){%> &gt; <%=factoryname%>名人访谈<%}%></h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 fix"> 
  <div class="visit_search">
    <strong class="n">按品牌搜索：</strong>
    <div class="vs_box"><a <%if("133".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_133_0.htm">三一</a>
    <a <%if("209".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_209_0.htm">徐工</a>
    <a <%if("134".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_134_0.htm">中联重科</a>
    <a <%if("136".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_136_0.htm">柳工</a>
    <a <%if("138".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_138_0.htm">卡特彼勒青州</a>
    <a <%if("144".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_144_0.htm">山推</a>
    <a <%if("139".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_139_0.htm">厦工</a>
    <a <%if("137".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_137_0.htm">山东临工</a>
    <a <%if("145".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_145_0.htm">成工</a>
    <a <%if("158".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_158_0.htm">合力</a>
    <a <%if("141".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_141_0.htm">福田雷沃重工</a>
    <a <%if("142".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_142_0.htm">山河智能</a>
    <a <%if("135".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_135_0.htm">龙工</a>
    <a <%if("195".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_195_0.htm">詹阳动力</a>
    <a <%if("146".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_146_0.htm">玉柴重工</a>
    <a <%if("164".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_164_0.htm">抚挖</a>
    <a <%if("159".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_159_0.htm">一拖（洛阳）</a>
    <a <%if("140".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_140_0.htm">鼎盛重工</a>
    <a <%if("1734".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1734_0.htm">浙江杭叉</a>
    <a <%if("542".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_542_0.htm">中交西筑</a>
    <a <%if("200".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_200_0.htm">南方路机</a>
    <a <%if("154".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_154_0.htm">宣工</a>
    <a <%if("172".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_172_0.htm">晋工</a>
    <a <%if("151".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_151_0.htm">德工</a>
    <a <%if("170".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_170_0.htm">恒特重工</a>
    <a <%if("1718".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1718_0.htm">雷萨重机</a>
    <a <%if("152".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_152_0.htm">山重建机</a>
    <a <%if("149".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_149_0.htm">沃德重工</a>
    <a <%if("148".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_148_0.htm">常林股份</a>
    <a <%if("157".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_157_0.htm">力士德</a>
    <a <%if("477".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_477_0.htm">格瑞德</a>
    <a <%if("202".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_202_0.htm">鸿得利重工</a>
    <a <%if("671".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_671_0.htm">方圆集团</a>
    <a <%if("673".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_673_0.htm">洛阳路通</a>
    <a <%if("690".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_690_0.htm">新筑股份</a>
    <a <%if("770".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_770_0.htm">宜工</a>
    <a <%if("1093".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1093_0.htm">北车重工</a>
    <a <%if("1147".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1147_0.htm">恒天九五</a>
    <a <%if("1211".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1211_0.htm">同力重工</a>
    <a <%if("487".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_487_0.htm">江麓</a>
    <a <%if("150".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_150_0.htm">徐挖</a>
    <a <%if("1777".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1777_0.htm">英轩重工</a>
    <a <%if("1214".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1214_0.htm">重汽海斗</a>
    <a <%if("423".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_423_0.htm">工兵</a>
    <a <%if("1097".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1097_0.htm">星邦重工</a>
    <a <%if("13640".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_13640_0.htm">华南重工</a>
    <a <%if("1092".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1092_0.htm">山东圆友</a>
    <a <%if("1357".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1357_0.htm">建友机械</a>
    <a <%if("13652".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_13652_0.htm">久润</a>
    <a <%if("199".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_199_0.htm">普茨迈斯特</a>
    <a <%if("1304".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1304_0.htm">山特维克</a>
    <a <%if("190".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_190_0.htm">石川岛</a>
    <a <%if("14238".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_14238_0.htm">约翰迪尔</a>
    <a <%if("1185".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1185_0.htm">阿尔多</a>
    <a <%if("180".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_180_0.htm">阿特拉斯</a>
    <a <%if("482".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_482_0.htm">阿特拉斯·科普柯</a>
    <a <%if("1759".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1759_0.htm">京城长野</a>
    <a <%if("13687".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_13687_0.htm">立藤</a>
    <a <%if("454".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_454_0.htm">山猫</a>
    <a <%if("188".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_188_0.htm">竹内</a>
    <a <%if("13664".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_13664_0.htm">科尼乐重工</a>
    <a <%if("203".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_203_0.htm">辽宁海诺</a>
    <a <%if("14232".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_14232_0.htm">千里马</a>
    <a <%if("401".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_401_0.htm">惊天液压</a>
    <a <%if("1218".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1218_0.htm">道胜</a>
    <a <%if("156".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_156_0.htm">上海彭浦</a>
    <a <%if("14235".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_14235_0.htm">神娃机械</a>
    <a <%if("1683".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1683_0.htm">新源机械</a>
    <a <%if("867".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_867_0.htm">徐州凯尔</a>
    <a <%if("1525".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1525_0.htm">合矿</a>
    <a <%if("13118".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_13118_0.htm">山东鲁工</a>
    <a <%if("1216".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1216_0.htm">瑞诺</a>
    <a <%if("13699".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_13699_0.htm">诺力</a>
    <a <%if("1193".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1193_0.htm">巨超重工</a>
    <a <%if("1195".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1195_0.htm">重庆大江</a>
    <a <%if("1138".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1138_0.htm">重庆升力</a>
    <a <%if("562".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_562_0.htm">愚公机械</a>
    <a <%if("195".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_195_0.htm">詹阳动力</a>
    <a <%if("169".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_169_0.htm">南特</a>
    <a <%if("13569".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_13569_0.htm">宝达</a>
    <a <%if("1159".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_1159_0.htm">广州京龙</a>
    <a <%if("206".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_206_0.htm">华力重工</a>
    <a <%if("13570".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_13570_0.htm">宝鼎</a>
    <a <%if("197".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_197_0.htm">酒井</a>
    <a <%if("207".equals(factory)){%> class='cur' <%} %> href="/mingren_ftlist_207_0.htm">陆德筑机</a>

    </div>
    <div class="pbtn" id="changethis"></div>
  </div>
  <div class="visit_list fix">
    <ul class="fix">
    <%for(int i = 0; lr != null && i<lr.size();i++){%>
      <li>
        <h2><a target="_blank" href="<%=CommonString.getFormatPara(lr.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(lr.get(i).get("title"))%>"><%=CommonString.getFormatPara(lr.get(i).get("title"))%></a></h2>
        <a target="_blank" href="<%=CommonString.getFormatPara(lr.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(lr.get(i).get("person"))%>"><div class="show">
          <img src="<%=CommonString.getFormatPara(lr.get(i).get("image"))%>" alt="<%=CommonString.getFormatPara(lr.get(i).get("person"))%>" width="264" height="197" />
          <div class="info">
            本期人物：<strong><%=CommonString.getFormatPara(lr.get(i).get("person"))%></strong>
            <!--<span class="auther">作者：张成美</span>-->
          </div>
        </div></a>
        <a target="_blank" href="<%=CommonString.getFormatPara(lr.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(lr.get(i).get("title"))%>"><div class="text"><%=CommonString.getFormatPara(lr.get(i).get("intro"))%></div>
        <span class="btn">详细阅读</span></a>
      </li>
    <%}%>  
    </ul>
    <div class="pages">
        <form id="theform" name="theform" method="post" action="">
		<div id="pagination" class="paging  page" style="margin-right:3px;">
			<tags:page_mrft pageBean="<%=pageBean%>" />
		</div>
        </form>
      </div>
  </div>
</div>
<!--main end-->
<div class="contain980 nomess_tel">如果没有找到您的信息，请直接致电：4006-521-526</div>
<!--foot-->
<jsp:include page="../include/foot_photo.jsp"/>
<!--foot end--> 
<script type="text/javascript">
$('.pbtn').click(function(){
	if($(this).hasClass('pbon')){
		$(this).removeClass('pbon');
		$(this).prev('.vs_box').removeAttr('style');
	}else{
		$(this).addClass('pbon');
		$(this).prev('.vs_box').css('height','auto');
	}
	
})
</script>
</body>
</html>