<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
     String agent_id = CommonString.getFormatPara(request.getParameter("agent_id"));
	Map brandMap = (Map) application.getAttribute("brandMap");
    Map catalogMap = (Map) application.getAttribute("catalogMap");
   
	try{
	   
		 Connection connection = null;
	     DBHelper dbHelper = DBHelper.getInstance();
	     connection = dbHelper.getConnection();
		//TDK
		String newTitle="工程机械";
		String newDesc="工程机械";
		String newTitleEnd="工程机械";
		String showtonandmeter="";String keyword="";
		String keywords1="";String keywords2="";String keywords3="";String keywords4="";String keywords5="";
		if(!"".equals(factory)){keywords1=CommonString.getFormatPara(brandMap.get(factory))+"价格表,";}
        if(!"".equals(catalog)){keywords2=CommonString.getFormatPara(catalogMap.get(catalog))+"价格表,";}
		if(!"".equals(catalog)&&!"".equals(factory)){keywords3=CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特")+CommonString.getFormatPara(catalogMap.get(catalog))+"价格表";}
		if(!"".equals(catalog)&&!"".equals(factory)&&!"".equals(showtonandmeter)){keywords5=showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog))+",";}
		String newKeyWord=keywords5+keywords4+keywords2+keywords1+keywords3;
		if(newKeyWord.equals("")){newKeyWord="工程机械,工程机械价格表,工程机械产品大全";}
		else if(newKeyWord.endsWith(",")){newKeyWord=newKeyWord.substring(0,newKeyWord.length()-1);}
		
		if(!"".equals(factory)&&!"".equals(catalog)){
		       newTitle=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		       newDesc=("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		       newTitleEnd=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(catalogMap.get(catalog));
		}else if(!"".equals(factory)||!"".equals(catalog)){
		
		   newTitle=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   newDesc=("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   if("".equals(catalog)){
		   		   newTitleEnd=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog))+"产品";
		   }else{
		   		   newTitleEnd=keyword+showtonandmeter +("".equals(factory) ? "" : CommonString.getFormatPara(brandMap.get(factory)))+CommonString.getFormatPara(catalogMap.get(catalog));
		   }
		}
		
		String catalognum_new=catalog;
		String catalogName="";
			Map catalog_numNew=null;
		
			 catalog_numNew = dbHelper.getMap("select catalog_num from pro_catalog where num='"+catalog+"' and  is_show=1 ",connection) ;
			
			if(catalog_numNew!=null&&catalog_numNew.size()>0){
		    catalognum_new=CommonString.getFormatPara(catalog_numNew.get("catalog_num"));}
			whereStr.append(" and catalognum_new like '%" + catalognum_new + "%'");
			catalogName=CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机");
			 
		
		
			//代理商
		List<Map> list = dbHelper.getMapList("select  id,full_name,name,city,agent_fac_name,address,img1 from pro_agent_factory where id="+agent_id,connection) ;
		//所有类别
		List<Map> list1 = dbHelper.getMapList("select  name,num from pro_catalog where parentid=0 order by id desc",connection) ;
		
		catalogMap.put("104002011","其他环卫机械");
		catalogMap.put("119001","其他煤炭机械");
		catalogMap.put("103015","水泥运输车");
		catalogMap.put("104002","其他养护机械");
		catalogMap.put("105017","强夯机液压步履式桩架");
		catalogMap.put("103005002","布料机");
		catalogMap.put("103002","混凝土搅拌站");
		catalogMap.put("103018","拖泵");
		catalogMap.put("103001","泵车");
		catalogMap.put("103019","搅拌运输车");
		catalogMap.put("103018001","柴油拖泵");
		catalogMap.put("103018002","电动拖泵");
		catalogMap.put("101001001","履带式挖掘机");
		catalogMap.put("102008","履带式起重机");
		catalogMap.put("101003001","履带式推土机");
		
	
		
%><!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<title>【底价】工程机械_工程机械价格表_工程机械大全 - 铁臂商城</title>
<meta name="keywords" content="工程机械,工程机械价格表,工程机械产品大全" />
<meta name="description" content="铁臂商城工程机械专区,为您提供工程机械价格、工程机械型号、工程机械图片等详细信息,帮您全面了解工程机械,买工程机械产品就上铁臂商城。" />
<link href="Static/css/style.css" rel="stylesheet" />
<script src="/scripts/jquery-1.7.min.js"></script>
<script src="/scripts/scripts.js"></script>
</head>
<body>
<div style="text-align:center"><a href="http://sany.815.21-sun.com/m/index.html" target="_blank"><img src="Static/img/banner.jpg" alt=""></a></div>
<header>
  <h2 class="logo"><img src="Static/img/logo.png" alt="铁臂商城"></h2>
  <a href="javascript:history.back()" class="bc"><img src="Static/img/back.png"></a> <a href="/brands_list.jsp" class="search">筛选<img src="Static/img/search_ico.png"></a> </header>
