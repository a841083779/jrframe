<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<% 
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
	}
	
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	List<Map> proLists = null;

	try{
		connection = dbHelper.getConnection();

	String sql="select  * from pro_catalog_factory where factoryid=136";
			proLists = dbHelper.getMapList(sql);

		
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>铁臂口碑活动——分享真实用机感受柳工专区 - 铁臂口碑</title>
<meta name="keywords" content="工程机械口碑" />
<meta name="description" content="铁臂口碑第二季活动——分享您的真实用机感受，就有机会获得大奖。买工程机械产品，就上铁臂商城。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/plugin/dialog/jBox/Skins/Blue/jbox.css" type="text/css">
</link>
<link href="/plugin/validator/rjboy/validform.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<style>
.fixLayer { width: 100px; height: 300px; position: fixed; right: 10px; bottom: 50px; }
</style>
</head>
<body class="act_sem">
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"/>
<!--top end--> 
<!--banner-->
<div class="sem_banner"></div>
<!--banner end--> 
<!--main-->
<div class="contain980 fix sem_val_1"></div>
<div class="contain980 fix">
	<div class=" sem_val_new">
      <h3>获奖名单</h3>
        <ul class="fix">
            <li class="ll1"><div class="prize"><span >ruli125</span><b>211分</b><i>第1名</i></div><i>一等奖</i></li>
			 <li class="ll1"><div class="prize"><span>18812365777</span><b>70分</b><i>第2名</i></div><i>一等奖</i></li>
            <li class="ll1"><div class="prize"><span >IKARUSSIA</span><b>70分</b><i> 第3名</i></div><i>一等奖</i></li>
        </ul>
    </div>
</div>
<div class="contain980 fix sem_val_2">
  <div class="sem_prolist">
    <ul class="fix sprolist">
      <li>
        <div class="sem_img"><img src="images/lg_09.jpg" alt="ZL50CN-5t轮式装载机" title="ZL50CN-5t轮式装载机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></div>
        <div class="sem_right">
          <div class="sem_pname">ZL50CN<BR>5t轮式装载机</div>
          <ul class="sem_para">
            <li class="evenbg">额定容量：1.8~5.6 m<sup>3</sup></li>
            <li>额定载重量：5000kg</li>
            <li class="evenbg">额定功率：162kW</li>
          </ul>
          <a href="http://koubei.21-sun.com/list/9906.htm#sentComment" class="sem_btn" target="_blank">立即发表评论</a> </div>
      </li>
      <li>
        <div class="sem_img"><img src="images/lg_11.jpg" alt="CLG933E大型机" title="CLG933E大型机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></div>
        <div class="sem_right">
          <div class="sem_pname">CLG933E<br>大型机</div>
          <ul class="sem_para">
            <li class="evenbg">标准斗容：1.4m<sup>3</sup></li>
            <li>操作重量：31300kg</li>
            <li class="evenbg">额定功率：166kw</li>
          </ul>
          <a href="http://koubei.21-sun.com/list/21652.htm#sentComment" class="sem_btn" target="_blank">立即发表评论</a> </div>
      </li>
      <li>
        <div class="sem_img"><img src="images/lg_13.jpg" alt="CLG6122机械式振动压路机" title="CLG6122机械式振动压路机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></div>
        <div class="sem_right">
          <div class="sem_pname">CLG6122<br>机械式振动压路机</div>
          <ul class="sem_para">
            <li class="evenbg">额定功率：128Kw</li>
            <li>工作质量：22000kg</li>
            <li class="evenbg">静线压力：506N/cm</li>
          </ul>
          <a href="http://koubei.21-sun.com/list/19600.htm#sentComment" class="sem_btn" target="_blank">立即发表评论</a> </div>
      </li>
      <li>
        <div class="sem_img"><img src="images/lg_16.jpg" alt="QY8E汽车起重机" title="QY8E汽车起重机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></div>
        <div class="sem_right">
          <div class="sem_pname">QY8E<br>汽车起重机</div>
          <ul class="sem_para">
            <li class="evenbg">最大额定起重量：8000kg</li>
            <li>基本臂最大起重力矩：245KN•m</li>
            <li class="evenbg">最长主臂最大起重力矩：117KN•m</li>
          </ul>
          <a href="http://koubei.21-sun.com/list/9912.htm#sentComment" class="sem_btn" target="_blank">立即发表评论</a> </div>
      </li>
       <li>
        <div class="sem_img"><img src="images/lg_25.jpg" alt="B160L推土机" title="B160L推土机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></div>
        <div class="sem_right">
          <div class="sem_pname">B160L<br>推土机</div>
          <ul class="sem_para">
            <li class="evenbg">发动机：WD10G178E25</li>
            <li>额定功率：120/1850kW/rpm</li>
            <li class="evenbg">工作质量：17000kg</li>
          </ul>
          <a href="http://koubei.21-sun.com/list/10010.htm#sentComment" class="sem_btn" target="_blank">立即发表评论</a> </div>
      </li>
      <li>
        <div class="sem_img"><img src="images/lg_16-05.jpg" alt="CLG765A挖掘装载机" title="CLG765A挖掘装载机" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"></div>
        <div class="sem_right">
          <div class="sem_pname">CLG765A<br>挖掘装载机</div>
          <ul class="sem_para">
            <li class="evenbg">标定功率：75Kw</li>
            <li>额定转速：2400rpm</li>
            <li class="evenbg">整机重量：8300kg</li>
          </ul>
          <a href="http://koubei.21-sun.com/list/19607.htm#sentComment" class="sem_btn" target="_blank">立即发表评论</a> </div>
      </li>
     
    </ul>
  </div>
</div>
<div class="sem_val_3" id="aa"></div>
<div class="contain980 fix sem_val_4">
  <div class="p4_con">
    <form action="/action/crud.jsp" method="post" name="theform" id="theform">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tbody>
          <tr>
            <td width="19%" height="48" align="right" class="td_bot"><b>*</b>请选择机型：</td>
            <td width="81%" class="td_bot"><select name="catalog" id="catalog" onchange="<% if(username.equals("")){ %>login();<%}else{%>chooseBrand(this.value)<%}%>">
			 <option value="">请选择类型</option>
			<%
			
			if(proLists!=null){
    		for(Map m:proLists){
    			String id = CommonString.getFormatPara(m.get("catalognum"));
    			String file_name = CommonString.getFormatPara(m.get("catalogname"));
			%>
                <option value="<%=id%>"><%=file_name%></option>
				<%}}%>
			
              </select>
              <select name="zd_product_id" id="zd_product_id">
                <option>请选择型号</option>
              </select></td>
          </tr>
          <tr>
            <td align="right"><b>*</b>价格：</td>
            <td valign="top"><div class="xing" id="price_1" style="cursor: pointer; width: 100px;"><img src="/koubei/img/star-off.png" alt="1" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="2" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="3" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="4" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="5" title="">
                <input type="hidden" name="score">
              </div>
              <span class="xing_tip">点击星星为该机型价格打分</span></td>
          </tr>
          <tr>
            <td align="right"><b>*</b>质量：</td>
            <td><div class="xing" id="zhiliang_1" style="cursor: pointer; width: 100px;"><img src="/koubei/img/star-off.png" alt="1" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="2" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="3" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="4" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="5" title="">
                <input type="hidden" name="score">
              </div>
              <span class="xing_tip">点击星星为该机型质量打分</span></td>
          </tr>
          <tr>
            <td align="right"><b>*</b>性能：</td>
            <td><div class="xing" id="xingneng_1" style="cursor: pointer; width: 100px;"><img src="/koubei/img/star-off.png" alt="1" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="2" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="3" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="4" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="5" title="">
                <input type="hidden" name="score">
              </div>
              <span class="xing_tip">点击星星为该机型性能打分</span></td>
          </tr>
          <tr>
            <td align="right"><b>*</b>售后：</td>
            <td><div class="xing" id="shouhou_1" style="cursor: pointer; width: 100px;"><img src="/koubei/img/star-off.png" alt="1" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="2" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="3" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="4" title="">&nbsp;<img src="/koubei/img/star-off.png" alt="5" title="">
                <input type="hidden" name="score">
              </div>
              <span class="xing_tip">点击星星为该机型售后打分</span></td>
          </tr>
          <tr>
            <td align="right" valign="top"><b>*</b>评价：</td>
            <td><textarea id="zd_content" name="zd_content"></textarea></td>
          </tr>
          <tr>
            <td height="56">&nbsp;</td>
            <td><span class="tip">10~2000个字之间，请针对用机感受、使用情况等方面进行评论，评论的内容需对其他用户有参考价值，并且真实原创。</span></td>
          </tr>
          <tr>
            <td align="right">上传图片：</td>
            <td><%	if(username.equals("")){ %>
              <img src="images/1_22.jpg" onclick="login();" width="77" height="30" />
              <%}else{%>
              <span id="addImgs"></span>
              <%}%></td>
          </tr>
          <tr>
            <td colspan="2" style="padding-left:182px; padding-top:10px;"><ul class="showpic clearfix" id="addImgs_show">
              </ul></td>
          </tr>
          <tr> </tr>
          <tr>
            <td height="39" class="td_bot"></td>
            <td class="td_bot">单张图片不超过10MB，尺寸不小于300*300px,支持jpg、png和bmp。</td>
          </tr>
          <tr>
            <td bgcolor="#f8fcfb">&nbsp;</td>
            <td align="left" bgcolor="#f8fcfb"><div style="position:relative">
                <blockquote>
                  <p>
                    <%	if(username.equals("")){ %>
                    <a href="javascript:void(0);" onclick="login();" class="ti_btn">提交评论</a>
                    <%}else{%>
                    <input style="background: url(/activity/koubei/images/ti2_btn.png);width: 273px;height: 53px;font: 0px a;letter-spacing: -7px;margin-left: 180px;margin-top: 5px;margin-bottom: 12px;border: 0;" onclick="doComments();" type="button"  name="button" id="button" value="提交评论" class="ti_btn" />
                    <%}%>
                    <a style="font-size:18px;margin-left:260px;"  href="/activity/koubei2/index.jsp" ><strong>返回活动首页</strong></a><br>
                    铁臂口碑要求发布的评论确系本人原创，严禁剽窃、转投他人评论，若因此引起任何法律纠纷，与铁臂口碑无关。 </p>
                </blockquote>
              </div></td>
          </tr>
        </tbody>
      </table>
      <input type="hidden" name="tableName" id="tableName" value="pro_comments">
      <input type="hidden" name="zd_username" id="zd_username" value="<%=username%>">
      <input type="hidden" name="zd_userid" id="zd_userid" value="1">
      <input type="hidden" name="eventAfter" value="insertImages">
      <input type="hidden" name="zd_score1" id="score1">
      <input type="hidden" name="zd_score2" id="score2">
      <input type="hidden" name="zd_score3" id="score3">
      <input type="hidden" name="zd_score4" id="score4">
      <input type="hidden" name="zd_is_show" value="1">
    </form>
  </div>
</div>
<!--main end--> 
<!--foot-->
<div style="width:980px; height:170px; margin:0 auto; clear:both; position:relative;" class="proFoot">
  <div style="position:absolute; right:-18px; top:36px; width:160px; text-align:center;" class="fewm"><img src="/images/ewm_new.gif" width="90" height="90" /><br />
    关注铁臂商城<br />
    抢先查询新品信息</div>
  <link rel="stylesheet" href="http://www.21-sun.com/00css/new_21sun_include.css" type="text/css" />
  <div class="New_website">
    <div class="New_linksContain"> <strong><span class="New_links" onclick="window.open('http://www.21-sun.com');">中国工程机械商贸网</span>旗下网站：</strong> <span class="New_links" onclick="window.open('http://part.21-sun.com/');">中国工程机械配件网</span> <span class="New_links" onclick="window.open('http://www.21-cmjob.com/');">中国工程机械人才网</span> <span class="New_links" onclick="window.open('http://www.21-rent.com/');">中国工程机械租赁网</span> <span class="New_links" onclick="window.open('http://www.21-used.com/');">中国工程机械二手网</span> <span class="New_links" onclick="window.open('http://www.21part.com/');">配件商城</span> <span class="New_links" onclick="window.open('http://www.21peitao.com/');">配套网</span> <span class="New_links" onclick="window.open('http://www.cmbol.com/');">工程机械外贸网</span> <span class="New_links" onclick="window.open('http://product.21-sun.com/');">铁臂商城</span> </div>
  </div>
  <div class="New_foot"> <span class="New_links" onclick="window.open('http://www.21-sun.com/service/guanggao/index.htm');">广告服务</span><em>|</em> <span class="New_links" onclick="window.open('http://www.jerei.com/contact/');">联系方式</span><em>|</em> <span class="New_links" onclick="window.open('http://www.jerei.com/');">关于我们</span><em>|</em> <span class="New_links" onclick="window.open('http://www.jerei.com/news/');">本网动态</span><em>|</em> <span class="New_links" onclick="window.open('http://www.jerei.com/contact/legal.jsp');">法律声明</span><em>|</em> <span class="New_links" onclick="window.open('http://aboutus.21-sun.com/map.htm');">网站导航</span><em>|</em> <span class="New_links" onclick="window.open('http://www.21-sun.com/contact/');">联系客服</span><br/>
    产品询价专线：4006-521-526<br/>
    <span class="New_links" onclick="window.open('http://www.21-sun.com');">中国工程机械商贸网</span> Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script> 
  </div>
  <!-- Baidu Button BEGIN -->
  <div style="width:300px; margin:0px auto;" >
    <div class="bdsharebuttonbox" style="padding-left:50px;"> <a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
    <script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script> 
  </div>
  <!-- Baidu Button END --> 
</div>
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
<script type="text/javascript">
	var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
	document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F2bbdb11527d93b69fad8795fbc9167ef' type='text/javascript'%3E%3C/script%3E"));
  </script>
<div style="display:none"> 
  
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
</script> 
<!-- Baidu Button BEGIN --> 
<!--
<script type="text/javascript" src="http://pv.21-sun.com/http/stat.jsp"></script>
-->
<div class="fixLayer"> <a href="javascript:void(0)" onclick="share();"><img src="r2.png"/></a> <br>
  <a href="javascript:void(0)" id="gotop"><img src="r3.png"/></a> <br>
  <a href="javascript:void(0)"><img src="ewm_21.gif"/></a> </div>
<!--foot end--> 
<script type="text/javascript">
	
	
$.fn.inputholder=function(){
var dval=$(this).val();
$(this).focus(function(){
	$(this).val('').addClass('focus');
	}).blur(function(){
	if($(this).val()==''){
		$(this).val(dval).removeClass('focus');
		}
	});
};
var inputholder=$('.inputholder');
if(inputholder.length){
	inputholder.each(function() {
	  $(this).inputholder()
   })
};
	
var backUrl = '';
jQuery(function(){
	jQuery("#showLoginPasswd").val("密码") ;
	jQuery("#showLoginName").val("用户名") ;
	jQuery("#rem_pass").click(function(){//记住密码事件
		var remPass = jQuery("#rememberPass");
		if(remPass.attr("checked")=="checked"){
			remPass.removeAttr("checked");
			remPass.val("0");
		}else{
			remPass.attr("checked","checked");
			remPass.val("1");
		}
	});
	jQuery("#rememberPass").click(function(){//记住密码事件
		var remPass = jQuery(this);
		if(jQuery(this).attr("checked")=="checked"){
			remPass.attr("value","1");
		}else{
			remPass.attr("value","0");
		}
	});
})

function doLogin(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=login&r='+new Date()+'&u='+encodeURI(jQuery("#login_username").val())+'&p='+encodeURI(jQuery("#login_password").val()),
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("您已经成功登录！");
				setTimeout("parent.window.location.reload()",1000);
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("用户名或密码错误！");
			}else if($.trim(data)=="state0"){
				jQuery.jBox.tip("该用户已被禁用，请联系铁臂商城管理员！");
			}
		}
	});
}
</script> 
<script language="javascript" type="text/javascript">

