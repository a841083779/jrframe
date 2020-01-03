<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<% 	
     
	DBHelper dbHelper = DBHelper.getInstance();
	Map	memberInfo = (Map) session.getAttribute("memberInfo");%>
<div class="kba_top">
 <%if(memberInfo==null){ %>
	<a href="javascript:;" onclick="backs()" class="goback"><img src="img/goback.png"/> 返回</a>
	<h2 class="logo">铁臂口碑</h2>
    <a href="/web_login.jsp" class="login">登录</a>
    <a href="/web_reg.jsp" class="reg">注册</a>
	<%}else{%>
	 <form>
  <a href="javascript:;" onclick="backs()"  class="goback"><img src="img/goback.png"></a>
  <h2 class="logo">铁臂口碑</h2>
   <span class="logreg" style="float: right;margin-top: -25px;"> <%=CommonString.getFormatPara(memberInfo.get("username")) %>&nbsp; <input type="button" style="cursor:pointer;" class="sub" value=" 退出 " onclick="loginOut();" /></span>
   </form>
	  <%}%>
</div>
<div class="kba_banner">
	<img src="img/banner.jpg" alt=""/>
</div>
<script>
function backs(){
history.back();
}
function loginOut(){

}
</script>