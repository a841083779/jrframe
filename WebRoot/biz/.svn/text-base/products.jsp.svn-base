<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String usern = CommonString.getFormatPara(request.getParameter("usern"));
		if(usern.equals("hfxy")){
%>
    <script>
	window.location.href="http://product.21-sun.com/agentstore/hfxy/";
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
			whereStr += " and catalogname = '"+catalogname+"' ";
		}
		if(!"".equals(factory)){
			whereStr += " and factoryid = "+factory+" ";
		}
		PageBean pageBean = new PageBean() ; // 分页程序
		pageBean.setPageSize(15) ; // 每页显示条数
		pageBean.setCondition(whereStr.toString()) ;
		
		Integer nowPage = 1 ;
		if(!"".equals(offset) && !"0".equals(offset)){
		   nowPage = Integer.parseInt(offset)/pageBean.getPageSize()+1 ;
		}
		pageBean.setNowPage(nowPage) ;   
		pageBean.setOrderBy(" id desc ") ;  // 默认排序
		String url = CommonString.getFormatPara(request.getQueryString()) ;
		url = url.replace("/"+usern+"/agent_products.htm","/agent_products.jsp?usern="+usern);
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
	 String factoryid="";
	String agent_fac_id_list=CommonString.getFormatPara(map.get("agent_fac"));
    String fac_ids_list[]=agent_fac_id_list.split(",");
	    for(int i=0;i<fac_ids_list.length;i++){
		    if(!fac_ids_list[i].equals("")){
			factoryid=fac_ids_list[0];
			//Map facInfo = dbHelper.getMap(" select name,usern from pro_agent_factory where id = "+fac_ids_list[i],connection);
			  // dali_brand+=CommonString.getFormatPara(facInfo.get("name"));
			      // List<Map> proInfo = dbHelper.getMapList("select catalognum,catalogname from pro_agent_product_vi where agentid = '"+CommonString.getFormatPara(map.get("id"))+"' and factoryid = '"+fac_ids_list[i]+"'  group by catalognum,catalogname order by catalognum",connection);
                            // for(Map oneMap : proInfo){
							//  dali_pro+=CommonString.getFormatPara(facInfo.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"));
							 //}
		    }
		}
%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>产品展示_代理产品– <%=CommonString.getFormatPara(map.get("full_name"))%></title>
<meta name="keywords" content="<%=CommonString.getFormatPara(map.get("full_name"))%>产品展示,<%=CommonString.getFormatPara(map.get("full_name"))%>代理产品" />
<meta name="description" content="<%=CommonString.getFormatPara(map.get("full_name"))%>最新产品、主营产品分类，低廉的价格、优质的服务，欢迎广大客户前来采购询价。" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" />
<link href="http://product.21-sun.com/biz/style/style.css" rel="stylesheet" />
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery.min.js"></script>
<script type="text/javascript">
//导航选中状态
var jrChannel='0#0'
//店铺导航选中状态
//var jrChannel_shop='0#0'
</script>
</head>
<body>
<!--top-->


<!--top end-->
<div class="shop_con">
  <div class="shop_top01">
    <div class="contain980 fix">
      <h1 class="logo"><%=CommonString.getFormatPara(map.get("full_name"))%>
        <strong class="site"><a title="http://<%=usern%>.biz.21-sun.com" href="http://<%=usern%>.biz.21-sun.com" target="_blank">http://<%=usern%>.biz.21-sun.com</a></strong>
      </h1>
      <div class="mark"><img src="http://product.21-sun.com/biz/images/mark.png" width="109" height="34" onclick="addShop();return false;"></div>
      <script type="text/javascript">
      function addShop(){
          try{
             window.external.addFavorite('http://<%=usern%>.biz.21-sun.com', '<%=CommonString.getFormatPara(map.get("full_name"))%>');
         }catch (e){
             try{
                 window.sidebar.addPanel('<%=CommonString.getFormatPara(map.get("full_name"))%>','http://<%=usern%>.biz.21-sun.com',"");
             }catch (e){
                 alert("加入收藏失败，请使用Ctrl+D进行添加");
             }
         }
      }
      </script>
    </div>
  </div>
  <div class="shop_top02">
    <div class="contain980 fix">
      <ul class="shopNav fix">
        <li><a href="http://<%=usern%>.biz.21-sun.com">商铺首页</a></li>
        <li><a href="http://<%=usern%>.biz.21-sun.com/introduct.htm">公司介绍</a></li>
        <li class="cur"><a href="http://<%=usern%>.biz.21-sun.com/products.htm">产品展示</a></li>
        <li><a href="http://<%=usern%>.biz.21-sun.com/message.htm">留言反馈</a></li>
        <li><a href="http://<%=usern%>.biz.21-sun.com#contactus">联系我们</a></li>
      </ul>
    </div>
  </div>
  <div class="shopBanner">
    <img src="http://product.21-sun.com/biz/images/temp/shop_banner.jpg" width="978" height="188">
  </div>
<div class="contain980 mb10 clearfix">
  <h3 class="breadCrumbs l"><a href="/">企业首页</a> &gt;&gt; 产品展示 &gt;&gt; 产品</h3>
