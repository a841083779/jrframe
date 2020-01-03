<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.HashMap"%>
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catanum = CommonString.getFormatPara(request.getParameter("catanum")) ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "select  * from pro_products where factoryid= "+factoryid ;
	List<Map> products_List = null; 
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	if("".equals(factoryid)){
		response.sendRedirect("/brandshop/servlo/") ;
	}
	if("".equals(catanum) && !"454".equals(factoryid)){
		catanum = "101001" ;
	}
	if("".equals(catanum) && "454".equals(factoryid)){
		catanum = "101002" ;
	}
	String showTip = CommonString.getFormatPara(brandMap.get(factoryid)) ;
	String whereStr = "" ;
	if(!"".equals(catanum)){
		whereStr += " and catalognum like '"+catanum+"%'" ;
	}
	if("1661".equals(factoryid)){
		sel_sql = "select top 10 pro.name,pro.catalogname,pro.file_name,pro.id,pro.img2 from pro_agent_products agent left join pro_products pro on agent.product_id=pro.id where agent_id=1661" ;
		showTip = "千里马" ;
		if("113001".equals(catanum)){
			whereStr = "and pro.catalognum like '113001%'" ;
		}
		if("101001".equals(catanum)){
			catanum = "113001" ;
			whereStr = "and pro.catalognum like '113001%'" ;
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>千里马官方旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="千里马,千里马产品报价,千里马产品,千里马产品图片,千里马介绍,千里马代理商" />
<meta name="description" content="中国工程机械商贸网为您提供千里马介绍,千里马产品介绍,千里马产品报价,千里马产品图片,千里马产品展示等千里马产品信息，帮助您全面了解千里马相关的斗山产品、临工产品、山猫滑移产品、千里马产品。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
<script type="text/javascript" src="jquery.hoveraccordion.js"></script>
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true">
<jsp:param value="<%=factoryid %>" name="factoryid"/>
</jsp:include>
<!--main-->
<div class="shopPart03">
  <div class="contain980 pt20 clearfix">
    <div class="shopContain">
      <div class="shopLeftPart">
        <h2>产品列表</h2>
        <ul class="shopListMenu" id="leftNav">
          <li><a href="javascript:;" value="192">斗山</a>
            <ul>
              <li><a href="list.jsp?factoryid=192&catanum=101001">挖掘机</a></li>
              <li><a href="list.jsp?factoryid=192&catanum=101002">装载机</a></li>
              <li><a href="list.jsp?factoryid=192&catanum=101008">铰接式自卸卡车</a></li>
              <li><a href="list.jsp?factoryid=192&catanum=113001">破碎锤</a></li>
            </ul>
          </li>
          <li><a href="javascript:;" value="137">临工</a>
            <ul>
             <li><a href="list.jsp?factoryid=137&catanum=101001">液压控掘机</a></li>
              <li><a href="list.jsp?factoryid=137&catanum=101002">装载机</a></li>
              <li><a href="list.jsp?factoryid=137&catanum=106001">压路机</a></li>
            </ul>
          </li>
          <li><a href="javascript:;" value="454">山猫</a>
            <ul>
            <li><a href="list.jsp?factoryid=454&catanum=101001">挖掘机</a></li>
              <li><a href="list.jsp?factoryid=454&catanum=101002">装载机</a></li>
            </ul>
          </li>
          <li><a href="javascript:;" value="1661">千里马</a>
            <ul>
              <li><a href="list.jsp?factoryid=1661&catanum=33333">再制造产品</a></li>
              <li><a href="list.jsp?factoryid=1661&catanum=113001">破碎锤</a></li>
            </ul>
          </li>
        </ul>
        <div class="shopIntro">
          <div class="title">
            <h2>店铺介绍</h2>
          </div>
          <div class="content">
            <p class="intro"> <strong class="name">千里马工程机械集团<br />股份有限公司</strong> <a href="introduce.jsp" target="_blank" style="color:#939191!important;">千里马工程机械集团股份有限公司(简称千里马)，成立于2002年，是中国领先的工程机械绿色连锁服务商，是中国工程机械工业协会代理商委员会副会长单位，旗下包括武汉千</a> <span class="more"><a href="introduce.jsp" target="_blank">更多&gt;&gt;</a></span> 
            </p>
            <ul>
              <li>商　　家：<strong class="name">千里马官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：武汉</li>
              <li>客服电话：400-889-6977</li>
              <li>销售热线：027-83201111 </li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
          </div>
        </div>
      </div>
      <div class="shopRightPart">
        <div class="listBanner">
        <a title="千里马官方旗舰店" target="_blank" href="/brandshop/sevalo/"><img src="images/listbanner.gif" alt="做世界级的工程机械绿色连锁服务商" width="700" height="183"></a>
        </div>
		<%
			if("192".equals(factoryid) && "101001".equals(catanum)){
				%>
	<div class="listPart">
          <div class="title">
            <h3>大型挖掘机</h3>
            <span class="more"><!--<a href="/products/prolist.jsp" target="_blank">更多&gt;&gt;</a>--></span>
          </div>
          <div class="content pbl">
            <ul class="list">              
              <%
              products_List = dbHelper.getMapList(sel_sql+" and catalognum like '101001%' and tonandmeter>=30") ;
              if(null!=products_List && products_List.size()>0){
            	  for(Map oneMap:products_List){
            		  %>
               <li>
                <a class="img" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img onerror='this.src="/images/nopic.gif"'width="235" height="225" src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>"></a>
                <h4><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%></a></h4>
                <a class="xjbtn" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')">立即询价</a>
              </li>           		  
            		  <%
            	  }
              }
              %>
            </ul>
          </div>
        </div>
        <div class="listPart">
          <div class="title">
            <h3>中型挖掘机</h3>
            <span class="more"><!--<a href="/products/prolist.jsp" target="_blank">更多&gt;&gt;</a>--></span>
          </div>
          <div class="content pbl">
            <ul class="list">
              <%
              products_List = dbHelper.getMapList(sel_sql+" and catalognum like '101001%' and tonandmeter>=14 and tonandmeter<30") ;
              if(null!=products_List && products_List.size()>0){
            	  for(Map oneMap:products_List){
            		  %>
               <li>
                <a class="img" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img onerror='this.src="/images/nopic.gif"'width="235" height="225" src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>"></a>
                <h4><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%></a></h4>
                <a class="xjbtn" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')">立即询价</a>
              </li>           		  
            		  <%
            	  }
              }
              %>         
            </ul>
          </div>
        </div>
        <div class="listPart">
          <div class="title">
            <h3>小型挖掘机</h3>
            <span class="more"><!--<a href="/products/prolist.jsp" target="_blank">更多&gt;&gt;</a>--></span>
          </div>
          <div class="content pbl">
            <ul class="list">
             <%
              products_List = dbHelper.getMapList(sel_sql+" and catalognum like '%101001%' and tonandmeter>=1 and tonandmeter<=13") ;
              if(null!=products_List && products_List.size()>0){
            	  for(Map oneMap:products_List){
            		  %>
               <li>
                <a class="img" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img onerror='this.src="/images/nopic.gif"'width="235" height="225" src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>"></a>
                <h4><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%></a></h4>
                <a class="xjbtn" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')">立即询价</a>
              </li>           		  
            		  <%
            	  }
              }
              %>            
            </ul>
          </div>
        </div>
				<%
			}
		// 斗山装载机
		else
		if(!"".equals(factoryid)){
			%>
        <div class="listPart">
          <div class="title">
            <h3><%=CommonString.getFormatPara(catalogMap.get(catanum)).equals("")?(showTip+"产品"):CommonString.getFormatPara(catalogMap.get(catanum)) %></h3>
            <span class="more"><!--<a href="/products/prolist.jsp?factory=<%=factoryid %>&catalog=<%=catanum %>" target="_blank">更多&gt;&gt;</a>--></span>
          </div>
          <div class="content pbl">
           <ul class="list">
             <%
              products_List = dbHelper.getMapList(sel_sql+whereStr) ;
              if(null!=products_List && products_List.size()>0){
            	  for(Map oneMap:products_List){
            		  %>
               <li>
                <a class="img" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank"><img onerror='this.src="/images/nopic.gif"'width="235" height="225" src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2")) %>"></a>
                <h4><a href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")) %>" target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) +CommonString.getFormatPara(oneMap.get("catalogname"))+CommonString.getFormatPara(oneMap.get("name"))%></a></h4>
                <a class="xjbtn" href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(oneMap.get("id"))%>','')">立即询价</a>
              </li>           		  
            		  <%
            	  }
              }
              %>            
            </ul>
			<%
		}
		%>
          </div>
        </div>
      </div>
    </div>
  </div>  
