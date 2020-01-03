<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%
DBHelper dbHelper = null;
	String sql = "", message = "", result = "",requestIp="";
	
	//获取数据库连接
	dbHelper = DBHelper.getInstance();
	//获取请求操作类型
	message = request.getParameter("message");
	Connection connection = null;
	//获取表名前缀
	String table_prefix = "pro_";
	Map memberInfo = null;
	String uid="";
	int per_count=0;
	if (session.getAttribute("memberInfo") != null) {
		memberInfo = (Map) session.getAttribute("memberInfo");
		uid = CommonString.getFormatPara(memberInfo.get("id"));
	} else {
		memberInfo = null;
	}
	
	requestIp = request.getHeader("X-Real-IP");
	if (requestIp == null) {
		requestIp = Common.getIp(request);
	}
	try {
	connection = dbHelper.getConnection();
		//用户登陆
		if ("login".equals(message)) {
		System.out.println("111111111");
			String username = request.getParameter("zd_username");
			String password = request.getParameter("zd_password");
			System.out.println(username+"'''''''''"+username);
			Object[] params = new Object[] { username, password };
			sql = "select * from " + table_prefix + "member where username=? and password=?";
			memberInfo = dbHelper.getMap(sql, params);
			if (memberInfo != null) {
				String url = CommonString.getFormatPara(request.getParameter("url"));
			
				session.setAttribute("memberInfo", memberInfo);
				System.out.println("2222222");
				%>
						<script>
					   alert("XXXXXXX="+document.referrer );
					  	alert("成功登陆！");
						window.location.href=document.referrer;
						</script>
						<%
			} else {
				%>
						<script>
					window.location.href=document.referrer;
						</script>
						<%
			}
		}
		
		//验证用户名是否存在
		if ("checkUserName".equals(message)) {
			String user_no = request.getParameter("username");
			if (user_no != null) {
				//user_no = Tool.valueFilter(user_no);
				sql = "select count(*) as counts from " + table_prefix + "member where username='" + user_no + "'";
				Map count = dbHelper.getMap(sql);
				if (Integer.valueOf((count.get("counts")).toString()) > 0) {
					result = "yes";
				} else {
					result = "no";
				}
			} else {
				result = "no";
			}
		}
		
		//验证码
		if("rand".equals(message)){
			Common.getAuthImg(request, response);
			out.clear();
			out = pageContext.pushBody();
			return;
		}
		//验证电话号码唯一
		if ("checkPhoneNum".equals(message)) {
			String phone_num = request.getParameter("phone_num");
			if (phone_num != null) {
				//phone_num = Tool.valueFilter(phone_num);
				sql = "select count(*) as counts from " + table_prefix + "member where telephone='" + phone_num + "'";
				Map count = dbHelper.getMap(sql);

				if (Integer.valueOf((count.get("counts")).toString()) > 0) {
					result = "yes";
				} else {
					result = "no";
				}
			} else {
				result = "no";
			}
		}
		
	
			//用户注册
		if ("regist".equals(message)) {
				String user_no = request.getParameter("zd_username");
				String zd_telephone = request.getParameter("zd_telephone");
				String zd_password = request.getParameter("zd_password");
				 System.out.println(zd_telephone);
				List<Map> list = dbHelper.getMapList("select *  from " + table_prefix + "member where username='" + user_no + "' or telephone='" + zd_telephone + "'");
				if (list.size() == 0||user_no.equals("")||zd_telephone.equals("")) {
				sql = " insert into pro_member (add_date,add_ip,add_user,username,password,telephone,state) ";
				sql += " values (?,?,?,?,?,?,?) ";
				int r = dbHelper.execute(sql,new Object []{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),user_no,user_no,zd_password,zd_telephone,1},connection);				
				if(r>0){
						String usern = request.getParameter("zd_username");
						String password = request.getParameter("zd_password");
						Object[] pam = new Object[] { usern, password };
						sql = "select * from " + table_prefix + "member where username=? and password=?";
						memberInfo = dbHelper.getMap(sql, pam);
						//用户注册后自动登录
						session.setAttribute("memberInfo", memberInfo);
						//Tool.log((memberInfo.get("user_no")).toString(), requestIp, "", Integer.toString(id), "注册/登录");
						%>
						<script>
						alert("注册成功！");
						window.location.href=document.referrer;
						</script>
						<%
						
					}
				} else {
				%>
						<script>
						alert("注册失败，请重新注册！");
						window.location.href=document.referrer;
						</script>
						<%
				}}
				
		//退出网站
		if ("exit".equals(message)) {
			if(memberInfo!=null){
				session.invalidate();
				//Tool.log((memberInfo.get("user_no")).toString(), requestIp, "", "", "退出");
				result = "loginOut";
			}else{
				result = "loginOut";
			}
		}
			
	} catch (Exception e) {
		e.printStackTrace();
		result = "网络连接有点小问题,请您稍候片刻...";
	} finally {
		out.print(result);
	}
%>