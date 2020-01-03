<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
    String id = CommonString.getFormatPara(request.getParameter("id")) ;
	
    String sel_sql = " select img2,flag,factoryid,pro_factoryid,description,pro_start_price,factorylogo,factoryname,pro_name,pro_cataname,pro_id,pro_ids from  pro_ymt_activity where id="+id ;
	
	DBHelper dbHelper = DBHelper.getInstance();
	
	Connection connection = null;
	Map one = null ;
   	// 获得地区
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

	one = dbHelper.getMap(sel_sql);
	//活动方信息
	String img="";  String flag="";  String agentid="";   String factoryid=""; String content=""; String logo="";String pro_type="";
	String factoryname="";  String pro_name="";  String pro_cataname=""; String pro_id="";  String pro_ids="";String page_hot_flag="";
	String whereStr="";String pro_start_price="";String img2="";
	if(one!=null)
	{
	    img = CommonString.getFormatPara(one.get("img")) ; 
		 img2 = CommonString.getFormatPara(one.get("img2")) ; 
		flag = CommonString.getFormatPara(one.get("flag")) ; 
		agentid = CommonString.getFormatPara(one.get("factoryid")) ;
		factoryid = CommonString.getFormatPara(one.get("pro_factoryid")) ;
        content = CommonString.getFormatPara(one.get("description")) ;
	    logo=CommonString.getFormatPara(one.get("factorylogo")) ;
		if(logo.indexOf("uploadfiles")==-1&&!logo.equals("")){logo="/uploadfiles/"+logo;}
		factoryname=CommonString.getFormatPara(one.get("factoryname")) ;
		pro_name=CommonString.getFormatPara(one.get("pro_name")) ;
		pro_cataname=CommonString.getFormatPara(one.get("pro_cataname")) ;
		pro_id=CommonString.getFormatPara(one.get("pro_id")) ;
		pro_ids=CommonString.getFormatPara(one.get("pro_ids"));
		page_hot_flag=CommonString.getFormatPara(one.get("page_hot_flag"));
		//单产品，多产品标志位
		pro_type=CommonString.getFormatPara(one.get("pro_type"));
		pro_start_price=CommonString.getFormatPara(one.get("pro_start_price"));
		
	}
	//力士德推荐
	String pro_names="";
	if(id.equals("127")){
	pro_names="SC60.8";
	}else if(id.equals("128")){
	pro_names="SC80.8";
	}
	//产品
	String sql=""; 
	if(!pro_names.equals("")){
	sql = "select  * from pro_products where  name like'%"+pro_names+"%' ";
	}else{
	sql = "select  * from pro_products where  name  like'%"+pro_name+"%' ";
	}
	Map products =  dbHelper.getMap(sql);
	String product_id="";String para="";String factoryids="";String catalognums="";String img3="";String introduce="";String paras="";
	if(products!=null){
	product_id=CommonString.getFormatPara(products.get("id"));
	factoryids=CommonString.getFormatPara(products.get("factoryid"));
	catalognums=CommonString.getFormatPara(products.get("catalognum"));
	img3=CommonString.getFormatPara(products.get(img3));
	introduce=CommonString.getFormatPara(products.get("introduce"));
	paras=CommonString.getFormatPara(products.get("paras"));
	}
	//口碑
	List<Map> koubei = dbHelper.getMapList(" select * from pro_comments where product_id ='"+product_id+"'");
	
	
	//图籍
	List<Map> images = dbHelper.getMapList(" select * from pro_tuan_photo where group_id ='"+id+"'");
	

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=factoryname%><%=pro_name%><%=pro_cataname%> – 优买团</title>
<meta name="keywords" content="<%=factoryname%><%=pro_name%><%=pro_cataname%>促销" />
<meta name="description" content="铁臂商城旗下优买团为您提供<%=factoryname%><%=pro_name%><%=pro_cataname%>优惠促销, <%=factoryname%><%=pro_name%><%=pro_cataname%>促销最低价.找<%=factoryname%><%=pro_name%><%=pro_cataname%>优惠促销活动就上优买团!" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.ee'); 
</script>
<![endif]-->
</head>
<body style="background-color:#f0f0f0;">
<jsp:include page="/tuan/top_index.jsp" flush="true"/>
<div class="nav">
	<ul class="wrap">
    	<li><a href="index.jsp">首页</a></li>
        <li><a href="index.jsp?catalog=101001">挖掘机</a></li>
        <li><a href="index.jsp?catalog=101002">装载机</a></li>
        <li><a href="part.jsp">配件</a></li>
        <li><a href="index.jsp?catalog=113001">破碎锤</a></li>
        <li><a href="index.jsp?catalog=other">其他设备</a></li>
        <li><a href="http://koubei.21-sun.com" target="_blank">铁臂口碑</a></li>
        <li><a href="activity.jsp">专题活动</a></li>
    </ul>
