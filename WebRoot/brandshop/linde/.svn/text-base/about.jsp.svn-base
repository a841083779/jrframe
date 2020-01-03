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
    <div><img src="images/jj.jpg" width="730" height="210" /></div>
    
    <div class="intro_text">
	
	
	
<p style="text-align:left;">
    <strong>林德物料搬运 – 创造卓越</strong>
</p>
<p>
    &nbsp; &nbsp; &nbsp; &nbsp; 林德物料搬运总部位于德国阿萨芬堡，为世界领先的叉车设备制造商，亦是欧洲叉车市场的领导者。此外，林德物料搬运在电动驱动系统方面拥有数十年的研发经验，为客户提供专业的咨询服务，并将其成果广泛地应用于各个行业。作为一个国际化公司，林德物料搬运在全球主要区域范围内布局有9个生产和组装基地，同时在全球100多个国家和地区设有分支机构，建立了覆盖全球的销售和服务网络。
</p>
<p>
      &nbsp; &nbsp; &nbsp; &nbsp; 在过去的100年里，林德物料搬运为了给用户提供具有更高性价比的优质产品，始终致力于科技创新，向全球市场提供全系列产品及全方位服务和物流搬运解决方案。其中，林德叉车在仓储作业、节能减排等方面的表现均达到了行业顶尖水平。 
</p>
<p>
      &nbsp; &nbsp; &nbsp; &nbsp; 林德（中国）叉车有限公司，1993年成立于厦门，是林德物料搬运在亚洲的生产，销售、服务及技术研发基地，总投资17亿人民币，占地面积22万平方米，是目前国内乃至亚洲规模最大，技术设备最先进的外资品牌叉车制造商。林德（中国）向市场提供全系列的平衡重及仓储等叉车，专业的全方位的服务，最优化的物料搬运综合解决方案及物流方案设计及咨询。林德（中国）现有2500多名员工，销售网络覆盖全国130多个城市，为全国的客户提供高效专业的服务。 
</p>
</br>
<p style="text-align:left;">
    <strong>林德物料搬运百年历程 History of LMH</strong>
</p>
<p>
      &nbsp; &nbsp; &nbsp; &nbsp; 1904年卡尔冯林德博士与Guldner博士合作在慕尼黑成立发动机工厂。1907年工厂搬到阿萨芬堡。1955年静压传动技术开始运用。1960年林德在德国汉诺威展览上推出第一台静压传动叉车。1971年在德国汉诺威展览上推出第一台电动叉车.1985年351系列投产。1993年林德厦门成立。1994年推出系列二之高能量密度的静压传动组件。至今林德仍是世界上唯一将静压传动技术大规模应用于工业车辆的制造商。经过多年的发展，林德拥有最完整的产品系列，已形成了一个具有67个系列、233种产品，包括：内燃平衡重式叉车、电动平衡重叉车、托盘搬运及堆垛车、集装箱堆垛车、前移式叉车、窄通道叉车、低中高位拣选车、牵引车、防爆叉车等。
</p>
<p>
     &nbsp; &nbsp; &nbsp; &nbsp;  1984年和1989年，林德物料搬运集团先后法国的Fenwick集团公司和英国的Lansing集团公司。林德物料搬运部门下属公司分为两种类型：销售公司和制造销售公司，在德国、法国、英国、中国及美国设有叉车生产基地，在欧洲、美洲、亚洲等主要地区均有林德的销售公司，林德物料搬运部门已建立遍布全球的销售服务网络。
</p>
<br>
<p style="text-align:left;">
    <strong>技术创新 Technology &amp; Innovation</strong>
</p>
<p>
     &nbsp; &nbsp; &nbsp; &nbsp;  林德物料搬运1904年创建于德国，历经百年沉淀，将德国精益求精的态度与严谨先进的技术引入中国，获得国内外诸多专利项目，引领国内叉车行业不断发展。林德物料搬运的创新始于设计的最早期，建立新的高性能低成本物料搬运设备的标准。林德创新的原动力来自满足用户对物料搬运设备的技术性能和多样性的需求。其中林德静压传动是目前内燃叉车最理想、最先进的传动方式，主要特点是起步柔和、无级变速、换向迅速、控制精确、维修简单、可靠性高。 