jQuery(function(){
	jQuery("#addImgs").JrUpload({
		remotUrl : "http://resource.21-sun.com/upload.jsp",
		folder : "product/koubei" ,
		sizeLimit:10*1024*1024, //10M
		multi : true,
		beforeCallback : "beforeCallback",
		callback : "setImgs" ,
		style : "width:98px;height:30px;",
		buttonImg : "http://product.21-sun.com/activity/koubei/images/1_22.jpg" ,
		buttonImgWidth : 77 ,
		buttonImgHeight : 30
	});
});
function beforeCallback(){
	$.jBox.tip("图片上传中，请稍后。。。", "loading");
}
function setImgs(data){
	var imgs = data.split(",");
	var htm = '';
	var f = 'http://resource.21-sun.com';
	for(var i=0;i<imgs.length;i++){
		htm += '<li><img class="img" src="'+f+imgs[i]+'" width="90" height="60" /><input type="hidden" name="img" value="'+f+imgs[i]+'" /><a href="javascript:void(0);" onclick="removeThis(this);" attrId="0" class="img_delete" style="position:absolute;top:-7px;left:80px;"><img src="http://member.21-sun.com/home/used/images/delete.png" /></a></li>';
	}
	jQuery("#addImgs_show").append(htm);
	regEvent();
	$.jBox.closeTip();
}
function regEvent(){
	jQuery("#addImgs_show>li").mouseover(function(){
		jQuery(".img_delete").hide();
		jQuery(this).find(".img_delete").show();
	});
	jQuery("#addImgs_show>li").mouseout(function(){
		jQuery(".img_delete").hide();
	});
}
function removeThis(o){
	var attrId = jQuery(o).attr("attrId")+"";
	if(attrId=='0'){
		jQuery(o).parent().remove();
	}else{
		if(confirm("确定删除该张图片吗？")){
			jQuery(o).parent().remove();
		}
	}
}
function regForm(){
    alert(11);
	$.extend($.Datatype,{
		"b3" : /^[-\+]?\d{1,3}(\.\d{0,2})?$/
	});
		
	jQuery("#theform").Validform({
	 	tiptype : 4,
	 	ajaxPost : true,
		beforeCheck : function(){
			var catalog = $("#catalog").val();
			var a = '';
			if(catalog==a){
				alert("请选择产品类型！");
				return false;
			}
			var brand = $("#brand").val();
			var b = '';
			if(brand==b){
				alert("请选择品牌！");
				return false;
			}
			var product = $("#zd_product_id").val();
			var p = '';
			if(product==p){
				alert("请选择产品！");
				return false;
			}
			var price = jQuery("#price_1").raty("score");
			var xingneng = jQuery("#xingneng_1").raty("score");
			var zhiliang = jQuery("#zhiliang_1").raty("score");
			var shouhou = jQuery("#shouhou_1").raty("score");
			if(typeof(price)=="undefined"){
				alert("请您点击星星为该机型价格打分！");
				return false;
			}
			if(typeof(zhiliang)=="undefined"){
				alert("请您点击星星为该机型质量打分！");
				return false;
			}
			if(typeof(xingneng)=="undefined"){
				alert("请您点击星星为该机型性能打分！");
				return false;
			}
			if(typeof(shouhou)=="undefined"){
				alert("请您点击星星为该机型售后打分！");
				return false;
			}
			var content = $.trim($("#zd_content").val());
			var c = '';
			if(content==c){
				alert("请填写您的评价！");
				return false;
			}else if(content.length<10||content.length>1999){
				alert("请按要求填写您的评价！");
				return false;
			}
			var imgLength = jQuery("input[name=img]").length;
			//if(imgLength<1){
			//	alert("上传图片数量不足，请上传至少1张图片！");
			//	return false;
			//}
			
			jQuery("#score1").val(parseFloat(jQuery("#price_1").raty("score"),10)*20);
			jQuery("#score2").val(parseFloat(jQuery("#xingneng_1").raty("score"),10)*20);
			jQuery("#score3").val(parseFloat(jQuery("#zhiliang_1").raty("score"),10)*20);
			jQuery("#score4").val(parseFloat(jQuery("#shouhou_1").raty("score"),10)*20);
			return true;
		},
		beforeSubmit : function(){
			parent.$.jBox.tip("评论分享中，请稍后。。。","loading");
		},
	 	callback : function(json){
	 	 	alert("评论分享成功！");
	 	 	var pid = $("#zd_product_id").val();
	 	 	window.location = "http://koubei.21-sun.com/list/"+pid+".htm";
			//window.location.reload();
	 	}
 	});
}

