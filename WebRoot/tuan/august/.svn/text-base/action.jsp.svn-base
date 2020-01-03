<%@ page language="java" import="org.json.*,java.util.*,java.sql.Connection,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.webservice.WEBEmail"%><%
	String flag = request.getParameter("flag");
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	try{
		connection = dbHelper.getConnection();
		if("login".equals(flag)){
			String phone = CommonString.getFormatPara(request.getParameter("phone"));
			String sql = " select count(*) from activities_reg where type_id = 4 and phone = ? ";
			Integer counts = (Integer)dbHelper.getOne(sql,new Object [] {
				phone
			},connection);
			//如果有该注册手机号，直接取出
			if(counts>0){
				Map tuan_august_login = new HashMap();
				tuan_august_login.put("phone",phone);
				tuan_august_login.put("name",CommonString.getFormatPara(request.getParameter("name")));
				tuan_august_login.put("company",CommonString.getFormatPara(request.getParameter("company")));
				session.setAttribute("_tuan_august_login",tuan_august_login);
			}else{//否则，先插入，再取出
				sql = " insert into activities_reg ( uuid , phone , name , reg_date , type_id , reg_ip , preferential_code ) ";
				sql += " values ( ? , ? , ? , ? , ? , ? , ? )";
				dbHelper.execute(sql,new Object [] {
					CommonString.getUUID(),
					phone,
					CommonString.getFormatPara(request.getParameter("name")),
					CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),
					4,
					Common.getIp(request),
					CommonString.getFormatPara(request.getParameter("company"))
				},connection);
				Map tuan_august_login = new HashMap();
				tuan_august_login.put("phone",phone);
				tuan_august_login.put("name",CommonString.getFormatPara(request.getParameter("name")));
				tuan_august_login.put("company",CommonString.getFormatPara(request.getParameter("company")));
				session.setAttribute("_tuan_august_login",tuan_august_login);
			}
			JSONObject obj = new JSONObject();
			obj.put("info","");
			obj.put("status","y");
			out.print(obj.toString());
		}
		if("panduan".equals(flag)){
			Map tuan_august_login = (Map)session.getAttribute("_tuan_august_login");
			String phone = "";
			String name = "";
			String company = "";
			String sql = " select count(*) from activities_record where type_id = 4 and phone = ? ";
			//如果已经登录了，取出帐号
			if(null!=tuan_august_login){
				phone = CommonString.getFormatPara(tuan_august_login.get("phone"));
				name = CommonString.getFormatPara(tuan_august_login.get("name"));
				company = CommonString.getFormatPara(tuan_august_login.get("company"));
				//次数
				Integer counts = (Integer)dbHelper.getOne(sql,new Object [] {
					phone
				},connection);
				Boolean insertRecord = true;
				//抽第一次，不中奖
				if(counts==0){
					out.print("no");
				}else if(counts==1){//抽第二次，中奖
					out.print("ok");
					//插入中奖记录
					sql = " insert into activities_winning ( type_id , phone ) ";
					sql += " values ( ? , ? ) ";
					dbHelper.execute(sql,new Object [] {
						4 , phone
					},connection);
					//发送邮件
					String content = phone+"中奖了，请注意联系，姓名："+name+"&nbsp;公司："+company;
					WEBEmail.sendMail("mujie@21-sun.com,sunfh@21-sun.com,songsn@21-sun.com,zangss@21-sun.com","八月优买团，梦想新航线，未来合伙人",content);
				}else if(counts==2){//抽第三次，不中奖
					out.print("no");
				}else{//次数超了
					out.print("over");
					insertRecord = false;
				}
				if(insertRecord){
					sql = " insert into activities_record ( type_id , phone , add_ip , add_date ) ";
					sql += " values ( ? , ? , ? , ? )";
					dbHelper.execute(sql,new Object []{
						4 , phone , Common.getIp(request),CommonDate.getToday("yyyy-MM-dd HH:mm:ss")
					},connection);
				}
			}else{
				//返回未登录
				out.print("noLogin");
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	
%>