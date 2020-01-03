<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*,org.json.*" pageEncoding="UTF-8"%><%
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
	try{
		connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
		if(map == null){
			Common.do302(response,"/agent");
			return;
		}
		Integer is_shop = CommonString.getFormatInt(map.get("is_qijiandian"));
		/*
		if(is_shop.equals(1)){
			Common.do302(response,"/agentshop/"+CommonString.getFormatPara(map.get("usern"))+"/");
			return;
		}
		*/
	// 预计购买时间
	LinkedHashMap buyTimeMap = (LinkedHashMap)CommonApplication.getEnumChildrenLink("102",application) ;
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
	Integer newsCount = (Integer)dbHelper.getOne(" select count(*) from pro_agent_news where agent_id = ? and is_approval = 1 ",new Object [] {map.get("id")},connection);
	
	
	//代理品牌
	String dali_brand="";
	//代理产品
    String dali_pro="";
    String factoryid="";
	String agent_fac_id_list=CommonString.getFormatPara(map.get("agent_fac"));
    String fac_ids_list[]=agent_fac_id_list.split(",");
	if(fac_ids_list.length>0){
	    for(int i=0;i<fac_ids_list.length;i++){
		    if(!fac_ids_list[i].equals("")){
			factoryid=fac_ids_list[0];
			Map facInfo = dbHelper.getMap(" select name,usern from pro_agent_factory where id = "+fac_ids_list[i],connection);
			   dali_brand+=CommonString.getFormatPara(facInfo.get("name"));
			       List<Map> proInfo = dbHelper.getMapList("select catalognum,catalogname from pro_agent_product_vi where agentid = '"+CommonString.getFormatPara(map.get("id"))+"' and factoryid = '"+fac_ids_list[i]+"'  group by catalognum,catalogname order by catalognum",connection);
                             for(Map oneMap : proInfo){
							  dali_pro+=CommonString.getFormatPara(facInfo.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"));
							 }
			}				 
	 }
   }
   
%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=CommonString.getFormatPara(map.get("full_name"))%> – 铁臂商城代理商平台</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(map.get("full_name"))%>" />
<meta name="description" content="<%=CommonString.getFormatPara(map.get("full_name"))%>是<%=CommonString.getFormatPara(map.get("city"))%><%=dali_brand%>代理商,代理经营<%=CommonString.getFormatPara(map.get("city"))%><%=dali_pro%>系列产品。" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<link href="http://product.21-sun.com//style/style.css" rel="stylesheet" />
<link href="http://product.21-sun.com/biz/style/style.css" rel="stylesheet" />
<script type="text/javascript" src="http://product.21-sun.com//scripts/jquery.min.js"></script>
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
        <li class="cur"><a href="http://<%=usern%>.biz.21-sun.com">商铺首页</a></li>
        <li><a href="http://<%=usern%>.biz.21-sun.com/introduct.htm">公司介绍</a></li>
        <li><a href="http://<%=usern%>.biz.21-sun.com/products.htm">产品展示</a></li>
        <li><a href="http://<%=usern%>.biz.21-sun.com/message.htm">留言反馈</a></li>
        <li><a href="http://<%=usern%>.biz.21-sun.com#contactus">联系我们</a></li>
      </ul>
    </div>
  </div>
  <div class="shopBanner">
    <img src="http://product.21-sun.com/biz/images/temp/shop_banner.jpg" width="978" height="188">
  </div>
    <div class="contain980 mb10 clearfix">
  <h3 class="breadCrumbs l"><a href="/">企业首页</a></h3>
</div>
  <div class="contain980 fix">
    <div class="comBox04 mb10">
      <div class="hd fix">
        <h3>推荐产品<i></i></h3>
        <span class="more"><a href="http://<%=usern%>.biz.21-sun.com/products.htm" title="更多推荐产品">更多&gt;&gt;</a></span>
      </div>
      <div class="bd shopProList">
        <ul class="comList02">
            <jsp:include page="/include/agent_new/agent_products.jsp" flush="true">
               <jsp:param name="agentid" value='<%=CommonString.getFormatPara(map.get("id"))%>'></jsp:param>
               <jsp:param name="usern" value='<%=usern%>'></jsp:param>
			   <jsp:param name="flag" value='special'></jsp:param>
            </jsp:include>
        </ul>
      </div>
    </div>
    
    <div class="comBox04 mb10 companyIntro">
      <div class="hd fix">
        <h3>公司介绍<i></i></h3>
        <span class="more"><a href="http://<%=usern%>.biz.21-sun.com/introduct.htm" title="更多">更多&gt;&gt;</a></span>
      </div>
        <div class="bd fix">
          <a title="<%=CommonString.getFormatPara(map.get("full_name"))%>" href="http://<%=usern%>.biz.21-sun.com/introduct.htm">
            <img alt="<%=CommonString.getFormatPara(map.get("full_name"))%>" src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(map.get("img1"))%>" width="200" height="150" class="comImg" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);">
            <div class="text">　　<%=(CommonHtml.filterHTML(CommonString.getFormatPara(map.get("introduce"))).length()>=220)?CommonHtml.filterHTML(CommonString.getFormatPara(map.get("introduce"))).substring(0,220)+"...":CommonHtml.filterHTML(CommonString.getFormatPara(map.get("introduce")))%>
              <span class="more"><a href="http://<%=usern%>.biz.21-sun.com/introduct.htm" title="更多详情">更多详情&gt;&gt;</a></span>
            </div>
          </a>
        </div>
    </div>
    
    <div class="comBox04 mb10 shop_contacts" id="contactus">
      <div class="hd fix">
        <h3>联系方式<i></i></h3>
      </div>
      <div class="bd fix">
	  	 <%if(!CommonString.getFormatPara(map.get("address")).equals("")){%>公司名称：<%=CommonString.getFormatPara(map.get("full_name"))%><br><%}%>
	  	 <%if(!CommonString.getFormatPara(map.get("address")).equals("")){%>地址：<%=CommonString.getFormatPara(map.get("address"))%><br><%}%>
		 <%if(!CommonString.getFormatPara(map.get("city")).equals("")){%>代理地区：<%=CommonString.getFormatPara(map.get("city"))%><br><%}%>
	  	 <%if(!CommonString.getFormatPara(map.get("concatus")).equals("")){%>联系人：<%=CommonString.getFormatPara(map.get("concatus"))%><br><%}%>
		 <%if(!CommonString.getFormatPara(map.get("telphone")).equals("")){%>联系方式：<%=CommonString.getFormatPara(map.get("telphone"))%><br><%}%>
		 <%if(!CommonString.getFormatPara(map.get("saleqq")).equals("")){%> QQ：<%=CommonString.getFormatPara(map.get("saleqq"))%><br><%}%>
         <%if(!CommonString.getFormatPara(map.get("email")).equals("")){%>邮箱：<%=CommonString.getFormatPara(map.get("email"))%><br><%}%>
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