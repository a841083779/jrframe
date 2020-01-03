<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.alipay.util.*"%>

<%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
		String ipTest=Common.getIp(request,1);
	if(ipTest.equals("123.206.20.202")){return;}
	if(ipTest.equals("119.28.71.247")){return;}
	String rs = "fail";
	String callback = CommonString.getFilterStr(request.getParameter("callback"));
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Map brandProMap=(Map)application.getAttribute("brandProMap");
	if(brandProMap==null){
		brandProMap=new HashMap();
	}

	
	try{
		connection = dbHelper.getConnection(); 	
		//厂家营销宝开通，基础版及以上 
		if("brandShopRec".equals(flag)){  
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			if(!factoryid.equals("")){
				rs = "";
				Map brandM = (Map)dbHelper.getMap(" select usern,name,logo from pro_agent_factory where id = '"+factoryid+"' and is_shop >= 2 and is_qijiandian = 1 ",connection);
				if(brandM != null && brandM.get("usern") != null){
			%>
			<h3><span class="l"><a target="_blank" href="http://product.21-sun.com/brandshop/<%=CommonString.getFormatPara(brandM.get("usern"))%>/"><img src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(brandM.get("logo"))%>" alt="<%=CommonString.getFormatPara(brandM.get("name"))%>官方旗舰店"/></span><%=CommonString.getFormatPara(brandM.get("name"))%>官方旗舰店</a></h3>
            <a target="_blank" href="http://product.21-sun.com/brandshop/<%=CommonString.getFormatPara(brandM.get("usern"))%>/" class="bsBtn">进入品牌旗舰店</a>	
    		<%
				}
			}
		}
		
		//更新浏览次数并返回浏览次数
		if("viewCount".equals(flag)){
		 
		}
		
		//返回产品总数
		if("proCount".equals(flag)){
 
		}
		
		//返回订单次数
		if("orderCount".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			Integer orderCount = (Integer)dbHelper.getOne(" select count(*) from "+tableName+" where product_id = ? ",new Object [] {id},connection);
			if(orderCount != null && orderCount > 0){
				rs = "<font>"+orderCount+"</font>份在线询价单";
			}else{
				rs = "";	
			}
		}
		
		//厂家电话
		if("tel".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			id = id.replace(" ","").replace("'","").replace("\"","");
			String tel = (String)dbHelper.getOne(" select telphone from "+tableName+" where id = ? ",new Object [] {id},connection);
			rs = tel;
		}
		
		//产品评论保存
		if("save_comment".equals(flag)){
			 if(referer.indexOf("http://product.21-sun.com")==-1){
		    	//  return ;
			 }
			String sql = " insert into pro_comments (add_user, add_date, add_ip, name, content, product_id, score1, score2, score3, score4, is_show, is_buy,is_noname,uuid) ";
			sql += " values (?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
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
			 dbHelper.execute(sql,new Object []{"comment",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),CommonString.getFormatPara(request.getParameter("name")),CommonString.getFormatPara(request.getParameter("content")),CommonString.getFormatPara(request.getParameter("product_id")),CommonString.getFormatPara(request.getParameter("score1")),CommonString.getFormatPara(request.getParameter("score2")),CommonString.getFormatPara(request.getParameter("score3")),CommonString.getFormatPara(request.getParameter("score4")),1,CommonString.getFormatPara(request.getParameter("is_buy")),CommonString.getFormatPara(request.getParameter("is_noname")),UUID.randomUUID().toString()},connection);
		}
		
		//获得评论总分及平均分
		if("get_all_comment".equals(flag)){
			String product_id = CommonString.getFormatPara(request.getParameter("pid"));
		    Map sessionId = new HashMap();
			sessionId.put("pid",product_id);
			String sql = " select avg(score1) as score1,avg(score2) as score2,avg(score3) as score3,avg(score4) as score4,count(*) as counts ";
			sql += " from pro_comments ";
			sql += " where is_show = 1 and product_id = " + product_id;
			ResultSet rs1 = dbHelper.executeQuery(sql,connection);
			StringBuffer sBuffer = new StringBuffer();
			String score1 = "";
			String score2 = "";
			String score3 = "";
			String score4 = "";
			String countsStr = "";
			if(null!=rs1 && rs1.next()){
				score1 = CommonString.getFormatPara(rs1.getString("score1"));
				if("".equals(score1)){
					score1 = "0";
				}
				score2 = CommonString.getFormatPara(rs1.getString("score2"));
				if("".equals(score2)){
					score2 = "0";
				}
				score3 = CommonString.getFormatPara(rs1.getString("score3"));
				if("".equals(score3)){
					score3 = "0";
				}
				score4 = CommonString.getFormatPara(rs1.getString("score4"));
				if("".equals(score4)){
					score4 = "0";
				}
				countsStr = CommonString.getFormatPara(rs1.getString("counts"));
				if("".equals(countsStr)){
					countsStr = "0";
				}
				sBuffer.append("{");
				sBuffer.append("\"score1\":\""+score1+"\",");
				sBuffer.append("\"score2\":\""+score2+"\",");
				sBuffer.append("\"score3\":\""+score3+"\",");
				sBuffer.append("\"score4\":\""+score4+"\",");
				sBuffer.append("\"counts\":\""+countsStr+"\"");
				sBuffer.append("},");
			}
			if(null!=rs){
				rs1.close();
			}
			if(sBuffer.indexOf(",")!=-1){
				sBuffer.setLength(sBuffer.length()-1);
			}
			rs = callback+"("+sBuffer.toString()+")";
		}
		if("showrelatecatalog".equals(flag)){
			StringBuffer sBuffer = new StringBuffer("") ;
			String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			List<Map> catalogList = dbHelper.getMapList(" select  catalognum,catalogname,factoryname from pro_products where factoryid='"+factoryid+"'  and len(catalognum)=6   group by catalognum,catalogname,factoryname",connection) ;
			if(null !=catalogList && catalogList.size()>0){
				for(Map oneMap:catalogList){
					sBuffer.append("<li><a href='list.jsp?factoryid="+factoryid+"&catalogid="+CommonString.getFormatPara(oneMap.get("catalognum"))+"'>"+CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"图片</a></li>") ;
				}
			}
			rs = sBuffer.toString() ;
		}
		
		if("showrelatebrand".equals(flag)){
 
		}
		
		if("testRand".equals(flag)){
			if(!CommonString.getFormatPara(request.getParameter("randValue")).equals(session.getAttribute("rand"))){
				rs = "randfalse" ;
			}else{
				rs = "randok" ;
			}
		}
		// 是否可以提交评论（防止多次重复提交）
		if(flag.equals("ifcancomments")){
			String myip = CommonString.getFormatPara(request.getParameter("myip")) ;
			String caseid = CommonString.getFormatPara(request.getParameter("caseid")) ;
			String sel_sql = " select count(*) total from pro_case_news_reply where add_ip=? and case_news_id=?" ;
			if(!"".equals(myip)){
				if(Integer.parseInt(CommonString.getFormatPara(dbHelper.getMap(sel_sql,new Object[]{myip,caseid},connection).get("total")))>0){
					rs = "1"  ;
				}else{
					rs = "0" ;
				}
			}
		}
		if("changeonefield".equals(flag)){
			String uuid = CommonString.getFormatPara(request.getParameter("id"));
			String field = CommonString.getFormatPara(request.getParameter("field")) ;
			dbHelper.execute(" update "+tableName+" set "+field+" = isnull("+field+",0)+1 where id = ? ",new Object [] {uuid},connection);
			Integer Count = (Integer)dbHelper.getOne(" select "+field+" from "+tableName+" where id = ? ",new Object [] {uuid},connection);
			rs = ""+Count;
		}
		if("order_buy_time".equals(flag)){
			String buy_time = CommonString.getFormatPara(request.getParameter("buy_time")) ;
			JSONArray js = new JSONArray();
			List<Map> enumList = (ArrayList)application.getAttribute("enumList") ;
			for(Map oneMap:enumList){
				if(CommonString.getFormatPara(oneMap.get("parent_no")).equals("102")){
					js.put(oneMap) ;
				}
			}
			out.print(js) ;
			return ;
		}
		if("pushToreComm".equals(flag)){
			String idStr = CommonString.getFormatPara(request.getParameter("idStr")) ;
			String optflag = CommonString.getFormatPara(request.getParameter("optflag")) ;  // 操作标识 1 推荐 0取消
			String agentid = CommonString.getFormatPara(request.getParameter("agentid")) ;
			String sel_sql = "update pro_agent_products set recommend=1 where uuid in("+idStr+")"; 
			if(optflag.equals("0")){
				sel_sql = "update pro_agent_products set recommend=0 where uuid in("+idStr+")"; 
			}
			int i=0;
			if(!"".equals(idStr)){
				i=dbHelper.execute(sel_sql) ;
			}
			if(i>0){
				rs = "ok" ;
			}
		}
		if("product_order_to_agent".equals(flag)){
		 
		}
		
		
		if("order_to_agent".equals(flag)){
		 	String productId = CommonString.getFormatPara(request.getParameter("productId"));
			String province = CommonString.getFormatPara(request.getParameter("province"));  // 下单区域
			String city = CommonString.getFormatPara(request.getParameter("city"));
			String contact_tel = CommonString.getFormatPara(request.getParameter("contact_tel"));
			String ifgroup = CommonString.getFormatPara(request.getParameter("ifgroup"));
			String buy_time = CommonString.getFormatPara(request.getParameter("buy_time"));
			String message = CommonString.getFormatPara(request.getParameter("message"));
			String user_name = CommonString.getFormatPara(request.getParameter("user_name"));
			String company_name = CommonString.getFormatPara(request.getParameter("company_name"));
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
			String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
			String source_id = CommonString.getFormatPara(request.getParameter("source_id"));
			String tel_sms ="";
			String content1 ="";
			String catalogname1="";
			String productname1="";
			String agentname="";
			String catanum="";
			String cataname="";
			int product_id=0;
			String product_name="";
			String sql2 = " insert into pro_product_form (is_first, add_ip , add_user , add_date ,  uuid , agentid , agentname , contact_address , contact_tel , mobile_phone, province , city , state , ifgroup , buy_time , message , name , company , factoryid , factoryname   , catanum , cataname   , product_id , product_name  ) ";
			sql2 += " values ( ?,? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ?, ?, ?, ? , ?, ?   ) ";
			dbHelper.execute(sql2,new Object [] {
				    1,
					Common.getIp(request),
					"brand",
					CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),
					CommonString.getUUID(),
					0,agentname,
					province+city,contact_tel,contact_tel,province,city,0,
					ifgroup,buy_time,message,user_name,company_name,factoryid,factoryname,catanum,cataname,product_id,product_name
			},connection);
			
		
		}
		
		
		
		if("getAgentViewCount".equals(flag)){
 
		}
		// 产品中心显示 
		if("viewCountProAds".equals(flag)){
 
		}
		// 产品中心广告点击 
		if("viewCountProAdsClick".equals(flag)){
	 
		}
		if("tuan_form".equals(flag)){
	 
		}
		if("agent_news_view_count".equals(flag)){
		 
		}
		if("jia_ru_ding_dan_tong".equals(flag)){
 

		}
		if("jia_ru_ding_dan_tong_new".equals(flag)){
 
		}
		if("getLuceneKeyword".equals(flag)){
			// 热门：<a href="http://sowa.21-sun.com/?q=c8&f=news" target="_blank">C8</a>
			List<Map> luceneList = WEBDBHelper.getMapList("select top 6 word, count(*) total  from service_lucene_search_records group by word order by total desc","Web21serviceDBHelper") ;
			JSONArray js = new JSONArray();
			if(null!=luceneList && luceneList.size()>0){
				Map oneMap = null ;
				for(int i=1;i<luceneList.size();i++){
					oneMap = luceneList.get(i) ;
					js.put(oneMap) ;
				}
				
			}
			out.println(js) ;
			return ;
		}	
		if("agentNewsCount".equals(flag)){  // 更改代理商发布新闻浏览次数 
	 
			
		}
		if("getCommonProducts".equals(flag)){
	 
		}
		// 旗舰店订单
		/*注意：因为添加过滤导致传输where参数时and被过滤sql报错，旗舰店调用订单时本改为本页面查询，本方法停用	*/
		if("getAgentOrders".equals(flag)){
	 
		}
		
		//获取改产品同品牌其他产品
	    if("brandProductList".equals(flag)){  
 	
		}
		
	    //获取该产品大类别排行列表
	    if("topCatalogProductList".equals(flag)){  
 	
		}
	    //获取该产品在该类别中排序号
	    if("rank".equals(flag)){  
 
		}
		//产品评论保存新
		if("save_comment_new".equals(flag)){
		     //进行评论分数及评论
			 int score1=CommonString.getFormatInt(request.getParameter("score1"));
			 int score2=CommonString.getFormatInt(request.getParameter("score2"));
			 int score3=CommonString.getFormatInt(request.getParameter("score3"));
			 int score4=CommonString.getFormatInt(request.getParameter("score4"));
			 String contents=CommonString.getFormatPara(request.getParameter("content"));
			 String good=CommonString.getFormatPara(request.getParameter("good"));
			 String bad=CommonString.getFormatPara(request.getParameter("bad"));
			 Pattern p1 = Pattern.compile("^[0-9]*$"); 
			 Matcher m1 = p1.matcher(contents); 
			 boolean rs1 = m1.matches(); 
			 Matcher m2 = p1.matcher(good); 
			 boolean rs2 = m2.matches(); 
			 Matcher m3 = p1.matcher(bad); 
			 boolean rs3 = m3.matches(); 
			 if(score1>100||score2>100||score3>100||score4>100||rs1||rs2||rs3||contents.indexOf("www")!=-1||contents.indexOf("http")!=-1||contents.indexOf("href")!=-1)
			 {
			  		out.println("no") ;
					return ;
			 }
			 
			 if(referer.indexOf("http://product.21-sun.com")==-1){
		    	//  return ;
			 }
			String sql = " insert into pro_comments (add_user, add_date, add_ip, name, content, product_id, score1, score2, score3, score4, is_show, is_buy,is_noname,uuid,good,bad) ";
			sql += " values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
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
			 dbHelper.execute(sql,new Object []{"comment",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),CommonString.getFormatPara(request.getParameter("name")),CommonString.getFormatPara(request.getParameter("content")),CommonString.getFormatPara(request.getParameter("product_id")),CommonString.getFormatPara(request.getParameter("score1")),CommonString.getFormatPara(request.getParameter("score2")),CommonString.getFormatPara(request.getParameter("score3")),CommonString.getFormatPara(request.getParameter("score4")),1,CommonString.getFormatPara(request.getParameter("is_buy")),CommonString.getFormatPara(request.getParameter("is_noname")),UUID.randomUUID().toString(),CommonString.getFormatPara(request.getParameter("good")),CommonString.getFormatPara(request.getParameter("bad"))},connection);
		}
	    //获取该产品的排行列表
	    if("rank_url".equals(flag)){  
	        String url="/top_list/products.jsp?flag=";
			String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;   // 类型
            if(catalog.length()>6){catalog=catalog.substring(0,6);}
            if(catalog.equals("101001")){url=url+"grab";}  //挖掘机
            if(catalog.equals("101002")){url=url+"loader";}   //装载机
            if(catalog.equals("101003")){url=url+"bulldozer";}   //推土机
            if(catalog.equals("101005")){url=url+"grader";}   ///平地机
            if(catalog.indexOf("102")>0){url=url+"crane";}    //起重机
            if(catalog.equals("106001")){url=url+"roller";}   //压路机
            rs=""+url;
		}
		
	   //获取下一张图集
	    if("nextPic".equals(flag)){ 	
			String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;   // 类型
			if(catalog.length()>6){catalog=catalog.substring(0,6);}
			int id = CommonString.getFormatInt(request.getParameter("id")) ; // 编号	
			
			List<Map> proList = null ;
			String do_sql ="select top 1 id,catalogname,name,factoryname  from pro_products where id >"+id+" and catalognum like '%"+catalog+"%' order by id asc";
			StringBuffer html = new StringBuffer("") ;
		    proList = dbHelper.getMapList(do_sql,connection) ;
			if(null!=proList && proList.size()>0){
			  for(Map oneMap:proList){
				html.append("<span>下一图集：</span>") ;
			    html.append("<a title='"+CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"图片"+"' href='detail_for_"+CommonString.getFormatPara(oneMap.get("id"))+".htm'>") ;
			    html.append(CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"图片") ;
			    html.append("</a>") ;
			   }
		    }else
			{
			    html.append("<span>下一图集：</span><a>暂无信息</a>") ;
			}
			out.println(html.toString()) ;
			return ;
			
		}
		
	    //获取上一张图集
	    if("pretPic".equals(flag)){  
		    String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;   // 类型
			if(catalog.length()>6){catalog=catalog.substring(0,6);}
			int id = CommonString.getFormatInt(request.getParameter("id")) ; // 编号	
			List<Map> proList = null ;
			String do_sql ="select top 1 id,catalogname,name,factoryname  from pro_products where id <"+id+" and catalognum like '%"+catalog+"%' order by id desc";
			StringBuffer html = new StringBuffer("") ;
		    proList = dbHelper.getMapList(do_sql,connection) ;
			if(null!=proList && proList.size()>0){
			  for(Map oneMap:proList){
				html.append("<span>上一图集：</span>") ;
			    html.append("<a title='"+CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"图片"+"' href='detail_for_"+CommonString.getFormatPara(oneMap.get("id"))+".htm'>") ;
			    html.append(CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"图片") ;
			    html.append("</a>") ;
			   }
		    }else
			{
			    html.append("<span>上一图集：</span><a>暂无信息</a>") ;
			}
			out.println(html.toString()) ;
			return ;
		}
		
		//维修问题提交
		if("repair_info".equals(flag)){
 
		}
		
		//产品评论保存新
		if("cat_video".equals(flag)){
		     //进行评论分数及评论
			 String username=CommonString.getFormatPara(request.getParameter("user"));
			 String phone=CommonString.getFormatPara(request.getParameter("phone"));
			 String Q1=CommonString.getFormatPara(request.getParameter("Q1"));
			 String Q2=CommonString.getFormatPara(request.getParameter("Q2"));
			 String Q3=CommonString.getFormatPara(request.getParameter("Q3"));
			 String Q4=CommonString.getFormatPara(request.getParameter("Q4"));
			 
			 String Q1T=CommonString.getFormatPara(request.getParameter("Q1T"));
			 String Q2T=CommonString.getFormatPara(request.getParameter("Q2T"));
			 String Q3T=CommonString.getFormatPara(request.getParameter("Q3T"));
			 String Q4T=CommonString.getFormatPara(request.getParameter("Q4T"));
			 
			 if((Q1.equals("其他")||Q1.equals(""))&&!Q1T.equals("")){Q1=Q1T;}
			 if((Q2.equals("不确定")||Q2.equals(""))&&!Q2T.equals("")){Q2=Q2T;}
			 if((Q3.equals("不确定")||Q3.equals(""))&&!Q3T.equals("")){Q3=Q3T;}
			 if((Q4.equals("不确定")||Q4.equals(""))&&!Q4T.equals("")){Q4=Q4T;}

			 
			 String Q5=CommonString.getFormatPara(request.getParameter("Q5"));
	         String video_flag=CommonString.getFormatPara(request.getParameter("video_flag"));
			String sql = " insert into pro_cat_video_survey (add_date,add_ip,Q1,Q2,Q3,Q4,Q5,video_flag,username,phone) ";
			sql += " values (?,?,?,?,?,?,?,?,?,?) ";
			dbHelper.execute(sql,new Object []{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),Q1,Q2,Q3,Q4,Q5,video_flag,username,phone},connection);
		}
		//用户名验证
		if("checkUser".equals(flag)){
			String username = CommonString.getFormatPara(request.getParameter("n"));
			String sql = " select 1 from pro_member where username = ? ";
			Map memMap = dbHelper.getMap(sql,new Object [] {username} , connection);
			if(memMap != null){
				rs = "no";
			}else{
				rs = "ok";
			}
		}
		//手机号验证
		if("checkPhone".equals(flag)){
			String telephone = CommonString.getFormatPara(request.getParameter("n"));
			String sql = " select 1 from pro_member where telephone = ? ";
			Map memMap = dbHelper.getMap(sql,new Object [] {telephone} , connection);
			if(memMap != null){
				rs = "no";
			}else{
				rs = "ok";
			}
		}
		
		//获取验证码(字符串格式)
		if("checkRand".equals(flag)){
			String randValue = CommonString.getFormatPara(request.getParameter("a"));
			rs = (String)session.getAttribute("rand");
			if(rs.equals(randValue)){
				rs = "ok";	
			}else{
				rs = "no";	
			}
		}
		//用户注册
		if("regist".equals(flag)){
			String zd_username = CommonString.getFormatPara(request.getParameter("zd_username"));
			String zd_password = CommonString.getFormatPara(request.getParameter("zd_password"));
			String zd_telephone = CommonString.getFormatPara(request.getParameter("zd_telephone"));
			String zd_address = CommonString.getFormatPara(request.getParameter("zd_address"));
			String randValue = CommonString.getFormatPara(request.getParameter("auth"));
			rs = (String)session.getAttribute("rand");
			if(rs.equals(randValue)){
				String sql = " insert into pro_member (add_date,add_ip,add_user,username,password,telephone,address,state,shuang12_lottery_time) ";
				sql += " values (?,?,?,?,?,?,?,?,?) ";
				int r = dbHelper.execute(sql,new Object []{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),zd_username,zd_username,zd_password,zd_telephone,zd_address,1,1},connection);	
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
		//新用户首次注册
		if("regist_new".equals(flag)){
			String zd_username = CommonString.getFormatPara(request.getParameter("zd_username"));
			String zd_password = CommonString.getFormatPara(request.getParameter("zd_password"));
				String sql = " insert into pro_member (add_date,add_ip,add_user,username,nickname,password,state,shuang12_lottery_time) ";
				sql += " values (?,?,?,?,?,?,?,?) ";
				int r = dbHelper.execute(sql,new Object []{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),zd_username,zd_username,zd_username,zd_password,1,1},connection);	
				if(r>0){
					rs = "ok";	
					Map memberInfo = dbHelper.getMap("select * from pro_member where username = ?", new Object[] { zd_username }, connection);
					
					if (null != memberInfo) {
						session.setAttribute("memberInfo", memberInfo);
					}
				}else{
					rs = "no";	
				}
			
		}
		//新用户首次注册完善信息
		if("regist_new_second".equals(flag)){
		    String types = CommonString.getFormatPara(request.getParameter("type"));
				if(types.equals("person")){
				String zd_province = CommonString.getFormatPara(request.getParameter("zd_province"));
				String zd_city = CommonString.getFormatPara(request.getParameter("zd_city"));
				String zd_area = CommonString.getFormatPara(request.getParameter("zd_area"));
				String zd_telephone = CommonString.getFormatPara(request.getParameter("zd_telephone"));
				String zd_touxaing = CommonString.getFormatPara(request.getParameter("zd_touxaing"));
				String image="/new_resources/img/temp/101001_"+zd_touxaing+".png";
				Map memberInfo = (Map)session.getAttribute("memberInfo");
				System.out.println("memberInfo="+memberInfo);
				if(memberInfo!=null){
				   String id=CommonString.getFormatPara(memberInfo.get("id"));
				   String sql = " update  pro_member set province='"+zd_province+"',city='"+zd_city+"',area='"+zd_area+"',telephone='"+zd_telephone+"',image='"+image+"' where id=?";
				   int r = dbHelper.execute(sql,new Object []{id},connection);
					if(r>0){
						rs = "ok";	
						Map memberInfos = dbHelper.getMap("select * from pro_member where id = ?", new Object[] { id }, connection);
						if (null != memberInfos) {
							session.setAttribute("memberInfo", memberInfos);
						}
					}else{
						rs = "no";	
					}
				}
			}else if(types.equals("company")){
				String zd_company = CommonString.getFormatPara(request.getParameter("zd_company"));
				String zd_real_name = CommonString.getFormatPara(request.getParameter("zd_real_name"));
				String zd_job = CommonString.getFormatPara(request.getParameter("zd_job"));
				String zd_telephone = CommonString.getFormatPara(request.getParameter("zd_telephones"));
				String zd_touxaings = CommonString.getFormatPara(request.getParameter("zd_touxaings"));
				String image="/new_resources/img/temp/101001_"+zd_touxaings+".png";
				Map memberInfo = (Map)session.getAttribute("memberInfo");
				if(memberInfo!=null){
				   String id=CommonString.getFormatPara(memberInfo.get("id"));
				   String sql = " update  pro_member set company='"+zd_company+"',real_name='"+zd_real_name+"',job='"+zd_job+"',telephone='"+zd_telephone+"',image='"+image+"' where id=?";
				   int r = dbHelper.execute(sql,new Object []{id},connection);
					if(r>0){
						rs = "ok";	
						Map memberInfos = dbHelper.getMap("select * from pro_member where id = ?", new Object[] { id }, connection);
						if (null != memberInfos) {
							session.setAttribute("memberInfo", memberInfos);
						}
					}else{
						rs = "no";	
					}
				}
			}
		}
		//找回密码
		if("getPwd".equals(flag)){
			String zd_username = CommonString.getFormatPara(request.getParameter("zd_username"));
			String zd_telephone = CommonString.getFormatPara(request.getParameter("zd_telephone"));
			String randValue = CommonString.getFormatPara(request.getParameter("auth"));
			rs = (String)session.getAttribute("rand");
			if(rs.equals(randValue)){
				String member_info_cookie = "select password from pro_member where username=? and telephone=? " ; // 获得浏览记录 cookie 得到产品信息
				Map member_info = null ;
				if(!"".equals(zd_username)&&!"".equals(zd_telephone)){
					member_info = dbHelper.getMap(member_info_cookie,new Object[]{zd_username,zd_telephone},connection) ;
				}
				
				if(null!=member_info){
					rs = "ok";	
					try {
					    Map root = new HashMap() ;
						root.put("phone",zd_telephone) ; //电话号码
						root.put("content","您在铁臂商城所注册账号为："+member_info.get("password")+",请小心保管。") ;
						root.put("source","195002");
						String srt  = Common.doPost("http://service.21-sun.com/http/utils/sms.jsp", root) ;
					} catch (Exception e) {
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
		//session写入提车城市
		if(flag.equals("loadPlace")){
			session.removeAttribute("placeInfo");
			String placeInfo=CommonString.getFormatPara(request.getParameter("place"));
			session.setAttribute("placeInfo", placeInfo);

		}
		//登录
		if(flag.equals("login")){
			String username = CommonString.getFormatPara(request.getParameter("u"));
			String password = CommonString.getFormatPara(request.getParameter("p"));
			String login_state = CommonString.getFormatPara(request.getParameter("l"));
			String cookieMember =CommonString.getFormatPara(Common.getCookies(request,"memberInfo"));
			if(cookieMember.equals("")&&login_state.equals("1")){
			  String cookieInfo=username+"@@@"+password;
			  Common.createCookie(response, "memberInfo",cookieInfo, 60*60*24*2);
			}else if(!cookieMember.equals("")&&login_state.equals("0")){
			   String cookieInfo="";
			   Common.createCookie(response, "memberInfo",cookieInfo, 0);
			}
			String uname="";
			Map memberInfo = dbHelper.getMap("select * from pro_member where username = ? and password = ?", new Object[] { username, password }, connection);
			if (null != memberInfo) {
		    uname = CommonString.getFormatPara(memberInfo.get("username"));	
	       
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
		//是否登录
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
		//铁臂商城
		if(flag.equals("isLogin_Tiebi")){
			Map memberInfo = (Map)session.getAttribute("memberInfo");
			String username = "";
			if(memberInfo != null){
				username = CommonString.getFormatPara(memberInfo.get("username"));
			}
			if (!username.equals("")) {
				rs = username;
			}else{
				rs = "no";
			}
		}
		
		
		//铁臂商城zzzz
		if(flag.equals("isLogin_Tiebi_koubei")){
			Map memberInfo = (Map)session.getAttribute("memberInfo");
			String username = "";  String password="";
			if(memberInfo != null){
				username = CommonString.getFormatPara(memberInfo.get("username"));
				password = CommonString.getFormatPara(memberInfo.get("password"));
			}
			if (!username.equals("")) {
				rs = username+"_"+password;
			}else{
				rs = "no";
			}
		}
		
		if(flag.equals("isLogin_Tiebi_id")){
			Map memberInfo = (Map)session.getAttribute("memberInfo");
			String mid = "";
			if(memberInfo != null){
				mid = CommonString.getFormatPara(memberInfo.get("id"));
			}
			if (!mid.equals("")) {
				rs = mid;
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
		    String cookieusername= CommonString.getFormatPara(Common.getCookies(request,"cookieMemNo"));
			if(username.equals("")&&!cookieusername.equals("")){
			     username=cookieusername;
			}
			if(username.equals("")){username="tbvisiter";}
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
		//口碑有用投票
		if(flag.equals("koubeiHelp")){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			if (!id.equals("")) {
				String helpSql = "update pro_comments set is_help = ISNULL(is_help, 0)+1 where id="+id;
				dbHelper.execute(helpSql,connection);
				rs = "ok";
			}else{
				rs = "no";
			}
		}
		
		//发表维修心得
		if(flag.equals("pubXinde")){
	 
		}
		//给机器优点加1
	    if(flag.equals("pubProAd")){
 
		}
		
		//手机新产品评论保存
		if("new_save_comment_shouji".equals(flag)){
		String filename = CommonString.getFormatPara(request.getParameter("filename")) ;
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
			String sql = " insert into pro_comments (add_user, add_date, add_ip, name, content, product_id, score1, score2, score3, score4, is_show, is_buy,is_noname,uuid,username,is_help) ";
			sql += " values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
			String content = CommonString.getFormatPara(request.getParameter("content")) ; // 输入的内容
			String zd_image = CommonString.getFormatPara(request.getParameter("zd_image")) ;//图片 
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
			int keyId = dbHelper.executeUpdate(sql,new Object []{"comment",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),username,content,CommonString.getFormatPara(request.getParameter("product_id")),CommonString.getFormatInt(request.getParameter("score1")),CommonString.getFormatInt(request.getParameter("score2")),CommonString.getFormatInt(request.getParameter("score3")),CommonString.getFormatInt(request.getParameter("score4")),1,CommonString.getFormatPara(request.getParameter("is_buy")),CommonString.getFormatPara(request.getParameter("is_noname")),UUID.randomUUID().toString(),username,1},connection);
			 connection.setAutoCommit(false);
			if(!username.equals("")){
					String sqlStr = " insert into pro_comments_image ( add_date , add_user , add_ip, comment_id , image_small , image , is_show) ";
					sqlStr += " values ( ? , ? , ? , ? , ? , ? , ? )";
					
							int rb = dbHelper.execute(sqlStr,new Object [] {
									CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),username,Common.getIp(request),keyId,zd_image,zd_image,1},connection);
					
				}
			connection.commit();
			rs="ok";
		}
		
		//产品中心统计访问
		if("product_visit".equals(flag)){

		
		}
		
		//生成订单
		if("createOrder".equals(flag)){
		
		}
		//生成订单
		if("createOrder1".equals(flag)){
		
		}
				
		//图库活动投票
		if("photo_activity_vote".equals(flag)){
			String vote_id = CommonString.getFormatPara(request.getParameter("vote_id")) ;
			int result=dbHelper.execute("update pro_photo_group  set vote_count = ISNULL(vote_count,0)+1  where id="+vote_id,connection) ; 
            if(result==1){rs="1";}else{rs="0";}			
		}
		
		//图库活动图片保存
		if("photo_activity_save".equals(flag)){
		    rs="success";
			String [] imgs = request.getParameterValues("images");
			String title = CommonString.getFormatPara(request.getParameter("jr_title")) ; 
			String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ; 
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum")).replace("-请选择类别-","") ; 
			String brand = CommonString.getFormatPara(request.getParameter("brand")).replace("-请选择品牌-","") ;
		    String model = CommonString.getFormatPara(request.getParameter("model")).replace("-请选择型号-","").replace("暂无产品","") ; 
			String description = CommonString.getFormatPara(request.getParameter("description")) ; 
			String jr_username = CommonString.getFormatPara(request.getParameter("jr_username")) ; 
			
			String zhanhui_num = CommonString.getFormatPara(request.getParameter("zhanhui_num")) ; 
			
			if(jr_username.equals("")){jr_username="tiebiyouke";}
            String sql="";  int keyId=0;
               //图库活动插入图片
			   //插入主图
			   if(null!=imgs&&imgs.length>0){
					sql = " insert into pro_photo_group (title,sort_num,image,is_show,add_ip,add_date,uuid,pub_date,add_user,factoryid,catalognum,pro_id,contents,zhanhui_num) ";
			        sql += " values (?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
					keyId = dbHelper.executeUpdate(sql,new Object []{title,catalog+",",imgs[0].replace("/uploadfiles/","/"),1,Common.getIp(request),CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),UUID.randomUUID().toString(),CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),jr_username,brand,catalognum,model,description,zhanhui_num},connection);
                		if(keyId<=0){rs="fail";}		    
					connection.setAutoCommit(false);
				}
				//插入其他轮显图片
				if(null!=imgs&&imgs.length>1){
						for(int i=1;i<imgs.length;i++){
							sql = " insert into pro_photo (title,group_id,image,is_show,add_ip,add_date,uuid,pub_date,add_user) ";
			                sql += " values (?,?,?,?,?,?,?,?,?) ";
					        int aa=dbHelper.executeUpdate(sql,new Object []{title,keyId,imgs[i].replace("/uploadfiles/","/"),1,Common.getIp(request),CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),UUID.randomUUID().toString(),CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),jr_username},connection);
						    if(aa<=0){rs="fail";}
						}
				}
				connection.commit();
				if(catalog.equals("107002")){  //如果是产品图片进行单独处理
			        if(null!=imgs&&imgs.length>0){
						for(int i=0;i<imgs.length;i++){
							sql = " insert into pro_product_pic (product_id,name,img_name,is_show,page_pic_flag,uuid,is_activity,placeflag) ";
			                sql += " values (?,?,?,?,?,?,?,?) ";
					        int bb=dbHelper.executeUpdate(sql,new Object []{model,title,imgs[i].replace("/uploadfiles/","/"),1,0,UUID.randomUUID().toString(),1,0},connection);
						    if(bb<=0){rs="fail";}
						}
				    }
			    }
		
		}
		
		//该厂家或代理商合作开始时间
		if("cooperate_start_date".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			Map info = dbHelper.getMap("select order_start_time  from pro_agent_factory where id = ?", new Object[] {  id }, connection);
			if (null != info) {
			   rs=CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(info.get("order_start_time")));
			}
			//System.out.println("开始时间"+rs+id);
		}
		
		//该厂家或代理商合作结束时间
		if("cooperate_end_date".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			Map info = dbHelper.getMap("select order_end_time  from pro_agent_factory where id = ?", new Object[] {  id }, connection);
			if (null != info) {
			  rs=CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(info.get("order_end_time")));
			}
			//System.out.println("结束时间"+rs+id);
		}
		
		//卡特配件活动订单保存
		if("cat_part_activity_save".equals(flag)){
 
	    
		}
		//龙工店铺配件订单邮件
		if("longgongPartOrder".equals(flag)){
 
		}
		
		//zengfc添加
		if("dealerList".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String city = CommonString.getFormatPara(request.getParameter("city"));
            List<Map> agentList = null ;
			String sql ="select top 2 id,full_name,agent_fac_name,city,usern,telphone,is_qijiandian,is_made from pro_agent_factory where flag = 2 and is_show = 1 and (agent_fac LIKE '%"+id+",%' OR agent_fac LIKE '%,"+id+"%' or agent_fac = '"+id+"')  and  (city  like  '%"+province+"%' or city like '%"+city+"%' ) order by is_top desc, is_made desc,is_shop desc,flag ASC , name DESC , id DESC";
			StringBuffer html = new StringBuffer("") ;
		    agentList = dbHelper.getMapList(sql,connection) ;
			if(null!=agentList && agentList.size()>0){
			  for(Map oneMap:agentList){
				html.append("<li><div class='tdl_dltitle'><a href='/agent/"+CommonString.getFormatPara(oneMap.get("usern"))+"/' target='_blank'>"+((CommonString.getFormatPara(oneMap.get("full_name")).length()>13)?CommonString.getFormatPara(oneMap.get("full_name")).substring(0,13)+"...":CommonString.getFormatPara(oneMap.get("full_name")))+"</a><span class='tdlt_qy'>"+province+city+"</span> ") ;
			    html.append("<span class='tdlt_tag'>荐</span>") ;
				html.append("</div>") ;
				html.append("<div class='tdl_dlsum'> 代理区域："+CommonString.getFormatPara(oneMap.get("city"))+"<br/> ") ;
				html.append("代理品牌："+CommonString.getFormatPara(oneMap.get("agent_fac_name"))+"<br/> ") ;
				html.append("电话："+CommonString.getFormatPara(oneMap.get("telphone"))+"<br/> ") ;
                html.append("传真："+CommonString.getFormatPara(oneMap.get("fax"))+"<br/> ") ;
			    html.append("地址："+CommonString.getFormatPara(oneMap.get("address"))+"</div></li>") ;
			   }
		    }
			rs=html.toString();
		}
		
		
		if("dealerListMore".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String city = CommonString.getFormatPara(request.getParameter("city"));
            List<Map> agentList = null ;
			String sql ="select top 25 id,full_name,agent_fac_name,city,usern,telphone,is_qijiandian,is_made from pro_agent_factory where flag = 2 and is_show = 1 and (agent_fac LIKE '%"+id+",%' OR agent_fac LIKE '%,"+id+"%' or agent_fac = '"+id+"')  and  (city  like  '%"+province+"%' or city like '%"+city+"%' ) order by is_top desc, is_made desc,is_shop desc,flag ASC , name DESC , id DESC";
			StringBuffer html = new StringBuffer("") ;
		    agentList = dbHelper.getMapList(sql,connection) ;
			if(null!=agentList && agentList.size()>0){
			  int i=1;
			  for(Map oneMap:agentList){
				html.append("<ul class='libg0"+((i%2)+1)+"'><li class='g1'><a title='"+CommonString.getFormatPara(oneMap.get("full_name"))+"' href='http://product.21-sun.com/agent/"+CommonString.getFormatPara(oneMap.get("usern"))+"/' target='_blank'>"+CommonString.getFormatPara(oneMap.get("full_name"))+"</a></li>") ;
			    html.append("<li class='g2'><span title='"+CommonString.getFormatPara(oneMap.get("city"))+"'>"+CommonString.getFormatPara(oneMap.get("city"))+"</span></li>") ;
				html.append("<li class='g3'><span title='"+CommonString.getFormatPara(oneMap.get("agent_fac_name"))+"'>"+CommonString.getFormatPara(oneMap.get("agent_fac_name"))+"</span></li>") ;
				html.append("<li class='g4'><a href='javascript:void(0);' onClick='zaiXianXunJia(\""+CommonString.getFormatPara(oneMap.get("id"))+"\");'>在线询价</a></li>") ;
				html.append("<li class='g5' style='overflow:hidden;'><a id='seePhone_"+CommonString.getFormatPara(oneMap.get("id"))+"' href='javascript:void(0);' onClick='lianXiDianHua(\""+CommonString.getFormatPara(oneMap.get("id"))+"\");'>点击查看联系电话</a></li></ul>") ;		
			    i++;
			   }
		    }
			rs=html.toString();
		}
		
		if("brandDealerList".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String city = CommonString.getFormatPara(request.getParameter("city"));
            List<Map> agentList = null ;
			String sql ="select top 5 id,full_name,agent_fac_name,city,usern,telphone,is_qijiandian,is_made from pro_agent_factory where flag = 2 and is_show = 1 and (agent_fac LIKE '%"+id+",%' OR agent_fac LIKE '%,"+id+"%' or agent_fac = '"+id+"')  and  (city  like  '%"+province+"%' or city like '%"+city+"%' ) order by is_top desc, is_made desc,is_shop desc,flag ASC , name DESC , id DESC";
			StringBuffer html = new StringBuffer("") ;
		    agentList = dbHelper.getMapList(sql,connection) ;
			html.append("<li class='first'><div class='txd_dl_t txd_dl_t1'>代理商</div><div class='txd_dl_t txd_dl_t2'>代理区域</div><div class='txd_dl_t txd_dl_t3'>主营品牌</div><div class='txd_dl_t txd_dl_t4'>在线询价</div><div class='txd_dl_t txd_dl_t5'>联系电话</div></li>") ;
			if(null!=agentList && agentList.size()>0){
			  for(Map oneMap:agentList){
			    html.append("<li><div class='txd_dl_t txd_dl_t1'><a href='http://product.21-sun.com/agent/"+CommonString.getFormatPara(oneMap.get("usern"))+"/' title='"+CommonString.getFormatPara(oneMap.get("full_name"))+"'>"+CommonString.getFormatPara(oneMap.get("full_name"))+"</a></div>") ;
				html.append("<div class='txd_dl_t txd_dl_t2'>"+CommonString.getFormatPara(oneMap.get("city"))+"</div>") ;
				html.append("<div class='txd_dl_t txd_dl_t3'>"+CommonString.getFormatPara(oneMap.get("agent_fac_name"))+"</div>") ;
				html.append("<div class='txd_dl_t txd_dl_t4'><a href='javascript:void(0);' onClick='zaiXianXunJia(\""+CommonString.getFormatPara(oneMap.get("id"))+"\");' class='txd_dl_price'>在线询价</a></div>") ;	
				html.append("<div class='txd_dl_t txd_dl_t5'><a id='seePhone_"+CommonString.getFormatPara(oneMap.get("id"))+"' href='javascript:void(0);' onClick='lianXiDianHua(\""+CommonString.getFormatPara(oneMap.get("id"))+"\");'  class='txd_dl_tel'>点击查看联系电话</a></div></li>") ;						
			   }
		    }
			rs=html.toString();
		}
		
		if("loginCheck".equals(flag)){
		  Map memberInfo = (Map)session.getAttribute("memberInfo");
		  if(memberInfo!=null){
		    rs="ok";
		  }
		}
		
		//产品评论总数
		if("commentCount".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			int comment=0;
			Map map = dbHelper.getMap("select count(id)  as counts  from pro_comments  where product_id = ? ", new Object[] {  id }, connection);
			if (null != map) {
			   comment=CommonString.getFormatInt(map.get("counts"));
			}    
            rs=Integer.toString(comment);			
		}
		//询价单总数
		if("inquiryCount".equals(flag)){

            rs="";			
		}
		//询价列表
		if("inquiry_list".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
            List<Map> inquiryList = null ;
			String sql ="select top 5 add_date,province,city,name,id,product_name   from pro_product_form  where  is_deleted=0 and product_id ="+id+" order by add_date desc";
			inquiryList = dbHelper.getMapList(sql,connection) ;
			StringBuffer html = new StringBuffer("<li>暂无相关询价！</li>") ;
			if(null!=inquiryList && inquiryList.size()>0){
				html = new StringBuffer("") ;
			    for(Map oneMap:inquiryList){
			        html.append("<li><a href='http://product.21-sun.com/inquiry/detail_for_"+CommonString.getFormatPara(oneMap.get("id"))+".htm' target='_blank'>"+CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(oneMap.get("add_date")))+CommonString.getFormatPara(oneMap.get("province"))+CommonString.getFormatPara(oneMap.get("city"))+"的 "+((CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**")+" 询："+CommonString.getFormatPara(oneMap.get("product_name")).replace("^r","®").replace("?","®")+"</a></li>") ;
			    }
		    }
			rs=html.toString();
		}
		//获取有用的数目
		if("is_help".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			int is_help=0;
			Map map = dbHelper.getMap("select is_help  from pro_comments  where id= ? ", new Object[] {  id }, connection);
			if (null != map) {
			   is_help=CommonString.getFormatInt(map.get("is_help"));
			}   
            rs=Integer.toString(is_help);			
		}
		//刷新产品
		if("doFresh".equals(flag)){
 
		}
		//刷新首页二手
		if("reloadUsed".equals(flag)){
			
			Random random =new Random(); 
            int a=random.nextInt(40);
			String blank="";
			for(int i=0;i<=a;i++){
				blank+=" ";
			}
			
			List<Map> usedList  = new ArrayList<Map>();
			List<Map> usedListOld  = WEBDBHelper.getMapList("select"+blank+"  top 4  used_equipment.city_id,used_area.area_name,used_equipment.import_brand,used_equipment.price,used_equipment.workingtime,used_equipment.img1_1,used_equipment.factorydate,used_equipment.model,used_equipment.id,used_catalog.name from used_equipment,used_catalog,used_area  where used_equipment.is_review=1  and  used_equipment.is_pub=1 and  used_equipment.brand_id!='' and used_equipment.category_id=used_catalog.id and used_area.area_id=used_equipment.province_id and used_equipment.img1_1 like '%resource.21-sun%'  and used_equipment.city_id !='' and   used_equipment.city_id  is not null  order by  NEWID()","Web21usedDBHelper");
			if(null != usedListOld && usedListOld.size()>0){
				for(Map map:usedListOld){
					String city_name="";
					Map areaMap=WEBDBHelper.getMap("select area_name from used_area where area_id= "+CommonString.getFormatPara(map.get("city_id")),"Web21usedDBHelper");
					if(areaMap!=null){city_name=CommonString.getFormatPara(areaMap.get("area_name"));}
					map.put("city_name",city_name);
					usedList.add(map);
				}
			}
			StringBuffer html = new StringBuffer("") ;
	        if(usedList!=null&&usedList.size()>0){
		        for(Map oneMap:usedList){
				    html.append("<li> <a target='_blank' href='http://used.21-sun.com/equipment/equipmentdetail_for_"+CommonString.getFormatPara(oneMap.get("id"))+".htm' class='img'><img data-lazy='"+CommonString.getFormatPara(oneMap.get("img1_1"))+"' alt='"+CommonString.getFormatPara(oneMap.get("import_brand"))+CommonString.getFormatPara(oneMap.get("model"))+CommonString.getFormatPara(oneMap.get("name"))+"' src='"+CommonString.getFormatPara(oneMap.get("img1_1"))+"'></a> <a href='http://used.21-sun.com/equipment/equipmentdetail_for_"+CommonString.getFormatPara(oneMap.get("id"))+".htm'><div class='n'>"+CommonString.getFormatPara(oneMap.get("import_brand"))+CommonString.getFormatPara(oneMap.get("model"))+CommonString.getFormatPara(oneMap.get("name"))+"</div><div class='area'>"+CommonString.getFormatPara(oneMap.get("area_name"))+CommonString.getFormatPara(oneMap.get("city_name"))+"</div></a> </li>") ;
			    }
			}
			rs=html.toString();
		}
		
		//对比数据
		if("compareShow".equals(flag)){
			String equipment_id = CommonString.getFormatPara(request.getParameter("equiId"));
			Map map = dbHelper.getMap("select id,file_name,img2,factoryname,name,catalogname  from pro_products  where  id = ? ", new Object[] {equipment_id}, connection);
            if(map!=null){
			    rs = "<li id='comp_"+equipment_id+"'><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(map.get("file_name"))+"'><img src='http://product.21-sun.com//uploadfiles/"+CommonString.getFormatPara(map.get("img2"))+"' width='80' height='60'></a><div class='ficinfo'><div class='fictit'><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(map.get("file_name"))+"'>"+CommonString.getFormatPara(map.get("factoryname"))+CommonString.getFormatPara(map.get("name")).replace("^r","®")+CommonString.getFormatPara(map.get("catalogname"))+"</a></div><div class='ficprice'></div></div><span class='ficdel' onclick='removeOne("+CommonString.getFormatPara(map.get("id"))+");'><span class='del'></span></span><div class='li_bg'></div></li>";
			}else{
				rs="";
			}
		}
		
		
		//对比根据类别和品牌加载产品
		if("compareProLoad".equals(flag)){
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
			List<Map> proList = null ;
			String sql ="select  id,name from pro_products where is_show=1 and factoryid="+factoryid+" and catalognum like '"+catalognum+"%' order by tonandmeter asc,id desc ";
			StringBuffer html = new StringBuffer("") ;
		    proList = dbHelper.getMapList(sql,connection) ;
	        if(proList!=null&&proList.size()>0){
		        for(Map oneMap:proList){
				    html.append("<a href='javascript:;' data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"'>"+CommonString.getFormatPara(oneMap.get("name"))+"</a>") ;
			    }
			}
			rs=html.toString();
		}
		
		//加载二手品牌
		if("loadUsedBrand".equals(flag)){
			String where="";
			List<Map> usedListBrand  = WEBDBHelper.getMapList("select  id,name from used_brand where is_use=1 and id  in(select  brand_id from used_equipment where is_pub=1 "+where+" GROUP BY  brand_id","Web21usedDBHelper");
			StringBuffer html = new StringBuffer("") ;
			html.append("<a href='javascript:;' data-val='0'>请选择品牌</a>") ;
			if(null != usedListBrand && usedListBrand.size()>0){
				for(Map map:usedListBrand){
				    html.append("<a href='javascript:;' data-val='"+CommonString.getFormatPara(map.get("id"))+"'>"+CommonString.getFormatPara(map.get("name"))+"</a>") ;
				}
			}
			rs=html.toString();
		}
		
		//首页根据类别加载品牌
		if("indexLoadBrand".equals(flag)){
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
			List<Map> 	brandList=dbHelper.getMapList(" select id,name,upper_index  from pro_agent_factory  where id  in  (select factoryid from pro_products where is_show=1 and catalognum like '"+catalognum+"%'  group by  factoryid) order by upper_index asc "); //参数再分类别
			StringBuffer html = new StringBuffer("") ;
			html.append("<a href='javascript:;' data-val='0'>请选择品牌</a>") ;
			if(null != brandList && brandList.size()>0){
				for(Map map:brandList){
				    html.append("<a href='javascript:;' data-val='"+CommonString.getFormatPara(map.get("id"))+"'>"+CommonString.getFormatPara(map.get("upper_index"))+"-"+CommonString.getFormatPara(map.get("name"))+"</a>") ;
				}
			}
			rs=html.toString();
		}
		
		

		
				
		//首页根据类别和品牌加载产品
		if("indexLoadPro".equals(flag)){
			String catalognum = CommonString.getFormatPara(request.getParameter("catalognum"));
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
			List<Map> proList = null ;
			String sql ="select  id,name,file_name from pro_products where is_show=1 and factoryid="+factoryid+" and catalognum like '"+catalognum+"%' order by tonandmeter asc,id desc ";
			StringBuffer html = new StringBuffer("") ;
		    proList = dbHelper.getMapList(sql,connection) ;
	        if(proList!=null&&proList.size()>0){
		        for(Map oneMap:proList){
				    html.append("<a href='javascript:;' data-val='"+CommonString.getFormatPara(oneMap.get("file_name"))+"'>"+CommonString.getFormatPara(oneMap.get("name"))+"</a>") ;
			    }
			}
			rs=html.toString();
		}
		
		//首页广告01
		if("gg01".equals(flag)){
		   rs="974";
		}
		//首页广告02
		if("gg02".equals(flag)){
		   rs="1209";	
		}
		//首页广告03
		if("gg03".equals(flag)){
		    rs="809";	
		}
		//首页广告04
		if("gg04".equals(flag)){
             rs="654";							
		}
		//搜索国内品牌
		if("searchInnerBrand".equals(flag)){
			String whereStr="";
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(catalog.equals("140")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and (catalognum ='101001098' or catalognum ='101001098'  ) group by factoryid)";
			}else if(catalog.equals("101001")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and (catalognum ='101001001' or catalognum ='101001004' or catalognum ='101001007'  ) group by factoryid)";
			}
			else if(!catalog.equals("")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and catalognum like '"+catalog+"%' group by factoryid)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,is_inner,english_name,upper_index  from pro_agent_factory where flag=1 and  is_show=1 and  is_inner=1  "+whereStr+"  order by upper_index  asc,view_count desc";
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br0"+(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")?"1":"2")+"'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/products/prolist.jsp?factory="+CommonString.getFormatPara(oneMap.get("id"))+(catalog.equals("")?"":"&catalog="+catalog)+"#main'><span class='m'>"+CommonString.getFormatPara(oneMap.get("upper_index"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"<span style='color:red'>("+CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog.equals("")?"0":catalog)))+")"+"</span></span><span class='s'>"+CommonString.getFormatPara(oneMap.get("english_name"))+"</span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();							
		}
		
		//搜索国外品牌
		if("searchOutBrand".equals(flag)){
			String whereStr="";
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(catalog.equals("140")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and (catalognum ='101001098' or catalognum ='101001098'  ) group by factoryid)";
			}else if(catalog.equals("101001")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and (catalognum ='101001001' or catalognum ='101001004' or catalognum ='101001007'  ) group by factoryid)";
			}else if(!catalog.equals("")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and catalognum like '"+catalog+"%' group by factoryid)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,is_inner,english_name,upper_index   from pro_agent_factory where  flag=1 and  is_show=1 and  is_inner=0   "+whereStr+"   order by upper_index  asc,view_count desc";
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br0"+(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")?"1":"2")+"'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/products/prolist.jsp?factory="+CommonString.getFormatPara(oneMap.get("id"))+(catalog.equals("")?"":"&catalog="+catalog)+"#main'><span class='m'>"+CommonString.getFormatPara(oneMap.get("upper_index"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"<span style='color:red'>("+CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog.equals("")?"0":catalog)))+")"+"</span></span><span class='s'>"+CommonString.getFormatPara(oneMap.get("english_name"))+"</span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();								
		}
		//按照字母搜索品牌
		if("searchByLetter".equals(flag)){
			String whereStr="";
			String letter = CommonString.getFormatPara(request.getParameter("letter"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(catalog.equals("140")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and (catalognum ='101001098' or catalognum ='101001098'  ) group by factoryid)";
			}else if(catalog.equals("101001")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and (catalognum ='101001001' or catalognum ='101001004' or catalognum ='101001007'  ) group by factoryid)";
			}
			else if(!catalog.equals("")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and catalognum like '"+catalog+"%' group by factoryid)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,is_inner,english_name,upper_index   from pro_agent_factory where   flag=1   and upper_index='"+letter+"' and  is_show=1"+whereStr;
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br0"+(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")?"1":"2")+"'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/products/prolist.jsp?factory="+CommonString.getFormatPara(oneMap.get("id"))+(catalog.equals("")?"":"&catalog="+catalog)+"#main'><span class='m'>"+CommonString.getFormatPara(oneMap.get("upper_index"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"<span style='color:red'>("+CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog.equals("")?"0":catalog)))+")"+"</span></span><span class='s'>"+CommonString.getFormatPara(oneMap.get("english_name"))+"</span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();								
		}
				
		//搜索品牌
		if("searchBrand".equals(flag)){
			String whereStr="";
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(catalog.equals("140")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and (catalognum ='101001098' or catalognum ='101001098'  ) group by factoryid)";
			}else if(catalog.equals("101001")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and (catalognum ='101001001' or catalognum ='101001004' or catalognum ='101001007'  ) group by factoryid)";
			}
			else if(!catalog.equals("")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and catalognum like '"+catalog+"%' group by factoryid)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,is_inner,english_name,upper_index  from pro_agent_factory where  flag=1 and  is_show=1 and (  name like  '%"+keyword+"%'  or   full_name  like '%"+keyword+"%'  or  pinyin  like '%"+keyword+"%' ) "+whereStr+" order by upper_index  asc,view_count desc";
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br0"+(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")?"1":"2")+"'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/products/prolist.jsp?factory="+CommonString.getFormatPara(oneMap.get("id"))+(catalog.equals("")?"":"&catalog="+catalog)+"#main'><span class='m'>"+CommonString.getFormatPara(oneMap.get("upper_index"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"<span style='color:red'>("+CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog.equals("")?"0":catalog)))+")"+"</span></span><span class='s'>"+CommonString.getFormatPara(oneMap.get("english_name"))+"</span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();								
		}
						
		//搜索所有品牌
		if("searchAllBrand".equals(flag)){
			String whereStr="";
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(catalog.equals("140")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and (catalognum ='101001098' or catalognum ='101001098'  ) group by factoryid)";
			}else if(catalog.equals("101001")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and (catalognum ='101001001' or catalognum ='101001004' or catalognum ='101001007'  ) group by factoryid)";
			}else if(!catalog.equals("")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and catalognum like '"+catalog+"%' group by factoryid)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,is_inner,english_name,upper_index  from pro_agent_factory where  flag=1 and  is_show=1 "+whereStr+" order by upper_index  asc,view_count desc ";
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br0"+(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")?"1":"2")+"'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/products/prolist.jsp?factory="+CommonString.getFormatPara(oneMap.get("id"))+(catalog.equals("")?"":"&catalog="+catalog)+"#main'><span class='m'>"+CommonString.getFormatPara(oneMap.get("upper_index"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"<span style='color:red'>("+CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog.equals("")?"0":catalog)))+")"+"</span></span><span class='s'>"+CommonString.getFormatPara(oneMap.get("english_name"))+"</span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();								
		}
		
		//列表对比数据
		if("compareShowList".equals(flag)){
			String equipment_id = CommonString.getFormatPara(request.getParameter("equiId"));
			Map map = dbHelper.getMap("select id,file_name,img2,factoryname,name,catalogname  from pro_products  where  id = ? ", new Object[] {equipment_id}, connection);
            if(map!=null){
			    //rs = "<li id='comp_"+equipment_id+"'><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(map.get("file_name"))+"'><img src='http://product.21-sun.com//uploadfiles/"+CommonString.getFormatPara(map.get("img2"))+"' width='80' height='60'></a><div class='ficinfo'><div class='fictit'><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(map.get("file_name"))+"'>"+CommonString.getFormatPara(map.get("factoryname"))+CommonString.getFormatPara(map.get("name"))+CommonString.getFormatPara(map.get("catalogname"))+"</a></div><div class='ficprice'></div></div><span class='ficdel' onclick='removeOne("+CommonString.getFormatPara(map.get("id"))+");'><span class='del'></span></span><div class='li_bg'></div></li>";
				rs = "<li id='comp_"+equipment_id+"'><span class='cb'><input  checked='true' value='"+equipment_id+"' class='compare' name='db_subBox' type='checkbox' id='checkbox"+equipment_id+"' /></span><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(map.get("file_name"))+"'><img src='http://product.21-sun.com//uploadfiles/"+CommonString.getFormatPara(map.get("img2"))+"' width='80' height='60'></a><div class='ficinfo'><div class='fictit'><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(map.get("file_name"))+"'>"+CommonString.getFormatPara(map.get("factoryname"))+CommonString.getFormatPara(map.get("name")).replace("^r","®")+CommonString.getFormatPara(map.get("catalogname"))+"</a></div><div class='ficprice'></div></div><span class='ficdel' onclick='removeOne("+CommonString.getFormatPara(map.get("id"))+");'><span class='del'></span></span></li>";
			}else{
				rs="";
			}
		}
		
		//列表询价多个数据
		if("inquiryShowList".equals(flag)){
			String equipment_id = CommonString.getFormatPara(request.getParameter("equiId"));
			Map map = dbHelper.getMap("select id,file_name,img2,factoryname,name,catalogname  from pro_products  where  id = ? ", new Object[] {equipment_id}, connection);
            if(map!=null){
			    //checked rs = "<li id='comp_"+equipment_id+"'><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(map.get("file_name"))+"'><img src='http://product.21-sun.com//uploadfiles/"+CommonString.getFormatPara(map.get("img2"))+"' width='80' height='60'></a><div class='ficinfo'><div class='fictit'><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(map.get("file_name"))+"'>"+CommonString.getFormatPara(map.get("factoryname"))+CommonString.getFormatPara(map.get("name"))+CommonString.getFormatPara(map.get("catalogname"))+"</a></div><div class='ficprice'></div></div><span class='ficdel' onclick='removeOne("+CommonString.getFormatPara(map.get("id"))+");'><span class='del'></span></span><div class='li_bg'></div></li>";
				rs = "<li id='comps_"+equipment_id+"'><span class='cb'><input checked='true'  value='"+equipment_id+"' class='inquiry'  name='xj_subBox' type='checkbox' id='checkbox"+equipment_id+"' /></span><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(map.get("file_name"))+"'><img src='http://product.21-sun.com//uploadfiles/"+CommonString.getFormatPara(map.get("img2"))+"' width='80' height='60'></a><div class='ficinfo'><div class='fictit'><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(map.get("file_name"))+"'>"+CommonString.getFormatPara(map.get("factoryname"))+CommonString.getFormatPara(map.get("name"))+CommonString.getFormatPara(map.get("catalogname"))+"</a></div><div class='ficprice'></div></div><span class='ficdel' onclick='removeOne1("+CommonString.getFormatPara(map.get("id"))+");'><span class='del'></span></span></li>";
			}else{
				rs="";
			}
		}
		
				
		//列表获取省市
		if("get_city_by_name".equals(flag)){
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String area_id = CommonString.getFormatPara(request.getParameter("area_id"));
			Map map = dbHelper.getMap("select area_id  from comm_area   where  area_name like '%"+province+"%' ");
            if(map!=null){
				area_id= CommonString.getFormatPara(map.get("area_id"));
			}
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {area_id},connection);
			StringBuffer html = new StringBuffer("<option value=''>选择城市</option>");
		    for(Map m : areas){
				    html.append("<option value='"+CommonString.getFormatPara(m.get("area_name"))+"'>"+CommonString.getFormatPara(m.get("area_name"))+"</option>");
			}
			rs=html.toString();
		}
		
		//列表获取省市
		if("get_city".equals(flag)){
			String area_id = CommonString.getFormatPara(request.getParameter("area_id"));
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {area_id},connection);
			StringBuffer html = new StringBuffer("<option value=''>选择城市</option>");
		    for(Map m : areas){
				    html.append("<option value='"+CommonString.getFormatPara(m.get("area_name"))+"'>"+CommonString.getFormatPara(m.get("area_name"))+"</option>");
			}
			rs=html.toString();
		}
		
		//询价
		if("inquiryOrders".equals(flag)){
			System.out.println("13");
			String compareids = CommonString.getFormatPara(request.getParameter("compareids"));
			System.out.println(compareids);
			String uname = CommonString.getFormatPara(request.getParameter("uname"));
			String phone = CommonString.getFormatPara(request.getParameter("phone"));
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String city = CommonString.getFormatPara(request.getParameter("city"));
			String buy_time = CommonString.getFormatPara(request.getParameter("buy_time"));
			String buy_type = CommonString.getFormatPara(request.getParameter("buy_type"));
			String productList[]=compareids.split(",");
			String testIP=Common.getIp(request);
			if(!testIP.equals("123.206.20.202")){
			for(int i=0;i<productList.length;i++){
				Map map = dbHelper.getMap("select name,factoryid,factoryname,catalognum,catalogname  from pro_products  where  id = ? ", new Object[] {CommonString.getFormatPara(productList[i])}, connection);
			    if(map!=null&&!uname.equals("")&&!phone.equals("")){
					String sql="INSERT INTO [pro_product_form] ([add_ip] ,[add_user] ,[add_date] ,[factoryid],[factoryname],[catanum] ,[cataname],[name],[product_id],[product_name],[contact_address],[contact_tel] ,[message],[province],[city],[mobile_phone],[uuid],[buy_time],[ifgroup] ,[is_first],[is_deleted]) VALUES ";
					sql+="('"+Common.getIp(request)+"','mulfront','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"',"+CommonString.getFormatPara(map.get("factoryid"))+",'"+CommonString.getFormatPara(map.get("factoryname"))+"','"+CommonString.getFormatPara(map.get("catalognum"))+"','"+CommonString.getFormatPara(map.get("catalogname"))+"','"+uname+"',"+CommonString.getFormatPara(productList[i])+",'"+CommonString.getFormatPara(map.get("name"))+"','"+province+city+"','"+phone+"','我对该产品感兴趣，请联系我','"+province+"','"+city+"','"+phone+"','"+CommonString.getUUID()+"','"+buy_time+"','个人',1,0)";
					//System.out.println(sql);
					dbHelper.execute(sql, connection);	
				}
			}	
			}
			rs="success";
		}
		
		//获取城市名称
		if("get_city_name".equals(flag)){
			String city = CommonString.getFormatPara(request.getParameter("city"));
			rs=city;
			Map areaMap = dbHelper.getMap(" select top 1 area_name  from comm_area where area_name  like '%"+city+"%' ");
			if(areaMap!=null){
				rs=CommonString.getFormatPara(areaMap.get("area_name"));
			}
		}
		//优买团瀑布
		if("tuan_list".equals(flag)){
	            int pages = Integer.parseInt(request.getParameter("page"));
				
				if(pages==0){
					rs="<li class='t01'><a href='http://product.21-sun.com/tuan/detail.jsp?id=134' target='_blank'><img class='main' src='/Static/images/tuan/ds.jpg' /> <div class='maincontent'><div class='logo'></div><div class='intro'> <strong>斗山风雨二十年，感恩回馈老客户！</strong><br>2014年9月1日-12月31日，凡购买斗山DX120的，享受发动机延保3年或6000小时保护，让您无后顾之忧！</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
			        rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/detail.jsp?id=133' target='_blank'><img class='main' src='/Static/images/tuan/shengang0819.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>广西华河 乔迁特价机</strong><br>全系列产品优惠幅度最低3万元/台，最高10万元/台！超低首付！超低利率！</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					rs+="<li class='t01'><a href='http://product.21-sun.com/tuan/detail.jsp?id=107' target='_blank'><img class='main' src='/Static/images/tuan/huifa0819.jpg' /><div class='maincontent'> <div class='logo'></div> <div class='intro'> <strong>汇发机械 专业、专一</strong><br>汇发机械专场 神钢产品特价优惠 专业、专一 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/detail.jsp?id=106' target='_blank'><img class='main' src='/Static/images/tuan/baoding0819.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>宝鼎挖掘机质量最重要，价格最实在，促销最贴心</strong><br>2014年12月—2015年1月将有数款特价机型可供选购，并赠送一次保养服务！</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				}				
				else if(pages==1){
					//rs="<li class='t01'><a href='http://product.21-sun.com/tuan/detail.jsp?id=100' target='_blank'><img class='main' src='/Static/images/tuan/cat0819.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>卡特彼勒 为中国而生</strong><br></div> <div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
			        //rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/detail.jsp?id=132' target='_blank'><img class='main' src='/Static/images/tuan/fangyuan0819.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>方圆集团搅拌站</strong><br></div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					rs="<li class='t01'><a href='http://product.21-sun.com/tuan/detail.jsp?id=112' target='_blank'><img class='main' src='/Static/images/tuan/shantui0819.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>山推降价10%，在线抢购，仅限3台</strong><br>（2014年11月10日9时-11月16日24时），在线抢购该机型（SL30W装载机），降价10%，仅限3台。 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/detail.jsp?id=109' target='_blank'><img class='main' src='/Static/images/tuan/longgong0819.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>龙工 效率推动未来 全系产品优惠促销</strong><br></div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					rs+="<li class='t01'><a href='http://product.21-sun.com/tuan/detail.jsp?id=114' target='_blank'><img class='main' src='/Static/images/tuan/shanzhong.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>福建山重 优惠季进行时</strong><br>整机在保修期内，进行十三次免费跟踪服务 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/detail.jsp?id=116' target='_blank'><img class='main' src='/Static/images/tuan/yaoding.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>买挖机 找尧鼎</strong><br>极地品质，为您工程保驾护航 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				}	
				else if(pages==2){
					//rs="<li class='t01'><a href='http://product.21-sun.com/tuan/detail.jsp?id=105' target='_blank'><img class='main' src='/Static/images/tuan/hengte0819.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>恒特重工恒久品质  特别奉献</strong><br></div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
			        //rs="<li class='t02'><a href='http://product.21-sun.com/tuan/detail.jsp?id=113' target='_blank'><img class='main' src='/Static/images/tuan/gongbing.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>连云港工兵 碎他山之石</strong><br>连云港工兵提供最专业的破碎设备 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					rs="<li class='t01'><a href='http://product.21-sun.com/tuan/detail.jsp?id=104' target='_blank'><img class='main' src='/Static/images/tuan/shangong0819.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>山工机械装载机</strong><br></div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
			        rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/detail.jsp?id=25' target='_blank'><img class='main' src='/Static/images/tuan/guojie.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>重庆国杰8月钜惠</strong><br></div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					//rs+="<li class='t01'><a href='http://product.21-sun.com/tuan/detail.jsp?id=130' target='_blank'><img class='main' src='/Static/images/tuan/juje01.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>广州巨和 挖机优惠大联盟</strong><br></div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					rs+="<li class='t01'><a href='http://product.21-sun.com/tuan/detail.jsp?id=111' target='_blank'><img class='main' src='/Static/images/tuan/xcmg0819.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>陕西众林 品质之选</strong><br>XE150-XE265网络定机更有精美礼品向赠：ipad平板mini一部，首付交齐再赠送配件万元大礼包 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/detail.jsp?id=117' target='_blank'><img class='main' src='/Static/images/tuan/leiwo.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>雷沃梦 驰恒活动优惠季</strong><br></div> <div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					//rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/detail.jsp?id=126' target='_blank'><img class='main' src='/Static/images/tuan/songyu.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>贵州松宇 购机大优惠</strong><br></div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				}	
				else if(pages==3){
					rs="<li class='t01'><a href='http://product.21-sun.com/tuan/december/' target='_blank'><img class='main' src='/Static/images/tuan/2013-12yue.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>十二月优买团—2013年终惠</strong><br>优买团品牌汇聚，2013年终惠</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /></div></div></a> </li>";
				    rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/november/' target='_blank'><img class='main' src='/Static/images/tuan/2013-11yue.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>十一月优买团—我们的故事</strong><br>每天有上万的终端用户汇集在这里选机比价，最终这里汇集了他们和我们的故事</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /></div></div></a> </li>";
					rs+="<li class='t01'><a href='http://product.21-sun.com/tuan/october/' target='_blank'><img class='main' src='/Static/images/tuan/2013-10yue.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>待我长发及腰，拖我回家可好</strong><br>10月优买团优惠购机,卡特新品,三一新品,小松挖掘机,龙工装载机,山推压路机</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div> </a> </li>";
                    rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/september/' target='_blank'><img class='main' src='/Static/images/tuan/2013-9yue.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>优买团9月优惠购机</strong><br>品牌英雄汇全民盛宴，卡特挖掘机，小松挖掘机，三一挖掘机，山推装载机等专场</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				}	
				else if(pages==4){
					rs="<li class='t01'><a href='http://product.21-sun.com/tuan/august/index.htm' target='_blank'><img class='main' src='/Static/images/tuan/2013-8yue.jpg' /><div class='maincontent'> <div class='logo'></div><div class='intro'> <strong>梦想新航线，未来合伙人</strong><br>徐工挖掘机专场、斯帕克破碎锤专场、山工机械装载机专场、三一挖掘机促销活动</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				    rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/july/' target='_blank'><img class='main' src='/Static/images/tuan/2013-7yue.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>奋起吧，优买团！</strong><br>7月优惠购机,卡特迷你挖掘机,山工机械装载机,三一挖掘机,卡特配件,福田挖掘机。 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					rs+="<li class='t01'><a href='http://product.21-sun.com/tuan/june/' target='_blank'><img class='main' src='/Static/images/tuan/2013-6yue.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>六月逆袭，优买团优惠购机</strong><br>在优买团下订单皆可享受超值优惠政策,包括三一、卡特、山工机械、徐工专场等优惠。</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				    rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/may/' target='_blank'><img class='main' src='/Static/images/tuan/2013-5yue.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>优买团5月优惠购机</strong><br>徐工挖掘机、江麓挖掘机、斯帕克破碎锤、卡特挖掘机、三一挖掘机等大型促销活动</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				}
				else if(pages==5){
					rs="<li class='t01'><a href='http://product.21-sun.com/tuan/april/' target='_blank'><img class='main' src='/Static/images/tuan/2013-4yue.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>4月优买团大事件掀起万人团购劲爆狂潮</strong><br>山工机械平地机免费试驾、临沂亚华三一挖机订机客户，均可享受三重优惠大礼！相同配置比价格，徐工最优！</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				    rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/cat/' target='_blank'><img class='main' src='/Static/images/tuan/cat01.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>“效”傲江湖 智勇对决</strong><br>卡特彼勒机型争霸江湖，总有一款随你笑看风云。 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				    rs+="<li class='t01'><a href='http://product.21-sun.com/tuan/doosan_ganen/index.htm' target='_blank'><img class='main' src='/Static/images/tuan/doushan.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>斗山感恩回馈大型让利促销</strong><br>每天有上万的终端用户汇集在这里选机比价，最终这里汇集了他们和我们的故事。 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				    rs+="<li class='t02'><a href='http://product.21-sun.com/activity/yhqg/index.jsp' target='_blank'><img class='main' src='/Static/images/tuan/doushan2.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>斗山315抢购</strong><br>2013年3月15日10:00-10:30，斗山山东地区挖掘机抢购会活动拉开帷幕。 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				}
				else if(pages==6){
					rs="<li class='t01'><a href='http://product.21-sun.com/activity/hthsy/' target='_blank'><img class='main' src='/Static/images/tuan/hongtong.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong> 宏通好声音，三一挖掘机乐享惠</strong><br>2013年3月18日，潍坊三一重机宏通机械大型订货会。全系产品全城乐享惠！三重大礼等你拿！ </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a></li>";
				    rs+="<li class='t02'><a href='http://product.21-sun.com/tuan/juhe/' target='_blank'><img class='main' src='/Static/images/tuan/jihe1.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>广州巨和聚爱狂欢实惠到家</strong><br>和合集团8周年，和心相伴合力共赢，聚爱狂欢实惠到家，相约和合好事连连</div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				    rs+="<li class='t01'><a href='http://product.21-sun.com/tuan/sany_spring/index.jsp' target='_blank'><img class='main' src='/Static/images/tuan/jihe2.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>广东三一春季大型订</strong><br> 品质三一，相约一世 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				    rs+="<li class='t02'><a href='http://product.21-sun.com/activity/rongrun/index.jsp' target='_blank'><img class='main' src='/Static/images/tuan/longgong.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>与龙工“秘密”约会</strong><br>购龙工50系列节能环保机型，共筑绿色中国梦 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				}
				else if(pages==7){
				    rs="<li class='t01'><a href='http://product.21-sun.com/tuan/semsj/' target='_blank'><img class='main' src='/Static/images/tuan/shangong.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'> <strong>山工机械平地机免费试用火热招募中</strong><br>好机械用过才知道！山工机械支持您对品质的苛刻，给您长达2周时间免费试用山工机械平地机 </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
					rs+="<li class='t02'><a href='http://product.21-sun.com/activity/yhsy/' target='_blank'><img class='main' src='/Static/images/tuan/zhongwang.jpg' /><div class='maincontent'><div class='logo'></div><div class='intro'><strong>约惠三一，中旺大型订货会</strong><br>2013年3月17日，湖南中旺三一挖掘机线上购机活动全系产品全城乐享惠！ </div><div class='buy'> <img class='dinggou' src='/images/dinggou1.png' /> </div></div></a> </li>";
				}else{
					rs="";
				}
		}
		
		//代理商显示办事处
		if("showOffice".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			Map map = dbHelper.getMap("select full_name,telphone  from pro_agent_factory  where  id = ? ", new Object[] {id}, connection);
           	List<Map> office_list = dbHelper.getMapList(" select name,telphone from pro_agent_factory   where is_show=1 and parent_id = ? ",new Object [] {id},connection);
			StringBuffer html = new StringBuffer("");
			if(map!=null){
				html.append("<li class='first_li'><h3>"+CommonString.getFormatPara(map.get("full_name"))+"</h3><p>电话："+(CommonString.getFormatPara(map.get("telphone")).equals("")?"暂无联系方式":CommonString.getFormatPara(map.get("telphone")))+"</p></li>");
			}
		    for(Map m : office_list){
				html.append("<li><h3>"+CommonString.getFormatPara(m.get("name"))+"</h3><p>电话："+(CommonString.getFormatPara(m.get("telphone")).equals("")?"暂无联系方式":CommonString.getFormatPara(m.get("telphone")))+"</p></li>");
			}
			if(office_list==null||office_list.size()<=0){
				html.append("<li>暂无办事处联系方式</li>");

			}
			rs=html.toString();
		}
		
		
		
		
		//搜索国内品牌
		if("searchInnerBrandAgent".equals(flag)){
			String whereStr="";
			String area = CommonString.getFormatPara(request.getParameter("area"));
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(!catalog.equals("")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and catalognum like '"+catalog+"%' group by factoryid)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,is_inner,english_name,upper_index  from pro_agent_factory where flag=1 and  is_show=1 and  is_inner=1  "+whereStr+"  order by upper_index  asc,view_count desc";
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br0"+(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")?"1":"2")+"'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/agent/"+(area.equals("")?"0":area)+"_0_"+CommonString.getFormatPara(oneMap.get("id"))+"_0.shtm'><span class='m'>"+CommonString.getFormatPara(oneMap.get("upper_index"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"</span><span class='s'>"+CommonString.getFormatPara(oneMap.get("english_name"))+"</span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();							
		}
		
		//搜索国外品牌
		if("searchOutBrandAgent".equals(flag)){
			String area = CommonString.getFormatPara(request.getParameter("area"));
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String whereStr="";
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(!catalog.equals("")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and catalognum like '"+catalog+"%' group by factoryid)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,is_inner,english_name,upper_index   from pro_agent_factory where  flag=1 and  is_show=1 and  is_inner=0   "+whereStr+"   order by upper_index  asc,view_count desc";
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br0"+(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")?"1":"2")+"'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/agent/"+(area.equals("")?"0":area)+"_0_"+CommonString.getFormatPara(oneMap.get("id"))+"_0.shtm'><span class='m'>"+CommonString.getFormatPara(oneMap.get("upper_index"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"</span><span class='s'>"+CommonString.getFormatPara(oneMap.get("english_name"))+"</span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();								
		}
		//按照字母搜索品牌
		if("searchByLetterAgent".equals(flag)){
			String area = CommonString.getFormatPara(request.getParameter("area"));
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String whereStr="";
			String letter = CommonString.getFormatPara(request.getParameter("letter"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			System.out.println("-----"+catalog);
			if(!catalog.equals("")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and catalognum like '"+catalog+"%' group by factoryid)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,is_inner,english_name,upper_index   from pro_agent_factory where   flag=1   and upper_index='"+letter+"' and  is_show=1"+whereStr;
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br0"+(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")?"1":"2")+"'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/agent/"+(area.equals("")?"0":area)+"_0_"+CommonString.getFormatPara(oneMap.get("id"))+"_0.shtm'><span class='m'>"+CommonString.getFormatPara(oneMap.get("upper_index"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"</span><span class='s'>"+CommonString.getFormatPara(oneMap.get("english_name"))+"</span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();								
		}
				
		//搜索品牌
		if("searchBrandAgent".equals(flag)){
			String area = CommonString.getFormatPara(request.getParameter("area"));
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String whereStr="";
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(!catalog.equals("")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and catalognum like '%"+catalog+"%' group by factoryid)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,is_inner,english_name,upper_index  from pro_agent_factory where  flag=1 and  is_show=1 and (  name like  '"+keyword+"%'  or   full_name  like '%"+keyword+"%'  or  pinyin  like '%"+keyword+"%' ) "+whereStr+" order by upper_index  asc,view_count desc";
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br0"+(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")?"1":"2")+"'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/agent/"+(area.equals("")?"0":area)+"_0_"+CommonString.getFormatPara(oneMap.get("id"))+"_0.shtm'><span class='m'>"+CommonString.getFormatPara(oneMap.get("upper_index"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"</span><span class='s'>"+CommonString.getFormatPara(oneMap.get("english_name"))+"</span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();								
		}
						
		//搜索所有品牌
		if("searchAllBrandAgent".equals(flag)){
			String whereStr="";
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
			String area = CommonString.getFormatPara(request.getParameter("area"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String province = CommonString.getFormatPara(request.getParameter("province"));		
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(!catalog.equals("")){
				whereStr+=" and id in (select factoryid from pro_products where is_show=1 and catalognum like '"+catalog+"%' group by factoryid)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,is_inner,english_name,upper_index  from pro_agent_factory where  flag=1 and  is_show=1 "+whereStr+" order by upper_index  asc,view_count desc ";
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br0"+(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")?"1":"2")+"'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/agent/"+(area.equals("")?"0":area)+"_0_"+CommonString.getFormatPara(oneMap.get("id"))+"_0.shtm'><span class='m'>"+CommonString.getFormatPara(oneMap.get("upper_index"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"</span><span class='s'>"+CommonString.getFormatPara(oneMap.get("english_name"))+"</span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();								
		}
		
		
		//搜索所有品牌
		if("goToAgentMul".equals(flag)){
			String brands = CommonString.getFormatPara(request.getParameter("brands"));
			session.setAttribute("mulAgentSelect", brands);
		}
		

		//对比页提交多个产品
		if("inquiryMul".equals(flag)){
			String uname = CommonString.getFormatPara(request.getParameter("uname"));
			String uphone = CommonString.getFormatPara(request.getParameter("uphone"));
            String compare_ids = CommonString.getFormatPara(request.getParameter("compare_ids"));
			String province=CommonString.getFormatPara(request.getParameter("province"));
			String city=CommonString.getFormatPara(request.getParameter("city"));
			if(!city.equals("")){
				Map cityMap = dbHelper.getMap(" select top 1 area_name  from comm_area where area_name  like '%"+city+"%' ",connection) ;
				if(cityMap!=null){
                    city=CommonString.getFormatPara(cityMap.get("area_name"));
				}
			}
			List<Map> proList = null ;
			String sql =" select factoryid,factoryname,catalognum,catalogname,name,id from  pro_products where id in("+compare_ids+") ";
            proList = dbHelper.getMapList(sql,connection) ;
			if(proList!=null){
			    for(Map productMap:proList){
			    	String insertsql = " insert into pro_product_form(is_first,add_user,add_date,add_ip,catanum,factoryid,factoryname,cataname,name,contact_address,mobile_phone,product_id,uuid,product_name,message,province,city,buy_time,ifgroup,company,buy_type) values(1,'compare','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+Common.getIp(request)+"','"+Common.securityFilter(CommonString.getFormatPara(productMap.get("catalognum")))+"','"+Common.securityFilter(CommonString.getFormatPara(productMap.get("factoryid")))+"','"+Common.securityFilter(CommonString.getFormatPara(productMap.get("factoryname")))+"','"+(CommonString.getFormatPara(productMap.get("catalogname")))+"','"+uname+"','"+province+city+"','"+uphone+"','"+Common.securityFilter(CommonString.getFormatPara(productMap.get("id")))+"','"+CommonString.getUUID()+"','"+Common.securityFilter(CommonString.getFormatPara(productMap.get("name")))+"','','"+province+"','"+city+"','','个人','','') " ;
                    dbHelper.executeUpdate(insertsql);
				}
			}
		}
		
		//对比页提交多个产品左侧
		if("inquiryMulLeft".equals(flag)){
			String uname = CommonString.getFormatPara(request.getParameter("user_name"));
			String uphone = CommonString.getFormatPara(request.getParameter("contact_tel"));
            String compare_ids = CommonString.getFormatPara(request.getParameter("compare_ids"));
			String province=CommonString.getFormatPara(request.getParameter("province"));
			String city=CommonString.getFormatPara(request.getParameter("city"));
			if(!city.equals("")){
				Map cityMap = dbHelper.getMap(" select top 1 area_name  from comm_area where area_name  like '%"+city+"%' ",connection) ;
				if(cityMap!=null){
                    city=CommonString.getFormatPara(cityMap.get("area_name"));
				}
			}
			List<Map> proList = null ;
			String sql =" select factoryid,factoryname,catalognum,catalogname,name,id from  pro_products where id in("+compare_ids+") ";
            proList = dbHelper.getMapList(sql,connection) ;
			if(proList!=null){
			    for(Map productMap:proList){
			    	String insertsql = " insert into pro_product_form(is_first,add_user,add_date,add_ip,catanum,factoryid,factoryname,cataname,name,contact_address,mobile_phone,product_id,uuid,product_name,message,province,city,buy_time,ifgroup,company,buy_type) values(1,'compareLeft','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"','"+Common.getIp(request)+"','"+Common.securityFilter(CommonString.getFormatPara(productMap.get("catalognum")))+"','"+Common.securityFilter(CommonString.getFormatPara(productMap.get("factoryid")))+"','"+Common.securityFilter(CommonString.getFormatPara(productMap.get("factoryname")))+"','"+(CommonString.getFormatPara(productMap.get("catalogname")))+"','"+uname+"','"+province+city+"','"+uphone+"','"+Common.securityFilter(CommonString.getFormatPara(productMap.get("id")))+"','"+CommonString.getUUID()+"','"+Common.securityFilter(CommonString.getFormatPara(productMap.get("name")))+"','','"+province+"','"+city+"','','个人','','') " ;
                    dbHelper.executeUpdate(insertsql);
				}
			}
		}
		if("updateAccessToken".equals(flag)){
			String accessToken=CommonString.getFormatPara(request.getParameter("accessToken"));
			dbHelper.execute(" update weixin_access_token set access_token =?,update_time=GETDATE()  where id=2 ",new Object[]{accessToken},connection);
			rs="success";
		}
		
		
		//新产品评论保存
		if("new_save_comment_new".equals(flag)){

			String sql = " insert into pro_comments_new (add_user, add_date, add_ip, content, product_id, score1, score2, score3, score4,uuid) ";
			sql += " values (?,?,?,?,?,?,?,?,?,?) ";
			String content = CommonString.getFormatPara(request.getParameter("content")) ; // 输入的内容

			int keyId = dbHelper.executeUpdate(sql,new Object []{"comment",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),CommonString.getFormatPara(request.getParameter("content")),CommonString.getFormatPara(request.getParameter("product_id")),CommonString.getFormatPara(request.getParameter("score1")),CommonString.getFormatPara(request.getParameter("score2")),CommonString.getFormatPara(request.getParameter("score3")),CommonString.getFormatPara(request.getParameter("score4")),UUID.randomUUID().toString()},connection);
			connection.setAutoCommit(false);
 
			connection.commit();
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>