</p>
<br>
<p style="text-align:left;">
    <strong>全系列产品 Complete Product Range</strong>
</p>
<p>
      &nbsp; &nbsp; &nbsp; &nbsp; 世界一流产品：高质量的林德叉车面向全球用户，拥有最完整的产品系列，包括内燃叉车、电动叉车、仓储叉车等三大系列，两百多种叉车，以满足用户不同工况的需求。
</p>
<p>
     &nbsp; &nbsp; &nbsp; &nbsp;  精益化的“超市工厂”：拥有精益的制造系统，现代化生产模式，高质量的产品的保证；具备易于扩大产能能力，以满足新兴市场增长的需求，成为行业的榜样。
</p>
<p>
      &nbsp; &nbsp; &nbsp; &nbsp; 林德关注协助您实现整个物流环节的安全、高效、经济地运作。在整个物料搬运中总体运营成本除了您所能看到的采购成本、维修保养成本、能耗成本之外，司机成本在整个运营环节中也占有重要比重，而设备效率和能耗作为不可忽视的因素在各个环节发挥重要的影响。    林德针对客户的需求提供最合适的方案和搬运设备。
</p>
<br>
<p style="text-align:left;">
    <strong>专业服务 Service</strong>
</p>
<p style="text-align:left;">
    <strong>快速服务：及时响应，保障运营 Prompt Service – Safeguard Your Operation</strong>
</p>
<p>
     &nbsp; &nbsp; &nbsp; &nbsp;  林德(中国)在全国范围内拥有超过130个服务网点、700位经验丰富的高素质工程师队伍及中外专家、500辆配备常用配件及标准工具的林德售后服务车，提供最快速便捷的服务。林德率先建立了行业内首个呼叫中心 ，更好地协调强大的服务网络资源，更加快速地响应客户的需求。
</p>
<p>
     &nbsp; &nbsp; &nbsp; &nbsp;  林德(中国)储备了17,200种价值上亿元的配件库存，全国各分公司也拥有常用配件安全库存，同时得到了德国总部配件库提供的高达65,000种强有力的库存支持。林德先进的ERP系统确保了稳定、可靠的供货，而十年供应承诺则确保了客户购买叉车无后顾之忧。
</p>
<br>
<p style="text-align:left;">
    <strong>专业服务：高素质团队，高质量装备 Professional Service – Provides High Quality Team and Equipment</strong>
</p>
<p>
      &nbsp; &nbsp; &nbsp; &nbsp; 林德不断投资于服务设备与人员培训方面来提高服务质量。秉承德国注重技术传承的风格，林德创建了行业内独有的林德服务培训体系，以打造高素质高水准的专业团队。
</p>
<p>
     &nbsp; &nbsp; &nbsp; &nbsp;  林德服务工程师配备成套专用工具、PDA（移动服务系统）、手提诊断电脑及配备常用配件与GPS的服务车，确保服务工作的高效、高质。林德也是叉车行业首家荣获《特种设备安装改造维修许可证》的企业。
</p>
<br>
<p style="text-align:left;">
    <strong>可靠服务：诚信负责，长期共赢 Reliable Service – Long-Term &amp; Win-Win Partnership</strong>
</p>
<p>
      &nbsp; &nbsp; &nbsp; &nbsp; 高品质原装配件专为林德叉车高效、安全的性能而研制，选用优质材料、设计精良、配合精密，确保相对固定的维修成本，保证叉车安全、稳定运行，使用寿命也更长久。
</p>
<br>
<p style="text-align:left;">
    <strong>个性化服务：多元服务，物超所值 Customized Service – More Value for Money</strong>
</p>
<p>
     &nbsp; &nbsp; &nbsp; &nbsp;  林德提供多样的定制的服务方案以满足客户的不同需求，帮助用户对叉车进行维护保养，包括林德定期保养 (RMC)、林德全面保养 (FMC)、人工全包 (LMC) 以及驻点全包 (RSC)，使用户可专注于自己的核心业务而放心让林德来管理叉车。同时林德协助客户建立系统的叉车管理档案，提供《叉车履历册》，看板管理、协助制定操作规程、维护保养、培训等。
</p>
<p>
    <br />
</p>



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