</div>
<!--main end--> 
<!--foot-->
<div class="flagshopbg">
  <jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot--> 
<script type="text/javascript">
jQuery(function(){
	jQuery(".shopPros01 li").hover(function(){ 
		jQuery(this).toggleClass("hover");
	},function(){
		jQuery(this).removeClass("hover");
	});
})
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script> 
<script type="text/javascript" src="scripts/common.js"></script> 
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script> 
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
  try{
       window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
   }catch (e){
       try{
           window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/sevalo/', '千里马官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('千里马官方旗舰店','http://product.21-sun.com/brandshop/hengzhi/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
DK.load('scripts/core.js', function(){ 
	DK.index.init();
});
jQuery(function(){
    jQuery("#leftNav").hoverAccordion({
    	keepHeight : true,
        onClickOnly : true ,
        keepHeight:false 
    }) ;
    jQuery("#leftNav li a").each(function(){
    	if(jQuery(this).attr("value")=='<%=factoryid%>'){
			jQuery(this).click() ;
		    jQuery(this).parent().find("ul li a").each(function(){
		    	if(jQuery(this).attr("href").indexOf('<%=catanum%>')!=-1&&'<%=catanum%>'!=''){
		    	   jQuery(this).parent().addClass("select") ;
		    	}
		    }) ;
    	}
    }) ;
}) ;
jQuery("#leftNav li ul li").hover(function(){
	jQuery(this).addClass("select") ;
},function(){
	jQuery(this).removeClass("select") ;
}) ;
</script>
</body>
</html>