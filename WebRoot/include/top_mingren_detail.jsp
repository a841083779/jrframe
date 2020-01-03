<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*" pageEncoding="UTF-8"%>
<%
	String id = CommonString.getFormatPara(request.getParameter("id"));
%>
<div class="topLinks">
  <div class="contain980">
    <div class="visit_21sun"><a rel="nofollow" target="_blank" href="http://www.21-sun.com/" title="访问中国工程机械商贸网首页"><img src="/images/n_toppoint.gif" align="absmiddle" /> 访问中国工程机械商贸网首页</a></div>
    <ul class="tlRight">
      <li class="tl" onclick="addCookie();">加入收藏</li>
      <li class="tl" style="width:45px;" onclick="window.open('http://weixiu.21-sun.com/');">维修</li>
      <li class="tl" style="width:45px;"  onclick="window.open('http://koubei.21-sun.com/');">口碑</li>
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
      <li class="tl" style="width:63px; background:none; padding:4px 0px 0px 5px; height:24px">
        <iframe width="63" height="24" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" border="0" src="http://widget.weibo.com/relationship/followbutton.php?language=zh_cn&width=63&height=24&uid=1904756027&style=1&btn=red&dpc=1"></iframe>
      </li>
      <li class="tl" style="width:80px; background:none;"><a target="_blank" href="http://www.21-sun.com/weixin/"><img width="74" height="20" src="http://www.21-sun.com/weixin/images/weixin.jpg" style="margin-top:4px;" ></a></li>
    </ul>
  </div>
</div>
<div class="topbg mb10">
  <div class="top contain980">
    <div style="width: 205px; float: left; padding-top: 15px; padding-left: 9px;"> <a title="铁臂商城"  href="http://product.21-sun.com/" target="_blank"><img title="铁臂商城" src="/images/new_logo.png" alt="铁臂商城" width="220" height="72" /></a> </div>
    <div class="new_topMid">
      <ul class="news_topSearch">
        <li class="ntsi">
          <input type="text" name="keyword" id="keyword" maxlength="30" value="" onKeyDown="tj2();"/>
        </li>
        <li class="ntsb">
          <input type="submit" id="button" value="&nbsp;"  onclick="tj3();" />
        </li>
        <script>
		  function tj2(){
		  if((event.ctrlKey&&window.event.keyCode==13)||window.event.keyCode==13) {
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("http://product.21-sun.com/search/"+keyword+"_0_0_0.htm","target");
		  }
		  }
		  
		  		  		  function tj3(){
		
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("http://product.21-sun.com/search/"+keyword+"_0_0_0.htm","target");
		 
		  }
		</script>
        <input type="hidden" name="f" value="product" />
      </ul>
      <div class="hotWords">热门搜索： <a href="http://product.21-sun.com/search/挖掘机_0_0_0.htm" target="_blank"><b>挖掘机</b></a> <a href="http://product.21-sun.com/search/装载机_0_0_0.htm" target="_blank">装载机</a> <a href="http://product.21-sun.com/search/起重机_0_0_0.htm" target="_blank">起重机</a> <a class="link09"  href="http://product.21-sun.com/search/卡特彼勒挖机_0_0_0.htm" target="_blank"> 卡特彼勒挖机</a> </div>
    </div>
    <div class="topHot"> <img src="/images/tu5.gif" width="260" height="80" /> </div>
  </div>
  <div class="mingren_nav">
  	<ul class="np_fix contain980">
    	<li class="cur" id="top_1"><a href="/">首页</a></li>
        <li id="top_2"><a href="/mingren_detail_<%=id%>.htm">人物介绍</a></li>
        <li id="top_3"><a href="/mingren_fclist_<%=id%>.htm">人物风采</a></li>
        <li id="top_4"><a href="/mingren_ftdetail_<%=id%>.htm">人物访谈</a></li>
        <li id="top_5"><a target="_blank" href="/mingren_tpdetail_<%=id%>.htm">人物图片</a></li>
    </ul>
  </div>
</div>
<%
	String thisUrl = CommonString.getFormatPara(request.getRequestURI());
%>
<script language="javascript" type="text/javascript">
	var thisUrl = window.location.href;
	jQuery(".mingren_nav li").removeClass("cur");
	if(thisUrl.indexOf("/mingren_detail_") >= 0){
		jQuery("#top_2").addClass("cur");	
	}else if(thisUrl.indexOf("/mingren_fclist_") >= 0){
		jQuery("#top_3").addClass("cur");	
	}else if(thisUrl.indexOf("/mingren_ftdetail_") >= 0){
		jQuery("#top_4").addClass("cur");
	}else if(thisUrl.indexOf("/mingren_tpdetail_") >= 0){
		jQuery("#top_5").addClass("cur");	
	}else{
		jQuery("#top_1").addClass("cur");
	}
</script>