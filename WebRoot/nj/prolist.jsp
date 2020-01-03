<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString,java.sql.Connection,com.jerehnet.util.dbutil.*"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@page import="com.jerehnet.util.common.CommonHtml"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	StringBuffer whereStr = new StringBuffer("  and is_show=1  ") ;
	Map machineCatalogMap = (Map) application.getAttribute("machineCatalogMap");
	Map machineBrandMap=(Map)application.getAttribute("machineBrandMap");
    Map brandProMap=(Map)application.getAttribute("machineBrandProMap");
	Map cataProMap=(Map)application.getAttribute("machineCataProMap");
 	if(brandProMap==null){
		brandProMap=new HashMap();
	}
	if(cataProMap==null){
		cataProMap=new HashMap();
	}
 
	String h1="农机";
	
	String factory = CommonString.getFormatPara(request.getParameter("factory")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String order = CommonString.getFormatPara(request.getParameter("order")) ;
	String keyword = CommonString.getFormatPara(request.getParameter("keyword")) ;
	String factoryids= CommonString.getFormatPara(request.getParameter("factoryids"));
	String factoryids_str="";
	String factoryNames="";
	String  factoryArray[]=null;
	if(!factoryids.equals("")){
		factoryArray=factoryids.split(",");
	}
	if (!"".equals(factoryids)) { 
	   	for(int i=0;i<factoryArray.length;i++){
	        factoryids_str+="brand_id="+CommonString.getFormatPara(factoryArray[i])+" or  ";
			factoryNames+=CommonString.getFormatPara(machineBrandMap.get(CommonString.getFormatPara(factoryArray[i])))+",";
	    }
		factoryNames=factoryNames.substring(0,factoryNames.length()-1);
		factoryids_str=factoryids_str+"brand_id=0";
		whereStr.append(" and ("+factoryids_str+")");
	}
    if(!keyword.equals("")){
		whereStr.append(" and (brand_name+name+catalog_name) like '%"+keyword+"%'");
	}

	if(!factory.equals("")){
		whereStr.append(" and brand_id="+factory);
	}
	if(!catalog.equals("")){
		whereStr.append(" and catalog_num like '%"+catalog+"%'");
	}
	if(!factory.equals("")||!catalog.equals("")||!factoryids.equals("")||!keyword.equals("")){
		h1=keyword+factoryNames+CommonString.getFormatPara(machineBrandMap.get(factory))+CommonString.getFormatPara(machineCatalogMap.get(catalog));
	}
	int pageSize=16;
	DBHelper dbHelper = DBHelper.getInstance();
	PageBean pageBean = new PageBean() ; // 分页程序
	pageBean.setPageSize(16) ; // 每页显示条数
	pageBean.setOrderBy(" id desc ");
	if(order.equals("sale")){
		pageBean.setOrderBy(" inquiry_count desc ");
	}
	if(order.equals("view")){
		pageBean.setOrderBy(" view_count desc ");
	
	}
	pageBean.setCondition(whereStr.toString());
	Integer nowPage = 1 ;
	if(!"".equals(offset) && !"0".equals(offset)){
		nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
	}
	pageBean.setNowPage(nowPage) ;   
	String url = CommonString.getFormatPara(request.getQueryString()) ;
	if(!"".equals(url)){
		if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
			url="" ;
		}else if(url.indexOf("offset")!=-1 ){
			url = "&"+url.substring(url.indexOf("&")+1) ;
		}else{
			url = "&"+url ;
		}
	}	
	if(offset.equals("")){
		offset="0";
	}
	pageBean.setParams(url) ;
    pageBean.setFields("*") ;
    pageBean.setTableName("pro_machine_products") ;
	Connection connection = null;
	List<Map> prolist =null;
	List<Map> brandList=null;
	List<Map> brandLetterList=null;
	int pageCount=0;
	try{
		connection = dbHelper.getConnection();
		prolist = pageBean.getDatas() ;
        pageCount=	pageBean.getPageCount();	
		if(!catalog.equals("")){
		    brandList = dbHelper.getMapList("select name,id,first_letter  from pro_machine_brand where  is_show=1  and  id in(select distinct(brand_id) from pro_machine_products  where is_show=1 and catalog_num like '%"+catalog+"%')  order by  first_letter  asc",connection) ;
		    brandLetterList = dbHelper.getMapList("select first_letter  from pro_machine_brand where   is_show=1  and  id in(select distinct(brand_id) from pro_machine_products  where is_show=1 and catalog_num like '%"+catalog+"%')  group by first_letter  order by first_letter asc",connection) ;
	    }else{
		    brandList = dbHelper.getMapList("select name,id,first_letter  from pro_machine_brand where  is_show=1   order by  first_letter asc",connection) ;
		    brandLetterList = dbHelper.getMapList("select first_letter  from pro_machine_brand where    is_show=1   group by first_letter   order by first_letter asc",connection) ;
		}	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	

%>
<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<meta name="renderer" content="webkit">
<title>【报价】<%=h1%>_<%=h1%>价格表_<%=h1%>大全 - 铁臂商城</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="<%=h1%>,<%=h1%>价格表,<%=h1%>产品大全" />
<meta name="description" content="铁臂商城<%=h1%>专区,为您提供<%=h1%>价格、<%=h1%>型号、<%=h1%>图片等详细信息,帮您全面了解<%=h1%>,买<%=h1%>产品就上铁臂商城。" />
<script type="text/javascript" src="/nj/Static/app/mobile.js"></script>
<link href="/nj/Static/grid/grid12.css" rel="stylesheet" />
<link href="/nj/Static/css/ui.css" rel="stylesheet" />
<link href="/nj/Static/css/common.css" rel="stylesheet" />
<link href="/nj/Static/css/style.css" rel="stylesheet" />
<!--[if lt IE 9]><script src="/nj/Static/lib/H5shiv.js"></script><![endif]-->
<script type="text/javascript" src="/nj/scripts/jquery.min.js"></script>
<style>
.txd_nleft {
	width: 228px;
}
.list04 ul li {
	height: 20px;
	float: left;
	border-right: #d8d8d8 0px solid;
	padding: 0px 22px;
}
</style>
</head>
<body>
<!--top-->
<!--topBar-->
<div class="j_topBar">
  <div class="wrap fix">
    <div class="j_wel l j_grey" id="topLabel"><a href="http://www.21-sun.com/" target="_blank">欢迎您访问中国工程机械商贸网！</a><a href="http://product.21-sun.com/user/login.htm"  target="_blank">[登录]</a>&nbsp;&nbsp;<a href="http://product.21-sun.com/user/reg.htm" target="_blank">[注册]</a></div>
    <ul class="j_t_layer r">
      <li class="j_tl j_wei"><a href="http://www.21-sun.com/weixin/" target="_blank"><img width="74" height="20" style="margin-top:4px;" src="http://www.21-sun.com/weixin/images/weixin.jpg"></a></li>
      <li class="j_tl j_mobile">
        <div class="j_con"> <span class="j_n"><i class="ico"></i>手机商城<i class="ico ico1_3"></i></span>
          <div class="j_tlayer">
            <div><a href="http://www.21-sun.com/app/" target="_blank" rel="nofollow">手机商贸网</a></div>
            <div><a href="http://www.21-sun.com/app/phone_news.htm" target="_blank" rel="nofollow">工程机械动态</a></div>
            <div><img src="/nj/Static/images/ewm01.png" class="j_ewm">行业讯息</div>
            <div style="border:none;"><img src="/nj/Static/images/ewm02.png" class="j_ewm">铁臂商城微信</div>
          </div>
        </div>
      </li>
      <li class="j_tl j_about">
        <div class="j_con"> <span class="j_n"><a href="http://product.21-sun.com/about/" target="_blank" rel="nofollow">关于铁臂</a></span> </div>
      </li>
      <li class="j_tl j_siteNav">
        <div class="j_con"> <span class="j_n">网站导航<i class="ico ico1_3"></i></span>
          <div class="j_tlayer">
            <ul class="fix">
              <li onClick="window.open('http://product.21-sun.com/');">铁臂商城</li>
              <li onClick="window.open('http://photo.21-sun.com/');">产品图库</li>
              <li onClick="window.open('http://weixiu.21-sun.com/');">维　　修</li>
              <li onClick="window.open('http://koubei.21-sun.com/');">口　　碑</li>
              <li onClick="window.open('http://market.21-sun.com/');">供求市场</li>
              <li onClick="window.open('http://news.21-sun.com/');">行业动态</li>
              <li onClick="window.open('http://used.21-sun.com/');">二手设备</li>
              <li onClick="window.open('http://www.21-sun.com/part/');">配件市场</li>
              <li onClick="window.open('http://www.21part.com/');">杰 配 网</li>
              <li onClick="window.open('http://www.21-sun.com/supply/');">供 应 商</li>
              <li onClick="window.open('http://www.21taiyang.com/');">太阳商城</li>
              <li onClick="window.open('http://www.wajueji.com/');">铁臂兄弟连</li>
              <li onClick="window.open('http://dealer.21-sun.com/');">代理商</li>
              <li onClick="window.open('http://product.21-sun.com/about/case.htm');">旗舰店</li>
            </ul>
          </div>
        </div>
      </li>
      <li class="j_tl j_proNav">
        <div class="j_con topBigGuide"><span class="j_n">购机导航<i class="ico ico1_3"></i></span></div>
      </li>
    </ul>
  </div>
</div>
<!--topBar end-->
<!--top-->
<div class="wrap fix n_top">
  <h1 class="new_logo"> <a href="/nj/" title="铁臂商城"> <img src="/nj/Static/images/logo.png" alt="铁臂商城"> <span class="columnName">农机</span> </a> </h1>
  <div class="n_topSearch">
    <div class="input">
      <input id="keyword" name="keyword" type="text" placeholder="输入您要搜索的产品" />
    </div>
    <button onClick="tj3()" type="button" class="topBtn">搜索</button>
    <div class="n_hotwords"> <span>热门搜索：</span> <a href="/nj/prolist.jsp?catalog=102" >拖拉机</a> <a href="/nj/prolist.jsp?catalog=103">耕整地机械</a> <a href="/nj/prolist.jsp?catalog=104"  >种植施肥机械</a> <a href="/nj/prolist.jsp?catalog=105">收割/收获机</a> <a href="/nj/prolist.jsp?catalog=106" >农产品加工机械</a> <a href="/nj/prolist.jsp?catalog=107" >灌溉机械</a> </div>
  </div>
  <script>
  	  function tj3(){ 
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.location.href="/nj/prolist.jsp?keyword="+keyword;
	  }
	   $('#keyword').on('keydown', function (e) { if (e.keyCode == 13) {tj3()} })
  </script>
</div>
<!--top end-->
<!--nav-->
<div class="navBox">
  <div class="navBar">
    <div class="wrap fix">
      <ul class="menu">
        <li><a href="/nj/">首页</a></li>
        <li><a <%if(catalog.indexOf("102")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=102">拖拉机</a></li>
        <li><a <%if(catalog.indexOf("103")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=103">耕整地机械</a></li>
        <li><a <%if(catalog.indexOf("104")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=104">种植施肥机械</a></li>
        <li><a <%if(catalog.indexOf("105")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=105">收割/收获机</a></li>
        <li><a <%if(catalog.indexOf("106")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=106">农产品加工机械</a></li>
        <li><a <%if(catalog.indexOf("107")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=107">灌溉机械</a></li>
		<li><a <%if(catalog.equals("")){%>class="active"<%}%> href="/nj/prolist.jsp">更多</a></li>
		</ul>
    </div>
  </div>
</div>
<!--nav end-->
<!--top end-->
<!--main-->
<div class="txd_nmain">
  <div class="wrap fix listbg">
    <div class="txd_nleft" id="left_condition">
      <div class="allCates_">
        <div class="acn">全部分类</div>
      </div>
      <div class="txd_nlant"></div>
      <div class="txd_filter t_tab">
        <div class="t_tab_val">
          <div class="leftHeight">
            <div class="txd_filter_val">
              <ul class="fix txd_filter_plist txd_filter_plist_cat">
                <li class="LiFirst"> <a href="/nj/prolist.jsp?catalog=102"  title="拖拉机">拖拉机</a>
                  <div class="txd_filter_pnc"  style="background-color: white;height:584px">
                    <ul class="fix">
                      <li><a href="/nj/prolist.jsp?catalog=102001"  title="轮式拖拉机">轮式拖拉机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=102002"  title="手扶拖拉机">手扶拖拉机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=102003"  title="履带拖拉机">履带拖拉机</a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="/nj/prolist.jsp?catalog=103"  title="耕整地机械">耕整地机械</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:583px; padding-top:1px;">
                    <ul class="fix" >
                      <br>
                      <li><a href="/nj/prolist.jsp?catalog=103001"  title="旋耕机">旋耕机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=103002"  title="微耕机">微耕机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=103003"  title="耕整机">耕整机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=103004"  title="深松机">深松机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=103005"  title="钉齿耙">钉齿耙</a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="/nj/prolist.jsp?catalog=104"  title="种植施肥机械">种植施肥机械</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:582px; padding-top:2px;">
                    <ul class="fix" >
                      <br>
                      <br>
                      <li><a href="/nj/prolist.jsp?catalog=104001"  title="播种机">播种机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=104002"  title="插秧机">插秧机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=104003"  title="施肥机">施肥机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=104004"  title="地膜机">地膜机</a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="/nj/prolist.jsp?catalog=105"  title="收割/收获机">收割/收获机</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:581px; padding-top:3px;">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <li><a href="/nj/prolist.jsp?catalog=105001"  title="玉米收割/收获机">玉米收割/收获机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=105002"  title="稻麦收割机">稻麦收割机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=105003"  title="谷物收割机">谷物收割机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=105004"  title="打捆机">打捆机</a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="/nj/prolist.jsp?catalog=106"  title="农产品加工机械">农产品加工机械</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:580px; padding-top:4px;">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="/nj/prolist.jsp?catalog=106001"  title="脱粒机">脱粒机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=106002"  title="剥壳（去皮）机">剥壳（去皮）机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=106003"  title="烘干机">烘干机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=106004"  title="碾米机">碾米机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=106005"  title="榨油机">榨油机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=106006"  title="精选机">精选机</a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="/nj/prolist.jsp?catalog=107"  title="灌溉机械">灌溉机械</a>
                  <div class="txd_filter_pnc"  style="background-color: white;height:579px; padding-top:5px;">
                    <ul class="fix">
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="/nj/prolist.jsp?catalog=107001"  title="水泵">水泵</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=107002"  title="喷灌机">喷灌机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=107003"  title="喷洒机">喷洒机</a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="/nj/prolist.jsp?catalog=108"  title="农作管理">农作管理</a>
                  <div class="txd_filter_pnc"  style="background-color: white;height:578px; padding-top:6px;">
                    <ul class="fix">
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="/nj/prolist.jsp?catalog=108001"  title="喷雾机">喷雾机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=108002"  title="除草机">除草机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=108003"  title="中耕机">中耕机</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=108004"  title="培土机">培土机</a></li>
                    </ul>
                  </div>
                </li>
                <li> <a href="/nj/prolist.jsp?catalog=109"  title="运输机械">运输机械</a>
                  <div class="txd_filter_pnc"  style="background-color: white;height:577px; padding-top:7px;">
                    <ul class="fix">
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="/nj/prolist.jsp?catalog=109001"  title="三轮运输车">三轮运输车</a></li>
                      <li><a href="/nj/prolist.jsp?catalog=109002"  title="四轮运输车">四轮运输车</a></li>
                    </ul>
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div class="txd_nlant"></div>
    </div>
    <div class="txd_nright">
      <!--面包屑-->
      <div class="breadCrumbs"> 我的位置：<a href="/nj/">农机首页</a>
	    <%if(!factory.equals("")){%> <em>&gt;&gt;</em><a href="/nj/prolist.jsp?factory=<%=factory%>" ><%=CommonString.getFormatPara(machineBrandMap.get(factory)) %></a><%}%>
	    <%if(!catalog.equals("")){%> <em>&gt;&gt;</em><a href="/nj/prolist.jsp?catalog=<%=catalog%>" ><%=CommonString.getFormatPara(machineCatalogMap.get(catalog))%></a><%}%>
		<%if(!factory.equals("")&&!catalog.equals("")){%> <em>&gt;&gt;</em><%=CommonString.getFormatPara(machineBrandMap.get(factory))+CommonString.getFormatPara(machineCatalogMap.get(catalog))%><%}%>
	  </div>
      <!--面包屑 end-->
      <!--筛选-->
      <div id="main1">
        <div id="main"  style="background-color:white">
          <div class="filter fix" >
            <div class="filter_hd" style="background-color:white">
              <h1 class="_n"><%=h1%></h1>
              <span class="_tip">搜索到<%=pageBean.getTotal()%>件相关商品</span> <span style="float:right;padding-right:10px;display:none" id="show_tj"><a class="on" style="color:#fe6000" href="javascript:void(0)" id="show_select">显示筛选条件</a></span> </div>
            <%if(!catalog.equals("")||!factory.equals("")){%>
            <div class="j_Prop attr" id="select_condition">
              <div class="attrKey">已选条件</div>
              <div class="attrValues selectValues">
                <ul class="select_val">
				   <%if(!factory.equals("")){%>
                   <li><a href="/nj/prolist.jsp<%=catalog.equals("")?"":"?catalog="+catalog%>" title="<%=CommonString.getFormatPara(machineBrandMap.get(factory))%>">品牌：<strong><%=CommonString.getFormatPara(machineBrandMap.get(factory))%></strong></a><b></b></li>
				   <%}%>
				   <%if(!catalog.equals("")){%>
				      <%if(catalog.length()==3){%>
				      <li><a href="/nj/prolist.jsp<%=factory.equals("")?"":"?factory="+factory%>" title="<%=CommonString.getFormatPara(machineCatalogMap.get(catalog))%>">类别：<strong><%=CommonString.getFormatPara(machineCatalogMap.get(catalog))%></strong></a><b></b></li>
					  <%}else{%>
					  <li><a href="/nj/prolist.jsp<%=factory.equals("")?"":"?factory="+factory%>" title="<%=CommonString.getFormatPara(machineCatalogMap.get(catalog))%>">类别：<strong><%=CommonString.getFormatPara(machineCatalogMap.get(catalog))%></strong></a><b></b></li>
                      <!--
					  <li><a href="/nj/prolist.jsp?catalog=<%=catalog.substring(0,3)%><%=factory.equals("")?"":"&factory="+factory%>" title="<%=CommonString.getFormatPara(machineCatalogMap.get(catalog))%>">类别：<strong><%=CommonString.getFormatPara(machineCatalogMap.get(catalog))%></strong></a><b></b></li>
                      -->					 
					 <%}%>
				   <%}%>
                </ul>
                <a href="/nj/prolist.jsp" class="resetFilter"><i class="ion"></i>重置筛选条件</a> </div>
            </div>
            <%}%>
            <%if(catalog.equals("")){%>
            <div class="j_Prop attr j_Propli" id="select_category">
              <div class="attrKey">产品类别</div>
              <div class="attrValues">
                <ul class="av-collapse" style="visibility:visible;height:auto">
		          <%if(factory.equals("")){%>
                  <li style="margin: 0 10px 10px 0;"><a title="拖拉机" href="/nj/prolist.jsp?catalog=102<%=factory.equals("")?"":"&factory="+factory%>">拖拉机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("102")):""+CommonString.getFormatInt(brandProMap.get(factory+"_102"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;"><a title="耕整地机械" href="/nj/prolist.jsp?catalog=103<%=factory.equals("")?"":"&factory="+factory%>">耕整地机械<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;"><a title="种植施肥机械" href="/nj/prolist.jsp?catalog=104<%=factory.equals("")?"":"&factory="+factory%>">种植施肥机械<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("104")):""+CommonString.getFormatInt(brandProMap.get(factory+"_104"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;"><a title="收割/收获机" href="/nj/prolist.jsp?catalog=105<%=factory.equals("")?"":"&factory="+factory%>">收割/收获机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("105")):""+CommonString.getFormatInt(brandProMap.get(factory+"_105"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;"><a title="农产品加工机械" href="/nj/prolist.jsp?catalog=106<%=factory.equals("")?"":"&factory="+factory%>">农产品加工机械<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;"><a title="灌溉机械" href="/nj/prolist.jsp?catalog=107<%=factory.equals("")?"":"&factory="+factory%>">灌溉机械<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("107")):""+CommonString.getFormatInt(brandProMap.get(factory+"_107"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;"><a title="农作管理" href="/nj/prolist.jsp?catalog=108<%=factory.equals("")?"":"&factory="+factory%>">农作管理<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("108")):""+CommonString.getFormatInt(brandProMap.get(factory+"_108"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;"><a title="运输机械" href="/nj/prolist.jsp?catalog=109<%=factory.equals("")?"":"&factory="+factory%>">运输机械<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("109")):""+CommonString.getFormatInt(brandProMap.get(factory+"_109"))%>)</span></a></li>
				  <%}else{%>
				  <li style="margin: 0 10px 10px 0;<%=CommonString.getFormatInt(brandProMap.get(factory+"_102"))==0?"display:none":""%>"><a title="拖拉机" href="/nj/prolist.jsp?catalog=102<%=factory.equals("")?"":"&factory="+factory%>">拖拉机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("102")):""+CommonString.getFormatInt(brandProMap.get(factory+"_102"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;<%=CommonString.getFormatInt(brandProMap.get(factory+"_103"))==0?"display:none":""%>"><a title="耕整地机械" href="/nj/prolist.jsp?catalog=103<%=factory.equals("")?"":"&factory="+factory%>">耕整地机械<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;<%=CommonString.getFormatInt(brandProMap.get(factory+"_104"))==0?"display:none":""%>"><a title="种植施肥机械" href="/nj/prolist.jsp?catalog=104<%=factory.equals("")?"":"&factory="+factory%>">种植施肥机械<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("104")):""+CommonString.getFormatInt(brandProMap.get(factory+"_104"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;<%=CommonString.getFormatInt(brandProMap.get(factory+"_105"))==0?"display:none":""%>"><a title="收割/收获机" href="/nj/prolist.jsp?catalog=105<%=factory.equals("")?"":"&factory="+factory%>">收割/收获机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("105")):""+CommonString.getFormatInt(brandProMap.get(factory+"_105"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;<%=CommonString.getFormatInt(brandProMap.get(factory+"_106"))==0?"display:none":""%>"><a title="农产品加工机械" href="/nj/prolist.jsp?catalog=106<%=factory.equals("")?"":"&factory="+factory%>">农产品加工机械<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;<%=CommonString.getFormatInt(brandProMap.get(factory+"_107"))==0?"display:none":""%>"><a title="灌溉机械" href="/nj/prolist.jsp?catalog=107<%=factory.equals("")?"":"&factory="+factory%>">灌溉机械<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("107")):""+CommonString.getFormatInt(brandProMap.get(factory+"_107"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;<%=CommonString.getFormatInt(brandProMap.get(factory+"_108"))==0?"display:none":""%>"><a title="农作管理" href="/nj/prolist.jsp?catalog=108<%=factory.equals("")?"":"&factory="+factory%>">农作管理<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("108")):""+CommonString.getFormatInt(brandProMap.get(factory+"_108"))%>)</span></a></li>
                  <li style="margin: 0 10px 10px 0;<%=CommonString.getFormatInt(brandProMap.get(factory+"_109"))==0?"display:none":""%>"><a title="运输机械" href="/nj/prolist.jsp?catalog=109<%=factory.equals("")?"":"&factory="+factory%>">运输机械<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("109")):""+CommonString.getFormatInt(brandProMap.get(factory+"_109"))%>)</span></a></li>
				  <%}%>
                </ul>
              </div>
            </div>
            <%}%>
            <%if(catalog.equals("102")||catalog.equals("103")||catalog.equals("104")||catalog.equals("105")||catalog.equals("106")||catalog.equals("107")||catalog.equals("108")||catalog.equals("109")){%>
            <div class="j_Prop attr j_Propli" id="select_catalog">
              <div class="attrKey">产品类型</div>
              <div class="attrValues">
                <ul class="av-collapse" style="visibility:visible;height:auto">
				
		    <%if(!factory.equals("")){%>
                  <%if(catalog.equals("102")){%>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_102001"))==0?"style='display:none'":""%>><a title="轮式拖拉机" href="/nj/prolist.jsp?catalog=102001<%=factory.equals("")?"":"&factory="+factory%>">轮式拖拉机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("102001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_102001"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_102002"))==0?"style='display:none'":""%>><a title="手扶拖拉机" href="/nj/prolist.jsp?catalog=102002<%=factory.equals("")?"":"&factory="+factory%>">手扶拖拉机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("102002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_102002"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_102003"))==0?"style='display:none'":""%>><a title="履带拖拉机" href="/nj/prolist.jsp?catalog=102003<%=factory.equals("")?"":"&factory="+factory%>">履带拖拉机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("102003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_102003"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("103")){%>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_103001"))==0?"style='display:none'":""%>><a title="旋耕机" href="/nj/prolist.jsp?catalog=103001<%=factory.equals("")?"":"&factory="+factory%>">旋耕机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103001"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_103002"))==0?"style='display:none'":""%>><a title="微耕机" href="/nj/prolist.jsp?catalog=103002<%=factory.equals("")?"":"&factory="+factory%>">微耕机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103002"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_103003"))==0?"style='display:none'":""%>><a title="耕整机" href="/nj/prolist.jsp?catalog=103003<%=factory.equals("")?"":"&factory="+factory%>">耕整机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103003"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_103004"))==0?"style='display:none'":""%>><a title="深松机" href="/nj/prolist.jsp?catalog=103004<%=factory.equals("")?"":"&factory="+factory%>">深松机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103004")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103004"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_103005"))==0?"style='display:none'":""%>><a title="钉齿耙" href="/nj/prolist.jsp?catalog=103005<%=factory.equals("")?"":"&factory="+factory%>">钉齿耙<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103005")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103005"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("104")){%>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_104001"))==0?"style='display:none'":""%>><a title="播种机" href="/nj/prolist.jsp?catalog=104001<%=factory.equals("")?"":"&factory="+factory%>">播种机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("104001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_104001"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_104002"))==0?"style='display:none'":""%>><a title="插秧机" href="/nj/prolist.jsp?catalog=104002<%=factory.equals("")?"":"&factory="+factory%>">插秧机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("104002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_104002"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_104003"))==0?"style='display:none'":""%>><a title="施肥机" href="/nj/prolist.jsp?catalog=104003<%=factory.equals("")?"":"&factory="+factory%>">施肥机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("104003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_104003"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_104004"))==0?"style='display:none'":""%>><a title="地膜机" href="/nj/prolist.jsp?catalog=104004<%=factory.equals("")?"":"&factory="+factory%>">地膜机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("104004")):""+CommonString.getFormatInt(brandProMap.get(factory+"_104004"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("105")){%>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_105001"))==0?"style='display:none'":""%>><a title="玉米收割/收获机" href="/nj/prolist.jsp?catalog=105001<%=factory.equals("")?"":"&factory="+factory%>">玉米收割/收获机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("105001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_105001"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_105002"))==0?"style='display:none'":""%>><a title="稻麦收割机" href="/nj/prolist.jsp?catalog=105002<%=factory.equals("")?"":"&factory="+factory%>">稻麦收割机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("105002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_105002"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_105003"))==0?"style='display:none'":""%>><a title="谷物收割机" href="/nj/prolist.jsp?catalog=105003<%=factory.equals("")?"":"&factory="+factory%>">谷物收割机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("105003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_105003"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_105004"))==0?"style='display:none'":""%>><a title="打捆机" href="/nj/prolist.jsp?catalog=105004<%=factory.equals("")?"":"&factory="+factory%>">打捆机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("105004")):""+CommonString.getFormatInt(brandProMap.get(factory+"_105004"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("106")){%>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_106001"))==0?"style='display:none'":""%>><a title="脱粒机" href="/nj/prolist.jsp?catalog=106001<%=factory.equals("")?"":"&factory="+factory%>">脱粒机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106001"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_106002"))==0?"style='display:none'":""%>><a title="剥壳（去皮）机" href="/nj/prolist.jsp?catalog=106002<%=factory.equals("")?"":"&factory="+factory%>">剥壳（去皮）机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106002"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_106003"))==0?"style='display:none'":""%>><a title="烘干机" href="/nj/prolist.jsp?catalog=106003<%=factory.equals("")?"":"&factory="+factory%>">烘干机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106003"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_106004"))==0?"style='display:none'":""%>><a title="碾米机" href="/nj/prolist.jsp?catalog=106004<%=factory.equals("")?"":"&factory="+factory%>">碾米机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106004")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106004"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_106005"))==0?"style='display:none'":""%>><a title="榨油机" href="/nj/prolist.jsp?catalog=106005<%=factory.equals("")?"":"&factory="+factory%>">榨油机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106005")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106005"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_106006"))==0?"style='display:none'":""%>><a title="精选机" href="/nj/prolist.jsp?catalog=106006<%=factory.equals("")?"":"&factory="+factory%>">精选机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106006")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106006"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("107")){%>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_107001"))==0?"style='display:none'":""%>><a title="水泵" href="/nj/prolist.jsp?catalog=107001<%=factory.equals("")?"":"&factory="+factory%>">水泵<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("107001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_107001"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_107002"))==0?"style='display:none'":""%>><a title="喷灌机" href="/nj/prolist.jsp?catalog=107002<%=factory.equals("")?"":"&factory="+factory%>">喷灌机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("107002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_107002"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_107003"))==0?"style='display:none'":""%>><a title="喷洒机" href="/nj/prolist.jsp?catalog=107003<%=factory.equals("")?"":"&factory="+factory%>">喷洒机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("107003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_107003"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("108")){%>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_108001"))==0?"style='display:none'":""%>><a title="喷雾机" href="/nj/prolist.jsp?catalog=108001<%=factory.equals("")?"":"&factory="+factory%>">喷雾机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("108001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_108001"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_108002"))==0?"style='display:none'":""%>><a title="除草机" href="/nj/prolist.jsp?catalog=108002<%=factory.equals("")?"":"&factory="+factory%>">除草机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("108002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_108002"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_108003"))==0?"style='display:none'":""%>><a title="中耕机" href="/nj/prolist.jsp?catalog=108003<%=factory.equals("")?"":"&factory="+factory%>">中耕机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("108003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_108003"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_108004"))==0?"style='display:none'":""%>><a title="培土机" href="/nj/prolist.jsp?catalog=108004<%=factory.equals("")?"":"&factory="+factory%>">培土机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("108004")):""+CommonString.getFormatInt(brandProMap.get(factory+"_108004"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("109")){%>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_109001"))==0?"style='display:none'":""%>><a title="三轮运输车" href="/nj/prolist.jsp?catalog=109001<%=factory.equals("")?"":"&factory="+factory%>">三轮运输车<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("109001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_109001"))%>)</span></a></li>
                  <li <%=CommonString.getFormatInt(brandProMap.get(factory+"_109002"))==0?"style='display:none'":""%>><a title="四轮运输车" href="/nj/prolist.jsp?catalog=109002<%=factory.equals("")?"":"&factory="+factory%>">四轮运输车<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("109002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_109002"))%>)</span></a></li>
                  <%}%>
		    <%}else{%>
                  <%if(catalog.equals("102")){%>
                  <li><a title="轮式拖拉机" href="/nj/prolist.jsp?catalog=102001<%=factory.equals("")?"":"&factory="+factory%>">轮式拖拉机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("102001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_102001"))%>)</span></a></li>
                  <li><a title="手扶拖拉机" href="/nj/prolist.jsp?catalog=102002<%=factory.equals("")?"":"&factory="+factory%>">手扶拖拉机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("102002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_102002"))%>)</span></a></li>
                  <li><a title="履带拖拉机" href="/nj/prolist.jsp?catalog=102003<%=factory.equals("")?"":"&factory="+factory%>">履带拖拉机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("102003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_102003"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("103")){%>
                  <li><a title="旋耕机" href="/nj/prolist.jsp?catalog=103001<%=factory.equals("")?"":"&factory="+factory%>">旋耕机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103001"))%>)</span></a></li>
                  <li><a title="微耕机" href="/nj/prolist.jsp?catalog=103002<%=factory.equals("")?"":"&factory="+factory%>">微耕机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103002"))%>)</span></a></li>
                  <li><a title="耕整机" href="/nj/prolist.jsp?catalog=103003<%=factory.equals("")?"":"&factory="+factory%>">耕整机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103003"))%>)</span></a></li>
                  <li><a title="深松机" href="/nj/prolist.jsp?catalog=103004<%=factory.equals("")?"":"&factory="+factory%>">深松机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103004")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103004"))%>)</span></a></li>
                  <li><a title="钉齿耙" href="/nj/prolist.jsp?catalog=103005<%=factory.equals("")?"":"&factory="+factory%>">钉齿耙<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("103005")):""+CommonString.getFormatInt(brandProMap.get(factory+"_103005"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("104")){%>
                  <li><a title="播种机" href="/nj/prolist.jsp?catalog=104001<%=factory.equals("")?"":"&factory="+factory%>">播种机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("104001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_104001"))%>)</span></a></li>
                  <li><a title="插秧机" href="/nj/prolist.jsp?catalog=104002<%=factory.equals("")?"":"&factory="+factory%>">插秧机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("104002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_104002"))%>)</span></a></li>
                  <li><a title="施肥机" href="/nj/prolist.jsp?catalog=104003<%=factory.equals("")?"":"&factory="+factory%>">施肥机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("104003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_104003"))%>)</span></a></li>
                  <li><a title="地膜机" href="/nj/prolist.jsp?catalog=104004<%=factory.equals("")?"":"&factory="+factory%>">地膜机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("104004")):""+CommonString.getFormatInt(brandProMap.get(factory+"_104004"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("105")){%>
                  <li><a title="玉米收割/收获机" href="/nj/prolist.jsp?catalog=105001<%=factory.equals("")?"":"&factory="+factory%>">玉米收割/收获机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("105001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_105001"))%>)</span></a></li>
                  <li><a title="稻麦收割机" href="/nj/prolist.jsp?catalog=105002<%=factory.equals("")?"":"&factory="+factory%>">稻麦收割机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("105002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_105002"))%>)</span></a></li>
                  <li><a title="谷物收割机" href="/nj/prolist.jsp?catalog=105003<%=factory.equals("")?"":"&factory="+factory%>">谷物收割机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("105003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_105003"))%>)</span></a></li>
                  <li><a title="打捆机" href="/nj/prolist.jsp?catalog=105004<%=factory.equals("")?"":"&factory="+factory%>">打捆机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("105004")):""+CommonString.getFormatInt(brandProMap.get(factory+"_105004"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("106")){%>
                  <li><a title="脱粒机" href="/nj/prolist.jsp?catalog=106001<%=factory.equals("")?"":"&factory="+factory%>">脱粒机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106001"))%>)</span></a></li>
                  <li><a title="剥壳（去皮）机" href="/nj/prolist.jsp?catalog=106002<%=factory.equals("")?"":"&factory="+factory%>">剥壳（去皮）机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106002"))%>)</span></a></li>
                  <li><a title="烘干机" href="/nj/prolist.jsp?catalog=106003<%=factory.equals("")?"":"&factory="+factory%>">烘干机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106003"))%>)</span></a></li>
                  <li><a title="碾米机" href="/nj/prolist.jsp?catalog=106004<%=factory.equals("")?"":"&factory="+factory%>">碾米机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106004")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106004"))%>)</span></a></li>
                  <li><a title="榨油机" href="/nj/prolist.jsp?catalog=106005<%=factory.equals("")?"":"&factory="+factory%>">榨油机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106005")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106005"))%>)</span></a></li>
                  <li><a title="精选机" href="/nj/prolist.jsp?catalog=106006<%=factory.equals("")?"":"&factory="+factory%>">精选机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("106006")):""+CommonString.getFormatInt(brandProMap.get(factory+"_106006"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("107")){%>
                  <li><a title="水泵" href="/nj/prolist.jsp?catalog=107001<%=factory.equals("")?"":"&factory="+factory%>">水泵<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("107001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_107001"))%>)</span></a></li>
                  <li><a title="喷灌机" href="/nj/prolist.jsp?catalog=107002<%=factory.equals("")?"":"&factory="+factory%>">喷灌机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("107002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_107002"))%>)</span></a></li>
                  <li><a title="喷洒机" href="/nj/prolist.jsp?catalog=107003<%=factory.equals("")?"":"&factory="+factory%>">喷洒机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("107003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_107003"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("108")){%>
                  <li><a title="喷雾机" href="/nj/prolist.jsp?catalog=108001<%=factory.equals("")?"":"&factory="+factory%>">喷雾机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("108001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_108001"))%>)</span></a></li>
                  <li><a title="除草机" href="/nj/prolist.jsp?catalog=108002<%=factory.equals("")?"":"&factory="+factory%>">除草机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("108002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_108002"))%>)</span></a></li>
                  <li><a title="中耕机" href="/nj/prolist.jsp?catalog=108003<%=factory.equals("")?"":"&factory="+factory%>">中耕机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("108003")):""+CommonString.getFormatInt(brandProMap.get(factory+"_108003"))%>)</span></a></li>
                  <li><a title="培土机" href="/nj/prolist.jsp?catalog=108004<%=factory.equals("")?"":"&factory="+factory%>">培土机<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("108004")):""+CommonString.getFormatInt(brandProMap.get(factory+"_108004"))%>)</span></a></li>
                  <%}%>
                  <%if(catalog.equals("109")){%>
                  <li><a title="三轮运输车" href="/nj/prolist.jsp?catalog=109001<%=factory.equals("")?"":"&factory="+factory%>">三轮运输车<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("109001")):""+CommonString.getFormatInt(brandProMap.get(factory+"_109001"))%>)</span></a></li>
                  <li><a title="四轮运输车" href="/nj/prolist.jsp?catalog=109002<%=factory.equals("")?"":"&factory="+factory%>">四轮运输车<span style="color:red">(<%=factory.equals("")?""+CommonString.getFormatInt(cataProMap.get("109002")):""+CommonString.getFormatInt(brandProMap.get(factory+"_109002"))%>)</span></a></li>
                  <%}%>				  
			<%}%>
				  
				  
                </ul>
              </div>
            </div>
            <%}%>
            <div class="j_Prop attr hasMore attr_brand j_Propli" id="select_brand">
              <div class="attrKey">品牌
                <div class="brandTip" style="white-space:normal;text-indent:0;position:static;padding:10px;float:left"> <a href="javascript:void(0)" id="inner" class="br01">所有品牌</a>
                  <!--
			     <a id="out" href="javascript:void(0)" class="br02">国外品牌</a> 
				 <a href="javascript:void(0)" class="all" style="border-color:red;color:red">所有品牌</a>
				 -->
                </div>
              </div>
              <div class="attrValues">
                <div class="j_BrandSearch av-search fix">
				<!--拼音、-->
                  <input id="brand"  name="brand" type="text" value="" placeholder="可搜汉字查找品牌" />
                </div>
                <div class="letters"> 
                  <%  
			      if(brandLetterList!=null&&brandLetterList.size()>0){ 
			        for(Map oneMap : brandLetterList){
			      %>
                  <a data-val="<%=CommonString.getFormatPara(oneMap.get("first_letter"))%>" href="javascript:void(0)" ><%=CommonString.getFormatPara(oneMap.get("first_letter"))%></a>
                  <%}}%>
				  </div>
                <ul class="av-collapse" id="brand_list" style="margin-right:35px">
                  <%for(Map oneMap : brandList){%>
                  <li  class="br01" ><a data-val="<%=CommonString.getFormatPara(oneMap.get("id"))%>"  title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="/nj/prolist.jsp?factory=<%=CommonString.getFormatPara(oneMap.get("id"))%><%=catalog.equals("")?"":"&catalog="+catalog%>"><span class="m"><%=CommonString.getFormatPara(oneMap.get("first_letter"))%>-<%=CommonString.getFormatPara(oneMap.get("name"))%><span style="color:red">(<%=CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog.equals("")?"0":catalog)))%>)</span></span><span class="s" style="display:none"><%=CommonString.getFormatPara(oneMap.get("id"))%></span></a><b></b></li>
                  <%}%>
                </ul>
                <div class="av-options"> <a href="javascript:;" class="j_Multiple avo-multiple">多选<i></i></a> <a href="javascript:;" class="j_More avo-more ui-more-drop-l">更多<i class="ui-more-drop-l-arrow"></i></a> </div>
                <div class="av-btns" style="display:none;"> <a id="multipleBrand01" href="javascript:;" class="j_SubmitBtn ui-btn-s-primary ui-btn-disable">确定</a> <a href="javascript:;" class="j_CancelBtn ui-btn-s">取消</a> </div>
              </div>
            </div>
            <input type="hidden" id="catalog" name="catalog" value="" />
            <input type="hidden" id="tonandmeter" name="tonandmeter" value="" />
            <input type="hidden" id="letter" name="letter"  />
            <input type="hidden" id="brands" name="brands"  />
          </div>
          <!--筛选 end-->
          <div class="filterBox">
            <div class="filterBar fix "> <a class="fSort default <%if(order.equals("")||order.equals("normal")){%>fSort-cur<%}%> " href="/nj/prolist.jsp?order=normal<%=catalog.equals("")?"":"&catalog="+catalog%><%=factory.equals("")?"":"&factory="+factory%>" title="默认">默认</a> <a class="fSort default <%if(order.equals("view")){%>fSort-cur<%}%>  " href="/nj/prolist.jsp?order=view<%=catalog.equals("")?"":"&catalog="+catalog%><%=factory.equals("")?"":"&factory="+factory%>" title="点击量">点击量</a> <a class="fSort <%if(order.equals("sale")){%>fSort-cur<%}%> " href="/nj/prolist.jsp?order=sale<%=catalog.equals("")?"":"&catalog="+catalog%><%=factory.equals("")?"":"&factory="+factory%>" title="销量">销量</a>
              <div class="filterPage"> <a  <%if(nowPage==1){%>href="javascript:void(0)"<%}else{%>href="/nj/prolist.jsp?offset=<%=(Integer.parseInt(offset)-pageSize)%><%= factory.equals("")?"":"&factory="+factory%><%=catalog.equals("")?"":"&catalog="+catalog%>"<%}%> class="prev <%if(nowPage==1){%>disable<%}%>"><i class="ion">&#xe6c3;</i></a> <span class="total"><%=nowPage%>/<%=pageCount%></span> <a <%if(nowPage==pageCount){%>href="javascript:void(0)"<%}else{%>href="/nj/prolist.jsp?offset=<%=(Integer.parseInt(offset)+pageSize)%><%= factory.equals("")?"":"&factory="+factory%><%=catalog.equals("")?"":"&catalog="+catalog%>"<%}%> class="next <%if(nowPage==pageCount){%>disable<%}%>"><i class="ion">&#xe6c4;</i></a> </div>
              <span class="modeSwitch switch_on" title="点击切换到大图模式"></span> </div>
          </div>
        </div>
      </div>
      <div class="txd_sx_plist mainList listMode">
        <ul class="fix">
          <% 
		    if(null !=prolist && prolist.size()>0){
		  	    for(Map oneMap:prolist){
					String intro=CommonHtml.filterHTML( CommonString.getFormatPara( oneMap.get("content"))  );
					if(intro.length()>90){
						intro=intro.substring(0,90)+"...";
					}
					if(intro.equals("")){
						intro="暂无相关描述";
					}
		%>
          <li>
            <div class="box">
              <div class="tsx_pimg"><a href="/nj/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" title="<%=CommonString.getFormatPara(oneMap.get("brand_name"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalog_name"))%>" target="_blank"> <img src="http://product.21-sun.com//uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img"))%>" alt="<%=CommonString.getFormatPara(oneMap.get("brand_name"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalog_name"))%>" onerror="this.src='/uploadfiles/no_big.gif';"/></a></div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="/nj/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("brand_name"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalog_name"))%>"  ><%=CommonString.getFormatPara(oneMap.get("brand_name"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalog_name"))%></a></h2>
                <div class="txs_plink">

				 <!--<span class="pmhide"></span> <a href="/nj/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name"))%>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("brand_name"))%><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(oneMap.get("catalog_name"))%>性能">性能</a><em>|</em> <a href=""  target="_blank" title="三一SY60C-9挖掘机图片">图片</a><em>|</em> <a href=""  target="_blank" title="三一SY60C-9挖掘机代理商">代理商</a> -->

                </div>
                <div class="txs_psum"><a href="" target="_blank"><%=intro%></a></div>
              </div>
              <div class="oi">
                <div class="l"> <span class="thisxj"><b>询价（<%=CommonString.getFormatInt(oneMap.get("inquiry_count"))%>）</b></span></div>
                <span class="pmh">
                <div class="tsx_pprice"><a href="javascript:;" onClick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')">询最低价</a></div>
                <div class="r"><%=CommonString.getFormatInt(oneMap.get("inquiry_count"))%>人已询价</div>
                </span> </div>
            </div>
          </li>
          <%}}%>
        </ul>
      </div>
      <div class="txd_page fix">
        <div class="paging page" id="pagination">
          <tags:page pageBean="<%=pageBean %>"/>
        </div>
      </div>
    </div>
  </div>