//评论提交	
jQuery("#price_1,#xingneng_1,#zhiliang_1,#shouhou_1").raty({
	path: "/koubei/img",
	half : true ,
	score : 0
});
function chooseCatalog(v){
	var rand = Math.random();
	jQuery.ajax({
			url:'include/brands.jsp?r='+rand+'&v='+encodeURI(v),
			async:false,
			cache:false,
			success:function(data){
				jQuery("#brand").empty("");
				jQuery("#brand").append(jQuery.trim(data));
			}
		});
}
function chooseBrand(v){
	var rand = Math.random();
	var c = $.trim(jQuery("#catalog").val());
	var v = '136';
	if(c!=""&&v!=""){
		jQuery.ajax({
			url:'include/products.jsp?r='+rand+'&v='+encodeURI(v)+'&c='+encodeURI(c),
			async:false,
			cache:false,
			success:function(data){
				jQuery("#zd_product_id").empty("");
				jQuery("#zd_product_id").append(jQuery.trim(data));
			}
		});
	}
	
}
$(function(){
	$('.pr_img img').on({
		"mouseenter":function(){						
			$(this).parent().parent().css('position','relative').find('.big_img').show();			
		},
		"mouseleave":function(){
			$(this).parent().parent().css('position','static').find('.big_img').hide();			
		}})
		$('#weixin').hover(function(){
			$('#weixin_img').show();
			},function(){
				$('#weixin_img').hide();
				})
})

