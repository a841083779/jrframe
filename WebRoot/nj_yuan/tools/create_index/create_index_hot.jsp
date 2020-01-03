<%@ page language="java" import="java.util.*,java.sql.*,org.json.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.util.freemarker.FreemarkerUtils,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	 DBHelper dbHelper = DBHelper.getInstance() ;
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String result="";
	try{
		List <Map>list = null;
		Map root = new HashMap();
		if(flag.equals("hot")){
			//推土机
			String sql1 = " select top 14 factoryname,name,file_name,id from pro_products where is_show = 1 and catalognum like '101003%' order by view_count desc ";
			list = dbHelper.getMapList(sql1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot.htm",root,realPath+"index_new/index_new/index_hot_tuituji.htm");
			
			}
			String sql1_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '101003%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql1_1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_tuitu.htm");
			}
			//叉车
			String sql2 = " select top 14 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '107%' order by view_count desc ";
			list = dbHelper.getMapList(sql2);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot.htm",root,realPath+"index_new/index_new/index_hot_chache.htm");
			}
			String sql2_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '107%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql2_1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_chache.htm");
			}
			
			//压路机
			String sql3 = " select top 14 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '106001%' order by view_count desc ";
			list = dbHelper.getMapList(sql3);
			
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot.htm",root,realPath+"index_new/index_new/index_hot_yaluji.htm");
			}
			String sql3_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '106001%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql3_1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_yalu.htm");
			}
			
			//筑路机械
			String sql4 = " select top 14 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '104%' order by view_count desc ";
			list = dbHelper.getMapList(sql4);
			
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot.htm",root,realPath+"index_new/index_new/index_hot_zhulujixie.htm");
			}
			String sql4_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '104%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql4_1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_zhulu.htm");
			}
			
			//平地机
			String sql5 = " select top 14 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '101005%' order by view_count desc ";
			list = dbHelper.getMapList(sql5);
			
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot.htm",root,realPath+"index_new/index_new/index_hot_pingdiji.htm");
			}
			String sql5_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '101005%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql5_1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_pingdi.htm");
			}
			
			//旋挖钻
			String sql6 = " select top 14 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '105003%' order by view_count desc ";
			list = dbHelper.getMapList(sql6);
			
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot.htm",root,realPath+"index_new/index_new/index_hot_xuanwazuan.htm");
			}
			String sql6_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '105003%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql6_1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_xuanwazuan.htm");
			}

			
			//地下矿山机械
			String sql7 = " select top 14 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '110%' order by view_count desc ";
			list = dbHelper.getMapList(sql7);
			
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot.htm",root,realPath+"index_new/index_new/index_hot_kuangshanjixie.htm");
			}
			String sql7_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '110%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql7_1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_dixia.htm");
			}

			
			//破碎设备
			String sql8 = " select top 14 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '113%' order by view_count desc ";
			list = dbHelper.getMapList(sql8);
			
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot.htm",root,realPath+"index_new/index_new/index_hot_posuishebei.htm");
			}
			String sql8_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '113%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql8_1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_new/index_hot_brand.htm",root,realPath+"index_new/index_new/index_hot_brand_posui.htm");
			}
			
	         result="true";	
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}

	
%>