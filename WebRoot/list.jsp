<%@ page language="java" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.dbutil.DBHelper,com.jerehnet.util.common.CommonString,java.util.*,org.json.*" pageEncoding="UTF-8"%>

<%

	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	String catalogid = CommonString.getFormatPara(request.getParameter("catalogid"));
	if(factoryid.equals("")){factoryid="0";}
    if(catalogid.equals("")){catalogid="0";}
	String url="";
	if(factoryid.equals("0")&&catalogid.equals("0")){
		url="/products/prolist.jsp";
	}
	if(!factoryid.equals("0")&&catalogid.equals("0")){
		url="/products/prolist.jsp?factory="+factoryid;
	}
	if(factoryid.equals("0")&&!catalogid.equals("0")){
		url="/products/prolist.jsp?catalog="+catalogid;
	}
	if(!factoryid.equals("0")&&!catalogid.equals("0")){
		url="/products/prolist.jsp?factory="+factoryid+"&catalog="+catalogid;
	}
	response.setStatus(301);
	response.setHeader("Location", url);
	
%>