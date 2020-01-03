<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
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
<title>雷沃装载机_雷沃装载机品牌专区 - 铁臂商城</title>
<meta name="keywords" content="雷沃装载机,雷沃装载机报价,雷沃装载机,雷沃装载机图片,雷沃装载机介绍,雷沃装载机介绍" />
<meta name="description" content="铁臂商城为您提供雷沃装载机介绍,雷沃装载机介绍,雷沃装载机报价,雷沃装载机图片,雷沃装载机展示等雷沃装载机信息，帮助您全面了解雷沃装载机。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body class="flag_shop channel_content">
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
              <li>商　　家：<strong class="name">福田雷沃官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：山东</li>
              <li>服务电话：400-8293-888</li>
              <li>联系电话：+86-536-7638388</li>
              <li>传　　真：+86-536-2288631</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
          </div>
        </div>
      </div>
      <div class="shopRightPart">
      
        <div class="listBanner"><img src="images/listbanner.jpg" width="690" height="250" /></div>
        
        <div class="strongTitle">
          <h2><span>关于雷沃</span></h2>
        </div>
        
        <div class="intro_text">
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;福田雷沃国际重工股份有限公司（简称福田雷沃重工），成立于1998年，从收获机械业务起步，目前已经发展成为农业装备、工程机械、车辆、核心零部件、金融、房地产等业务为主体的大型产业装备制造企业，2012年实现销售收入186.3亿元，同比增长16.4%；2013年上半年销售收入突破百亿元。2013年，凭借在“内涵增长、结构调整、全球化”方面的卓越表现，“雷沃”品牌评估价值攀升至215.58亿元，成为近年来品牌价值增长速度最快的品牌之一。公司被认定为“国家重点高新技术企业”，公司工程技术研究院被认定为“国家认定企业技术中心”，公司主导产品曾被认定为“中国名牌”、“中国驰名商标”、“最具市场竞争力品牌”。 

　　<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;福田雷沃重工主导产品雷沃谷神联合收割机销量（自2001年起）连续13年居行业首位，市场占有率达70%；雷沃大中型拖拉机（自2005年起）连续9年市场占有率行业领先。福田五星三轮摩托车连续7年销量、市场占有率行业第一；以雷沃装载机、挖掘机、旋挖钻机为代表的雷沃工程机械业务高速、健康发展，市场竞争力持续攀升，成为行业内成长最快的品牌之一。

　　<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;近年来，公司在“内涵增长、结构调整、全球化”经营方针指引下，积极搭建基于未来国际化发展的业务管理和运行平台，促使工程机械、农业装备、车辆三大产业实现了均衡快速发展。
<br />

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在国内多个市场领域获得领先地位的基础上，福田雷沃重工积极开拓国际市场。目前，公司已建成了由300多家销售服务商组成的覆盖全球120多个国家和地区的集“销售、服务、配件供应、用户培训与信息反馈”五位一体的全球营销服务网络体系，出口产品涵盖农业装备、工程机械、车辆三大产业。
<br />

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;面向未来，福田雷沃重工将以中国为中心，保持中国市场领导者地位，把中国打造成全球非公路业务产业中心，在全球三个重点国家实现产业化，在两个发达地区市场取得市场突破，实现从区域性企业向全球性企业转变。力争通过10年努力，把福田雷沃重工打造成世界级主流机械装备制造企业。<br />
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
jQuery("body").bind("contextmenu", function() {
  return false;
});
DK.load('scripts/core.js', function(){ 
	DK.index.init();
});
</script> 
</body>
</html>