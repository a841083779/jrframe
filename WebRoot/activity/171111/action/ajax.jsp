<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*" pageEncoding="UTF-8"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Random"%>
<%	
    DBHelper dbHelper = DBHelper.getInstance() ;
	Connection connection = null;
	String flag= CommonString.getFormatPara(request.getParameter("flag"));
    response.setContentType("text/html;charset=utf-8");
    request.setCharacterEncoding("utf-8");

	try{
		connection=dbHelper.getConnection();

		if(flag.equals("game")){
			int prize=0;
			String tel = CommonString.getFormatPara(session.getAttribute("order_phone"));	
			String name=CommonString.getFormatPara(session.getAttribute("order_name"));
			Map orderMap = dbHelper.getMap(" select top 1 id  from  pro_product_form  where mobile_phone='"+tel+"' and  DateDiff(dd,add_date,getdate())=0 and add_user='171111' ",connection);
			if(orderMap!=null){//今天是否下过订单
				Map logMap = dbHelper.getMap(" select top 1 id  from  activity_17double_eleven_game_log  where tel='"+tel+"' and  DateDiff(dd,add_date,getdate())=0  ",connection);
				
				if(logMap==null){//今天没有进行抽奖活动	
					Map winPrizeMap = dbHelper.getMap(" select top 1  id  from  activity_17double_eleven_game_log  where gift_id!=0 and  tel='"+tel+"'   ",connection);//是否获奖
					Random random=new Random();
					int game=random.nextInt(1000);
					//System.out.println("game:"+game);
					if(game<3){  //模型3
						prize=1;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=1   ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<0){
								
							}else{
								prize=0;
							}
						}
					}else if(game<30){ //包8
						prize=2;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=2  ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<0){
								
							}else{
								prize=0;
							}
						}
					}else if(game<40){ //三一杯垫11
						prize=4;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=4   ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<0){
								
							}else{
								prize=0;
							}
						}
					}else if(game<50){ //毛巾8
						prize=3;
						Map checkMap= dbHelper.getMap(" select  count(id) as  prizeCount  from  activity_17double_eleven_game_log  where  gift_id=3   ",connection);
						if(checkMap!=null){
							if(CommonString.getFormatInt(checkMap.get("prizeCount"))<0){
								
							}else{
								prize=0;
							}
						}
					}else if(game<60){  //礼品杯30
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
					
					//System.out.println("=================================================insert into  activity_17double_eleven_game_log(tel,gift_id,gift,add_date) values ('"+tel+"',"+prize+",'"+prize_name+"','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"')");
					int i=dbHelper.executeUpdate("insert into  activity_17double_eleven_game_log(name,tel,gift_id,gift,add_date) values ('"+name+"','"+tel+"',"+prize+",'"+prize_name+"','"+CommonDate.getToday("yyyy-MM-dd HH:mm:ss")+"')",connection);
					out.print(prize);
					
				
				}else{
					
					out.print("nochance");
					
				}
			}else{
				out.print("noorder");
			}

			
		}
		

		if(flag.equals("rankList")){
			String html="";
			List<Map>  ranklist = dbHelper.getMapList(" select tel,gift  from  activity_17double_eleven_game_log  where gift_id>0    order by id desc",connection);
			if(ranklist != null && ranklist.size() > 0){
			  for(Map news:ranklist){
				  String tel=CommonString.getFormatPara(news.get("tel"));
				  String gift=CommonString.getFormatPara(news.get("gift"));
				  html+="<li>手机号"+tel.substring(0,3)+"****"+tel.substring(tel.length()-4,tel.length())+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 获得"+gift+"一个</li>";
			  }
			}else{
				html="暂无获奖名单！";
			}
				out.print(html);
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	
	
%>
