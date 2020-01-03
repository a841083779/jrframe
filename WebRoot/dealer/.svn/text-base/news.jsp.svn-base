<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	DBHelper dbHelper = DBHelper.getInstance();
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String url = CommonString.getFormatPara(request.getQueryString());
	if (!"".equals(url)) {
			if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
				url = "";
			} else if (url.indexOf("offset") != -1) {
				url = "&" + url.substring(url.indexOf("&") + 1);
			} else {
				url = "&" + url;
			}
	}
	Connection connection = null;
	try{
	    StringBuffer whereStr = new StringBuffer(" and is_approval=1");
		connection = dbHelper.getConnection();
		PageBean pageBean = new PageBean(); // 分页程序
		pageBean.setPageSize(25); // 每页显示条数
		pageBean.setCondition(whereStr.toString());
		pageBean.setParams(url);
		pageBean.setIsShowSql(false);
		pageBean.setFields(" id,title,pub_date ");
		pageBean.setTableName("pro_agent_news");
		pageBean.setOrderBy(" pub_date desc") ;

		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
		pageBean.setNowPage(nowPage);
%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>工程机械代理商热点_工程机械代理商动态 – 铁臂商城代理商平台</title>
<meta name="keywords" content="工程机械代理商热点,工程机械代理商动态" />
<meta name="description" content="工程机械代理商热点栏目专业提供工程机械代理商热点动态，工程机械代理商热点新闻等工程机械代理商信息，买工程机械就上铁臂商城。" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<link href="http://product.21-sun.com//style/style.css" rel="stylesheet" />
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
  <h3 class="breadCrumbs"><a href="/">铁臂商城代理商平台</a> &gt;&gt;  代理商热点</h3>
</div>
<div class="contain980 fix mb10">
  <div class="left01">
        <%List<Map> newsList = pageBean.getDatas(connection); %>
    <div class="newsList">
      <div class="hd">
        <h1 style="font-size: 20px;color: #204c89;font-weight: normal;font-family: 'Microsoft Yahei';width: auto;float: left;">代理商热点</h1>
      </div>
      <div class="bd">
        <ul class="list">
		 <%	
			    int i=1;
				if (newsList != null && newsList.size() > 0) {
					for (Map oneMap : newsList) {
			%>
          <li>
            <h3><a target="_blank" title="<%=CommonString.getFormatPara(oneMap.get("title")) %>" href="/news_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm"><%=CommonString.getFormatPara(oneMap.get("title")) %></a></h3>
            <span class="time"><%= CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(oneMap.get("pub_date")))%></span>
          </li>
		  <%if(i%5==0){%><li class="line"></li><%}%>
		  <%i++;}}%> 
        </ul>
        
        <div class="comPage">
          <div class="page" id="pagination">
		  
             <tags:agent_news pageBean="<%=pageBean%>" />
         
		 </div>
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
        <span class="more"><a href="/0_0_0_0_0.shtm" title="更多推荐代理商">更多&gt;&gt;</a></span>
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
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>