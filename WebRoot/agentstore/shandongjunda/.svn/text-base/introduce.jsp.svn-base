<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;   // 栏目 
String factoryid_sub = CommonString.getFormatPara(request.getParameter("factoryid_sub")) ; // 品牌 id
String sel_sql = " select catalogname from pro_factory_category where factoryid=? and num =?" ;
DBHelper dbHelper = DBHelper.getInstance() ;
//选出所有的类别
String sel_sql2 = " select num,catalogname from dbo.pro_factory_category where factoryid=1236 order by id" ;
List<Map> catalogList = dbHelper.getMapList(sel_sql2) ;
String catalogname = "" ;
if(null!=catalogList && catalogList.size()>0){
	for(Map oneMap:catalogList){
		if(catalognum.equals(CommonString.getFormatPara(oneMap.get("num")))){
			catalogname = CommonString.getFormatPara(oneMap.get("catalogname")) ;
			break ;
		}
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>山东骏大官方旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="山东骏大,山东骏大产品报价,山东骏大产品,山东骏大产品图片,山东骏大介绍,山东骏大代理商" />
<meta name="description" content="中国工程机械商贸网为您提供山东骏大介绍,山东骏大产品介绍,山东骏大产品报价,山东骏大产品图片,山东骏大产品展示等山东骏大产品信息，帮助您全面了解山东骏大。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<div class="shop_topbg">
  <div class="contain980">
    <h2><img src="images/new_shop_logos.jpg" alt="山东骏大" width="373" height="80" />山东骏大官方旗舰店</h2>
    <div class="shop_tel">
      客服热线：<em>400-618-6777</em>
    </div>
    <div class="clear"></div>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/new_shop_bm.png" alt="收藏本店铺" width="117" height="40" /></a></div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li style="background:none;"><a href="./">首 页HOME</a></li>
      <li><a href="index.jsp#hot_rec">热销推荐HOT</a></li>
      <li><a href="index.jsp#excavator">挖掘机EXCAVATOR</a></li>
      <li><a href="introduce.jsp" class="selected">公司介绍ABOUTUS</a></li>
    </ul>
  </div>
</div>
<!--main-->
<div class="shopPart03">
  <div class="contain980 pt20 clearfix">
    <div class="shopContain">
      <div class="shopLeftPart">
        <div class="shopIntro">
          <div class="title">
            <h2>联系方式</h2>
          </div>
          <div class="content">
            <ul>
              <li>商　　家：<strong class="name">山东骏大官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：山东</li>
              <li>客服电话：400-618-6777</li>
              <li>销售热线：0531-88264899</li>
              <li>投诉电话：96001678</li>
              <li>总部地址：济南市黄河大桥北308国道107号</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
          </div>
        </div>
      </div>
      <div class="shopRightPart">
      
        <div class="listBanner"><img src="images/listbanner.jpg" width="670" height="168" /></div>
        
        <div class="introTitle"><img src="images/intro_title.gif" alt="公司简介" width="328" height="50" /></div>
        
        <div class="intro_text">
             <strong class="sbiaoyu">山东骏大—工程机械服务专家</strong>
           　　山东骏大集团是国内知名的工程机械代理运营企业和专业的维修服务提供商，是现代挖掘机，现代装载机，康明斯、洋马、潍柴发动机，力博士破碎器等产品山东省总代理。<br />
　　公司集“整机销售、售后服务、配件供应、二手机交易、大修翻新、租赁、驾驶培训”于一体，拥有六家子公司，33个分公司，58个办事处，秉承“帮助用户创造财富，做工程机械服务专家”的企业理念和“服务是我们的唯一产品，用户满意是服务的标准”的服务理念，为社会、为客户、为企业、为员工、为股东创造更多的回报。
        </div>
      </div>
    </div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<div class="flagshopbg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot-->
<script type="text/javascript">
jQuery(function(){
	jQuery(".shopPros01 li").hover(function(){ 
		jQuery(this).toggleClass("hover");
	},function(){
		jQuery(this).removeClass("hover");
	});
})
</script>
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
  try{
       window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
   }catch (e){
       try{
           window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com', '江苏华通动力重工官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('江苏华通动力重工官方旗舰店', 'http://product.21-sun.com',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
DK.load('scripts/core.js', function(){ 
	DK.index.init();
});
</script> 
</body>
</html>