<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String comment_id = CommonString.getFormatPara(request.getParameter("id"));
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");	
	DBHelper dbHelper = DBHelper.getInstance() ;
	String id = "";
	String catalog = "";
	String product_id = "";
	String factoryid = "";
	String factoryname = "";
	String file_name = "";
	String catalognum = "";
	String product_name = "";
	String catalogname = "";
	String img2 = "";
	String good = "";
	String bad = "";
	String add_date = "";
	String contact_address = "";
	String content = "";
	int factoryInt = 0;
	int score = 0;
	int score1 = 0;
	int score2 = 0;
	int score3 = 0;
	int score4 = 0;
	int is_help=0;
	String username = "";
	Map commentMap = dbHelper.getMap("select pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pm.product_id,pp.factoryid,pp.factoryname,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pp.view_count from pro_comments pm left join pro_products pp on pm.product_id=pp.id where pm.id=" + comment_id + " order by pm.add_date desc");
	if(commentMap!=null){
		id = CommonString.getFormatPara(commentMap.get("id"));
		catalog = CommonString.getFormatPara(commentMap.get("catalognum"));
		product_id = CommonString.getFormatPara(commentMap.get("product_id"));
		factoryname = CommonString.getFormatPara(commentMap.get("factoryname"));
		is_help = CommonString.getFormatInt(commentMap.get("is_help"));
		factoryid = CommonString.getFormatPara(commentMap.get("factoryid"));
		factoryInt = CommonString.getFormatInt(commentMap.get("factoryid"));
		file_name = CommonString.getFormatPara(commentMap.get("file_name"));
		catalognum = CommonString.getFormatPara(commentMap.get("catalognum"));
		product_name = CommonString.getFormatPara(commentMap.get("product_name"));
		catalogname = CommonString.getFormatPara(commentMap.get("catalogname"));
		img2 = CommonString.getFormatPara(commentMap.get("img2"));
		good = CommonString.getFormatPara(commentMap.get("good"));
		bad = CommonString.getFormatPara(commentMap.get("bad"));
		add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm", CommonString.getFormatPara(commentMap.get("add_date")));
		contact_address = CommonString.getFormatPara(commentMap.get("contact_address"));
		content = CommonString.getFormatPara(commentMap.get("content"));
		score1 = Integer.parseInt(CommonString.getFormatPara(commentMap.get("score1")));
	    score2 = Integer.parseInt(CommonString.getFormatPara(commentMap.get("score2")));
	    score3 = Integer.parseInt(CommonString.getFormatPara(commentMap.get("score3")));
	    score4 = Integer.parseInt(CommonString.getFormatPara(commentMap.get("score4")));
	    score = (score1+score2+score3 +score4)/4;
	    username = CommonString.getFormatPara(commentMap.get("username"));
	}else if(commentMap==null){
	        Common.do302(response,"http://koubei.21-sun.com/");
			return;
	}
	//所有分类
	List<Map> allcatalogsList = dbHelper.getMapList("select name,num from pro_catalog where len(num) = 6");
	//其他口碑
	List<Map> otherList=null;
        otherList = dbHelper.getMapList("select top 5 pm.id,pm.score1,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pm.product_id,pm.is_help,pp.factoryid,pp.factoryname,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pp.view_count from pro_comments pm inner join pro_products pp on pm.product_id=pp.id where pm.product_id=" + product_id + " and pm.id<>" + id + " order by pm.add_date desc");
	if(otherList==null || otherList.size()<=0){ 
		otherList = dbHelper.getMapList("select top 5 pm.id,pm.score1,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pm.product_id,pm.is_help,pp.factoryid,pp.factoryname,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pp.view_count from pro_comments pm inner join pro_products pp on pm.product_id=pp.id where pm.id<>" + id + " and pp.catalognum='" + catalog + "' and pp.factoryid=" + factoryid + " order by pm.add_date desc");
	}
	String tdkTtile = "";
	if(good.equals("")){
		if(CommonHtml.filterHTML(content).length()>20){
			tdkTtile = content.substring(0,20);
		}else{
			tdkTtile = content;
		}
	}else{
		if(CommonHtml.filterHTML(good).length()>20){
			tdkTtile = good.substring(0,20);
		}else{
			tdkTtile = good;
		}
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【<%=CommonString.getFormatPara(commentMap.get("factoryname")) + CommonString.getFormatPara(commentMap.get("product_name")) + CommonString.getFormatPara(commentMap.get("catalogname")) %>怎么样?】<%=tdkTtile %>_<%=CommonString.getFormatPara(commentMap.get("factoryname")) + CommonString.getFormatPara(commentMap.get("product_name")) + CommonString.getFormatPara(commentMap.get("catalogname")) %>口碑_<%=CommonString.getFormatPara(commentMap.get("factoryname")) %> - 铁臂口碑</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(commentMap.get("factoryname")) + CommonString.getFormatPara(commentMap.get("product_name")) + CommonString.getFormatPara(commentMap.get("catalogname")) %>,<%=CommonString.getFormatPara(commentMap.get("factoryname")) + CommonString.getFormatPara(commentMap.get("product_name")) + CommonString.getFormatPara(commentMap.get("catalogname")) %>怎么样,<%=CommonString.getFormatPara(commentMap.get("factoryname")) + CommonString.getFormatPara(commentMap.get("product_name")) + CommonString.getFormatPara(commentMap.get("catalogname")) %>好不好,<%=CommonString.getFormatPara(commentMap.get("factoryname")) + CommonString.getFormatPara(commentMap.get("catalogname")) %>口碑" />
<meta name="description" content="铁臂口碑包含了大量<%=CommonString.getFormatPara(commentMap.get("factoryname")) + CommonString.getFormatPara(commentMap.get("product_name")) + CommonString.getFormatPara(commentMap.get("catalogname")) %>产品口碑，帮助您通过网络了解<%=CommonString.getFormatPara(commentMap.get("factoryname")) + CommonString.getFormatPara(commentMap.get("product_name")) + CommonString.getFormatPara(commentMap.get("catalogname")) %>产品怎么样,好不好，买<%=CommonString.getFormatPara(commentMap.get("factoryname")) + CommonString.getFormatPara(commentMap.get("product_name")) + CommonString.getFormatPara(commentMap.get("catalogname")) %>产品就上铁臂商城。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/koubei/style/koubei.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/validator.alert.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<link href="../style/friendly_link.css" rel="stylesheet" type="text/css" />
<!--[if IE 6]>
<script src="/scripts/iepng.js"></script>
<script>
   EvPNG.fix('.png')
</script>
<![endif]-->
<script type="text/javascript">
//导航选中状态
var jrChannel='2#0'
</script>
</head>
<body>
<!--top-->
<jsp:include page="include/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
<h3 class="breadCrumbs"><a href="/" title="铁臂口碑">铁臂口碑</a>&nbsp;&gt;&gt;&nbsp;最新口碑
  <%
  	if(!catalog.equals("")){
  %>
  <div style="display:none">&nbsp;&gt;&gt;&nbsp;<a href="/comment-<%=catalog.substring(0, 3) %>-0-0-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0, 3))) %></a></div>
  <%
  		if(catalog.length() >= 6){
  %>
  			&gt;&gt;&nbsp;<a href="/comment-<%=catalog %>-0-0-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog)) %></a>
  			&gt;&gt;&nbsp;<a href="/comment-0-<%=factoryInt %>-0-0-0.htm"><%=CommonString.getFormatPara(brandMap.get(factoryid)) %></a>
  			&gt;&gt;&nbsp;<a href="/comment-<%=catalog %>-<%=factoryInt %>-0-0-0.htm"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特") %><%=CommonString.getFormatPara(catalogMap.get(catalog)) %></a>
  			&gt;&gt;&nbsp;<a href="/comment-<%=catalog %>-<%=factoryInt %>-0-0-0.htm"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)) %><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0, 6))) %>怎么样</a>
  			&gt;&gt;&nbsp;<%=factoryname +product_name+catalogname %>怎么样

  <%
  		}else{
  %>
  		&gt;&gt;&nbsp;<%=CommonString.getFormatPara(catalogMap.get(catalog)) %>哪家好 
  <%			
  		}
  	}
  %></h3>
