<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Random"%>
<%	
    DBHelper dbHelper = DBHelper.getInstance() ;
	Connection connection = null;
	String rs="";
	String callbackparam=CommonString.getFormatPara(request.getParameter("callbackparam"));
	String flag= CommonString.getFormatPara(request.getParameter("flag"));
    response.setContentType("text/html;charset=utf-8");
    request.setCharacterEncoding("utf-8");

	try{
		connection=dbHelper.getConnection();

		if(flag.equals("games")){
			int prize=0;
			String tel = CommonString.getFormatPara(session.getAttribute("mobile_phone_mark"));	
			
			Map orderMap = dbHelper.getMap(" select top 1 id  from  pro_product_form  where mobile_phone='"+tel+"' and  DateDiff(dd,add_date,getdate())=0 and add_user='171111' ",connection);
			if(orderMap!=null){//今天是否下过订单
				Map logMap = dbHelper.getMap(" select top 1 id  from  activity_17double_eleven_game_log  where tel='"+tel+"' and  DateDiff(dd,add_date,getdate())=0  ",connection);
				
				if(logMap==null){//今天没有进行抽奖活动	
					Map winPrizeMap = dbHelper.getMap(" select top 1  id  from  activity_17double_eleven_game_log  where gift_id!=0 and  tel='"+tel+"'   ",connection);//是否获奖
					Random random=new Random();
					int game=random.nextInt(800);
					if(game<5){  //模型
						prize=1;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=1   ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<7){
								
							}else{
								prize=0;
							}
						}
					}else if(game<50){ //帽子
						prize=2;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=2  ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<100){
								
							}else{
								prize=0;
							}
						}
					}else if(game<60){ //水杯
						prize=5;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=5   ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<10){
								
							}else{
								prize=0;
							}
						}
					}else if(game<80){ //指甲套装
						prize=6;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=6   ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<40){
								
							}else{
								prize=0;
							}
						}
					}else if(game<90){  //毛巾
						prize=3;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=3  ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<10){
								
							}else{
								prize=0;
							}
						}
					}else if(game<100){  //背包
						prize=4;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=4   ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<20){
								
							}else{
								prize=0;
							}
						}
					}else if(game<110){  //手电
						prize=7;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=7   ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<10){
								
							}else{
								prize=0;
							}
						}
					}else{ //什么也没中
						prize=0;
						
					}
					if(winPrizeMap!=null){prize=0;}
					
					String prize_name="";
					if(prize==1){
						prize_name="模型";
					}else if(prize==2){
						prize_name="帽子";
					}else if(prize==3){
						prize_name="毛巾";
					}else if(prize==4){
						prize_name="背包";
					}else if(prize==5){
						prize_name="水杯";
					}else if(prize==6){
						prize_name="指甲套装";
					}else if(prize==7){
						prize_name="手电";
					}else{
						prize_name="谢谢参与";
					}
					
					
					int i=dbHelper.executeUpdate("insert into  activity_17double_eleven_game_log(tel,gift_id,gift,add_date) values ('"+tel+"',"+prize+",'"+prize_name+"','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"')",connection);
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
