<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="java.net.URLEncoder"%>
<cache:cache cron="* * */5 * *">
<%
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
	}
	String cookieusername= CommonString.getFormatPara(Common.getCookies(request,"cookieMemNo"));
	if(username.equals("")&&!cookieusername.equals("")){
		username=cookieusername;
	}
	String product_id = CommonString.getFormatPara(request.getParameter("id"));
	String offset = CommonString.getFormatPara(request.getParameter("offset")) ;
	String orderby = CommonString.getFormatPara(request.getParameter("orderby"));
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;	
	Map CatalogFromBrandMap = (HashMap)application.getAttribute("CatalogFromBrandMap") ;
	Map BrandCatalogMap = (HashMap)application.getAttribute("BrandCatalogMap") ;
	if(CatalogFromBrandMap==null){
		CatalogFromBrandMap=new HashMap();
	}
	if(BrandCatalogMap==null){
		BrandCatalogMap=new HashMap();
	}
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList");	
	DBHelper dbHelper = DBHelper.getInstance() ;
	String id = "";
	String catalog = "";
	String factoryid = "";
	String factoryname = "";
	String name = "";
	String file_name = "";
	String catalognum = "";
	String img2 = "";
	String catalogname = "";
	String good = "";
	String bad = "";
	String add_date = "";
	String contact_address = "";
	String content = "";
	String view_count= "";
	String cataname="";
	int factoryInt = 0;
	int score = 0;
	int score1 = 0;
	int score2 = 0;
	int score3 = 0;
	int score4 = 0;
	Map productMap = dbHelper.getMap("select catalognum,factoryname,name,factoryid,file_name,catalognum,img2,catalogname,view_count,add_date from pro_products where id=" + product_id + " order by id desc");
	if(productMap!=null){
		catalog = CommonString.getFormatPara(productMap.get("catalognum"));
		factoryname = CommonString.getFormatPara(productMap.get("factoryname"));
		name = CommonString.getFormatPara(productMap.get("name"));
		factoryid = CommonString.getFormatPara(productMap.get("factoryid"));
		factoryInt = CommonString.getFormatInt(productMap.get("factoryid"));
		file_name = CommonString.getFormatPara(productMap.get("file_name"));
		catalognum = CommonString.getFormatPara(productMap.get("catalognum"));
		img2 = CommonString.getFormatPara(productMap.get("img2"));
		catalogname = CommonString.getFormatPara(productMap.get("catalogname"));
		view_count = CommonString.getFormatPara(productMap.get("view_count"));
		add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm", CommonString.getFormatPara(productMap.get("add_date")));
		
		if(catalog.length()>6){cataname=CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))); }
		else{cataname=CommonString.getFormatPara(catalogMap.get(catalog));}
		 
	}else if(productMap==null){
	        Common.do302(response,"http://koubei.21-sun.com/");
			return;
	}
	String allCatalog=CommonString.getFormatPara(CatalogFromBrandMap.get(factoryid));
	String allcatalogsList[]=allCatalog.split(",");		
	String brandRank=CommonString.getFormatPara(BrandCatalogMap.get(catalog));
    String brandRankList[]=brandRank.split(",");			
	Integer nowPage = 1 ;
    int pageSize=20;
	List<String> filterQuery = new ArrayList<String>(0);
	List<SolrQuery.SortClause> orderList = new ArrayList<SolrQuery.SortClause>();
	orderList.add(SolrQuery.SortClause.desc("id"));
	SolrQuery query = new SolrQuery();
    query.setQuery("*:*");
	filterQuery.add("product_id:"+product_id);
    String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product_koubei";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
   	String [] filterArr = new String [filterQuery.size()];
	filterArr = filterQuery.toArray(filterArr);
	query.addFilterQuery(filterArr);	
	query.setRequestHandler("/jereh");
	query.setSorts(orderList);
	query.setRows(pageSize);
	query.setStart((nowPage - 1) * pageSize);
    int totalParts = 0;
	QueryResponse res = server.query(query);
	totalParts = (int)res.getResults().getNumFound();
	int pageCount = totalParts / pageSize + (totalParts % pageSize > 0 ? 1 : 0);
	SolrDocumentList searchProducts = res.getResults();		
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【点评】<%=factoryname+name+catalogname %>怎么样_<%=factoryname+name+catalogname %>真实口碑 - 铁臂口碑</title>
<meta name="keywords" content="<%=factoryname+name+catalogname %>,<%=factoryname+name+catalogname %>怎么样,<%=factoryname+name+catalogname %>好不好,<%=factoryname+name+catalogname %>真实口碑" />
<meta name="description" content="铁臂口碑包含大量<%=factoryname+name+catalogname %>真实口碑、点评信息，让您清楚地了解<%=factoryname+name+catalogname %>怎么样，有哪些优缺点，买<%=factoryname+name+catalogname %>就上铁臂商城。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/koubei/style/koubei.css" rel="stylesheet" type="text/css" />
<link href="/new_resources/css/style.css" rel="stylesheet" />
<link href="/new_resources/css/style_common.css" rel="stylesheet" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/validator.alert.js"></script>
<script type="text/javascript" src="/scripts/login.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<!-- jbox -->
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<link href="/style/friendly_link.css" rel="stylesheet" type="text/css" />
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
<jsp:include page="/include/top.jsp" flush="true" />
<!--top end-->
<!--面包屑-->
<div class="contain1190 mb10" style="  margin-top: 10px;">
  <h3 class="breadCrumbs">我的位置：<a href="http://product.21-sun.com/">铁臂商城</a> >><a href="/" title="铁臂口碑">铁臂口碑</a> &gt;&gt;&nbsp;<a href="/0-<%=factoryid %>-0.htm"><%=CommonString.getFormatPara(brandMap.get(factoryid))%></a> &gt;&gt;&nbsp;<a href="/<%=catalog.substring(0,6) %>-0-0.htm"><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))) %></a> &gt;&gt;&nbsp;<a href="/<%=catalog.substring(0,6) %>-<%=factoryid %>-0.htm"><%=CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")%><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6))) %></a> &gt;&gt;&nbsp;<%=factoryname+name+catalogname %>口碑</h3>
