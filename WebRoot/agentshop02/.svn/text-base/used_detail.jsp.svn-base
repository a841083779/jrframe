<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.Map,com.jerehnet.util.common.Common,java.util.List,java.util.LinkedHashMap,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonHtml,com.jerehnet.util.common.CommonApplication" errorPage="" %><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%

		String usern = CommonString.getFormatPara(request.getParameter("usern"));
		DBHelper dbHelper = DBHelper.getInstance();
		Connection connection = null;
		String factoryid = "" ;
		try{
		connection = dbHelper.getConnection();
		Map map = dbHelper.getMap(" select * from pro_agent_factory where usern = ? ",new Object []{usern},connection);
		if(map == null){
			Common.do302(response,"/agent");
			return;
		}
		factoryid = CommonString.getFormatPara(map.get("agent_fac")) ;  // 代理的品牌
		String agentid =CommonString.getFormatPara(map.get("id")) ;  // 代理商的品牌	 
  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%="代理商首页_"+CommonString.getFormatPara(map.get("full_name"))%>-中国工程机械商贸网</title>
<meta name="keywords" content="代理商首页,<%= CommonString.getFormatPara(map.get("full_name"))%>,工程机械" />
<meta name="description" content="中国工程机械商贸网提供<%= CommonString.getFormatPara(map.get("full_name"))%>代理商首页栏目，让您对<%= CommonString.getFormatPara(map.get("full_name"))%>更加了解，欢迎光临<%= CommonString.getFormatPara(map.get("full_name"))%>品牌旗舰店。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/shop01.css" rel="stylesheet" type="text/css" />
<link href="/style/ud.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<script src="/scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
EvPNG.fix('div,ul,img,li,input,td,a'); 
</script>
<![endif]-->
<script type="text/javascript" src="/scripts/pinyin.js"></script>
</head>
<body class="style01">
<!--top-->
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--top end--> 
<!--面包屑结束-->

<%
	if(usern.equals("jxxiaosong")){
		%>

<div class="sTop01" style="height:116px;">
  <div class="contain980 h93px" >
  	<%
  		String logo = CommonString.getFormatPara(map.get("logo"));
  		if(!"".equals(logo)){
  			%><div style="float:left;margin-top:15px;margin-left:6px;"><img style="width:70px;height:65px;" src="/uploadfiles<%=logo %>" /></div><%
  		}
  	%>
    <h2 class="companyName"> <%=CommonString.getFormatPara(map.get("full_name"))%><span class="intro"><%=CommonString.getFormatPara(map.get("sub_title")) %></span> </h2>
    <div class="approve">
      <div class="star"><span class="star01"></span></div>
    </div>
  </div>
</div>
		<%
	}else{
		%>
<div class="sTop01">
  <div class="contain980 h93px">
  	<%
  		String logo = CommonString.getFormatPara(map.get("logo"));
  		if(!"".equals(logo)){
  			%><div style="float:left;margin-top:15px;margin-left:6px;"><img style="width:70px;height:65px;" src="/uploadfiles<%=logo %>" /></div><%
  		}
  	%>
    <h2 class="companyName"> <%=CommonString.getFormatPara(map.get("full_name"))%><span class="intro"><%=CommonString.getFormatPara(map.get("sub_title")) %></span> </h2>
    <div class="approve">
      <div class="star"><span class="star01"></span></div>
    </div>
  </div>
</div>
		<%
	}
%>

<!--店铺导航-->
<jsp:include page="nav_top.jsp"><jsp:param value="7" name="flag"/></jsp:include>
<!--店铺导航结束--> 
<script type="text/javascript">
	//主营品牌
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"flag":"brandAgentCatalogListShop2","shop_url":'agentshop02',"agentid":"<%=agentid%>","agent_fac":"<%=CommonString.getFormatPara(map.get("agent_fac"))%>","agent_fac_name":"<%=CommonString.getFormatPara(map.get("agent_fac_name"))%>","usern":"<%=usern%>"},
		success:function(data){
			jQuery("#brandId").html(jQuery.trim(data));	
			if(jQuery.trim(data)==""){
				jQuery("#brandId").removeClass("agentLeftPart mb10");	
			}
		}
	});
	//二手机显示
	jQuery.ajax({
		url:"/action/ajax_list.jsp",
		type:"post",
		data:{"flag":"usedListShop2","shop_url":'agentshop02',"agentid":"<%=agentid%>","agent_fac":"<%=CommonString.getFormatPara(map.get("agent_fac"))%>","agent_fac_name":"<%=CommonString.getFormatPara(map.get("agent_fac_name"))%>","usern":"<%=usern%>"},
		success:function(data){
			jQuery("#usedBrandId").html(jQuery.trim(data));	
			if(jQuery.trim(data)==""){
				jQuery("#usedBrandId").removeClass("agentLeftPart mb10");	
			}
		}
	});