</div>
<!--main end-->
<!--foot-->
<div class="j_foot j_foot02" style="height:auto">
  <div class="wrap fix">
    <div class="j_foot_link_tab j_tab">
      <div class="j_tab_keylist">
        <ul class="fix">
          <li class="j_tab_key cur">中国工程机械商贸网 旗下网站</li>
          <li class="j_tab_key">友情链接</li>
        </ul>
      </div>
      <div class="j_tab_val" style="display: block;">
        <ul class="fix j_link_list">
          <li><a href="http://part.21-sun.com">中国工程机械配件网</a></li>
          <li><a href="http://job.21-sun.com/">中国工程机械人才网</a></li>
          <li><a href="http://rent.21-sun.com/">中国工程机械租赁网</a></li>
          <li><a href="http://used.21-sun.com/">中国工程机械二手网</a></li>
          <li><a href="http://www.cmbol.com/">Construction Equipment</a></li>
          <li><a href="http://www.21part.com/">杰配网</a></li>
          <li><a href="http://peitao.21-sun.com/">配套网</a></li>
          <li><a href="http://www.21-sun.com/app/">手机21-SUN</a></li>
          <li><a href="http://ad.21-sun.com/link_to.jsp?paras=0,0,100028&amp;url=www.21taiyang.com/">太阳商城</a></li>
          <li><a href="http://product.21-sun.com/">铁臂商城</a></li>
        </ul>
      </div>
      <div class="j_tab_val">
        <ul class="fix j_link_list">
          <li><a target="_blank" href="http://cn.newmaker.com/">佳工机电网</a></li>
          <li><a target="_blank" href="http://www.51dzw.com/">51电子网</a></li>
          <li><a target="_blank" href="http://gongkong.ofweek.com">工控</a></li>
          <li><a target="_blank" href="http://www.skxox.com">云同盟</a></li>
          <li><a target="_blank" href="http://www.jc35.com">机床网</a></li>
          <li><a target="_blank" href="http://www.tielu.cn/">铁路网</a></li>
          <li><a target="_blank" href="http://www.machine35.com/">中国机床网</a></li>
          <li><a target="_blank" href="http://www.cncu.cn/">铜</a></li>
          <li><a target="_blank" href="http://product.gongchang.com/">中国产品库</a></li>
          <li><a target="_blank" href="http://paihang.jiameng.com/">品牌加盟店</a></li>
          <li><a target="_blank" href="http://blog.zhulong.com/">筑龙博客</a></li>
          <li><a target="_blank" href="http://changsha.liebiao.com/">长沙列表网</a></li>
          <li><a target="_blank" href="http://cn.makepolo.com/">企业名录</a></li>
          <li><a target="_blank" href="http://www.99114.com/">B2B平台</a></li>
          <li><a target="_blank" href="http://p.tgnet.com/">工程信息</a></li>
          <li><a target="_blank" href="http://www.qp110.com/">汽车配件110网</a></li>
          <li><a target="_blank" href="http://nm.sci99.com/">有色金属价格</a></li>
          <li><a target="_blank" href="http://huanbao.bjx.com.cn/">节能环保</a></li>
          <li><a target="_blank" href="http://www.ayijx.com">百川网</a></li>
          <li><a target="_blank" href="http://info.glinfo.com/">钢联资讯</a></li>
          <li><a target="_blank" href="http://www.best73.com">优质企商网</a></li>
          <li><a target="_blank" href="http://cd.fang.com">成都搜房网</a></li>
          <li><a target="_blank" href="http://jz.zhulong.com/">建筑设计</a></li>
          <li><a target="_blank" href="http://qiye.youboy.com/">企业名录</a></li>
          <li><a target="_blank" href="http://jixie.huangye88.com/">中国机械网</a></li>
          <li><a target="_blank" href="http://baojia.feijiu.net">废旧报价</a></li>
          <li><a target="_blank" href="http://qicai.fengniao.com">摄影器材</a></li>
          <li><a target="_blank" href="http://price.315che.com/">汽车报价网</a></li>
          <li><a target="_blank" href="http://koubei.21-sun.com/">挖掘机口碑</a></li>
          <li><a target="_blank" href="http://www.21-sun.com/service/wangzhanjianshe/anliMore.jsp">成功案例</a></li>
          <li><a target="_blank" href="http://www.nongjx.com/">中国农机总网</a></li>
          <li><a target="_blank" href="http://www.fdcew.com/">房地产E网</a></li>
          <li><a target="_blank" href="http://steel.sci99.com">钢铁</a></li>
          <li><a target="_blank" href="http://www.chamenhu.com/">B2B网站大全</a></li>
          <li><a target="_blank" href="http://www.shigongjishu.cn/">施工技术杂志社</a></li>
          <li><a target="_blank" href="http://www.machine.com.cn/link/">中国机械设备网</a></li>
          <li><a target="_blank" href="http://bbs.cehome.com/">铁甲论坛</a></li>
          <li><a target="_blank" href="http://bbs.qjy168.com">勤加缘社区</a></li>
        </ul>
      </div>
    </div>
  </div>
