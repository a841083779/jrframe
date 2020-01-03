<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Common.do302(response,"/agent/login.jsp");
	if(session.getAttribute("factoryInfo") != null && ((Map)session.getAttribute("factoryInfo")).get("flag").equals(1)){
		// Common.do302(response,"/admin/factory/main.jsp");
		return ;
	}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>产品中心--工程机械--中国工程机械商贸网</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/webadmin/scripts/jquery.form.js"></script>
<script type="text/javascript">
jQuery(function(){
   var tag = "" ;
	jQuery("#usern").focus();
	jQuery("input[id^='login']").click(function(){
	 tag = jQuery(this).attr("tag") ;
		if(jQuery("#usern"+tag).val()==""){
			alert("请输入帐号");
			jQuery("#usern"+tag).focus();
			return false;
		}else if(jQuery("#password"+tag).val()==""){
			alert("请输入密码");
			jQuery("#password"+tag).focus();
			return false;
		}
		jQuery("#theform"+tag).ajaxSubmit({
			type:"POST",
			success:function(data){
				if(jQuery.trim(data)=='factoryok'){
					window.location.href='/admin/factory/main.jsp';
				}else
				if(jQuery.trim(data)=='agentok'){
				  window.location.href='/admin/agent/main.jsp';
				}else
                if(jQuery.trim(data)=='state0' && tag==1){
					alert('您是代理商，请通过代理商登录入口登录！');
					window.location.href = "/admin/login.jsp";
				}else
				 if(jQuery.trim(data)=='state1' && tag==2){
				    alert('您是厂商，请通过厂商登录入口登录！');
				    window.location.href = "/admin/login.jsp";
				  }else{
					alert('帐号或者密码不正确！');
				}
			}
		});
	});
});
</script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs">您现在所在的位置：<a href="#">产品中心首页</a> &gt;&gt; 厂家登陆</h3>
</div>
<!--面包屑结束--> 
<!--广告-->
<div class="contain980 mb10"><img src="/images/ad04.jpg" width="980" height="60" /></div>
<!--广告结束--> 
<!--main-->
<div class="contain980 mb10">
  <div class="n_loginContain">
    <div class="nlc" style="border-right:#d7d7d7 1px dotted;">
      <h2>厂家登录</h2>
      <div class="text">
        请输入会员名及密码，按登录即可。<br />
        如有疑问请您拨打0535-6792733咨询。
      </div>
      <dl class="lcform">
        <form id="theform1" name="theform" method="post" action="/action/login_action.jsp">
          <dt>帐号</dt>
          <dd class="lcinput">
            <input type="text" name="usern" id="usern1" max="20"/>
          </dd>
          <dt>密码</dt>
          <dd class="lcinput">
            <input type="password" name="password" onkeydown="if(event.keyCode==13){jQuery('#login').click()}" id="password1" maxlength="20"/>
          </dd>
          <dd class="lcbtn">
            <input type="hidden" name="flag" value="login_factory"/>
            <input type="button" value="&nbsp;" id="login" tag="1"/>
            <input type="hidden" name="flag" value="login_factory" />
          </dd>
        </form>
      </dl>
    </div>
    <div class="nlc">
      <h2>代理商登录</h2>
      <div class="text">
        请输入会员名及密码，按登录即可。<br />
        如有疑问请您拨打0535-6792733咨询。
      </div>
      <dl class="lcform">
        <form id="theform2" name="theform" method="post" action="/action/login_action.jsp">
          <dt>帐号</dt>
          <dd class="lcinput">
            <input type="text" name="usern" id="usern2" max="20"/>
          </dd>
          <dt>密码</dt>
          <dd class="lcinput">
            <input type="password" name="password" onkeydown="if(event.keyCode==13){jQuery('#login').click()}" id="password2" maxlength="20"/>
          </dd>
          <dd class="lcbtn">
           <input type="hidden" name="flag"  value="login_agent"/>
            <input type="button" value="&nbsp;" id="login2" tag="2" />
            <input type="hidden" name="flag" value="login_factory" />
          </dd>
        </form>
      </dl>
    </div>
  </div>
  <div class="clear"></div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="true" />
<!--end of foot-->
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript">  
      
    //处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外  
    function banBackSpace(e){     
        var ev = e || window.event;//获取event对象     
        var obj = ev.target || ev.srcElement;//获取事件源     
        var t = obj.type || obj.getAttribute('type');//获取事件源类型    
        //获取作为判断条件的事件类型  
        var vReadOnly = obj.getAttribute('readonly');  
        var vEnabled = obj.getAttribute('enabled');  
        //处理null值情况  
        vReadOnly = (vReadOnly == null) ? false : vReadOnly;  
        vEnabled = (vEnabled == null) ? true : vEnabled;  
          
        //当敲Backspace键时，事件源类型为密码或单行、多行文本的，  
        //并且readonly属性为true或enabled属性为false的，则退格键失效  
        var flag1=(ev.keyCode == 8 && (t=="password" || t=="text" || t=="textarea")   
                    && (vReadOnly==true || vEnabled!=true))?true:false;  
         
        //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效  
        var flag2=(ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea")  
                    ?true:false;          
          
        //判断  
        if(flag2){  
            return false;  
        }  
        if(flag1){     
            return false;     
        }     
    }  
    //禁止后退键 作用于Firefox、Opera  
    document.onkeypress=banBackSpace;  
    //禁止后退键  作用于IE、Chrome  
    document.onkeydown=banBackSpace;  
    </script>  
</body>

</html>