<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Map agentInfo = (Map)session.getAttribute("agentInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>产品中心--工程机械--中国工程机械商贸网</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<!--[if (IE 6)]>
<link href="../style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a target="_blank" href="/">产品中心首页</a> &gt;&gt; 代理商管理</h3>
</div>
<!--面包屑结束--> 
<!--广告-->
<div class="contain980 mb10"><img src="/images/ad04.jpg" width="980" height="60" /></div>
<!--广告结束--> 
<!--main-->
<div class="contain980 mb10">
  <div class="w210 l">
    <div class="w208 border01 l leftPart mb10">
      <h2 style="white-space:nowrap; text-overflow:ellipsis; overflow:hidden;" title="<%=CommonString.getFormatPara(agentInfo.get("full_name"))%>"><%=CommonString.getFormatPara(agentInfo.get("full_name"))%></h2>
      <ul class="list13">
        <li><a href="/admin/agent/pro_product_form/pro_product_form_list.jsp" target="agentfac">订单管理</a></li>
        <li><a href="/admin/agent/pro_agent_products/pro_agent_products_list.jsp?id=<%=CommonString.getFormatPara(agentInfo.get("id")) %>" target="agentfac">代理产品管理</a></li>
        <li><a href="/admin/agent/pro_agent_factory/pro_agent_factory_agent_edit.jsp" target="agentfac">公司资料</a></li>
        <li><a href="/admin/agent/pro_agent_factory/changepassword.jsp" target="agentfac">修改密码</a></li>
        <li><a target="_blank" href="/agent/<%=CommonString.getFormatPara(agentInfo.get("usern"))%>/">我的首页</a></li>
        <li><a href="/action/exit.jsp?flag=2">退出登录</a></li>
      </ul>
    </div>
  </div>
  <div class="w757 r">
    <iframe width="100%" height="495" frameborder="No" name="agentfac" marginheight="0" marginwidth="0" border="0" src="/admin/agent/pro_product_form/pro_product_form_list.jsp"></iframe>
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