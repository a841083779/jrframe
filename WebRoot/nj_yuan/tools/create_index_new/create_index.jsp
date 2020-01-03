<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String flag = CommonString.getFormatPara(request.getParameter("flag"));

    Connection connection = null;
    DBHelper dbHelper = DBHelper.getInstance() ;
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
	List <Map>productMap = null;
	List <Map>walist = null;
	List <Map>zhuanglist = null;
	List <Map>qizhongjilist = null;
	List <Map>hunningtulist = null;
	List <Map>zhishu = null;
	
	List <Map> wjjInquiryList = null;
	List <Map> zzjInquiryList = null;
	List <Map> qzjInquiryList = null;
	List <Map> hntInquiryList = null;
	List <Map> list = null;
	List <Map> koubeilist = null;
	String sql="";
	
	Map root = new HashMap();
	    freemarkerUtils.generate("create_index/index_top_inquiry.htm",realPath+"create_index/index_top_inquiry.htm") ;//生成首页上方最新询价
	    //freemarkerUtils.generate("create_index/index_top_wajueji_rank.htm",realPath+"create_index/index_top_wajueji_rank.htm") ;//生成首页上方挖掘机排行
	    freemarkerUtils.generate("create_index/index_top_comment.htm",realPath+"create_index/index_top_comment.htm") ;//生成首页上方口碑
	    try{
	        connection = dbHelper.getConnection();
			/*
            //挖掘机铁臂排行榜
			walist= dbHelper.getMapList(" SELECT top 10 100 as fm,allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from  pro_product_form  WHERE  is_deleted=0 and catanum like '101001%' GROUP BY factoryid ) as h INNER JOIN ( SELECT  name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY  (h.allCount) DESC ",connection);
			if(walist != null && walist.size() > 0){
				root.put("list",walist);
				//freemarkerUtils.generate("create_index/index_rank.htm",root,realPath+"create_index/index_wajueji_rank.htm");
			}
			//装载机铁臂排行榜
			zhuanglist = dbHelper.getMapList(" SELECT top 10 90 as fm,allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from  pro_product_form  WHERE  is_deleted=0 and catanum like '101002%' GROUP BY factoryid ) as h INNER JOIN ( SELECT  name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1 ) AS j ON  j.id=h.factoryid ORDER BY  (h.allCount) DESC ",connection);
			if(zhuanglist != null && zhuanglist.size() > 0){
				root.put("list",zhuanglist);
				//freemarkerUtils.generate("create_index/index_rank.htm",root,realPath+"create_index/index_zhuangzaiji_rank.htm");
			}
			//起重机铁臂排行榜
			qizhongjilist = dbHelper.getMapList(" SELECT top 10 90 as fm,allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from  pro_product_form  WHERE  is_deleted=0 and catanum like '102%' GROUP BY factoryid ) as h INNER JOIN ( SELECT  name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY  (h.allCount) DESC ",connection);
			if(qizhongjilist != null && qizhongjilist.size() > 0){
				root.put("list",qizhongjilist);
				//freemarkerUtils.generate("create_index/index_rank.htm",root,realPath+"create_index/index_qizhongji_rank.htm");
			}
			//混凝土铁臂排行榜
			hunningtulist = dbHelper.getMapList(" SELECT top 10 90 as fm,allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from  pro_product_form  WHERE  is_deleted=0 and catanum like '103%' GROUP BY factoryid ) as h INNER JOIN ( SELECT  name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1 ) AS j ON  j.id=h.factoryid ORDER BY  (h.allCount) DESC ",connection);
			if(hunningtulist != null && hunningtulist.size() > 0){
				root.put("list",hunningtulist);
				//freemarkerUtils.generate("create_index/index_rank.htm",root,realPath+"create_index/index_hunningtu_rank.htm");
			}
			*/

			//挖掘机询价
			wjjInquiryList= dbHelper.getMapList("SELECT top 10 allCount as view_count,img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,introduce from (SELECT  (COUNT(*)*9) AS allCount,product_id from pro_product_form  WHERE   is_deleted=0 and product_id!=0 and catanum like '101001%' GROUP BY product_id) as h inner JOIN ( SELECT img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,view_count,introduce FROM pro_products where is_show=1  ) AS j ON  j.id=h.product_id ORDER BY h.allCount DESC",connection);
			if(wjjInquiryList != null && wjjInquiryList.size() > 0){
				root.put("list",wjjInquiryList);
				freemarkerUtils.generate("create_index/inquiry_list.htm",root,realPath+"create_index/index_wajueji_inquiry.htm");
			}
			//装载机询价
			zzjInquiryList = dbHelper.getMapList("SELECT top 10 allCount as view_count,img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,introduce from (SELECT  (COUNT(*)*9) AS allCount,product_id from pro_product_form  WHERE   is_deleted=0 and product_id!=0 and catanum like '101002%' GROUP BY product_id) as h inner JOIN ( SELECT img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,view_count,introduce FROM pro_products where is_show=1 ) AS j ON  j.id=h.product_id ORDER BY h.allCount DESC");
			if(zzjInquiryList != null && zzjInquiryList.size() > 0){
				root.put("list",zzjInquiryList);
				freemarkerUtils.generate("create_index/inquiry_list.htm",root,realPath+"create_index/index_zhuangzaiji_inquiry.htm");
			}
			//起重机询价
			qzjInquiryList = dbHelper.getMapList("SELECT top 10 allCount as view_count,img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,introduce from (SELECT  (COUNT(*)*9) AS allCount,product_id from pro_product_form  WHERE   is_deleted=0 and product_id!=0 and catanum like '102%' GROUP BY product_id) as h inner JOIN ( SELECT img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,view_count,introduce FROM pro_products where is_show=1 ) AS j ON  j.id=h.product_id ORDER BY h.allCount DESC ",connection);
			if(qzjInquiryList != null && qzjInquiryList.size() > 0){
				root.put("list",qzjInquiryList);
				freemarkerUtils.generate("create_index/inquiry_list.htm",root,realPath+"create_index/index_qizhongji_inquiry.htm");
			}
			//混凝土询价
			hntInquiryList = dbHelper.getMapList("SELECT top 10 allCount as view_count,img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,introduce from (SELECT  (COUNT(*)*9) AS allCount,product_id from pro_product_form  WHERE   is_deleted=0 and product_id!=0 and catanum like '103%' GROUP BY product_id) as h inner JOIN ( SELECT img2,factoryname,catalogname,name,file_name,factoryid,catalognum,id,view_count,introduce FROM pro_products where is_show=1 ) AS j ON  j.id=h.product_id ORDER BY h.allCount DESC ",connection);
			if(hntInquiryList != null && hntInquiryList.size() > 0){
				root.put("list",hntInquiryList);
				freemarkerUtils.generate("create_index/inquiry_list.htm",root,realPath+"create_index/index_hunningtu_inquiry.htm");
			}
			
			
			
			//挖掘机排行
			list= dbHelper.getMapList("select top 10 file_name,view_count,factoryname,catalogname,name from pro_products where  is_show=1 and   catalognum like '101001%'  order by view_count desc",connection);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/pro_rank.htm",root,realPath+"create_index/index_wajueji_rank.htm");
			}
			//装载机排行
			list = dbHelper.getMapList("select top 10  file_name,view_count,factoryname,catalogname,name  from pro_products where  is_show=1 and catalognum like '101002%' order by view_count desc");
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/pro_rank.htm",root,realPath+"create_index/index_zhuangzaiji_rank.htm");
			}
			//起重机排行
			list = dbHelper.getMapList("select top 10  file_name,view_count,factoryname,catalogname,name  from pro_products where is_show=1 and catalognum like '102%' order by view_count desc ",connection);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/pro_rank.htm",root,realPath+"create_index/index_qizhongji_rank.htm");
			}
			//混凝土排行
			list = dbHelper.getMapList("select top 10  file_name,view_count,factoryname,catalogname,name  from pro_products where is_show=1 and  catalognum like '103%' order by view_count desc ",connection);
			if(list != null && list.size() > 0){
				root.put("list",list);
				freemarkerUtils.generate("create_index/pro_rank.htm",root,realPath+"create_index/index_hunningtu_rank.htm");
			}
			
		
		    //其他产品
			//推土机
			String sql1 = " select top 15 factoryname,name,file_name,id from pro_products where is_show = 1 and catalognum like '101003%' order by view_count desc ";
			list = dbHelper.getMapList(sql1);
			root.put("list",list);
			String sql1_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '101003%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql1_1);
            root.put("listbrand",list);
			sql = " select top 1 title,url,img,order_no,sub_title,id from pro_index_data  where channel_uuid = 'F977E6CE-B6C0-4F2A-B282-7170B597B59E' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			root.put("onePro",list);
			//freemarkerUtils.generate("create_index/index_other_pro_list.htm",root,realPath+"create_index/index_ttj_pro.htm");
			
			//叉车
			String sql2 = " select top 15 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '107%' order by view_count desc ";
			list = dbHelper.getMapList(sql2);
			root.put("list",list);
			String sql2_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '107%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql2_1);
			root.put("listbrand",list);
			sql = " select top 1 title,url,img,order_no,sub_title,id from pro_index_data  where channel_uuid = '562544C0-B689-4DE1-8B72-8DFC6F95EF5B' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			root.put("onePro",list);
			//freemarkerUtils.generate("create_index/index_other_pro_list.htm",root,realPath+"create_index/index_cc_pro.htm");
		
			//压路机
			String sql3 = " select top 15 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '106001%' order by view_count desc ";
			list = dbHelper.getMapList(sql3);
		    root.put("list",list);
			String sql3_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '106001%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql3_1);
			root.put("listbrand",list);
			sql = " select top 1 title,url,img,order_no,sub_title,id from pro_index_data  where channel_uuid = 'C6EA8121-CCB5-4FF0-87CD-B727FCC7E402' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			root.put("onePro",list);
		    //freemarkerUtils.generate("create_index/index_other_pro_list.htm",root,realPath+"create_index/index_ylj_pro.htm");
			
			//筑路机械
			String sql4 = " select top 15 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '104%' order by view_count desc ";
			list = dbHelper.getMapList(sql4);
			root.put("list",list);
			String sql4_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '104%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql4_1);
			root.put("listbrand",list);
			sql = " select top 1 title,url,img,order_no,sub_title,id from pro_index_data  where channel_uuid = '0360E36F-8442-48AF-8D1B-C5DF3D8ED705' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			root.put("onePro",list);
			//freemarkerUtils.generate("create_index/index_other_pro_list.htm",root,realPath+"create_index/index_zljx_pro.htm");
			
	
			//平地机
			String sql5 = " select top 15 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '101005%' order by view_count desc ";
			list = dbHelper.getMapList(sql5);
			root.put("list",list);
			String sql5_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '101005%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql5_1);
			root.put("listbrand",list);
			sql = " select top 1  title,url,img,order_no,sub_title,id from pro_index_data  where channel_uuid = 'F349F80C-9585-4BA1-AE25-B620125F51A2' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			root.put("onePro",list);
			//freemarkerUtils.generate("create_index/index_other_pro_list.htm",root,realPath+"create_index/index_pdj_pro.htm");
	
			//旋挖钻
			String sql6 = " select top 15 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '105003%' order by view_count desc ";
			list = dbHelper.getMapList(sql6);
			root.put("list",list);
			String sql6_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '105003%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql6_1);
			root.put("listbrand",list);
			sql = " select  title,url,img,order_no,sub_title,id from pro_index_data  where channel_uuid = '409F7023-3780-4342-BB8C-77F70E095D5B' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			root.put("onePro",list);
			//freemarkerUtils.generate("create_index/index_other_pro_list.htm",root,realPath+"create_index/index_xwz_pro.htm");
	
			//地下矿山机械
			String sql7 = " select top 15 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '110%' order by view_count desc ";
			list = dbHelper.getMapList(sql7);
			root.put("list",list);
			String sql7_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '110%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql7_1);
			root.put("listbrand",list);
			sql = " select top 1  title,url,img,order_no,sub_title,id from pro_index_data  where channel_uuid = '6EF085AD-BD86-4A1C-9A5A-06112D98090A' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			root.put("onePro",list);
			//freemarkerUtils.generate("create_index/index_other_pro_list.htm",root,realPath+"create_index/index_dxksjx_pro.htm");
		

			
			//破碎设备
			String sql8 = " select top 15 factoryname,name,file_name from pro_products where is_show = 1 and catalognum like '101001098%' order by view_count desc ";
			list = dbHelper.getMapList(sql8);
			root.put("list",list);
			freemarkerUtils.generate("index_new/index_hot.htm",root,realPath+"index_new/index_new/index_hot_posuishebei.htm");
			String sql8_1 = "SELECT top 6 name,logo,usern,id from (SELECT COUNT(*) AS allCount,factoryid from pro_product_form  WHERE  catanum like '101001098%' GROUP BY factoryid ) as h INNER JOIN ( SELECT name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY (h.allCount) DESC ";   
			list = dbHelper.getMapList(sql8_1);
			root.put("listbrand",list);
			sql = " select top 1  title,url,img,order_no,sub_title,id from pro_index_data  where channel_uuid = 'CAA8E310-0FB3-4071-AE99-20D80EEDE55A' and is_pub = 1  order by order_no asc ";
			list = dbHelper.getMapList(sql);
			root.put("onePro",list);
			//freemarkerUtils.generate("create_index/index_other_pro_list.htm",root,realPath+"create_index/index_pssb_pro.htm");
		
		    
			//二手
			List<Map> usedList  = new ArrayList<Map>();
			List<Map> usedListOld  = WEBDBHelper.getMapList("select  top 4  used_equipment.city_id,used_area.area_name,used_equipment.import_brand,used_equipment.price,used_equipment.workingtime,used_equipment.img1_1,used_equipment.factorydate,used_equipment.model,used_equipment.id,used_catalog.name from used_equipment,used_catalog,used_area  where used_equipment.is_review=1  and  used_equipment.is_pub=1 and  used_equipment.brand_id!='' and used_equipment.category_id=used_catalog.id and used_area.area_id=used_equipment.province_id and used_equipment.img1_1 like '%resource.21-sun%' order by  used_equipment.id desc","Web21usedDBHelper");
			if(null != usedListOld && usedListOld.size()>0){
				for(Map map:usedListOld){
					String city_name="";
					Map areaMap=WEBDBHelper.getMap("select area_name from used_area where area_id= "+CommonString.getFormatPara(map.get("city_id")),"Web21usedDBHelper");
					if(areaMap!=null){city_name=CommonString.getFormatPara(areaMap.get("area_name"));}
					map.put("city_name",city_name);
					usedList.add(map);
				}
			}
			root.put("usedList",usedList) ;
			freemarkerUtils.generate("create_index/used_list.htm",root,realPath+"create_index/used_list.htm");
			
			
			 //挖掘机口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name,pm.add_date FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '101001%' and pm.username is not null and pm.username!=''  and pm.is_show=1 and   pm.content <> ''  and   pm.content is not null ORDER BY pm.add_date DESC ",connection);
			root.put("koubeilist",koubeilist);
		    freemarkerUtils.generate("create_index/index_koubei_list.htm",root,realPath+"create_index/index_wjj_koubei.htm");

			 //装载机口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name,pm.add_date FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '101002%' and pm.username is not null and pm.username!=''   and pm.is_show=1 and   pm.content <> ''  and   pm.content is not null ORDER BY pm.add_date DESC ",connection);
			root.put("koubeilist",koubeilist);
			freemarkerUtils.generate("create_index/index_koubei_list.htm",root,realPath+"create_index/index_zzj_koubei.htm");

			 //起重机口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name,pm.add_date FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '102%' and pm.username is not null and pm.username!=''   and pm.is_show=1 and   pm.content <> ''  and   pm.content is not null ORDER BY pm.add_date DESC ",connection);
			root.put("koubeilist",koubeilist);
			freemarkerUtils.generate("create_index/index_koubei_list.htm",root,realPath+"create_index/index_qzj_koubei.htm");

			 //混凝土口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name,pm.add_date FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '103%' and pm.username is not null and pm.username!=''   and pm.is_show=1 and   pm.content <> ''  and   pm.content is not null ORDER BY pm.add_date DESC ",connection);
			root.put("koubeilist",koubeilist);
			freemarkerUtils.generate("create_index/index_koubei_list.htm",root,realPath+"create_index/index_hnt_koubei.htm");

			
			//推土机口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name,pm.add_date FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '101003%' and pm.username is not null and pm.username!=''  and pm.is_show=1 and   pm.content <> ''  and   pm.content is not null ORDER BY pm.add_date DESC ",connection);
			root.put("koubeilist",koubeilist);
			freemarkerUtils.generate("create_index/index_koubei_list.htm",root,realPath+"create_index/index_ttj_koubei.htm");

			//叉车口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name,pm.add_date FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '107%' and pm.username is not null and pm.username!=''   and pm.is_show=1 and   pm.content <> ''  and   pm.content is not null ORDER BY pm.add_date DESC ",connection);
			root.put("koubeilist",koubeilist);
			freemarkerUtils.generate("create_index/index_koubei_list.htm",root,realPath+"create_index/index_cc_koubei.htm");

			//压路机口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name,pm.add_date FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '106001%' and pm.username is not null and pm.username!=''   and pm.is_show=1 and   pm.content <> ''  and   pm.content is not null ORDER BY pm.add_date DESC ",connection);
			root.put("koubeilist",koubeilist);
			freemarkerUtils.generate("create_index/index_koubei_list.htm",root,realPath+"create_index/index_ylj_koubei.htm");

			//筑路机械口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name,pm.add_date FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '104%' and pm.username is not null and pm.username!=''  and pm.is_show=1 and   pm.content <> ''  and   pm.content is not null ORDER BY pm.add_date DESC ",connection);
			root.put("koubeilist",koubeilist);
			freemarkerUtils.generate("create_index/index_koubei_list.htm",root,realPath+"create_index/index_zljx_koubei.htm");

			//地下矿山机械口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name,pm.add_date FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '110%' and pm.username is not null and pm.username!=''  and pm.is_show=1 and   pm.content <> ''  and   pm.content is not null ORDER BY pm.add_date DESC ",connection);
			root.put("koubeilist",koubeilist);
			freemarkerUtils.generate("create_index/index_koubei_list.htm",root,realPath+"create_index/index_dxksjx_koubei.htm");

			
			

		
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBHelper.freeConnection(connection) ;
		}

	out.print("ok");
%>