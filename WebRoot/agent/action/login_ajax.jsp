<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.common.CommonEncrypt"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.action.PoolManager"%>
<%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String agent_pass = CommonString.getFormatPara(request.getParameter("agent_pass"));
	String agent_name = CommonString.getFormatPara(request.getParameter("agent_name")) ;
	Connection conn = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map sessionMemberInfo = null;
	Map memberInfo = null;
	Map agentMemebrInfo = null;
	String rand = CommonString.getFormatPara(request.getParameter("rand")); // 验证码
	String sessionRand = CommonString.getFormatPara(session.getAttribute("rand"));
	String sel_sql = null ;
	if(!rand.equals(sessionRand)){
		out.println("{\"info\":\"验证码不正确!\",\"status\":\"n\"}") ;
		return ;
	}
	try {
		conn = PoolManager.getInstance().getConnection();
		sel_sql = "select count(*) total from member_info where mem_no=? and password_bak=?" ;
		if(!"".equals(agent_name) && !"".equals(agent_pass)){
			if(Integer.parseInt(CommonString.getFormatPara(dbHelper.getMap(sel_sql,new Object[]{agent_name,agent_pass},conn).get("total")))>0){
				out.println("{\"info\":\"登录成功!\",\"status\":\"y\"}") ;
				return ;
			}else{
				out.println("{\"info\":\"账号不存在!\",\"status\":\"n\"}") ;
				return ;
			}
		}

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		DBHelper.freeConnection(conn);
	}
%>

