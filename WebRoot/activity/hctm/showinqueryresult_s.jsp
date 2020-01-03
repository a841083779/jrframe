<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.codec.binary.StringUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.jerehnet.util.business.OrderBusiness"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.Random"%>

<%
  
	String productid = CommonString.getFormatPara(request.getParameter("productid")) ;

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>在线询价</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/scripts.js"></script>

<style type="text/css">
body { padding: 5px 10px; font-family: 'Microsoft Yahei' }
.top_t { color: #4e5762; font-size: 18px; border-bottom: 1px solid #dfdfdf; padding-bottom: 7px; }
.top_t1 { font-size: 24px; height: 85px; line-height: 85px; font-weight: bold; border-bottom: 1px dashed #f1f1f2 }
.top_t1 .img { vertical-align: middle; margin-right: 10px; }
.list_t { font-size: 16px; font-weight: bold; margin-bottom: 10px; }
.list_t span { color: #fe6000 }
.tj li { float: left; width: 50%; margin-bottom: 1px; }
.tj li span { display: block; margin-bottom: 5px; }
.tj li span.n { color: #990000 }
.tj li input[type=checkbox] { vertical-align: middle; margin-right: 5px; }
.orderbg{ padding-bottom:5px; border-bottom:1px solid #dfdfdf; margin-bottom:5px;}
.orderbg .img { position: absolute; right: 20px; bottom: 50px; width: 210px; height: 45px; }
.xj_btn { width: 267px; height: 20px; background: url(images/xunjia.png) no-repeat; border: 0; cursor: pointer }
.STYLE1 { color: #FF0000 }
.jbox-close{ display:none !importent}
</style>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css">
</link>
<script type="text/javascript" src="/scripts/citys.js"></script>

</head>
<body>
<br/><br/>
<span style="font-weight: bold;font-size:2em">询价成功</span>
<br/><br/>
<div class="top_t1"><img src="images/succ1.png" width="74" height="77" class="img">您在<span style="color:red"><a style="color:red" href="http://product.21-sun.com/" target="_blank">铁臂商城</a></span>的询价已提交，<span ><a style="color:red"  target="_blank">宏昌天马</a></span>将联系您进行报价！</div>

</div>
</body>
<div style="display:none">
<script src="http://s11.cnzz.com/z_stat.php?id=1258677099&web_id=1258677099" language="JavaScript"></script>
</div>
</html>