</div>
  <div class="contain980 fix">
    <div class="comBox04 mb10">
      <div class="hd fix">
        <h3>产品展示<i></i></h3>
        <span class="more"><a href="http://<%=usern%>.biz.21-sun.com/products.htm" title="更多产品展示">更多&gt;&gt;</a></span>
      </div>
      <div class="bd shopProList">
        <ul class="comList02">
      		<%
				List<Map> list = pageBean.getDatas(connection);
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
      <li><a href="http://product.21-sun.com/proDetail/<%=CommonString.getFormatPara(list.get(i).get("file_name"))%>" title="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>">
	 <img width="150" height="115" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(list.get(i).get("img2"))%>" alt="<%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%>" ><strong><%=CommonString.getFormatPara(list.get(i).get("factoryname"))%><%=CommonString.getFormatPara(list.get(i).get("name"))%><%=CommonString.getFormatPara(list.get(i).get("catalogname"))%></strong></a></li>
       <%}
		}else{
	  %> 
      	<span class="textStyle">暂无信息</span>
      <%}%>
        </ul>
      </div>
    </div>
    

    
    <jsp:include page="friend_link.jsp" flush="true" />

  </div>
</div>
<!--foot-->
<div class="foot_box">



<div style="width:980px; height:170px; margin:0 auto; clear:both; position:relative;" class="proFoot">
<div style="position:absolute; right:-18px; top:36px; width:160px; text-align:center;" class="fewm"><img src="/images/ewm_new.gif" width="90" height="90" /><br />关注铁臂商城<br />抢先查询新品信息</div>
  <link rel="stylesheet" href="http://www.21-sun.com/00css/new_21sun_include.css" type="text/css" />
  <div class="New_website">
    <div class="New_linksContain">
      <strong><span class="New_links" onclick="window.open('http://www.21-sun.com');">中国工程机械商贸网</span>旗下网站：</strong>
      <span class="New_links" onclick="window.open('http://part.21-sun.com/');">中国工程机械配件网</span>
      <span class="New_links" onclick="window.open('http://www.21-cmjob.com/');">中国工程机械人才网</span>
      <span class="New_links" onclick="window.open('http://www.21-rent.com/');">中国工程机械租赁网</span>
      <span class="New_links" onclick="window.open('http://www.21-used.com/');">中国工程机械二手网</span>
      <span class="New_links" onclick="window.open('http://www.21part.com/');">配件商城</span>
      <span class="New_links" onclick="window.open('http://www.21peitao.com/');">配套网</span>
      <span class="New_links" onclick="window.open('http://www.cmbol.com/');">工程机械外贸网</span>
      <span class="New_links" onclick="window.open('http://product.21-sun.com/');">铁臂商城</span>
    </div>
  </div>
  <div class="New_foot">
    <span class="New_links" onclick="window.open('http://www.21-sun.com/service/guanggao/index.htm');">广告服务</span><em>|</em>
    <span class="New_links" onclick="window.open('http://www.jerei.com/contact/');">联系方式</span><em>|</em>
    <span class="New_links" onclick="window.open('http://www.jerei.com/');">关于我们</span><em>|</em>
    <span class="New_links" onclick="window.open('http://www.jerei.com/news/');">本网动态</span><em>|</em>
    <span class="New_links" onclick="window.open('http://www.jerei.com/contact/legal.jsp');">法律声明</span><em>|</em>
    <span class="New_links" onclick="window.open('http://aboutus.21-sun.com/map.htm');">网站导航</span><em>|</em>
    <span class="New_links" onclick="window.open('http://www.21-sun.com/contact/');">联系客服</span><br/>
    产品询价专线：4006-521-526<br/>
    <span class="New_links" onclick="window.open('http://www.21-sun.com');">中国工程机械商贸网</span>
    Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script>
  </div>
  <!-- Baidu Button BEGIN -->
    <div style="width:300px; margin:0px auto;" >
    <div class="bdsharebuttonbox" style="padding-left:50px;">
    <a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>
    </div>
    <!-- Baidu Button END -->
</div>

<div class="n_tools">
  <ul>
    <li class="nt02"><a href="#"><i></i><span class="te">客服：4006-521-526</span></a></li>
    <li class="nt03"><a href="http://product.21-sun.com/inquiry/"><i></i><span class="te">在线询价</span></a></li>
    <li class="nt04 bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"><span class="te">点击分享</span></a></li>
    <li class="nt05"><a href="#"><i></i><span class="te">添加收藏</span></a></li>
    <li class="nt06"><a href="javascript:void(0);" class="gotop"><i></i><span class="te">返回顶部</span></a></li>
  </ul>
</div>
<script type="text/javascript">
$('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});
</script>

<div style="display:none"> 
  <script type="text/javascript">
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
	document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F2bbdb11527d93b69fad8795fbc9167ef' type='text/javascript'%3E%3C/script%3E"));
  </script>
  <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
  <script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
  try{
       window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
   }catch (e){
       try{
           window.sidebar.addPanel('21-sun产品中心', 'http://product.21-sun.com', "");
       }catch (e){
           alert("请使用Ctrl+D进行添加");
       }
   }
}
</script> 
<!-- Baidu Button BEGIN -->
<!--
<script type="text/javascript" src="http://pv.21-sun.com/http/stat.jsp"></script>
-->
</div>
<!--foot end-->
<div style="display:none">     <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_5953941'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/stat.php%3Fid%3D5953941' type='text/javascript'%3E%3C/script%3E"));</script> </div>

</body>
<script type="text/javascript" src="http://product.21-sun.com/biz/scripts/common.js"></script>
<script type="text/javascript">
function SetFontSize(size){
   document.getElementById('mainDetail').style.fontSize=size+'px';
}
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>