</div>
<!--面包屑结束-->
<div class="contain1190 mb10 np_fix">
<!--left-->
<div class="w210 l n_pp_left np_left nkb_detleft">
 
  <div class="mb10 nkb_zyyw border02 l w208">
    <div class="nkb_zyyw_title">
      <h2 class="l"><%=factoryname %>主营业务</h2>
      <span class="r"><a href="/0-<%=factoryid %>-0.htm" target="_blank" title="更多<%=factoryname %>主营业务">更多&gt;&gt;</a></span> </div>
    <ul class="nkb_zyyw_list np_fix">
      <%   
       		if(allcatalogsList.length>0){
			    String cata="";
       			   for(int i=0;i<allcatalogsList.length;i++){
       				if(allcatalogsList[i].length()==6){
       	%>
      <li><a target="_blank"  href="/<%=allcatalogsList[i] %>-<%=factoryid %>-0.htm" title="<%=factoryname.replace("卡特彼勒","卡特") %><%=CommonString.getFormatPara(catalogMap.get(allcatalogsList[i])) %>"><%=CommonString.getFormatPara(catalogMap.get(allcatalogsList[i])) %></a></li>
      <%}else if(allcatalogsList[i].length()>6){
			if(cata.indexOf(allcatalogsList[i].substring(0,6))<0){
			  cata+=allcatalogsList[i].substring(0,6)+",";
		 %>
      <li><a target="_blank"  href="/<%=allcatalogsList[i].substring(0,6) %>-<%=factoryid %>-0.htm" title="<%=factoryname.replace("卡特彼勒","卡特") %><%=CommonString.getFormatPara(catalogMap.get(allcatalogsList[i].substring(0,6))) %>"><%=CommonString.getFormatPara(catalogMap.get(allcatalogsList[i].substring(0,6))) %></a></li>
      <%}}}}%>
    </ul>
  </div>
  <div class="w208 border02 l leftPart02 mb10 pp_hotph">
    <h2><%=catalogname %>口碑排行 </h2>
    <ul class="list003" id="brandSubLeftId">
      <%
	        if(brandRankList.length>0){
	        for(int i=0;i<brandRankList.length&&i<=14;i++){
			
	   %>
      <li <% if(i<=2){ %>class="top3"<%} %><% if(i==14){ %>style="border-bottom:none;"<%} %>> <em><%=i+1 %></em>
        <h4><a target="_blank" href="/<%=catalog %>-<%=brandRankList[i] %>-0.htm" title="<%=CommonString.getFormatPara(brandMap.get(brandRankList[i])).replace("卡特彼勒","卡特")%><%=cataname %>口碑"><%=CommonString.getFormatPara(brandMap.get(brandRankList[i])).replace("卡特彼勒","卡特")%><%=cataname %>口碑</a></h4>
      </li>
      <%}}%>
    </ul>
  </div>
 
