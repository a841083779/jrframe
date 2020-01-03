<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern"));
		if(usern.equals("hfxy")){
%>
    <script>
	window.location.href="/agentstore/hfxy/";
	</script>
<%	
	}
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	Map brandUsernMap = (Map)application.getAttribute("brandUsernMap");
	try{
		connection = dbHelper.getConnection();
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
		Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
		Map brandMap = (HashMap)application.getAttribute("brandMap") ;
		String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
		String factory = CommonString.getFormatPara(request.getParameter("factory"));
		String catalogname = CommonString.getFormatPara(request.getParameter("catalogname"));
		String factoryname="";
		if(!catalognum.equals("")){catalogname=CommonString.getFormatPara(catalogMap.get(catalognum));}
		if(!factory.equals("")){factoryname=CommonString.getFormatPara(brandMap.get(factory));}
		String agentid = CommonString.getFormatPara(map.get("id"));
		//如果是办事处
		if(!"".equals(CommonString.getFormatPara(map.get("parent_id")))&&!"0".equals(CommonString.getFormatPara(map.get("parent_id")))){
			Map tMap = dbHelper.getMap(" select * from pro_agent_factory where id = ? ",new Object []{CommonString.getFormatPara(map.get("parent_id"))},connection);
			agentid = CommonString.getFormatPara(tMap.get("id"));
		}
		String offset = CommonString.getFormatPara(request.getParameter("offset"));
		String whereStr = " and agentid = '"+agentid+"' and is_show = 1 ";
		if(!catalognum.equals("")){
			whereStr += " and catalognum = '"+catalognum+"' ";	
		}
		if(!"".equals(catalogname)){
			//whereStr += " and catalogname = '"+catalogname+"' ";
		}
		if(!"".equals(factory)){
			whereStr += " and factoryid = "+factory+" ";
		}
		PageBean pageBean = new PageBean() ; // 分页程序
		pageBean.setPageSize(11) ; // 每页显示条数
		pageBean.setCondition(whereStr.toString()) ;
		
		Integer nowPage = 1 ;
		if(!"".equals(offset) && !"0".equals(offset)){
		   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
		}
		pageBean.setNowPage(nowPage) ;   
		pageBean.setOrderBy(" id desc ") ;  // 默认排序
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
		pageBean.setParams(url) ;
		pageBean.setFields(" id,img2,file_name,factoryid,factoryname,file_name,name,place,catalognum,catalogname,price_start,price_end ") ;
		pageBean.setTableName("pro_agent_product_vi") ;
		
		String ip  = Common.getIp(request);
		String jsonStr = Tools.getMyProvinceAndCity(ip);
		String city = "";
		String province = "";
		if(!CommonString.getFormatPara(jsonStr).equals("")){
			JSONObject obj = new JSONObject(jsonStr);
			if(null!=obj&&obj.length()>0){
				province = CommonString.getFormatPara(obj.getString("province"));
				city = CommonString.getFormatPara(obj.getString("city"));
			}
		}
		Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {
				map.get("id")
			},connection);
	//代理品牌
	String dali_brand="";
	//代理产品
    String dali_pro="";
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
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【电话】<%=CommonString.getFormatPara(map.get("city"))%><%=(factory.equals("")?"":factoryname+catalogname)%>代理商_<%=CommonString.getFormatPara(map.get("full_name"))%></title>
<meta name="keywords" content="<%=CommonString.getFormatPara(map.get("city"))%><%=(factory.equals("")?dali_brand:factoryname+catalogname)%>代理商,<%=CommonString.getFormatPara(map.get("full_name"))%>,<%=CommonString.getFormatPara(map.get("city"))%><%=dali_brand%>" />
<meta name="description" content="<%=CommonString.getFormatPara(map.get("full_name"))%>是<%=CommonString.getFormatPara(map.get("city"))%><%=(factory.equals("")?dali_brand:factoryname+catalogname)%>代理商,代理经营<%=CommonString.getFormatPara(map.get("city"))%><%=(factory.equals("")?dali_pro:factoryname+catalogname)%>系列产品." />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta name="mobile-agent" content="format=html5;url=http://m.product.21-sun.com/agent_pro.jsp?agent_id=<%=CommonString.getFormatPara(map.get("id"))%>&catalog=<%=catalognum%>&factory=<%=factory%>">
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
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
        .soSpan{
         background: none repeat scroll 0 0 #E3EDF7;
	    border: 1px solid #BBBBBB;
	    color: #2D66B5;
	    display: block;
	    float: right;
	    height: 21px;
	    line-height: 21px;
	    margin-top: 10px;
	    padding: 0 15px;
	    text-align: center;
	    width: auto;
	    cursor:pointer ;
	    }
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
        <li class="anSelect"><a href="/agent/<%=usern%>/agent_products.shtm">代理机型</a></li>
        <li><a href="/agent/<%=usern%>/agent_message.shtm">在线询价</a></li>
		<li><a href="/agent/agent_inquiry.jsp?usern=<%=usern%>">代理价格</a></li>
                <%
        	if(newsCount>0){
        		%>
        		 <li><a href="/agent/<%=usern%>/agent_news.shtm">企业动态</a></li>
        		<%
        	}
        %>
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
		    String agent_fac_ids=CommonString.getFormatPara(map.get("agent_fac"));
			String fac_ids[]=agent_fac_ids.split(",");
			for(int i=0;i<fac_ids.length;i++){
			   if(!fac_ids[i].equals("")){
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
  <!--right-->
  <div class="w697 r"> 
  <cache:cache cron="* * * */1 *">
  <%
		List<Map> list = pageBean.getDatas(connection);
  %>
    <!--代理产品-->
    <div class="w695 border03 l mb10 agentPro">
      <div class="title13">
        <h2>代理产品</h2>
      </div>
      <%
		if(list != null && list.size() > 0){
	  %>
      <ul class="ti">
    <li class="a6" style="width:124px;">图片</li>
    <li class="a7" style="width:93px;">品牌</li>
    <li class="a8">机型</li>
    <li class="a9" style="width:99px;">类别</li>
	<li class="a9" style="width:103px;">品类</li>
    <li class="a10">询价</li>
      </ul>
      <%
		}
	  %>
      <div class="li">
      <%
	  	if(list != null && list.size() > 0){
	  		for(int i = 0;list != null && i < list.size();i++){
			String pl=CommonString.getFormatPara(list.get(i).get("factoryname"))+CommonString.getFormatPara(list.get(i).get("catalogname"));
			String catalogNo=CommonString.getFormatPara(list.get(i).get("catalognum"));
			if(catalogNo.equals("101001001")||catalogNo.equals("101002003")||catalogNo.equals("101003001")){
			    catalogNo=catalogNo.substring(0,6);			}
			if(pl.length()>6)
			{
			  pl=pl.substring(0,6)+"...";
			}
	  %>
        <ul>
          <li class="a6" style="width:119px;"><a href="/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>" target="_blank"><img src="/uploadfiles/<%=CommonString.getFormatPara(list.get(i).get("img2"))%>" width="70" height="50" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" /></a></li>
          <li class="a7" style="width:93px;"><a href="/brand/<%=brandUsernMap.get(CommonString.getFormatPara(list.get(i).get("factoryid")))%>/" target="_blank"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%></a></li>
          <li class="a8"><a target="_blank"  href="/inquiry/index.jsp?proId=<%=CommonString.getFormatPara(list.get(i).get("id"))%>&proName=<%=CommonString.getFormatPara(list.get(i).get("name"))%>"><%=CommonString.getFormatPara(list.get(i).get("name"))%>价格</a></li>
          <li class="a9" style="width:99px;"><a target="_blank" href="/products/prolist.jsp?catalog=<%=CommonString.getFormatPara(list.get(i).get("catalognum"))%>"><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%></a></li>
          <li class="a9" style="width:103px;"><a title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))+CommonString.getFormatPara(list.get(i).get("catalogname"))%>" target="_blank" style="color:#fe6000" href="/products/prolist.jsp?factory=<%=CommonString.getFormatPara(list.get(i).get("factoryid"))%>&catalog=<%=catalogNo%>"><%=pl%></a></li>  
		 <li class="a10"><a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(list.get(i).get("id")) %>','<%=CommonString.getFormatPara(list.get(i).get("factoryid"))%>')"  class="plbtn">询价</a></li>
        </ul>
      <%}
		}else{
	  %> 
      	<span class="textStyle">暂无信息</span>
      <%}%> 
      </div>
	  <%
		if(list != null && list.size() > 0){
	  %>
      <div class="wfull l">
        <div id="pagination" class="page">
          <tags:page pageBean="<%=pageBean %>" url="/agent/agent_products.jsp"/>
        </div>
      </div>
      <%
		}
	  %>
    </div>
    <!--代理产品结束--> 
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
	function lianXiDianHua(id){
		var xunjia_user = jQuery.cookies.get("xunjia_user");
		if(null!=xunjia_user){
			seePhone(id);
			return;
		}
		jQuery.jBox("iframe:/include/agent/show_phone.jsp?id="+id,{
			title : "查看联系电话",
			width : 400,
			height : 290,
			top: '35%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return subSr;
				}
			}
		});
	}
	function seePhone(id){
		jQuery.post("/tools/ajax.jsp",{flag:'viewPhoneClickCount',id:id});
		var xunjia_user = jQuery.cookies.get("xunjia_user");
		var xunjia_phone = jQuery.cookies.get("xunjia_phone");
		var xunjia_catalog = jQuery.cookies.get("xunjia_catalog");
		var xunjia_catalog_name = jQuery.cookies.get("xunjia_catalog_name");
		var xunjia_brand = jQuery.cookies.get("xunjia_brand");
		var xunjia_brand_name = jQuery.cookies.get("xunjia_brand_name");
		jQuery.post("/tools/ajax.jsp",{
			flag : 'seePhone',
			name : xunjia_user,
			mobile_phone : xunjia_phone,
			province : '<%=province %>',
			city : '<%=city %>',
			catalog : xunjia_catalog,
			catalogName : xunjia_catalog_name,
			brand : xunjia_brand ,
			brandName : xunjia_brand_name ,
			id : id
		},function(data){
			jQuery("#seePhone_"+id).addClass("gcur");
			jQuery("#seePhone_"+id).html(data);
			jQuery("#seePhone_"+id).attr("tip_title",data);
			jQuery("#seePhone_"+id).removeAttr("onclick");
			jQuery("#seePhone_"+id).yitip();
			var singleTitleTip = jQuery("#seePhone_"+id).yitip("api");
			singleTitleTip.setPosition("rightMiddle");
		});
	}
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