<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*" pageEncoding="UTF-8"%>
<%@ include file="hm.jsp" %>
<%
_HMT _hmt = new _HMT("68a002ecc1238a0d146069ac0b00940e");
_hmt.setDomainName("m.product.21-sun.com");
_hmt.setHttpServletObjects(request, response);
String _hmtPixel = _hmt.trackPageview();
%>
<img src="<%= _hmtPixel %>" width="0" height="0"  />

<%@ include file="cs.jsp" %>
<%CS cs = new CS(5923031);cs.setHttpServlet(request,response);
String imgurl = cs.trackPageView();%> 
<img src="<%= imgurl %>" width="0" height="0"  />


<div ><script type="text/javascript">
var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://"); document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F68a002ecc1238a0d146069ac0b00940e' type='text/javascript'%3E%3C/script%3E")); </script></div>