</div>
<div class="j_bottom">
  <div class="wrap fix">
    <div class="j_bottom_left l"> <span class="New_links" onClick="window.open('http://www.21-sun.com/service/guanggao/index.htm');">广告服务</span><em>|</em> <span class="New_links" onClick="window.open('http://www.jerei.com/contact/');">联系方式</span><em>|</em> <span class="New_links" onClick="window.open('http://www.jerei.com/');">关于我们</span><em>|</em> <span class="New_links" onClick="window.open('http://www.jerei.com/news/');">本网动态</span><em>|</em> <span class="New_links" onClick="window.open('http://www.jerei.com/contact/legal.jsp');">法律声明</span><em>|</em> <span class="New_links" onClick="window.open('http://aboutus.21-sun.com/map.htm');">网站导航</span><em>|</em> <span class="New_links" onClick="window.open('http://www.21-sun.com/contact/');">联系客服</span> </div>
    <div class="j_bottom_left r">中国工程机械商贸网 © copyright 2000-<span class="currentDate">2015</span></div>
  </div>
</div>
<!--foot end-->
<!--购机导航内容-->
<div class="j_tlayer j_prol">
  <ul class="fix">
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001" class="j_link01" title="挖掘机/属具">挖掘机/属具</a> <a href="http://product.21-sun.com/brand/ht95/" title="恒天九五挖掘机">恒天九五挖掘机</a></div>
      <a href="http://product.21-sun.com/brand/jcm/" class="j_link02" title="山重">山重</a> <a href="http://product.21-sun.com/brand/hi-tech/" class="j_link02" title="普堃韩泰克">普堃韩泰克</a> <a href="http://product.21-sun.com/brand/eddie/" class="j_link02" title="艾迪">艾迪</a> <a href="http://product.21-sun.com/brand/tike/" class="j_link02" title="泰科">泰科</a> <a href="http://product.21-sun.com/brand/ytxinrenty/" class="j_link02" title="DBK">DBK</a> <br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001001" title="履带挖掘机">履带挖掘机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001004" title="轮式挖掘机">轮式挖掘机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001007" title="特种挖掘机">特种挖掘机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001098" title="破碎锤">破碎锤</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001099" title="液压剪">液压剪</a> </li>
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001" class="j_link01" title="装载机">装载机</a> </div>
      <a href="http://product.21-sun.com/brand/sdlg/" class="j_link02" title="临工">临工</a> <a href="http://product.21-sun.com/brand/liugong/" class="j_link02" title="柳工">柳工</a> <a href="http://product.21-sun.com/brandshop/xuangong/" class="j_link02" title="宣工">宣工</a><a href="http://ad.21-sun.com/link_to.jsp?paras=101,101,6850&amp;url=http://product.21-sun.com/brand/yingxuan/" class="j_link02" title="英轩">英轩</a> <br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002007" title="轮式装载机">轮式装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002003" title="履带装载机">履带装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002004" title="特种装载机">特种装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002008" title="挖掘装载机">挖掘装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002009" title="滑移装载机">滑移装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002010" title="滑移装载机">滑移装载机</a> </li>
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102" class="j_link01" title="起重机">起重机</a><span class="j_tr"> <a href="http://used.21-sun.com/qizhongji/0-0-0-0-0-0-0-0-0.htm" title="二手">二手</a> / <a href="http://rent.21-sun.com/equipment/index.jsp?find_category=02" title="起重机械">租赁</a></span> </div>
      <a href="http://product.21-sun.com/brand/xcmg/" class="j_link02" title="徐工">徐工</a> <a href="http://product.21-sun.com/brand/sany/" class="j_link02" title="三一">三一</a> <a href="http://product.21-sun.com/brand/zoomlion/" class="j_link02" title="中联">中联</a> <a href="http://product.21-sun.com/brand/fuwa/" class="j_link02" title="抚挖">抚挖</a> <a href="http://product.21-sun.com/brand/liugong/" class="j_link02" title="柳工">柳工</a> <a rel="nofollow" href="http://www.sinoboom.com.cn/" class="j_link02" title="星邦重工">星邦重工</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102007" title="汽车起重机">汽车起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102002" title="塔式起重机">塔式起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102003" title="高空作业车/平台">高空作业车/平台</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102006" title="随车起重机">随车起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102008" title="履带式起重机">履带式起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102012" title="伸缩臂叉装机">伸缩臂叉装机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102011" title="施工升降机">施工升降机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102013" title="龙门/桥梁起重机">龙门/桥梁起重机</a> </li>
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001" class="j_link01" title="压路机/压实机/夯">压路机/压实机/夯</a> <a href="http://ad.21-sun.com/link_to.jsp?paras=101,101,4544&amp;url=www.green-belt.cn/" title="垂直振动压路机">垂直振动压路机</a></div>
      <a href="http://product.21-sun.com/brand/gjzjyituo/" class="j_link02" title="洛建">洛建</a> <a href="http://product.21-sun.com/brand/shantui/" class="j_link02" title="山推">山推</a> <a href="http://product.21-sun.com/brand/sany/" class="j_link02" title="三一">三一</a> <a href="http://product.21-sun.com/brand/zoomlion/" class="j_link02" title="中联">中联</a> <a href="http://product.21-sun.com/brand/xcmg/" class="j_link02" title="徐工">徐工</a> <a href="http://product.21-sun.com/brand/changlin/" class="j_link02" title="常林">常林</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001001" title="单钢轮压路机">单钢轮压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001002" title="双钢轮压路机">双钢轮压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001003" title="三钢轮压路机">三钢轮压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001005" title="轮胎压路机">轮胎压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001004" title="手扶压路机">手扶压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001020" title="压实机">压实机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001021" title="夯实机">夯实机</a> </li>
    <li >
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003" class="j_link01" title="推土机">推土机</a> </div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003001" title="履带推土机">履带推土机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003004" title="轮式推土机">轮式推土机</a> </li>
    <li >
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005" class="j_link01" title="平地机/铲运机">平地机/铲运机</a> </div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005001" title="自行式铲运机">自行式铲运机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005002" title="自行式平地机">自行式平地机</a> </li>
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=109" class="j_link01" title="桥梁机械">桥梁机械</a> </div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109006" title="砂浆车">砂浆车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109005" title="检测车">检测车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109004" title="提梁机">提梁机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109002" title="运梁车">运梁车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109001" title="架桥机">架桥机</a> </li>
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008" class="j_link01" title="自卸卡车/矿卡">自卸卡车/矿卡</a> </div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008002" title="刚性自卸卡车">刚性自卸卡车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008001" title="铰接式自卸卡车">铰接式自卸卡车</a> </li>
    <li  style="margin-top:-45px">
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110" class="j_link01" title="地下及矿山机械">地下及矿山机械</a> </div>
      <a href="http://product.21-sun.com/brandshop/tiejian/" class="j_link02" title="铁建重工">铁建重工</a> <a href="http://product.21-sun.com/brand/kym/" class="j_link02" title="开元">开元</a> <a href="http://product.21-sun.com/brand/stwkks/" class="j_link02" title="山特维克">山特维克</a> <a href="http://product.21-sun.com/brand/carter/" class="j_link02" title="卡特重工">卡特重工</a> <a href="http://product.21-sun.com/brand/shanbao/" class="j_link02" title="山宝">山宝</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110001" title="盾构机">盾构机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110002" title="掘进机">掘进机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110008" title="凿岩台车/钻机">凿岩台车/钻机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110009" title="破碎机">破碎机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110012" title="筛分机">筛分机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110013" title="装载及搬运设备">装载及搬运设备</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110018" title="扒渣机">扒渣机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110019" title="采煤机">采煤机</a> </li>
    <li  style="margin-top:-45px">
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105" class="j_link01" title="桩工机械">桩工机械</a><span class="j_tr"> <a href="http://rent.21-sun.com/equipment/index.jsp?find_category=07" title="租赁">租赁</a></span> </div>
      <a href="http://ad.21-sun.com/link_to.jsp?paras=101,101,7238&amp;url=http://product.21-sun.com/brandshop/hnxth/" class="j_link02" title="新天和">新天和</a> <a href="http://product.21-sun.com/brand/xcmg/" class="j_link02" title="徐工">徐工</a> <a href="http://product.21-sun.com/brand/sunward/" class="j_link02" title="山河智能">山河智能</a> <a href="http://product.21-sun.com/brand/dongda/" class="j_link02" title="东达">东达</a> <a class="j_link02" href="http://product.21-sun.com/brand/ht95/" title="恒天九五">恒天九五</a> <br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105003" title="旋挖钻机">旋挖钻机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105004" title="潜孔钻机">潜孔钻机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105005" title="水平定向钻">水平定向钻</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105007" title="连续墙设备">连续墙设备</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105018" title="螺旋钻机">螺旋钻机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105009" title="压桩机/打桩机">压桩机/打桩机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105028" title="截桩机/破桩机">截桩机/破桩机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105027" title="其它桩工机械">其它桩工机械</a> </li>
    <li  style="margin-top:-45px">
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103" class="j_link01" title="混凝土机械">混凝土机械</a><a href="http://ad.21-sun.com/link_to.jsp?paras=101,101,7097&amp;url=http://product.21-sun.com/brand/roady/" title="陆德筑机">陆德筑机</a><span class="j_tr"> <a href="http://used.21-sun.com/hunningtu/0-0-0-0-0-0-0-0-0-0.htm" title="二手">二手</a> / <a href="http://rent.21-sun.com/equipment/index.jsp?find_category=03" title="租赁">租赁</a></span></div>
      <a href="http://product.21-sun.com/brand/lingyu/" class="j_link02" title="中集凌宇">中集凌宇</a> <a href="http://product.21-sun.com/brand/sany/" class="j_link02" title="三一">三一</a> <a href="http://product.21-sun.com/brand/shenglida8/" class="j_link02" title="盛利达">盛利达</a> <a href="http://product.21-sun.com/brand/haizhoujx/" class="j_link02" title="海州">海州</a> <a href="http://product.21-sun.com/brand/ftls/" class="j_link02" title="雷萨">雷萨</a> <a href="http://product.21-sun.com/brand/shantui/" class="j_link02" title="山推">山推</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001" title="混凝土泵车">混凝土泵车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103019" title="混凝土搅拌运输车">搅拌运输车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103017" title="车载泵">车载泵</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103018" title="拖泵">拖泵</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103020" title="输送泵">输送泵</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103002" title="混凝土搅拌站/楼/车">搅拌站/楼/车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103005" title="混凝土布料杆/车">布料杆/车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103008" title="干粉/砂浆生产设备">干粉/砂浆生产设备</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103010" title="喷湿机">喷湿机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103015" title="其它混凝土设备">其它混凝土设备</a> </li>
    <li  style="margin-top:-45px">
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104" class="j_link01" title="路面机械">路面机械</a> </div>
      <a href="http://product.21-sun.com/brand/xizhu/" class="j_link02" title="中交西筑">中交西筑</a> <a href="http://product.21-sun.com/brand/rehorkj/" class="j_link02" title="雷奥">雷奥</a> <a href="http://product.21-sun.com/brand/xcmg/" class="j_link02" title="徐工">徐工</a> <br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104001" title="摊铺机">摊铺机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104005" title="铣刨机">铣刨机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104003" title="开槽机/灌缝机">开槽机/灌缝机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104004" title="路面破碎机">破碎机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104002" title="再生/修补机械">再生/修补机械</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104008" title="稳定土厂拌设备">稳定土厂拌设备</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104009" title="沥青搅拌/转运">沥青搅拌/转运</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104006" title="沥青洒布/碎石散布机">沥青洒布/碎石散布机</a> </li>
    <li>
      <div class="j_t" style="margin-top:5px"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118" class="j_link01" title="专用车辆">专用车辆</a> <span class="j_tr"> <a href="http://rent.21-sun.com/equipment/index.jsp?find_category=06" title="租赁">租赁</a></span></div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118001" title="普通载货车">普通载货车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118013" title="公路牵引车">公路牵引车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118004" title="场地牵引车">场地牵引车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118003" title="消防车">消防车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118012" title="清障车">清障车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118005" title="冷藏车">冷藏车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118006" title="货厢车">货厢车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118007" title="粉罐车">粉罐车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118008" title="油罐车">油罐车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118009" title="液罐车">液罐车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118010" title="翻斗车">翻斗车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118011" title="渣土车">渣土车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118014" title="半挂车">半挂车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118002" title="其他专用车">其他专用车</a> </li>
    <li>
      <div class="j_t" style="margin-top:5px"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107" class="j_link01" title="叉车">叉车</a> </div>
      <a href="http://product.21-sun.com/brand/doosan/" class="j_link02" title="斗山">斗山</a> <a href="http://product.21-sun.com/brand/hyundai-bj/" class="j_link02" title="现代京城">现代京城</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107011" title="内燃平衡重叉车">内燃平衡重叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107012" title="电动叉车">电动叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107013" title="侧面叉车">侧面叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107014" title="前移叉车">前移叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107015" title="搬运车/托盘车">搬运车/托盘车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107016" title="堆高机/堆垛车">堆高机/堆垛车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107018" title="仓储叉车">仓储叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107017" title="专用叉车">专用叉车</a> </li>
    <li >
      <div class="j_t" style="margin-top:5px"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111" class="j_link01" title="港口机械">港口机械</a> </div>
      <a href="http://product.21-sun.com/brand/sany" class="j_link02" title="三一">三一</a> <a href="http://product.21-sun.com/brand/liebherr/" class="j_link02" title="利勃海尔">利勃海尔</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111001" title="正面吊">正面吊</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111004" title="门式起重机">门式起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111002" title="码头堆高机">码头堆高机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111003" title="卸船机">卸船机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111007" title="推耙机">推耙机</a> </li>
    <li  >
      <div class="j_t" style="margin-top:5px"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122" class="j_link01" title="环卫车辆">环卫车辆</a> </div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122001" title="清扫车">清扫车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122002" title="垃圾车">垃圾车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122003" title="清雪车">清雪车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122004" title="酒水车">酒水车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122005" title="污水粪便车">污水粪便车</a> </li>
  </ul>
  <div class="j_proCates">
    <div> <strong>挖掘机：</strong>
      <p> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=174&amp;catalog=101001" title="卡特挖掘机">卡特挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=182&amp;catalog=101001" title="小松挖掘机">小松挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&amp;catalog=101001" title="三一挖掘机">三一挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=184&amp;catalog=101001" title="日立挖掘机">日立挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=183&amp;catalog=101001" title="神钢挖掘机">神钢挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&amp;catalog=101001" title="徐工挖掘机">徐工挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=175&amp;catalog=101001" title="沃尔沃挖掘机">沃尔沃挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&amp;catalog=101001" title="龙工挖掘机">龙工挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=137&amp;catalog=101001" title="临工挖掘机">临工挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&amp;catalog=101001" title="柳工挖掘机">柳工挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=141&amp;catalog=101001" title="福田雷沃挖掘机">福田雷沃挖掘机</a> </p>
    </div>
    <div> <strong>装载机：</strong>
      <p> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=138&amp;catalog=101002" title="山工装载机">山工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&amp;catalog=101002" title="柳工装载机">柳工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&amp;catalog=101002" title="龙工装载机">龙工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&amp;catalog=101002" title="徐工装载机">徐工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=137&amp;catalog=101002" title="临工装载机">临工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=139&amp;catalog=101002" title="厦工装载机">厦工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=141&amp;catalog=101002" title="福田雷沃装载机">福田雷沃装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=174&amp;catalog=101002" title="卡特装载机">卡特装载机</a> </p>
    </div>
  </div>
