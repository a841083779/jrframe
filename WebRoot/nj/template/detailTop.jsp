<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
     String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
%>
<!--topBar-->
<div class="j_topBar">
  <div class="wrap fix">
    <div class="j_wel l j_grey" id="topLabel"><a href="http://www.21-sun.com/" target="_blank">欢迎您访问中国工程机械商贸网！</a><a href="http://product.21-sun.com/user/login.htm"  target="_blank">[登录]</a>&nbsp;&nbsp;<a href="http://product.21-sun.com/user/reg.htm" target="_blank">[注册]</a></div>
    <ul class="j_t_layer r">
      <li class="j_tl j_wei"><a href="http://www.21-sun.com/weixin/" target="_blank"><img width="74" height="20" style="margin-top:4px;" src="http://www.21-sun.com/weixin/images/weixin.jpg"></a></li>
      <li class="j_tl j_mobile">
        <div class="j_con"> <span class="j_n"><i class="ico"></i>手机商城<i class="ico ico1_3"></i></span>
          <div class="j_tlayer">
            <div><a href="http://www.21-sun.com/app/" target="_blank" rel="nofollow">手机商贸网</a></div>
            <div><a href="http://www.21-sun.com/app/phone_news.htm" target="_blank" rel="nofollow">工程机械动态</a></div>
            <div><img src="/nj/Static/images/ewm01.png" class="j_ewm">行业讯息</div>
            <div style="border:none;"><img src="/nj/Static/images/ewm02.png" class="j_ewm">铁臂商城微信</div>
          </div>
        </div>
      </li>
      <li class="j_tl j_about">
        <div class="j_con"> <span class="j_n"><a href="http://product.21-sun.com/about/" target="_blank" rel="nofollow">关于铁臂</a></span> </div>
      </li>
      <li class="j_tl j_siteNav">
        <div class="j_con"> <span class="j_n">网站导航<i class="ico ico1_3"></i></span>
          <div class="j_tlayer">
            <ul class="fix">
              <li onClick="window.open('http://product.21-sun.com/');">铁臂商城</li>
              <li onClick="window.open('http://photo.21-sun.com/');">产品图库</li>
              <li onClick="window.open('http://weixiu.21-sun.com/');">维　　修</li>
              <li onClick="window.open('http://koubei.21-sun.com/');">口　　碑</li>
              <li onClick="window.open('http://market.21-sun.com/');">供求市场</li>
              <li onClick="window.open('http://news.21-sun.com/');">行业动态</li>
              <li onClick="window.open('http://used.21-sun.com/');">二手设备</li>
              <li onClick="window.open('http://www.21-sun.com/part/');">配件市场</li>
              <li onClick="window.open('http://www.21part.com/');">杰 配 网</li>
              <li onClick="window.open('http://www.21-sun.com/supply/');">供 应 商</li>
              <li onClick="window.open('http://www.21taiyang.com/');">太阳商城</li>
              <li onClick="window.open('http://www.wajueji.com/');">铁臂兄弟连</li>
              <li onClick="window.open('http://dealer.21-sun.com/');">代理商</li>
              <li onClick="window.open('http://product.21-sun.com/about/case.htm');">旗舰店</li>
            </ul>
          </div>
        </div>
      </li>
      <li class="j_tl j_proNav">
        <div class="j_con topBigGuide"><span class="j_n">购机导航<i class="ico ico1_3"></i></span></div>
      </li>
    </ul>
  </div>
</div>
<!--topBar end-->
<!--top-->
<div class="wrap fix n_top">
  <h1 class="new_logo"> <a href="/nj/" title="铁臂商城"> <img src="/nj/Static/images/logo.png" alt="铁臂商城"> <span class="columnName">农机</span> </a> </h1>
  <div class="n_topSearch">
    <div class="input">
      <input id="keyword" name="keyword" type="text" placeholder="输入您要搜索的产品" />
    </div>
    <button onClick="tj3()" type="button" class="topBtn">搜索</button>
    <div class="n_hotwords"> <span>热门搜索：</span> <a href="/nj/prolist.jsp?catalog=102" >拖拉机</a> <a href="/nj/prolist.jsp?catalog=103">耕整地机械</a> <a href="/nj/prolist.jsp?catalog=104"  >种植施肥机械</a> <a href="/nj/prolist.jsp?catalog=105">收割/收获机</a> <a href="/nj/prolist.jsp?catalog=106" >农产品加工机械</a> <a href="/nj/prolist.jsp?catalog=107" >灌溉机械</a> </div>
  </div>
  <script>
  	  function tj3(){ 
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.location.href="/nj/prolist.jsp?keyword="+keyword;
	  }
	   $('#keyword').on('keydown', function (e) { if (e.keyCode == 13) {tj3()} })
  </script>
</div>
<!--nav-->
<div class="navBox">
  <div class="navBar">
    <div class="wrap fix">
      <ul class="menu">
        <li><a href="/nj/">首页</a></li>
        <li><a <%if(catalog.indexOf("102")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=102">拖拉机</a></li>
        <li><a <%if(catalog.indexOf("103")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=103">耕整地机械</a></li>
        <li><a <%if(catalog.indexOf("104")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=104">种植施肥机械</a></li>
        <li><a <%if(catalog.indexOf("105")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=105">收割/收获机</a></li>
        <li><a <%if(catalog.indexOf("106")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=106">农产品加工机械</a></li>
        <li><a <%if(catalog.indexOf("107")>=0){%>class="active"<%}%> href="/nj/prolist.jsp?catalog=107">灌溉机械</a></li>
				<li><a href="/nj/prolist.jsp">更多</a></li>

      </ul>
      <div class="allCates">
        <div class="acn">全部分类</div>
      </div>
    </div>
  </div>
</div>
<!--nav end-->

<script>
jQuery(function(){
    jQuery.post("/action/ajax.jsp", {
        flag: "isLogin_Tiebi"
    }, function(data){
        var tData = jQuery.trim(data);
        if (tData != 'no') {
            jQuery("#topLabel").html("<a href='http://www.21-sun.com/' target='_blank'>欢迎您访问中国工程机械商贸网！</a><a href='javascript:void(0);' onclick='logout();' style='text-decoration: underline;'>退出</a> | 欢迎您，<a target='_blank' href='/member/'>" + tData + "</a>");
           
        }
    });
});
//退出
function logout(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=logout&r='+new Date(),
		async:false,
		cache:false,
		success:function(data){
			alert("您已退出登录！");
			setTimeout("window.location.reload()",1000);
		}
	});
}
</script>