</div>
<!--left end-->
<!--right-->
<div class="w960 r np_right">
  <div class="pdTop1">
    <h1><%=factoryname+name+catalogname %>口碑</h1>
    <span class="r">本产品共有<font id="viewCountId"> <%=view_count %></font>人关注<span id="orderCountId"></span></span> </div>
  <div class="pdTop2 mb10" style="width:960px">
    <div class="pdtImg"><img title="<%=factoryname+name+catalogname %>" alt="<%=factoryname+name+catalogname %>" src="/uploadfiles/<%=img2 %>" width="310" height="240" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"></div>
    <div class="score" style="width: 565px;">
      <div class="total" style="position:relative;">网友平均评分 <font id="totalScoreId"></font> 分 <span style="display: inline-block;position: absolute;top: 12px;left: 190px;">
        <div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
        </span> </div>
      <ul class="scoreList">
        <li><span>价格：</span>
          <div id="pricescore" title="regular"></div>
        </li>
        <li><span>质量：</span>
          <div id="qualityscore" title="regular"></div>
        </li>
        <li><span>性能：</span>
          <div id="abilityscore" title="regular"></div>
        </li>
        <li><span>售后：</span>
          <div id="servicescore"></div>
        </li>
      </ul>
      <div class="pdbtn" style="font-size: 22px;margin-left: -0px;"><a href="javascript:;" onclick="showinquery('<%=product_id%>','')"><img src="/koubei/images/temp/1_03.png" alt="免费询价" width="113" height="27"></a> <a href="#00a" "><img src="/koubei/images/temp/1_05.png" alt="发表评论" width="120" height="27"></a>
        <p>因不同地区代理商及价格差异，请您点击<b><a style="height:32px;" href="javascript:;"  onclick="showinquery('<%=product_id%>','')" >咨询最低价</a></b>。</p>
      </div>
      <div class="l" style="white-space:nowrap; text-overflow:ellipsis; overflow:hidden;">品牌：<a title="<%=factoryname %>" href="/0-<%=factoryid %>-0.htm" target="_blank"><%=factoryname %></a> 　类别：<a title="<%=factoryname.replace("卡特彼勒","卡特")+catalogname %>" href="/<%=catalognum.length()>=6?catalognum.substring(0,6):catalognum %>-<%=factoryid %>-0.htm"><%=factoryname.replace("卡特彼勒","卡特")+catalogname %></a></div>
      <div class="kf_tel">客服：<font>4006-521-526</font></div>
    </div>
  </div>
  <!--询价单-->
  <div style="clear:both; border: 0px solid #D3D3D3; margin-bottom: 10px !important;border-top:#ff9000 0px solid;" class="prodetailOrder" id="00b">
    <jsp:include page="/include/products/product_detail_order.jsp" flush="true">
    <jsp:param name="factoryid" value="<%=factoryid%>"></jsp:param>
    <jsp:param name="productid" value="<%=product_id%>"></jsp:param>
    </jsp:include>
  </div>
  <!--询价单结束-->
  <!--列表开始-->
  <div class="l border03 n_koubei_list border03">
    <div class="np_fix nkb_sort">
      <div class="l nkb_left">
        <ul class="np_fix">
          <li>全部口碑</li>
          <!-- <li><a href="/0-0-pubdate-0-0.htm">最新发表</a></li>-->
          <li style="display:none"><a href="/0_0_help_0_0.htm">有帮助</a></li>
        </ul>
      </div>
      <div class="r nkb_right" style="display:none">共有11条</div>
    </div>
    <div class="np_fix n nkb_sxtj">
      <div class="r sxtj_right">
        <!-- <a href="#"><img src="../images/new_pro/fbkb_btn.gif" width="69" height="21"/></a> -->
      </div>
    </div>
    <div class="plList nkb_pro_list np_fix kalist" style="height:580px;;overflow:hidden;width:950px;" id="morebrand">
      <ul  style="width:950px">
        <%
		   if(totalParts>0){
			   for(SolrDocument oneMap:searchProducts){
				   String pId = CommonString.getFormatPara(oneMap.getFieldValue("id"));
				   String pAdd_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm", CommonString.getFormatPara(oneMap.getFieldValue("pub_date")));
				   String pContent = CommonString.getFormatPara(oneMap.getFieldValue("content"));
				   int pIs_help = CommonString.getFormatInt(oneMap.getFieldValue("is_help"));
				   String pUsername = CommonString.getFormatPara(oneMap.getFieldValue("username"));
				   int pScore1 = Integer.parseInt(CommonString.getFormatPara(oneMap.getFieldValue("score1")));
				   int pScore2 = Integer.parseInt(CommonString.getFormatPara(oneMap.getFieldValue("score2")));
				   int pScore3 = Integer.parseInt(CommonString.getFormatPara(oneMap.getFieldValue("score3")));
				   int pScore4 = Integer.parseInt(CommonString.getFormatPara(oneMap.getFieldValue("score4")));
				   int pScore = (pScore1+pScore2+pScore3 +pScore4)/4;
				   String list_touxiang="http://product.21-sun.com/catalog/images/s_face.png";
	               //list_touxiang=CommonString.getFormatPara(oneMap.getFieldValue("touxiang"));
		%>
        <li>
          <div class="content_new"> <img style="width:41px;height:41px;"  src="<%=list_touxiang%>" onerror="showImgDelay(this,'http://product.21-sun.com/catalog/images/s_face.png',2);" >
            <div class="np_fix ktitle" style="width:900px;">
              <h3><%=pUsername.equals("")?"游客":pUsername %></h3>
              <span class="youk"><a href="javascript:void(0)" onclick="vote('<%=pId %>')"><b>有用</b></a> (<span id="vote_<%=pId %>"><%=pIs_help %></span>)</span> <span class="time"><%=pAdd_date %></span> </div>
            <div class="w100 np_fix">
              <p class="textContent" style="width:720px;"><%=pContent.length() > 50?pContent.substring(0,49)+"...":pContent %><a style="color:#ef4c07" href="http://koubei.21-sun.com/detail/<%=pId %>.htm" target="_blank" title="查看全文">查看全文>></a></p>
            </div>
            <div class="n_kb_add_pf">
              <ul class="np_fix nkb_pflist np_fix">
                <li><span class="nkb_pfwz">价格：</span>
                  <div id="pricescore_<%=pId %>" title="regular"></div>
                  <span class="nkb_pffs"><%=pScore1 %>分</span></li>
                <li><span class="nkb_pfwz">性能：</span>
                  <div id="abilityscore_<%=pId %>" title="regular"></div>
                  <span class="nkb_pffs"><%=pScore2 %>分</span></li>
                <li><span class="nkb_pfwz">质量：</span>
                  <div id="qualityscore_<%=pId %>" title="regular"></div>
                  <span class="nkb_pffs"><%=pScore3 %>分</span></li>
                <li><span class="nkb_pfwz">售后：</span>
                  <div id="servicescore_<%=pId %>"></div>
                  <span class="nkb_pffs"><%=pScore4 %>分</span></li>
              </ul>
            </div>
            <script language="javascript" type="text/javascript">
	            var s1_<%=pId %> = (parseInt(<%=pScore1 %>,10)/20);
	  			var s2_<%=pId %> = (parseInt(<%=pScore2 %>,10)/20);
	  			var s3_<%=pId %> = (parseInt(<%=pScore3 %>,10)/20);
	  			var s4_<%=pId %> = (parseInt(<%=pScore4 %>,10)/20);

	            //获得评论分数
	          	jQuery("#pricescore_<%=pId %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s1_<%=pId %>
	          	});
	          	jQuery("#abilityscore_<%=pId %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s2_<%=pId %>
	          	});
	          	jQuery("#qualityscore_<%=pId %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s3_<%=pId %>
	          	});
	          	jQuery("#servicescore_<%=pId %>").raty({
	          		path: "/koubei/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s4_<%=pId %>
	          	});
              </script>

          </div>
        </li>
        <%
			   }
		   }else{
		%>
        <li> 该产品暂无口碑 </li>
        <% } %>
      </ul>
    </div>
   <div align="center"> <a style="cursor:pointer;"  id="showmore" onclick="showmore();">加载更多</a></div>
    <!--列表结束-->
    <!--评论开始-->
    <div class="wfull l mb10" id="myTab2_ContentA4">
      <form name="comment_form" id="comment_form" method="post" action="/action/ajax.jsp">
        <div class="sentComment" name="sentComment" id="sentComment">
          <div class="pdTab" id="00a">
            <ul style="width:445px;">
              <li class="select">我要评论</li>
            </ul>
            <div class="rbtip"> 了解更多获奖明细及活动公告请加 <b>QQ群： 215179483</b> </div>
          </div>
          <div class="scc" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td height="48" colspan="2" align="left" class="td_bot"><b>产品评分：</b>在星星上滑动鼠标点击即可评分<span>( 您对爱机的评价可以帮助更多人选机*为必填项 )</span></td>
              </tr>
              <tr>
                <td width="19%" align="right" valign="top"><b>*</b>价格：</td>
                <td width="81%" valign="top"><div class="xing" id="price_1" style="float:left; margin-left:3px;"></div>
                  <span class="xing_tip">点击星星为该机型价格打分</span></td>
              </tr>
              <tr>
                <td align="right" valign="top"><b>*</b>质量：</td>
                <td><div class="xing" id="zhiliang_1" style="float:left;margin-left:3px;"></div>
                  <span class="xing_tip">点击星星为该机型质量打分</span></td>
              </tr>
              <tr>
                <td align="right" valign="top"><b>*</b>性能：</td>
                <td><div class="xing" id="xingneng_1" style="float:left;margin-left:3px;"></div>
                  <span class="xing_tip">点击星星为该机型性能打分</span></td>
              </tr>
              <tr>
                <td align="right" valign="top"><b>*</b>售后：</td>
                <td><div class="xing" id="shouhou_1" style="float:left;margin-left:3px;"></div>
                  <span class="xing_tip">点击星星为该机型售后打分</span></td>
              </tr>
              <tr>
                <td align="right" valign="top"><b>*</b>评价：</td>
                <td><textarea id="content" name="content" dataType="Require" msg="请输入评价内容！" placeholder="沉默不是金，来一吐为快吧！"></textarea></td>
              </tr>
              <tr>
                <td colspan="2" style="padding-left:65px; padding-top:10px;"><ul class="showpic clearfix" id="addImgs_show">
                  </ul></td>
              </tr>
              <tr>
                <td height="56">&nbsp;</td>
                <td><span class="tip">10~2000个字</span></a></td>
              </tr>
              <tr>
                <td align="right">上传图片：</td>
                <td><%	if(username.equals("")){ %>
                  <img src="http://product.21-sun.com/activity/koubei/images/1_22.jpg" onclick="login();" width="77" height="30" />
                  <%}else{%>
                  <span id="addImgs"></span>
                  <%}%></td>
              </tr>
              <tr>
                <td height="39" class="td_bot">&nbsp;</td>
                <td class="td_bot">单张图片不超过10MB，尺寸不小于300*300px,支持jpg、png和bmp。</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td align="left"><p>
                    <input id="button" name="button" value="&nbsp;" type="button" onclick="doComments();" class="ti_btn" style="border:0" />
                  </p></td>
              </tr>
            </table>
          </div>
        </div>
        <input type="hidden" name="flag" value="new_save_comment" />
        <input type="hidden" name="product_id" value="<%=product_id %>" />
        <input type="hidden" name="score1" id="score1" />
        <input type="hidden" name="score2" id="score2" />
        <input type="hidden" name="score3" id="score3" />
        <input type="hidden" name="score4" id="score4" />
        <input type="hidden" name="jr_username" id="jr_username"  value="<%=username%>"/>
      </form>
    </div>
    <!--评论结束-->
  </div>
  <!--right end-->
  <div align="center">铁臂口碑要求发布的评论确系本人原创，严禁剽窃、转投他人评论，若因此引起任何法律纠纷，与铁臂口碑无关。</div>
