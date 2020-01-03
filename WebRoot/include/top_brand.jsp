<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String facSql = "select top 1 logo,full_name,name,usern,introduce,view_count  from pro_agent_factory where flag=1 and id="+factoryid;
	Map facMap = dbHelper.getMap(facSql);
	String full_name = "";
	String logo = "";
	if(facMap!=null && facMap.size()>0){
		full_name = CommonString.getFormatPara(facMap.get("full_name"));
		logo = CommonString.getFormatPara(facMap.get("logo"));
	}
%>
<div class="topLinks n_pp_top">
  <div class="contain980">
    <div class="visit_21sun"><a href="/"><img src="/images/new_pro/np_pplogo.png" width="124" height="36" class="png" alt="铁臂商城"/></a></div>
    <ul class="tlRight">
      <li class="tl" onclick="addCookie();">加入收藏</li>
	  <li class="tl" style="width:45px;" onclick="window.open('http://weixiu.21-sun.com/');">维修</li>
	  <li class="tl" style="width:45px;" onclick="window.open('http://koubei.21-sun.com/');">口碑</li>
      <li class="tl" onclick="window.open('http://aboutus.21-sun.com/contact/');">客服中心</li>
      <li class="guide"><span class="gt">网站导航</span>
        <ul>
          <li onclick="window.open('http://product.21-sun.com/');">铁臂商城</li>
          <li onclick="window.open('http://photo.21-sun.com/');">产品图库</li> 
          <li onclick="window.open('http://weixiu.21-sun.com/');">维　　修</li>
          <li onclick="window.open('http://koubei.21-sun.com/');">口　　碑</li>
          <li onclick="window.open('http://market.21-sun.com/');">供求市场</li>
		  <li onclick="window.open('http://news.21-sun.com/');">行业动态</li>  
          <li onclick="window.open('http://used.21-sun.com/');">二手设备</li>
          <li onclick="window.open('http://www.21-sun.com/part/');">配件市场</li>
		  <li onclick="window.open('http://www.21part.com/');">杰 配 网</li>
		  <li onclick="window.open('http://www.21-sun.com/supply/');">供 应 商</li>
          <li onclick="window.open('http://www.21taiyang.com/');">太阳商城</li>
          <li onclick="window.open('http://www.wajueji.com/');">铁臂兄弟连</li>
        </ul>
      </li>
      <li class="tl" style="width:63px; background:none; padding:7px 0px 0px 5px; height:24px"><iframe width="63" height="24" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" border="0" src="http://widget.weibo.com/relationship/followbutton.php?language=zh_cn&amp;width=63&amp;height=24&amp;uid=1904756027&amp;style=1&amp;btn=red&amp;dpc=1"></iframe></li>
      <li class="tl" style="width:80px; background:none;"><a target="_blank" href="http://www.21-sun.com/weixin/"><img width="74" height="20" src="http://www.21-sun.com/weixin/images/weixin.jpg" style="margin-top:8px;"></a></li>
    </ul>
  </div>
</div>
<div class="contain980 n_pp_logo np_fix">
	<div class="l npp_logoimg"><img src="/uploadfiles/<%=logo %>" width="120" height="50" alt="<%=full_name %>"/></div>
    <div class="l npp_logoname">
    	<p class="pp_ch"><%=full_name %></p>
        <!-- <p class="pp_en">SANY Heavy Industry Co.,Ltd.</p> -->
    </div>
</div>