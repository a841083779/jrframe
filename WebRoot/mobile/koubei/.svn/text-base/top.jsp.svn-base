<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%>
<%	
     
	DBHelper dbHelper = DBHelper.getInstance();
	Map	memberInfo = (Map) session.getAttribute("memberInfo");%>
<header>
  <%if(memberInfo==null){ %>
  <h2 class="logo"><a href="http://m.product.21-sun.com"><img src="Static/img/logo.png" alt="铁臂商城"></a></h2>
  <a href="javascript:;" onclick="backs()" class="bc"><img src="Static/img/back.png"></a>
  <span class="logreg"><a href="web_login.jsp" class="tlog">登录</a><a href="web_reg.jsp" class="treg">注册</a></span>
     <%}else{ %>
	  <form>
	  <h2 class="logo"><img src="Static/img/logo.png" alt="铁臂商城"></h2>
  <a  href="javascript:;" onclick="backs()"  class="bc"><img src="Static/img/back.png"></a>
   <span class="logreg"> <%=CommonString.getFormatPara(memberInfo.get("username")) %>&nbsp; <input type="button" style="cursor:pointer;" class="sub" value=" 退出 " onclick="loginOut();" /></span>
 
  
	  </form>
	  <%}%>
</header>
<script>
function backs(){
history.back();
}
</script>
