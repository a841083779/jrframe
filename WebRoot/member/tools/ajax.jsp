<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String rs = "fail";
	String callback = CommonString.getFormatPara(request.getParameter("callback"));
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	
	
	try{
		connection = dbHelper.getConnection(); 	
	     
		//用户注册
		if("regist".equals(flag)){
			String zd_username = CommonString.getFormatPara(request.getParameter("zd_username"));
			String zd_password = CommonString.getFormatPara(request.getParameter("zd_password"));
			String zd_telephone = CommonString.getFormatPara(request.getParameter("zd_telephone"));
			String zd_address = CommonString.getFormatPara(request.getParameter("zd_address"));
			String randValue = CommonString.getFormatPara(request.getParameter("auth"));
			rs = (String)session.getAttribute("rand");
			if(rs.equals(randValue)){
				String sql = " insert into pro_member (add_date,add_ip,add_user,username,password,telephone,address,state) ";
				sql += " values (?,?,?,?,?,?,?,?) ";
				int r = dbHelper.execute(sql,new Object []{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),zd_username,zd_username,zd_password,zd_telephone,zd_address,1},connection);	
				if(r>0){
					rs = "ok";	
					Map memberInfo = dbHelper.getMap("select * from pro_member where username = ?", new Object[] { zd_username }, connection);
					if (null != memberInfo) {
						session.setAttribute("memberInfo", memberInfo);
					}
				}else{
					rs = "no";	
				}
			}else{
				rs = "rand";	
			}
		}
		//退出
		if(flag.equals("logout")){
			session.removeAttribute("memberInfo");
		}
		//登录
		if(flag.equals("login")){
			String username = CommonString.getFormatPara(request.getParameter("u"));
			String password = CommonString.getFormatPara(request.getParameter("p"));
			Map memberInfo = dbHelper.getMap("select * from pro_member where username = ? and password = ?", new Object[] { username, password }, connection);
			if (null != memberInfo) {
				if (memberInfo.get("state").equals(0)) {
					rs = "state0";
				} else {
					session.setAttribute("memberInfo", memberInfo);
					//修改最后登录信息
					String sql = "UPDATE pro_member SET login_count = isnull(login_count,0)+1 , last_login_date = '" + CommonDate.getToday("yyyy-MM-dd HH:mm:ss") + "' , last_login_ip = '" + Common.getIp(request) + "'";
					sql += " WHERE id = ? ";
					dbHelper.execute(sql, new Object[] { memberInfo.get("id") }, connection);
					rs = "ok";
				}
			}else{
				rs = "no";
			}
		}
		//登录
		if(flag.equals("isLogin")){
			Map memberInfo = (Map)session.getAttribute("memberInfo");
			String username = "";
			if(memberInfo != null){
				username = CommonString.getFormatPara(memberInfo.get("username"));
			}
			if (!username.equals("")) {
				rs = "ok";
			}else{
				rs = "no";
			}
		}
		//新产品评论保存
		if("new_save_comment".equals(flag)){
			Map memberInfo = (Map)session.getAttribute("memberInfo");
			String username = "";
			if(memberInfo != null){
				username = CommonString.getFormatPara(memberInfo.get("username"));
			}
			 if(referer.indexOf("http://product.21-sun.com")==-1){
		    	//  return ;
			 }
			 if(username.equals("")){
				 out.println("login") ;
					return ; 
			 }
			String sql = " insert into pro_comments (add_user, add_date, add_ip, name, content, product_id, score1, score2, score3, score4, is_show, is_buy,is_noname,uuid,username) ";
			sql += " values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
			String content = CommonString.getFormatPara(request.getParameter("content")) ; // 输入的内容
			String html_reg  = "<[^>]*>|&lt;[^(&gt;)]*&gt;"; // 过滤所有以<开头以>结尾的标签  &lt;&gt;
			Pattern pattern = Pattern.compile(html_reg);  
			Matcher matcher = pattern.matcher(content);  
			if(matcher.find()){
				return ;
			}else{
				boolean filter = Common.filterKeyWords(request) ;
				if(filter){
					out.println("no") ;
					return ; 
				}
			}
			int keyId = dbHelper.executeUpdate(sql,new Object []{"comment",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),CommonString.getFormatPara(request.getParameter("name")),CommonString.getFormatPara(request.getParameter("content")),CommonString.getFormatPara(request.getParameter("product_id")),CommonString.getFormatPara(request.getParameter("score1")),CommonString.getFormatPara(request.getParameter("score2")),CommonString.getFormatPara(request.getParameter("score3")),CommonString.getFormatPara(request.getParameter("score4")),1,CommonString.getFormatPara(request.getParameter("is_buy")),CommonString.getFormatPara(request.getParameter("is_noname")),UUID.randomUUID().toString(),username},connection);
			 connection.setAutoCommit(false);
			if(!username.equals("")){
					String sqlStr = " insert into pro_comments_image ( add_date , add_user , add_ip, comment_id , image_small , image , is_show) ";
					sqlStr += " values ( ? , ? , ? , ? , ? , ? , ? )";
					String [] imgs = request.getParameterValues("img");
					if(null!=imgs&&imgs.length>0){
						for(int i=0;i<imgs.length;i++){
							int rb = dbHelper.execute(sqlStr,new Object [] {
									CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),username,Common.getIp(request),keyId,Common.getSmallImg(imgs[i]),imgs[i],1
								},connection);
						}
					}
				}
			connection.commit();
		}
		
		
		//新增
		//发布说说
		if(flag.equals("pubTalk")){
		String content = CommonString.getFormatPara(request.getParameter("content"));
		String add_user = CommonString.getFormatPara(request.getParameter("add_user"));
		String sql = " insert into pro_member_talk (add_user,add_date,add_ip,content,is_show) ";
		sql += " values (?,?,?,?,?) ";
		int r = dbHelper.execute(sql,new Object []{add_user,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),content,1},connection);	
		if(r>0){
			 rs = "ok";	
        }else{
			rs = "no";	
		}	
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>