<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%
String type = CommonString.getFormatPara(request.getParameter("type"));
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";
	String password="";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
		password=CommonString.getFormatPara(memberInfo.get("password"));
	}


%>
<div class="topLinks">
  <div class="contain980" >
    <div class="visit_21sun" style="margin-right: 20px;"><a rel="nofollow" target="_blank" href="http://www.21-sun.com/" title="访问中国工程机械商贸网首页"><img src="/images/n_toppoint.gif" align="absmiddle" /> 访问中国工程机械商贸网首页</a></div>
	 <%if(username.equals("")){%>
     <div class="t_login">	
	   <strong class="ln">用户名</strong>
       <span class="lp"><input type="text" name="username" id="username" class="input" /></span>
       <strong class="ln">密　码</strong>
       <span class="lp"><input type="password" name="password" id="password" class="input" onKeyDown="if(event.keyCode==13){doLogin();}" /></span>
       <a href="javascript:void(0)"  onclick="doLogin();"  class="loginBtn">登录</a> <a target="_blank" href="/photo_domain/register.jsp">注册</a>
    </div>
	<%}else{%>
	 
    	<div style="float: left;line-height: 31px;">欢迎您，<a  href="javascript:void(0)"  onclick="goTO();" ><%=username %></a>！<a  href="javascript:void(0)" onclick="goTO();"><span style="color:red">个人中心</span></a>  <a href="javascript:void(0);" onclick="loginOut()">【退出】</a></div>
  
	<%}%>
    <ul class="tlRight">
      <li class="tl" onclick="addCookie();">加入收藏</li>
      <li class="tl" style="width:45px;" onclick="window.open('http://weixiu.21-sun.com/');">维修</li>
      <li class="tl" style="width:45px;"  onclick="window.open('http://koubei.21-sun.com/');">口碑</li>
      <li class="tl" onclick="window.open('http://aboutus.21-sun.com/contact/');">客服中心</li>
      <li class="guide"><span class="gt">网站导航</span>
        <ul>
          <li onclick="window.open('http://product.21-sun.com/');">铁臂商城</li>
          <li onclick="window.open('http:/.21-sun.com/');">产品图库</li>
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
    <div style="width: 205px; float: left; padding-top: 15px; padding-left: 9px;"> <a title="铁臂商城"  href="http://product.21-sun.com/"><img title="铁臂商城" src="/images/new_logo.png" alt="铁臂商城" width="220" height="72" /></a> </div>
    <div class="new_topMid">
      <ul class="news_topSearch">
        <li class="ntsi">
          <input type="text" name="keyword" id="keyword" maxlength="30" value="" onKeyDown="tj2();"/>
        </li>
        <li class="ntsb">
          <input type="submit" id="button" value="&nbsp;"  onclick="tj3();" />
        </li>
        <script>
		
		function goTO(){
        window.open("http://product.21-sun.com/member/index.jsp?usernn=<%=username%>&password=<%=password%>");
        }
		
		  function tj2(){
		  if((event.ctrlKey&&window.event.keyCode==13)||window.event.keyCode==13) {
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("/"+keyword+"_0_0_0_0.htm","target");
		  }
		  }
		  
		  		  		  function tj3(){
		
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("/"+keyword+"_0_0_0_0.htm","target");
		 
		  }
		  
		  function doLogin(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=login&r='+new Date()+'&u='+encodeURI(jQuery("#username").val())+'&p='+encodeURI(jQuery("#password").val()),
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("登录成功！");
				setTimeout("parent.window.location.reload()",1000);
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("用户名或密码错误！");
			}
		}
	});
}

function loginOut(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=logout',
		async:false,
		cache:false,
		success:function(data){
				jQuery.jBox.tip("退出成功！");
				setTimeout("parent.window.location.reload()",1000);
		}
	});
}
		</script>
        <input type="hidden" name="f" value="product" />
      </ul>
      <div class="hotWords">热门搜索：
	  <a href="/挖掘机_0_0_0_0.htm" target="_blank"><b>挖掘机</b></a> 
	  <a href="/装载机_0_0_0_0.htm" target="_blank">装载机</a>
	  <a href="/起重机_0_0_0_0.htm" target="_blank">起重机</a> 
	  <a class="link09"  href="/卡特彼勒挖机_0_0_0_0.htm" target="_blank"> 卡特彼勒挖机</a>
	  </div>
    </div>
    <div class="topHot"> <img src="/images/tu5.gif" width="260" height="80" /> </div>
  </div>
  <div class="contain980 photo_nav">
  	<ul class="np_fix">
    	<li <% if(type.equals("")){ %>class="cur"<%} %>><a href="/">首页</a></li>
    	<li <% if(type.equals("107002")){ %>class="cur"<%} %>><a href="/pro_index.htm ">产品图片</a></li>
        <li <% if(type.equals("107001")){ %>class="cur"<%} %>><a href="/nlist_0_0_107001_0.htm">行业图片</a></li>
        <li <% if(type.equals("107003")){ %>class="cur"<%} %>><a href="/other_0_0_107003_0.htm">施工图片</a></li>
        <li <% if(type.equals("107004")){ %>class="cur"<%} %>><a href="/other_0_0_107004_0.htm">维修图片</a></li>
        <li <% if(type.equals("107005")){ %>class="cur"<%} %>><a href="/zhanhui_0_0_0_107005_0.htm">展会图片</a></li>
        <li <% if(type.equals("107006")){ %>class="cur"<%} %>><a href="/other_0_0_107006_0.htm">趣味图片</a></li>
        <!-- <li <% if(type.equals("107007")){ %>class="cur"<%} %>><a href="/new_zhanhui_list.jsp.jsp?type=107007">更多</a></li> -->
    </ul>
  </div>
</div>
<script>
function goTO(){
window.open("http://product.21-sun.com/member/index.jsp?usernn=<%=username%>&password=<%=password%>");
}
</script>