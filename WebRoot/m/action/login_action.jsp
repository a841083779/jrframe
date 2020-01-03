<%@ page language="java" import="com.jerehnet.util.images.*,org.json.*,org.apache.commons.io.FileUtils,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*,java.io.File" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	Connection conn = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map factoryInfo = (Map)session.getAttribute("factoryInfo");
	Map agentInfo = (Map)session.getAttribute("agentInfo");
	String rs = "fail";
	try{
		conn = dbHelper.getConnection();
		conn.setAutoCommit(false);
		//厂家登录
		if("login_factory".equals(flag)){
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			String password = CommonString.getFormatPara(request.getParameter("password"));
			if(!"".equals(password)){
				 password = CommonEncrypt.MD5(password) ;
			}
			factoryInfo = dbHelper.getMap(" select * from "+tablePrefix+"agent_factory where 1 = 1 and usern = ? and passw = ? ",new Object [] {usern,password},conn);
			if(null!=factoryInfo){
				if(CommonString.getFormatPara(factoryInfo.get("flag")).equals("2")){//厂家登录页面、代理商帐号
					rs = "state0";
				}else if(CommonString.getFormatPara(factoryInfo.get("flag")).equals("1")){
					session.setAttribute("factoryInfo",factoryInfo);
					Map postMap = new HashMap();
					postMap.putAll(request.getParameterMap());
					postMap.put("uuid",factoryInfo.get("uuid"));
					//Common.doPostHttpAsync(Common.getDomain(request)+"/backend/action/log.jsp",postMap);
					//修改最后登录信息
					String sql = " UPDATE "+tablePrefix+"agent_factory SET login_count = isnull(login_count,0)+1 , last_login_date = '"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"' , last_login_ip = '"+Common.getIp(request,1)+"' ";
					sql += " WHERE id = ? ";
					dbHelper.execute(sql,new Object [] {factoryInfo.get("id")},conn);
					rs = "factoryok";
				}
			}
		}
		//代理商登录
		if("login_agent".equals(flag)){
			String usern = CommonString.getFormatPara(request.getParameter("usern"));
			String password = CommonString.getFormatPara(request.getParameter("password"));
			if(!"".equals(password)){
				password = CommonEncrypt.MD5(password) ;
			}
			agentInfo = dbHelper.getMap(" select * from "+tablePrefix+"agent_factory where 1 = 1 and usern = ? and passw = ? ",new Object [] {usern,password},conn);
			if(null!=agentInfo){
				if(CommonString.getFormatPara(agentInfo.get("flag")).equals("1")){
					rs = "state1";
				}else if(CommonString.getFormatPara(agentInfo.get("flag")).equals("2")){
					session.setAttribute("agentInfo",agentInfo);
					Map postMap = new HashMap();
					postMap.putAll(request.getParameterMap());
					postMap.put("uuid",agentInfo.get("uuid"));
					//Common.doPostHttpAsync(Common.getDomain(request)+"/backend/action/log.jsp",postMap);
					//修改最后登录信息
					String sql = " UPDATE "+tablePrefix+"agent_factory SET login_count = isnull(login_count,0)+1 , last_login_date = '"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"' , last_login_ip = '"+Common.getIp(request,1)+"' ";
					sql += " WHERE id = ? ";
					dbHelper.execute(sql,new Object [] {agentInfo.get("id")},conn);
					rs = "agentok";
				}
			}
		}
		conn.commit();
	}catch(Exception e){
		conn.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(conn);
	}
	out.print(rs);
%>