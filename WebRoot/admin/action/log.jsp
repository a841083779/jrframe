<%@ page language="java" import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,java.sql.*" pageEncoding="UTF-8"%><%
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String logFlag = CommonString.getFormatPara(request.getParameter("logFlag"));
	DBHelper dbHelper = DBHelper.getInstance();
	Map factoryInfo = (Map)session.getAttribute("factoryInfo");
	Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		if(null==factoryInfo){
			String uuid = CommonString.getFormatPara(request.getParameter("uuid"));
			factoryInfo = dbHelper.getMap(" select * from "+table_prefix+"common_user where uuid = ? ",new Object [] {uuid},connection);
		}
		String channelNo = CommonString.getFormatPara(request.getParameter("channel_no"));
		String channelName = "";
		if(!"".equals(channelNo)){
			Map channel = dbHelper.getMap(" select top 1 name from "+table_prefix+"common_channel where no = ? ",new Object [] {channelNo},connection);
			if(null!=channel){
				channelName = (String)channel.get("name");
			}
		}
		String logSql = "";
		List logs = new ArrayList(0);
		Map model = null;
		//增加日志
		if("101001".equals(logFlag)){
			String keyId = CommonString.getFormatPara(request.getParameter("keyId"));
			logSql = " select * from "+tableName+" where id = ? ";
			model = dbHelper.getMap(logSql,new Object [] {keyId},connection);
			logs.add(model);
		}
		//删除日志
		if("101003".equals(logFlag)){
			String ids = CommonString.getFormatPara(request.getParameter("del_id"));
			logSql = " select * from "+tableName+" where uuid in ("+ids+") ";
			logs = dbHelper.getMapList(logSql,connection);
		}
		//修改日志
		if("101002".equals(logFlag)){
			String keyId = CommonString.getFormatPara(request.getParameter("keyId"));
			logSql = " select * from "+tableName+" where id = ? ";
			model = dbHelper.getMap(logSql,new Object [] {keyId},connection);
			logs.add(model);
		}
		logSql = " INSERT INTO "+table_prefix+"common_log ( add_user , add_date , add_ip , uuid , channel_name , content , type , log_level ) ";
		logSql += " VALUES ( ? , ? , ? , ? , ? , ? , ? , ? ) ";
		//登录日志
		if("101004".equals(logFlag)){
			dbHelper.execute(logSql,new Object [] {
					factoryInfo.get("usern"),
					CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),
					Common.getIp(request),
					CommonString.getUUID(),
					"用户登录",
					factoryInfo.get("usern").toString()+"登录",
					"101004",
					0
				},connection);
		}else{
			if(null!=logs&&logs.size()>0){
				Object [] [] params = new Object [logs.size()] [8];
				for(int i=0;i<logs.size();i++){
					model = (Map)logs.get(i);
					params[i][0]=factoryInfo.get("usern");
					params[i][1]=CommonDate.getToday("yyyy-MM-dd HH:mm:ss");
					params[i][2]=Common.getIp(request);
					params[i][3]=CommonString.getUUID();
					params[i][6]=logFlag;
					if(tableName.equals(table_prefix+"common_user")){
						params[i][4]="用户管理";
						params[i][5]=model.get("usern");
					}else if(tableName.equals(table_prefix+"common_enum")){
						params[i][4]="枚举管理";
						params[i][5]=model.get("name");
					}else if(tableName.equals(table_prefix+"common_channel")){
						params[i][4]="频道管理";
						params[i][5]=model.get("name");
					}else if(tableName.equals(table_prefix+"common_role")){
						params[i][4]="角色管理";
						params[i][5]=model.get("role_name");
					}else if(!"".equals(channelName)){
						params[i][4]=channelName;
						if(channelNo.equals("101006")){//我的用户
							params[i][5]=model.get("name");
						}else if(channelNo.equals("101007")){//文件管理
							params[i][5]=model.get("new_name");
						}
					}else{
						params[i][4]=tableName;
						params[i][5]="";
						params[i][7]=1;
					}
					params[i][7]=0;
				}
				dbHelper.executeBatch(logSql,params,connection);
			}	
		}
		connection.commit();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>