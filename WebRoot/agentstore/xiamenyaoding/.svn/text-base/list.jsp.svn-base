<%@ page language="java" import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	DBHelper dbHelper = DBHelper.getInstance() ;	
	List<Map> productsList = new ArrayList() ;
	String sql = "select * from pro_agent_product_vi where agentid=15864 and factoryid=139 and id<>'20365' and is_show=1" ; 
	productsList = dbHelper.getMapList(sql+"order by order_no") ;
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>厦门市尧鼎机械有限公司_中国工程机械商贸网</title>
<meta name="keywords" content="厦门尧鼎,厦工挖掘机产品报价厦工挖掘机产品厦工挖掘机产品图片厦工挖掘机产品介绍厦工挖掘机介绍" />
<meta name="description" content="中国工程机械商贸网为您提供厦门市尧鼎机械有限公司介绍厦工挖掘机产品介绍厦工挖掘机产品报价厦工挖掘机产品图片厦工挖掘机产品展示等厦工挖掘机产品信息，帮助您全面了解厦工挖掘机。" />
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
   
    <div class="bd">    
      <div class="box">
        <h3 class="t">店铺介绍</h3>
        <div class="intro">
          <strong class="t">厦门市尧鼎工程机械有限公司</strong>
          <p>
厦门市尧鼎工程机械有限公司成立于2010年4月，专业代理厦工品牌工程机械产品，是厦门厦工机械股份有限公司挖掘机福建区域代理商。公司总部位于厦工股份有限公司的生产发源地——厦门市，设有综合管理部、市场企划部、财务部、债权管理部、整机销售部、售后服务部、配件部等部门，在部分代理区域内设有二级经销商，并且在漳州、泉州、三明、南平等区域设有办事处，自公司成立以来，以良好的企业形象及信誉赢得了广大用户的支持和信赖。</p>
        </div>
      </div>
    </div>
  </div>
  <!--right-->
   <div class="r plist" style=" width:735px;">
    <ul class="fix" style=" width:800px;">
    <%
    if(productsList!=null && productsList.size()>0){
    	for(Map m:productsList){
    		String id = CommonString.getFormatPara(m.get("id"));
    		String file_name = CommonString.getFormatPara(m.get("file_name"));
    		String name = CommonString.getFormatPara(m.get("name"));
    		String catalogname = CommonString.getFormatPara(m.get("catalogname"));
    		String factoryname = CommonString.getFormatPara(m.get("factoryname"));
    		String img2 = CommonString.getFormatPara(m.get("img2"));
    		String factoryid = CommonString.getFormatPara(m.get("factoryid"));
    %>
      <li><a href="/proDetail/<%=file_name %>" title="<%=factoryname+name+catalogname %>" target="_blank"><img src="/uploadfiles<%=img2 %>" width="222" height="157" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" alt="<%=factoryname+name+catalogname %>"><strong><%=factoryname+name+catalogname %></strong></a><a href="javascript:void(0);" onclick="showinquery('<%=id %>','')"><img src="images/1_10.png" /></a></li>
    <%}} %>
    </ul>
  </div>
</div>
<!--foot-->
<div class="bottombg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot--> 
<script type="text/javascript">
function addShop(){// 收藏店铺
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/', '厦门市尧鼎机械有限公司');
   }catch (e){
       try{
           window.sidebar.addPanel('厦门市尧鼎机械有限公司','http://product.21-sun.com/brandshop/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
</body>
</html>