</div>
<!--面包屑结束-->
<div class="contain980 mb10 np_fix"> 
  <!--left-->
  <div class="w210 l n_pp_left np_left nkb_detleft">
	<div class="w208  l leftPart02 mb10 np_addpcat border02">
      <div class="stitle np_fix">
      	<% if(catalog.length() >= 6){  %>
        <h3 class="l"><%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)) %><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))) %></h3>
        <span class="r"><a href="/<%=catalog.substring(0, 6) %>-<%=factoryInt %>-0.htm" target="_blank" title="更多<%="".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)) %><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))) %>">更多&gt;&gt;</a></span>
        <%	} %>
      </div>
      <ul class="list003">
        <jsp:include page="/include/koubei/agent_products.jsp" flush="true">
			<jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
			<jsp:param name="factoryid" value="<%=factoryid %>"></jsp:param>
		</jsp:include>
      </ul>
    </div>
    <div class="mb10 nkb_zyyw border02 l w208">
    	<div class="nkb_zyyw_title">
        	<h2 class="l"><%=factoryname %>主营业务</h2>
            <span class="r"><a href="/0-<%=factoryid %>-0.htm" target="_blank" title="更多<%=factoryname %>主营业务">更多&gt;&gt;</a></span>
        </div>
        <ul class="nkb_zyyw_list np_fix">
        <%
       		if(allcatalogsList!=null && allcatalogsList.size()>0){
       			for(Map m:allcatalogsList){
       				String num = CommonString.getFormatPara(m.get("num"));
       				String cataname = CommonString.getFormatPara(m.get("name"));
       				List<Map> subcatalogList = dbHelper.getMapList("select top 1 id from pro_products where is_show=1 and factoryid = '"+factoryid+"' and catalognum like '"+num+"%'");
       				if(subcatalogList!=null && subcatalogList.size()>0){
       	%> 
        	<li><a target="_blank"  href="/<%=num %>-<%=factoryid %>-0.htm" title="<%=factoryname %><%=cataname %>"><%=cataname %></a></li>
         <%}}}%>
        </ul>
    </div>
    <div class="w208 border02 l leftPart02 mb10 pp_hotph">
      <h2><%=catalogname %>口碑排行 </h2>
      <ul class="list003" id="brandSubLeftId">
      	<jsp:include page="/include/koubei/brands.jsp" flush="true">
			<jsp:param name="factoryid" value="<%=factoryid %>"></jsp:param>
			<jsp:param name="catalog" value="<%=catalog %>"></jsp:param>
		</jsp:include>
      </ul>
    </div>
    <div class="mb10 nkb_zyyw border02 l w208 nkb_proxf">
    	<div class="nkb_zyyw_title">
    	<%	if(catalog.length() >= 6){%>
        	<h2><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0,3))) %>产品细分</h2>
        <%} %>
        </div>
        <ul class="nkb_zyyw_list np_fix">
	        <jsp:include page="/include/koubei/catelog.jsp" flush="true">
				<jsp:param name="catalog" value="<%=catalog %>"></jsp:param>
			</jsp:include>
        </ul>
    </div>
  </div>
  <!--left end--> 
  <!--right-->
  <div class="w757 r mb10 np_right nkb_det_right">
    <div class="l n_koubei_list ">
      <div class="plList nkb_pro_list np_fix nkb_det_top mb10" style="">
        <ul>
          <li>
            <div class="l" style="margin-top: 65px;">
              <div class="plimg"> <a  title="<%=factoryname +product_name+catalogname %>"> <img src="/uploadfiles/<%=img2 %>" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" alt="<%=factoryname +product_name+catalogname %>" title="<%=factoryname +product_name+catalogname %>"> </a> </div>
            </div>
            <div class="content">
              <div class="np_fix" style="margin-left: -150px;font-size: 13px;">
                <h1><a  title="<%=factoryname +product_name+catalogname %>怎么样?"><%=factoryname +product_name+catalogname %>怎么样?</a><span style="display: inline-block;position: absolute;top: 12px;left: 590px;">	
		<div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div></span></h1>
                <span class="time"><%=add_date %></span> <span class="youk" style="padding-right: 20px;float: right;line-height: 20px;"><a href="javascript:void(0)" onclick="vote('<%=id %>')"><b style="color: #ef4c07;font-weight: normal">有用</b></a> (<span id="vote_<%=id %>"><%=is_help%></span>)</span></div>
              <div class="plinfo01"><span class="plname"><%=username.equals("")?contact_address:username %>的评论</span></div>
              <div class="w100 np_fix">
                <p class="textContent"><% if(!good.equals("")){ %>优点：<%=good %><br /><%} %><% if(!bad.equals("")){ %>缺点：<%=bad %> <br /><%} %><%=content %> </p>
                <!--<div class="r plt">网友平均评分 <font><%=score %></font> 分</div>-->
              </div>
			 <%
              	String imgSqlTop = "select top 10 image from pro_comments_image where comment_id='"+id+"' and is_show=1";
              	List<Map> imgsListTop = dbHelper.getMapList(imgSqlTop);
              	if(imgsListTop!=null && imgsListTop.size()>0){
              %>
              <div class="diy_pic fix">
              <ul class="fix">
              <% 
              	for(Map m:imgsListTop){
              		String image = CommonString.getFormatPara(m.get("image"));
              %>
              <li><a href="javascript:void(0)"><img src="<%=image%>" width="40" height="40"><i></i></a></li>
              <%} %>
              </ul>
             <div class="pic_yuan"><a href="javascript:void(0)">收起</a><img src="" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="300" height="400" /></div>
              </div>
              <%} %>
			  
              <div class="n_kb_add_pf">
              	<p class="pftitle">网友评分</p>
                <ul class="np_fix nkb_pflist np_fix">
                	<li><span class="nkb_pfwz">价格：</span><div id="pricescore_<%=id %>" title="regular"></div><span class="nkb_pffs"><%=score1 %>分</span></li>
                    <li><span class="nkb_pfwz">性能：</span><div id="abilityscore_<%=id %>" title="regular"></div><span class="nkb_pffs"><%=score2 %>分</span></li>
                    <li><span class="nkb_pfwz">质量：</span><div id="qualityscore_<%=id %>" title="regular"></div><span class="nkb_pffs"><%=score3 %>分</span></li>
                    <li><span class="nkb_pfwz">售后：</span><div id="servicescore_<%=id %>"></div><span class="nkb_pffs"><%=score4 %>分</span></li>
                </ul>
              </div>
              <script language="javascript" type="text/javascript">
	            var s1_<%=id %> = (parseInt(<%=score1 %>,10)/20);
	  			var s2_<%=id %> = (parseInt(<%=score2 %>,10)/20);
	  			var s3_<%=id %> = (parseInt(<%=score3 %>,10)/20);
	  			var s4_<%=id %> = (parseInt(<%=score4 %>,10)/20);

	            //获得评论分数
	          	jQuery("#pricescore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s1_<%=id %>
	          	});
	          	jQuery("#abilityscore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s2_<%=id %>
	          	});
	          	jQuery("#qualityscore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s3_<%=id %>
	          	});
	          	jQuery("#servicescore_<%=id %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s4_<%=id %>
	          	});
              </script>
              <div class="nkb_moregg"><span><a title="<%=factoryname %>" href="/0-<%=factoryid %>-0.htm" target="_blank"><%=factoryname %></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a title="<%=factoryname %><%=catalogname %>" href="/<%=catalog.length()>6?catalog.substring(0,6):catalog %>-<%=factoryid %>-0.htm" target="_blank"><%=factoryname %><%=catalogname %></a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/comment-<%=catalog.length()>6?catalog.substring(0,6):catalog %>-<%=factoryid %>-0-0-0.htm" target="_blank" title="更多<%=factoryname %><%=catalogname %>口碑">更多<%=factoryname %><%=catalogname %>口碑</a></div>
           

		   
		   </div>
            <div class="k_zxzdj"><a href="javascript:;" onclick="showinquery('<%=product_id %>','')"><img src="/koubei/images/temp/1_03.png" alt="免费询价" width="120" height="27"></a></br></br><a href="http://koubei.21-sun.com/list/<%=product_id %>.htm#sentComment" target="_blank"><img src="/koubei/images/temp/1_05.png" alt="发表评论" width="120" height="27"></a></div>
          </li>
        </ul>
      </div>
	  
	
      <div class="plList nkb_pro_list np_fix nkb_det_top mb10">
      <div class="np_fix nkb_other_t">
      	<div class="l other_title">其他用户口碑</div>
        <div class="r other_more"><a href="/comment-<%=catalog.length()>6?catalog.substring(0,6):catalog %>-<%=factoryid %>-0-0-0.htm" target="_blank" title="更多<%=factoryname +product_name+catalogname %>口碑">更多&gt;&gt;</a></div>
      </div>
        <ul>
        <%
      	if(otherList!=null && otherList.size()>0){
      		for(Map oneMap : otherList){
      			String otherid = CommonString.getFormatPara(oneMap.get("id"));
				String otherfactoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
				String otherproduct_name = CommonString.getFormatPara(oneMap.get("product_name"));
				String othercatalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
				String othercatalognum=CommonString.getFormatPara(oneMap.get("catalognum"));
				if(othercatalognum.length()>6){othercatalognum=othercatalognum.substring(0,6);}
				String othercataname=CommonString.getFormatPara(catalogMap.get(othercatalognum)) ;
				String otherfile_name = CommonString.getFormatPara(oneMap.get("file_name"));
				String otherimg2 = CommonString.getFormatPara(oneMap.get("img2"));
				String otherfactoryid = CommonString.getFormatPara(oneMap.get("factoryid"));
				String otheradd_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm", CommonString.getFormatPara(oneMap.get("add_date")));
				String othercontact_address = CommonString.getFormatPara(oneMap.get("contact_address"));
				String othergood = CommonString.getFormatPara(oneMap.get("good"));
				String otherbad = CommonString.getFormatPara(oneMap.get("bad"));
				int pIs_help = CommonString.getFormatInt(oneMap.get("is_help"));
				String othercontent = CommonString.getFormatPara(oneMap.get("content"));
				int otherscore1 = Integer.parseInt(CommonString.getFormatPara(oneMap.get("score1")));
				int otherscore2 = Integer.parseInt(CommonString.getFormatPara(oneMap.get("score2")));
				int otherscore3 = Integer.parseInt(CommonString.getFormatPara(oneMap.get("score3")));
				int otherscore4 = Integer.parseInt(CommonString.getFormatPara(oneMap.get("score4")));
				int otherscore = (score1+score2+score3 +score4)/4;
				String otherUsername = CommonString.getFormatPara(oneMap.get("username"));
      %>
          <li>
            <div class="content" style="float:left;width:100%">
              <div class="np_fix">
               	<span class="plname" style="font-weight:bold;"><%=otherUsername.equals("")?othercontact_address:otherUsername %>对<%=otherfactoryname +otherproduct_name+othercatalogname %>的评论</span>
                <span class="time"><%=otheradd_date %> <span class="youk" style="padding-left: 15px;"><a href="javascript:void(0)" onclick="vote('<%=otherid %>')"><b style="color: #ef4c07;font-weight: normal">有用</b></a> (<span id="vote_<%=otherid %>"><%=pIs_help%></span>)</span></span> </div>
              <div class="w100 np_fix">
                <p class="textContent"><% if(!othergood.equals("")){ %>优点：<%=othergood %><br /><%}%><% if(!otherbad.equals("")){ %>缺点：<%=otherbad %><br /><%}%><%=othercontent.length()>30?othercontent.substring(0,29):othercontent %><a href="http://koubei.21-sun.com/detail/<%=otherid %>.htm" target="_blank" title="查看全文">查看全文>></a></p>
                <div class="r plt">网友平均评分 <font><%=otherscore %></font> 分</div>
              </div>
			      <%
              	String imgSql = "select top 10 image from pro_comments_image where comment_id='"+otherid+"' and is_show=1";
              	List<Map> imgsList = dbHelper.getMapList(imgSql);
              	if(imgsList!=null && imgsList.size()>0){
              %>
              <div class="diy_pic fix">
              <ul class="fix">
              <% 
              	for(Map m:imgsList){
              		String image = CommonString.getFormatPara(m.get("image"));
              %>
              <li><a href="javascript:void(0)"><img src="<%=image%>" width="40" height="40"><i></i></a></li>
              <%} %>
              </ul>
             <div class="pic_yuan"><a href="javascript:void(0)">收起</a><img src="" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="300" height="400" /></div>
              </div>
              <%} %>
              <div class="n_kb_add_pf">
              	<p class="pftitle">网友评分</p>
                <ul class="np_fix nkb_pflist np_fix">
                    <li><span class="nkb_pfwz">价格：</span><div id="pricescore_<%=otherid %>" title="regular"></div><span class="nkb_pffs"><%=otherscore1 %>分</span></li>
                    <li><span class="nkb_pfwz">性能：</span><div id="abilityscore_<%=otherid %>" title="regular"></div><span class="nkb_pffs"><%=otherscore2 %>分</span></li>
                    <li><span class="nkb_pfwz">质量：</span><div id="qualityscore_<%=otherid %>" title="regular"></div><span class="nkb_pffs"><%=otherscore3 %>分</span></li>
                    <li><span class="nkb_pfwz">售后：</span><div id="servicescore_<%=otherid %>"></div><span class="nkb_pffs"><%=otherscore4 %>分</span></li>
                </ul>
              </div>
              <script language="javascript" type="text/javascript">
	            var s1_<%=otherid %> = (parseInt(<%=otherscore1 %>,10)/20);
	  			var s2_<%=otherid %> = (parseInt(<%=otherscore2 %>,10)/20);
	  			var s3_<%=otherid %> = (parseInt(<%=otherscore3 %>,10)/20);
	  			var s4_<%=otherid %> = (parseInt(<%=otherscore4 %>,10)/20);

	            //获得评论分数
	          	jQuery("#pricescore_<%=otherid %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s1_<%=otherid %>
	          	});
	          	jQuery("#abilityscore_<%=otherid %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s2_<%=otherid %>
	          	});
	          	jQuery("#qualityscore_<%=otherid %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s3_<%=otherid %>
	          	});
	          	jQuery("#servicescore_<%=otherid %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s4_<%=otherid %>
	          	});
              </script>
			  
			  
              <div class="nkb_moregg"><a href="/0-<%=otherfactoryid %>-0.htm" target="_blank" title="<%=otherfactoryname %>"><%=otherfactoryname %></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/<%=othercatalognum%>-<%=otherfactoryid %>-0.htm" target="_blank" title="<%=otherfactoryname+othercatalogname %>"><%=otherfactoryname+othercatalogname %></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/comment-<%=othercatalognum%>-<%=otherfactoryid %>-0-0-0.htm" target="_blank" title="更多<%=otherfactoryname.replace("卡特彼勒","卡特")+othercataname %>口碑">更多<%=otherfactoryname.replace("卡特彼勒","卡特")+othercataname %>口碑</a></div>
            </div>
          </li>
          <%
      		}
      	}else{
      %>
      <li> 
        <div>暂无相关评论！</div>
      </li>
      <%
      	}
      %>
        </ul>
      </div>
 
    </div>
	
	
	
	
    <div class="wfull l mb10" id="myTab2_ContentA4" style="display:none">
      <div class="sentComment">
        <div class="pdTab">
          <ul>
            <li class="select">我要评论</li>
          </ul>
        </div>
        <div class="scc">
          <form name="comment_form" id="comment_form" method="post" action="/action/ajax.jsp">
            <div class="w300 l npkb_left">
              <div><b>您的称呼：</b>
                <input id="name" datatype="Require" msg="请输入您的称呼！" name="name" value="" class="npkb_nameinp" type="text" maxlength="11">
                <input type="checkbox" name="is_noname" id="checkbox" class="check" value="1" onclick="if(this.checked){(jQuery('#name').val(remote_ip_info['province']+remote_ip_info['city']+'的网友'))}else{jQuery('#name').val('')}">
                匿名评价</div>
              <div><b>优点：</b>
                <input id="good" datatype="Require" msg="请输入优点！" name="good" value="" type="text" maxlength="11" class="npkb_inp">
              </div>
              <div><b>缺点：</b>
                <input id="bad" datatype="Require" msg="请输入缺点！" name="bad" value="" type="text" maxlength="11" class="npkb_inp">
              </div>
              <div class="npkb_areaval"><b>建议：</b>
               <textarea class="npkb_area" id="content" name="content" dataType="Require" msg="请输入评价内容！ cols="45" rows="5"></textarea>
              </div>
              <div>
                <input type="checkbox" name="is_buy" id="is_buy" class="check" value="1">
                <b>我已购买该产品</b></div>
            </div>
            <div class="w370 r npkb_right">
              
               <div><b>产品评分：</b>在星星上滑动鼠标点击即可评分</div>
              <ul>
                <li><span>价格：</span>
                	<div id="price_1" style="float:left; margin-left:3px;"></div>
                </li>
                <li><span>质量：</span>
                	<div id="zhiliang_1" style="float:left;margin-left:3px;"></div>
                </li>
                <li><span>性能：</span>
                  <div id="xingneng_1" style="float:left;margin-left:3px;"></div>
                  </li>
                <li><span>售后：</span>
                	<div id="shouhou_1" style="float:left;margin-left:3px;"></div>
                </li>
              </ul>
              <div class="sent">
              <input id="button" name="button" value="&nbsp;" type="button" onclick="doComments();">
              <input type="hidden" name="flag" value="save_comment_new">
              <input type="hidden" name="product_id" value="<%=product_id %>">
              <input type="hidden" name="score1" id="score1">
              <input type="hidden" name="score2" id="score2">
              <input type="hidden" name="score3" id="score3">
              <input type="hidden" name="score4" id="score4">
            </div>
            </div>
            
          </form>
        </div>
      </div>
    </div>	
  </div>
  <!--right end--> 
