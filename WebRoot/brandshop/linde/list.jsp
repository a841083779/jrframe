<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.common.CommonHtml,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
   	DBHelper dbHelper = DBHelper.getInstance() ;
	String catalog=CommonString.getFormatPara(request.getParameter("catalog")); 
    //产品列表
	String pro_sql = "select  id,name,file_name,img2,catalogname_spe,catalognum_spe,zoomlion_hot_pic ,catalogname from pro_products where factoryid=1742 and is_show=1 and catalognum like '"+catalog+"%'  order by id desc" ;
	List<Map> newProductsList = null ;
	newProductsList = dbHelper.getMapList(pro_sql) ;
   //公司信息
   String  company="select introduce from pro_agent_factory where id=1742";
   List<Map> companyInfo = null ;
   companyInfo = dbHelper.getMapList(company) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>林德(中国)叉车有限公司_中国工程机械商贸网</title>
<meta name="keywords" content="林德,林德叉车产品报价林德叉车产品林德叉车产品图片林德叉车产品介绍林德叉车介绍" />
<meta name="description" content="中国工程机械商贸网为您提供江苏华通介绍林德叉车产品介绍林德叉车产品报价林德叉车产品图片林德叉车产品展示等林德叉车产品信息，帮助您全面了解林德叉车。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if IE 6]><script src="/scripts/pngfix.js">/* s,i,.pngfix,.pngimg img */</script><![endif]-->
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"></jsp:include>
<div class="shopWrap fix channelBox">
  <!--left-->
  <div class="channelLeft">
    <div class="hd">
      <strong>所有产品分类&gt;&gt;</strong>
    </div>
    <div class="bd">
      <ul class="shopListMenu">
        <li <%if(catalog.equals("107001")){%>class="select"<%}%>><a href="/brandshop/linde/list.jsp?catalog=107001">林德内燃叉车</a></li>
        <li <%if(catalog.equals("107003")){%>class="select"<%}%>><a href="/brandshop/linde/list.jsp?catalog=107003">林德电动叉车</a></li>
        <li <%if(catalog.equals("107005")){%>class="select"<%}%>><a href="/brandshop/linde/list.jsp?catalog=107005">林德仓储叉车</a></li>
        <li <%if(catalog.equals("118004")){%>class="select"<%}%>><a href="/brandshop/linde/list.jsp?catalog=118004">林德牵引车</a></li>
      </ul>
      <div class="box">
        <h3 class="t">店铺介绍</h3>
        <div class="intro">
          <strong class="t">林德(中国)叉车有限公司</strong>
          <p>
1993年成立于厦门，是林德物料搬运在亚洲的生产、销售、服务及技术支持基地，总投资17亿人民币，占地面积22万平方米，林德(中国)向市场提供全系列的平衡重及仓储等叉车，专业...
          </p>
          <div class="more"><a href="about.jsp">更多&gt;&gt;</a></div>
        </div>
      </div>
    </div>
  </div>
  <!--right-->
  <div class="channelRight">
    <div class="hd">
      <strong>
	  <%if(catalog.equals("107001")){%> 林德内燃叉车<%}%>
	  <%if(catalog.equals("107003")){%> 林德电动叉车<%}%>
	  <%if(catalog.equals("107005")){%> 林德仓储叉车<%}%>
	  <%if(catalog.equals("118004")){%> 林德牵引车<%}%>
	  </strong>
    </div>
    <div class="bd">
      <div class="proList01">
        <ul class="fix">
		<%
			if(null!=newProductsList && newProductsList.size()>0){
				Map oneMap = null ;
				for(int i=0;i<newProductsList.size();i++){
					oneMap = (HashMap)newProductsList.get(i);
		%>
          <li>
            <div class="img"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">
			<img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>" /></a></div>
            <h3><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank">林德<%=CommonString.getFormatPara(oneMap.get("name")) %><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></h3>
            <span class="links"><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")  %>_parameter.shtm" target="_blank">参数</a> | <a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2" target="_blank">评论</a></span>
            <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','1742');" class="priceBtn">立即询价</a>
          </li>
       <%}}%>
        </ul>  
      </div>
    </div>
  </div>
</div>
<!--foot-->
<div class="bottombg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot--> 
<script type="text/javascript">
function addShop(){　 // 收藏店铺
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/linde/', '林德(中国)叉车有限公司');
   }catch (e){
       try{
           window.sidebar.addPanel('林德(中国)叉车有限公司','http://product.21-sun.com/brandshop/linde/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
</body>
</html>