</script> 

<!--店铺导航结束--> 
<!--主体-->
<div class="shopContain whitebg mb10">
  <div class="h10px c"></div>
  <div class="w100 l shopLeftbg"> 
    <!--left-->
    <div class="shopLeft"> 
      <!--代理产品-->
      <div class="brand">
        <div class="sTitle">
          <h2>代理品牌</h2>
        </div>
        <div class="sContent" id="brandId"></div>
      </div>
      <!--代理产品 结束-->
      <div class="w100 l h10px whitebg"></div>
 	<!--二手机显示 开始-->
      <div class="brand">
        <div class="sTitle">
          <h2>二手机展示</h2>
        </div>
        <div class="sContent" id="usedBrandId">
        </div>
      </div>
      <!--二手机显示结束-->
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

            <%=CommonString.getFormatPara(map.get("fax")).equals("")?"":"传真："+CommonString.getFormatPara(map.get("fax"))+"<br />"%>
               <!--   邮政编码：<%=CommonString.getFormatPara(map.get("postcode"))%><br />  -->
           <%=CommonString.getFormatPara(map.get("address")).equals("")?"":" 地址："+CommonString.getFormatPara(map.get("address"))%> 
          </div>
        </div>
      </div>
      <!--公司资料 结束-->       
    </div>
    <!--left end--> 
    <!--right-->
    <div class="shopRight"> 
      <div class="dt_1 clearfix">
        <div class="dt_Title">
        <%
    	String id =CommonString.getFormatPara(request.getParameter("id"));   	
    	String mingcheng=null;
    	String leibie=null;
    	//基本信息
       	String sql = "select * from pro_products_used where id="+id+" and is_show=1" ;
        Map productsLists= null;
       
        productsLists = dbHelper.getMap(sql);
        
    	if(productsLists==null){%>
    		该产品暂时没有信息
    		
    	<%
    	Common.do302(response,"/agent");
			return;
    	}
        factoryid= CommonString.getFormatPara(productsLists.get("id"));
      	  CommonString.getFormatPara(productsLists.get("phone"));
      	  String name=CommonString.getFormatPara(productsLists.get("name"));
      	  String place=CommonString.getFormatPara(productsLists.get("place"));
      	  String old=CommonString.getFormatPara(productsLists.get("old"));
      	  String catalogname=CommonString.getFormatPara(productsLists.get("catalogname"));
      	
      		 String brandname= CommonString.getFormatPara(productsLists.get("factoryname"));
      	 	 mingcheng=place+brandname+name+old+catalogname;
      	          leibie=brandname+catalogname;
      	
    	%>
          <h1 style="width:500px;"><%=mingcheng %></h1>
          <div class="brandinfo">
            <span>品牌：<a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(productsLists.get("factoryid"))%>"><%=brandname %></a>&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <span>类别：<a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(productsLists.get("factoryid"))%>&catalog=<%=CommonString.getFormatPara(productsLists.get("catalognum")) %>"><%=leibie %></a></span> 
          </div>
          <div class="inquiry">
           <span class="oi"><img width="14" height="14" src="/images/detail_ico01.gif"/><%=CommonString.getFormatPara(productsLists.get("lastvisitedate")).substring(0,16) %></span> 
           <span class="oi"><img width="14" height="14" src="/images/detail_ico02.gif"/><font id="viewCountId"></font>次</span> 
          </div>
        </div>
      </div>
      <div class="dt_2">
        <div class="dt_2Left">
          <div class="info-con">
            <div class="price">设备报价： <strong>&yen;<%=CommonString.getFormatPara(productsLists.get("price")).equals("0")?"暂无报价":CommonString.getFormatPara(productsLists.get("price"))+"万" %></strong>（可议）</div>
           
            <ul class="list">
              <li>
                <dt>工作小时：</dt>
                <dd><%=CommonString.getFormatPara(productsLists.get("worktime")) %>小时 </dd>
              </li>
              <li>
                <dt>生产年份：</dt>
                <dd><%=CommonString.getFormatPara(productsLists.get("birth_year")) %> </dd>
              </li>
              <li>
                <dt>新旧程度：</dt>
                <dd> <%=CommonString.getFormatPara(productsLists.get("deep")) %> </dd>
              </li>
              <li>
                <dt>设备地址：</dt>
                 <dd> <%=CommonString.getFormatPara(productsLists.get("address")) %> </dd>
              </li>
              <li>
                <dt>设备来源：</dt>
                <dd> <%=CommonString.getFormatPara(productsLists.get("source")) %> </dd>
              </li>
              <li>
                <dt>有无发票：</dt>
                
                <dd> <%=CommonString.getFormatPara(productsLists.get("invoice")).equals("1")?"有":"无" %> </dd>
             
              </li>
              <li>
                <dt>产<span style="margin-left:20px;"></span>地：</dt>
                <dd> <%=CommonString.getFormatPara(productsLists.get("origin")) %> </dd>
              </li>
              <li>
                <dt>有无大修：</dt>
              <dd> <%=CommonString.getFormatPara(productsLists.get("rest")).equals("1")?"有":"无" %> </dd>
             
              </li>
              <li>
                <dt>联系电话：</dt>
              <dd><%=CommonString.getFormatPara(productsLists.get("phone")) %></dd>
              </li>
              <li>
              <div align="center">
               <a href="javascript:;" onclick="showinquery('<%=CommonString.getFormatPara(productsLists.get("id")) %>','<%=agentid%>','<%=CommonString.getFormatPara(productsLists.get("factoryid"))%>')" class="btn"><img onerror="this.src='/images/nopic.gif'"  src="/images/pd_btn.gif"/></a>
               </div>
               </ul>
          </div>
          <div class="bigpic "><img onerror="this.src='/images/nopic.gif'" src="http://product.21-sun.com//uploadfiles<%=CommonString.getFormatPara(productsLists.get("img2"))%>" width="424" height="300" id="mainImg" name="mainImg" title="<%=mingcheng %> " /> </div>
          <div id="rollBox" class="rollBox">
            <div class="hd"> <a class="next"></a> <a class="prev"></a> </div>
            <div class="bd">
              <ul class="picList">
                <%
              //图片信息
                String imgSql = "select img_name FROM pro_product_used_pic where product_id="+factoryid+" ORDER BY order_no ASC" ;
            	 List<Map> imgList = null ;
            	  Map oneMap = null ;
            	  imgList = dbHelper.getMapList(imgSql) ; 
        
					    if(null!=imgList && imgList.size()>0){
					        for(int i=0;i<imgList.size();i++){
					          oneMap =imgList.get(i);					  
							  String imgname=CommonString.getFormatPara(oneMap.get("img_name"));
							  %>
							   <li><a href="javascript:void(0);" onclick="showBigImg('<%=imgname.indexOf("uploadfiles")==-1?"http://product.21-sun.com/uploadfiles/"+imgname :"http://product.21-sun.com/"+imgname %>');">
							   <img onerror="this.src='/images/nopic.gif'" src="<%=imgname.indexOf("uploadfiles")==-1?"http://product.21-sun.com/uploadfiles/"+imgname :"http://product.21-sun.com/"+imgname %>" width="90" height="65" /></a></li>
				
							 <%
					      }}else{
					    	  %>
				
					    	 <%
					      }
					    %>   
				</ul>
            </div>
          </div>
        </div>
      </div>
      <div class="detail-con">
        <div class="parHd">
          <ul>
            <li class="on"><h2>详细参数</h2></li>
          </ul>
          
        </div>
        <div class="detail-content clearfix mb10">
          <div class="pdPart clearfix">
            <div class="parameter clearfix" id="list01">
              <ul>
               <li >
                  <dt>品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：</dt>
                  <dd><%=brandname %></dd>
                </li>
                <li >
                  <dt>型&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</dt>
                  <dd><%=name %></dd>
                </li>
                <li >
                  <dt>类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：</dt>
                  <dd><%=catalogname %></dd>
                </li>
                <li >
                  <dt>序&nbsp;&nbsp;列&nbsp;&nbsp;号：</dt>
                  <dd><%=CommonString.getFormatPara(productsLists.get("number")) %></dd>
                </li>
                <li >
                  <dt>工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;时：</dt>
                  <dd><%=CommonString.getFormatPara(productsLists.get("worktime")) %>小时</dd>
                </li>
                <li >
                  <dt>年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;份：</dt>
                 <dd><%=CommonString.getFormatPara(productsLists.get("birth_year")) %></dd>
                </li>
                <li >
                  <dt>新旧程度：</dt>
               <dd><%=CommonString.getFormatPara(productsLists.get("deep")) %></dd>
                </li>
                <li >
                  <dt>设备地址：</dt>
                <dd><%=CommonString.getFormatPara(productsLists.get("address")) %></dd>
                </li>
                <li >
                  <dt>设备来源：</dt>
				 <dd><%=CommonString.getFormatPara(productsLists.get("source")) %></dd>
                </li>
                <li >
                  <dt>有无发票：</dt>
                  <dd> <%=CommonString.getFormatPara(productsLists.get("invoice")).equals("1")?"有":"无" %> </dd>
                </li>
                <li >
                  <dt>产&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;地：</dt>
            	 <dd><%=CommonString.getFormatPara(productsLists.get("origin")) %></dd>
                </li>
                <li >
                  <dt>有无大修：</dt>
         	<dd> <%=CommonString.getFormatPara(productsLists.get("rest")).equals("1")?"有":"无" %> </dd>
                </li>
                <li >
                  <dt>吨位/马力：</dt>
        		 <dd><%=CommonString.getFormatPara(productsLists.get("weight")) %></dd>
                </li>
                <li >
                  <dt>合&nbsp;&nbsp;格&nbsp;&nbsp;证：</dt>
             <dd> <%=CommonString.getFormatPara(productsLists.get("warranty")).equals("1")?"有":"无" %> </dd>
                </li>
                <li >
                  <dt>当前状态：</dt>
                <dd><%=CommonString.getFormatPara(productsLists.get("condition")) %></dd>
                </li>
              </ul>
            </div>
          </div>
          <div class="pdPart clearfix">
            <div class="title" id="detail">
              <h3>附加信息</h3>
            </div>
            <div class="content">
             <%=CommonString.getFormatPara(productsLists.get("introduce")) %>
              <div class="Postscript">联系我时，请说是在铁臂商城二手网上看到的，谢谢！ </div>
            </div>
          </div>
          <div class="pdPart clearfix">
            <div class="title">
              <h3>图片展示</h3>
            </div>
       
                
            <div class="content">
              <div style=" text-align:center;"> 
                <%
            			
					    if(null!=imgList && imgList.size()>0){
					        for(int i=0;i<imgList.size();i++){
					        
					          oneMap = imgList.get(i);					  
							  String imgname=CommonString.getFormatPara(oneMap.get("img_name"));
							
							  %>
							  
					<img style="width:723px;" onerror="this.src='/images/nopic.gif'" src="<%=imgname.indexOf("uploadfiles")==-1?"http://product.21-sun.com/uploadfiles/"+imgname :"http://product.21-sun.com/"+imgname %>" /><br />
                <br />
             
							    <%
					        }}else{
					        	%>
					        	 暂无更多图片
					        	<%
					        	
					        }
					    %>             	
              </div>
            </div>
          </div>
        </div>
      </div>
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
<!--foot end-->
<div style="display:none"> 
  <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
  <script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
    <!-- Baidu Button END --> 
  <div class="n_tools">
    <ul>
      <li class="nt02"><a href="#"><i></i><span class="te">客服：4006-521-526</span></a></li>
      <li class="nt03"><a href="http://product.21-sun.com/inquiry/"><i></i><span class="te">在线询价</span></a></li>
      <li class="nt04 bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"><span class="te">点击分享</span></a></li>
      <li class="nt05"><a href="javascript:void(0)" onclick="addUrl()"><i></i><span class="te">添加收藏</span></a></li>
      <li class="nt06"><a href="javascript:void(0);" class="gotop"><i></i><span class="te">返回顶部</span></a></li>
    </ul>
  </div>
  
 <script type="text/javascript">
	function showinquery(pid,agentid,factoryid){
	jQuery.jBox("iframe:/include/products/product_order_agent_used.jsp?productid="+pid+"&factoryid="+factoryid+"&agentid="+agentid+"&agentName=<%=CommonString.getFormatPara(map.get("name")) %>", {
	title: "在线询价",
	width: 720,
	height: 450,
	iframeScrolling : 'no',
	buttons: { '关闭': false }
	});
}
</script> 
  
  <script type="text/javascript">
 
