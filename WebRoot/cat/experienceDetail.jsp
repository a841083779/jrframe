<%@ page language="java" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.dbutil.DBHelper,com.jerehnet.util.common.CommonString,java.util.*" pageEncoding="UTF-8"%>
<% 
	String id = CommonString.getFormatPara(request.getParameter("id"));
	DBHelper dbHelper = DBHelper.getInstance() ;
	String agentId = "174";//卡特
	Map newsMap = null;
	String title = "";
	String content = "";
	if(id!=null && !id.equals("")){
		//新闻与活动
		newsMap = dbHelper.getMap(" select top 1 id,title,content from pro_agent_news where agent_id=? and id=? order by pub_date desc,id desc",new Object[]{agentId,id}) ;
		if(newsMap == null){
			response.setStatus(301);
			response.setHeader("Location", "/cat/"); 
			return;	
		}else{
			title = CommonString.getFormatPara(newsMap.get("title"));
			content = CommonString.getFormatPara(newsMap.get("content"));
		}
	}else{
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		Common.doForward(request,response,"/404.htm");
	}
							
	
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=title %>-卡特彼勒公司旗下挖掘机价格查询中心，卡特挖掘机电商平台，最新卡特挖机报价【Cat电商平台】</title>
<meta name="Keywords" content="卡特挖机,卡特挖掘机,卡特彼勒公司,卡特电子商务平台 cat电商平台,挖掘机价格,挖掘机报价,挖机价格,挖机报价,挖掘机" />
<meta name="Description" content="卡特挖掘机电商平台是世界最大的挖掘机生产厂家之一卡特彼勒公司旗下的Cat电商平台卡特挖掘机价格查询中心。了解最新卡特挖机报价相关信息登录卡特挖掘机电商平台。" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="scripts/jquery.SuperSlide.js"></script>
<script src="scripts/tabs.js" type="text/javascript"></script>
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.png'); 
</script>
<![endif]-->
</head>
<body class="experience">

<!--top--begin-->
<div class="top">
	<div class="wrap ex_tit">Cat<sup>&reg;</sup>（卡特）挖掘机使用体验</div>
</div>
<jsp:include page="include/nav.jsp" flush="true"></jsp:include>
<!--top--end-->

<div class="wrap con">
  <div class="ex_paper">
    	<h3><%=title %></h3>
        <div class="clearfix bb">
        	<span class="date">发布日期：2014-01-22</span>
            <div class="share">
           <!-- JiaThis Button BEGIN -->
            <div class="jiathis_style">
                <span class="jiathis_txt">分享：</span>
                <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
            </div>
            <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=undefined" charset="utf-8"></script>
            <!-- JiaThis Button END -->
            </div>
            <a href="javascript://void(0);" onclick="AddFavorite('<%=title %>-卡特彼勒公司旗下挖掘机价格查询中心，卡特挖掘机电商平台，最新卡特挖机报价【Cat电商平台】');" class="collect">加入收藏</a>
            <a href="experience.jsp" class="back">返回首页</a>
        </div>
        
    </div>
  	<div class="ex_content">
    	<%=content %>
    </div>
	
   	<!--foot--begin-->
<div class="New_foot ex_foot">
  Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script>
	<span class="New_links" onclick="window.open('http://www.21-sun.com');">中国工程机械商贸网</span> | 制作维护
  </div>
  <div style="display:none;">
  <script src="http://s13.cnzz.com/stat.php?id=5804868&web_id=5804868" language="JavaScript"></script>
  <script src="http://s13.cnzz.com/stat.php?id=5786967&web_id=5786967" language="JavaScript"></script>
  <script src="http://s85.cnzz.com/stat.php?id=5100957&web_id=5100957" language="JavaScript"></script>
  </div>
	<!--foot--end-->
</div>
<div id="topcontrol" style="position: fixed; bottom: 15px; right: 13.75px; opacity: 1; cursor: pointer; z-index: 1000; display: block;" title="返回顶部"><img onmouseout="this.src='images/back_top.gif'" onmouseover="this.src='images/back_top_hover.gif'" style="width:60px; height:60px" src="images/back_top.gif"></div>

<script type="text/javascript" src="scripts/comm.js"></script> 
<script type="text/javascript">
jQuery(".leftLoop").slide({ titCell:".hd ul",mainCell:".bd ul",effect:"leftLoop",vis:5,scroll:1,autoPage:false,autoPlay:true,delayTime:1000});
//收藏本站
function AddFavorite(title) {
	url = window.location.href;
    try {
        window.external.addFavorite(url, title);
    }
    catch (e) {
        try {
            window.sidebar.addPanel(title, url, "");
        }
        catch (e) {
            alert("抱歉，您所使用的浏览器无法完成此操作。\n\n加入收藏失败，请使用Ctrl+D进行添加");
        }
    }
}
</script>
<script type="text/javascript" src="scripts/jr_top.js"></script>
<script type="text/javascript">
jQuery.JrTop({
	left : 550
});
</script>
<script>
    var ref = ''; 
    if (document.referrer.length > 0) { 
        ref = document.referrer; 
    } 
    try { 
       if (ref.length == 0 && opener.location.href.length > 0) { 
       ref = opener.location.href; 
        } 
    }catch (e) {}
   	jQuery.ajax({
    	type:'post',
    	url:'ajax.jsp',
    	data:{flag:'visitHistory',ref:ref} ,
    	success:function(msg){
    	}
    });
</script>
</body>
</html>