function login() {
	jQuery.jBox.setDefaults({
		defaults : {
			border : 5
		}
	}); // 只修改全局 border
	jQuery.jBox("iframe:/activity/koubei/login.jsp?back=" + encodeURIComponent(document.URL), {
		border:5,
		title : null,
		opacity : 0.3,
		width : 620,
		top : '30%',
		height : 280,
		showClose:false,
		showIcon : false,
		iframeScrolling : 'no',
		id:'loginFrame',
		buttons : {}
	});
}

function logout(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=logout&r='+new Date(),
		async:false,
		cache:false,
		success:function(data){
			jQuery.jBox.tip("您已退出登录！");
			setTimeout("window.location.reload()",1000);
		}
	});
}
function LoginToRegister(){//注册成功会自动登录并返回注册前页面
	window.parent.location.href = 'register.jsp';
}
function toRegist_for_return(){	
	parent.LoginToRegister();
	parent.jQuery.jBox.close('loginFrame');
}

//登录弹出
function doLogin(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=login&r='+new Date()+'&u='+encodeURI(jQuery("#login_username").val())+'&p='+encodeURI(jQuery("#login_password").val()),
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("您已经成功登录！");
				setTimeout("parent.window.location.reload()",1000);
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("用户名或密码错误！");
			}else if($.trim(data)=="state0"){
				jQuery.jBox.tip("该用户已被禁用，请联系铁臂商城管理员！");
			}
		}
	});
}

