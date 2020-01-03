<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLDecoder"%><%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String sql="";String rs="";
	String flag= CommonString.getFormatPara(request.getParameter("flag"));
	String callbackparam=CommonString.getFormatPara(request.getParameter("callbackparam"));
	
	
	try{
		connection=dbHelper.getConnection();
		if(flag.equals("submit")){
			String factoryid=CommonString.getFormatPara(request.getParameter("factoryid"));
			String factoryname=CommonString.getFormatPara(request.getParameter("factoryname"));
			//factoryname=URLDecoder.decode(factoryname,"UTF-8");
			//factoryname=new String(factoryname.getBytes("ISO-8859-1"),"UTF-8");
			String product_id=CommonString.getFormatPara(request.getParameter("product_id"));
			String product_name=CommonString.getFormatPara(request.getParameter("product_name"));
			//product_name=URLDecoder.decode(product_name,"UTF-8");
			String catanum=CommonString.getFormatPara(request.getParameter("catanum"));
			String cataname=CommonString.getFormatPara(request.getParameter("cataname"));
			//cataname=URLDecoder.decode(cataname,"UTF-8");
			String province=CommonString.getFormatPara(request.getParameter("province"));
			//province=URLDecoder.decode(province,"UTF-8");
			String city=CommonString.getFormatPara(request.getParameter("city"));
			//city=URLDecoder.decode(city,"UTF-8");
			String contact_address=CommonString.getFormatPara(request.getParameter("contact_address"));
			//contact_address=URLDecoder.decode(contact_address,"UTF-8");

			String name=CommonString.getFormatPara(request.getParameter("name"));
			//name=URLDecoder.decode(name,"UTF-8");
			String mobile_phone=CommonString.getFormatPara(request.getParameter("mobile_phone"));
			Boolean regTel=mobile_phone.matches("^(13|15|18)\\d{9}$");  
			if(!regTel){
				rs=callbackparam+" ([ { rs:\"telError\"},{tel:\"\"} ] ) ";
				return;
			}
				
			sql=" insert into pro_product_form (uuid,add_user,add_date,add_ip,agentid,factoryid,factoryname,product_id,product_name,catanum,cataname,ifgroup,is_first,message,province,city,contact_address,name,mobile_phone) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
			Integer keyId = dbHelper.executeUpdate(sql,new Object[]{CommonString.getUUID(),"171111",CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),Common.getIp(request),0,factoryid,factoryname,product_id,product_name,catanum,cataname,"个人",1,"您好，我对"+factoryname+product_name+cataname+"感兴趣，想要咨询，请您给我回复，谢谢。",province,city,contact_address,name,mobile_phone},connection) ; 
			
			if(keyId>0){
				rs=callbackparam+" ([ { rs:\"success\"},{tel:\""+mobile_phone+"\"} ] ) ";
				session.setAttribute("mobile_phone_mark", mobile_phone); 
			}else{
				rs=callbackparam+" ([ { rs:\"fail\"},{tel:\"\"} ] ) ";
			}

		}
		
		if(flag.equals("games")){
			int prize=0;
			String tel=CommonString.getFormatPara(request.getParameter("tel"));
			String name=CommonString.getFormatPara(request.getParameter("name"));
			Map orderMap = dbHelper.getMap(" select top 1 id  from  pro_product_form  where mobile_phone='"+tel+"' and  DateDiff(dd,add_date,getdate())=0 and add_user='171111' ",connection);
			if(orderMap!=null){//今天是否下过订单
				Map logMap = dbHelper.getMap(" select top 1 id  from  activity_17double_eleven_game_log  where tel='"+tel+"' and  DateDiff(dd,add_date,getdate())=0  ",connection);
				
				if(logMap==null){//今天没有进行抽奖活动	
					Map winPrizeMap = dbHelper.getMap(" select top 1  id  from  activity_17double_eleven_game_log  where gift_id!=0 and  tel='"+tel+"'   ",connection);//是否获奖
					Random random=new Random();
					int game=random.nextInt(1000);
					if(game<3){  //模型
						prize=1;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=1   ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<0){
								
							}else{
								prize=0;
							}
						}
					}else if(game<30){ //包
						prize=2;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=2  ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<0){
								
							}else{
								prize=0;
							}
						}
					}else if(game<40){ //三一杯垫
						prize=4;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=4   ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<0){
								
							}else{
								prize=0;
							}
						}
					}else if(game<50){ //毛巾
						prize=3;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=3   ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<0){
								
							}else{
								prize=0;
							}
						}
					}else if(game<60){  //礼品杯
						prize=5;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=5  ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<20){
								
							}else{
								prize=0;
							}
						}
					}else{ //什么也没中
						prize=0;
						
					}
					
					if(tel.equals("13930107858")){//该手机号抽奖中模型
						prize=1;
					}
					
					if(winPrizeMap!=null){prize=0;}
					
					String prize_name="";
					if(prize==1){
						prize_name="模型";
					}else if(prize==2){
						prize_name="手提包";
					}else if(prize==3){
						prize_name="毛巾";
					}else if(prize==4){
						prize_name="三一杯垫";
					}else if(prize==5){
						prize_name="礼品杯";
					}else{
						prize_name="谢谢参与";
					}
					
					
					
					int i=dbHelper.executeUpdate("insert into  activity_17double_eleven_game_log(name,tel,gift_id,gift,add_date) values ('"+name+"','"+tel+"',"+prize+",'"+prize_name+"','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"')",connection);
					rs=callbackparam+" ([ { back:"+prize+"} ] ) ";
				
				}else{
					rs=callbackparam+" ([ { back:\"nochance\"} ] ) ";	
				}
			}else{
				rs=callbackparam+" ([ { back:\"noorder\"} ] ) ";
			}

			
		}

		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
		
		out.print(rs);
	}
%>