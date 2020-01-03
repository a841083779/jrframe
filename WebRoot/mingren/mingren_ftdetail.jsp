<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.common.*,com.jerehnet.webservice.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String id = CommonString.getFormatPara(request.getParameter("id")) ; // 一条产品订单的id
	
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map m = dbHelper.getMap(" select * from pro_famous_person where id=?",new Object[]{id}) ;
	if(m == null){
		response.setStatus(301);
		response.setHeader("Location", "/mingren/"); 
		return;	
	}
	
	List <Map>o = WEBDBHelper.getMapList(" select top 2 title,id,link_other,image,person,intro from people_lundao_detail where (person like '%"+CommonString.getFormatPara(m.get("name"))+"%' or title like '%"+CommonString.getFormatPara(m.get("name"))+"%') order by id desc ","Web21sunDBHelper");
	//该人物其它访谈
	List<Map> lo = WEBDBHelper.getMapList(" select top 18 title,id,link_other from people_lundao_detail where (person like '%"+CommonString.getFormatPara(m.get("name"))+"%' or title like '%"+CommonString.getFormatPara(m.get("name"))+"%') order by id desc ","Web21sunDBHelper");
	//若访谈数量不够，调取新闻
	List<Map> loa = null;
	if(lo != null && lo.size() < 18){
		loa = WEBDBHelper.getMapList(" select top "+(18-lo.size())+" title,id,link_other,html_filename from article where title like '%"+CommonString.getFormatPara(m.get("name"))+"%' order by id desc ","Web21sunDBHelper");	
	}
	//相关人物
	List<Map> lr = WEBDBHelper.getMapList(" select top 7 title,id,link_other,image from people_lundao_detail order by id desc ","Web21sunDBHelper");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%if(!id.equals("")){%>
<title><%=CommonString.getFormatPara(m.get("name"))%>访谈 – 铁臂名人堂</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(m.get("name"))%>访谈,<%=CommonString.getFormatPara(m.get("name"))%>对话,<%=CommonString.getFormatPara(m.get("name"))%>" />
<meta name="description" content="铁臂名人堂为您提供<%=CommonString.getFormatPara(m.get("name"))%>访谈对话内容。找<%=CommonString.getFormatPara(m.get("name"))%>访谈，就上铁臂名人堂！" />
<%}else{%>

<%}%>
<meta name="renderer" content="webkit">
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
</head>
<body class="mingren_none">
<!--top--> 
<jsp:include page="/include/top_mingren_detail.jsp" flush="true"/>
<jsp:include page="/mingren/tongji.jsp"/>
<!--top end-->
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> <a href="/">首页</a> &gt; <a href="/ftlist/">名人访谈</a><%if(!id.equals("")){%> &gt; <%=CommonString.getFormatPara(m.get("name"))%>访谈<%}%></h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 fm-wryh">
	<div class="mr_ftdet_one fix">
    <%for(int i = 0; o != null && i<o.size();i++){%>
    	<%if(i==0){%><div class="ftimg"><a target="_blank" href="<%=CommonString.getFormatPara(o.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("position"))%><%=CommonString.getFormatPara(m.get("name"))%>"><img src="<%=CommonString.getFormatPara(o.get(i).get("image"))%>" alt="<%=CommonString.getFormatPara(o.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("position"))%><%=CommonString.getFormatPara(m.get("name"))%>" width="310" height="230"/></a></div><%}%>
        <div class="ft_nr">
        	<%if(i==0){%><div class="ft_title"><a target="_blank" href="<%=CommonString.getFormatPara(o.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("position"))%><%=CommonString.getFormatPara(m.get("name"))%>"><%=CommonString.getFormatPara(m.get("factoryname"))%><%=CommonString.getFormatPara(m.get("position"))%><%=CommonString.getFormatPara(m.get("name"))%></a></div><%}%>
            <div class="ft_pname"><a target="_blank" href="<%=CommonString.getFormatPara(o.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(o.get(i).get("title"))%>"><%=CommonString.getFormatPara(o.get(i).get("title"))%></a></div>
            <div class="ft_sum"><a target="_blank" href="<%=CommonString.getFormatPara(o.get(i).get("link_other"))%>" title=""><%=CommonString.getFormatPara(o.get(i).get("intro"))%></a></div>
            <div class="ft_more"><a target="_blank" href="<%=CommonString.getFormatPara(o.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(o.get(i).get("title"))%>">查看详情&gt;</a></div>
        </div>
    <%}%>
    </div>
    <div class="mr_ftdet_two">
    	<ul class="mrft_list fix">
        <%for(int i = 0; lo != null && i<lo.size();i++){%>
        	<li><a target="_blank" href="<%=CommonString.getFormatPara(lo.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(lo.get(i).get("title"))%>"><%=CommonString.getFormatPara(lo.get(i).get("title"))%></a></li>
        <%}%> 
        <%for(int i = 0; loa != null && i<loa.size();i++){%>
        	<li><a target="_blank" href="http://news.21-sun.com/detail/<%=CommonString.getFormatPara(loa.get(i).get("html_filename")).substring(0,4)%>/<%=CommonString.getFormatPara(loa.get(i).get("html_filename")).substring(4,6)%>/<%=CommonString.getFormatPara(loa.get(i).get("html_filename"))%>" title="<%=CommonString.getFormatPara(loa.get(i).get("title"))%>"><%=CommonString.getFormatPara(loa.get(i).get("title"))%></a></li>
        <%}%>   
        </ul>
    </div>
    <div class="mr_ftdet_three">
    	<div class="xgft_t">相关人物访谈</div>
        <div class="xgft_list">
        	<ul class="fix">
            <%for(int i = 0; lr != null && i<lr.size();i++){%>
            	<li>
                	<a target="_blank" href="<%=CommonString.getFormatPara(lr.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(lr.get(i).get("title"))%>">
                    	<img src="<%=CommonString.getFormatPara(lr.get(i).get("image"))%>" alt="<%=CommonString.getFormatPara(lr.get(i).get("title"))%>" width="127" height="94"/>
                        <p><%=CommonString.getFormatPara(lr.get(i).get("title"))%></p>
                    </a>
                </li>
             <%}%>
            </ul>
        </div>
    </div>
</div>
<!--main end-->
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