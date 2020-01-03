<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%
	String usern = CommonString.getFormatPara(request.getParameter("usern"));
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String factoryid = "" ;
	try{
		connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
		if(map == null){
			Common.do302(response,"http://product.21-sun.com/404.htm");
			return;
		}
		if(map != null && !CommonString.getFormatPara(map.get("is_qijiandian")).equals("1")){
			Common.do302(response,"/agent/"+CommonString.getFormatPara(request.getParameter("usern"))+"/");
			return;	
		}
		factoryid = CommonString.getFormatPara(map.get("agent_fac")) ;  // 代理的品牌
		String factory_name = CommonString.getFormatPara(map.get("agent_fac_name")) ;  // 代理的品牌
		String agentid =CommonString.getFormatPara(map.get("id")) ;  // 代理商的品牌
		String sel_sql = " select * from pro_agent_product_vi where factoryid in("+factoryid.substring(0,factoryid.length()-1)+") and recommend=1 and agentid=?" ;
		List<Map> productsList = null ;
		if(!"".equals(factoryid)){
			if(factoryid.charAt(factoryid.length()-1)==','){
				productsList = dbHelper.getMapList(sel_sql,new Object[]{agentid}) ;
			}else{
			sel_sql = " select * from pro_agent_product_vi where factoryid in("+factoryid.replace(",,",",")+") and recommend=1 and agentid=?" ;
			productsList = dbHelper.getMapList(sel_sql,new Object[]{agentid}) ;
			}
		}
	// 预计购买时间
	LinkedHashMap buyTimeMap = (LinkedHashMap)CommonApplication.getEnumChildrenLink("102",application) ;
	Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {
			map.get("id")
		},connection);
	
	String title = CommonString.getFormatPara(map.get("full_name"))+"_"+factory_name+"代理商" +"-中国工程机械商贸网";
	String keywords = CommonString.getFormatPara(map.get("full_name")) ;
	String description = "中国工程机械商贸网提供"+ CommonString.getFormatPara(map.get("full_name"))+"代理商首页栏目，让您对"+ CommonString.getFormatPara(map.get("full_name"))+"更加了解，欢迎光临"+CommonString.getFormatPara(map.get("full_name"))+"品牌旗舰店。";

	if(!"".equals(CommonString.getFormatPara(map.get("seo_title")))){ 
		title = CommonString.getFormatPara(map.get("seo_title")) ; 
	}
	if(!"".equals(CommonString.getFormatPara(map.get("seo_keyword")))){
		keywords = CommonString.getFormatPara(map.get("seo_keyword")) ;
	}
	if(!"".equals(CommonString.getFormatPara(map.get("seo_desc")))){
		description = CommonString.getFormatPara(map.get("seo_desc")) ;
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=title%></title>
<meta name="keywords" content="<%=keywords %>" />
<meta name="description" content="<%=description %>" />
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/style/shop.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="http://product.21-sun.com/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery.form.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<script src="http://product.21-sun.com/scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">

   EvPNG.fix('div,ul,img,li,input,td,a'); 
</script>
<![endif]-->
<script type="text/javascript" src="http://product.21-sun.com/scripts/pinyin.js"></script>
<script type="text/javascript" src="/scripts/jquery.SuperSlide.js"></script>
<style>
.erweima { position:fixed; right:0px; top:225px;}
* html .erweima {position:absolute; left:expression(eval(document.documentElement.scrollLeft+document.documentElement.clientWidth-this.offsetWidth)-(parseInt(this.currentStyle.marginLeft,10)||0)-(parseInt(this.currentStyle.marginRight,10)||0)); top:expression(eval(document.documentElement.scrollTop)+225)}
</style>
</head>
<body class="style01">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--top end--> 
<!--面包屑-->
<div class="sTop00 whitebg">
  <div class="contain980">
    <h3 class="breadCrumbs">您现在所在的位置：<a href="/">工程机械产品中心</a> &gt;&gt; <a href="/agent/">代理商专区</a> &gt;&gt; <%=CommonString.getFormatPara(map.get("full_name")) %></h3>
  </div>
</div> 
<!--面包屑结束--> 
<div class="sTop01">
  <div class="contain980 h93px">
    <h2 class="companyName"> <%=CommonString.getFormatPara(map.get("full_name"))%><span class="intro"><%=CommonString.getFormatPara(map.get("sub_title")) %></span> </h2>
    <div class="approve">
      <div class="star"><span class="star01"></span></div>
    </div>
  </div>
</div>
<!--公司名称-->
<!--公司名称结束--> 
<!--店铺导航-->
<jsp:include page="nav_top.jsp"></jsp:include>
<!--店铺导航结束--> 
<!--主体-->
<div class="shopContain whitebg mb10"> 
  <!--banner-->
  <div class="bannerShow">
  	<%
  		String agentbanner= CommonString.getFormatPara(map.get("agentbanner"));
  		if(!"".equals(agentbanner)&&agentbanner.indexOf("http://")!=-1){
  			agentbanner = agentbanner+"";
  		}else{
  			agentbanner = "http://product.21-sun.com/uploadfiles/"+agentbanner;
  		}
  	%>
    <ul class="imgs">
      <li><img src="<%=agentbanner %>" width="960" height="200" onerror="showImgDelay(this,'/images/agentshop_logo.jpg',2);" /></li>
    </ul>
    <ul class="nums" style="display:none;">
      <li value="1" class="cur"></li>
    </ul>
  </div>
  <!--banner end-->
  <div class="h10px c"></div>
  <div class="w100 l shopLeftbg"> 
    <!--left-->
    <div class="shopLeft"> 
      <!--代理产品-->
      <div class="brand">
        <div class="sTitle">
          <h2>代理品牌</h2>
        </div>
        <div class="sContent" id="brandId"> 
        <%
        	String id = CommonString.getFormatPara(map.get("id")) ;
        	String agent_fac= CommonString.getFormatPara(map.get("agent_fac")) ;
        	String agent_fac_name = CommonString.getFormatPara(map.get("agent_fac_name")) ;
        	out.println(CommonHtml.getHTMLByURL("http://product.21-sun.com/action/ajax_list.jsp?flag=brandAgentCatalogListShop3&agentid="+id+"&agent_fac="+agent_fac+"&agent_fac_name="+agent_fac_name+"&usern="+usern+"")) ;
        %>
        </div>
      </div>
      <!--代理产品 结束-->
      <div class="w100 l h10px whitebg"></div>
      <!--公司资料-->
      <div class="sLeftPart companyInfo">
        <div class="sTitle">
          <h2>公司资料</h2>
        </div>
        <div class="sContent">
          <h3 class="companyName"><%=CommonString.getFormatPara(map.get("full_name"))%></h3>
          <span class="approve">官方认证旗舰店（第1年）</span>
          <div class="star"><span class="star01"></span></div>
          <div class="intro"> 
            <%=CommonString.getFormatPara(map.get("city")).equals("")?"":"代理地区："+CommonString.getFormatPara(map.get("city"))+" <br />"%>
            <%=CommonString.getFormatPara(map.get("agent_fac_name")).equals("")?"":"代理品牌："+CommonString.getFormatPara(map.get("agent_fac_name"))+"<br />"%>
            <%=CommonString.getFormatPara(map.get("telphone")).equals("")?"":"销售电话："+CommonString.getFormatPara(map.get("telphone"))+"<br />"%>
            <%=CommonString.getFormatPara(map.get("concatus")).equals("")?"":"联系人："+CommonString.getFormatPara(map.get("concatus"))+"<br />"%>
           <%
           	if(!"".equals(CommonString.getFormatPara(map.get("email")))){
           		%>
           		  电子邮件：<a href="mailto:<%=CommonString.getFormatPara(map.get("email"))%>">
                          <%=CommonString.getFormatPara(map.get("email"))%></a><br />
           		<%
           	}
           %>
             <%=CommonString.getFormatPara(map.get("saleqq")).equals("")?"":"销售QQ："+CommonString.getFormatPara(map.get("saleqq"))+"<br />"%>
          <%=CommonString.getFormatPara(map.get("serviceqq")).equals("")?"":"服务QQ："+CommonString.getFormatPara(map.get("serviceqq"))+"<br />"%>
            <%=CommonString.getFormatPara(map.get("fax")).equals("")?"":"传真："+CommonString.getFormatPara(map.get("fax"))+"<br />"%>
               <!--   邮政编码：<%=CommonString.getFormatPara(map.get("postcode"))%><br />  -->
           <%=CommonString.getFormatPara(map.get("address")).equals("")?"":" 地址："+CommonString.getFormatPara(map.get("address"))%> </div>
        </div>
      </div>
      <!--公司资料 结束--> 
      
    </div>
    <!--left end--> 
    <!--right-->
    <div class="shopRight"> 
      <!--推荐产品-->
      <div class="sRightPart">
        <div class="sTitle" id="recommendProT">
          <h2>推荐产品</h2>
          <span class="more"><a href="agent_products.htm">查看更多产品</a></span>
         </div>
        <div class="sContent"  id="recommendPro">
          <ul class="slist">
           <%
           	if(null!=productsList && productsList.size()>0){
           		for(Map oneMap:productsList){
           			%>
           	 <li>
              <div class="img"><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname")) %>"><img src="<%="http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2")) %>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_small.gif',2);" width="176px" height="147px" alt="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))  %>" /></a></div>
              <h3><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))  %>"><%=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))  %></a></h3>
              <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id")) %>','<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>','133')" class="btn">我要询价</a> 
            </li>
           			<%
           		}
           	}
           %>
          </ul>
        </div>
      </div>
      <!--主营产品-->
      <div class="sRightPart">
        <div class="sTitle">
          <h2>主营产品</h2>
          <span class="more"><a href="agent_products.htm">查看更多产品</a></span> </div>
        <jsp:include page="/include/agent/agentshop_products.jsp" flush="true">
        <jsp:param name="agentid" value='<%=CommonString.getFormatPara(map.get("id"))%>'></jsp:param>
        <jsp:param name="usern" value='<%=usern%>'></jsp:param>
        </jsp:include>
      </div>
      <!--公司简介-->
      <div class="sRightPart">
        <div class="sTitle">
          <h2>公司简介</h2>
          <span class="more"><a href="/agentshop/<%=usern%>/introduce.htm">查看更多详情</a></span> </div>
        <div class="sContent companyInfo">
          <div class="img"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(map.get("img1"))%>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="246" height="168" /></div>
          <div class="intro">
            <p class="text"><%=(CommonHtml.filterHTML(CommonString.getFormatPara(map.get("introduce"))).length()>=220)?CommonHtml.filterHTML(CommonString.getFormatPara(map.get("introduce"))).substring(0,220)+"...":CommonHtml.filterHTML(CommonString.getFormatPara(map.get("introduce")))%><a target="_blank" href="/agentshop/<%=usern%>/introduce.htm" title="查看详情" class="ablue"><b>[查看详情]</b></a></p>
            <a href="javascript:void(0)" title="免费询价" class="l mr20" onclick="showinquery('','<%=CommonString.getFormatPara(map.get("id"))%>','')"><img src="http://product.21-sun.com//images/simg_btn01.gif" alt="免费询价" width="188" height="45" /></a> <a href="http://product.21-sun.com/agent/login.jsp" target="_blank" title="代理商登录" class="l comlogin">代理商登录</a> </div>
        </div>
      </div>
      <!--在线询价-->
      <div class="sRightPart">
        <div class="sTitle">
          <h2>在线询价</h2>
        </div>
        <div class="sContent"> 
          <script type="text/javascript">
        jQuery(function(){
            jQuery(".inquiry .btn02").hover(function(){
                jQuery(this).toggleClass("hover");
            },function(){
                jQuery(this).removeClass("hover");
            });
        jQuery.ajax({
    	type:'post',
    	url:'http://product.21-sun.com/action/ajax.jsp',
    	data:{flag:'getAgentViewCount',agentId:'<%=CommonString.getFormatPara(map.get("id"))%>'} ,
    	success:function(msg){
    	}
    }) ;
        })
        </script>
          <form action="/action/order_save.jsp" method="post" name="theform" id="theform" onsubmit="return submitYN(this);">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="inquiry">
              <tr>
                <th width="13%" style="padding:5px 0px;">姓名：</th>
                <td width="87%"><input class="input01" name="zd_name" type="text" id="zd_name" size="30" maxlength="20" />
                  *</td>
              </tr>
               <tr>
                <th style="padding:5px 0px;">手机/固话：</th>
                <td><input class="input01" name="zd_mobile_phone" type="text" id="zd_mobile_phone" size="30" maxlength="15" />
                  *</td>
              </tr>
              <tr>
                <th style="padding:5px 0px;">地区：</th>
                <td><select name="zd_province" id="zd_province" onChange="set_city(this,this.value,theform.zd_city,'');" style="width:79px;"  dataType="Require"  msg="请选择省份">
                    <option value="安徽">安徽</option>
                    <option value="北京">北京</option>
                    <option value="重庆">重庆</option>
                    <option value="福建">福建</option>
                    <option value="甘肃">甘肃</option>
                    <option value="广东">广东</option>
                    <option value="广西">广西</option>
                    <option value="贵州">贵州</option>
                    <option value="海南">海南</option>
                    <option value="河北">河北</option>
                    <option value="黑龙江">黑龙江</option>
                    <option value="河南">河南</option>
                    <option value="湖北">湖北</option>
                    <option value="湖南">湖南</option>
                    <option value="内蒙古">内蒙古</option>
                    <option value="江苏">江苏</option>
                    <option value="江西">江西</option>
                    <option value="吉林">吉林</option>
                    <option value="辽宁">辽宁</option>
                    <option value="宁夏">宁夏</option>
                    <option value="青海">青海</option>
                    <option value="山西">山西</option>
                    <option value="山东">山东</option>
                    <option value="上海">上海</option>
                    <option value="四川">四川</option>
                    <option value="天津">天津</option>
                    <option value="西藏">西藏</option>
                    <option value="新疆">新疆</option>
                    <option value="云南">云南</option>
                    <option value="浙江">浙江</option>
                    <option value="陕西">陕西</option>
                    <option value="台湾">台湾</option>
                    <option value="香港">香港</option>
                    <option value="澳门">澳门</option>
                    <option value="海外">海外</option>
                  </select>
                  <select  name="zd_city" id="zd_city"  style="width:100px;" dataType="Require"  msg="请选择城市">
                    <option value="">选择城市</option>
                  </select>
                  *</td>
              </tr>
                <tr>
                <th width="13%" style="padding:5px 0px;">采购性质：</th>
                <td width="87%"><input name="zd_ifgroup" type="radio" checked value="个人" />
                  <font color="#434343">个人</font>
                  <input  name="zd_ifgroup" type="radio"  value="公司" />
                  <font color="#434343">公司</font>
                  <input type="text" value="公司名字" id="zd_company" name="zd_company" style="display:none;" />
                  *</td>
              </tr>
              <tr>
                <th align="right" nowrap="nowrap" class="list_cell_bg" style="padding:5px 0px">预计购买时间：</th>
                <td nowrap="nowrap" class="list_cell_bg"><select name="zd_buy_time" id="zd_buy_time" >
                    <%=CommonForm.createSelect(buyTimeMap,"1个月内") %>
                  </select>
                  *</td>
              </tr>
              <tr>
                <th style="padding:5px 0px;">留言内容：</th>
                <td><textarea class="textarea01" name="zd_message" cols="45" rows="5"  id="zd_message"></textarea></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td><input type="submit" name="button2" id="button2" value="提交" class="btn02" /></td>
              </tr>
            </table>
            <input type="hidden" name="tableName" id="tableName" value="pro_product_form"/>
            <input type="hidden" name="zd_contact_address" id="zd_contact_address" />
            <input type="hidden" name="zd_agentid" id="zd_agentid" value="<%=CommonString.getFormatPara(map.get("id")) %>"/>
            <input type="hidden" name="zd_agentname" id="zd_agentname" value="<%=CommonString.getFormatPara(map.get("name")) %>"/>
            <input type="hidden" name="zd_ifgroup" id="zd_ifgroup" value="个人"/>
            <!-- 属于公司或个人 -->
          </form>
        </div>
      </div>
      <%
			String whereStr = " ";
			String offset = CommonString.getFormatPara(request.getParameter("offset"));
			String agent_area = CommonString.getFormatPara(map.get("city")) ;  // 代理商代理地区
			String agent_factory = CommonString.getFormatPara(map.get("agent_fac")) ;  // 代理品牌
			String[] agent_factorys = null ;
			String agent_factory_str = "" ;
			 if(agent_factory.length()>0 && agent_factory.indexOf(",")>0){
				 agent_factorys = agent_factory.split(",") ;
			 }else{
				 whereStr+=" and factoryid="+agent_factory ;
			 }
			 if(null!=agent_factorys){
				 for(int i=0;i<agent_factorys.length;i++){
					 if(agent_factorys[i].length()>0 ){
						 agent_factory_str+=agent_factorys[i]+"," ;
					 }
				 }
			 }
			 if(agent_factory_str.length()>0 && agent_factory_str.lastIndexOf(",")!=0){
				 agent_factory_str = agent_factory_str.substring(0,agent_factory_str.length()-1) ;
			 }
			 if(agent_factory_str.length()>0){
				 whereStr += " and factoryid in("+agent_factory_str+")" ;
			 }
			 if(agent_area.length()>0 && agent_area.indexOf(",")==-1){ 
				  whereStr+= " and contact_address like'%"+agent_area+"%'" ;
			 }
			 String where = "" ;
			 if(agent_area.length()>0 && agent_area.indexOf(",")>0){  // 代理多个区域
				 String[] agent_areas = agent_area.split(",") ;
				 for(int i=0;i<agent_areas.length;i++){
					 where+=" or contact_address like '%"+agent_areas[i]+"%'" ;
				 }
			 }
			 if(where.length()>0 && where.indexOf("or")>0){
				 where = where.replaceFirst("or","") ;
			 }
			 if(where.length()>0){
				 whereStr+= " and ( "+where+" )" ;
			 }
			PageBean pageBean = new PageBean() ; // 分页程序
			pageBean.setPageSize(11) ; // 每页显示条数
			pageBean.setCondition(whereStr) ;
			
			Integer nowPage = 1 ;
			if(!"".equals(offset) && !"0".equals(offset)){
			   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
			}
			pageBean.setNowPage(nowPage) ;   
			pageBean.setOrderBy(" id desc ") ;  // 默认排序
			String url = CommonString.getFormatPara(request.getQueryString()) ;
			//url = url.replace("/"+usern+"/agent_products.shtm","/agent_products.jsp?usern="+usern);
			if(!"".equals(url)){
				if(url.indexOf("offset")!=-1 && url.indexOf("&")==-1){
					url="#order" ;
				}else if(url.indexOf("offset")!=-1 ){
					url = "&"+url.substring(url.indexOf("&")+1)+"#order" ;
				}else{
					url = "&"+url+"#order" ;
				}
			}
			pageBean.setParams(url) ;
			pageBean.setFields(" id,factoryname,cataname,product_name,add_date,name,mobile_phone,province,city,contact_address ") ;
			pageBean.setTableName("pro_product_form") ;
			List<Map> list = pageBean.getDatas();
	  %>
      <%
	  	if(list != null && list.size() > 0){
	  %>
      <div class="sRightPart list08">
        <div class="sTitle">
          <h2>产品订单<a name="order" id="order"></a></h2>
        </div>
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
          <%
			String showtel = "";
			for(int i = 0;list != null && i < list.size();i++){
				showtel = "".equals(CommonString.getFormatPara(list.get(i).get("mobile_phone")))?CommonString.getFormatPara(list.get(i).get("contact_tel")):CommonString.getFormatPara(list.get(i).get("mobile_phone")) ;
				if(showtel.length()>7&&showtel.length()<=20){
					showtel = showtel.substring(0,3)+"***"+showtel.substring(showtel.length()-3) ;
				}else if(showtel.length()>3){
					showtel = showtel.substring(0,4)+"***" ;
				}else
				{
					showtel = showtel+"***" ;
				}	
		%>
          <ul class="libg0<%=i%2+1%>">
            <li class="i1"><%=i+1%></li>
            <li class="i2"><a href="http://product.21-sun.com/inquiry/detail_for_<%=CommonString.getFormatPara(list.get(i).get("id"))%>.htm" target="_blank"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("product_name"))%><%=CommonString.getFormatPara(list.get(i).get("cataname"))%></a></li>
            <li class="i3"><%=(CommonString.getFormatPara(list.get(i).get("name")).length()>0)?CommonString.getFormatPara(list.get(i).get("name")).substring(0,1)+"***":"张**" %></li>
            <li class="i4"><%=showtel%></li>
            <li class="i5"><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%></li>
            <li class="i6"><%="".equals(CommonString.getFormatPara(list.get(i).get("contact_address")))?"-":CommonString.getFormatPara(list.get(i).get("contact_address"))  %></li>
            <li class="i7"><%=(CommonString.getFormatPara(list.get(i).get("add_date")).length()>15)?CommonString.getFormatPara(list.get(i).get("add_date")).substring(0,16):CommonString.getFormatPara(list.get(i).get("add_date")) %></li>
          </ul>
          <%}%>
        </div>
      </div>
      <%
		}
	%>
      <%
		if(list != null && list.size() > 0){
	  %>
      <div class="wfull l">
        <div id="pagination" class="page" style="<%=pageBean.getPageCount()>1?"margin-right:10px;":"display:none;" %>">
           <tags:domain_page pageBean="<%=pageBean %>" url="agent_message.htm"/>
        </div>
      </div>
      <%
		}
	  %>
    </div>
    <!--right end-->
    <div class="w100 l shopLeftLine"></div>
  </div>
  <div class="clear"></div>
