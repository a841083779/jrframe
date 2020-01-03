<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.net.URLEncoder,com.jerehnet.util.dbutil.DBHelper" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.mobile.action.*"%><%	
 
	DBHelper dbHelper = DBHelper.getInstance() ;
	CommonAction comAc=new CommonAction();

	String ua = ((HttpServletRequest) request).getHeader("user-agent").toLowerCase();
    if (ua.indexOf("micromessenger")==-1) {// 是微信浏览器
		response.sendRedirect("noweixin.jsp");
		return;
	}
	
	String openId= CommonString.getFormatPara(request.getParameter("sqopenid"));
	String headimgurl= CommonString.getFormatPara(request.getParameter("headimgurl"));
	String nickname= CommonString.getFormatPara(request.getParameter("nickname"));
    String  uid = CommonString.getFormatPara(session.getAttribute("wx_id"));
	
	if(uid==null||uid.equals("")){
	if(openId==null||openId.equals("")){
		String url=request.getScheme()+"://"+request.getHeader("host")+request.getRequestURI();  
		String paramsStr=request.getQueryString();
		if(paramsStr!=null&&!paramsStr.equals("")){
			url+="?"+request.getQueryString();
		}
		String enurl=URLEncoder.encode(url);
        response.sendRedirect("http://xxlfront.jerei.com/auth_head_tt.jsp?back="+enurl);//
	    return;
    }else{
    	System.out.println("openId:"+openId);
		session.setAttribute("wx_id", openId); 
		session.setAttribute("nickname", nickname); 
		session.setAttribute("wxImg", headimgurl); 
	}
	}
	
	comAc.isBindingWX(request,response);
		

 
%>