jQuery(function(){
	jQuery("#rem_pass").click(function(){//记住密码事件
		var remPass = jQuery("#rememberPass");
		if(remPass.attr("checked")=="checked"){
			remPass.removeAttr("checked");
			remPass.val("0");
		}else{
			remPass.attr("checked","checked");
			remPass.val("1");
		}
	});
	jQuery("#rememberPass").click(function(){//记住密码事件
		var remPass = jQuery(this);
		if(jQuery(this).attr("checked")=="checked"){
			remPass.attr("value","1");
		}else{
			remPass.attr("value","0");
		}
	});
})

//登录首页
function doLoginIndex(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=login&r='+new Date()+'&u='+encodeURI(jQuery("#showLoginName_index").val())+'&p='+encodeURI(jQuery("#showLoginPasswd_index").val()),
		async:false,
		cache:false,
		success:function(data){
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("您已经成功登录！");
				setTimeout("parent.window.location.reload()",1000);
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("用户名或密码错误！");
			}else if($.trim(data)=="state0"){
				jQuery.jBox.tip("该用户已被禁用，请联系铁臂商城管理员！");
			}
		}
	});
}

jQuery(function(){
	jQuery("#showLoginPasswd_index").val("密码") ;
	jQuery("#showLoginName_index").val("用户名") ;
	jQuery("#rem_pass_index").click(function(){//记住密码事件
		var remPass = jQuery("#rememberPass_index");
		if(remPass.attr("checked")=="checked"){
			remPass.removeAttr("checked");
			remPass.val("0");
		}else{
			remPass.attr("checked","checked");
			remPass.val("1");
		}
	});
	jQuery("#rememberPass_index").click(function(){//记住密码事件
		var remPass = jQuery(this);
		if(jQuery(this).attr("checked")=="checked"){
			remPass.attr("value","1");
		}else{
			remPass.attr("value","0");
		}
	});
})


