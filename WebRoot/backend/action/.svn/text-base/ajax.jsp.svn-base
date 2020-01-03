<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String rs = "fail";
	String callback = CommonString.getFilterStr(request.getParameter("callback"));
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	
	
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
			String uuid = CommonString.getFormatPara(request.getParameter("id"));
			dbHelper.execute(" update "+tableName+" set view_count = isnull(view_count,0)+1 where id = ? ",new Object [] {uuid},connection);
			Integer viewCount = (Integer)dbHelper.getOne(" select view_count from "+tableName+" where id = ? ",new Object [] {uuid},connection);
			rs = ""+viewCount;
			String view_type = "" ;
			String type = null ;
			if(!"".equals(referer) && referer.indexOf("/")>0){
				type = referer.substring((referer.lastIndexOf("/")+1)) ;
				if(type.indexOf("intro")!=-1){
					view_type = "intro" ;
				}else if(type.indexOf("pic")!=-1){
					view_type = "pic" ;
				}else if(type.indexOf("agent")!=-1){
					view_type="agent" ;
				}else if(type.indexOf("message")!=-1){
					view_type="message" ;
				}else if(type.indexOf("order")!=-1){
					view_type="order" ;
				}else{
					view_type="config" ;
				}
			}
			String today = CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
			String sessionid = CommonString.getFormatPara(request.getSession().getId()) ; // 当前会话的id
			Object[] objs = new Object[]{sessionid,today,uuid,view_type} ;
			StringBuffer whereStr = new StringBuffer(" where session_id=? and view_date=? and product_id=? and view_type=?") ;
			String sel_sql = " select count(*) total from pro_products_view_record" ;
			String ins_sql = " insert into pro_products_view_record (session_id,view_date,product_id,view_type) values(?,?,?,?)" ;
			if(Integer.parseInt(dbHelper.getMap(sel_sql+whereStr.toString(),objs,connection).get("total").toString())<=0){
				dbHelper.execute(ins_sql,objs,connection);
			}
			
			String pro_info_cookie = "select factoryname,catalogname,name,price_end,img2,file_name from pro_products where id=? " ; // 获得浏览记录 cookie 得到产品信息
			Map pro_info = null ;
			if(!"".equals(uuid)){
			 	pro_info = dbHelper.getMap(pro_info_cookie,new Object[]{uuid},connection) ;
			}
			if(pro_info==null){
				pro_info = new HashMap() ;
			}
			String factoryname = CommonString.getFormatPara(pro_info.get("factoryname")) ;
			String name = CommonString.getFormatPara(pro_info.get("name")) ;
			String price = "参考价:"+(CommonString.getFormatPara(pro_info.get("price_end")).equals("0")?"面议":(CommonString.getFormatPara(pro_info.get("price_end"))+"万"));
			String catalogname = CommonString.getFormatPara(pro_info.get("catalogname")) ;
			String file_name = CommonString.getFormatPara(pro_info.get("file_name")) ;
			String img = "/uploadfiles/"+CommonString.getFormatPara(pro_info.get("img2")) ;
			%>
			<script type="text/javascript" src="/scripts/history/json.js"></script>
			<script type="text/javascript" src="/scripts/history/history.js"></script>
			<script type="text/javascript">
	           addHistory("<%=uuid%>",escape("<%=factoryname%>"),escape("<%=name%>"),escape("<%=price%>"),escape("<%=catalogname%>"),escape("<%=img%>"),escape("<%=file_name%>"));
			</script>
			<%
		}
		
		//返回产品总数
		if("proCount".equals(flag)){
			Integer proCount = (Integer)dbHelper.getOne(" select count(*) from "+tableName+" where 1 = 1 ",connection);
			rs = "本站共有 <font style='font-size:17px;color:red;'><b>"+proCount+"</b></font> 台设备！";
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
			StringBuffer sBuffer = new StringBuffer("") ;
			String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
			List<Map> catalogList = dbHelper.getMapList(" select top 4 factoryid,factoryname,max(view_count) view_count from pro_products where catalognum like '"+catalog+"%' and factoryid <>'"+factoryid+"' group by factoryid,factoryname order by max(view_count) desc  ",connection) ;
			if(null !=catalogList && catalogList.size()>0){
				for(Map oneMap:catalogList){
					sBuffer.append("<li><a href='list.jsp?factoryid="+CommonString.getFormatPara(oneMap.get("factoryid"))+"'>"+CommonString.getFormatPara(oneMap.get("factoryname"))+"</a></li>") ;
				}
			}
			rs = sBuffer.toString() ;
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
			String productId = CommonString.getFormatPara(request.getParameter("productId"));
			String province = CommonString.getFormatPara(request.getParameter("province"));  // 下单区域
			String city = CommonString.getFormatPara(request.getParameter("city"));
			if(city.indexOf("-")!=-1){
				city = city.split("-")[1];
			}
			if(province.indexOf("北京")!=-1){
				city = "北京" ;
			}
			if(province.indexOf("天津")!=-1){
				city = "天津" ;
			}
			if(province.indexOf("上海")!=-1){
				city = "上海" ;
			}
			if(province.indexOf("重庆")!=-1){
				city = "重庆" ;
			}
			if(province.indexOf("-")!=-1){
				province = province.split("-")[1];
			}
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
			
			if(!productId.equals("")){
				rs = "";
				Map pro1 = (Map)dbHelper.getMap(" select  catalognum, catalogname, name  from  pro_products  where id = '"+productId+"' ",connection);
				if(pro1 != null && pro1.get("name") != null){
			       catalogname1 = CommonString.getFormatPara(pro1.get("catalogname")) ;
				   productname1 = CommonString.getFormatPara(pro1.get("name")) ;
				  	}
					
					
			}
			
			//System.out.println("factoryid---"+factoryid) ;  
			//给厂家高级营销宝发短信
			if(!factoryid.equals("")){
				rs = "";
				Map brandM1 = (Map)dbHelper.getMap(" select usern,tel_sms  from pro_agent_factory where id = '"+factoryid+"' and is_shop = 3 and is_qijiandian = 1 ",connection);
				if(brandM1 != null && brandM1.get("usern") != null){
			       tel_sms = CommonString.getFormatPara(brandM1.get("tel_sms")) ;
				   content1 = province+city+user_name+contact_tel+"询"+factoryname+productname1+catalogname1;  
				    				try { 
											Map root1 = new HashMap() ;  
											root1.put("phone",tel_sms) ;   
											root1.put("content",content1) ;  
											root1.put("source","195002");
											Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",root1);
										} catch (Exception e) {
									 }
										
										//System.out.println("bbbbbbbb"+tel_sms+"--------"+content1) ; 
				}
			}
	
		
			//如果产品不为空
			if(!"".equals(productId)){
				//查询出相关代理商
				String sql = " SELECT paf.city_tel,paf.email,paf.is_shop,pp.factoryid,pp.factoryname,pap.agent_id,paf.full_name,pp.catalognum,pp.catalogname, ";
				sql += "pap.product_id,pp.name AS product_name,paf.city ";
				sql += "FROM pro_agent_products pap , pro_products pp , pro_agent_factory paf";
				sql += " WHERE pap.product_id = pp.id AND pap.agent_id = paf.id ";
				sql += " AND paf.flag = 2 AND ( paf.parent_id IS NULL OR paf.parent_id = 0 ) ";
				sql += " AND pap.product_id = "+productId; 
				sql += " AND paf.id IN ( "; 
				if(factoryid.equals("135")){
				sql+="16350,16349,16348,16347,16346,16345";
				   if(province.indexOf("江西")!=-1){
				   sql+=",677";
				   }
				}else if(factoryid.equals("136")&&province.indexOf("河南")!=-1){
				sql+="1873";
				}else if((factoryid.equals("137")&&(province.indexOf("广西")!=-1||province.indexOf("山西")!=-1))||(factoryid.equals("192")&&(province.indexOf("四川")!=-1||province.indexOf("湖北")!=-1||province.indexOf("重庆")!=-1||province.indexOf("新疆")!=-1))){
				sql+="1661";
				}else if(factoryid.equals("190")&&province.indexOf("湖南")!=-1){
				sql+="14216";
				}else if(factoryid.equals("182")&&province.indexOf("江苏")!=-1){
				sql+="370";
				}else if(factoryid.equals("152")&&province.indexOf("江苏")!=-1){
				sql+="1569";
				}else{
				//sql += " SELECT agent_id FROM "; 
				//sql += " pro_agent_factory_and_area ";
				//sql += " WHERE  factory_id="+factoryid+" AND area_id = ( ";
				//sql += " SELECT TOP 1 area_id FROM ";
				//sql += " comm_area ";
				//sql += " WHERE area_name LIKE '%"+city+"%' ";
				//sql += " AND level_id=2 ) ";
				//sql += " GROUP BY agent_id "; 
				}
				sql += ") "; 
				List<Map> list = dbHelper.getMapList(sql,connection);
				
				//System.out.println("---sql111---"+sql) ;
				
				
				String uuid = "" ;
				if(null!=list){
					int size = list.size();
					if(size>0){
						Map m = null;
						//插入订单
						sql = " insert into pro_agent_products_form (uuid, add_ip , add_user , add_date , no , factory_id , factory_name , agent_id , agent_name , cata_num , cata_name , product_id , product_name , contact_address , contact_tel , province , city , state , form_date , ifgroup , buy_time , message , user_name , company_name , source_id ) ";
						sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) ";
						
						
						for(int i=0;i<size;i++){
							m = list.get(i);
							uuid =  UUID.randomUUID().toString()  ;
							/*只有龙工几家代理商会自动推送订单*/
							dbHelper.execute(sql,new Object [] {uuid ,Common.getIp(request),"",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),CommonString.getFormatPara(m.get("agent_id"))+productId+CommonDate.getToday("yyyyMMddHHmmss"),CommonString.getFormatPara(m.get("factoryid")),CommonString.getFormatPara(m.get("factoryname")),CommonString.getFormatPara(m.get("agent_id")),CommonString.getFormatPara(m.get("full_name")),CommonString.getFormatPara(m.get("catalognum")),CommonString.getFormatPara(m.get("catalogname")),CommonString.getFormatPara(m.get("product_id")),CommonString.getFormatPara(m.get("product_name")),province+city,contact_tel,province,city,0,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),ifgroup,buy_time,message,user_name,company_name,source_id},connection);
							
							String content = province+city+user_name+contact_tel+"询"+CommonString.getFormatPara(m.get("factoryname"))+CommonString.getFormatPara(m.get("product_name"))+CommonString.getFormatPara(m.get("catalogname"));
							// 开通营销宝的代理商发送订单，邮件和短信(高级版)
							if(CommonString.getFormatPara(m.get("is_shop")).equals("3")){
								String email = CommonString.getFormatPara(m.get("email")) ;  // 该代理商的邮箱
								String telphone = CommonString.getFormatPara(m.get("city_tel")) ; // 该代理商的电话
								String str = "" ;
								//如果代理商电话不为空
								//if(null!=telphone&&!"".equals(telphone)){
									  try { 
											Map root = new HashMap() ;  
											root.put("phone",telphone) ;   
											root.put("content",content) ;  
											root.put("source","195002");
											Common.doPostHttpAsync("http://service.21-sun.com/http/utils/sms.jsp",root);
										} catch (Exception e) {
			
									 }
								//}
						        WEBEmail.sendMailByUrl(email, null, null, CommonString.getFormatPara(m.get("factoryname"))
										+ CommonString.getFormatPara(m.get("product_name")) + CommonString.getFormatPara(m.get("catalogname"))
										+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new_agent.jsp?uuid="+uuid,
										"utf-8");  
						        WEBEmail.sendMailByUrl("wanggq@21-sun.com", null, null, CommonString.getFormatPara(m.get("factoryname"))
										+ CommonString.getFormatPara(m.get("product_name")) + CommonString.getFormatPara(m.get("catalogname"))
										+ "询价单  -  来自中国工程机械商贸网(www.21-sun.com) 产品中心AD", "http://product.21-sun.com/tools/email/email_detail_new_agent.jsp?uuid="+uuid,
										"utf-8");
							}
						}
					}
				}
			}else if(!"".equals(factoryid)){//如果厂家不为空
				//找出所有该区域该厂家的代理商 
				String sql = " SELECT TOP 10 * FROM ";
				sql += " pro_agent_factory "; 
				sql += " WHERE flag = 2  AND ( parent_id IS NULL OR parent_id = 0 ) ";
				sql += " AND id IN ( SELECT agent_id FROM pro_agent_products WHERE factory_id = "+factoryid+" ) ";
				sql += " AND id IN ( ";
				sql += " SELECT agent_id FROM ";
				sql += " pro_agent_factory_and_area ";
				sql += " WHERE factory_id="+factoryid+" AND  area_id = ( ";
				sql += " SELECT TOP 1 area_id FROM ";
				sql += " comm_area ";
				sql += " WHERE area_name LIKE '%"+city+"%' and level_id=2 ";
				sql += " ) ";
				sql += " GROUP BY agent_id ";
				sql += ") ";
				List<Map> list = dbHelper.getMapList(sql,connection);
				if(null!=list){
					int size = list.size();
					if(size>0){
						Map m = null;
						//插入订单
						sql = " insert into pro_agent_products_form ( add_ip , add_user , add_date , no , factory_id , factory_name , agent_id , agent_name , contact_address , contact_tel , province , city , state , form_date , ifgroup , buy_time , message , user_name , company_name ) ";
						sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) ";
						
						
						for(int i=0;i<size;i++){
							m = list.get(i);
							//取消代理商推送
							//dbHelper.execute(sql,new Object [] {Common.getIp(request),"",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),CommonString.getFormatPara(m.get("id"))+CommonDate.getToday("yyyyMMddHHmmss"),factoryid,factoryname,CommonString.getFormatPara(m.get("id")),CommonString.getFormatPara(m.get("full_name")),province+city,contact_tel,province,city,0,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),ifgroup,buy_time,message,user_name,company_name},connection);
						}
					}
				}
			}
		}
		
		
		if("order_to_agent".equals(flag)){
			String agentId = CommonString.getFormatPara(request.getParameter("agentid"));
			String agentName = CommonString.getFormatPara(request.getParameter("agentname"));
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String city = CommonString.getFormatPara(request.getParameter("city"));
			String contact_tel = CommonString.getFormatPara(request.getParameter("contact_tel"));
			String ifgroup = CommonString.getFormatPara(request.getParameter("ifgroup"));
			String buy_time = CommonString.getFormatPara(request.getParameter("buy_time"));
			String message = CommonString.getFormatPara(request.getParameter("message"));
			String user_name = CommonString.getFormatPara(request.getParameter("user_name"));
			String company_name = CommonString.getFormatPara(request.getParameter("company_name"));
			String factoryid = CommonString.getFormatPara(request.getParameter("factoryid"));
			String factoryname = CommonString.getFormatPara(request.getParameter("factoryname"));
			String catanum = CommonString.getFormatPara(request.getParameter("catanum"));
			String cataname = CommonString.getFormatPara(request.getParameter("cataname"));
			//插入订单
			String sql = " insert into pro_agent_products_form ( add_ip , add_user , add_date , no , agent_id , agent_name , contact_address , contact_tel , province , city , state , form_date , ifgroup , buy_time , message , user_name , company_name , factory_id , factory_name , cata_num , cata_name ) ";
			sql += " values ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? ) ";
			//取消代理商订单推送
			//dbHelper.execute(sql,new Object [] {Common.getIp(request),"",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),agentId+CommonDate.getToday("yyyyMMddHHmmss"),agentId,agentName,province+city,contact_tel,province,city,0,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),ifgroup,buy_time,message,user_name,company_name,factoryid,factoryname,catanum,cataname},connection);
			
			//插入订单
			String sql2 = " insert into pro_product_form ( add_ip , add_user , add_date ,  uuid , agentid , agentname , contact_address , contact_tel , mobile_phone, province , city , state , ifgroup , buy_time , message , name , company , factoryid , factoryname ) ";
			sql2 += " values ( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , ?, ?  ) ";
			dbHelper.execute(sql2,new Object [] {
					Common.getIp(request),
					"",
					CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),
					CommonString.getUUID(),
					agentId,agentName,
					province+city,contact_tel,contact_tel,province,city,0,
					ifgroup,buy_time,message,user_name,company_name,factoryid,factoryname
			},connection);
			
		
		}
		
		
		
		if("getAgentViewCount".equals(flag)){
			String agentId = CommonString.getFormatPara(request.getParameter("agentId")) ;  // 代理商 id
			String today = CommonDate.getToday("yyyy-MM-dd") ;
			String todayTime = CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
			Map oneMap = null ;
			String sel_sql = " select counts from pro_agent_statistics where type=0 and agent_id=? and convert(varchar,statistics_date,23)=?" ;
			String upt_sql = " update pro_agent_statistics set counts=isnull(counts,1)+1 where agent_id=? and convert(varchar,statistics_date,23)=?" ;
			String ins_sql = " insert into pro_agent_statistics(type,counts,agent_id,statistics_date,source) values(0,1,?,?,?)" ; // 以天为统计单位
			String ins_sql_detail = "insert into pro_agent_statistics_detail(type,agent_id,statistics_date,source,source_ip) values(0,?,?,?,?)" ;
			// String del_sql = " delete from pro_agent_statistics_detail where " ;
			if(!agentId.equals("")){
				dbHelper.execute(ins_sql_detail,new Object[]{agentId,todayTime,CommonString.getFormatPara(request.getHeader("Referer")),Common.getIp(request)},connection) ;  // 
			}
			oneMap = dbHelper.getMap(sel_sql,new Object[]{agentId,today},connection);
			if(null!=oneMap && Integer.parseInt((CommonString.getFormatPara(oneMap.get("counts"))))>0){
				dbHelper.execute(upt_sql,new Object[]{agentId,today},connection) ;
			}else{
				dbHelper.execute(ins_sql,new Object[]{agentId,today,CommonString.getFormatPara(request.getHeader("Referer"))},connection);
			}
		}
		// 产品中心显示 
		if("viewCountProAds".equals(flag)){
			String adsId = CommonString.getFormatPara(request.getParameter("adsId")) ;
			String cata_num = CommonString.getFormatPara(request.getParameter("cata_num"));
			if("".equals(cata_num)&&cata_num.length()>=6){
				cata_num = cata_num.substring(0,6);
			}
			if(!"".equals(adsId)){
				String [] adArr = adsId.split(",");
				String ins_sql = "insert into pro_agent_prolist_ad_show(agent_id,cata_num,show_date) values(?,?,?)" ; 
				for(int i=0;i<adArr.length;i++){
					dbHelper.execute(ins_sql,new Object[]{adArr[i],cata_num,CommonDate.getToday("yyyy-MM-dd HH:mm:ss")},connection) ;
				}
			}
		}
		// 产品中心广告点击 
		if("viewCountProAdsClick".equals(flag)){
			String ins_sql = "insert into pro_agent_prolist_ad_click(agent_id,cata_num,click_date) values(?,?,?)" ;
			String adsId = CommonString.getFormatPara(request.getParameter("adsId")) ;
			String cata_num = CommonString.getFormatPara(request.getParameter("cata_num"));
			if("".equals(cata_num)&&cata_num.length()>=6){
				cata_num = cata_num.substring(0,6);
			}
			if(!"".equals(adsId)){
				dbHelper.execute(ins_sql,new Object[]{adsId,cata_num,CommonDate.getToday("yyyy-MM-dd HH:mm:ss")},connection) ;
			}
		}
		if("tuan_form".equals(flag)){
			String compname = CommonString.getFormatPara(request.getParameter("compname")); //公司名称
			String username = CommonString.getFormatPara(request.getParameter("username")); //姓名
			String telphone = CommonString.getFormatPara(request.getParameter("telphone")); //电话
			String company = CommonString.getFormatPara(request.getParameter("company")); //合作内容
			String rand = CommonString.getFormatPara(request.getParameter("rand")); // 验证码
			String sessionRand = CommonString.getFormatPara(session.getAttribute("rand"));
			if (!sessionRand.equals(rand)) {
				out.println("{\"info\":\"<span style='color:red;'>验证码不正确!</span>\",\"status\":\"n\"}");
				System.out.println("验证码不正确");
				return;
			}
			if(Pattern.matches("(0\\d{2,3}\\s?[\\-]?\\s?\\d{7,8})|(1\\d{10})", telphone)){
				 // 拼html发送邮件
				 StringBuffer sbf_html = new StringBuffer("<table width='482' height='396' border='1' align='center' cellpadding='0' cellspacing='0' bordercolor='C4BED8'>") ;
				 //----------------------------------------------------------------------------
				 sbf_html.append("<tr bgcolor='#F2EDFF'>") ;
				 sbf_html.append("<th height='34' colspan='2' scope='col'>") ;
				 sbf_html.append("优买团报名</th></tr>") ;
				 //--
				 sbf_html.append("<tr bgcolor='#F2EDFF'>") ;
				 sbf_html.append("<td width='150' height='32'>") ;
				 sbf_html.append("<div align='right' style='width: 100px;'>") ;			
				 sbf_html.append("姓名") ;			
				 sbf_html.append("</div></td>") ;		
				 sbf_html.append("<td width='406'>") ;	
				 sbf_html.append("<div align='left'>") ;		
				 sbf_html.append("&nbsp;&nbsp;"+username) ;								
				 sbf_html.append("</div></td></tr>") ;	
				 //--
				 sbf_html.append("<tr bgcolor='#F2EDFF'>") ;
				 sbf_html.append("<td width='150' height='32'>") ;
				 sbf_html.append("<div align='right' style='width: 100px;'>") ;			
				 sbf_html.append("公司名称") ;			
				 sbf_html.append("</div></td>") ;		
				 sbf_html.append("<td width='406'>") ;	
				 sbf_html.append("<div align='left'>") ;		
				 sbf_html.append("&nbsp;&nbsp;"+compname) ;								
				 sbf_html.append("</div></td></tr>") ;	
				 //--
				 sbf_html.append("<tr bgcolor='#F2EDFF'>") ;
				 sbf_html.append("<td width='150' height='32'>") ;
				 sbf_html.append("<div align='right' style='width: 100px;'>") ;			
				 sbf_html.append("联系电话") ;			
				 sbf_html.append("</div></td>") ;		
				 sbf_html.append("<td width='406'>") ;	
				 sbf_html.append("<div align='left'>") ;		
				 sbf_html.append("&nbsp;&nbsp;"+telphone) ;								
				 sbf_html.append("</div></td></tr>") ;	
				 //--
				 sbf_html.append("<tr bgcolor='#F2EDFF'>") ;
				 sbf_html.append("<td width='150' height='32'>") ;
				 sbf_html.append("<div align='right' style='width: 100px;'>") ;			
				 sbf_html.append("合作内容") ;			
				 sbf_html.append("</div></td>") ;		
				 sbf_html.append("<td width='406'>") ;	
				 sbf_html.append("<div align='left'>") ;		
				 sbf_html.append("&nbsp;&nbsp;"+company) ;								
				 sbf_html.append("</div></td></tr>") ;			
				 //----------------------------------------------------------------------------
				 int isCheckOk = 0;//
 				 if(Tools.isChineseCharacter(username) && Tools.isChineseCharacter(compname)){
 					isCheckOk = 1;
				 }else{
					 isCheckOk = 0;
					 //System.out.println("username or compname is not chinese!");
				 }
				 if(company!=null && !company.equals("")){
					 if(Tools.isChineseCharacter(company)&& isCheckOk==1){
						 isCheckOk = 1;
					 }else{
						 isCheckOk = 0;
						 //System.out.println("company is not chinese!");
					 } 
				 }
				 if(isCheckOk==1){
					WEBEmail.sendMail("yuxj@21-sun.com,zangss@21-sun.com,qinhy@21-sun.com,wanggq@21-sun.com,zhuch@21-sun.com",null,null,"优买团报名",sbf_html.toString());
					WEBEmail.sendMail("gaopeng@21-sun.com",null,null,"优买团报名ok",sbf_html.toString());
				 }else{
					 WEBEmail.sendMail("gaopeng@21-sun.com",null,null,"优买团报名no",sbf_html.toString());
				 }
			}
			out.println("{\"info\":\"提交成功!\",\"status\":\"y\"}");
			return ;
		}
		if("agent_news_view_count".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
			String agent_id = CommonString.getFormatPara(request.getParameter("agent_id"));
			String sql = " select count(*) from pro_agent_statistics where datediff(day,statistics_date,getdate()) = 0 and type = 1 ";
			sql += " and source = '"+id+"' ";
			Integer counts = (Integer)dbHelper.getOne(sql,connection);
			if(counts>0){
				sql = " update pro_agent_statistics set counts = isnull(counts,0) + 1 where datediff(day,statistics_date,getdate()) = 0 and type = 1 ";
				sql += " and source = '"+id+"' ";
				sql += " and agent_id = '"+agent_id+"' ";
				dbHelper.execute(sql,connection);
			}else{
				sql = " insert into pro_agent_statistics ( type , source , counts , agent_id , statistics_date ) ";
				sql += " values ( ? ,? , ? , ? , ? )";
				dbHelper.execute(sql,new Object [] {
						1,id,1,agent_id,CommonDate.getToday("yyyy-MM-dd")
				},connection);
			}
			sql = " insert into pro_agent_statistics_detail ( type , source , agent_id , statistics_date , source_ip ) ";
			sql += " values ( ? , ? , ? , ? , ? )";
			dbHelper.execute(sql,new Object [] {
				1,id,agent_id,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request)
			},connection);
		}
		if("jia_ru_ding_dan_tong".equals(flag)){
			String ip  = Common.getIp(request);
			String jsonStr = Tools.getMyProvinceAndCity(ip);
			String city = "";
			String province = "";
			if(!CommonString.getFormatPara(jsonStr).equals("")){
				JSONObject obj = new JSONObject(jsonStr);
				if(null!=obj&&obj.length()>0){
					province = CommonString.getFormatPara(obj.getString("province"));
					city = CommonString.getFormatPara(obj.getString("city"));
				}
			}
			String name = CommonString.getFormatPara(request.getParameter("name"));
			String email = CommonString.getFormatPara(request.getParameter("email"));
			String phone = CommonString.getFormatPara(request.getParameter("phone"));
			String message = CommonString.getFormatPara(request.getParameter("message"));
			String emailText = "";
			emailText += "【"+province;
			if(!province.equals(city)){
				emailText += city;
			}
			emailText += "】的";
			emailText += "【"+name + "】申请加入订单宝<br />";
			emailText += "邮箱是："+email+"<br />";
			emailText += "电话是："+phone+"<br />";
			emailText += "内容是："+message+"<br />";
			HttpClient httpClient = new HttpClient();
			PostMethod postMethod = new PostMethod("http://service.21-sun.com/http/utils/sendmail.jsp");
			postMethod.getParams().setContentCharset("UTF-8");
			postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
			//postMethod.addParameter("to","sunfh@21-sun.com");
			//postMethod.addParameter("to","zhenghj@21-sun.com,zhangchen@21-sun.com");
			postMethod.addParameter("to","zengfc@21-sun.com,yuxj@21-sun.com");
			//postMethod.addParameter("cc","zhuch@21-sun.com,wanggq@21-sun.com,sunfh@21-sun.com");
			postMethod.addParameter("title","来自产品中心的消息");
			postMethod.addParameter("content",emailText);
			postMethod.addParameter("fixed","21sun");
			//httpClient.executeMethod(postMethod);
		    WEBEmail.sendMail("zengfc@21-sun.com,yuxj@21-sun.com",null,null,"来自产品中心的消息",emailText);

		}
		if("jia_ru_ding_dan_tong_new".equals(flag)){
			String rand = CommonString.getFormatPara(request.getParameter("rand")); // 验证码
	        String sessionRand = CommonString.getFormatPara(session.getAttribute("rand"));
	        if (!sessionRand.equals(rand)) {
			     out.println("0");
		         return;
	        }
			
			String ip  = Common.getIp(request);
			String jsonStr = Tools.getMyProvinceAndCity(ip);
			String city = "";
			String province = "";
			if(!CommonString.getFormatPara(jsonStr).equals("")){
				JSONObject obj = new JSONObject(jsonStr);
				if(null!=obj&&obj.length()>0){
					province = CommonString.getFormatPara(obj.getString("province"));
					city = CommonString.getFormatPara(obj.getString("city"));
				}
			}
			String name = CommonString.getFormatPara(request.getParameter("name"));
			String email = CommonString.getFormatPara(request.getParameter("email"));
			String phone = CommonString.getFormatPara(request.getParameter("phone"));
			String message = CommonString.getFormatPara(request.getParameter("message"));
			String emailText = "";
			emailText += "【"+province;
			if(!province.equals(city)){
				emailText += city;
			}
			emailText += "】的";
			emailText += "【"+name + "】申请加入订单宝<br />";
			emailText += "邮箱是："+email+"<br />";
			emailText += "电话是："+phone+"<br />";
			emailText += "内容是："+message+"<br />";
			HttpClient httpClient = new HttpClient();
			PostMethod postMethod = new PostMethod("http://service.21-sun.com/http/utils/sendmail.jsp");
			postMethod.getParams().setContentCharset("UTF-8");
			postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
			//postMethod.addParameter("to","sunfh@21-sun.com");
			//postMethod.addParameter("to","zhenghj@21-sun.com,zhangchen@21-sun.com");
			postMethod.addParameter("to","zengfc@21-sun.com");
			//postMethod.addParameter("cc","zhuch@21-sun.com,wanggq@21-sun.com,sunfh@21-sun.com");
			postMethod.addParameter("title","来自产品中心的消息");
			postMethod.addParameter("content",emailText);
			postMethod.addParameter("fixed","21sun");
			//httpClient.executeMethod(postMethod);
		    WEBEmail.sendMail("zengfc@21-sun.com,yuxj@21-sun.com",null,null,"来自产品中心的消息",emailText);
            out.println("1");
			return;
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
			String id = CommonString.getFormatPara(request.getParameter("id")) ;
			String upt_sql = "update pro_agent_news set view_count=isnull(view_count,1)+1 where id=?" ;
			if(!"".equals(id)){
				dbHelper.execute(upt_sql,new Object[]{id},connection) ;
			}
			
		}
		if("getCommonProducts".equals(flag)){
			int proId = CommonString.getFormatInt(request.getParameter("id")) ; // 产品 id
			int catalog = CommonString.getFormatInt(request.getParameter("catalog")) ;   // 类型
			int factoryid = CommonString.getFormatInt(request.getParameter("factoryid")) ; // 品牌
			
			String do_sql = " if object_id('tempdb..#temp_table') is not null Begin drop table #temp_table End" ;  // 先删除临时表
			// 创建临时表
			 do_sql += " select top 60 identity(int,1,1) id ,name, factoryname,catalogname,file_name,img2 into #temp_table from pro_products where catalognum like '"+catalog+"%' and factoryid<>'"+factoryid+"' order by view_count desc " ;
			// 选出记录
			 do_sql += " select top 6 * from #temp_table where id in( select min(id) from #temp_table group by factoryname )" ;
			List<Map> proList = null ;
			StringBuffer html = new StringBuffer("") ;
			if(!"".equals(catalog)&& !"0".equals(catalog) && !"".equals(factoryid)){
				proList = dbHelper.getMapList(do_sql,connection) ;
			}
			if(null!=proList && proList.size()>0){
				html.append("<div class='stitle'>") ;
			    html.append("<h3>"+CommonString.getFormatPara(catalogMap.get(catalog))+"同类产品</h3>") ;
			    html.append("<span class='more'><a href='/products/prolist.jsp?catalog="+catalog+"' target='_blank'>更多&gt;&gt;</a></span>") ;
			    html.append("</div>") ;
			    html.append("<div class='scontent'>") ;
			    html.append("<ul class='slist'>") ;
				for(Map oneMap:proList){
				    html.append("<li><a href='/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name"))+"' target='_blank' title='"+CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"'><img src='/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2"))+"' alt='"+CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"' onerror="+"showImgDelay(this,'/uploadfiles/no_small.gif',2);"+" width='80' height='70' />") ;
				    html.append("<h4>"+CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"</h4>") ;
				    html.append("</a></li>") ;
				}
			    html.append("</ul>") ; 
			    html.append(" </div>") ;
			}
		    
			out.println(html.toString()) ;
			return ;
		}
		// 旗舰店订单
		/*注意：因为添加过滤导致传输where参数时and被过滤sql报错，旗舰店调用订单时本改为本页面查询，本方法停用	*/
		if("getAgentOrders".equals(flag)){
			Integer nowPage = CommonString.getFormatInt(request.getParameter("nowPage"));
			Integer pageSize = CommonString.getFormatInt(request.getParameter("pageSize"));
			String where = CommonString.getFormatPara(request.getParameter("where")) ;
			String fields = CommonString.getFormatPara(request.getParameter("fields")) ;
			String orderBy = CommonString.getFormatPara(request.getParameter("orderBy")) ; // 排序
			StringBuffer whereStr = new StringBuffer(" and 1=1 ") ;
			if(!"".equals(where)){
				whereStr.append(where) ;
			}
			PageBean pageBean = new PageBean() ;
			pageBean.setTableName(tableName) ;
			pageBean.setPageSize(pageSize) ;
			pageBean.setCondition(whereStr.toString()) ;
			pageBean.setFields(fields) ;
			pageBean.setOrderBy(orderBy) ;
			pageBean.setNowPage(nowPage) ;
			List<Map> agentOrders = pageBean.getDatas(connection);
			JSONArray arrays = new JSONArray(agentOrders);
			JSONObject obj = new JSONObject();
			obj.put("list",arrays);
			obj.put("total",pageBean.getTotal());
			obj.put("nowPage",nowPage);
			obj.put("pageSize",pageBean.getPageSize());
			obj.put("pageCount",pageBean.getPageCount());
			out.print(obj.toString());
			return ;
		}
		
		//获取改产品同品牌其他产品
	    if("brandProductList".equals(flag)){  
			int catalog = CommonString.getFormatInt(request.getParameter("catalog")) ;   // 类型
			int factoryid = CommonString.getFormatInt(request.getParameter("factoryid")) ; // 品牌	
			List<Map> proList = null ;
			String do_sql ="select top 6 file_name,name,factoryname,catalogname from pro_products where factoryid="+factoryid+" and catalognum ="+catalog;
			StringBuffer html = new StringBuffer("") ;
			if(!"".equals(catalog)&& !"0".equals(catalog) && !"".equals(factoryid)){
				proList = dbHelper.getMapList(do_sql,connection) ;
			}
			if(null!=proList && proList.size()>0){
			  for(Map oneMap:proList){
				html.append("<li class='top3'><h4>") ;
			    html.append("<a title='查看"+CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"' target='_blank' href='/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name"))+"'>") ;
			    html.append(CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))) ;
			    html.append("</a></h4></li>") ;
			   }
		    }
			out.println(html.toString()) ;
			return ;	
		}
		
	    //获取该产品大类别排行列表
	    if("topCatalogProductList".equals(flag)){  
			int catalog = CommonString.getFormatInt(request.getParameter("catalog")) ;   // 类型
			int factoryid = CommonString.getFormatInt(request.getParameter("factoryid")) ; // 品牌	
			List<Map> proList = null ;
			String do_sql ="select top 6 file_name,name,factoryname,catalogname,img2 from pro_products where  catalognum ="+catalog+"order by view_count desc";
			StringBuffer html = new StringBuffer("") ;
			if(!"".equals(catalog)&& !"0".equals(catalog) && !"".equals(factoryid)){
				proList = dbHelper.getMapList(do_sql,connection) ;
			}	
			if(null!=proList && proList.size()>0){
			  for(Map oneMap:proList){
				html.append("<li><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name"))+"' title='"+CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"'>") ;
			    html.append("<img src='http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(oneMap.get("img2"))+"'  width='80' height='70' alt='"+CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"'  onerror="+"showImgDelay(this,'/uploadfiles/no_small.gif',2);"+" width='80' height='70' /></a>" ) ;
			    html.append("<h3><a target='_blank' href='/proDetail/"+CommonString.getFormatPara(oneMap.get("file_name"))+"' title='"+CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"'>"+CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"))+CommonString.getFormatPara(oneMap.get("catalogname"))+"</a>") ;
			    html.append("<span style='color:#999999'> </span></h3></li>") ;
			   }
		    }
			out.println(html.toString()) ;
			return ;	
		}
	    //获取该产品在该类别中排序号
	    if("rank".equals(flag)){  
			int catalog = CommonString.getFormatInt(request.getParameter("catalog")) ;   // 类型
			int proid = CommonString.getFormatInt(request.getParameter("id")) ; // 品牌	
			Integer rank = (Integer)dbHelper.getOne(" SELECT COUNT(*)+1 FROM pro_products WHERE catalognum='"+catalog+"' AND view_count >(SELECT view_count FROM pro_products WHERE id="+proid+")",new Object [] {},connection);
            rs=""+rank;
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
			 String desc=CommonString.getFormatPara(request.getParameter("jr_desc"));
             String title=CommonString.getFormatPara(request.getParameter("jr_title"));
			 String brand=CommonString.getFormatPara(request.getParameter("jr_brand"));
			 String cata=CommonString.getFormatPara(request.getParameter("jr_cata"));
			 String pro=CommonString.getFormatPara(request.getParameter("jr_pro"));
             if(title.equals("")){title=brand+pro+cata;}
			String sql = " insert into repair_info (title,content,add_date,add_user,is_pub,uuid) ";
			sql += " values (?,?,?,?,?,?) ";
			 dbHelper.execute(sql,new Object []{title,desc,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),"onlineuser","1",CommonString.getUUID()},connection);
			 return;
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
			String content = CommonString.getFormatPara(request.getParameter("content"));
			String username = CommonString.getFormatPara(request.getParameter("username"));
			String reply_id = CommonString.getFormatPara(request.getParameter("reply_id"));
			String type_no = CommonString.getFormatPara(request.getParameter("type_no"));
			String pro_id = CommonString.getFormatPara(request.getParameter("proid"));
			if(type_no.equals("")){type_no="0";} 	if(reply_id.equals("")){reply_id="0";}  if(username.equals("")){username="front";}  if(pro_id.equals("")){pro_id="0";}
			//保存图片
			String images = CommonString.getFormatPara(request.getParameter("images"));
			String []imagesUrl=images.split(",");
			for(int i=0;i<imagesUrl.length;i++)
			{
				String uuidImage=CommonString.getUUID();
				String sqlImage = " insert into pro_weixiu_image (uuid,add_date,add_user,add_ip,image,weixiu_id) ";
				sqlImage += " values (?,?,?,?,?,?) ";
				dbHelper.execute(sqlImage,new Object []{uuidImage,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),username,Common.getIp(request),imagesUrl[i],reply_id},connection);	
			}
            String uuid=CommonString.getUUID();
			if (!content.equals("")) {
				String sql = " insert into pro_weixiu_comment (uuid,add_date,add_user,add_ip,username,content,reply_id,type_no,pro_id) ";
				sql += " values (?,?,?,?,?,?,?,?,?) ";
				int r = dbHelper.execute(sql,new Object []{uuid,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),"front",Common.getIp(request),username,content,reply_id,type_no,pro_id},connection);					
				if(r>0){rs = "ok";}else{rs="no";}
			}else{
				rs = "no";
			}
		}
		//给机器优点加1
			if(flag.equals("pubProAd")){
			String pro_id = CommonString.getFormatPara(request.getParameter("pro_id"));
			String param = CommonString.getFormatPara(request.getParameter("param"));
			int exist=0;
			int r=0;
			Map proInfo = dbHelper.getMap("select id from pro_weixiu_advantage where pro_id=?", new Object[] { pro_id }, connection);
			if(proInfo!=null){exist=1; }  
            String  sql=""	;		
            String uuid=CommonString.getUUID(); 
			if (exist!=1) {
				sql = " insert into pro_weixiu_advantage (uuid,add_date,"+param+",pro_id) ";
				sql += " values (?,?,?,?) ";
				r = dbHelper.execute(sql,new Object []{uuid,CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),1,pro_id},connection);					
				if(r>0){rs = "ok";}else{rs="no";}
			}else{
			    sql= "update pro_weixiu_advantage set "+param+" = ISNULL("+param+", 0)+1 where pro_id="+pro_id;
				System.out.println(sql);
				r=dbHelper.execute(sql,connection);
				if(r>0){rs = "ok";}else{rs="no";}
			}
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
			System.out.println(content);
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
		
		
		//验证代理商是否重复用户名
		if("repeatName".equals(flag)){
		String username = CommonString.getFormatPara(request.getParameter("username")) ;
		String id = CommonString.getFormatPara(request.getParameter("id")) ;
		if(id.equals("")){id="0";}
			Map memberInfo = dbHelper.getMap("select * from pro_agent_factory  where id!="+id+" and usern = ? ", new Object[] { username }, connection);
			if (null == memberInfo) {
                rs="ok";
			}else{
				rs="no";
			}
		}
		//验证代理商用户名是否负责正则规范
		if("guifan".equals(flag)){
		String username = CommonString.getFormatPara(request.getParameter("username")) ;
		String regex = "^[A-Za-z0-9]+$"; 
        boolean flg = Pattern.matches(regex, username); 
			if (flg == true) {
                rs="ok";
			}else{
				rs="no";
			}
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>