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
			//挖掘机
			String sql1_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '101001%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql1_1);
			if(brand_list != null && brand_list.size() > 0){
				root.put("brand_list",brand_list);
				root.put("catalognum","101001");
				freemarkerUtils.generate("index_page/index_floor_brand.htm",root,realPath+"index_new/index_page/index_hot_brand_wjj.htm");
			
			}
			//装载机
			String sql2_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '101002%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql2_1);
			if(brand_list != null && brand_list.size() > 0){
				root.put("brand_list",brand_list);
				root.put("catalognum","101002");
				freemarkerUtils.generate("index_page/index_floor_brand.htm",root,realPath+"index_new/index_page/index_hot_brand_zzj.htm");
			}
			//起重机
			String sql3_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '102%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid and j.usern!='bdzg' ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql3_1);
			if(brand_list != null && brand_list.size() > 0){
				root.put("brand_list",brand_list);
				root.put("catalognum","102");
				freemarkerUtils.generate("index_page/index_floor_brand.htm",root,realPath+"index_new/index_page/index_hot_brand_qzj.htm");
			}
			//混凝土
			String sql4_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '103%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			brand_list = dbHelper.getMapList(sql4_1);
			if(brand_list != null && brand_list.size() > 0){
				root.put("brand_list",brand_list);
				root.put("catalognum","103");
				freemarkerUtils.generate("index_page/index_floor_brand.htm",root,realPath+"index_new/index_page/index_hot_brand_hnt.htm");
			}
			
	         result="true";	
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}

	
%>