</div>
  <!--副导航-->
  <style>
  .new_v_foot_list{ width:980px; margin:0 auto; text-align:left; margin-bottom:10px;}
.new_v_foot_list .adnf_list ul li{ float:left;  margin:0 6px 0;white-space:nowrap; padding: 6px 0;}
.new_v_foot_list .adnf_list ul li a{  display:inline-block;}
.new_v_foot_list .adnf_list ul li a:hover{ color:#ff6600}
.new_v_foot_list .adnf_title{ font-size:14px; font-weight:bold; border-bottom:1px solid #ccc; padding:7px 0; margin-bottom:5px; font-family:微软雅黑;}
.nleft_one .list003 { height:210px; overflow:auto;}
  </style>
    <div class="new_v_foot_list">
    <div class="adnf_title">其他品牌<%=catalogname %>口碑</div>
    <div class="adnf_list">
      <ul class="clearfix">
  <jsp:include page="/include/koubei/related_brand_news.jsp" flush="true">
     <jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
     <jsp:param name="catalogName" value="<%=catalogname%>"></jsp:param>
  </jsp:include>    
      </ul>
    </div>
  </div>
  <!--副导航-->
<!--end of foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>

<style type="text/css">
/*对联广告*/
/*左侧*/
#ads01 { position:fixed; left:0px; top:80px; z-index:999999; width:42px; height:350px;}
* html #ads01 {position:absolute; left:expression(eval(document.documentElement.scrollLeft)); top:expression(eval(document.documentElement.scrollTop)+100);}
/*右侧*/
#ads02 { position:fixed; right:0px; top:80px; z-index:99999; width:42px; height:350px;}
* html #ads02 {position:absolute; left:expression(eval(document.documentElement.scrollLeft+document.documentElement.clientWidth-this.offsetWidth)-(parseInt(this.currentStyle.marginLeft,0)||0)-(parseInt(this.currentStyle.marginRight,0)||0)); top:expression(eval(document.documentElement.scrollTop)+100);}
.hide { display:none;}
.ads_big { display:none;}
#ads01.ads_hover,#ads02.ads_hover { width:95px!important;}
.ads_hover .ads_small { display:none;}
.ads_hover .ads_big { display:block;}
/*对联广告结束*/
</style>
<!--对联广告-->
<div id="ads02" class="ads_hover">
<a href="http://product.21-sun.com/activity/koubei/index.jsp" target="blank" style="display:block;"><img src="http://product.21-sun.com/images/kb_dl20140702.jpg" width="95" height="330" class="ads_big" /></a>
<img src="http://news.21-sun.com/images/close_x.gif" width="39" height="13" alt="关闭" title="关闭" onclick="document.getElementById('ads02').className='hide';" style="cursor:pointer; margin-top:1px; float:right;" />
</div>
<!--对联广告结束-->
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/validator.alert.js"></script>
<script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" type="text/javascript"></script>
<script type="text/javascript">
//评论提交	
jQuery("#price_1,#xingneng_1,#zhiliang_1,#shouhou_1").raty({
	path: "/koubei/img", //图片路径  
	half : true ,
	score : 4
});
//获得评论分数
jQuery("#pricescore").raty({
	path: "/koubei/img", //图片路径  
	half : true ,
	readOnly : true,
	score : 0
});
jQuery("#abilityscore").raty({
	path: "/koubei/img", //图片路径  
	half : true ,
	readOnly : true,
	score : 0
});
jQuery("#qualityscore").raty({
	path: "/koubei/img", //图片路径  
	half : true ,
	readOnly : true,
	score : 0
});
jQuery("#servicescore").raty({
	path: "/koubei/img", //图片路径  
	half : true ,
	readOnly : true,
	score : 0
});
function doComments(){
	var rs = Validator.Validate(document.getElementById("comment_form"),1);
	if(rs){
	   var  content = jQuery.trim(jQuery("#content").val()) ;
	   if(content!=content.replace(/<\/?[^>]*>/g,'').replace('&lt','').replace('&gt','') || (content.indexOf("www.")!=-1 || content.indexOf("http:")!=-1)){
	       alert('您的评论内容不符合规则，请重新输入!') ;	
	       jQuery("#content").val("") ;
	       jQuery("#content").focus() ;
	        return false ;
	   }
		jQuery("#score1").val(parseFloat(jQuery("#price_1").raty("score"),10)*20);
		jQuery("#score2").val(parseFloat(jQuery("#xingneng_1").raty("score"),10)*20);
		jQuery("#score3").val(parseFloat(jQuery("#zhiliang_1").raty("score"),10)*20);
		jQuery("#score4").val(parseFloat(jQuery("#shouhou_1").raty("score"),10)*20);
		jQuery("#comment_form").ajaxSubmit({
			type : "POST",
			async : false ,
			success : function(data){
		     if(jQuery.trim(data)=='no'){
			   alert("您输入的评价中含有敏感词，请重新输入") ;
			    jQuery("#content").val("") ;
	            jQuery("#content").focus() ; 
			   return ;
			}
				alert("评论提交成功！");
				//getComment();
				jQuery("#comment_form").clearForm();
				jQuery("#price_1,#xingneng_1,#zhiliang_1,#shouhou_1").raty({
					path: "/koubei/img", //图片路径  
					half : true ,
					score : 4
				});
			}					  
		});
	}
}

function vote(id){
		var help = parseInt($("#vote_"+id).html());
		if(setlooked(id)==1){
			$.ajax({
			  url: "/action/ajax.jsp?flag=koubeiHelp&id="+id,
			  cache: false,
			  async: true,
			  success: function(html){
			  }
			});
			$("#vote_"+id).html(help+1);
			$.jBox.tip('感谢您的支持！');
		}else{
			$.jBox.tip('您已经投过票了哟！');
		}
	}
	function setlooked(id){
		var x = 0;
		var imgs = jQuery.cookies.get("help_imgs");
		if(imgs==null || imgs == "" || imgs.indexOf("help"+id) < 0){
			var newImgs = imgs+",help"+id;
			jQuery.cookies.set("help_imgs",newImgs,{hoursToLive : 10});
			x = 1;
		}
		return x;
	}
</script> 
<!--end of foot-->
<div style="display:none"><script src="http://s6.cnzz.com/stat.php?id=5755842&web_id=5755842" language="JavaScript"></script></div>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
</body>
</html>