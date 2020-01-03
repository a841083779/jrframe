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
<title>沃尔华_沃尔华品牌专区 - 铁臂商城</title>
<meta name="keywords" content="沃尔华,沃尔华挖掘机报价,沃尔华挖掘机,沃尔华挖掘机图片,沃尔华挖掘机介绍,沃尔华介绍" />
<meta name="description" content="铁臂商城为您提供沃尔华介绍,沃尔华挖掘机介绍,沃尔华挖掘机报价,沃尔华挖掘机图片,沃尔华挖掘机展示等沃尔华挖掘机信息，帮助您全面了解沃尔华。" />
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
<jsp:include page="top.jsp" flush="true">
 <jsp:param value="0" name="topflag"/>
</jsp:include>
<!--main-->
<div class="shopPart03">
  <div class="contain980 pt20 clearfix">
    <div class="w100 l" style="background-color:#fff;">
      <div class="shopLeftPart">
        <div class="shopIntro">
          <div class="title">
            <h2>店铺介绍</h2>
          </div>
          <div class="content">
            <p class="intro">
              <strong class="name">沃尔华集团有限公司</strong>
              <a href="introduce.jsp" target="_blank" style="color:#434343;">沃尔华集团有限公司坐落于素有孔孟之乡的山东省济宁市，诚信为本培育了沃尔华公司的经营文化，深厚的中华文化底蕴铸就了沃尔华人朴实勤劳的工作作风。作为中国五大工程机械产业基地之一的济宁...</a><span class="more"><a href="introduce.jsp" target="_blank">更多&gt;&gt;</a></span>
            </p>
            <ul>
              <li>商　　家：<strong class="name">沃尔华官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：山东</li>
              <li>24小时服务电话：400-666-2850</li>
              <li>联系电话：0535－3451876</li>
              <li>传　　真：0535－2161737</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
          </div>
        </div>
      </div>
      <div class="shopRightPart">
      
        <div class="listBanner"><img src="images/listbanner.jpg" width="690" height="176" /></div>
        
        <div class="pukunTitle">
          <h2><span>公司介绍</span></h2>
        </div>
        
        <div class="intro_text">
        
          <p>&#12288;&#12288;<strong>沃尔华集团有限公司</strong>坐落于素有孔孟之乡的山东省济宁市，诚信为本培育了沃尔华公司的经营文化，深厚的中华文化底蕴铸就了沃尔华人朴实勤劳的工作作风。作为中国五大工程机械产业基地之一的济宁，不仅拥有像山推和日本小松这样的工程机械行业的大型企业，而且更有众多的中小型配套件生产厂。得天独厚的环境优势造就了沃尔华的崛起，在七年多的公司历程中吸引和培养了一大批工程机械的专业人才。</p>
  <p style="text-align: center"><br>
    <img src="http://resource.jereh-network.com/10260/10081617114917_0.jpg" alt=""></p>
  <p style="text-align: left"><br>
    &#12288;&#12288;沃尔华集团公司，是按照现代化企业标准建立的高新技术企业，总投资7.5亿元，占地面积237亩，建有现代化厂房80000余平方米，技术研究中心及综合办公大楼8000余平方米，是集研发、生产、销售为一体的液压挖掘机、工程机械配件及液压泵阀的专业生产企业。是目前国内极少集整机、配件和液压泵阀系统生产于一体的企业之一，为逐步形成公司先进的核心技术打下了坚实的基础。集团现有员工657人（其中研发人员45人），公司管理人员均具有大学本科以上学历，具有较高的管理水平。<br>
    <br>
    <strong>&#12288;&#12288;公司以液压挖掘机和液压多路阀作为主导产品，有着先进的技术和广阔的市场前景：<br>
    </strong>&#12288;&#12288;自主研发的多功能液压挖掘机包括：DLS865-9A四驱轮式、DLS880-9A四驱轮式、DLS100-9A四驱轮式、DLS865-9B型履带式、DLS880-9B型履带式、DLS100-9B型履带式、DLS130-9型履带式、DLS160-9型履带式等八大系列二十多个品种。<br>
    该系列挖掘机具有挖掘、破碎、钻孔、抓举等多项功能，产品采用了德国力士乐核心技术，提高了生产的设计水平，适合工作于各种复杂的地面环境，广泛应用于建筑业、工业、农业和军事领域，并以高效率和高可靠性而著称。随着国家扩大内需的政策逐步落实到位，挖掘机市场越来越好，集团面临良好的发展机遇。</p>
  <p style="text-align: center"><br>
    <img src="http://resource.jereh-network.com/10260/13040310313883_0.jpg" alt=""></p>
  <p style="text-align: left"><br>
    &#12288;&#12288;随着国民经济的发展，在港口、船舶、发电、环保、航空、航天、铁路、机车车辆、医药、印刷以及游艺行业等对液压产品也有大量的需求。液压传动技术已成为工业机械、工程建筑机械及国防尖端产品不可缺少的重要技术。而其向自动化、高精度、高效率、高速化、高功率、小型化、轻量化方向发展，是不断提高它与电传动、机械传动竞争能力的关键。目前，我国多路阀市场多被国外产品所垄断，特别是大吨位的工程机械。为此开发新技术、新产品，打破被国外产品所垄断，形成自主知识产权的多路阀产品是市场的迫切需求。自主研制的16通径、22通径和32通径高压大流量整体式多路阀（液压系统），以德国力士乐技术为基础，采用当今国际流行的设计理念，研制出的产品具有压力高、流量大、体积小、结构紧凑、无外渗漏、寿命长和环保等特点，在国内同行业中处于领先地位。自主创新的液压件项目能够带动省内机械元件的全面升级，拥有自主知识产权，其技术达到国内先进水平，在某些方面填补了国内空白，并且同类产品与国外发达国家相比有着较大的价格优势，同时推动整个地区区域的液压件更新换代，其技术和规模效益对于增加劳动就业和经济发展具有较大的贡献。<br>
    &#12288;&#12288;为了扩大生产规模，集团于2008年5月开始建设二期扩建工程，2009年7月已竣工投入使用，该项目主要用于扩产大中小型液压挖掘机及工程机械液压泵阀，项目达产后，挖掘机年产能力超过5000台、液压泵阀在10000台套以上，不仅能带来可观的经济效益，而且可带动机械配件加工、钢材、物流运输等数十个相关行业的发展，具有显著地社会效益。公司力争在最短的时间内形成国际知名的“沃尔华”品牌。<br>
    <strong>&#12288;&#12288;公司通过了ISO9001:2008质量管理体系认证，建立完善的管理制度：<br>
    </strong>&#12288;&#12288;质量是企业的生命，抓住质量源头，从采购环节抓配套厂的质量，在生产方面严格控制自制件质量和制作工艺，推行了6S管理，技术部门从新产品开发和现有产品的升级换代方面做出了突出成绩，为生产高质量的产品提供了技术支持，不断提升员工的质量意识，从根本上树立了质量第一的观念，结合考核机制进行监督检查，实行质量一票否决制，保证了产品的耐久性、可靠性。<br>
    &#12288;&#12288;引进技术及加强技术合作与交流也给沃尔华的发展奠定了基础，沃尔华与韩国GTS机械研究所、山东科技大学、工程机械协会、工程机械配件协会等机构建立了紧密的合作关系，并于2008年10月成立了沃尔华工程机械研究院，为沃尔华的新产品研发提供了强大的技术支持。<br>
    &#12288;&#12288;信息化管理为企业管理规范化、专业化奠定了基础，在整体运营方面公司开发了专门的管理运作平台，从成本管理、核算的源头入手，理清产品工艺流程，通过设备和信息化投入做出公司产品的配件列表（BOM），完备了产品工艺，为公司的全面质量管理和成本核算奠定了基础。<br>
    &#12288;&#12288;作为济宁市高新技术企业百花园里的一枝新葩，沃尔华人努力开拓，锐意创新，先后荣获济宁市任城区<strong>“支柱企业”、“先进企业”、“项目建设先进企业”、“经济效益先进企业”</strong>及济宁市委、市政府授予的<strong>“民营百强企业”</strong>等荣誉称号。</p>
        
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