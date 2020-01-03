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
<title>江苏华通官方旗舰店 - 铁臂商城</title>
<meta name="keywords" content="江苏华通,江苏华通产品报价,江苏华通产品,江苏华通产品图片,江苏华通产品介绍,江苏华通介绍" />
<meta name="description" content="铁臂商城为您提供江苏华通介绍,江苏华通产品介绍,江苏华通产品报价,江苏华通产品图片,江苏华通产品展示等江苏华通产品信息，帮助您全面了解江苏华通。" />
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
    <h2><img src="images/new_shop_logos.gif" alt="江苏华通动力重工旗舰店" width="434" height="102" /></h2>
    <div class="shop_bm"><a href="#" onclick="addShop();return false;"><img src="images/new_shop_bm.gif" alt="收藏本店铺" width="149" height="35" /></a></div>
    <div class="shop_tel">江苏华通动力客服热线：400-660-2278<br />
      销售热线：0511-84423116　84420569</div>
  </div>
</div>
<div class="shopNav">
  <div class="contain980">
    <ul>
      <li><a href="./" class="<%=catalognum.equals("")?"selected":"" %>">首页</a></li>
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
  </div>
</div>
<!--main-->
<div class="shopPart03">
  <div class="contain980 pt20 clearfix">
    <div class="shopContain">
      <div class="shopLeftPart">
        <h2>所有产品分类&gt;&gt;</h2>
        <ul class="shopListMenu">
          <%
          	if(null!=catalogList && catalogList.size()>0){
          		for(int i=0;i<catalogList.size();i++){
          			Map oneMap = catalogList.get(i) ;
          			%>
          			 <li class="<%=catalognum.equals(CommonString.getFormatPara(oneMap.get("num")))?"select":"" %>"><a href="?num=<%=CommonString.getFormatPara(oneMap.get("num")) %>"><%=CommonString.getFormatPara(oneMap.get("catalogname")) %></a></li>
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
              <strong class="name">江苏华通动力重工有限公司</strong>
              <a href="introduce.jsp" target="_blank" style="color:#434343;">我公司为新加坡科技动力有限公司下属的合资企业，是我国生产经营路面机械和建筑机械产品的重点企业和骨干企业，为江苏省高新技术企业、外商投资先进技术企业、全国CAD应用工程示范</a>
              <span class="more"><a href="#" target="_blank">更多&gt;&gt;</a></span>
            </p>
          </div>
        </div>
        
      </div>
      <div class="shopRightPart">
      
        <div class="listBanner"><a title="江苏华通官方旗舰店" target="_blank" href="/brandshop/huatong/"><img src="images/listbanner.jpg" width="650" height="210" /></a></div>
        
        <div class="intro_text">
           <div style="width:650px;">　 我公司为新加坡科技动力有限公司下属的合资企业，是我国生产经营路面机械和建筑机械产品的重点企业和骨干企业，为江苏省高新技术企业、外商投资先进技术企业、全国CAD应用工程示范企业、国家火炬计划重点高新技术企业、机械工业管理进步示范企业、国家高技能人才培养示范基地、设立国家级博士后科研工作站、省研究生工作站企业和通过ISO9001质量体系认证的企业。公司的前身是镇江华晨华通路面机械有限公司（镇江路面机械制造总厂）。江泽民同志及国务院有关部委领导曾亲临视察，并题词留念。<br />
　　公司所属技术中心为江苏省公路养护机械技术研究中心，专业从事路面机械和建筑机械产品开发研究，具有一支实力雄厚的研发团队，具备较强的自主创新开发能力，已拥有141项授权专利。<br />
我公司分别先后从日本、澳大利亚和美国引进沥青摊铺机、多功能搅拌设备和滑模式水泥摊铺机的先进技术，并结合我国市场实际吸收、消化、创新，形成摊铺机械、拌和机械、养护机械、混凝土机械和铲运机械五大系列61个品种的高新技术产品群。<br />
　　路面机械和建筑机械为我公司长远发展战略规划产品，被列为国家机械发展重点产品、江苏省战略产品。近几年来，生产能力不断提高，技术工艺不断创新，产品品种不断扩大，国内市场占有率达25%以上，技术性能达到国际先进水平。本公司除在北京、上海、广州、沈阳、武汉、西安、昆明、乌鲁木齐等重点省会城市设有25个销售办事处外，还在印度、阿尔及利亚、俄罗斯、哈萨克斯坦设立驻外办事处，以优质的产品、周到的服务赢得国内外广大用户的信赖和青睐，中国质量管理协会用户委员会颁发售后服务用户满意证书。</div>
        </div>
              
        <div class="l bdintro" style="width:720px; padding:10px 0px;">
        
          <div class="l"><img width="188" height="45" onclick="showinquery('','1220')" src="/images/pd_btn.gif" style="cursor:pointer"></div>
          
          <div class="r"><a href="/admin/login.jsp" target="_blank">厂家登录</a> </div>
          <div class="checkContact"> 
          <span style="background:url(/images/contact_layer_point.gif) right no-repeat;display:block" onclick="document.getElementById('contactLayer').style.display='block';">联系电话</span>
          <div style="display: none; position: relative;" id="contactLayer"> <a onclick="jQuery('#contactLayer').hide();" class="ContactCloseBtn" href="javascript:void(0);"></a>
            <h3>联系电话</h3>
            <div class="cc">联系本站（0535-6792733）<br>
              <span id="p0_1"> 联系厂家（<span id="telId">0511-84423116</span>） </span></div>
            <div style="padding-left:20px; line-height:18px;">联系我们时，请说是在 <strong>中国工程机械商贸网</strong> 上看到的。</div>
            <div class="cb"><a href="javascript:void(0)"><img onclick="showinquery('','1220')" src="/images/pd_btn.gif"></a></div>
          </div>
        </div>
        </div>
        
        <div class="w755 border03 l mb10 list08">
          <div class="title12">
            <h3>华通动力产品订单</h3>
            <span><a target="_blank" href="/inquiry/?factory=1220">更多&gt;&gt;</a></span> </div>
          <div class="title08">
            <h3><b>询价总数：24</b> - 采购询价</h3>
            <span>共有<font>24</font>个符合条件</span> </div>
          <ul class="ti">
            <li class="i1">编号</li>
            <li class="i2">询价产品</li>
            <li class="i3">联系人</li>
            <li class="i4">电话</li>
            <li class="i5">询价品牌</li>
            <li class="i6">询价区域</li>
            <li class="i7">询价时间</li>
          </ul>
          <div class="li">
            <ul class="libg01">
              <li class="i1">1</li>
              <li class="i2"><a target="_blank" href="/inquiry/detail_for_128560.htm">华通动力SPS90C全液压多功能摊铺机</a></li>
              <li class="i3">王***</li>
              <li class="i4">043***804</li>
              <li class="i5">华通动力</li>
              <li class="i6">吉林长春</li>
              <li class="i7">2013-04-03 11:00</li>
            </ul>
            <ul class="libg02">
              <li class="i1">2</li>
              <li class="i2"><a target="_blank" href="/inquiry/detail_for_118271.htm">华通动力ABH3000沥青搅拌站</a></li>
              <li class="i3">肖***</li>
              <li class="i4">186***381</li>
              <li class="i5">华通动力</li>
              <li class="i6">湖北孝感</li>
              <li class="i7">2013-03-18 10:25</li>
            </ul>
            <ul class="libg01">
              <li class="i1">3</li>
              <li class="i2"><a target="_blank" href="/inquiry/detail_for_110404.htm">华通动力ABH3000沥青搅拌站</a></li>
              <li class="i3">赵***</li>
              <li class="i4">135***118</li>
              <li class="i5">华通动力</li>
              <li class="i6">四川遂宁</li>
              <li class="i7">2013-03-07 15:52</li>
            </ul>
            <ul class="libg02">
              <li class="i1">4</li>
              <li class="i2"><a target="_blank" href="/inquiry/detail_for_103601.htm">华通动力1220MAXI-PAV滑模摊铺机</a></li>
              <li class="i3">冼***</li>
              <li class="i4">139***760</li>
              <li class="i5">华通动力</li>
              <li class="i6">河北唐山</li>
              <li class="i7">2013-02-25 15:40</li>
            </ul>
            <ul class="libg01">
              <li class="i1">5</li>
              <li class="i2"><a target="_blank" href="/inquiry/detail_for_94177.htm">华通动力1220MAXI-PAV滑模摊铺机</a></li>
              <li class="i3">肖***</li>
              <li class="i4">135***385</li>
              <li class="i5">华通动力</li>
              <li class="i6">四川成都</li>
              <li class="i7">2013-01-31 13:30</li>
            </ul>
            <ul class="libg02">
              <li class="i1">6</li>
              <li class="i2"><a target="_blank" href="/inquiry/detail_for_89429.htm">华通动力ABH3000沥青搅拌站</a></li>
              <li class="i3">晏***</li>
              <li class="i4">151***777</li>
              <li class="i5">华通动力</li>
              <li class="i6">陕西宝鸡</li>
              <li class="i7">2013-01-18 10:01</li>
            </ul>
            <ul class="libg01">
              <li class="i1">7</li>
              <li class="i2"><a target="_blank" href="/inquiry/detail_for_88441.htm">华通动力ABH5000沥青搅拌站</a></li>
              <li class="i3">魏***</li>
              <li class="i4">138***000</li>
              <li class="i5">华通动力</li>
              <li class="i6">四川眉山</li>
              <li class="i7">2013-01-15 00:52</li>
            </ul>
            <ul class="libg02">
              <li class="i1">8</li>
              <li class="i2"><a target="_blank" href="/inquiry/detail_for_86873.htm">华通动力WBSC300稳定土厂拌设备</a></li>
              <li class="i3">孙***</li>
              <li class="i4">139***175</li>
              <li class="i5">华通动力</li>
              <li class="i6">内蒙古呼和浩特</li>
              <li class="i7">2013-01-10 21:36</li>
            </ul>
            <ul class="libg01">
              <li class="i1">9</li>
              <li class="i2"><a target="_blank" href="/inquiry/detail_for_85746.htm">华通动力LJB1000沥青搅拌站</a></li>
              <li class="i3">未***</li>
              <li class="i4">133***717</li>
              <li class="i5">华通动力</li>
              <li class="i6">甘肃嘉峪关</li>
              <li class="i7">2013-01-07 09:18</li>
            </ul>
            <ul class="libg02">
              <li class="i1">10</li>
              <li class="i2"><a target="_blank" href="/inquiry/detail_for_80798.htm">华通动力LTL70C履带式摊铺机</a></li>
              <li class="i3">张***</li>
              <li class="i4">187***661</li>
              <li class="i5">华通动力</li>
              <li class="i6">新疆昌吉</li>
              <li class="i7">2012-12-19 16:51</li>
            </ul>
          </div>
        </div>
        
        <div class="selects">
          <div style="margin-right: 0px;" class="local"><strong>目前所在：</strong> 烟台</div>
          <div style="float: right; margin-right: 5px;">
            <select style="width: 100px;" onchange="set_city(this,this.value,document.getElementById('city'),'');" id="province" name="province">
              <option value="">--省份--</option>
              <script type="text/javascript">
                for(var c in cities){
                    document.write("&lt;option value='"+c+"'&gt;"+c+"&lt;/option&gt;");
                }
               </script>
              <option value="A 澳门">A 澳门</option>
              <option value="A 安徽">A 安徽</option>
              <option value="B 北京">B 北京</option>
              <option value="C 重庆">C 重庆</option>
              <option value="F 福建">F 福建</option>
              <option value="G 广东">G 广东</option>
              <option value="G 贵州">G 贵州</option>
              <option value="G 甘肃">G 甘肃</option>
              <option value="G 广西">G 广西</option>
              <option value="H 河北">H 河北</option>
              <option value="H 黑龙江">H 黑龙江</option>
              <option value="H 河南">H 河南</option>
              <option value="H 湖北">H 湖北</option>
              <option value="H 湖南">H 湖南</option>
              <option value="H 海南">H 海南</option>
              <option value="J 吉林">J 吉林</option>
              <option value="J 江苏">J 江苏</option>
              <option value="J 江西">J 江西</option>
              <option value="L 辽宁">L 辽宁</option>
              <option value="N 内蒙古">N 内蒙古</option>
              <option value="N 宁夏">N 宁夏</option>
              <option value="Q 青海">Q 青海</option>
              <option value="S 上海">S 上海</option>
              <option value="S 山西">S 山西</option>
              <option value="S 山东">S 山东</option>
              <option value="S 四川">S 四川</option>
              <option value="S 陕西">S 陕西</option>
              <option value="T 天津">T 天津</option>
              <option value="T 台湾">T 台湾</option>
              <option value="X 香港">X 香港</option>
              <option value="X 西藏">X 西藏</option>
              <option value="X 新疆">X 新疆</option>
              <option value="Y 云南">Y 云南</option>
              <option value="Z 浙江">Z 浙江</option>
            </select>
            <select style="width: 100px;" id="model" name="model">
              <option value="">--类型--</option>
              <option value="101">土方机械</option>
              <option value="101001">&nbsp;&nbsp;&nbsp;&nbsp;挖掘机</option>
              <option value="101002">&nbsp;&nbsp;&nbsp;&nbsp;装载机</option>
              <option value="101003">&nbsp;&nbsp;&nbsp;&nbsp;推土机</option>
              <option value="101004">&nbsp;&nbsp;&nbsp;&nbsp;铲运机</option>
              <option value="101005">&nbsp;&nbsp;&nbsp;&nbsp;平地机</option>
              <option value="101008">&nbsp;&nbsp;&nbsp;&nbsp;自卸卡车</option>
              <option value="102">起重机械</option>
              <option value="102007">&nbsp;&nbsp;&nbsp;&nbsp;汽车起重机</option>
              <option value="102006">&nbsp;&nbsp;&nbsp;&nbsp;随车起重机</option>
              <option value="102008">&nbsp;&nbsp;&nbsp;&nbsp;履带式起重机</option>
              <option value="102002">&nbsp;&nbsp;&nbsp;&nbsp;塔式起重机</option>
              <option value="102003">&nbsp;&nbsp;&nbsp;&nbsp;高空作业平台</option>
              <option value="102010">&nbsp;&nbsp;&nbsp;&nbsp;高空作业车</option>
              <option value="102011">&nbsp;&nbsp;&nbsp;&nbsp;施工升降机</option>
              <option value="102012">&nbsp;&nbsp;&nbsp;&nbsp;伸缩臂叉装机</option>
              <option value="102013">&nbsp;&nbsp;&nbsp;&nbsp;桥梁式起重机</option>
              <option value="103">混凝土机械</option>
              <option value="103001">&nbsp;&nbsp;&nbsp;&nbsp;混凝土泵车</option>
              <option value="103002">&nbsp;&nbsp;&nbsp;&nbsp;混凝土搅拌设备</option>
              <option value="103006">&nbsp;&nbsp;&nbsp;&nbsp;混凝土搅拌运输车</option>
              <option value="103005">&nbsp;&nbsp;&nbsp;&nbsp;混凝土布料设备</option>
              <option value="103010">&nbsp;&nbsp;&nbsp;&nbsp;喷湿机</option>
              <option value="103008">&nbsp;&nbsp;&nbsp;&nbsp;干粉砂浆生产设备</option>
              <option value="103009">&nbsp;&nbsp;&nbsp;&nbsp;粉粒物料运输车</option>
              <option value="103011">&nbsp;&nbsp;&nbsp;&nbsp;沥青砂浆车</option>
              <option value="103012">&nbsp;&nbsp;&nbsp;&nbsp;干混砂浆生产线</option>
              <option value="103014">&nbsp;&nbsp;&nbsp;&nbsp;干混砂浆背罐车</option>
              <option value="103015">&nbsp;&nbsp;&nbsp;&nbsp;其它混凝土设备</option>
              <option value="104">筑养路机械</option>
              <option value="104001">&nbsp;&nbsp;&nbsp;&nbsp;摊铺机</option>
              <option value="104004">&nbsp;&nbsp;&nbsp;&nbsp;其它路面机械</option>
              <option value="104002">&nbsp;&nbsp;&nbsp;&nbsp;养护机械</option>
              <option value="104005">&nbsp;&nbsp;&nbsp;&nbsp;铣刨机</option>
              <option value="104006">&nbsp;&nbsp;&nbsp;&nbsp;稳定土拌合机</option>
              <option value="104007">&nbsp;&nbsp;&nbsp;&nbsp;沥青混合料搅拌设备</option>
              <option value="104008">&nbsp;&nbsp;&nbsp;&nbsp;稳定土厂拌设备</option>
              <option value="104009">&nbsp;&nbsp;&nbsp;&nbsp;沥青搅拌站</option>
              <option value="105">桩工机械</option>
              <option value="105003">&nbsp;&nbsp;&nbsp;&nbsp;旋挖钻机</option>
              <option value="105004">&nbsp;&nbsp;&nbsp;&nbsp;潜孔钻机</option>
              <option value="105005">&nbsp;&nbsp;&nbsp;&nbsp;水平定向钻</option>
              <option value="105007">&nbsp;&nbsp;&nbsp;&nbsp;连续墙抓斗</option>
              <option value="105009">&nbsp;&nbsp;&nbsp;&nbsp;液压静力压桩机</option>
              <option value="105016">&nbsp;&nbsp;&nbsp;&nbsp;连续墙钻机</option>
              <option value="105011">&nbsp;&nbsp;&nbsp;&nbsp;打桩机</option>
              <option value="105013">&nbsp;&nbsp;&nbsp;&nbsp;液压步履式桩架</option>
              <option value="105015">&nbsp;&nbsp;&nbsp;&nbsp;打桩锤</option>
              <option value="105017">&nbsp;&nbsp;&nbsp;&nbsp;强夯机</option>
              <option value="105018">&nbsp;&nbsp;&nbsp;&nbsp;长螺旋钻孔机</option>
              <option value="105019">&nbsp;&nbsp;&nbsp;&nbsp;多功能钻机</option>
              <option value="105026">&nbsp;&nbsp;&nbsp;&nbsp;多轴钻孔机</option>
              <option value="105027">&nbsp;&nbsp;&nbsp;&nbsp;其它桩工机械</option>
              <option value="105028">&nbsp;&nbsp;&nbsp;&nbsp;截桩机/破桩机</option>
              <option value="106">压实机械</option>
              <option value="106001">&nbsp;&nbsp;&nbsp;&nbsp;压路机</option>
              <option value="106003">&nbsp;&nbsp;&nbsp;&nbsp;压实机</option>
              <option value="106004">&nbsp;&nbsp;&nbsp;&nbsp;夯实机</option>
              <option value="107">叉车</option>
              <option value="107001">&nbsp;&nbsp;&nbsp;&nbsp;内燃叉车</option>
              <option value="107003">&nbsp;&nbsp;&nbsp;&nbsp;电动叉车</option>
              <option value="107005">&nbsp;&nbsp;&nbsp;&nbsp;仓储叉车</option>
              <option value="107010">&nbsp;&nbsp;&nbsp;&nbsp;专用叉车</option>
              <option value="109">桥梁机械</option>
              <option value="109001">&nbsp;&nbsp;&nbsp;&nbsp;架桥机</option>
              <option value="109002">&nbsp;&nbsp;&nbsp;&nbsp;运梁车</option>
              <option value="109004">&nbsp;&nbsp;&nbsp;&nbsp;提梁机</option>
              <option value="109005">&nbsp;&nbsp;&nbsp;&nbsp;检测车</option>
              <option value="109006">&nbsp;&nbsp;&nbsp;&nbsp;砂浆车</option>
              <option value="110">地下及矿山机械</option>
              <option value="110001">&nbsp;&nbsp;&nbsp;&nbsp;盾构掘进机</option>
              <option value="110002">&nbsp;&nbsp;&nbsp;&nbsp;矿用掘进机</option>
              <option value="110005">&nbsp;&nbsp;&nbsp;&nbsp;采煤机</option>
              <option value="110008">&nbsp;&nbsp;&nbsp;&nbsp;凿岩台车</option>
              <option value="110009">&nbsp;&nbsp;&nbsp;&nbsp;破碎机</option>
              <option value="110010">&nbsp;&nbsp;&nbsp;&nbsp;凿岩钻车</option>
              <option value="110011">&nbsp;&nbsp;&nbsp;&nbsp;凿岩机和钻机</option>
              <option value="110012">&nbsp;&nbsp;&nbsp;&nbsp;筛分机</option>
              <option value="110013">&nbsp;&nbsp;&nbsp;&nbsp;装载及搬运设备</option>
              <option value="110014">&nbsp;&nbsp;&nbsp;&nbsp;连续采煤机和隧道掘进机</option>
              <option value="110015">&nbsp;&nbsp;&nbsp;&nbsp;输送和辅助设备</option>
              <option value="110016">&nbsp;&nbsp;&nbsp;&nbsp;全液压凿岩钻机</option>
              <option value="110017">&nbsp;&nbsp;&nbsp;&nbsp;隧道轨道设备</option>
              <option value="111">港口机械</option>
              <option value="111001">&nbsp;&nbsp;&nbsp;&nbsp;正面吊</option>
              <option value="111002">&nbsp;&nbsp;&nbsp;&nbsp;堆高机</option>
              <option value="111003">&nbsp;&nbsp;&nbsp;&nbsp;吊具</option>
              <option value="111006">&nbsp;&nbsp;&nbsp;&nbsp;场桥</option>
              <option value="111007">&nbsp;&nbsp;&nbsp;&nbsp;推耙机</option>
              <option value="113">破碎设备</option>
              <option value="113001">&nbsp;&nbsp;&nbsp;&nbsp;破碎锤</option>
              <option value="113002">&nbsp;&nbsp;&nbsp;&nbsp;液压剪</option>
              <option value="118">专用汽车</option>
              <option value="118002">&nbsp;&nbsp;&nbsp;&nbsp;专用车辆</option>
              <option value="118003">&nbsp;&nbsp;&nbsp;&nbsp;消防车</option>
              <option value="118004">&nbsp;&nbsp;&nbsp;&nbsp;牵引车</option>
              <option value="119">煤炭机械</option>
            </select>
            <input type="button" onclick="setNowSearch();" class="selectBtn_70" value="代理商搜索" id="button2" name="button2" style="background-image: url('http://product.21-sun.com/images/a_btn_70.gif'); margin: 0;padding: 0;border: none;width: 70px;height: 22px;color: #fff;cursor: pointer;">
          </div>
        </div>
        
        <ul class="agent_ti">
          <li class="g1">代理商</li>
          <li class="g2">代理区域</li>
          <li class="g3">主营品牌</li>
          <li class="g4">在线询价</li>
          <li class="g5">联系电话</li>
        </ul>
        
        <div class="agent_li" style="height: auto;">
          <ul class="libg02">
            <li class="g1"><a target="_blank" href="/agent/xjylxhsmyxzrgs/" title="新疆伊犁星河商贸有限责任公司">新疆伊犁星河商贸有限责任公司</a></li>
            <li class="g2"><span title="新疆伊犁州">新疆伊犁州</span></li>
            <li class="g3"><span title="阿特拉斯,厦工,晋工,大地,詹阳动力,徐工,山推,方圆集团,三一,华通动力">阿特拉斯,厦工,晋工,大地,詹阳动力,徐工,山推,方圆集团,三一,华通动力</span></li>
            <li class="g4"><a onclick="zaiXianXunJia('12467');" href="javascript:void(0);">在线询价</a></li>
            <li style="width:130px;overflow:hidden;" class="g5"><a href="javascript:void(0);" class="gcur">暂无联系方式</a></li>
          </ul>
        </div>
        
        <div style="float: left;width: 600px;padding:0; margin-left:20px; display:inline;" class="paging page"><a style="cursor: default;" href="javascript:void(0);" class="pre">&nbsp;</a><span class="current"><b>&nbsp;1&nbsp;</b></span><a style="cursor: default;" href="javascript:void(0);" class="next">&nbsp;</a></div>
        
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