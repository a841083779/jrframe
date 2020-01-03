<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<% 	
     
	DBHelper dbHelper = DBHelper.getInstance();
	Map	memberInfo = (Map) session.getAttribute("memberInfo");
	String username="";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
	}%>
<div class="kba_foot">
   <ul class="fix">
   	<li class="fico_4"><a href="http://m.product.21-sun.com/index.jsp?factory=136&catalog=101001" class="更多产品"></a></li>
    <li class="fico_3 bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more" title="分享"></a></li>
    <li class="fico_2"><a <%if(!username.equals("")){%>href="/koubei.jsp"<%}else{%>href="javascript:;" onclick="show_cim();"<%}%> title="我的口碑"></a></li>
    <li class="fico_1"><a <%if(!username.equals("")){%>href="javascript:alert('您已经登录！')"<%}else{%>href="/web_login_activity.jsp"<%}%> class="登录" title="登录"></a></li>
   </ul>
</div>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script>
function show_cim(){
alert('请您登陆后再进行操作，谢谢');window.location.href='/web_login_activity.jsp';}

function loginOut(){
	$.post("/action/ajax_mobile.jsp",{message:"exit"},function(data){
		if($.trim(data)=="loginOut"){
			 location.reload();
		}
	});
}
</script>