function addUrl(){
	var url = window.location.href;
    try{
       window.external.addFavorite(url, '铁臂商城');
   }catch (e){
       try{
           window.sidebar.addPanel('铁臂商城',url,"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}

$('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});
</script>
  <div style="display:none"> 
    <script type="text/javascript">
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
	document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F2bbdb11527d93b69fad8795fbc9167ef' type='text/javascript'%3E%3C/script%3E"));
  </script> 
    <!-- <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> --> 
    <script src="http://s6.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
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
	//浏览次数增加、返回
 jQuery.ajax({
		url:"/action/ajax.jsp",
		type:"post",
		data:{"id":"<%=factoryid%>","flag":"viewCount","tableName":"pro_products_used"},
		success:function(data){
			jQuery("#viewCountId").html(jQuery.trim(data));	
		}
	})
</script> 
  <!-- Baidu Button BEGIN --> 
  <!--
<script type="text/javascript" src="http://pv.21-sun.com/http/stat.jsp"></script>
--> 
<!--foot end-->
<div style="display:none"> 
  <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> 
  <script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
</body>
<script type="text/javascript" src="/scripts/agent_banner.js"></script>
<script type="text/javascript" src="/scripts/citys.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript" src="/scripts/sslide.js"></script>
<script type="text/javascript">	
//二手新添加
jQuery("#rollBox").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"leftLoop",vis:4,scroll:1,autoPlay:false});
$(document).ready(function(){
    $("#list01 li").each(function(i){
       if( Math.floor(i/3)%2==0 ) {
       		$(this).addClass("gbg");
       };
    });
});
function showBigImg(src){
	jQuery("#mainImg").attr("src",src);
}
//二手新添加 end
	jQuery("#zd_message").text("您好，我对江西小松工程机械有限公司的产品感兴趣，想要咨询，请您给我回复，谢谢。");
function submitYN(event) {
	var mobile_phone_reg = /^1([\d]{10})$/;
	 var connect_reg=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	 // var connect_reg = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?|(0([\d]{10}))$/;
	var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	if (null == jQuery("#zd_name").val() || jQuery("#zd_name").val().length == 0) {
		jQuery.jBox.tip("请输入您的姓名!");
		setTimeout(function() {
			jQuery("#zd_name").focus();
		},
		0);
		return false;
	}
	if ((null == jQuery("#zd_mobile_phone").val() || jQuery("#zd_mobile_phone").val().length == 0)) {
		jQuery.jBox.tip("请输入您的手机或固定电话！");
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
		jQuery.jBox.tip("请输入正确的电话号码!");
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
   	setTimeout(function(){
		if(jQuery.trim(jQuery("#recommendPro ul").html())==''){	
			jQuery("#recommendProT").parent("div").remove() ;  // 如果没有推荐产品则隐藏推荐产品标题
		}
		},0) ;
})
jQuery("input:radio").bind("click",function(){
	jQuery("#zd_ifgroup").val(jQuery(this).val()) ;  // 个人或公司
	if(jQuery(this).val()=='公司'){
		jQuery("#zd_company").attr("style","width:150px;") ;
	}else{
		jQuery("#zd_company").attr("style","display:none;") ;
	}
}) ;

<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>
jQuery("#zd_company").focus(function(){
	if(jQuery(this).val()=='公司名字'){
	   jQuery(this).val("") ;
	}
})	
</script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
</html>