<div class="dl_top">
  <ul class="fix">
    <li><a href="javascript:;" class="dl_top_t" id="dl_brand_list"><b></b>品牌</a></li>
    <li><a href="javascript:;" class="dl_top_t" id="dl_area_list"><b></b>区域</a></li>
    <li class="s"><a href="javascript:;" class="dl_top_t" id="dl_cg_list"><b></b>类别</a></li>
  </ul>
</div>
<div class="dl_list">
  <ul>
  <%
  if (list != null && list.size() > 0) {
			for (Map oneMap : list) {
  %>
    <li><a href="#"><img src="<%=CommonString.getFormatPara(oneMap.get("img1"))%>" class="img l" alt="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>">
      <div class="r">
        <h3 class="dl_list_t"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></h3>
        <div class="t">主营品牌：<span>[<%=CommonString.getFormatPara(oneMap.get("agent_fac_name"))%>]</span></div>
        <div  class="t">代理区域：<span><%=CommonString.getFormatPara(oneMap.get("city"))%></span></div>
        <div  class="t">详细地址：<span><%=CommonString.getFormatPara(oneMap.get("address"))%></span></div>
      </div>
      </a></li>
	  <%}}%>
  </ul>
</div>
<div class="dl_detail">
  <h3><a href="#" class="more">更多</a>卡特挖掘机</h3>
  <ul class="fix">
    <li><a href="#"><img src="Static/img/dl_detial.jpg" class="img"> <strong>卡特彼勒307E挖掘机</strong> </a><a class="btn dj" href="#"><img src="Static/img/dl_btn_bg_06.png">询问底价</a><a class="btn dg" href="#"><img src="Static/img/dl_btn_bg_03.png">立即订购</a></li>
    <li><a href="#"><img src="Static/img/dl_detial.jpg" class="img"> <strong>卡特彼勒307E挖掘机</strong> </a><a class="btn dj" href="#"><img src="Static/img/dl_btn_bg_06.png">询问底价</a><a class="btn dg" href="#"><img src="Static/img/dl_btn_bg_03.png">立即订购</a></li>
  </ul>
</div>
<div class="dl_detail mt10">
  <h3><a href="#" class="more">更多</a>卡特挖掘机</h3>
  <ul class="fix">
    <li><a href="#"><img src="Static/img/dl_detial.jpg" class="img"> <strong>卡特彼勒307E挖掘机</strong> </a><a class="btn dj" href="#"><img src="Static/img/dl_btn_bg_06.png">询问底价</a><a class="btn dg" href="#"><img src="Static/img/dl_btn_bg_03.png">立即订购</a></li>
    <li><a href="#"><img src="Static/img/dl_detial.jpg" class="img"> <strong>卡特彼勒307E挖掘机</strong> </a><a class="btn dj" href="#"><img src="Static/img/dl_btn_bg_06.png">询问底价</a><a class="btn dg" href="#"><img src="Static/img/dl_btn_bg_03.png">立即订购</a></li>
  </ul>
</div>
<div class="dl_p">
<h3>关于我们</h3>
<p>&nbsp;&nbsp;&nbsp;&nbsp;北京融世杰机械设备有限公司竭诚为广大客户提供欧美一流的品牌产品、技术和售后服务。 融世杰公司汇集了众多优秀的员工，以脚踏实地、追求卓越的工作作风，在港口、煤炭、铁路、公路、市政、水电、钢</p>
</div>
<div class="dl_p">
<h3>联系方式</h3>
<p>联系人：代邵先 <br>
代理地区：云南 <br>
地址：云南省昆明市西山区百集龙B座816室 <br>
邮箱：596422822@qq.com </p>
</div>
<!--下拉遮罩-->
<div class="zy"></div>
<!--品牌下拉列表-->
<div class="dl_brand_list dl_sele fix">
  <ul>
    <li><a href="#" class="selected">卡特彼勒</a></li>
    <li><a href="#">卡特彼勒</a></li>
    <li><a href="#">卡特彼勒</a></li>
    <li><a href="#">卡特彼勒</a></li>
    <li><a href="#">卡特彼勒</a></li>
    <li><a href="#">卡特彼勒</a></li>
    <li><a href="#">卡特彼勒</a></li>
  </ul>
  <div class="dl_sele_btm"></div>
