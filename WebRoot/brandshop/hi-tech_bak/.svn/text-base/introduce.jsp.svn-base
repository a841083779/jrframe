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
<title>烟台普堃官方旗舰店 - 铁臂商城</title>
<meta name="keywords" content="烟台普堃,烟台普堃产品报价,烟台普堃产品,烟台普堃产品图片,烟台普堃介绍,烟台普堃代理商" />
<meta name="description" content="铁臂商城为您提供烟台普堃介绍,烟台普堃产品介绍,烟台普堃产品报价,烟台普堃产品图片,烟台普堃产品展示等烟台普堃产品信息，帮助您全面了解烟台普堃。" />
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
<jsp:include page="top.jsp" flush="true"></jsp:include>
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
              <li>商　　家：<strong class="name">烟台普堃官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：山东</li>
              <li>24小时服务电话：400-666-2850</li>
              <li>联系电话：0535－3451876</li>
              <li>传　　真：0535－3451870</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
          </div>
        </div>
      </div>
      <div class="shopRightPart">
      
        <div class="listBanner"><img src="images/listbanner.jpg" width="690" height="250" /></div>
        
        <div class="pukunTitle">
          <h2><span>公司简介</span></h2>
        </div>
        
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