</div>
<div class="wrap clearfix cx_top">
  <div class="cx_top_t">
    <h2 class="company_name"><span class="brands"><%if(!logo.equals("")){%><img src="http://product.21-sun.com/<%=logo%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/><%}%></span>力士德工程机械股份有限公司</h2>
    <div class="clearfix">
      <div class="bigImg"><img src='http://product.21-sun.com/uploadfiles/<%=img2%>' /><i class="tag">抢购</i></div>
      <div class="cx_info">
        <h1 class="name"><%=factoryname%><%=pro_name%><%=pro_cataname%></h1>
        <div class="zc"><%=content%></div>
        <div class="price">
          <div class="box"><em>&yen;</em><%=pro_start_price%>万元<a href="javascript:;" onclick="showinquery('<%=product_id %>','')" title="立即订购" class="btn">立即订购</a></div>
        </div>
        <div class="tel"><img src="images/tel.png" />客服热线：<span>4006-521-526</span></div>
		<%
		if(id.equals("127")||id.equals("128")){
		%>
        <div class="info"><span>品牌：力士德</span>　　<span>类别：挖掘机</span></div>
		<%}else{%>
		  <div class="info"><span>品牌：<%=factoryname%></span><span>类别：<%=pro_cataname%></span></div>
		<%}%>
        <div class="tools">
          <span class="share bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></span>
          <span class="mark"><img src="images/like.png" width="20" height="20" />加入收藏</span>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="wrap clearfix cx_main">
  <div class="cx_tab">
    <ul class="clearfix idTabs">
	<li><a href="#cx01" class="selected">产品详情<i></i></a></li> 
     <li><a href="#cx02">产品口碑<i></i></a></li>
    </ul>
  </div>
  <div class="cx_contain">
    <div class="tab_con" id="cx01">
     <%=paras%>
	 <%if(!introduce.equals("")){%>
      <div class="text">性能：<br />
       <%=introduce%></div>
    </div><%}%>
    <div class="tab_con" id="cx02">
     
	  <div class="plList nkb_pro_list np_fix nkb_det_top mb10">
        <div class="np_fix nkb_other_t">
          <div class="r other_more"><a title="更多口碑" target="_blank" href="http://product.21-sun.com/activity/koubei/index.jsp" target="_blank">更多&gt;&gt;</a></div>
        </div>
		<%
		for(int i=0;i<(koubei.size()>5?5:koubei.size());i++){
		 int score1 = Integer.parseInt(CommonString.getFormatPara(koubei.get(i).get("score1")));
		int score2 = Integer.parseInt(CommonString.getFormatPara(koubei.get(i).get("score2")));
		int score3 = Integer.parseInt(CommonString.getFormatPara(koubei.get(i).get("score3")));
		int score4 = Integer.parseInt(CommonString.getFormatPara(koubei.get(i).get("score4")));
		int score = (score1+score2+score3 +score4)/4;
		String add_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm", CommonString.getFormatPara(koubei.get(i).get("add_date")));
		String contents=CommonString.getFormatPara(koubei.get(i).get("content"));
		contents=contents.replaceAll("<\\s*img\\s+([^>]*)\\s*>","");
		contents = contents.replaceAll("&nbsp;","");
		contents = contents.replaceAll("<[^<|^>]+>","");
		
		String username=CommonString.getFormatPara(koubei.get(i).get("username"));
		if(username.equals("")){
		username=CommonString.getFormatPara(koubei.get(i).get("name"));
		}
		%>
        <ul>
          <li>
           <!-- <div class="l">
              <div class="plimg"> <a title="#"> <img title="" alt="" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" src="/uploadfiles/no_big.gif"> </a> </div>
            </div>-->
            <div class="content">
              <div class="np_fix"> <span style="font-weight:bold;" class="plname"><%=username%></span> <span class="time"><%=add_date%></span> </div>
              <br>
              <div class="w100 np_fix">
			  <%
			  if(!content.equals("")){
			  %>
                <p class="textContent"><%=content%><a href="http://koubei.21-sun.com/detail/<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>.htm" target="_blank">查看全文&gt;&gt;</a></p><%}%>
                <div class="r plt">网友平均评分 <font><%=score%></font> 分</div>
              </div>
              <div class="n_kb_add_pf">
                <p class="pftitle">网友评分</p>
                <ul class="np_fix nkb_pflist np_fix">
                  <li><span class="nkb_pfwz">价格：</span>
                    <div title="regular" id="pricescore_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>"></div>
                    <span class="nkb_pffs"><%=CommonString.getFormatPara(koubei.get(i).get("score1"))%>分</span></li>
                  <li><span class="nkb_pfwz">性能：</span>
                    <div title="regular" id="abilityscore_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>"></div>
                    <span class="nkb_pffs"><%=CommonString.getFormatPara(koubei.get(i).get("score2"))%>分</span></li>
                  <li><span class="nkb_pfwz">质量：</span>
                    <div title="regular" id="qualityscore_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>"></div>
                    <span class="nkb_pffs"> <%=CommonString.getFormatPara(koubei.get(i).get("score3"))%>分</span></li>
                  <li><span class="nkb_pfwz">售后：</span>
                    <div id="servicescore_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>"></div>
                    <span class="nkb_pffs"><%=CommonString.getFormatPara(koubei.get(i).get("score4"))%>分</span></li>
                </ul>
              </div>
			<script language="javascript" type="text/javascript">
	            var s1_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%> = (parseInt(<%=CommonString.getFormatPara(koubei.get(i).get("score1"))%>,10)/20);
	  			var s2_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%> = (parseInt(<%=CommonString.getFormatPara(koubei.get(i).get("score2"))%>,10)/20);
	  			var s3_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%> = (parseInt(<%=CommonString.getFormatPara(koubei.get(i).get("score3"))%>,10)/20);
	  			var s4_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%> = (parseInt(<%=CommonString.getFormatPara(koubei.get(i).get("score4"))%>,10)/20);

	            //获得评论分数
	          	jQuery("#pricescore_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>").raty({
	          		path: "/tuan/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s1_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>
	          	});
	          	jQuery("#abilityscore_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>").raty({
	          		path: "/tuan/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s2_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>
	          	});
	          	jQuery("#qualityscore_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>").raty({
	          		path: "/tuan/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s3_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>
	          	});
	          	jQuery("#servicescore_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>").raty({
	          		path: "/tuan/img", //图片路径  
	          		half : true ,
	          		readOnly : true,
	          		score : s4_<%=CommonString.getFormatPara(koubei.get(i).get("id"))%>
	          	});
              </script>
              </script>

              <div class="nkb_moregg"><span><a href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factoryids%>"target="_blank" title="<%=CommonString.getFormatPara(products.get("factoryname"))%>"> <%=CommonString.getFormatPara(products.get("factoryname"))%></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factoryids%>&catalog=<%=catalognums%>" target="_blank" title="<%=CommonString.getFormatPara(products.get("catalogname"))%>"><%=CommonString.getFormatPara(products.get("catalogname"))%></a></span>&nbsp;&nbsp;|&nbsp;&nbsp;<a title="更多<%=CommonString.getFormatPara(products.get("factoryname"))%>口碑" target="_blank" href="http://koubei.21-sun.com/0-<%=factoryids%>-0-0-0.htm">更多<%=CommonString.getFormatPara(products.get("factoryname"))%>口碑</a></div>
            </div>
          </li>
        </ul>
      <%}%>
      </div>
	 
	 
    </div>
  </div>
  
  <div class="cx_img">
    <div class="hd">
      <h3>产品图片</h3>
    </div>
	<div class="bd">
	<% for(int i=0;i<images.size();i++){
     String imgs=CommonString.getFormatPara(images.get(i).get("image"));%>
    <img src="http://product.21-sun.com/uploadfiles<%=imgs%>" width="920" height="700" />
  <%}%>
  </div></div>
  
</div>
</div>
<div class="bottom">
	<div class="wrap">
	<span class="l">中国工程机械商贸网 Copyright © 2000-2014 </span>	
    <div class="r">客服：9:00-21:00<em>|</em>4006-521-526</div>
    </div>
 </div>
 <script type="text/javascript" src="scripts/comm.js"></script> 
 <div class="n_tools">
  <ul>
    <li class="nt06"><a href="javascript:void(0);" class="gotop"><i></i><span class="te">返回顶部</span></a></li>
  </ul>
</div>

</body>
<script type="text/javascript" src="/scripts/idTabs.js"></script>
<script type="text/javascript">
$('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});
//百度分享
window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>
</html>