<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	String id = CommonString.getFormatPara(request.getParameter("id")) ;  
	String sel_sql = " select title,pub_date,content from pro_agent_news where id=?" ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map news_info = null ;
	if(!"".equals(id)){
		news_info = dbHelper.getMap(sel_sql,new Object[]{id}) ;
	}
	if(null==news_info || news_info.size()<=0){
		response.sendRedirect("product.21-sun.com/agent/") ;
	}
	String contents=CommonString.getFormatPara(news_info.get("content"));
	if(contents.length()>150){contents=contents.substring(0,150)+"...";}
%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=news_info.get("title") %></title>
<meta name="keywords" content="企业动态,活动推荐,工程机械图片,工程机械产品动态,工程机械铁臂商城" />
<meta name="description" content="<%=contents%>" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" />
<link href="http://product.21-sun.com/dealer/style/style.css" rel="stylesheet" />
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery.min.js"></script>
<script type="text/javascript">
//导航选中状态
var jrChannel='1#0'
</script>
</head>
<body>
<!--top-->
<jsp:include page="include/top.jsp" flush="true" />
<!--top end-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂商城代理商平台 </a> &gt;&gt; <a href="news.jsp">代理商热点</a> &gt;&gt;  <%=news_info.get("title") %></h3>
</div>
<div class="contain980 fix mb10">
  <div class="left01">
    
    <div class="listleft02_1">
      <div class="listtitle01_1">
        <h1><%=news_info.get("title") %></h1>
      </div>
      <div class="listtitle03_2">
        <font class="font08">发布时间:<%=CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(news_info.get("pub_date"))) %>  <span style="display:none">&nbsp;&nbsp;&nbsp;&nbsp;来源:中国证券报</span></font>
        <font style="font-size:12px">【字号：<a href="javascript:SetFontSize(16)" class="pl">大</a>&nbsp;<a href="javascript:SetFontSize(14)" >中</a>&nbsp;<a href="javascript:SetFontSize(12)" class="pl">小</a>】</font> 
      </div>
      <div class="detail" id="mainDetail">
	   <%=CommonString.getFormatPara(news_info.get("content")) %>
        <div class="listfoot01"> <a href="/">返回首页</a></div>
        <!-- JiaThis Button BEGIN -->
        <div style="width:240px;height:30px;padding:15px 0 5px 0px; float:left;">
          <div id="ckepop"><span class="jiathis_txt">分享到：</span> <a class="jiathis_button_tsina"></a> <a class="jiathis_button_tqq"></a> <a class="jiathis_button_weixin"></a> <a class="jiathis_button_qzone"></a> <a class="jiathis_button_xiaoyou"></a> <a class="jiathis_button_t163"></a> <a class="jiathis_button_baidu"></a> <a href="http://www.jiathis.com/share?uid=1554525" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a> 
            <!--<a class="jiathis_counter_style"></a>--> 
          </div>
        </div>
        <script type="text/javascript" >
		var jiathis_config={
		data_track_clickback:true,
		summary:" ",
		ralateuid:{
		"tsina":"1904756027"
		},
		appkey:{
		"tsina":"709719509"
		},
		hideMore:false
		}
		</script> 
        <script type="text/javascript" src="http://v2.jiathis.com/code/jia.js?uid=1554525" charset="utf-8"></script> 
        <!-- JiaThis Button END -->
        
        <div class="detail_news_keywords" style="display:none">
          <div id="mark_old">
          关键词：<a href="javascript:searchAction('融资租赁');" class="link06">融资租赁</a>&nbsp;
          <a href="javascript:searchAction('发展');" class="link06">发展</a>&nbsp;
          <a href="javascript:searchAction('掣肘');" class="link06">掣肘</a>&nbsp;
          </div>
        </div>
      </div>
      <div class="listfoot02">
        <div style="float:right;width:55%;height:29px;line-height:29px">【<img src="http://product.21-sun.com/dealer/images/tb01.gif" width="18" height="11" /><a href="javascript:storePage();" class="pl">收藏此页</a>】【<img src="http://product.21-sun.com/dealer/images/tb03.gif" width="16" height="12" /><a href="Javascript:window.print();" >打印</a>】【<img src="http://product.21-sun.com/dealer/images/tb04.gif" width="12" height="9" /><a href="javascript:window.close()">关闭</a>】 </div>
      </div>
      
      <div>
        <div class="redian-title00">
          <div class="title3">相关动态</div>
        </div>
        <div class="listnews001">
          <ul class="qushitext">
		      <jsp:include page="/include/agent_new/related_news.jsp" flush="true" />
          </ul>
        </div>
      </div>
    </div>
    
  </div>
  <div class="right01">
  
    <div class="comBox01 fix mb10 ag_city">
      <div class="hd fix">
        <h3>按地区浏览</h3>
        <span class="more"><a href="/area/" title="更多其他地域代理商">更多&gt;&gt;</a></span>
      </div>
      <div class="bd fix">
        <ul class="city_list">
          <li><a target="_blank" href="/101_0_0_0_0.shtm" title="北京">北京</a></li>
          <li><a target="_blank" href="/103_0_0_0_0.shtm" title="上海">上海</a></li>
          <li><a target="_blank" href="/112_112002_0_0_0.shtm" title="广州">广州</a></li>
          <li><a target="_blank" href="/102_0_0_0_0.shtm" title="天津">天津</a></li>
          <li><a target="_blank" href="/110_110001_0_0_0.shtm" title="杭州">杭州</a></li>
          <li><a target="_blank" href="/112_112001_0_0_0.shtm" title="深圳">深圳</a></li>
          <li><a target="_blank" href="/105_105001_0_0_0.shtm" title="济南">济南</a></li>
          <li><a target="_blank" href="/109_109001_0_0_0.shtm" title="南京">南京</a></li>
          <li><a target="_blank" href="/113_113001_0_0_0.shtm" title="福州">福州</a></li>
          <li><a target="_blank" href="/105_105002_0_0_0.shtm" title="青岛">青岛</a></li>
          <li><a target="_blank" href="/109_109002_0_0_0.shtm" title="苏州">苏州</a></li>
          <li><a target="_blank" href="/112_112006_0_0_0.shtm" title="东莞">东莞</a></li>
          <li><a target="_blank" href="/107_107001_0_0_0.shtm" title="太原">太原</a></li>
          <li><a target="_blank" href="/110_110002_0_0_0.shtm" title="宁波">宁波</a></li>
          <li><a target="_blank" href="/112_112007_0_0_0.shtm" title="佛山">佛山</a></li>
          <li><a target="_blank" href="/106_106001_0_0_0.shtm" title="石家庄">石家庄</a></li>
          <li><a target="_blank" href="/111_111001_0_0_0.shtm" title="合肥">合肥</a></li>
          <li><a target="_blank" href="/115_115001_0_0_0.shtm" title="南昌">南昌</a></li>
          <li><a target="_blank" href="/121_121002_0_0_0.shtm" title="长春">长春</a></li>
          <li><a target="_blank" href="/123_123001_0_0_0.shtm" title="成都">成都</a></li>
          <li><a target="_blank" href="/117_117001_0_0_0.shtm" title="郑州">郑州</a></li>
          <li><a target="_blank" href="/120_120001_0_0_0.shtm" title="沈阳">沈阳</a></li>
          <li><a target="_blank" href="/104_0_0_0_0.shtm" title="重庆">重庆</a></li>
          <li><a target="_blank" href="/118_118001_0_0_0.shtm" title="武汉">武汉</a></li>
          <li><a target="_blank" href="/122_122001_0_0_0.shtm" title="哈尔滨">哈尔滨</a></li>
          <li><a target="_blank" href="/127_127001_0_0_0.shtm" title="西安">西安</a></li>
          <li><a target="_blank" href="/119_119001_0_0_0.shtm" title="长沙">长沙</a></li>
          <li><a target="_blank" href="/120_120002_0_0_0.shtm" title="大连">大连</a></li>
          <li><a target="_blank" href="/125_125001_0_0_0.shtm" title="昆明">昆明</a></li>
          <li><a target="_blank" href="/108_108001_0_0_0.shtm" title="呼和浩特">呼和浩特</a></li>
        </ul>
      </div>
    </div>
    
    <div class="comBox01 fix ag_rec mb10">
      <div class="hd fix">
        <h3>推荐代理商</h3>
        <span class="more"><a title="更多推荐代理商" href="/0_0_0_0_0.shtm">更多&gt;&gt;</a></span>
      </div>
      <div class="bd fix">
        <ul class="comList">
		 <jsp:include page="/include/agent_new/rec_agent.jsp" flush="true" />
        </ul>
      </div>
    </div>
    
    <div class="comBox01 fix ag_brands mb10">
      <div class="hd fix">
        <h3>代理品牌</h3>
        <span class="more"><a title="更多代理品牌" href="/brand/">更多&gt;&gt;</a></span>
      </div>
      <div class="bd fix">
        <ul class="comList">
          <li><a href="/0_0_133_0_0.shtm" title="三一代理商">三一</a></li>
          <li><a href="/0_0_134_0_0.shtm" title="中联重科代理商">中联重科</a></li>
          <li><a href="/0_0_174_0_0.shtm" title="卡特彼勒代理商">卡特彼勒</a></li>
          <li><a href="/0_0_152_0_0.shtm" title="山重建机代理商">山重建机</a></li>
          <li><a href="/0_0_137_0_0.shtm" title="临工代理商">临工</a></li>
          <li><a href="/0_0_135_0_0.shtm" title="龙工代理商">龙工</a></li>
          <li><a href="/0_0_141_0_0.shtm" title="福田雷沃代理商">福田雷沃</a></li>
          <li><a href="/0_0_183_0_0.shtm" title="神钢代理商">神钢</a></li>
        </ul>  
      </div>
    </div>
    
    <div class="comBox01 fix mb10">
	  <div class="hd fix">
        <h3>代理机型</h3>
        <span class="more"><a title="更多代理机型" href="/model/">更多&gt;&gt;</a></span>
      </div>
      <div class="bd fix">
        <ul class="comList01">
		     <jsp:include page="/include/agent_new/hot_wajueji.jsp" flush="true" />
        </ul>  
      </div>
    </div>
    
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