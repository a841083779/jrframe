<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.common.Common"%><%@page import="com.jerehnet.util.common.CommonString"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@page import="com.jerehnet.util.dbutil.PageBean"%><%@page import="java.text.SimpleDateFormat"%><%@page import="com.jerehnet.util.common.CommonDate"%><%@page import="java.sql.Connection"%><%@page import="com.jerehnet.util.common.CommonApplication"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
    int loginFlag=1;
	String nickname=""; String img=""; String usern=""; String password="";
    Map memberInfo = (Map)session.getAttribute("memberInfo");
    if(memberInfo==null){
			loginFlag=0;

	}else{
		usern= CommonString.getFormatPara(memberInfo.get("username"));
	    nickname= CommonString.getFormatPara(memberInfo.get("nickname"));
		password=CommonString.getFormatPara(memberInfo.get("password"));
		if(nickname.equals("")){nickname=usern;}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【口碑】工程机械产品口碑_工程机械产品点评 – 铁臂口碑</title>
<meta name="keywords" content="工程机械产品口碑,工程机械产品点评,工程机械产品口碑大全" />
<meta name="description" content="铁臂口碑为您提供大量真实用户的工程机械产品口碑、工程机械产品点评，帮助您通过网络了解工程机械产品，买工程机械产品就上铁臂商城。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta name="mobile-agent" content="format=html5;url=http://m.koubei.21-sun.com/">
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="http://product.21-sun.com/koubei/style/koubei.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<link href="/plugin/validator/rjboy/validform.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/login.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script src="http://siteapp.baidu.com/static/webappservice/uaredirect.js" type="text/javascript"></script>
<script type="text/javascript">uaredirect("http://m.koubei.21-sun.com/");</script>
<script type="text/javascript">
//导航选中状态
var jrChannel='0#0'
</script>
</head>
<body style="background-color:#f3f3f3;">
<!--top-->
<jsp:include page="include/top.jsp" flush="true" />
<!--top end-->

<div class="contain980 fix mb10">
  <div class="kb_cates">
    <div class="kbc">
      <div class="kb-hd"><a href="/101001-0-0.htm"><i class="kbc1"></i>挖掘机</a></div>
      <div class="kb-bd"><a href="/101001004-0-0.htm">轮式挖掘机</a><a href="/101001006-0-0.htm">正铲挖掘机</a></div>
      <div class="kb-box">
        <strong class="t">品牌推荐</strong>
        <ul>
          <li><a href="/101001-182-0.htm">小松</a></li>
          <li><a href="/101001-133-0.htm">三一</a></li>
          <li><a href="/101001-184-0.htm">日立</a></li>
          <li><a href="/101001-174-0.htm">卡特彼勒</a></li>
          <li><a href="/101001-192-0.htm">斗山</a></li>
          <li><a href="/101001-183-0.htm">神钢</a></li>
		  <li><a href="/101001-175-0.htm">沃尔沃</a></li>
          <li><a href="/101001-136-0.htm">柳工</a></li>
          <li><a href="/101001-209-0.htm">徐工</a></li>  
		  <li><a href="/101001-677-0.htm">龙工</a></li>
          <li><a href="/101001-189-0.htm">加藤</a></li>
          <li><a href="/101001-194-0.htm">现代</a></li>
          <li><a href="/101001-152-0.htm">山重建机</a></li>
          <li><a href="/101001-139-0.htm">厦工</a></li>
          <li><a href="/101001-177-0.htm">杰西博</a></li>
		  <li><a href="/101001-157-0.htm">力士德</a></li>
          <li><a href="/101001-195-0.htm">詹阳动力</a></li>
          <li><a href="/101001-146-0.htm">玉柴重工</a></li>
        </ul>
      </div>
    </div>
    <div class="kbc">
      <div class="kb-hd"><a href="/101002-0-0.htm"><i class="kbc2"></i>装载机</a></div>
      <div class="kb-bd"><a href="/101002007-0-0.htm">轮式装载机</a><a href="/101002009-0-0.htm">滑移装载机</a></div>
      <div class="kb-box">
        <strong class="t">品牌推荐</strong>
        <ul>
          <li><a href="/101002-136-0.htm">柳工</a></li>
          <li><a href="/101002-677-0.htm">龙工</a></li>
          <li><a href="/101002-209-0.htm">徐工</a></li>
		  <li><a href="/101002-139-0.htm">厦工</a></li>
		  <li><a href="/101002-138-0.htm">山工</a></li>
		  <li><a href="/101002-137-0.htm">山东临工</a></li>
		  <li><a href="/101002-174-0.htm">卡特彼勒</a></li>
		  <li><a href="/101002-145-0.htm">成工</a></li>
		  <li><a href="/101002-141-0.htm">福田雷沃</a></li>
          <li><a href="/101002-1522-0.htm">徐工特机</a></li>
          <li><a href="/101002-192-0.htm">斗山</a></li>
          <li><a href="/101002-13118-0.htm">山东鲁工</a></li>
		  <li><a href="/101002-182-0.htm">小松</a></li>
		  <li><a href="/101002-175-0.htm">沃尔沃</a></li>
		  <li><a href="/101002-148-0.htm">常林股份</a></li>
		  <li><a href="/101002-172-0.htm">晋工</a></li>
		  <li><a href="/101002-144-0.htm">山推</a></li>
		  <li><a href="/101002-1777-0.htm">英轩重工</a></li>
        </ul>
      </div>
    </div>
    <div class="kbc">
      <div class="kb-hd"><a href="/102-0-0.htm"><i class="kbc3"></i>起重机</a></div>
      <div class="kb-bd"><a href="/102007-0-0.htm">汽车起重机</a><a href="/102008-0-0.htm">履带起重机</a></div>
      <div class="kb-box">
        <strong class="t">品牌推荐</strong>
        <ul>
          <li><a href="/102-134-0.htm">中联重科</a></li>
		  <li><a href="/102-209-0.htm">徐工</a></li>
		  <li><a href="/102-133-0.htm">三一</a></li>
		  <li><a href="/102-179-0.htm">利勃海尔</a></li>
		  <li><a href="/102-147-0.htm">长江</a></li>
		  <li><a href="/102-136-0.htm">柳工</a></li>
		  <li><a href="/102-176-0.htm">特雷克斯</a></li>
		  <li><a href="/102-166-0.htm">京城重工</a></li>
		  <li><a href="/102-186-0.htm">北起多田野</a></li>	  
		  <li><a href="/102-168-0.htm">石煤</a></li>
		  <li><a href="/102-487-0.htm">江麓</a></li>
		  <li><a href="/102-167-0.htm">北方交通</a></li>
		  <li><a href="/102-830-0.htm">沈阳三洋</a></li>
		  <li><a href="/102-843-0.htm">永茂</a></li>
		  <li><a href="/102-1117-0.htm">四川建机</a></li>
		  <li><a href="/102-189-0.htm">加藤</a></li>
		  <li><a href="/102-163-0.htm">东岳重工</a></li>
		  <li><a href="/102-217-0.htm">山东鸿达</a></li>
        </ul>
      </div>
    </div>
    <div class="kbc">
      <div class="kb-hd"><a href="/101003-0-0.htm"><i class="kbc4"></i>推土机</a></div>
      <div class="kb-bd"><a href="/101003001-0-0.htm">推土机</a></div>
      <div class="kb-box">
        <strong class="t">品牌推荐</strong>
        <ul>
          <li><a href="/101003-144-0.htm">山推</a></li>
          <li><a href="/101003-174-0.htm">卡特彼勒</a></li>
          <li><a href="/101003-134-0.htm">中联重科</a></li>
          <li><a href="/101003-154-0.htm">河北宣工</a></li>
          <li><a href="/101003-749-0.htm">洛阳东方红</a></li>
          <li><a href="/101003-136-0.htm">柳工</a></li>
          <li><a href="/101003-182-0.htm">小松</a></li>
          <li><a href="/101003-1187-0.htm">东方红</a></li>
          <li><a href="/101003-162-0.htm">大地</a></li>

		  <li><a href="/101003-209-0.htm">徐工</a></li>
          <li><a href="/101003-179-0.htm">利勃海尔</a></li>
          <li><a href="/101003-156-0.htm">上海彭浦</a></li>
          <li><a href="/101003-161-0.htm">移山</a></li>
          <li><a href="/101003-455-0.htm">凯斯</a></li>
          <li><a href="/101003-138-0.htm">山工</a></li>
          <li><a href="/101003-13613-0.htm">红旗</a></li>
          <li><a href="/101003-139-0.htm">厦工</a></li>
          <li><a href="/101003-135-0.htm">龙工</a></li>
        </ul>
      </div>
    </div>
     <div class="kbc">
      <div class="kb-hd"><a href="/103-0-0.htm"><i class="kbc5"></i>混凝土机械</a></div>
      <div class="kb-bd"><a href="/103001-0-0.htm">泵车</a><a href="/103002-0-0.htm">混凝土搅拌设备</a></div>
      <div class="kb-box">
        <strong class="t">品牌推荐</strong>
        <ul>
          <li><a href="/103-133-0.htm">三一</a></li>
          <li><a href="/103-174-0.htm">中联重科</a></li>
          <li><a href="/103-203-0.htm">海诺</a></li>
          <li><a href="/103-199-0.htm">普茨迈斯特</a></li>
          <li><a href="/103-136-0.htm">柳工</a></li>
          <li><a href="/103-205-0.htm">星马汽车</a></li>
          <li><a href="/103-217-0.htm">鸿达</a></li>
          <li><a href="/103-209-0.htm">徐工</a></li>

		  <li><a href="/103-1148-0.htm">亚特混</a></li>
          <li><a href="/103-1092-0.htm">圆友混</a></li>
          <li><a href="/103-202-0.htm">鸿得利重工</a></li>
          <li><a href="/103-179-0.htm">利勃海尔</a></li>
          <li><a href="/103-476-0.htm">天地重工</a></li>
          <li><a href="/103-167-0.htm">北方交通</a></li>
          <li><a href="/103-671-0.htm">方圆集团</a></li>
          <li><a href="/103-1092-0.htm">圆友</a></li>
		  <li><a href="/103-200-0.htm">南方路机</a></li>
		  <li><a href="/103-143-0.htm">宇通重工</a></li>
        </ul>
      </div>
    </div>
  </div>
  <div class="kbSlider">
    <div class="bd">
      <ul>
        <li><a href="http://product.21-sun.com/activity/koubei/" target="_blank"><img src="http://product.21-sun.com/koubei/images/bxjg.jpg" width="520" height="300" alt="" /></a></li>
      </ul>
    </div>
    <div class="hd">
      <ul>
        <li class="on"><b>1</b><span>分享真实用机感受，变形金刚跟你回家</span></li>
      </ul>
    </div>
  </div>
  <div class="sideRight">
   
   <div class="kb_mem">
   <%if(loginFlag==0){%>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding-top:30px;">
        <tr>
          <th width="23%">用户名</th>
          <td width="77%"><input type="text" name="username" id="username" class="input" /></td>
        </tr>
        <tr>
          <th>密　码</th>
          <td><input type="password" name="password" id="password" class="input" onKeyDown="if(event.keyCode==13){doLogin();}" /></td>
        </tr>
		<!--
        <tr >
          <th>验证码</th>
          <td><input type="text" name="textfield3" id="textfield3" class="input" style="width:45px;" />
          <img src="images/yzm.png" width="62" height="22" style="vertical-align:middle;" />看不清？</td>
        </tr>
		-->
        <tr>
          <th>&nbsp;</th>
          <td><a href="javascript:void(0)"  onclick="doLogin();"  class="loginBtn">立即登录</a> <a target="_blank" href="http://koubei.21-sun.com/activity/koubei/register.jsp">免费注册</a></td>
        </tr>
      </table>
	  <%}else if(loginFlag==1){%>
      <div class="memInfo fix" >
        <span class="face"><a target="_blank" href="javascript:void(0)" onclick="goTO()"><img src="<%= CommonString.getFormatPara(memberInfo.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" width="99" height="99" /></a></span>
        <div class="info">
          <strong class="name"><a href="javascript:void(0)" ><%=nickname%></a></strong>
		  <div class="text">
          <a href="javascript:void(0)" onclick="goTO()"   target="_blank">个人中心</a>
          </div>
          <div class="text" style="display:none">
          关注17<br />
          粉丝6834
          </div>
          <a href="#" class="focus" style="display:none">关注</a>
        </div>
        <div class="links" >
          <a href="javascript:void(0)" style="display:none"><img src="http://product.21-sun.com/koubei/images/mem_ico01.png" />我的口碑</a>
          <a href="#" style="display:none"><img src="images/mem_ico02.png" />上传图片</a>
        </div>
        <div class="out"><a href="javascript:void(0)"  onclick="loginOut();"  class="outBtn">退出</a></div>
      </div>
	  <%}%>
    </div>
    <div class="gonggao">
      <div class="gg_box">
        <ul>
          <li><a target="_blank" href="http://product.21-sun.com/activity/koubei/" title="分享真实用机感受，变形金刚跟你回家">【公告】分享真实用机感受，变形金刚跟你回家</a></li>
        </ul>
      </div>
      <div class="more" style="display:none"><a href="#">更多公告&gt;&gt;</a></div>
    </div>
  </div>
</div>

<div class="contain980 fix mb10 kbList">
  <div class="kb_left">
    <div class="hd">
      <h3>热门挖掘机口碑</h3><span style="float:right"><a href="/101001-0-0.htm" target="_blank" title="更多挖掘机口碑">更多</a></span>
    </div>
    <div class="bd kbl">
      <ul>
         <jsp:include page="/include/koubei/koubei_index_wjj.htm" flush="true" />
      </ul>
    </div>
  </div>
  <div class="kb_right">
    <div class="hd">
      <h3>最新口碑</h3><span style="float:right"><a href="/comment-101001-0-0-0-0.htm" target="_blank" title="更多挖掘机最新口碑">更多</a></span>
    </div>
    <div class="bd kblr">
      <ul>
         <jsp:include page="/include/koubei/koubei_index_wjj_right.htm" flush="true" />
      </ul>
    </div>
  </div>
</div>

<div class="contain980 fix mb10 kbList">
  <div class="kb_left">
    <div class="hd">
      <h3>热门装载机口碑</h3><span style="float:right"><a href="/101002-0-0.htm" target="_blank" title="更多装载机口碑">更多</a></span>
    </div>
    <div class="bd kbl">
      <ul>
          <jsp:include page="/include/koubei/koubei_index_zzj.htm" flush="true" />
      </ul>
    </div>
  </div>
  <div class="kb_right">
    <div class="hd">
      <h3>最新口碑</h3><span style="float:right"><a href="/comment-101002-0-0-0-0.htm" target="_blank" title="更多装载机最新口碑">更多</a></span>
    </div>
    <div class="bd kblr">
      <ul>
         <jsp:include page="/include/koubei/koubei_index_zzj_right.htm" flush="true" />
      </ul>
    </div>
  </div>
</div>

<div class="contain980 fix mb10 kbList">
  <div class="kb_left">
    <div class="hd">
      <h3>热门推土机口碑</h3><span style="float:right"><a href="/101003-0-0.htm" target="_blank" title="更多推土机口碑">更多</a></span>
    </div>
    <div class="bd kbl">
      <ul>
          <jsp:include page="/include/koubei/koubei_index_ttj.htm" flush="true" />
      </ul>
    </div>
  </div>
  <div class="kb_right">
    <div class="hd">
      <h3>最新口碑</h3><span style="float:right"><a href="/comment-101003-0-0-0-0.htm" target="_blank" title="更多推土机最新口碑">更多</a></span>
    </div>
    <div class="bd kblr">
      <ul>
          <jsp:include page="/include/koubei/koubei_index_ttj_right.htm" flush="true" />
      </ul>
    </div>
  </div>
</div>

<div class="contain980 fix mb10 kbList">
  <div class="kb_left">
    <div class="hd">
      <h3>热门平地机口碑</h3><span style="float:right"><a href="/101005-0-0.htm" target="_blank" title="更多平地机口碑">更多</a></span>
    </div>
    <div class="bd kbl">
      <ul>
          <jsp:include page="/include/koubei/koubei_index_pdj.htm" flush="true" />
      </ul>
    </div>
  </div>
  <div class="kb_right">
    <div class="hd">
      <h3>最新口碑</h3><span style="float:right"><a href="/comment-101005-0-0-0-0.htm" target="_blank" title="更多平地机最新口碑">更多</a></span>
    </div>
    <div class="bd kblr">
      <ul>
          <jsp:include page="/include/koubei/koubei_index_pdj_right.htm" flush="true" />
      </ul>
    </div>
  </div>
</div>
<jsp:include page="/include/index/friendlink_koubei.htm" flush="true"/>
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--end of foot-->
<style type="text/css">
/*对联广告*/
/*左侧*/
#ads01 { position:fixed; left:0px; top:80px; z-index:999999; width:42px; height:350px;}
* html #ads01 {position:absolute; left:expression(eval(document.documentElement.scrollLeft)); top:expression(eval(document.documentElement.scrollTop)+100);}
/*右侧*/
#ads02 { position:fixed; right:0px; top:80px; z-index:99999; width:42px; height:350px;}
* html #ads02 {position:absolute; left:expression(eval(document.documentElement.scrollLeft+document.documentElement.clientWidth-this.offsetWidth)-(parseInt(this.currentStyle.marginLeft,0)||0)-(parseInt(this.currentStyle.marginRight,0)||0)); top:expression(eval(document.documentElement.scrollTop)+100);}
.hide { display:none;}
.ads_big { display:none;}
#ads01.ads_hover,#ads02.ads_hover { width:95px!important;}
.ads_hover .ads_small { display:none;}
.ads_hover .ads_big { display:block;}
/*对联广告结束*/
</style>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
<!--对联广告-->
<div id="ads02" class="ads_hover">
<a href="http://product.21-sun.com/activity/koubei/index.jsp" target="blank" style="display:block;"><img src="http://product.21-sun.com/images/kb_dl20140702.jpg" width="95" height="330" class="ads_big" /></a>
<img src="http://news.21-sun.com/images/close_x.gif" width="39" height="13" alt="关闭" title="关闭" onclick="document.getElementById('ads02').className='hide';" style="cursor:pointer; margin-top:1px; float:right;" />
</div>
<!--对联广告结束-->
</body>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/common.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/koubei/scripts/superslide.js"></script>
<script type="text/javascript">
var len = $('.kbSlider .hd li').length - 1;
var leftwidth = len * 34;
$(".kbSlider").slide({ titCell:".hd li", mainCell:".bd ul",effect:"leftLoop",vis:1,scroll:1,autoPlay:true,interTime:4000,startFun:function(i){
	$('.kbSlider .hd ul').children('li').eq(i).css('width',520 - leftwidth).siblings().removeAttr('style')
}});

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

function goTO(){
window.open("http://product.21-sun.com/member/index.jsp?usernn=<%=usern%>&password=<%=password%>");
}
<%if(memberInfo!=null){%>
//$.getJSON("/action/sso.jsp?key=<%=usern%>--<%=password%>--<%=CommonDate.getToday("yyyy-MM-dd")%>");
<%}%>
</script>
</html>