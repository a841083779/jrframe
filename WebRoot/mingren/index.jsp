<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.common.*,com.jerehnet.webservice.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	DBHelper dbHelper = DBHelper.getInstance() ;
	List <Map>ls = dbHelper.getMapList(" select top 10 * from pro_famous_person order by view_count desc " );
	List <Map>fc = WEBDBHelper.getMapList(" select top 6 title,id,link_other,html_filename,image,view_count from article where title like '%人物%' and image is not null and image != '' order by id desc ","Web21sunDBHelper");
	List <Map>fs = WEBDBHelper.getMapList(" select top 4 title,id,link_other,html_filename,image,subtitle from article where title like '%人物%' and image is not null and image != '' order by subtitle desc,id desc ","Web21sunDBHelper");	
	List<Map> ft = WEBDBHelper.getMapList(" select top 4 title,id,link_other,image,intro from people_lundao_detail order by id desc ","Web21sunDBHelper");
	List <Map>wb = dbHelper.getMapList(" select top 12 * from pro_famous_person where weibo_url!='' order by view_count desc " );
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>工程机械名人_行业人物 - 铁臂名人堂</title>
<meta name="keywords" content="工程机械行业名人,工程机械行业人物" />
<meta name="description" content="铁臂名人堂为您提供众多工程机械行业人物信息,帮助您关注工程机械行业名人与热点人物最新动态。了解工程机械行业名人，就上铁臂名人堂！" />
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
<body>
<!--top--> 
<jsp:include page="/include/top_mingren.jsp" flush="true"/>
<jsp:include page="/mingren/tongji.jsp"/>
<!--top end-->
<!--banner-->
<div class="contain980 fix">                        
	<div class="mrtop_left fix">
    	<div class="mrt_img01">
        	<div class="mrt_img01_n"><a href="#"><img src="http://product.21-sun.com/mingren/images/wangmin.jpg" alt="王民" width="250" height="160"/></a></div>
            <div class="mrt_img01_n"><a href="#"><img src="http://product.21-sun.com/mingren/images/zhanchunxin.jpg" alt="詹纯新" width="250" height="160"/></a></div>
        </div>
        <div class="mrt_img02">
        	<div class="mrt_img02_n"><a href="#"><img src="../images/new_pro/mrt_img.gif" alt="" width="200" height="120"/></a></div>
            <div class="mrt_img02_n"><a href="#"><img src="http://product.21-sun.com/mingren/images/wangxiaohua.jpg" alt="王晓华" width="200" height="200"/></a></div>
        </div>
        <div class="mrt_img03">
        	<div class="mrt_img03_n"><a href="http://mingren.21-sun.com/mingren_detail_18.htm" target="_blank"><img src="http://product.21-sun.com/mingren/images/liangwengen.jpg" alt="梁稳根" width="206" height="322"/></a></div>
        </div>
    </div>
    <div class="mrtop_right">
    	<ul class="fix mrfc_list">
        <%for(int i = 0;fc != null && i<fc.size();i++){%>
        	<li <%if(i==0){%>class="mrfc_open"<%}%>>
            	<div class="mr_num"><%=i+1%></div>
                <div class="mr_nr">
                	<a target="_blank" href="http://news.21-sun.com/detail/<%=CommonString.getFormatPara(fc.get(i).get("html_filename")).substring(0,4)%>/<%=CommonString.getFormatPara(fc.get(i).get("html_filename")).substring(4,6)%>/<%=CommonString.getFormatPara(fc.get(i).get("html_filename"))%>" title="<%=CommonString.getFormatPara(fc.get(i).get("title"))%>"><img src="http://news.21-sun.com/UserFiles/Image/<%=CommonString.getFormatPara(fc.get(i).get("image"))%>" width="116px" height="65px" alt="<%=CommonString.getFormatPara(fc.get(i).get("title"))%>" />
                        <p class="mrfc_title"><%=CommonString.getFormatPara(fc.get(i).get("title")).length()>17?CommonString.getFormatPara(fc.get(i).get("title")).substring(0,17):CommonString.getFormatPara(fc.get(i).get("title"))%></p>
                        <p class="mrfc_play">播放：<%=CommonString.getFormatPara(fc.get(i).get("view_count"))%></p>
                    </a>
                </div>
            </li>
        <%}%>    
        </ul>
        <div class="mrfc_tag"></div>
    </div>