</div>
<!--头部购机导航内容 end-->
<div style="display:none;">
</div>
<script src="http://script.v.jerei.com/recv.js" type="text/javascript"></script>
<!--foot end-->
<div class="blackBar" id="zeng" style="display:none">
  <div class="bb01"> <a target="_blank" href="http://product.21-sun.com/user/login.htm" class="si"><i class="sb_ion sb01"></i></a> <a title="批量询价" alt="批量询价" href="#" class="si sb_xunjia"><i class="sb_ion sb02"></i><b>批量询价</b> <em id="plxj" class="num">0</em> <i class="arr"></i></a> </div>
  <div class="bb02"> <a href="javascript:void(0)" class="si sb_ewm"><i class="sb_ion sb03"></i></a> <a href="#" class="si gotop" title="返回顶部"><i class="sb_ion sb04"></i></a> </div>
  <div class="hide">
    <div class="bb_ewm"><img src="/nj/Static/images/ewm02.png"></div>
  </div>
</div>
<!--询价弹层-->
<div class="sb_layer yincang sb_layer_xunjia" id="xjtc">
  <div class="sb_hd"> <span class="check_box">
    <input type="checkbox" id="checkAll_xunjia">
    共<b class="all" id="inquiryCount">0</b>件，已选<b class="fn">0</b>件 </span> <a style="margin-left:25px" id="closexunjia" href="javascript:void(0)" >【关闭】</a></div>
  <div class="sb_bd">
    <ul id="xunjiaContent">
    </ul>
    <div class="sb_xunjiaForm" style="bottom:50px">
      <div class="dl">
        <div class="dt">姓名：</div>
        <div class="dd">
          <input type="text" class="form-control" id="uname">
          <em>*</em></div>
      </div>
      <div class="dl">
        <div class="dt">手机：</div>
        <div class="dd">
          <input type="text" class="form-control" id="phone">
          <em>*</em></div>
      </div>
      <div class="dl area">
        <div class="dt">地区：</div>
        <div class="dd">
          <select class="form-control" onChange="set_my_city(this);" id="select_province">
            <option>选择省</option>
            <option value="100110">山东</option>
            <option value="101800">安徽</option>
            <option value="103100">江西</option>
            <option value="104200">浙江</option>
            <option value="105290">上海</option>
            <option value="105499">北京</option>
            <option value="105689">天津</option>
            <option value="105879">重庆</option>
            <option value="106400">河北</option>
            <option value="108300">山西</option>
            <option value="109700">内蒙古</option>
            <option value="110900">江苏</option>
            <option value="113000">广西</option>
            <option value="115000">西藏</option>
            <option value="116000">宁夏</option>
            <option value="117000">新疆</option>
            <option value="119000">吉林</option>
            <option value="120000">辽宁</option>
            <option value="122000">黑龙江</option>
            <option value="124000">湖北</option>
            <option value="126000">湖南</option>
            <option value="128000">广东</option>
            <option value="130000">河南</option>
            <option value="132000">贵州</option>
            <option value="133000">青海</option>
            <option value="134000">甘肃</option>
            <option value="135500">陕西</option>
            <option value="137000">云南</option>
            <option value="139000">四川</option>
            <option value="141500">海南</option>
            <option value="142000">福建</option>
          </select>
          <input type="hidden" name="province" id="province" value="" />
          <select class="form-control" style="margin-right:0;" id="city_lists"  onchange="set_area(this);">
            <option value="">选择城市</option>
          </select>
          <em>*</em>
          <input type="hidden" name="city" id="city" value="" />
        </div>
      </div>
    </div>
  </div>
  <div class="sb_fd" style="margin-top:-40px"> <span class="check_box"> 已选<b class="fn">0</b>件 </span> <a href="javascript:void(0)" id="ljxj" class="xjBtn">立即询价</a> </div>
