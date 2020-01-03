<%@ page language="java" import="java.util.*,java.sql.*,org.json.*,com.jerehnet.cmbol.database.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*,com.jerehnet.util.freemarker.FreemarkerUtils,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	 DBHelper dbHelper = DBHelper.getInstance() ;
	String result="";
	try{
		List <Map>list = null;
		List <Map>brand_list = null;
		Map root = new HashMap();
			//推土机
			String sql1 = " select top 4 id,factoryname,name,file_name ,catalogname,img2 from pro_products where is_show = 1 and catalognum like '101003%' order by view_count desc ";
			list = dbHelper.getMapList(sql1);
			String sql1_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '101003%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql1_1);
			if(list != null && list.size() > 0&&brand_list != null && brand_list.size() > 0){
				root.put("list",list);
				root.put("brand_list",brand_list);
				freemarkerUtils.generate("index_page/index_hot_pro.htm",root,realPath+"index_new/index_page/index_hot_tuituji.htm");
			
			}
			//叉车
			String sql2 = " select top 4 id,factoryname,name,file_name ,catalogname,img2 from pro_products where is_show = 1 and catalognum like '107%' order by view_count desc ";
			list = dbHelper.getMapList(sql2);
			String sql2_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '107%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql2_1);
			if(list != null && list.size() > 0&&brand_list != null && brand_list.size() > 0){
				root.put("list",list);
				root.put("brand_list",brand_list);
				freemarkerUtils.generate("index_page/index_hot_pro.htm",root,realPath+"index_new/index_page/index_hot_chache.htm");
			}
			//压路机
			String sql3 = " select top 4 id,factoryname,name,file_name ,catalogname,img2 from pro_products where is_show = 1 and catalognum like '106001%' order by view_count desc ";
			list = dbHelper.getMapList(sql3);
			String sql3_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '106001%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql3_1);
			if(list != null && list.size() > 0&&brand_list != null && brand_list.size() > 0){
				root.put("list",list);
				root.put("brand_list",brand_list);
				freemarkerUtils.generate("index_page/index_hot_pro.htm",root,realPath+"index_new/index_page/index_hot_yaluji.htm");
			}
			//筑路机械
			String sql4 = " select top 4 id,factoryname,name,file_name ,catalogname,img2 from pro_products where is_show = 1 and catalognum like '104%' order by view_count desc ";
			list = dbHelper.getMapList(sql4);
			String sql4_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '104%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql4_1);
			if(list != null && list.size() > 0&&brand_list != null && brand_list.size() > 0){
				root.put("list",list);
				root.put("brand_list",brand_list);
				freemarkerUtils.generate("index_page/index_hot_pro.htm",root,realPath+"index_new/index_page/index_hot_zhulujixie.htm");
			}
			//平地机
			String sql5 = " select top 4 id,factoryname,name,file_name ,catalogname,img2 from pro_products where is_show = 1 and catalognum like '101005%' order by view_count desc ";
			list = dbHelper.getMapList(sql5);
			String sql5_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '101005%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql5_1);
			if(list != null && list.size() > 0&&brand_list != null && brand_list.size() > 0){
				root.put("list",list);
				root.put("brand_list",brand_list);
				freemarkerUtils.generate("index_page/index_hot_pro.htm",root,realPath+"index_new/index_page/index_hot_pingdiji.htm");
			}
			//旋挖钻
			String sql6 = " select top 4 id,factoryname,name,file_name ,catalogname,img2 from pro_products where is_show = 1 and catalognum like '105003%' order by view_count desc ";
			list = dbHelper.getMapList(sql6);
			String sql6_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '105003%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql6_1);
			if(list != null && list.size() > 0&&brand_list != null && brand_list.size() > 0){
				root.put("list",list);
				root.put("brand_list",brand_list);
				freemarkerUtils.generate("index_page/index_hot_pro.htm",root,realPath+"index_new/index_page/index_hot_xuanwazuan.htm");
			}
			//地下矿山机械
			String sql7 = " select top 4 id,factoryname,name,file_name ,catalogname,img2 from pro_products where is_show = 1 and catalognum like '110%' order by view_count desc ";
			list = dbHelper.getMapList(sql7);
			String sql7_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '110%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql7_1);
			if(list != null && list.size() > 0&&brand_list != null && brand_list.size() > 0){
				root.put("list",list);
				root.put("brand_list",brand_list);
				freemarkerUtils.generate("index_page/index_hot_pro.htm",root,realPath+"index_new/index_page/index_hot_kuangshanjixie.htm");
			}
			//破碎设备
			String sql8 = " select top 4 id,factoryname,name,file_name,catalogname,img2 from pro_products where is_show = 1 and catalognum like '113%' order by view_count desc ";
			list = dbHelper.getMapList(sql8);
			String sql8_1 = "SELECT top 10 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '113%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql8_1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("index_page/index_hot_pro.htm",root,realPath+"index_new/index_page/index_hot_posuishebei.htm");
			}
	         result="true";	
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}

	
%>