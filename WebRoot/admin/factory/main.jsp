<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Map factoryInfo = (Map)session.getAttribute("factoryInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>产品中心--工程机械--中国工程机械商贸网</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<!--[if (IE 6)]>
<link href="../style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body style="">
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a target="_blank" href="/">产品中心首页</a> &gt;&gt; 厂家管理</h3>
</div>
<!--面包屑结束--> 
<!--广告-->
<div class="contain980 mb10"><img src="/images/ad04.jpg" width="980" height="60" /></div>
<!--广告结束--> 
<!--main-->
<div class="contain980 mb10">
  <div class="w210 l">
    <div class="w208 border01 l leftPart mb10">
      <h2  title="<%=CommonString.getFormatPara(factoryInfo.get("full_name"))%>"><%=CommonString.getFormatPara(factoryInfo.get("full_name"))%></h2>
      <ul class="list13">
        <li><a href="/admin/factory/pro_product_form/pro_product_form_list.jsp" target="agentfac">订单管理</a></li>
        <li><a href="/admin/factory/pro_products/pro_products_list.jsp" target="agentfac">产品管理</a></li>
        <li><a href="/admin/factory/pro_agent_factory/pro_agent_factory_agent_list.jsp" target="agentfac">代理商信息</a></li>
        <li><a href="/admin/factory/pro_agent_factory/pro_agent_factory_fac_edit.jsp" target="agentfac">厂家资料</a></li>
            <li><a href="/admin/factory/pro_agent_factory/changepassword.jsp" target="agentfac">修改密码</a></li>
        <li><a target="_blank" href="/brand/<%=CommonString.getFormatPara(factoryInfo.get("usern"))%>/">我的首页</a></li>
        <li><a href="/action/exit.jsp?flag=1">退出登录</a></li>
      </ul>
    </div>
  </div>
  <div class="w757 r">
    <iframe width="100%" height="520" frameborder="No" name="agentfac" marginheight="0" marginwidth="0" border="0" src="/admin/factory/pro_product_form/pro_product_form_list.jsp"></iframe>
  </div>
  <div class="clear"></div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true" />
<!--end of foot-->

</body>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
</html>