//评论提交
function doComments(){
			var catalog = $("#catalog").val();
			var a = '';
			if(catalog==a){
				alert("请选择产品类型！");
				return false;
			}
	
			var product = $("#zd_product_id").val();
			var p = '';
			if(product==p){
				alert("请选择产品！");
				return false;
			}
			var price = jQuery("#price_1").raty("score");
			var xingneng = jQuery("#xingneng_1").raty("score");
			var zhiliang = jQuery("#zhiliang_1").raty("score");
			var shouhou = jQuery("#shouhou_1").raty("score");
			if(typeof(price)=="undefined"){
				alert("请您点击星星为该机型价格打分！");
				return false;
			}
			if(typeof(zhiliang)=="undefined"){
				alert("请您点击星星为该机型质量打分！");
				return false;
			}
			if(typeof(xingneng)=="undefined"){
				alert("请您点击星星为该机型性能打分！");
				return false;
			}
			if(typeof(shouhou)=="undefined"){
				alert("请您点击星星为该机型售后打分！");
				return false;
			}
			var content = $.trim($("#zd_content").val());
			var c = '';
			if(content==c){
				alert("请填写您的评价！");
				return false;
			}else if(content.length<10||content.length>1999){
				alert("请按要求填写您的评价！");
				return false;
			}

			
			jQuery("#score1").val(parseFloat(jQuery("#price_1").raty("score"),10)*20);
			jQuery("#score2").val(parseFloat(jQuery("#xingneng_1").raty("score"),10)*20);
			jQuery("#score3").val(parseFloat(jQuery("#zhiliang_1").raty("score"),10)*20);
			jQuery("#score4").val(parseFloat(jQuery("#shouhou_1").raty("score"),10)*20);

			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data){
			     if(jQuery.trim(data)=='no'){
				   alert("您输入的评价中含有敏感词，请重新输入") ;

				   return ;
				}
				if(jQuery.trim(data)=='0'){
				   alert("评论失败") ;
 
				   return ;
				}
					alert("评论提交成功！");
		            setTimeout("window.location.reload()",1000);
				}					  
			});
		}
		
//分享
function share() {
window.open("http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=http://product.21-sun.com/activity/liugong/&title=铁臂口碑活动——分享真实用机感受柳工专区 - 铁臂口碑");
}

$('#gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});

</script> 
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<div style="display:none"><script src="http://s95.cnzz.com/stat.php?id=1253077109&web_id=1253077109" language="JavaScript"></script></div>
</body>
</html>