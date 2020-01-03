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
		pageBean.setPageSize(12) ; // 每页显示条数
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
	 String factoryid="";
	String agent_fac_id_list=CommonString.getFormatPara(map.get("agent_fac"));
    String fac_ids_list[]=agent_fac_id_list.split(",");
	    for(int i=0;i<fac_ids_list.length;i++){
		    if(!fac_ids_list[i].equals("")){
			Map facInfo = dbHelper.getMap(" select name,usern from pro_agent_factory where id = "+fac_ids_list[i],connection);
			if(facInfo!=null){factoryid=fac_ids_list[i];}
			}				 
		}
%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=CommonString.getFormatPara(map.get("full_name"))%>产品展示_代理产品– 铁臂商城代理商平台</title>
<meta name="keywords" content="<%=CommonString.getFormatPara(map.get("full_name"))%>产品展示, <%=CommonString.getFormatPara(map.get("full_name"))%>代理产品" />
<meta name="description" content="<%=CommonString.getFormatPara(map.get("full_name"))%>最新产品、主营产品分类，低廉的价格、优质的服务，欢迎广大客户前来采购询价。" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" />
<link href="http://product.21-sun.com/dealer/style/style.css" rel="stylesheet" />
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="http://product.21-sun.com/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript">
//导航选中状态
var jrChannel='0#0'
//店铺导航选中状态
var jrChannel_shop='0#0'
</script>
</head>
<body class="shop02">
<!--top-->
<jsp:include page="include/top.jsp" flush="true" />
<!--top end-->
<div class="shop_con">
  <div class="shop_top01">
    <div class="contain980 fix">
      <h1 class="logo"><%=CommonString.getFormatPara(map.get("full_name"))%>
        <strong class="site"><a title="http://dealer.21-sun.com/<%=usern%>/" href="http://dealer.21-sun.com/<%=usern%>/" target="_blank">http://dealer.21-sun.com/<%=usern%>/</a></strong>
      </h1>
      <div class="mark"><img src="http://product.21-sun.com/dealer/images/mark.png" width="109" height="34" onclick="addShop();return false;"></div>
      <script type="text/javascript">
      function addShop(){
          try{
             window.external.addFavorite('http://dealer.21-sun.com/<%=usern%>/', '<%=CommonString.getFormatPara(map.get("full_name"))%>');
         }catch (e){
             try{
                 window.sidebar.addPanel('<%=CommonString.getFormatPara(map.get("full_name"))%>','http://dealer.21-sun.com/<%=usern%>/',"");
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
        <li><a href="/<%=usern%>/">商铺首页</a></li>
        <li><a href="/<%=usern%>/introduce.shtm">公司介绍</a></li>
        <li><a href="/<%=usern%>/agent_products.shtm">产品展示</a></li>
        <li><a href="/<%=usern%>/message.shtm">留言反馈</a></li>
        <li><a href="/<%=usern%>/contact.shtm">联系我们</a></li>
      </ul>
    </div>
  </div>
  
  <div class="shopBanner">
    <img src="http://product.21-sun.com/dealer/images/temp/shop_banner.jpg" width="978" height="188">
  </div>
  
     <div class="contain980 mb10 clearfix">
  <h3 class="breadCrumbs l"><a href="/">铁臂商城代理商平台</a> &gt;&gt; <%=CommonString.getFormatPara(map.get("full_name"))%> &gt;&gt; 产品展示</h3>
</div>
  
  <div class="contain980 fix">
    <!--left-->
    <div class="shopLeft">
      <div class="comBox03 mb10">
        <div class="hd fix">
          <h3>产品分类</h3>
        </div>
        <div class="bd fix">
          <div class="comList" id="brandId">
		    <jsp:include page="/include/agent_new/agent_catalog.jsp" flush="true">
               <jsp:param name="agentid" value='<%=CommonString.getFormatPara(map.get("id"))%>'></jsp:param>
			   <jsp:param name="usern" value='<%=usern%>'></jsp:param>
            </jsp:include>
          </div>
        </div>
      </div>
      <div class="comBox03 mb10 shop_contacts">
        <div class="hd fix">
          <h3>联系方式</h3>
        </div>
        <div class="bd fix">
          <div class="comList">
		      <%if(!CommonString.getFormatPara(map.get("concatus")).equals("")){%><li> 联系人：<%=CommonString.getFormatPara(map.get("concatus"))%></li><%}%>
		      <%if(!CommonString.getFormatPara(map.get("city")).equals("")){%><li> 代理地区：<%=CommonString.getFormatPara(map.get("city"))%></li><%}%>
			  <%if(!CommonString.getFormatPara(map.get("address")).equals("")){%><li>地址：<%=CommonString.getFormatPara(map.get("address"))%></li><%}%>
               <%if(!CommonString.getFormatPara(map.get("email")).equals("")){%><li>邮箱：<%=CommonString.getFormatPara(map.get("email"))%></li><%}%>
          </div>
        </div>
      </div>
      
      <div class="comBox03 mb10">
        <div class="hd fix">
          <h3>其他该地域代理商</h3>
        </div>
        <div class="bd fix">
          <div class="comList">
		    <jsp:include page="/include/agent_new/other_agent.jsp" flush="true">
			   <jsp:param name="area" value='<%=CommonString.getFormatPara(map.get("city"))%>'></jsp:param>
            </jsp:include>
          </div>
        </div>
      </div>
    <%if(!factoryid.equals("")){%>  
      <div class="comBox03 mb10">
        <div class="hd fix">
          <h3>更多品牌代理商</h3>
        </div>
        <div class="bd fix">
          <div class="comList">
		    <jsp:include page="/include/agent_new/other_agent.jsp" flush="true">
			   <jsp:param name="agent_fac" value='<%=factoryid%>'></jsp:param>
            </jsp:include>
          </div>
        </div>
      </div>
     <%}%>
    </div>
    <!--left end-->
    <!--right-->
    <div class="shopRight">
      <div class="comBox04 mb10">
        <div class="hd fix">
          <h3>产品展示</h3>
          <span class="more"><a href="/<%=usern%>/agent_products.shtm" title="更多产品">更多&gt;&gt;</a></span>
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
      
    </div>
    <!--right end-->
  </div>
</div>
<!--foot-->
<div class="foot_box">
<jsp:include page="/include/foot.jsp" flush="true" />
</div>
<!--foot end-->
<div style="display:none">     <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_5953941'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/stat.php%3Fid%3D5953941' type='text/javascript'%3E%3C/script%3E"));</script> </div>

</body>
<script type="text/javascript" src="http://product.21-sun.com/dealer/scripts/common.js"></script>
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