</div>
<!--主体 结束--> 
<!--foot-->
<div class="shopFoot"> 
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--foot end-->
<div style="display:none"> 
  <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
  <script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
</body>
<script type="text/javascript" src="http://product.21-sun.com/scripts/citys.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/rememberAccount.js"></script>
<!--<script type="text/javascript" src="/scripts/agent_banner.js"></script>-->
<script type="text/javascript">
jQuery("#zd_message").text("您好，我对<%=CommonString.getFormatPara(map.get("full_name"))%>的产品感兴趣，想要咨询，请您给我回复，谢谢。");
function submitYN(event) {
	var mobile_phone_reg = /^1([\d]{10})$/;
	 var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	 // var connect_reg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?|(0([\d]{10}))$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
		alert("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		alert("请输入您的手机或固定电话！");
		setTimeout(function() {
		 	jQuery("#zd_mobile_phone").focus();
		},
		10);
		return false;
	}
  if(jQuery("#zd_ifgroup").val()=='公司'){
		if(jQuery("#zd_company").val()=='公司名字' || jQuery.trim(jQuery("#zd_company").val())==''){
			jQuery.jBox.tip("请输入公司名字") ;
			jQuery("#zd_company").focus() ;
			return false ;
		}
	}
	if (jQuery("#zd_mobile_phone").val().length != 0 && (!mobile_phone_reg.test(jQuery('#zd_mobile_phone').attr("value"))&&!connect_reg.test(jQuery('#zd_mobile_phone').attr("value")))) {
		alert("请输入正确的电话号码!");
		setTimeout(function() {
			jQuery("#zd_mobile_phone").focus();
			jQuery("#zd_mobile_phone").select(); 
		},
		10);
		return false;
	}
	jQuery("#zd_contact_address").val(jQuery("#zd_province").val()+jQuery("#zd_city").val()) ;
	jQuery("#theform").ajaxSubmit(function(msg){
			if("0"!=jQuery.trim(msg)){
				jQuery.jBox.tip("提交成功！") ;
				//  询价成功，把用户名和电话放入 cookie 中
				 SetCookie("order_name",jQuery("#zd_name").val()) ;
				 SetCookie("order_phone",jQuery("#zd_mobile_phone").val()) ;
				jQuery("#zd_mobile_phone").val("");
				jQuery("#zd_message").val("");
			}
		}) ;
		return false ;
}
jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province = remote_ip_info["province"];
	var city = remote_ip_info["city"];
	jQuery("#zd_province option:contains("+province+")").attr("selected",true);
	set_city(document.getElementById("zd_province"),document.getElementById("zd_province").value,document.theform.zd_city,'');
	document.getElementById("zd_city").value = city;
	 jQuery("#zd_contact_address").val(province+city) ;
}) ;

