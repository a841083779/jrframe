<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
   	String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
	String catalog = CommonString.getFormatInt(request.getParameter("catalog")).toString();
	catalog = CommonString.getFilterStr(catalog);
	if(catalog.equals("0")){
		catalog = "";
	}
	Map brandMap = (Map) application.getAttribute("brandMap");
	if(catalog.indexOf("10500315")!=-1){
		Common.do301(response,"<%=url%>?catalog=105003") ;
	}
	String factoryid = CommonString.getFormatInt(request.getParameter("factoryid")).toString();
	String factory = CommonString.getFormatInt(request.getParameter("factory")).toString();
	if(factory.equals("0")){
		factory = "";
	}
	if(factoryid.equals("0")){
		factoryid = "";
	}
	if (!"".equals(factory)) {  
		factoryid = factory;
	}
	DBHelper dbHelper = DBHelper.getInstance();
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String order = CommonString.getFormatPara(request.getParameter("order"));
	Map seoTitleKeywordMap = (HashMap)application.getAttribute("seoTitleKeywordMap") ;
	String seoTitle = null ;
	seoTitle = CommonString.getFormatPara(seoTitleKeywordMap.get(catalog)) ;
	String province = "";
	String city = "";
	String ip  = Common.getIp(request);
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		String objStr = Tools.getMyProvinceAndCity(ip);
		JSONObject obj = new JSONObject(objStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<cache:cache cron="*/1 * * * *">
<%
		String showtonandmeter = ""; 
		if ("grab_1_13".equals(tonandmeter)) {
			showtonandmeter = "小挖(1T~13T)";
		} else if ("grab_14_30".equals(tonandmeter)) {
			showtonandmeter = "中挖(14T~30T)";
		} else if ("grab_30_1".equals(tonandmeter)) {    
			showtonandmeter = "大挖(30T以上)";
		} else if ("loader_1_3".equals(tonandmeter)) {
			showtonandmeter = "3T以下";
		} else if ("loader_3_01".equals(tonandmeter)) {
			showtonandmeter = "3T";
		} else if ("loader_3_5".equals(tonandmeter)) {
			showtonandmeter = "3T~5T";
		} else if("loader_5_1".equals(tonandmeter)){
			showtonandmeter = "5T以上";
		}else if ("crane_1_16".equals(tonandmeter)) {
			showtonandmeter = "16T以下";
		} else if ("crane_20_70".equals(tonandmeter)) {
			showtonandmeter = "20T~70T";
		} else if ("crane_70_1".equals(tonandmeter)) {
			showtonandmeter = "70T以上";
		} else {
			showtonandmeter = "";
		}
		List<Map> catalogList = (List) application.getAttribute("catalogList"); 
		Map catalogMap = (Map) application.getAttribute("catalogMap");
		Map brandUsernMap = (HashMap) application.getAttribute("brandUsernMap"); // id 和 品牌代号对应
		if (null == brandUsernMap) {
			brandUsernMap = new HashMap();
		}
		StringBuffer whereStr = new StringBuffer(" and is_show=1");
		if (!"".equals(catalog)) {
			whereStr.append(" and catalognum like '%" + catalog + "%'");
		}
		if (!"".equals(factoryid)) {  
			whereStr.append(" and factoryid=" + factoryid);
		}
		if (!keyword.equals("")) {
			whereStr.append(" and  factoryname+name+catalogname like '%" + keyword + "%'");
		}
		//拆分吨位
		String[] parttonandmeters = null;
		String firsttonandmeter = "";
		String sectonandmeter = "";
		if (!"".equals(tonandmeter) && !"undefined".equals(tonandmeter)) {
			parttonandmeters = tonandmeter.split("_");
			firsttonandmeter = parttonandmeters[1];
			sectonandmeter = parttonandmeters[2];
			if ("0".equals(parttonandmeters[2])) {
				whereStr.append(" and tonandmeter < " + firsttonandmeter);
			} else if ("1".equals(parttonandmeters[2])) {
				whereStr.append(" and tonandmeter >" + firsttonandmeter);
			} else if ("01".equals(parttonandmeters[2])) {
				whereStr.append(" and tonandmeter =" + firsttonandmeter);
			} else {
				whereStr.append(" and tonandmeter between " + firsttonandmeter + " and " + parttonandmeters[2]);
			}
		}
		PageBean pageBean = new PageBean(); // 分页程序
		pageBean.setPageSize(10); // 每页显示条数
		pageBean.setCondition(whereStr.toString());
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
		pageBean.setNowPage(nowPage);
		if("".equals(order)){
		}
		if(!"".equals(factoryid) && "".equals(order)){
			pageBean.setOrderBy(" order_no desc, view_count desc") ;
		}
		if (("".equals(order) || "1".equals(order)) &&"".equals(factoryid)) {
		 	pageBean.setOrderBy(" order_no_all desc, view_count desc"); // 默认排序
		}
		if ("0".equals(order)) {
			pageBean.setOrderBy(" view_count desc"); // 点击量排序
		}
		String url = CommonString.getFormatPara(request.getQueryString());
		if (!"".equals(url)) {
			if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
				url = "";
			} else if (url.indexOf("offset") != -1) {
				url = "&" + url.substring(url.indexOf("&") + 1);
			} else {
				url = "&" + url;
			}
		}
		pageBean.setParams(url);
		pageBean.setIsShowSql(false);
		pageBean.setFields(" id,factoryname,name,introduce,catalogname,file_name,img2,factoryid,catalognum ");
		pageBean.setTableName("pro_products");
		String showTile = keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+CommonString.getFormatPara(catalogMap.get(catalog))+"_网上购买"+keyword+showtonandmeter
		+("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+CommonString.getFormatPara(catalogMap.get(catalog))+"_"+keyword+showtonandmeter
		+("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+CommonString.getFormatPara(catalogMap.get(catalog));
		if(!"_".equals(showTile)){
	    	showTile+="价格表" ;
	    }else{
	    	showTile = "工程机械产品大全" ; 
	    }
		if(!"".equals(seoTitle)){
			showTile = ("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+seoTitle ;
		}
	%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<title>无标题文档</title>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true">
<jsp:param name="keyword" value="1"></jsp:param>
<jsp:param name="catalog" value="1"></jsp:param>
<jsp:param name="factoryid" value="1"></jsp:param>
</jsp:include>
<!--top end--> 
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> 您现在所在的位置： <a href="/">铁臂商城</a> &gt;&gt; <a href="/products/">产品大全</a> </h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10"> 
  <!--left-->
  <div class="w210 l np_left">
    <div id="leftId">
      <div class="npro_tab">
      	<ul class="np_fix">
        	<li class="cur"><a href="#">参数</a></li>
            <li><a href="#">口碑</a></li>
            <li><a href="#">图片</a></li>
            <li><a href="#">维修</a></li>
            <li><a href="#">视频</a></li>
            <li><a href="#">品牌故事 </a></li>
        </ul>
      </div>
      <div class="w208 border01 l leftPart mb10">
        <h2>热门品牌</h2>
        <div class="hbr">
          <ul>
            <li><a target="_blank" href="/brand/sany/">三一</a></li>
            <li><a target="_blank" href="/brand/komatsu/">小松</a></li>
            <li><a target="_blank" href="/brand/hitachi/">日立</a></li>
            <li><a target="_blank" href="/brand/kobelco/">神钢</a></li>
            <li><a target="_blank" href="/brand/volvo/">沃尔沃</a></li>
            <li><a target="_blank" href="/brand/doosan/">斗山</a></li>
          </ul>
        </div>
        
        <!--字母检索-->
        
        <div class="treeSubNavv1">
          <ul id="tree_letter">
            <li><a href="javascript:void(0);" onclick="treeHref(1);return false;">A</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(2);return false;">B</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(3);return false;">C</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(4);return false;">D</a></li>
            <li class="none">E</li>
            <li><a href="javascript:void(0);" onclick="treeHref(5);return false;">F</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(6);return false;">G</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(7);return false;">H</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(8);return false;">I</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(9);return false;">J</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(10);return false;">K</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(11);return false;">L</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(12);return false;">M</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(13);return false;">N</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(14);return false;">O</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(15);return false;">P</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(16);return false;">Q</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(17);return false;">R</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(18);return false;">S</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(19);return false;">T</a></li>
            <li class="none">U</li>
            <li class="none">V</li>
            <li><a href="javascript:void(0);" onclick="treeHref(20);return false;">W</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(21);return false;">X</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(22);return false;">Y</a></li>
            <li><a href="javascript:void(0);" onclick="treeHref(23);return false;">Z</a></li>
          </ul>
        </div>
        <div class="treev1" id="treev1">
          <ul>
            <li class="root" id="letter1"><b>A</b>
              <ul>
                <li id="1185" title="阿尔多机械" url="<%=url%>"> <a href="<%=url%>?factory=1185" class="mainBrand"><big>阿尔多机械</big></a>
                  <ul id="1185_sub">
                  </ul>
                </li>
                <li id="180" title="阿特拉斯" url="<%=url%>"> <a href="<%=url%>?factory=180" class="mainBrand"><big>阿特拉斯</big></a>
                  <ul id="180_sub">
                  </ul>
                </li>
                <li id="482" title="阿特拉斯·科普柯" url="<%=url%>"> <a href="<%=url%>?factory=482" class="mainBrand"><big>阿特拉斯·科普柯</big></a>
                  <ul id="482_sub">
                  </ul>
                </li>
                <li id="402" title="艾迪" url="<%=url%>"> <a href="<%=url%>?factory=402" class="mainBrand"><big>艾迪</big></a>
                  <ul id="402_sub">
                  </ul>
                </li>
                <li id="772" title="艾思博" url="<%=url%>"> <a href="<%=url%>?factory=772" class="mainBrand"><big>艾思博</big></a>
                  <ul id="772_sub">
                  </ul>
                </li>
                <li id="14236" title="安鼎重工" url="<%=url%>"> <a href="<%=url%>?factory=14236" class="mainBrand"><big>安鼎重工</big></a>
                  <ul id="14236_sub">
                  </ul>
                </li>
                <li id="1710" title="安迈" url="<%=url%>"> <a href="<%=url%>?factory=1710" class="mainBrand"><big>安迈</big></a>
                  <ul id="1710_sub">
                  </ul>
                </li>
                <li id="1169" title="安丘通用" url="<%=url%>"> <a href="<%=url%>?factory=1169" class="mainBrand"><big>安丘通用</big></a>
                  <ul id="1169_sub">
                  </ul>
                </li>
                <li id="13271" title="奥津" url="<%=url%>"> <a href="<%=url%>?factory=13271" class="mainBrand"><big>奥津</big></a>
                  <ul id="13271_sub">
                  </ul>
                </li>
                <li id="1778" title="奥盛特重工" url="<%=url%>"> <a href="<%=url%>?factory=1778" class="mainBrand"><big>奥盛特重工</big></a>
                  <ul id="1778_sub">
                  </ul>
                </li>
                <li id="13272" title="奥泰" url="<%=url%>"> <a href="<%=url%>?factory=13272" class="mainBrand"><big>奥泰</big></a>
                  <ul id="13272_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li class="root" id="letter2"><b>B</b>
              <ul>
                <li id="484" title="八达" url="<%=url%>"> <a href="<%=url%>?factory=484" class="mainBrand"><big>八达</big></a>
                  <ul id="484_sub">
                  </ul>
                </li>
                <li id="791" title="八达重工" url="<%=url%>"> <a href="<%=url%>?factory=791" class="mainBrand"><big>八达重工</big></a>
                  <ul id="791_sub">
                  </ul>
                </li>
                <li id="13557" title="巴里巴" url="<%=url%>"> <a href="<%=url%>?factory=13557" class="mainBrand"><big>巴里巴</big></a>
                  <ul id="13557_sub">
                  </ul>
                </li>
                <li id="1108" title="百财" url="<%=url%>"> <a href="<%=url%>?factory=1108" class="mainBrand"><big>百财</big></a>
                  <ul id="1108_sub">
                  </ul>
                </li>
                <li id="13562" title="百巨建机" url="<%=url%>"> <a href="<%=url%>?factory=13562" class="mainBrand"><big>百巨建机</big></a>
                  <ul id="13562_sub">
                  </ul>
                </li>
                <li id="13560" title="百开" url="<%=url%>"> <a href="<%=url%>?factory=13560" class="mainBrand"><big>百开</big></a>
                  <ul id="13560_sub">
                  </ul>
                </li>
                <li id="13565" title="百力克" url="<%=url%>"> <a href="<%=url%>?factory=13565" class="mainBrand"><big>百力克</big></a>
                  <ul id="13565_sub">
                  </ul>
                </li>
                <li id="1168" title="百脉建机" url="<%=url%>"> <a href="<%=url%>?factory=1168" class="mainBrand"><big>百脉建机</big></a>
                  <ul id="1168_sub">
                  </ul>
                </li>
                <li id="478" title="邦立重机" url="<%=url%>"> <a href="<%=url%>?factory=478" class="mainBrand"><big>邦立重机</big></a>
                  <ul id="478_sub">
                  </ul>
                </li>
                <li id="13569" title="宝达" url="<%=url%>"> <a href="<%=url%>?factory=13569" class="mainBrand"><big>宝达</big></a>
                  <ul id="13569_sub">
                  </ul>
                </li>
                <li id="13570" title="宝鼎" url="<%=url%>"> <a href="<%=url%>?factory=13570" class="mainBrand"><big>宝鼎</big></a>
                  <ul id="13570_sub">
                  </ul>
                </li>
                <li id="1715" title="宝骊" url="<%=url%>"> <a href="<%=url%>?factory=1715" class="mainBrand"><big>宝骊</big></a>
                  <ul id="1715_sub">
                  </ul>
                </li>
                <li id="13550" title="宝马格" url="<%=url%>"> <a href="<%=url%>?factory=13550" class="mainBrand"><big>宝马格</big></a>
                  <ul id="13550_sub">
                  </ul>
                </li>
                <li id="13558" title="宝象" url="<%=url%>"> <a href="<%=url%>?factory=13558" class="mainBrand"><big>宝象</big></a>
                  <ul id="13558_sub">
                  </ul>
                </li>
                <li id="13567" title="暴风雪" url="<%=url%>"> <a href="<%=url%>?factory=13567" class="mainBrand"><big>暴风雪</big></a>
                  <ul id="13567_sub">
                  </ul>
                </li>
                <li id="1093" title="北车重工" url="<%=url%>"> <a href="<%=url%>?factory=1093" class="mainBrand"><big>北车重工</big></a>
                  <ul id="1093_sub">
                  </ul>
                </li>
                <li id="14144" title="北方红阳" url="<%=url%>"> <a href="<%=url%>?factory=14144" class="mainBrand"><big>北方红阳</big></a>
                  <ul id="14144_sub">
                  </ul>
                </li>
                <li id="167" title="北方交通" url="<%=url%>"> <a href="<%=url%>?factory=167" class="mainBrand"><big>北方交通</big></a>
                  <ul id="167_sub">
                  </ul>
                </li>
                <li id="13551" title="北京加隆" url="<%=url%>"> <a href="<%=url%>?factory=13551" class="mainBrand"><big>北京加隆</big></a>
                  <ul id="13551_sub">
                  </ul>
                </li>
                <li id="186" title="北起多田野" url="<%=url%>"> <a href="<%=url%>?factory=186" class="mainBrand"><big>北起多田野</big></a>
                  <ul id="186_sub">
                  </ul>
                </li>
                <li id="1714" title="北山机械" url="<%=url%>"> <a href="<%=url%>?factory=1714" class="mainBrand"><big>北山机械</big></a>
                  <ul id="1714_sub">
                  </ul>
                </li>
                <li id="420" title="贝力特" url="<%=url%>"> <a href="<%=url%>?factory=420" class="mainBrand"><big>贝力特</big></a>
                  <ul id="420_sub">
                  </ul>
                </li>
                <li id="13556" title="贝司特" url="<%=url%>"> <a href="<%=url%>?factory=13556" class="mainBrand"><big>贝司特</big></a>
                  <ul id="13556_sub">
                  </ul>
                </li>
                <li id="13568" title="泵虎" url="<%=url%>"> <a href="<%=url%>?factory=13568" class="mainBrand"><big>泵虎</big></a>
                  <ul id="13568_sub">
                  </ul>
                </li>
                <li id="13553" title="边宁荷夫" url="<%=url%>"> <a href="<%=url%>?factory=13553" class="mainBrand"><big>边宁荷夫</big></a>
                  <ul id="13553_sub">
                  </ul>
                </li>
                <li id="13566" title="滨州钻机" url="<%=url%>"> <a href="<%=url%>?factory=13566" class="mainBrand"><big>滨州钻机</big></a>
                  <ul id="13566_sub">
                  </ul>
                </li>
                <li id="13552" title="波坦" url="<%=url%>"> <a href="<%=url%>?factory=13552" class="mainBrand"><big>波坦</big></a>
                  <ul id="13552_sub">
                  </ul>
                </li>
                <li id="13571" title="波特重工" url="<%=url%>"> <a href="<%=url%>?factory=13571" class="mainBrand"><big>波特重工</big></a>
                  <ul id="13571_sub">
                  </ul>
                </li>
                <li id="13559" title="博德" url="<%=url%>"> <a href="<%=url%>?factory=13559" class="mainBrand"><big>博德</big></a>
                  <ul id="13559_sub">
                  </ul>
                </li>
                <li id="1206" title="博汇机械" url="<%=url%>"> <a href="<%=url%>?factory=1206" class="mainBrand"><big>博汇机械</big></a>
                  <ul id="1206_sub">
                  </ul>
                </li>
                <li id="13555" title="博纳地" url="<%=url%>"> <a href="<%=url%>?factory=13555" class="mainBrand"><big>博纳地</big></a>
                  <ul id="13555_sub">
                  </ul>
                </li>
                <li id="13093" title="博山" url="<%=url%>"> <a href="<%=url%>?factory=13093" class="mainBrand"><big>博山</big></a>
                  <ul id="13093_sub">
                  </ul>
                </li>
                <li id="1234" title="博亚" url="<%=url%>"> <a href="<%=url%>?factory=1234" class="mainBrand"><big>博亚</big></a>
                  <ul id="1234_sub">
                  </ul>
                </li>
                <li id="13624" title="博洋" url="<%=url%>"> <a href="<%=url%>?factory=13624" class="mainBrand"><big>博洋</big></a>
                  <ul id="13624_sub">
                  </ul>
                </li>
                <li id="825" title="搏浪沙" url="<%=url%>"> <a href="<%=url%>?factory=825" class="mainBrand"><big>搏浪沙</big></a>
                  <ul id="825_sub">
                  </ul>
                </li>
                <li id="683" title="德国宝峨" url="<%=url%>"> <a href="<%=url%>?factory=683" class="mainBrand"><big>德国宝峨</big></a>
                  <ul id="683_sub">
                  </ul>
                </li>
                <li id="1703" title="甘肃宝龙" url="<%=url%>"> <a href="<%=url%>?factory=1703" class="mainBrand"><big>甘肃宝龙</big></a>
                  <ul id="1703_sub">
                  </ul>
                </li>
                <li id="13231" title="天地奔牛" url="<%=url%>"> <a href="<%=url%>?factory=13231" class="mainBrand"><big>天地奔牛</big></a>
                  <ul id="13231_sub">
                  </ul>
                </li>
              </ul>
            </li>  
          </ul>
        </div>
        <!--字母检索结束--> 
      </div>
    </div>
  </div>
  <!--left end--> 
  <!--right-->
  <div class="w757 r np_right mb10">
  
  
<form name="theform" id="theform">
    <div class="w755 border03 l Condition mb10">
      <div class="ConditionTop">
        <div class="l">
          <%
										if (!"".equals(catalog) || !"".equals(factoryid)) {
									%>
          <span class="reset" onClick="sosuo();">重置</span>
          <%
										}
									%>
          <%
										if (!"".equals(catalog) && !"".equals(catalog)) {
									%>
          <span><em><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("","<%=factoryid%>","","","<%=order%>")'></a> </span>
          <%
										}
									%>
          <%
										if (!"".equals(factoryid) && !"".equals(factoryid)) {
									%>
          <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("<%=catalog%>","","","","<%=order%>")'></a> </span>
          <%
										}
									%>
          <%
										if (!"".equals(tonandmeter) && !"".equals(showtonandmeter)) {
									%>
          <span><em><%=showtonandmeter%></em> <a
										href="javascript:void(0)" title="取消" class="delete"
										onclick='sosuo("<%=catalog%>","<%=factoryid%>","")'></a> </span>
          <%
										}
									%>
        </div>
        <h3 class="r"><%=keyword%><%=showtonandmeter%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></h3>
      </div>
      <ul class="ConditionBottom">
        <script type="text/javascript">
	  jQuery(document).ready(function() {
		  jQuery(".pbtn").click(function(){
			  jQuery(this).next("div").slideToggle(0)
			  .siblings(".plmore:visible").slideUp(0);
			  jQuery(this).toggleClass("pbon");
			  jQuery(this).siblings(".pbon").removeClass("pbon");
		  });	
	  });
	  </script>
        <li class="cblist">
          <dt> 类别 </dt>
          <input type="hidden" name="factory" id="factory_id" />
          <input type="hidden" name="catalog" id="catalognum" />
          <dd> <a href="<%=url%>" <%if("".equals(catalog)){%> class='select' <%} %>>不限</a> <a href="<%=url%>?catalog=101001" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机</a> <a href="<%=url%>?catalog=101002" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机</a> <a href="<%=url%>?catalog=102" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机</a> <a href="<%=url%>?catalog=101003" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机</a> <a href="<%=url%>?catalog=103" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土</a> <a href="<%=url%>?catalog=106001" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机</a> <a href="<%=url%>?catalog=101005" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机</a> <a href="<%=url%>?catalog=105003" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻</a> <a href="<%=url%>?catalog=113001" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤</a> <a href="<%=url%>?catalog=104001" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机</a>
            <div id="changethis" class="pbtn"></div>
            <div class="plmore" style="padding-left: 0px; width: 680px;;">
            <jsp:include page="/include/products/catalog.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
            <jsp:param value="<%=order%>" name="order"/>
            </jsp:include>   
            </div>
          </dd>
        </li>
        <li class="cblist">
          <dt> 品牌 </dt>
          <dd>
            <%
											if (!"".equals(catalog)) {
										%>
            <a onClick="sosuo('<%=catalog%>','','<%=tonandmeter%>');"
											href="javascript:void(0)" <%if("".equals(factoryid)){%>
											class="select" <%} %>>不限</a>
            <%
											List<Map> recommend_brands = dbHelper
															.getMapList(" select catalognum,catalogname,factoryid,factoryname from pro_catalog_factory where catalognum ='" + catalog
																	+ "' order by order_no desc",connection);
													if (null != recommend_brands && recommend_brands.size() > 0) {
														int i = 0;
														for (Map oneMap : recommend_brands) {
															i++;
															if (i == 20) {
																break;
															}
										%>  
            <!-- 挖掘机 --> 
            <a
											onclick="sosuo('<%=catalog%>','<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>','<%=tonandmeter%>')"
											href="javascript:;"
											<%if(CommonString.getFormatPara(oneMap.get("factoryid")).equals(factoryid)){%>
											class="select" <%} %>><%=CommonString.getFormatPara(oneMap.get("factoryname"))%></a>
            <%
											}
													}
												} else {
										%>
            <a <%if("".equals(factoryid)){%> class='select' <%} %> href="<%=url%>">不限</a> 
            <!-- 挖掘机 --> 
            <a <%if("133".equals(factoryid)){%> class='select' <%} %> href="<%=url%>?factory=133<%=catalog.equals("")?"":"&catalog="+catalog%>">三一</a> 
            <!-- 挖掘机 --> 
            <a <%if("182".equals(factoryid)){%>
											class='select' <%} %> href="<%=url%>?factory=182<%=catalog.equals("")?"":"&catalog="+catalog%>">小松</a> 
            <!-- 挖掘机 --> 
            <a <%if("192".equals(factoryid)){%>
											class='select' <%} %> href="<%=url%>?factory=192<%=catalog.equals("")?"":"&catalog="+catalog%>">斗山</a> 
            <!-- 挖掘机 --> 
            <a <%if("184".equals(factoryid)){%>
											class='select' <%} %> href="<%=url%>?factory=184<%=catalog.equals("")?"":"&catalog="+catalog%>">日立</a> 
            <!-- 挖掘机 --> 
            <a <%if("183".equals(factoryid)){%>
											class='select' <%} %> href="<%=url%>?factory=183<%=catalog.equals("")?"":"&catalog="+catalog%>">神钢</a> 
            <!-- 挖掘机 --> 
            <a <%if("175".equals(factoryid)){%>
											class='select' <%} %> href="<%=url%>?factory=175<%=catalog.equals("")?"":"&catalog="+catalog%>">沃尔沃</a> 
            <!-- 挖掘机 --> 
            <a <%if("174".equals(factoryid)){%>
											class='select' <%} %> href="<%=url%>?factory=174<%=catalog.equals("")?"":"&catalog="+catalog%>">卡特彼勒</a> 
            <!-- 挖掘机 --> 
            <a <%if("146".equals(factoryid)){%>
											class='select' <%} %> href="<%=url%>?factory=146<%=catalog.equals("")?"":"&catalog="+catalog%>">玉柴重工</a> 
            <!-- 挖掘机 --> 
            <a <%if("136".equals(factoryid)){%>
											class='select' <%} %> href="<%=url%>?factory=136<%=catalog.equals("")?"":"&catalog="+catalog%>">柳工</a> 
            <!-- 挖掘机 --> 
            <a <%if("194".equals(factoryid)){%>
											class='select' <%} %> href="<%=url%>?factory=194<%=catalog.equals("")?"":"&catalog="+catalog%>">现代京城</a>
            <a <%if("1220".equals(factoryid)){%>
											class='select' <%} %> href="<%=url%>?factory=1220<%=catalog.equals("")?"":"&catalog="+catalog%>">华通动力</a>
            <%
											}
										%>
            <div id="changethis" class="pbtn"></div>
            <div class="plmore" style="padding-left: 0px; width: 680px;">
            <jsp:include page="/include/products/brand.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
            <jsp:param value="<%=order%>" name="order"/>
            </jsp:include>
            </div>
          </dd>
        </li>
        <li class="cblist" id="grab" style="display: none;">
          <dt> 吨位 </dt>
          <dd>
            <input type="hidden" name="tonandmeter" id="tonandmeter" />
            <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_1_13')"
											<%if("grab_1_13".equals(tonandmeter)){%> class="select" <%}%>>小挖(1T～13T)</a>&nbsp; <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_14_30')"
											<%if("grab_14_30".equals(tonandmeter)){%> class="select"
											<%}%>>中挖(14T～30T)</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_30_1')"
											<%if("grab_30_1".equals(tonandmeter)){%> class="select" <%}%>>大挖(30T以上)</a> </dd>
        </li>
        <li class="cblist" style="display: none;" id="loader">
          <dt> 吨位 </dt>
          <dd> <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_1_3')"
											<%if("loader_1_3".equals(tonandmeter)){%> class="select"
											<%}%>>3T以下</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_3_01')"
											<%if("loader_3_01".equals(tonandmeter)){%> class="select"
											<%}%>>3T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_3_5')"
											<%if("loader_3_5".equals(tonandmeter)){%> class="select"
											<%}%>>3T～5T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_5_1')"
											<%if("loader_5_1".equals(tonandmeter)){%> class="select"
											<%}%>>5T以上</a> </dd>
        </li>
        <li class="cblist" style="display: none;" id="crane">
          <dt> 吨位 </dt>
          <dd> <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_1_16')"
											<%if("crane_1_16".equals(tonandmeter)){%> class="select"
											<%}%>>16T以下</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_20_70')"
											<%if("crane_20_70".equals(tonandmeter)){%> class="select"
											<%}%>>20T～70T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_70_1')"
											<%if("crane_70_1".equals(tonandmeter)){%> class="select"
											<%}%>> 70T以上</a> </dd>
        </li>
        
        <!-- 广告投放 -->
        <%
                             
                             // factoryid  品牌
                             // province 当前省份
                             // catalog 机型
                          //    province = "山东" ;
                             // 选出所有的代理商
                             if(!"".equals(city)){
                            	 String sql = "";
                                 sql += " SELECT id,usern,name,is_qijiandian,is_made FROM ";
                                 sql += "  pro_agent_factory ";
                                 sql += " WHERE (is_shop ='2' OR is_shop='3' ) AND id IN ( ";
                                 sql += " SELECT distinct pap.agent_id FROM ";
                                 sql += " pro_agent_products pap , pro_products pp , pro_agent_ad_area paaa , comm_area ca ";
                                 sql += " WHERE pap.product_id = pp.id AND pap.agent_id = paaa.agent_id AND paaa.area_id = ca.area_id ";
                                 sql += " AND pp.catalognum LIKE '"+catalog+"%' AND ca.area_name LIKE '%"+city+"%' ";
                                 sql += "  ) ";
                                 List<Map> adsList = dbHelper.getMapList(sql,connection);
                                 if(null!=adsList&&adsList.size()>0){
                                	 %>
        <li style="display:block; padding:5px 0px;" class="cblist" id="prolistads">
          <dt><%=city %><br/>
            代理</dt>
          <dd style="line-height: 38px;">
            <%
                    	 String adsId = "";
                    	 for(Map oneMap : adsList){  
                    		 adsId += CommonString.getFormatPara(oneMap.get("id"))+",";
                    		 if("1".equals(CommonString.getFormatPara(oneMap.get("is_qijiandian")))&&"1".equals(CommonString.getFormatPara(oneMap.get("is_made")))){
                    			 %>
                    			 <a style="color:#2e65b7;" href="/agentstore/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank" adsid='<%=CommonString.getFormatPara(oneMap.get("id")) %>'><%=CommonString.getFormatPara(oneMap.get("name")) %></a>
                    			 <%
                    		 }else if("1".equals(CommonString.getFormatPara(oneMap.get("is_qijiandian")))&&!"1".equals(CommonString.getFormatPara(oneMap.get("is_made")))){
                    			 %>
                    			 <a style="color:#2e65b7;" href="/agentshop/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank" adsid='<%=CommonString.getFormatPara(oneMap.get("id")) %>'><%=CommonString.getFormatPara(oneMap.get("name")) %></a>
                    			 <%
                    		 }else if("2".equals(CommonString.getFormatPara(oneMap.get("is_qijiandian")))&&!"1".equals(CommonString.getFormatPara(oneMap.get("is_made")))){
                    			 %>
                    			 <a style="color:#2e65b7;" href="/agentshop02/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank" adsid='<%=CommonString.getFormatPara(oneMap.get("id")) %>'><%=CommonString.getFormatPara(oneMap.get("name")) %></a>
                    			 <%
                    		 }else{
                    		%>
                          <a style="color:#2e65b7;" href="/agent/<%=CommonString.getFormatPara(oneMap.get("usern")) %>/" target="_blank" adsid='<%=CommonString.getFormatPara(oneMap.get("id")) %>'><%=CommonString.getFormatPara(oneMap.get("name")) %></a>
                          <% 
                    		 }
                    	 }
                    	 if(!"".equals(adsId)){
                    		 if(adsId.indexOf(",")!=-1){
                    			 adsId = adsId.substring(0,adsId.length()-1);
                    			 %>
            <script type="text/javascript">
                                	     jQuery.ajax({
                                	       url:'/action/ajax.jsp' ,
                                	       type:'post',
                                	       data:{adsId:'<%=adsId %>',flag:'viewCountProAds','cata_num':'<%=catalog %>'}
                                	     }) ;
                                	     </script>
            <%
                                		 }
                                	 }
                                	 %>
        </li>
        </dd>
        <%
                                 }
                             }
                             %>
        <script type="text/javascript">
	            if('<%=catalog%>'.indexOf("101001")!=-1){
	              jQuery("#grab").attr("style","display:;") ;
	            }
	               if('<%=catalog%>'.indexOf("101002")!=-1){
	              jQuery("#loader").attr("style","display:;") ;
	            }
	               if('<%=catalog%>'.indexOf("102")!=-1){
	              jQuery("#crane").attr("style","display:;") ;
	            }
	          </script>
      </ul>
    </div>
    <input type="hidden" name="order" id="order" />
    <input type="hidden" name="keyword" id="key_word" />
  </form>  

	
    <div style="clear:both; padding:0px 0px 10px;">
        <a href="/tuan/" target="_blank"><img src="/images/ymt_ad.gif" width="757" height="70"></a>
    </div>
    <div class="w755 l border03 listTop">
    <div class="l" id="showorder"> <strong>排序</strong> <a href="javascript:;" onclick="javascript:sosuo('','','','',1,'');" class="select">默认</a> <a href="javascript:;" onclick="javascript:sosuo('','','','',0,'');">热度</a> </div>
    <div class="r"> <span><b> </b>&nbsp;&nbsp;共</span><b>14056</b><span>款机型&nbsp;|</span> 
      <!--  <a href="javascript:void(0);" class="pre noPre"></a> <b>1/11</b> <a href="#" class="next"></a> --> 
      <a href="javascript:;" class="pre noPre" title="上一页">&nbsp;</a><b>1/1406</b><a href="?offset=10" class="next">&nbsp;</a> </div>
  </div>
  	<div class="plist">
    <ul id="showproducts">
      <!-- *************3个产品****************** -->
      

						
	<li>
		<a href="/proDetail/GD90-16CX.shtm" target="_blank"> <img src="/uploadfiles//image/2013/04/29/20130429092448_81.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="谷登机械GD90-16C水平定向钻" title="谷登机械GD90-16C水平定向钻">
		</a>
		<div class="w618 r">
			<h2>
				<a href="/proDetail/GD90-16CX.shtm" target="_blank">谷登机械GD90-16C水平定向钻</a>
			</h2>
			<span class="info"> <a href="?factory=13605&amp;catalog=105005">谷登机械水平定向钻</a><em>|</em><a href="/inquiry/?factory=13605&amp;catalog=105005" target="_blank">订单</a><em>|</em><a href="/photo/list.jsp?factoryid=13605&amp;catalogid=" target="_balnk">图片</a><em>|</em><a href="/proDetail/GD90-16CX.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/GD90-16CX_message.shtm" target="_blank">评论</a>
				 <a href="javascript:;" onclick="showinquery('16939','')" class="plbtn">询价</a></span>
			<div class="plInfo">1、发动机采用康明斯6CTA8.3-C24O工程机械专用，179KW；2、电路简单，故障率低；3、采用齿轮齿条推拉，效率高，工作平稳；维修和维护方便...<b><a href="/proDetail/GD90-16CX.shtm" target="_blank">[查看详情]</a> </b>
			</div>
		</div>
	</li>
						
	<li>
		<a href="/proDetail/HI-TECH200.shtm" target="_blank"> <img src="/uploadfiles//image/2013/05/20130510145155_584.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="韩泰克Hi-Tech200破碎锤" title="韩泰克Hi-Tech200破碎锤">
		</a>
		<div class="w618 r">
			<h2>
				<a href="/proDetail/HI-TECH200.shtm" target="_blank">韩泰克Hi-Tech200破碎锤</a>
			</h2>
			<span class="info"> <a href="?factory=403&amp;catalog=113001">韩泰克破碎锤</a><em>|</em><a href="/inquiry/?factory=403&amp;catalog=113001" target="_blank">订单</a><em>|</em><a href="/photo/list.jsp?factoryid=403&amp;catalogid=" target="_balnk">图片</a><em>|</em><a href="/proDetail/HI-TECH200.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/HI-TECH200_message.shtm" target="_blank">评论</a>
				 <a href="javascript:;" onclick="showinquery('3589','')" class="plbtn">询价</a></span>
			<div class="plInfo">设计先进的破碎技术·领先的热处理技术：增强抗热、抗磨损性能。·低耗油设计：在保证油压不变的情况下减小油缸体积，降低燃油消耗...<b><a href="/proDetail/HI-TECH200.shtm" target="_blank">[查看详情]</a> </b>
			</div>
		</div>
	</li>
						
      <!-- 付费会员选取产品 -->
      
      <li> <a href="/proDetail/SEM919.shtm" target="_blank"> <img src="/uploadfiles//image/2013/12/20131212083811_224.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="山工SEM919自行式平地机" title="山工SEM919自行式平地机"> </a>
        <div class="w618 r">
          <h2> <a href="/proDetail/SEM919.shtm" target="_blank">山工SEM919自行式平地机</a> </h2>
          <span class="info"> <a href="?factory=138&amp;catalog=101005">山工平地机</a><em>|</em><a href="/inquiry/?factory=138&amp;catalog=101005002" target="_blank">订单</a><em>|</em> 
<a href="/photo/list.jsp?factoryid=138&amp;catalogid=" target="_balnk">图片</a><em>|</em> 
<a href="/proDetail/SEM919.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/SEM919_message.shtm" target="_blank">评论</a>
<a href="javascript:;" onclick="showinquery('10965','')" class="plbtn">询价</a> </span>
<div class="plInfo">·国二排放配备增压中冷的发动机，扭矩储备大、动力强劲；·全新冷却系统设计，满足零下40°C~零上50°C环境温度工作要求；·国际先进技...<b><a href="/proDetail/SEM919.shtm" target="_blank">[查看详情]</a> </b> </div>
        </div>
      </li>
      
      <li> <a href="/proDetail/R505LC-7.shtm" target="_blank"> <img src="/uploadfiles//image/2013/01/20130131112045_739.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="现代R505LC-7履带式挖掘机" title="现代R505LC-7履带式挖掘机"> </a>
        <div class="w618 r">
          <h2> <a href="/proDetail/R505LC-7.shtm" target="_blank">现代R505LC-7履带式挖掘机</a> </h2>
          <span class="info"> <a href="?factory=194&amp;catalog=101001">现代挖掘机</a><em>|</em><a href="/inquiry/?factory=194&amp;catalog=101001001" target="_blank">订单</a><em>|</em> 
<a href="/photo/list.jsp?factoryid=194&amp;catalogid=" target="_balnk">图片</a><em>|</em> 
<a href="/proDetail/R505LC-7.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/R505LC-7_message.shtm" target="_blank">评论</a>
<a href="javascript:;" onclick="showinquery('15369','')" class="plbtn">询价</a> </span>
<div class="plInfo"><b><a href="/proDetail/R505LC-7.shtm" target="_blank">[查看详情]</a> </b> </div>
        </div>
      </li>
      
      <li> <a href="/proDetail/YX635.shtm" target="_blank"> <img src="/uploadfiles//image/2014/01/20140124145201_748.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="英轩重工YX635轮式装载机" title="英轩重工YX635轮式装载机"> </a>
        <div class="w618 r">
          <h2> <a href="/proDetail/YX635.shtm" target="_blank">英轩重工YX635轮式装载机</a> </h2>
          <span class="info"> <a href="?factory=1777&amp;catalog=101002">英轩重工装载机</a><em>|</em><a href="/inquiry/?factory=1777&amp;catalog=101002007" target="_blank">订单</a><em>|</em> 
<a href="/photo/list.jsp?factoryid=1777&amp;catalogid=" target="_balnk">图片</a><em>|</em> 
<a href="/proDetail/YX635.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/YX635_message.shtm" target="_blank">评论</a>
<a href="javascript:;" onclick="showinquery('15104','')" class="plbtn">询价</a> </span>
<div class="plInfo">●全景车窗，外观时尚；高强度整体式框架结构，安全性高；密封减震性好；豪华座椅，可选装空调，给用户提供舒适的操作环境；●采...<b><a href="/proDetail/YX635.shtm" target="_blank">[查看详情]</a> </b> </div>
        </div>
      </li>
      
      <li> <a href="/proDetail/SEM816.shtm" target="_blank"> <img src="/uploadfiles//image/2013/12/20131212083934_992.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="山工SEM816履带推土机" title="山工SEM816履带推土机"> </a>
        <div class="w618 r">
          <h2> <a href="/proDetail/SEM816.shtm" target="_blank">山工SEM816履带推土机</a> </h2>
          <span class="info"> <a href="?factory=138&amp;catalog=101003">山工推土机</a><em>|</em><a href="/inquiry/?factory=138&amp;catalog=101003001" target="_blank">订单</a><em>|</em> 
<a href="/photo/list.jsp?factoryid=138&amp;catalogid=" target="_balnk">图片</a><em>|</em> 
<a href="/proDetail/SEM816.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/SEM816_message.shtm" target="_blank">评论</a>
<a href="javascript:;" onclick="showinquery('15634','')" class="plbtn">询价</a> </span>
<div class="plInfo">1.传承卡特彼勒推土机105年设计经验，开发国内首款160马力-220马力静液压驱动履带式推土机。2.发动机满足中国StageII排放标准,提供可选的...<b><a href="/proDetail/SEM816.shtm" target="_blank">[查看详情]</a> </b> </div>
        </div>
      </li>
      
      <li> <a href="/proDetail/SEM8218.shtm" target="_blank"> <img src="/uploadfiles//image/2013/12/20131212084224_431.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="山工SEM8218单钢轮压路机" title="山工SEM8218单钢轮压路机"> </a>
        <div class="w618 r">
          <h2> <a href="/proDetail/SEM8218.shtm" target="_blank">山工SEM8218单钢轮压路机</a> </h2>
          <span class="info"> <a href="?factory=138&amp;catalog=106001">山工压路机</a><em>|</em><a href="/inquiry/?factory=138&amp;catalog=106001001" target="_blank">订单</a><em>|</em> 
<a href="/photo/list.jsp?factoryid=138&amp;catalogid=" target="_balnk">图片</a><em>|</em> 
<a href="/proDetail/SEM8218.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/SEM8218_message.shtm" target="_blank">评论</a>
<a href="javascript:;" onclick="showinquery('7449','')" class="plbtn">询价</a> </span>
<div class="plInfo">可靠的振动系统?卡特彼勒专利豆荚型偏心机构，双频双幅设计，可靠性更高，压实效果更卓越。?整体的激振室设计，维修保养和更换更加...<b><a href="/proDetail/SEM8218.shtm" target="_blank">[查看详情]</a> </b> </div>
        </div>
      </li>
      
      <li> <a href="/proDetail/ZTS.shtm" target="_blank"> <img src="/uploadfiles//image/2013/11/20131127131223_6.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="铁建重工ZTS泥水平衡盾构机" title="铁建重工ZTS泥水平衡盾构机"> </a>
        <div class="w618 r">
          <h2> <a href="/proDetail/ZTS.shtm" target="_blank">铁建重工ZTS泥水平衡盾构机</a> </h2>
          <span class="info"> <a href="?factory=1758&amp;catalog=110001">铁建重工盾构掘进机</a><em>|</em><a href="/inquiry/?factory=1758&amp;catalog=110001" target="_blank">订单</a><em>|</em> 
<a href="/photo/list.jsp?factoryid=1758&amp;catalogid=" target="_balnk">图片</a><em>|</em> 
<a href="/proDetail/ZTS.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/ZTS_message.shtm" target="_blank">评论</a>
<a href="javascript:;" onclick="showinquery('14845','')" class="plbtn">询价</a> </span>
<div class="plInfo">ZTS系列泥水平衡盾构机是一种集机、电、液压、传感、测量和信息技术于一体的隧道施工成套设备，适用于对沉降控制要求更高的渗水系...<b><a href="/proDetail/ZTS.shtm" target="_blank">[查看详情]</a> </b> </div>
        </div>
      </li>
      
      <li> <a href="/proDetail/SEM6020-23.shtm" target="_blank"> <img src="/uploadfiles//image/2013/12/20131212084313_71.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="山工SEM6020垃圾压实机" title="山工SEM6020垃圾压实机"> </a>
        <div class="w618 r">
          <h2> <a href="/proDetail/SEM6020-23.shtm" target="_blank">山工SEM6020垃圾压实机</a> </h2>
          <span class="info"> <a href="?factory=138&amp;catalog=106003">山工压实机</a><em>|</em><a href="/inquiry/?factory=138&amp;catalog=106003" target="_blank">订单</a><em>|</em> 
<a href="/photo/list.jsp?factoryid=138&amp;catalogid=" target="_balnk">图片</a><em>|</em> 
<a href="/proDetail/SEM6020-23.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/SEM6020-23_message.shtm" target="_blank">评论</a>
<a href="javascript:;" onclick="showinquery('13104','')" class="plbtn">询价</a> </span>
<div class="plInfo">·潍柴六缸、直列、水冷、四冲程、增压、干缸套、直喷式柴油发动机，可选低温启动装置。·液力变矩器和动力换挡变速箱、四轮驱动，...<b><a href="/proDetail/SEM6020-23.shtm" target="_blank">[查看详情]</a> </b> </div>
        </div>
      </li>
      
      <li> <a href="/proDetail/PSJZ.shtm" target="_blank"> <img src="/uploadfiles//image/2013/11/20131129173220_500.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="铁建重工喷射机组其它混凝土设备" title="铁建重工喷射机组其它混凝土设备"> </a>
        <div class="w618 r">
          <h2> <a href="/proDetail/PSJZ.shtm" target="_blank">铁建重工喷射机组其它混凝土设备</a> </h2>
          <span class="info"> <a href="?factory=1758&amp;catalog=103015">铁建重工其它混凝土设备</a><em>|</em><a href="/inquiry/?factory=1758&amp;catalog=103015" target="_blank">订单</a><em>|</em> 
<a href="/photo/list.jsp?factoryid=1758&amp;catalogid=" target="_balnk">图片</a><em>|</em> 
<a href="/proDetail/PSJZ.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/PSJZ_message.shtm" target="_blank">评论</a>
<a href="javascript:;" onclick="showinquery('20668','')" class="plbtn">询价</a> </span>
<div class="plInfo"><b><a href="/proDetail/PSJZ.shtm" target="_blank">[查看详情]</a> </b> </div>
        </div>
      </li>
      
      <li> <a href="/proDetail/SJJJJ.shtm" target="_blank"> <img src="/uploadfiles//image/2013/11/20131129131442_53.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="铁建重工竖井掘进机矿用掘进机" title="铁建重工竖井掘进机矿用掘进机"> </a>
        <div class="w618 r">
          <h2> <a href="/proDetail/SJJJJ.shtm" target="_blank">铁建重工竖井掘进机矿用掘进机</a> </h2>
          <span class="info"> <a href="?factory=1758&amp;catalog=110002">铁建重工矿用掘进机</a><em>|</em><a href="/inquiry/?factory=1758&amp;catalog=110002" target="_blank">订单</a><em>|</em> 
<a href="/photo/list.jsp?factoryid=1758&amp;catalogid=" target="_balnk">图片</a><em>|</em> 
<a href="/proDetail/SJJJJ.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/SJJJJ_message.shtm" target="_blank">评论</a>
<a href="javascript:;" onclick="showinquery('20664','')" class="plbtn">询价</a> </span>
<div class="plInfo"><b><a href="/proDetail/SJJJJ.shtm" target="_blank">[查看详情]</a> </b> </div>
        </div>
      </li>
      
      <li> <a href="/proDetail/LG855D.shtm" target="_blank"> <img src="/uploadfiles//image/2013/08/20130802145048_764.jpg" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="130" height="90" class="plimg" alt="龙工LG855D轮式装载机" title="龙工LG855D轮式装载机"> </a>
        <div class="w618 r">
          <h2> <a href="/proDetail/LG855D.shtm" target="_blank">龙工LG855D轮式装载机</a> </h2>
          <span class="info"> <a href="?factory=135&amp;catalog=101002">龙工装载机</a><em>|</em><a href="/inquiry/?factory=135&amp;catalog=101002007" target="_blank">订单</a><em>|</em> 
<a href="/photo/list.jsp?factoryid=135&amp;catalogid=" target="_balnk">图片</a><em>|</em> 
<a href="/proDetail/LG855D.shtm" target="_blank">参数</a><em>|</em><a href="/proDetail/LG855D_message.shtm" target="_blank">评论</a>
<a href="javascript:;" onclick="showinquery('15879','')" class="plbtn">询价</a> </span>
<div class="plInfo">1、采用龙工专用的潍柴斯太尔WD10G210E24低转速柴油机（1900r/min）,对变矩器进行合理匹配，优化设计，低油耗、低噪音、低磨损,节能减排、...<b><a href="/proDetail/LG855D.shtm" target="_blank">[查看详情]</a> </b> </div>
        </div>
      </li>
      
    </ul>
  </div>
  	<div class="telTip">如果没有找到您的信息，请直接致电：<strong>4006-521-526</strong></div>
    <div class="w755 l">
    <div id="pagination" class="page">
      <div class="paging page" id="pagination"><a class="pre noPre" title="上一页" href="javascript:;"></a> <span class="current"><b>&nbsp;1&nbsp;</b></span><a class="num" href="?offset=10&amp;catalog=101001001">&nbsp;2&nbsp;</a><a class="num" href="?offset=20&amp;catalog=101001001">&nbsp;3&nbsp;</a><a class="num" href="?offset=30&amp;catalog=101001001">&nbsp;4&nbsp;</a><a class="num" href="?offset=40&amp;catalog=101001001">&nbsp;5&nbsp;</a><a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a><a class="num" href="?offset=860&amp;catalog=101001001">&nbsp;87&nbsp;</a><a class="num" href="?offset=870&amp;catalog=101001001">&nbsp;88&nbsp;</a><a href="?offset=10&amp;catalog=101001001" class="next"></a></div>
    </div>
  </div>
  </div>
  <!--right end-->
  <div class="clear"></div>
  <div class="contain980 mb10">
    <div class="title04">
      <h2>履带式挖掘机最新订单 </h2>
      <span><a href="/inquiry/?catalog=101001001" target="_blank">更多&gt;&gt;</a> </span> </div>
    <div class="list04">
      <div id="MarqueeDiv" style="width: 978px; height: auto; overflow: hidden;">
        <ul>
          <li>
            <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_292504.htm" title="沃尔沃EC3500履带式挖掘机询价单">山西阳泉市的 王** 用户询问了<font>沃尔沃EC3500履带式挖掘机</font>的价格</a></div>
            <div class="t3"></div>
          </li>
          <li>
            <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_292490.htm" title="卡特彼勒320D2履带式挖掘机询价单">江苏苏州市的 杨** 用户询问了<font>卡特彼勒320D2履带式挖掘机</font>的价格</a></div>
            <div class="t3"></div>
          </li>
          <li>
            <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_292489.htm" title="三一SY225C-9履带式挖掘机询价单">江苏苏州市的 杨** 用户询问了<font>三一SY225C-9履带式挖掘机</font>的价格</a></div>
            <div class="t3"></div>
          </li>
          <li>
            <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_292488.htm" title="晋工JGM906履带式挖掘机询价单">安徽芜湖市的 赵** 用户询问了<font>晋工JGM906履带式挖掘机</font>的价格</a></div>
            <div class="t3"></div>
          </li>
          <li>
            <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_292485.htm" title="山重建机GC378LC-8履带式挖掘机询价单">江苏苏州市的 杨** 用户询问了<font>山重建机GC378LC-8履带式挖掘机</font>的价格</a></div>
            <div class="t3"></div>
          </li>
          <li>
            <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_292486.htm" title="卡特彼勒313D2履带式挖掘机询价单">江苏苏州市的 杨** 用户询问了<font>卡特彼勒313D2履带式挖掘机</font>的价格</a></div>
            <div class="t3"></div>
          </li>
          <li>
            <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_292487.htm" title="厦工XG822LC履带式挖掘机询价单">江苏苏州市的 杨** 用户询问了<font>厦工XG822LC履带式挖掘机</font>的价格</a></div>
            <div class="t3"></div>
          </li>
          <li>
            <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_292484.htm" title="三一SY225C-9履带式挖掘机询价单">江苏苏州市的 杨** 用户询问了<font>三一SY225C-9履带式挖掘机</font>的价格</a></div>
            <div class="t3"></div>
          </li>
          <li>
            <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_292482.htm" title="晋工JGM906履带式挖掘机询价单">安徽淮北市的 赵** 用户询问了<font>晋工JGM906履带式挖掘机</font>的价格</a></div>
            <div class="t3"></div>
          </li>
          <li>
            <div class="t2"><a target="_blank" href="http://product.21-sun.com/inquiry/detail_for_292479.htm" title="柳工925D履带式挖掘机询价单">新疆乌鲁木齐市的 系** 用户询问了<font>柳工925D履带式挖掘机</font>的价格</a></div>
            <div class="t3"></div>
          </li>
        </ul>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true" />
<!--foot end--> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</cache:cache>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
