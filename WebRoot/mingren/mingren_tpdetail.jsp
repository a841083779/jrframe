<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.common.*"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String id = CommonString.getFormatPara(request.getParameter("id")) ; // 一条产品订单的id
	
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map m = dbHelper.getMap(" select * from pro_famous_person where id=?",new Object[]{id}) ;
	if(m == null){
		response.setStatus(301);
		response.setHeader("Location", "/mingren/"); 
		return;	
	}
	List <Map>l = dbHelper.getMapList(" select * from pro_famous_person_pic where product_id = ? ",new Object[]{id});

%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=CommonString.getFormatPara(m.get("name"))%>图片 - 铁臂名人堂</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(m.get("name"))%>图片,<%=CommonString.getFormatPara(m.get("name"))%>" />
<meta name="description" content="铁臂名人堂为您提供大量高清<%=CommonString.getFormatPara(m.get("name"))%>图片，找<%=CommonString.getFormatPara(m.get("name"))%>图片，就上铁臂名人堂。" />
<style type="text/css">
*{ margin:0; padding:0;}
img { border:0;}
body { background-color:#40454e; font-size:12px; font-family:"Microsoft Yahei"; color:#a7b2bc; height:100%;}
ul,li { list-style-type:none;}
a { color:#67b0fc; text-decoration:none;}
/*style*/
.photoBar { width:100%; height:42px; line-height:42px; border-bottom:1px solid #161a1e; background-color:#2e3239; position:fixed; left:0px; top:0px; z-index:100;}
.p_logo { font-size:20px; float:left; padding-left:15px; margin-right:15px;}
.breadcrumb { width:auto; float:left; font-size:14px;}
.breadcrumb .album-name { padding-left:30px; background:url(/images/picdialog.png) no-repeat 5px 4px}
.return-back{height:28px;width:60px;cursor:pointer;padding-left:10px;padding-right:17px;line-height:28px;float:right;text-decoration:none;text-align:center;border:1px solid #23252a;background:#3b4048 url(/images/back-arrow.png) no-repeat 74px center;font-size:14px;color:#a8b2bd;margin-top:6px;margin-right:20px}
.photo_main { width:100%; height:100%; position:absolute; left:0px; top:0px;}
.photo_img { width:100%; height:100%; position:absolute; left:0px; top:0px;}
.photo_img .pimg { width:400px; height:300px; position:absolute; left:50%; top:50%; margin:-150px 0px 0px -200px;}
.footer-wrap { width:960px; height:24px; position:absolute; left:50%; bottom:20px; margin-left:-480px;}
.footer-wrap .description { text-align:center; height:24px; line-height:24px;}
.footer-wrap .description .text { font-size:16px;}
.footer-wrap .tool-button { width:autol; height:24px; line-height:24px; position:absolute; right:0px; top:0px; padding-left:30px; background:url(/images/picdialog.png) 0 -30px no-repeat; color:#a8b2bd;}
.thumb_imgs { width:84px; height:475px; position:absolute; right:12.5%; top:50%; margin-top:-237px; margin-right:-80px;}
.thumb_imgs .prev,.thumb_imgs .next { display:block;width:80px;height:29px;cursor:pointer;background:url(/images/picture-dialog.png) no-repeat 0 -142px; margin:2px auto;}
.thumb_imgs .next { background-position:0px -244px;}
.thumb_imgs .bd { width:84px; height:410px; position:relative; overflow:hidden;}
.thumb_imgs .bd li { width:80px; height:60px; float:left; margin-bottom:4px; border:#40454e 2px solid;}
.thumb_imgs .bd li.on { border-color:#519cea;}
.thumb_imgs .bd img { width:80px; height:60px;}
/*style end*/
</style>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/superslide.js"></script>
</head>
<body>
<div class="photoBar">
  <a href="http://product.21-sun.com/" target="_blank"><h2 class="p_logo">铁臂商城</h2></a>
  <div class="breadcrumb"><%=CommonString.getFormatPara(m.get("name"))%>图册</div>
  <a href="/mingren_detail_<%=id%>.htm" class="return-back">返回词条</a>
</div>
<jsp:include page="/mingren/tongji.jsp"/>

<div class="photo_main">
  <div class="photo_img"><%for(int i = 0;l != null && i<=0;i++){%><img src="<%=CommonString.getFormatPara(l.get(i).get("img_name"))%>" width="400" height="300" class="pimg" alt="<%=CommonString.getFormatPara(m.get("name"))%>"/><%}%></div>
  <div class="footer-wrap">
    <div class="description">
      <!--<span class="pageState"></span>-->
      <span class="text"><%=CommonString.getFormatPara(m.get("name"))%></span>
    </div>
  </div>
  <div class="thumb_imgs">
  <a href="javascript:void(0);" class="prev"></a>
  <div class="bd">
    <ul>
    <%for(int i = 0;l != null && i<l.size();i++){%>
      <li <%if(i==0){%>class="on"<%}%>><a href="<%=CommonString.getFormatPara(l.get(i).get("img_name"))%>"><img src="<%=CommonString.getFormatPara(l.get(i).get("img_name"))%>" alt="<%=CommonString.getFormatPara(m.get("name"))%>" width="161" height="120"></a></li>
    <%}%>
    </ul>
  </div>
  <a href="javascript:void(0);" class="next"></a>
</div>
</div>
</body>
<script type="text/javascript">
$(".photo_main").slide({ mainCell:".bd ul",effect:"topLoop",vis:6,scroll:1,autoPlay:false});
$('.thumb_imgs .bd a').click(function(){
	$('.photo_img .pimg').attr('src',$(this).attr('href'));
	$('.footer-wrap .origin').attr('href',$(this).attr('href'));
	$(this).parent().addClass('on').siblings().removeClass('on');
	return false;
})
</script>
</html>