</div>
<!--banner end-->
<!--企业名人-->
<div class="contain980 mrt_lanmu">
	<div class="mrt_lant fix">
    	<img src="../images/new_pro/mrt_lan01.gif" width="980" height="56" alt=""/>
        <!--<a href="#" class="mr_sub">立即提交名人</a>-->
    </div>
    <div class="mrqy_val">
    	<div class="mrt_more"><a href="/list/" title="更多企业名人">更 多 &gt;</a></div>
        <ul class="fix mrqy_list">
        <%for(int i = 0;ls != null && i<ls.size();i++){%>
        	<li>
              <p class="qymr_img"><a title="<%=CommonString.getFormatPara(ls.get(i).get("name"))%>" href="/mingren_detail_<%=CommonString.getFormatPara(ls.get(i).get("id"))%>.htm"><img src="/uploadfiles/<%=CommonString.getFormatPara(ls.get(i).get("img"))%>" alt="<%=CommonString.getFormatPara(ls.get(i).get("name"))%>"/></a></p>
              <div class="qymr_name"><a title="<%=CommonString.getFormatPara(ls.get(i).get("name"))%>" href="/mingren_detail_<%=CommonString.getFormatPara(ls.get(i).get("id"))%>.htm"><%=CommonString.getFormatPara(ls.get(i).get("name"))%> <%=CommonString.getFormatPara(ls.get(i).get("factoryname"))%><%=CommonString.getFormatPara(ls.get(i).get("position"))%></a></div>
              <div class="qymr_sum"><%=CommonString.getFormatPara(ls.get(i).get("achieve"))%><a title="<%=CommonString.getFormatPara(ls.get(i).get("name"))%>" href="/mingren_detail_<%=CommonString.getFormatPara(ls.get(i).get("id"))%>.htm">[详情]</a></div>
              <%if(i<3){%><i class="mrhot_ico hotico_0<%=i+1%>"></i><%}%> </li>
            </li>
         <%}%>   
        </ul>
    </div>
    <div class="mrqy_val2 fix">
    	<div class="mr_dtlist">
        	<div class="fix mrdt_lan">
            	<div class="l mrdt_t">名人风采</div>
                <div class="r mrdt_more"><a href="/fclist/" title="更多名人风采">更多</a></div>
            </div>
            <ul class="fix mrt_dtlist">
            <%for(int i = 0;fs != null && i<fs.size();i++){%>
            	<li>
                	<div class="mrdt_img"><a target="_blank" href="http://news.21-sun.com/detail/<%=CommonString.getFormatPara(fs.get(i).get("html_filename")).substring(0,4)%>/<%=CommonString.getFormatPara(fs.get(i).get("html_filename")).substring(4,6)%>/<%=CommonString.getFormatPara(fs.get(i).get("html_filename"))%>" title="<%=CommonString.getFormatPara(fs.get(i).get("title"))%>"><img src="http://news.21-sun.com/UserFiles/Image/<%=CommonString.getFormatPara(fs.get(i).get("image"))%>" alt="<%=CommonString.getFormatPara(fs.get(i).get("title"))%>" /></a></div>
                    <div class="mrdt_nr">
                    	<div class="mtt1" style="height:auto;"><a target="_blank" href="http://news.21-sun.com/detail/<%=CommonString.getFormatPara(fs.get(i).get("html_filename")).substring(0,4)%>/<%=CommonString.getFormatPara(fs.get(i).get("html_filename")).substring(4,6)%>/<%=CommonString.getFormatPara(fs.get(i).get("html_filename"))%>" title="<%=CommonString.getFormatPara(fs.get(i).get("title"))%>"><%=CommonString.getFormatPara(fs.get(i).get("title"))%></a></div>
                        <div class="mtt3"><%=CommonString.getFormatPara(fs.get(i).get("subtitle")).equals("null")?"":CommonString.getFormatPara(fs.get(i).get("subtitle"))%></div>
                    </div>
                </li>
             <%}%>   
            </ul>
        </div>
        <div class="mr_dtlist">
        	<div class="fix mrdt_lan">
            	<div class="l mrdt_t">名人访谈</div>
                <div class="r mrdt_more"><a href="/ftlist/" title="更多名人访谈">更多</a></div>
            </div>
            <ul class="fix mrt_dtlist">
            <%for(int i = 0; ft != null && i<ft.size();i++){%>
            	<li>
                	<div class="mrdt_img"><a target="_blank" href="<%=CommonString.getFormatPara(ft.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(ft.get(i).get("title"))%>"><img src="<%=CommonString.getFormatPara(ft.get(i).get("image"))%>" alt="<%=CommonString.getFormatPara(ft.get(i).get("title"))%>" /></a></div>
                    <div class="mrdt_nr">
                    	<div class="mtt1"><a target="_blank" href="<%=CommonString.getFormatPara(ft.get(i).get("link_other"))%>" title="<%=CommonString.getFormatPara(ft.get(i).get("title"))%>"><%=CommonString.getFormatPara(ft.get(i).get("title"))%></a></div>
                        <div class="mtt2"><%=CommonString.getFormatPara(ft.get(i).get("person"))%></div>
                        <div class="mtt3"><%=CommonString.getFormatPara(ft.get(i).get("intro"))%></div>
                    </div>
                </li>
             <%}%>
            </ul>
        </div>
        <div class="mr_dtlist mr_dtlist2">
        	<div class="fix mrdt_lan">
            	<div class="l mrdt_t">名人微博</div>
                <div class="r mrdt_more"></div>
            </div>
            <ul class="fix cfb_list">
            <%for(int i = 0; wb != null && i<wb.size();i++){%>
            	<li>
                	<a target="_blank" href="<%=CommonString.getFormatPara(wb.get(i).get("weibo_url"))%>">
                    	<img src="/uploadfiles/<%=CommonString.getFormatPara(wb.get(i).get("img"))%>" alt="<%=CommonString.getFormatPara(wb.get(i).get("name"))%>"/>
                        <p><%=CommonString.getFormatPara(wb.get(i).get("name"))%></p>
                    </a>
                </li>
            <%}%>    
            </ul>
        </div>
    </div>
