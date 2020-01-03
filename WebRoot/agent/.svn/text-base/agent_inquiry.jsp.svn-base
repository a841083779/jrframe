<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern"));
		if(usern.equals("hfxy")){
%>
    <script>
	window.location.href="/agentstore/hfxy/";
	</script>
<%	
	}
	if(usern.indexOf("?")>0){
	   usern=usern.substring(0,usern.indexOf("?"));
	}
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	Map brandUsernMap = (Map)application.getAttribute("brandUsernMap");
	
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	String catalog = CommonString.getFilterStr(request.getParameter("catalog")) ;
	String factoryid = CommonString.getFilterStr(request.getParameter("factoryid")) ;
    Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	String place="";
	String address="";
    Map hzpyMap=(HashMap)application.getAttribute("hzpyMap") ;
    Map pyhzMap=(HashMap)application.getAttribute("pyhzMap") ;String area = CommonString.getFormatPara(request.getParameter("area")) ;
	try{
		connection = dbHelper.getConnection();
		List<Map> provinceList = dbHelper.getMapList(" select * from hz_py where province='0' order by id asc ",connection) ;
		Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
		if(map == null){
			Common.do302(response,"/agent");
			return;
		}
		Integer is_shop = CommonString.getFormatInt(map.get("is_shop"));
		/*
		if(is_shop.equals(1)){
			Common.do302(response,"/agentshop/"+CommonString.getFormatPara(map.get("usern"))+"/");
			return;
		}
		*/
		String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
		String catalogname = CommonString.getFormatPara(request.getParameter("catalogname"));
		
		String agentid = CommonString.getFormatPara(map.get("id"));
        Map agentMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object [] {agentid},connection);
		//如果代理商是办事处，则查询办事处上级
		if(!"".equals(CommonString.getFormatPara(agentMap.get("parent_id")))&&!"0".equals(CommonString.getFormatPara(agentMap.get("parent_id")))){
				agentid = CommonString.getFormatPara(agentMap.get("parent_id"));
		}
		String offset = CommonString.getFormatPara(request.getParameter("offset"));
		String whereStr = " and is_deleted=0";
        if(!"".equals(factoryid)){
	    whereStr+=" and factoryid="+factoryid ;
        }
        if(!"".equals(catalog)){
	    whereStr+=" and catanum like '%"+catalog+"%'" ;
        }

		PageBean pageBean = new PageBean() ; // 分页程序
		pageBean.setPageSize(10) ; // 每页显示条数
		Integer nowPage = 1 ;
		if(!"".equals(offset) && !"0".equals(offset)){
		   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
		}		
		String url = CommonString.getFormatPara(request.getQueryString()) ;
		url = url.replace("/"+usern+"/agent_products.shtm","/agent_products.jsp?usern="+usern);
		if(!"".equals(url)){
			if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
				url="" ;
			}else if(url.indexOf("offset")!=-1 ){
				url = "&"+url.substring(url.indexOf("&")+1) ;
			}else{
				url = "&"+url ;
			}
		}
		
		pageBean.setNowPage(nowPage) ;   
		pageBean.setOrderBy(" id desc ") ;  // 默认排序
		pageBean.setFields(" id,factoryname,factoryid,cataname,name,mobile_phone,contact_tel,contact_address,product_name,add_date,province,city ") ;
		pageBean.setTableName("pro_product_form") ;
		pageBean.setParams(url) ;
		pageBean.setCondition(whereStr.toString()) ;
		//String ip  = Common.getIp(request);
		//String jsonStr = Tools.getMyProvinceAndCity(ip);
		String city = "";
		String province = "";
		//if(!CommonString.getFormatPara(jsonStr).equals("")){
			//JSONObject obj = new JSONObject(jsonStr);
			//if(null!=obj&&obj.length()>0){
				//province = CommonString.getFormatPara(obj.getString("province"));
				//city = CommonString.getFormatPara(obj.getString("city"));
			//}
		//}
		
	String agent_fac_ids="";
	Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {map.get("id")},connection);
		
    //代理品牌
	String dali_brand="";
	//代理产品及品牌
    String dali_pro="";
	//代理类别
	String agent_fac_id_list=CommonString.getFormatPara(map.get("agent_fac"));
    String fac_ids_list[]=agent_fac_id_list.split(",");
	    for(int i=0;i<fac_ids_list.length;i++){
		    if(!fac_ids_list[i].equals("")){
			Map facInfo = dbHelper.getMap(" select name,usern from pro_agent_factory where id = "+fac_ids_list[i],connection);
			   dali_brand+=CommonString.getFormatPara(facInfo.get("name"));
			       List<Map> proInfo = dbHelper.getMapList("select catalognum,catalogname from pro_agent_product_vi where agentid = '"+CommonString.getFormatPara(map.get("id"))+"' and factoryid = '"+fac_ids_list[i]+"'  group by catalognum,catalogname order by catalognum",connection);
                             for(Map oneMap : proInfo){
							  dali_pro+=CommonString.getFormatPara(facInfo.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"));
							 }
			}
	}
    //代理区域
	String TDK_keywords="";
	String city_list=CommonString.getFormatPara(map.get("city"));
	String cityList[]=city_list.split(",");
	for(int i=0;i<cityList.length;i++){
	      TDK_keywords+=cityList[i]+CommonString.getFormatPara(brandMap.get(factoryid))+(String)("".equals(catalog)?"工程机械":CommonString.getFormatPara(catalogMap.get(catalog)))+"价格表,";
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【价格表】<%=CommonString.getFormatPara(map.get("city"))%><%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=("".equals(catalog)?"工程机械":CommonString.getFormatPara(catalogMap.get(catalog)))%>价格表|厂家报价_<%=CommonString.getFormatPara(map.get("full_name"))%></title>
<meta name="keywords" content="<%=TDK_keywords+CommonString.getFormatPara(map.get("full_name"))%>" />
<meta name="description" content="<%=CommonString.getFormatPara(map.get("full_name"))%>是<%=CommonString.getFormatPara(map.get("city"))%><%=dali_pro%>代理商,提供最新<%=CommonString.getFormatPara(map.get("city"))%><%=dali_pro%>系列产品价格,帮助您全面了解<%=CommonString.getFormatPara(map.get("city"))%><%=dali_pro%>." /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
<script>
 function showCity(obj){
     $("#city").show();
	 $("#"+obj).show().siblings('dd').hide();
 }
 function showCata(obj){
     $("#cataDetail").show();
	 $("#"+obj).show().siblings('dd').hide();
 }
 $(document).ready(function() {
    $('#city').mouseleave(function(){
		$(this).hide();
	})
});
 $(document).ready(function() {
    $('#cataDetail').mouseleave(function(){
		$(this).hide();
	})
});
 function hideCata(){
  $("#cataDetail").hide();
 }
</script>
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; <a href="/agent/">代理商专区</a> &gt;&gt; <%=CommonString.getFormatPara(map.get("full_name")) %></h3>
</div>
<!--面包屑结束--> 
<!--广告-->
<!-- <div class="contain980 mb10"><img src="/images/ad04.jpg" width="980" height="60" /></div> -->
<!--广告结束--> 
<!--main-->
<div class="contain980 mb10">
  <div class="asiteTop mb10">
    <div class="wfull l">
      <div class="comInfo">
        <h2 class="l"><%=CommonString.getFormatPara(map.get("full_name"))%></h2>
         <style>
        .soSpan{ background: none repeat scroll 0 0 #E3EDF7;border: 1px solid #BBBBBB;color: #2D66B5;float: right;height: 21px;line-height: 21px;margin-top: 10px;padding: 0 15px;text-align: center;width: auto;cursor:pointer ;}
        </style>
         <span style='<%=(CommonString.getFormatPara(map.get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(map.get("is_made")).equals("1"))?"":"display:none;" %>' class="soSpan" onclick="window.open('http://<%=CommonString.getFormatPara(map.get("usern")) %>.product.21-sun.com')">进入<%=CommonString.getFormatPara(map.get("name"))%>官方旗舰店</span>
        <span class="r"><%if(!CommonString.getFormatPara(map.get("logo")).equals("")){%><img src="/uploadfiles/<%=CommonString.getFormatPara(map.get("logo"))%>" width="172" height="46" /><%}%></span> </div>
      <!--<div class="tel l">销售专线：<%=CommonString.getFormatPara(map.get("telphone"))%></div>-->
      <%
      	if(newsCount>0){
      		%><ul class="agentNav r" style="width: 703px;"><%
      	}else{
      		%><ul class="agentNav r" style="width: 583px;"><%
      	}
      %>
        <li><a href="/agent/<%=usern%>/">代理商首页</a></li>
        <li><a href="/agent/<%=usern%>/introduce.shtm">公司简介</a></li>
        <li><a href="/agent/<%=usern%>/agent_products.shtm">代理机型</a></li>
        <li><a href="/agent/<%=usern%>/agent_message.shtm">在线询价</a></li>
		<li  class="anSelect"><a href="/agent/agent_inquiry.jsp?usern=<%=usern%>">代理价格</a></li>
        <%if(newsCount>0){%><li><a href="/agent/<%=usern%>/agent_news.shtm">企业动态</a></li><%}%>
      </ul>
    </div>
  </div>
  <!--left-->
  <div class="w270 l"> 
    <!--公司介绍-->
    <div class="agentInfo mb10">
      <div class="agentInfobg">
        <h2><%=CommonString.getFormatPara(map.get("full_name"))%></h2>
        <div class="agentInfoDetail">
          <%if(!CommonString.getFormatPara(map.get("address")).equals("")){%>地址：<%=CommonString.getFormatPara(map.get("address"))%><br /><%}%>
          <%if(!CommonString.getFormatPara(map.get("postcode")).equals("")){%>邮编：<%=CommonString.getFormatPara(map.get("postcode"))%> 　 <br /><%}%>
          <%if(!CommonString.getFormatPara(map.get("concatus")).equals("")){%> 联系人：<%=CommonString.getFormatPara(map.get("concatus"))%> <br /><%}%>
          <%if(!CommonString.getFormatPara(map.get("area")).equals("")){%>主要经营：<%=CommonString.getFormatPara(map.get("area")).length()>=100?CommonString.getFormatPara(map.get("area")).substring(0,100)+"...":CommonString.getFormatPara(map.get("area"))%><br /><%}%>
         <%if(!CommonString.getFormatPara(map.get("agent_fac")).equals("")){%> 代理品牌：
		 <%
		    agent_fac_ids=CommonString.getFormatPara(map.get("agent_fac"));
			String fac_ids[]=agent_fac_ids.split(",");
			for(int i=0;i<fac_ids.length;i++){
			   if(!fac_ids_list[i].equals("")){
			   Map facInfo = dbHelper.getMap(" select name,usern from pro_agent_factory where id = "+fac_ids[i],connection);
		 %>
		 <font><a href="/brand/<%=CommonString.getFormatPara(facInfo.get("usern"))%>/"><%=CommonString.getFormatPara(facInfo.get("name"))%></a></font>
		 <%}}}%>
         </div>
        <div class="more01 blue">
        	        <%
        	if("".equals(CommonString.getFormatPara(map.get("mobile_phone")))){
        		%>
        <div class="agent_li" style="width: auto; border: none;"><ul style="border: none;"><li class="g5"><a id="seePhone_<%=map.get("id") %>" style="text-align: left;" href="javascript:void(0);" onclick="lianXiDianHua('<%=map.get("id") %>');">点击查看联系电话</a></li></ul></div>
        		<%
        	}else{
        		%>
        <div class="agent_li" style="width: auto; border: none;"><ul style="border: none;"><li class="g5" style="width:130px;overflow:hidden;text-align: left;"><a class="gcur" href="javascript:void(0);">暂无联系方式</a></li></ul></div>
        		<%
        	}
        %>
       <div style="float: right;"><a href="/agent/<%=usern%>/introduce.shtm">更多介绍 &gt;&gt;</a></div>
       </div>
      </div>
    </div>
    <!--公司介绍结束--> 
    <!--主营品牌-->
    <div class="agentLeftPart mb10" id="brandId">
      
    </div>
    <!--主营品牌结束--> 
  </div>
  <!--left end--> 
  
  
  <div class="w695 border03 l Condition mb10" style="float:right">
    <div class="ConditionTop">
      <div class="l">
        <%if (!"".equals(catalog) || !"".equals(factoryid)) {%>
        <span class="reset" ><a href="/agent/agent_inquiry.jsp?usern=<%=CommonString.getFormatPara(map.get("usern"))%>">重置</a></span>
        <%}%>

        <%if (!"".equals(catalog) && !"".equals(catalog)) {%>
        <span><em>
		<%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a href="/agent/agent_inquiry.jsp?usern=<%=CommonString.getFormatPara(map.get("usern"))%>?<%=province.equals("")?"":"province="+province%><%=city.equals("")?"":"&city="+city%><%=factoryid.equals("")?"":"&factoryid="+factoryid%>" title="取消" class="delete" ></a> </span>
        <%}%>
        <%if (!"".equals(factoryid) && !"".equals(factoryid)) {%>
        <span><em><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%></em> <a href="/agent/agent_inquiry.jsp?usern=<%=CommonString.getFormatPara(map.get("usern"))%>?<%=province.equals("")?"":"province="+province%><%=city.equals("")?"":"&city="+city%><%=catalog.equals("")?"":"&catalog="+catalog%>" title="取消" class="delete" ></a> </span>
        <%}%>
			    <%if (!"".equals(place) && !"".equals(place)) {%>
        <span><em><%=place%></em> <a href="/agent/agent_inquiry.jsp?usern=<%=CommonString.getFormatPara(map.get("usern"))%>?<%=catalog.equals("")?"":"catalog="+catalog%><%=factoryid.equals("")?"":"&factoryid="+factoryid%>" title="取消" class="delete" ></a> </span>
        <%}%>
      </div>
      <h3 class="r"><%=place%><%=address%><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%></h3>
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
        <dd style="width:550px;"> <a href="/agent/agent_inquiry.jsp?usern=<%=CommonString.getFormatPara(map.get("usern"))%><%=province.equals("")?"":"&province="+province%><%=factoryid.equals("")?"":"&factoryid="+factoryid%><%=city.equals("")?"":"&city="+city%>" <%if("".equals(catalog)){%> class='select' <%} %>>不限</a> 
	     <%
		       agent_fac_ids=CommonString.getFormatPara(map.get("agent_fac"));
			   agent_fac_ids=agent_fac_ids.replace(",","','");
			   List<Map> facInfos = dbHelper.getMapList("select catalognum,catalogname from pro_agent_product_vi where agentid = '"+agentid+"' and factoryid in ('"+agent_fac_ids+"')  group by catalognum,catalogname order by catalognum",connection);
		       for(Map oneMap : facInfos){
		%>
     	<a  href="/agent/agent_inquiry.jsp?usern=<%=CommonString.getFormatPara(map.get("usern"))%>&catalog=<%=CommonString.getFormatPara(oneMap.get("catalognum"))%><%=factoryid.equals("")?"":"&factoryid="+factoryid%>" <%if(CommonString.getFormatPara(oneMap.get("catalognum")).equals(catalog)){%> class='select' <%} %>><%=CommonString.getFormatPara(oneMap.get("catalogname"))%></a>
               <%}%>
        </dd>
      </li>
      <li class="cblist">
      <dt> 品牌 </dt>
        <dd style="width:550px;">
          <a   href="/agent/agent_inquiry.jsp?usern=<%=CommonString.getFormatPara(map.get("usern"))%><%=catalog.equals("")?"":"&catalog="+catalog%>" <%if("".equals(factoryid)){%>  class="select" <%} %>>不限</a>
          <%
		       agent_fac_ids=CommonString.getFormatPara(map.get("agent_fac"));
			   String fac_idss[]=agent_fac_ids.split(",");
		       for(int i=0;i<fac_idss.length;i++){
			   if(!"".equals(fac_idss[i])){
			   Map facInfo = dbHelper.getMap(" select name,usern,id from pro_agent_factory where id = "+fac_idss[i],connection);
		 %>
         <a  href="/agent/agent_inquiry.jsp?usern=<%=CommonString.getFormatPara(map.get("usern"))%>&factoryid=<%=CommonString.getFormatPara(facInfo.get("id"))%><%=catalog.equals("")?"":"&catalog="+catalog%>"
             <%if(CommonString.getFormatPara(facInfo.get("id")).equals(factoryid)){%>
											class="select" <%} %> ><%=CommonString.getFormatPara(facInfo.get("name"))%></a>
          <%}}%>
        </dd>
      </li>
      <!-- 广告投放 -->
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

  <!--right-->
  <div class="w697 r"> 
   <cache:cache cron="* * */1 * *">
    <%
 	  List<Map>	pro_orders = pageBean.getDatas() ;
	%>
    <!--<div style="padding-bottom:6px;"><a href="http://ad.21-sun.com/link_to.jsp?paras=12,17,2779&url=http://product.21-sun.com/case/ " target="_blank"><img src="/ads/ad01.jpg" width="757" height="78" /></a></div>-->
    <!--询价列表-->
    <div class="w695 border03 l mb10 list08">
      <div class="title08 listTop">
        <h3><b><%="".equals(area)?"":area+"地区" %><%= CommonString.getFormatPara(brandMap.get(factoryid))%><%="".equals(catalog)?"":CommonString.getFormatPara(catalogMap.get(catalog))%>询价单总数：<%=pageBean.getTotal() %></b> </h3>
        <div class="r"> <%=pageBean.getUpPageBar() %> </div>
      </div>
      <ul class="ti">
        <li class="i1">编号</li>
        <li class="i2" style="width:182px;">询价产品</li>
        <li class="i3">联系人</li>
        <li class="i4" style="width:85px;">电话</li>
        <li class="i5">询价品牌</li>
        <li class="i6">询价区域</li>
        <li class="i7" style="width:95px;">询价时间</li>
      </ul>
      <div class="li" id="showorders">
        <%
		String cDate = CommonDate.getToday("yyyy-MM-dd");
         if(pro_orders.size()>0){
        	Iterator iter = pro_orders.iterator() ;
        	Map oneMap = new HashMap() ;
        	int i = 1 ;
        	String showtel = "" ; 
        	while(iter.hasNext())
        	{
        		oneMap = (HashMap)iter.next() ;
        		showtel = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("contact_tel")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
        		
        		if(showtel.length()>7&&showtel.length()<=20){
        			showtel = showtel.substring(0,2)+"***"+showtel.substring(showtel.length()-2) ;
        		}else if(showtel.length()>3){
        			showtel = showtel.substring(0,4)+"***" ;
        		}else
        		{
        			showtel = showtel+"***" ;
        		}
				String addDate = (CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date"));
				if(cDate.compareTo(addDate) < 0){
					addDate = cDate;	
				}
        		%>
        <ul class="libg01">
          <li class="i1"><%=i %></li>
          <%if("".equals(province)&&"".equals(city)){%>
          <li class="i2" style="text-align:left;width:178px;"><a href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
          <%}else{%>
          <li class="i2" style="text-align:left;width:178px;"><a href="/inquiry/area_for_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm?<%=province.equals("")?"":"province="+province%><%=city.equals("")?"":"&city="+city%>" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
          <%}%>
          <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
          <li class="i4" style="width:85px;"><%=showtel %></li>
          <li class="i5"><a href="/inquiry/0_0_<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>_0.shtm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
          <li class="i6"><a href="/inquiry/<%= (String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("province")))%>_0_0_0.shtm" target="_blank"><%="".equals(CommonString.getFormatPara(oneMap.get("province")))?"-":CommonString.getFormatPara(oneMap.get("province"))  %></a>
		  <a href="/inquiry/0_<%= (String)pyhzMap.get(CommonString.getFormatPara(oneMap.get("city")))%>_0_0.shtm" target="_blank"><%="".equals(CommonString.getFormatPara(oneMap.get("city")))?"-":CommonString.getFormatPara(oneMap.get("city"))  %></a></li>
          <li class="i7" style="width:95px;"><%=addDate %></li>
        </ul>
        <%
        		i++;
        	}
         }else{
        	 out.println("<li class='i2' style='width:100%;text-align:center;'>暂无订单!</li>") ;
         }
        %>
      </div>
      <!--翻页-->
      <div class="w695 l">
        <div id="pagination" class="page">
          <tags:page pageBean="<%=pageBean %>" />
        </div>
      </div>
      <!--翻页-->
    </div>
    <!--询价列表结束-->
  </cache:cache>
  </div>
  <!--right end-->
  <div class="clear"></div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true" />
<!--end of foot-->
<script type="text/javascript" src="/scripts/sort.js"></script>
<script language="javascript" type="text/javascript">
	//主营品牌
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"flag":"brandAgentCatalogList","agentid":"<%=CommonString.getFormatPara(map.get("id"))%>","agent_fac":"<%=CommonString.getFormatPara(map.get("agent_fac"))%>","agent_fac_name":"<%=CommonString.getFormatPara(map.get("agent_fac_name"))%>","usern":"<%=usern%>"},
		success:function(data){
			jQuery("#brandId").html(jQuery.trim(data));	
			if(jQuery.trim(data)==""){
				jQuery("#brandId").removeClass("agentLeftPart mb10");	
			}
		}
	})

		jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'<%=CommonString.getFormatPara(map.get("id"))%>'} ,
    	success:function(msg){
    	}
    });
</script>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>