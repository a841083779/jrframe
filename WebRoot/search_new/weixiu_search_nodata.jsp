<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
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
<link href="../style/new_style.css" rel="stylesheet" type="text/css" />
<link href="../weixiu/style/style.css" rel="stylesheet" type="text/css" />
<link href="../dealer/style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/friendly_link.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top_search.jsp" flush="true"/>
<!--top end--> 
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">搜索结果</a> &gt;&gt; <a href="/products/">挖掘机</a> </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980">
  <div class="nser_nots mb10">非常抱歉，没有找到与"<span>-</span>"相关的维修信息</div>
        <jsp:include page="/include/search/weixiu_info_list.jsp" flush="false"/>
        <jsp:include page="/include/search/weixiu_pro_list.jsp" flush="false"/>
        <jsp:include page="/include/search/weixiu_agent_list.jsp" flush="false"/>
</div>
<!--main end--> 
<!--foot search 有搜索结果时出现-->
<div class="contain980">
  <div class="telTip">如果没有找到您的信息，请直接致电：<strong>4006-521-526</strong></div>
  <script>
		  function tj(){
		  	  if(jQuery('#keywords').val()==''){
		     jQuery('#keywords').focus();
			 return false;
		  }
		  var keyword=jQuery('#keywords').val();
		  window.location.href="/search/"+keyword+"_0_0_0.htm";
		  }
		</script> 
</div>
<!--foot search 有搜索结果时出现结束--> 
<!--like--> 

<!--like end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--foot end--> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>