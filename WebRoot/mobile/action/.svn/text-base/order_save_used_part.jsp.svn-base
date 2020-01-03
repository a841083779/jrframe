<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.util.Map"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%
	response.setContentType("text/html; charset=UTF-8");
	String randValue = Common.securityFilter(CommonString.getFormatPara(request.getParameter("rand"))).toLowerCase() ;
	String rand = Common.securityFilter(CommonString.getFormatPara(session.getAttribute("rand"))).toLowerCase() ;
	String url = Common.securityFilter(CommonString.getFormatPara(request.getHeader("referer"))) ;
	
    String zd_name = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_name"))) ;
	String zd_mobile_phone = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_mobile_phone"))) ;
	String zd_contact_address = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_contact_address"))) ;
	String zd_message = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_message"))) ;
	String zd_pro = Common.securityFilter(CommonString.getFormatPara(request.getParameter("zd_proname"))) ;
     System.out.println("123213"+zd_pro);
	
	if(!randValue.equals(rand) && url.indexOf("showinqueryresult.jsp")==-1 && url.indexOf("/agent") == -1){  // 验证码不正确
		out.println("<script>alert('请您输入正确的验证码!');history.back();</script>") ;
		return ;
	}
	request.setCharacterEncoding("utf-8");
	WEBEmail.sendMailByUrl("zengfc@21-sun.com", null, null, zd_pro + "询价单  -  来自中国工程机械商贸网优买团活动订单",
											"http://product.21-sun.com/tools/email/email_detail_special.jsp?zd_name=" + zd_name+"&zd_mobile_phone="+zd_mobile_phone+"&zd_contact_address="+zd_contact_address+"&zd_message="+zd_message+"&zd_pro="+zd_pro, "utf-8");
											

		%>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<script type="text/javascript"> 
						    parent.jQuery.jBox.tip("询价成功！") ;
    						parent.window.jBox.close();
</script>