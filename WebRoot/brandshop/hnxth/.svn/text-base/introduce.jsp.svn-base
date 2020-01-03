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
<title>新天和官方旗舰店 - 铁臂商城</title>
<meta name="keywords" content="新天和,新天和产品报价,新天和产品,新天和产品图片,新天和产品介绍,新天和介绍" />
<meta name="description" content="铁臂商城为您提供新天和介绍,新天和产品介绍,新天和产品报价,新天和产品图片,新天和产品展示等新天和产品信息，帮助您全面了解新天和。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop01.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body class="flag_shop shopList">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<div class="shop_topbg">
  <div class="contain980">
    <h2><img src="images/new_shop_logos.png" alt="湖南新天和官方旗舰店" width="409" height="100" /></h2> 
    <span class="l" style="padding-top:45px;"><img src="/images/ico.gif" /></span>
    <div class="shop_tel">湖南新天和客服热线：0731-52825566<br />营销热线：0731-52825569 　13875985255</div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li style="background:none;"><a href="./" class="<%=catalognum.equals("")?"selected":"" %>">首页HOME</a></li>
      <%
      if(null!=catalogList && catalogList.size()>0){
    	  for(Map oneMap:catalogList){
        		%>
        		<li><a href="list.jsp?num=<%=CommonString.getFormatPara(oneMap.get("num")) %>" class="<%=CommonString.getFormatPara(oneMap.get("num")).equals(catalognum)?"selected":"" %>"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></li>
        		<%
        	}
      }
      %>
    </ul>
    <a class="qq" href="javascript:;" onclick="addShop();return false ;"><img src="images/new_shop_bm.gif" alt="收藏本店铺" width="128" height="30" /></a>
  </div>
</div>
<!--main-->
<div class="listPart">
  <div class="contain980 pt20 clearfix">
    <div class="shopContain clearfix">
      <div class="shopLeftPart">
        <h2>产品分类</h2>
        <ul class="shopListMenu">
          <%
          	if(null!=catalogList && catalogList.size()>0){
          		for(int i=0;i<catalogList.size();i++){
          			Map oneMap = catalogList.get(i) ;
          			%>
          			 <li class="<%=catalognum.equals(CommonString.getFormatPara(oneMap.get("num")))?"select":"" %>"><a href="list.jsp?num=<%=CommonString.getFormatPara(oneMap.get("num")) %>"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></li>
          			<%
          		}
          	}
          %>
        </ul>
        
        <div class="shopIntro">
          <div class="title">
            <h2>店铺介绍</h2>
          </div>
          <div class="content">
            <p class="intro">
              <strong class="name">湖南新天和工程设备有限公司</strong>
              <a href="introduce.jsp" target="_blank" style="color:#434343;">位于国家级经济技术开发区--湖南湘潭九华示范区，占地100亩，注册资本2800万元，专业研发、生产、销售高性能、环保型工程机械产品，自营机械设备进出口业务。主要产品有</a>
              <span class="more"><a href="introduce.jsp" target="_blank">更多&gt;&gt;</a></span>
            </p>
            <ul>
              <li>商　　家：<strong class="name">新天和官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：湖南</li>
              <!--<li>服务电话：0731-52825555</li>-->
              <li>营销热线：0731-52825569</li>
              <li>售后热线：0731-52825566</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
            <div class="clearfix" style="padding:5px 20px;">
              <!-- <span class="l"><a href="javascript:;" onclick="addShop();">收藏店铺</a></span>-->
              <!-- <span class="r"><a href="/brand/hnxth/" target="_blank">关注店铺</a></span>  -->
            </div>
          </div>
        </div>
        
      </div>
      <div class="shopRightPart">
        <div class="listBanner">
        <a href="/brandshop/hnxth/" target="_blank" title="湖南新天和工程设备有限公司">
        <img src="images/listbanner.jpg" width="650" height="210" />
        </a>
        </div>
        <div class="intro_text">
           <div style="width:650px;">　 湖南新天和工程设备有限公司位于国家级经济技术开发区--湖南湘潭九华示范区，占地100亩，注册资本2800万元，专业研发、生产、销售高性能、环保型工程机械产品，自营机械设备进出口业务。主要产品有：ZYC系列多功能液压静力压桩机(40t～1200t)、CFG系列液压步履式长螺旋钻机、JBY系列液压步履式桩架、LGZ系列液压步履式螺杆桩机、SMW工法桩机、WB系列沥青路面微波养护机共六大系列五十多种规格型号。其中ZYC系列多功能液压静力压桩机全国销量第二。
　 公司所有产品定位高端市场，配置、性能超群，全力打造业内最受尊敬的企业。<br/>
　 公司被认定为“高新技术企业”，拥有十三项专利，其中三项发明专利，通过了ISO9001:2008质量体系认证；液压静力压桩机获欧盟CE认证。公司获得《湖南省著名商标》、《湖南省质量信用A级企业》、《全国桩机产品质量合格企业》、《质量诚信消费者（用户）信得过单位》、《AAA级质量诚信会员单位》、《中国市场诚信单位》等众多荣誉称号。多项产品被列入国家火炬计划和省、市重点科技项目计划，并申报国家创新基金。产品畅销全国,出口到东南亚和欧洲等国家和地区, 深受用户欢迎。<br/>
　 公司现有员工210多人，拥有专业生产厂房16250㎡，综合办公楼3300㎡，已形成年产各类桩工机械设备400台以上，产值达5亿元的生产规模。二期工程建成后可形成年产各类桩工机械产品600台以上，年产值可达8～10亿元的生产规模。计划5年内使公司发展成为具有国内外较强竞争力的工程机械厂家，迅速将产业做大做强，并树立国际品牌。
           </div>
        </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<div class="footbg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot-->
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com', '湖南新天和官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('湖南新天和官方旗舰店', 'http://product.21-sun.com',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>