</div>

</div>
<!--foot-->

<jsp:include page="/include/foot.jsp" flush="false"/>

<!--foot end-->
<style type="text/css">
/*对联广告*/
/*左侧*/
#ads01 { position:fixed; left:0px; top:80px; z-index:999999; width:42px; height:350px;}
* html #ads01 {position:absolute; left:expression(eval(document.documentElement.scrollLeft)); top:expression(eval(document.documentElement.scrollTop)+100);}
/*右侧*/
.hide { display:none;}
.ads_big { display:none;}
#ads01.ads_hover,#ads02.ads_hover { width:95px!important;}
.ads_hover .ads_small { display:none;}
.ads_hover .ads_big { display:block;}
/*对联广告结束*/
</style>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="/scripts/validator.alert.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script>
function showmore(){
var m = $("#morebrand");  
m.css("height","auto"); 
//var mm = $("#morebrandhelp");  
//mm.css("height","auto"); 
 $("#showmore").hide(); 
}

</script>
<script language="javascript" type="text/javascript">
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
function getAllComment(){
		jQuery.getJSON("/action/ajax.jsp?flag=get_all_comment&callback=?&pid=<%=product_id %>",function(data){
			var s1 = (parseInt(data.score1,10)/20);
			var s2 = (parseInt(data.score2,10)/20);
			var s3 = (parseInt(data.score3,10)/20);
			var s4 = (parseInt(data.score4,10)/20);
			var sall = ((s1*5)+(s2*5)+(s3*5)+(s4*5));
			jQuery("#totalScoreId").html(sall);
			jQuery("#pricescore").raty({
				path: "/koubei/img", //图片路径  
				half : true ,
			    readOnly : true,
				score : s1
			});
			jQuery("#abilityscore").raty({
				path: "/koubei/img", //图片路径  
				half : true ,
				readOnly : true,
				score : s2
			});
			jQuery("#qualityscore").raty({
				path: "/koubei/img", //图片路径  
				half : true ,
				readOnly : true,
				score : s3
			});
			jQuery("#servicescore").raty({
				path: "/koubei/img", //图片路径  
				half : true ,
				readOnly : true,
				score : s4
			});
		});
	}
	getAllComment();
	
	//评论提交	
	jQuery("#price_1,#xingneng_1,#zhiliang_1,#shouhou_1").raty({		
		path: "/koubei/img", //图片路径  
		half : true ,
		score : 0
	});

	jQuery(function(){
		jQuery("#addImgs").JrUpload({
			remotUrl : "http://resource.21-sun.com/upload.jsp",
			folder : "product/koubei" ,
			sizeLimit:10*1024*1024, //10M
			multi : true,
			beforeCallback : "beforeCallback",
			callback : "setImgs" ,
			style : "width:98px;height:30px;",
			buttonImg : "<%=Common.getDomain(request) %>/activity/koubei/images/1_22.jpg" ,
			buttonImgWidth : 77 ,
			buttonImgHeight : 30
		});
	});
	function beforeCallback(){
		$.jBox.tip("图片上传中，请稍后。。。", "loading");
	}
	function setImgs(data){
		var imgs = data.split(",");
		var htm = '';
		var f = 'http://resource.21-sun.com';
		for(var i=0;i<imgs.length;i++){
			htm += '<li><img class="img" src="'+f+imgs[i]+'" width="90" height="60" /><input type="hidden" name="img" value="'+f+imgs[i]+'" /><a href="javascript:void(0);" onclick="removeThis(this);" attrId="0" class="img_delete" style="position:absolute;top:-7px;left:80px;"><img src="http://member.21-sun.com/home/used/images/delete.png" /></a></li>';
		}
		jQuery("#addImgs_show").append(htm);
		regEvent();
		$.jBox.closeTip();
	}
	function regEvent(){
		jQuery("#addImgs_show>li").mouseover(function(){
			jQuery(".img_delete").hide();
			jQuery(this).find(".img_delete").show();
		});
		jQuery("#addImgs_show>li").mouseout(function(){
			jQuery(".img_delete").hide();
		});
	}
	function removeThis(o){
		var attrId = jQuery(o).attr("attrId")+"";
		if(attrId=='0'){
			jQuery(o).parent().remove();
		}else{
			if(confirm("确定删除该张图片吗？")){
				jQuery(o).parent().remove();
			}
		}
	}
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
					if($.trim(data)=="login"){
						login();
					}else{
						alert("评论提交成功！");
						window.location.reload();
					}
					
				}					  
			});
		}
	}
	function checkLogin(){
		jQuery.ajax({
			url:'/action/ajax.jsp?flag=isLogin&r='+new Date(),
			async:true,
			cache:false,
			success:function(data){
				if($.trim(data)=="ok"){
					return "ok"; 
				}
			}
		});
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
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
</body>
</html>
</cache:cache>