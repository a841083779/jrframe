<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="org.json.JSONArray"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.common.CommonEncrypt"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jerehnet.action.PoolManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.jerehnet.util.common.CommonDate"%>
<%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String agent_name = CommonString.getFormatPara(request.getParameter("agent_name"));
	// String agent_pass = CommonEncrypt.MD5(CommonString.getFormatPara(request.getParameter("agent_pass")));
	String agent_pass = CommonString.getFormatPara(request.getParameter("agent_pass"));
	Connection conn = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map sessionMemberInfo = null;
	Map memberInfo = null;
	Map agentMemebrInfo = null;
	if (!"".equals(agent_pass)) {
		// agent_pass = CommonEncrypt.MD5(agent_pass);
	}
	String rand = CommonString.getFormatPara(request.getParameter("rand")); // 验证码
	String sessionRand = CommonString.getFormatPara(session.getAttribute("rand"));
	
	if (!sessionRand.equals(rand)) {
		out.println("0");
		return;
	}
	
	String sel_sql_member = "select * from pro_agent_factory where usern=? and passw_bak=?";
	try {
		conn = PoolManager.getInstance().getConnection();
		if (!"".equals(agent_name) && !"".equals(agent_pass)) {
			sessionMemberInfo = dbHelper.getMap(sel_sql_member, new Object[] { agent_name ,agent_pass}, conn);
		}
		if(null!=sessionMemberInfo && sessionMemberInfo.size()>0){
			boolean probation = false ;   
			String nowdate=CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
			String probation_date = CommonString.getFormatPara(sessionMemberInfo.get("probation_date")) ;
			if(probation_date.length()>15){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date d = sdf.parse(probation_date);  // 过期日期
				probation = d.before(sdf.parse(nowdate)); 
			}
			if(probation && CommonString.getFormatPara(sessionMemberInfo.get("is_shop")).equals("1")){ // 只有免费版才有到期日期
				out.println("5") ; // 已过期 
			}else 
			if(CommonString.getFormatPara(sessionMemberInfo.get("flag")).equals("2")&&(CommonString.getFormatPara(sessionMemberInfo.get("is_shop")).equals("1")||CommonString.getFormatPara(sessionMemberInfo.get("is_shop")).equals("2")||CommonString.getFormatPara(sessionMemberInfo.get("is_shop")).equals("3"))){
				out.println("1") ; // 代理商开通旗舰店
			}else if(CommonString.getFormatPara(sessionMemberInfo.get("flag")).equals("1") &&(CommonString.getFormatPara(sessionMemberInfo.get("is_shop")).equals("")||CommonString.getFormatPara(sessionMemberInfo.get("is_shop")).equals("0"))){
				out.println("3") ;  // 厂家没开通旗舰店
			}else if(CommonString.getFormatPara(sessionMemberInfo.get("flag")).equals("1") &&(CommonString.getFormatPara(sessionMemberInfo.get("is_shop")).equals("1")||CommonString.getFormatPara(sessionMemberInfo.get("is_shop")).equals("2")||CommonString.getFormatPara(sessionMemberInfo.get("is_shop")).equals("3")||CommonString.getFormatPara(sessionMemberInfo.get("is_shop")).equals("4"))){
				out.println("4") ;  // 厂家开通旗舰店
			}
			return ;
		}else{
			out.println("2") ; // 代理商没有开通旗舰店
			return ;
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		DBHelper.freeConnection(conn);
	}
%>