</div>
<!--对比弹层-->
<div class="sb_layer yincang sb_layer_duibi"  id="dbtc">
  <div class="sb_hd"> <span class="check_box">
    <input type="checkbox" id="checkAll_duibi">
    共<b class="all" id="compareCount">0</b>件，已选<b class="fn">0</b>件 </span> <a id="closecompare" href="javascript:void(0)" style="margin-left:25px">【关闭】</a> </div>
  <div class="sb_bd">
    <ul id="cmpContent">
    </ul>
  </div>
  <div class="sb_fd"> <span class="check_box"> 已选<b class="fn">0</b>件 </span> <a href="javascript:void(0)" id="ksdb" class="xjBtn">开始对比</a> </div>
</div>
<script src="/nj/Static/modules/seajs/sea.js" id="seajsnode" ></script>
<script src="/nj/seajs.config.js"></script>
<script>
var jrChannel='1#0';
seajs.use('app/product_list.js');
define("page_use",function(require,exports,module) {
	var $ = require('jquery');
	var base = require('base');
	require('tip');
	$('.sb_ewm').tip($('.bb_ewm'), {place:'left-center'});
	
	$('.sb_bd').height($('.sb_layer').height()-$('.sb_hd').outerHeight()-$('.sb_fd').outerHeight());
	$(window).resize(function(){
		$('.sb_bd').height($('.sb_layer').height()-$('.sb_hd').outerHeight()-$('.sb_fd').outerHeight());
	});
	//询价
	$('.sb_layer_xunjia').on('click','#checkAll_xunjia',function(){
		var xjCheck = $('input[name="xj_subBox"]');
		if($(this).prop('checked')){
			xjCheck.prop("checked",true);	
		}else{
			xjCheck.prop("checked",false);		
		}
		$('.sb_layer_xunjia .check_box').find('.fn').html($('#xunjiaContent').find("input[name='xj_subBox']:checked").length);
	});
	$('.sb_layer_xunjia').on('click','input[name="xj_subBox"]',function(){
		var xjCheck = $('input[name="xj_subBox"]');
		$("#checkAll_xunjia").prop("checked",xjCheck.length == $('input[name="xj_subBox"]:checked').length ? true : false);
		$('.sb_layer_xunjia .check_box').find('.fn').html($('#xunjiaContent').find("input[name='xj_subBox']:checked").length);
	})
	//询价添加总数
	$('.sb_layer_xunjia .check_box').find('.all').html($('#xunjiaContent').find("input[name='xj_subBox']").length);
	$('.sb_xunjia .num').html($('#xunjiaContent').find("input[name='xj_subBox']").length);
	//弹出询价
	$('.sb_xunjia').click(function(e){
		e.preventDefault();
		$('.sb_layer').stop().animate({right:'-100%'},500);
		$(this).addClass('si_act').siblings().removeClass('si_act');
		if($('.sb_layer_xunjia').hasClass('yincang')){
			$('.sb_layer_xunjia').removeClass('yincang').stop().animate({right:35},500);
			$(this).addClass('si_act');
		}else{
			$('.sb_layer_xunjia').addClass('yincang').stop().animate({right:'-100%'},500);
			$(this).removeClass('si_act');
		}
	});
	$('#closexunjia').click(function(e){
		e.preventDefault();
		$('.sb_layer').stop().animate({right:'-100%'},500);
		$(this).addClass('si_act').siblings().removeClass('si_act');
		if($('.sb_layer_xunjia').hasClass('yincang')){
			$('.sb_layer_xunjia').removeClass('yincang').stop().animate({right:35},500);
			$(this).addClass('si_act');
		}else{
			$('.sb_layer_xunjia').addClass('yincang').stop().animate({right:'-100%'},500);
			$(this).removeClass('si_act');
		}
	});


});
seajs.use("page_use");
</script>
<div style="display:none"><script src="http://s95.cnzz.com/stat.php?id=1258830328&web_id=1258830328" language="JavaScript"></script></div>
</body>
</html>
<script type="text/javascript" src="/nj/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/nj/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/nj/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<link href="/nj/plugin/dialog/jBox/Skins/GreyBlue/jbox.css" type="text/css" rel="stylesheet"/>
<link href="/nj/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" />
<script type="text/javascript" src="/nj/scripts/prolist.js"></script>
<script src="http://script.v.jerei.com/recv.js" type="text/javascript"></script>
<script>
	jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province = remote_ip_info["province"];
	var city = remote_ip_info["city"];
	$('#province').val(province);
	$('#city').val(city);
	$("#select_province option:contains("+province+")").attr("selected",true);
	$("#select_province").change();
	    jQuery.ajax({
			url : '/nj/action/ajax.jsp',
			data : {
				flag : 'get_city_by_name',
				province : province
			},
			success : function(data) {
					if($.trim(data)!=""){
						$("#city_lists").html(data);
						$("#city_lists option:contains("+city+")").attr("selected",true);
					}
			}
		});
    }) ;
	
    $('#xjtc').mouseleave(function(){
		$('.sb_layer').stop().animate({right:'-100%'},500);
		$(this).addClass('si_act').siblings().removeClass('si_act');
		if($('.sb_layer_xunjia').hasClass('yincang')){
			$('.sb_layer_xunjia').removeClass('yincang').stop().animate({right:35},500);
			$(this).addClass('si_act');
		}else{
			$('.sb_layer_xunjia').addClass('yincang').stop().animate({right:'-100%'},500);
			$(this).removeClass('si_act');
		}
    });   
	$('#dbtc').mouseleave(function(){
        //e.preventDefault();
		$('.sb_layer').stop().animate({right:'-100%'},500);
		$(this).addClass('si_act').siblings().removeClass('si_act');
		if($('.sb_layer_duibi').hasClass('yincang')){
			$('.sb_layer_duibi').removeClass('yincang').stop().animate({right:35},500);
			$(this).addClass('si_act');
		}else{
			$('.sb_layer_duibi').addClass('yincang').stop().animate({right:'-100%'},500);
			$(this).removeClass('si_act');
		}
    });
</script>