function showinquery(pid,agentid,factoryid){
	jQuery.jBox("iframe:http://product.21-sun.com/include/products/product_order_agent.jsp?productid="+pid+"&factoryid="+factoryid+"&agentid="+agentid+"&agentName="+encodeURIComponent("<%=CommonString.getFormatPara(map.get("name")) %>"), {
	title: "在线询价",
	width: 720,
	height: 450,
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
	jQuery(".jbox-button-panel").attr("style","display:none;") ;
}
	// 把下过订单的信息取出
jQuery(function(){
	var order_name = jQuery.trim(unescape(GetCookie("order_name"))) ;  // 订单人
    var order_phone = jQuery.trim(GetCookie("order_phone")) ;  // 订单电话
    if(''!=order_name && null!=order_name &&'null' != order_name){
    	jQuery("#zd_name").val(order_name) ;
    }
    if(''!=order_phone && null!=order_phone && "null"!=order_phone){
    	jQuery("#zd_mobile_phone").val(order_phone) ;
    }
})
jQuery("input:radio").bind("click",function(){
	jQuery("#zd_ifgroup").val(jQuery(this).val()) ;  // 个人或公司
	if(jQuery(this).val()=='公司'){
		jQuery("#zd_company").attr("style","width:150px;") ;
	}else{
		jQuery("#zd_company").attr("style","display:none;") ;
	}
}) ;
jQuery("#zd_company").focus(function(){
	if(jQuery(this).val()=='公司名字'){
	   jQuery(this).val("") ;
	}
})	
jQuery(function(){
	setTimeout(function(){
		if(jQuery.trim(jQuery("#recommendPro ul").html())==''){	
			jQuery("#recommendProT").parent("div").remove() ;
		}
		},0) ;
}) ;
</script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/scrolltopcontrol.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<%if(usern.equals("dingfengjixie")){%>
<div class="erweima"><img src="http://product.21-sun.com/images/dfew.jpg" width="170" height="170" /></div>
<%}%>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>