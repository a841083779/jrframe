<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;   // 栏目 
String factoryid_sub = CommonString.getFormatPara(request.getParameter("factoryid_sub")) ; // 品牌 id
String sel_sql = " select catalogname from pro_factory_category where factoryid=? and num =?" ;
DBHelper dbHelper = DBHelper.getInstance() ;
//选出所有的类别
String sel_sql2 = " select num,catalogname from dbo.pro_factory_category where factoryid=152 order by id" ;
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

//厂家信息
Map m = dbHelper.getMap("select * from pro_agent_factory where id = '152'");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>关于山建_山重建机_山重建机品牌专区 - 中国工程机械商贸网</title>
<meta name="keywords" content="山重建机,山重建机挖掘机报价,山重建机挖掘机,山重建机挖掘机图片,山重建机挖掘机介绍,山重建机介绍" />
<meta name="description" content="中国工程机械商贸网为您提供山重建机介绍,山重建机挖掘机介绍,山重建机挖掘机报价,山重建机挖掘机图片,山重建机挖掘机展示等山重建机挖掘机信息，帮助您全面了解山重建机。" />
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
  <div class="contain980 clearfix">
    <div class="shopContain">
      <div class="shopLeftPart">
        <div class="shopIntro">
          <div class="title">
            <h2>联系方式</h2>
          </div>
          <div class="content">
            <ul>
              <li>商　　家：<strong class="name"><%=CommonString.getFormatPara(m.get("name"))%>官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：<%=CommonString.getFormatPara(m.get("address"))%></li>
              <li>服务电话：400-000-1000</li>
              <li>联系电话：0086-0539-8152370</li>
              <li>传　　真：0086-0539-8162158</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
          </div>
        </div>
      </div>
      <div class="shopRightPart">
        <div class="listBanner"><img src="images/listbanner01.jpg" width="690" height="220" /></div>
        <div class="strongTitle">
          <h2><span>关于山建</span></h2>
        </div>
        <div class="intro_text"><%=CommonString.getFormatPara(m.get("introduce"))%>　 </div>
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
jQuery("body").bind("contextmenu", function() {
  return false;
});
DK.load('scripts/core.js', function(){ 
	DK.index.init();
});
</script>
</body>
</html>