</div>
<!--企业名人结束-->
<!--行业达人-->
<div class="contain980 mrt_lanmu" style="display:none;">
	<div class="mrt_lant fix">
    	<img src="../images/new_pro/mrt_lan02.gif" width="980" height="56" alt=""/>
        <a href="#" class="mr_sub">立即提交名人</a>
    </div>
    <div class="hydr_val">
    <div class="mrt_more"><a href="#">更 多 &gt;</a></div>
    <ul class="fix hydr_list">
    	<li>
        	<div class="hydr_img">
            	<a href="#"><img src="../images/new_pro/mr_temp08.jpg" alt=""/></a>
                <i class="hydr_ico hydr_ico01"></i>
            </div>
            <div class="hydr_name"><a href="#">催恒 主任医师</a></div>
            <div class="hydr_gn"><span class="gn1">活跃指数：</span><span class="gn2"><i style="width:40%;"></i></span><span class="gn3">1223434</span></div>
        </li>
        <li>
        	<div class="hydr_img">
            	<a href="#"><img src="../images/new_pro/mr_temp08.jpg" alt=""/></a>
                <i class="hydr_ico hydr_ico02"></i>
            </div>
            <div class="hydr_name"><a href="#">催恒 主任医师</a></div>
            <div class="hydr_gn"><span class="gn1">活跃指数：</span><span class="gn2"><i style="width:40%;"></i></span><span class="gn3">1223434</span></div>
        </li>
        <li>
        	<div class="hydr_img">
            	<a href="#"><img src="../images/new_pro/mr_temp08.jpg" alt=""/></a>
                <i class="hydr_ico hydr_ico03"></i>
            </div>
            <div class="hydr_name"><a href="#">催恒 主任医师</a></div>
            <div class="hydr_gn"><span class="gn1">活跃指数：</span><span class="gn2"><i style="width:40%;"></i></span><span class="gn3">1223434</span></div>
        </li>
        <li>
        	<div class="hydr_img">
            	<a href="#"><img src="../images/new_pro/mr_temp08.jpg" alt=""/></a>
            </div>
            <div class="hydr_name"><a href="#">催恒 主任医师</a></div>
            <div class="hydr_gn"><span class="gn1">活跃指数：</span><span class="gn2"><i style="width:40%;"></i></span><span class="gn3">1223434</span></div>
        </li>
        <li>
        	<div class="hydr_img">
            	<a href="#"><img src="../images/new_pro/mr_temp08.jpg" alt=""/></a>
            </div>
            <div class="hydr_name"><a href="#">催恒 主任医师</a></div>
            <div class="hydr_gn"><span class="gn1">活跃指数：</span><span class="gn2"><i style="width:40%;"></i></span><span class="gn3">1223434</span></div>
        </li>
        <li>
        	<div class="hydr_img">
            	<a href="#"><img src="../images/new_pro/mr_temp08.jpg" alt=""/></a>
            </div>
            <div class="hydr_name"><a href="#">催恒 主任医师</a></div>
            <div class="hydr_gn"><span class="gn1">活跃指数：</span><span class="gn2"><i style="width:40%;"></i></span><span class="gn3">1223434</span></div>
        </li>
        <li>
        	<div class="hydr_img">
            	<a href="#"><img src="../images/new_pro/mr_temp08.jpg" alt=""/></a>
            </div>
            <div class="hydr_name"><a href="#">催恒 主任医师</a></div>
            <div class="hydr_gn"><span class="gn1">活跃指数：</span><span class="gn2"><i style="width:40%;"></i></span><span class="gn3">1223434</span></div>
        </li>
        <li>
        	<div class="hydr_img">
            	<a href="#"><img src="../images/new_pro/mr_temp08.jpg" alt=""/></a>
            </div>
            <div class="hydr_name"><a href="#">催恒 主任医师</a></div>
            <div class="hydr_gn"><span class="gn1">活跃指数：</span><span class="gn2"><i style="width:40%;"></i></span><span class="gn3">1223434</span></div>
        </li>
         <li>
        	<div class="hydr_img">
            	<a href="#"><img src="../images/new_pro/mr_temp08.jpg" alt=""/></a>
            </div>
            <div class="hydr_name"><a href="#">催恒 主任医师</a></div>
            <div class="hydr_gn"><span class="gn1">活跃指数：</span><span class="gn2"><i style="width:40%;"></i></span><span class="gn3">1223434</span></div>
        </li>
         <li>
        	<div class="hydr_img">
            	<a href="#"><img src="../images/new_pro/mr_temp08.jpg" alt=""/></a>
            </div>
            <div class="hydr_name"><a href="#">催恒 主任医师</a></div>
            <div class="hydr_gn"><span class="gn1">活跃指数：</span><span class="gn2"><i style="width:40%;"></i></span><span class="gn3">1223434</span></div>
        </li>
    </ul>
    </div>
</div>
<!--行业达人结束-->
<!--foot-->
<jsp:include page="../include/foot_photo.jsp"/>
<!--foot end-->
<script type="text/javascript">
	$('.mrfc_list li:lt(3) .mr_num').addClass('red_num')
	$('.mrfc_list li').hover(function(){
		$(this).addClass('mrfc_open').siblings().removeClass('mrfc_open');
	});
</script>
</body>
</html>