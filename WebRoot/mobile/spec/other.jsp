<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*" pageEncoding="UTF-8"%>

<%@ include file="cs.jsp" %>
<%CS cs = new CS(1252937888);cs.setHttpServlet(request,response);
String imgurl = cs.trackPageView();%> 
<img src="<%= imgurl %>" width="0" height="0"  />