<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.alipay.util.*,com.jerehnet.wxpay.*"%>
<%@ page import="java.util.*,java.io.*,java.net.*"%>
<%@page import="com.jerehnet.wxpay.WXPayConstants.SignType" %>
<%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();

	String rs = "fail";
	String callback = CommonString.getFilterStr(request.getParameter("callback"));
	
	try{
		connection = dbHelper.getConnection(); 	
		//------------------------------------留言 开始-------------------------------------------
		//保存留言
		if("saveMessage".equals(flag)){
			String createTime = CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
			String nickName = CommonString.getFormatPara(request.getParameter("nickName")) ;
			String headImg = CommonString.getFormatPara(request.getParameter("headImg")) ;
			String openId = CommonString.getFormatPara(request.getParameter("openId")) ;
			String content = CommonString.getFormatPara(request.getParameter("content")) ;

			int result=dbHelper.execute(" insert into anniversary18_message(open_id,nick_name,head_img,content,add_date) values (?,?,?,?,?) ",new Object[]{openId,nickName,headImg,content,createTime},connection);
			if(result>0){
				rs="success";	
			}else{
				rs="fail";
			}
			out.print(rs);
		}
		//最新留言列表
		if("newMessageList".equals(flag)){
			String uid = CommonString.getFormatPara(request.getParameter("uid"));
			String html = "";
			List<Map> list = dbHelper.getMapList(" select id,nick_name,head_img,content,add_date,st_diggs,(select count(id) as a from anniversary18_message_digg where open_id = ? and message_id=anniversary18_message.id) as isDigged from anniversary18_message where is_show = 0  order by add_date desc,id desc  ",new Object[]{uid},connection );
			System.out.println("size:"+list.size());
			if(list !=null && list.size()>0){
				for(Map m:list){
					String digState="";
					if(CommonString.getFormatInt(CommonString.getFormatPara(m.get("isDigged")))==0){
						digState = "on";
					}
					html +="<div class='com_item fix'>";
					html +="<div class='com_img l'><img src='"+CommonString.getFormatPara(m.get("head_img"))+"' onerror='javascript:this.src=\'images/header.jpg\';'/></div>";
					html +="<div class='com_main l'>";
					html +="<div class='com_name'>"+CommonString.getFormatPara(m.get("nick_name"))+"</div>";
					html +="<div class='com_m'>"+CommonString.getFormatPara(m.get("content"))+"</div>";
					html +="<div class='com_time'>"+CommonDate.getFormatDate("yyyy-MM-dd",m.get("add_date"))+"</div></div>";
					html +="<div class='com_good l "+digState+"' data-id='"+CommonString.getFormatPara(m.get("id"))+"'><img src='images/heart_y.png'/><img src='images/heart_n.png'/><p>"+CommonString.getFormatPara(m.get("st_diggs"))+"</p></div></div>";
				}
			}
			out.print(html);
		}
		//热门留言列表
		if("hotMessageList".equals(flag)){
			String uid = CommonString.getFormatPara(request.getParameter("uid"));
			String html = "";
			List<Map> list = dbHelper.getMapList(" select id,nick_name,head_img,content,add_date,st_diggs,(select count(id) as a from anniversary18_message_digg where open_id = ? and message_id=anniversary18_message.id) as isDigged from anniversary18_message where is_show = 0  order by st_diggs desc,id desc ",new Object[]{uid},connection );
			if(list !=null && list.size()>0){
				for(Map m:list){
					String digState="";
					if(CommonString.getFormatInt(CommonString.getFormatPara(m.get("isDigged")))==0){
						digState = "on";
					}
					html +="<div class='com_item fix'>";
					html +="<div class='com_img l'><img src='"+CommonString.getFormatPara(m.get("head_img"))+"' onerror='javascript:this.src=\'images/header.jpg\';'/></div>";
					html +="<div class='com_main l'>";
					html +="<div class='com_name'>"+CommonString.getFormatPara(m.get("nick_name"))+"</div>";
					html +="<div class='com_m'>"+CommonString.getFormatPara(m.get("content"))+"</div>";
					html +="<div class='com_time'>"+CommonDate.getFormatDate("yyyy-MM-dd",m.get("add_date"))+"</div></div>";
					html +="<div class='com_good l "+digState+"' data-id='"+CommonString.getFormatPara(m.get("id"))+"'><img src='images/heart_y.png'/><img src='images/heart_n.png'/><p>"+CommonString.getFormatPara(m.get("st_diggs"))+"</p></div></div>";
				}
			}
			out.print(html);
		}
		//留言点赞
		if("digMessage".equals(flag)){
			int result=0,uresult=0;
			String uid = CommonString.getFormatPara(request.getParameter("uid"));
			String messageId = CommonString.getFormatPara(request.getParameter("messageId"));
			//是否赞过判断
			int hasDigged = (Integer)dbHelper.getOne(" select count(id) as a from anniversary18_message_digg where open_id= ? and message_id = ? ",new Object[]{uid,messageId},connection);
			if(hasDigged ==0){
				//做留言点赞日志
				result = dbHelper.execute(" insert into anniversary18_message_digg (open_id,message_id,add_date) values (?,?,?) ",new Object[]{uid,messageId,CommonDate.getToday("yyyy-MM-dd HH:mm:ss")},connection);
				if(result>0){
					uresult = dbHelper.execute(" update anniversary18_message set st_diggs = st_diggs+1 where id= ? ",new Object[]{messageId},connection);
				}
			}
			if(result>0){
				rs = "success";
			}else{
				if(hasDigged>0){
					rs = "repeat";
				}else{
					rs = "fail";
				}
			}
			out.print(rs);
		}
		//------------------------------------留言 结束-------------------------------------------
		
		//------------------------------------势力榜 开始-------------------------------------------
		//提交用户品牌绑定
		if("saveUserBrand".equals(flag)){
			String uid = CommonString.getFormatPara(request.getParameter("uid"));
			String tel = CommonString.getFormatPara(request.getParameter("tel"));
			String brandId = CommonString.getFormatPara(request.getParameter("brandId"));
			String otherBrand = CommonString.getFormatPara(request.getParameter("otherBrand"));

			int i = dbHelper.execute(" insert into anniversary18_user_brand (open_id,tel,brand_id,other_brand,add_date) values (?,?,?,?,?) ",new Object[]{uid,tel,brandId,otherBrand,CommonDate.getToday("yyyy-MM-dd HH:mm:ss")},connection);
			if(i>0){
				rs="success";
			}else{
				rs="fail";
			}
			out.print(rs);
		}
		//验证用户是否绑定品牌
		if("hasBindBrand".equals(flag)){
			String uid = CommonString.getFormatPara(request.getParameter("uid"));
			int result = (Integer)dbHelper.getOne(" select count(id) as a from anniversary18_user_brand where open_id = ? ",new Object[]{uid},connection);
			out.print(result);
		}
		//品牌势力榜排名
		if("rankList".equals(flag)){
			String html = "";int num = 0;
			List<Map> list = dbHelper.getMapList(" select id,name,logo,st_diggs from anniversary18_brand order by st_diggs desc,id desc ",connection);
			if(list!=null && list.size()>0){
				for(Map m:list){
					num++;
					html +="<div class='ri_item fix'>";
					html +="<p class='rl_no l'>"+num+"</p>";
					html +="<p class='rl_br l fix'><img src='"+CommonString.getFormatPara(m.get("logo"))+"'  class='l'/><span class='rlb_name l'>"+CommonString.getFormatPara(m.get("name"))+"</span></p>";
					html +="<p class='rl_co l'>"+CommonString.getFormatPara(m.get("st_diggs"))+"</p>";
					html +="<p class='rl_btn l'><a class='point_it' data-id='"+CommonString.getFormatPara(m.get("id"))+"'><img src='images/ranking_btn.png'/></a></p>";
					html +="</div>";
				}
			}
			out.print(html);
		}
		//助力
		if("doHelp".equals(flag)){
			String uid = CommonString.getFormatPara(request.getParameter("uid"));
			String brandId = CommonString.getFormatPara(request.getParameter("brandId"));
			int hi = (Integer)dbHelper.getOne(" select count(id) as a from anniversary18_dig_log where open_id=? and DateDiff(dd,add_date,getdate())=0   ",new Object[]{uid},connection);
			int sum = (Integer)dbHelper.getOne(" select ISNULL(sum(count), 0) as sum from anniversary18_dig_log where open_id=? and DateDiff(dd,add_date,getdate())=0   ",new Object[]{uid},connection);
			int result=0;
			if(sum<10){
				if(hi==0){
					result=dbHelper.execute(" insert into anniversary18_dig_log (open_id,add_date) values (?,?) ",new Object[]{uid,CommonDate.getToday("yyyy-MM-dd HH:mm:ss")},connection);
				}else{
					result=dbHelper.execute(" update anniversary18_dig_log set count = count+1 where open_id=? and DateDiff(dd,add_date,getdate())=0  ",new Object[]{uid},connection);
				}
				if(result>0){
					dbHelper.execute(" update anniversary18_brand set st_diggs =st_diggs+1 where id = ? ",new Object[]{ brandId },connection);
					rs="success";
				}else{
					rs="fail";
				}
			}else{
				rs="over";
			}
			out.print(rs);
			 
		}
		
		//------------------------------------势力榜 结束-------------------------------------------
		
		
		//------------------------------------广告/会员微信支付 结束-------------------------------------------
		//微信支付提交
		if("saveOrder".equals(flag)){
			String uid = CommonString.getFormatPara(request.getParameter("uid"));
			String adId = CommonString.getFormatPara(request.getParameter("adId"));
			String name = CommonString.getFormatPara(request.getParameter("name"));
			String tel = CommonString.getFormatPara(request.getParameter("tel"));
			String adTitle = CommonString.getFormatPara(request.getParameter("adTitle"));
			String money = CommonString.getFormatPara(request.getParameter("money"));
			String createTime = CommonDate.getToday("yyyy-MM-dd HH:mm:ss") ;
			String out_trade_no = System.currentTimeMillis()+RandomUtils.generateString(15);
			
			int state = (Integer)dbHelper.getOne(" select ad_state from anniversary18_ad where id = ?  ",new Object[]{adId},connection);
			if(state==1){
				rs="isSell";
			}else{
				int result = dbHelper.execute(" insert into anniversary18_wxpay_log (name,tel,ad_id,ad_title,money,open_id,add_date,order_no) values (?,?,?,?,?,?,?,?) ",new Object[]{name,tel,adId,adTitle,money,uid,createTime,out_trade_no},connection);
				if(result==1){
					rs=out_trade_no;
				}else{
					rs="fail";
				}
			}
			
			out.print(rs);
		}
		if("isSell".equals(flag)){
			String adId = CommonString.getFormatPara(request.getParameter("adId"));
			int state = (Integer)dbHelper.getOne(" select ad_state from anniversary18_ad where id = ?  ",new Object[]{adId},connection);
			out.print(state);
		}
		//------------------------------------广告/会员微信支付 结束-------------------------------------------
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}

%>