</div>
<!--end品牌下拉列表--> 
<!--区域下拉列表-->
<div class="dl_area_list dl_sele fix">
  <div class="l dl_sele_l">
    <ul class="idTabs dl_sele_l_ls">
      <li><a href="#area01" class="selected">山东<i>112</i></a></li>
      <li><a href="#area02">山东<i>2245</i></a></li>
      <li><a href="#area03">山东<i>25</i></a></li>
      <li><a href="#area04">山东<i>25</i></a></li>
      <li><a href="#area05">山东<i>25</i></a></li>
      <li><a href="#area06">山东<i>25</i></a></li>
      <li><a href="#area07">山东<i>25</i></a></li>
      <li><a href="#area08">山东<i>25</i></a></li>
    </ul>
  </div>
  <div class="r dl_sele_r">
    <div class="dl_sele_r_ls" id="area01">
      <ul>
        <li><a href="#"><span>420</span>烟台1</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area02">
      <ul>
        <li><a href="#"><span>420</span>烟台2</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area03">
      <ul>
        <li><a href="#"><span>420</span>烟台3</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area04">
      <ul>
        <li><a href="#"><span>420</span>烟台4</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area05">
      <ul>
        <li><a href="#"><span>420</span>烟台5</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area06">
      <ul>
        <li><a href="#"><span>420</span>烟台6</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area07">
      <ul>
        <li><a href="#"><span>420</span>烟台7</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area08">
      <ul>
        <li><a href="#"><span>420</span>烟台8</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
        <li><a href="#"><span>420</span>烟台</a></li>
      </ul>
    </div>
  </div>
  <div class="dl_sele_btm"></div>
</div>
<!--end 区域下拉列表 --> 
<!--类别下拉列表-->
<div class="dl_cg_list dl_sele fix">
  <h3 class="dl_cg_t">全部产品</h3>
  <div class="l dl_sele_l">
    <ul class="idTabs dl_sele_l_ls">
      <li><a href="#cg01" class="selected">山东临工</a></li>
      <li><a href="#cg02">山东临工</a></li>
      <li><a href="#cg03">山东临工</a></li>
      <li><a href="#cg04">山东临工</a></li>
      <li><a href="#cg05">山东临工</a></li>
      <li><a href="#cg06">山东临工</a></li>
      <li><a href="#cg07">山东临工</a></li>
      <li><a href="#cg08">山东临工</a></li>
    </ul>
  </div>
  <div class="r dl_sele_r">
    <div class="dl_sele_r_ls" id="cg01">
      <ul>
        <li><a href="#">挖掘机1</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="cg02">
      <ul>
        <li><a href="#">挖掘机41</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="cg03">
      <ul>
        <li><a href="#">挖掘机11</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="cg04">
      <ul>
        <li><a href="#">挖掘机131</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="cg05">
      <ul>
        <li><a href="#">挖掘机131</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="cg06">
      <ul>
        <li><a href="#">挖掘机21</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="cg07">
      <ul>
        <li><a href="#">挖掘机11</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="cg08">
      <ul>
        <li><a href="#">挖掘机8</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
        <li><a href="#">挖掘机</a></li>
      </ul>
    </div>
  </div>
  <div class="dl_sele_btm"></div>
</div>
<!--end 类别下拉列表-->
<div class="bottomBar">
  <div class="share bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></div>
  <div class="tel"><a href="tel:4006-521-526"><img src="Static/img/tel_ico.png"><span>4006-521-526</span></a></div>
  <div class="comment"><a href="http://koubei.21-sun.com/"><img src="Static/img/com_btn.png" class="io">评论</a></div>
</div>
<img src="http://hm.baidu.com/hm.gif?si=68a002ecc1238a0d146069ac0b00940e&amp;et=0&amp;nv=0&amp;st=4&amp;lt=1408518877&amp;v=wap-2-0.3&amp;rnd=1876828651" width="0" height="0"  /> <img src="http://c.cnzz.com/wapstat.php?siteid=5923031&r=&rnd=67932853" width="0" height="0"  />
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://"); document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F68a002ecc1238a0d146069ac0b00940e' type='text/javascript'%3E%3C/script%3E")); </script>
<script>
	var jrChannel='0#0';
	seajs.use('app/index.js');
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>