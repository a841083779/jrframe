<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

    DBHelper dbHelper = DBHelper.getInstance() ;
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"create_spec/") ; 
	String cuuid = CommonString.getFormatPara(request.getParameter("cuuid"));
	String resule="false";
	try{
		List <Map>list = null;
		Map root = new HashMap();
		//页面生成
		if(cuuid.equals("478E2BFF-A1AB-44DC-820B-47753BE76551")){//挖掘机专题热门机型
			//卡特
			String sql = "select top 8 title,title_url,url1,url2,url3,is_display from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 and type = 1 and order_no <=4 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("catlist1",list);
			}	
			sql = "select top 8 title,title_url,url1,url2,url3,is_display from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 and type = 1 and order_no >4 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("catlist2",list);
			}
			//三一
			sql = "select top 8 title,title_url,url1,url2,url3,is_display from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 and type = 2 and order_no <=4 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("sanylist1",list);
			}
			//三一
			sql = "select top 8 title,title_url,url1,url2,url3,is_display from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 and type = 2 and order_no >4 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("sanylist2",list);
			}
			//山东临工
			sql = "select top 8 title,title_url,url1,url2,url3,is_display from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 and type = 3 and order_no <=4 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("linlist1",list);
			}
			//山东临工
			sql = "select top 8 title,title_url,url1,url2,url3,is_display from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 and type = 3 and order_no >4 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("linlist2",list);
			}
			//徐工
			sql = "select top 8 title,title_url,url1,url2,url3,is_display from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 and type = 4 and order_no <=4 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("xulist1",list);
			}
			//徐工
			sql = "select top 8 title,title_url,url1,url2,url3,is_display from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 and type = 4 and order_no >4 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("xulist2",list);
			}
			//小松
			sql = "select top 8 title,title_url,url1,url2,url3,is_display from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 and type = 5 and order_no <=4 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("xslist1",list);
			}
			//小松
			sql = "select top 8 title,title_url,url1,url2,url3,is_display from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 and type = 5 and order_no >4 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("xslist2",list);
			}
			freemarkerUtils.generate("template/spec_wj_hot.htm",root,realPath+"create_spec/include/spec-wj-hot.htm");
			resule="true";
		}
		if(cuuid.equals("41B26BB5-5691-4214-B36B-E72BC143E917")){//推荐品牌页面生成
			String sql = "select top 8 title,title_url,img from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_brand.htm",root,realPath+"create_spec/include/spec-wj-brand.htm");
				resule="true";
			}
		}
		
		if(cuuid.equals("536007D7-2B8A-4026-8F89-799A20B17FD5")){//推荐旗舰店页面生成
			String sql = "select top 6 title,title_url,img from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_fs.htm",root,realPath+"create_spec/include/spec-wj-fs.htm");
				resule="true";
			}
		}
		if(cuuid.equals("ADB51D09-26A2-4C7D-8359-5A40C61E0585")){//产品推荐1
			String sql = "select top 6 title,title_url,url1,url2,url3,url4,url5,img,is_display,sub_title from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_screen1.htm",root,realPath+"create_spec/include/spec-wj-screen1.htm");
				resule="true";
			}
		}
		if(cuuid.equals("A95A3707-CE20-44FE-B022-5856C7289BC3")){//产品推荐2
			String sql = "select top 6 title,title_url,url1,url2,url3,url4,url5,img,is_display,sub_title from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_screen2.htm",root,realPath+"create_spec/include/spec-wj-screen2.htm");
				resule="true";
			}
		}
		if(cuuid.equals("CABE1296-F96A-4D43-ABF3-94A8BD1966C3")){//产品推荐3
			String sql = "select top 6 title,title_url,url1,url2,url3,url4,url5,img,is_display,sub_title from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_screen3.htm",root,realPath+"create_spec/include/spec-wj-screen3.htm");
				resule="true";
			}
		}
		
		if(cuuid.equals("AA004A18-7A08-4148-AE96-804AC598F5E6")){//二手
			String sql = "select top 6 title,title_url,url1,img,is_display,sub_title,price,summary from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_used.htm",root,realPath+"create_spec/include/spec-wj-used.htm");
				resule="true";
			}
		}
		if(cuuid.equals("E6E0DE0D-8662-457E-B1FB-1930D087A9A2")){//推荐代理商
			String sql = "select top 6 title,title_url,img,sub_title from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_agent.htm",root,realPath+"create_spec/include/spec-wj-agent.htm");
				resule="true";
			}
		}
		
		if(cuuid.equals("FB748A88-782A-4C50-A8BC-AA89B1B2F769")){//资讯轮播
			String sql = "select top 3 title,title_url,img from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_wheel.htm",root,realPath+"create_spec/include/spec-wj-wheel.htm");
				resule="true";
			}
		}
		
		if(cuuid.equals("E9DB29A0-915D-49AD-A505-27DE9CE3CADA")){//资讯新闻
			String sql = "select top 6 title,title_url,type from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_news.htm",root,realPath+"create_spec/include/spec-wj-news.htm");
				resule="true";
			}
		}
		
		if(cuuid.equals("7A8737AD-6950-458B-AE47-48FF11144111")){//图库
			String sql = "select top 8 title,title_url,img,is_display,summary from pro_spec_data  where channel_uuid = '"+cuuid+"' and is_pub = 1 order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_pic.htm",root,realPath+"create_spec/include/spec-wj-pic.htm");
				resule="true";
			}
		}
		
		if(cuuid.equals("F449F979-E4A9-4A36-98E4-3D16A9E73804")){//底部快速链接
			String sql = "select title,title_url from pro_spec_data where channel_uuid = '"+cuuid+"' order by order_no asc";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_foot.htm",root,realPath+"create_spec/include/spec-wj-foot.htm");
				resule="true";
			}
		}
		
		if(cuuid.equals("3765274B-ECC7-4317-BEC6-A2DF8CD1EE9D")){//广告
			//第一个广告
			String sql = "select title,title_url,img from pro_spec_data where channel_uuid = '"+cuuid+"' and is_pub = 1 and order_no = 1 ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_adv.htm",root,realPath+"create_spec/include/spec-wj-adv1.htm");
				resule="true";
			}
			resule="false";
			//第二个广告
			sql = "select title,title_url,img from pro_spec_data where channel_uuid = '"+cuuid+"' and is_pub = 1 and order_no = 2 ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_adv.htm",root,realPath+"create_spec/include/spec-wj-adv2.htm");
				resule="true";
			}
			resule="false";
			//第三个广告
			sql = "select title,title_url,img from pro_spec_data where channel_uuid = '"+cuuid+"' and is_pub = 1 and order_no = 3 ";
			list = dbHelper.getMapList(sql);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("template/spec_wj_adv.htm",root,realPath+"create_spec/include/spec-wj-adv3.htm");
				resule="true";
			}
		}
		
	}catch(Exception e){
		e.printStackTrace();	
	}finally{
		
	}
	out.println(resule) ;	
	%>