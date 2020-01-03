<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.Common"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="java.sql.Connection"%><%@page import="com.jerehnet.util.common.CommonApplication"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;
	Map brandMap = (Map)application.getAttribute("brandMap") ;
	String factoryname = brandMap.get(factory)!=null?(String)brandMap.get(factory):"";
	
	DBHelper dbHelper = DBHelper.getInstance() ;
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	StringBuffer whereStr = new StringBuffer(" and 1=1") ;

	if(!"".equals(factory)){
		whereStr.append(" and factoryid="+factory) ;
	}
	String url = CommonString.getFormatPara(request.getQueryString()) ;  // 调整url，做分页处理
	if(!"".equals(url)){
		if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
			url="" ;
		}else if(url.indexOf("offset")!=-1 ){
			url = "&"+url.substring(url.indexOf("&")+1) ;
		}else{
			url = "&"+url ;
		}
	}
	PageBean pageBean = new PageBean() ;
	pageBean.setPageSize(30) ;
	Integer nowPage = 1 ;
	if(!"".equals(offset) && !"0".equals(offset)){
	 	nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	}
	pageBean.setNowPage(nowPage) ;
	pageBean.setParams(url) ;
	pageBean.setCondition(whereStr.toString()) ;
	pageBean.setFields(" * ") ;
	//pageBean.setIsShowSql(true) ;
	pageBean.setTableName(" pro_famous_person ") ;
	String orderbyStr = "";
	pageBean.setOrderBy(orderbyStr) ;
	// 根据条件查出的产品
	List<Map> l = pageBean.getDatas() ;  
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>工程机械图片大全_工程机械图片库 - 铁臂图库</title>
<meta name="renderer" content="webkit">
<meta name="keywords" content="工程机械图片,工程机械图片大全,工程机械,铁臂图库" />
<meta name="description" content="铁臂图库为您提供各种品牌工程机械高清图片，买工程机械就上铁臂商城。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<!--[if IE 6]><script src="/scripts/pngfix.js">/* s,i,.pngfix,.pngimg img */</script><![endif]-->
<style type="text/css">
.mr_brandse .mrb_srlist { height:auto;}
.mrb_srlist .ConditionBottom { background:#fff;}
.mrb_srlist .ConditionBottom li.cblist dd { width:775px;}
.mrb_srlist .ConditionBottom li.cblist dd .plmore { float:none; clear:both; width:845px;}
</style>
</head>
<body class="mingren_none">
<!--top-->
<jsp:include page="/include/top_mingren.jsp" flush="true"/>
<!--top end--> 
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> <a href="/">首页</a> &gt; <a href="/qiyemingren_list.htm">企业名人</a><%if(!factoryname.equals("")){%> &gt; <%=factoryname%><%}%></h3>
</div>
<!--面包屑结束-->
<div class="contain980"><img src="../images/new_pro/qymr_timg.jpg" width="980" height="45"/></div>
<!--搜索-->
<div class="contain980 fm-wryh">
  <div class="fix mr_brandse">
    <div class="mrbrand_l">按品牌搜索：</div>
    <div class="mrbrand_r">
      <div class="mrb_srlist"> <ul class="ConditionBottom">
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
          <dd>
            <a <%if("".equals(factory)){%> class='select' <%} %> href="/qiyemingren_list.htm">不限</a> 
            <a <%if("133".equals(factory)){%> class='select' <%} %> href="/qiyemingren_list.htm?factory=133">三一</a> 
            <div id="changethis" class="pbtn"></div>
            <div class="plmore" style="padding-left: 0px;">
            <jsp:include page="/include/products/brand_mingren.jsp" flush="true">
            <jsp:param value="<%=factory%>" name="factoy_id"/>
            </jsp:include>
            </div>
          </dd>
        </li>
        <script type="text/javascript">
	            if('101001001'.indexOf("101001")!=-1){
	              jQuery("#grab").attr("style","display:;") ;
	            }
	               if('101001001'.indexOf("101002")!=-1){
	              jQuery("#loader").attr("style","display:;") ;
	            }
	               if('101001001'.indexOf("102")!=-1){
	              jQuery("#crane").attr("style","display:;") ;
	            }
	          </script>
      </ul> </div>
    </div>
  </div>
</div>
<!--搜索结束--> 
<!--企业名人-->
<div class="contain980 mrt_lanmu">
  <div class="mrqy_val">
    <ul class="fix mrqy_list">
    <%for(int i = 0; l != null && i<l.size();i++){%>
      <li>
        <p class="qymr_img"><a target="_blank" href="/mingren_detail_<%=CommonString.getFormatPara(l.get(i).get("id"))%>.htm"><img src="/uploadfiles/<%=CommonString.getFormatPara(l.get(i).get("img"))%>" alt="<%=CommonString.getFormatPara(l.get(i).get("name"))%>"></a></p>
        <div class="qymr_name"><a target="_blank" href="/mingren_detail_<%=CommonString.getFormatPara(l.get(i).get("id"))%>.htm"><%=CommonString.getFormatPara(l.get(i).get("name"))%> <%=CommonString.getFormatPara(l.get(i).get("position"))%></a></div>
        <div class="qymr_sum"><%=CommonString.getFormatPara(l.get(i).get("achieve"))%><a target="_blank" href="/mingren_detail_<%=CommonString.getFormatPara(l.get(i).get("id"))%>.htm">[详情]</a></div>
        <%if(i<3){%><i class="mrhot_ico hotico_0<%=i+1%>"></i><%}%> </li>
     <%}%>
    </ul>
  </div>
  <%if(pageBean.getTotal() > pageBean.getPageSize() ){%>
  <div class="w755 l">
    <div id="pagination" class="page">
   		<tags:page pageBean="<%=pageBean %>"  />   
    </div>
  </div>
  <%}%>
</div>
<!--企业名人结束-->
<div class="contain980 nomess_tel">如果没有找到您的信息，请直接致电：4006-521-526</div>
<!--foot-->
<jsp:include page="../include/foot_photo.jsp"/>
<!--foot end--> 
<script type="text/javascript">
	$('.mrfc_list li:lt(3) .mr_num').addClass('red_num')
	$('.mrfc_list li').hover(function(){
		$(this).addClass('mrfc_open').siblings().removeClass('mrfc_open');
	});
	
	$('.mrb_srmore a').click(function(){
		var na = $('.mrb_srlist'); 
		na.toggleClass('mrb_srlist_auto'); 
		if( na.hasClass('mrb_srlist_auto') ){ 
			$(this).addClass('add_sqbtn');
		}else{ 
			$(this).removeClass('add_sqbtn');
		} 
	});

</script>
</body>
</html>