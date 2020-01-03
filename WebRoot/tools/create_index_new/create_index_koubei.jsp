<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  Connection connection = null;
   DBHelper dbHelper = DBHelper.getInstance() ;
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
	List <Map>koubeilist = null;
	Map root = new HashMap();
	try{
	        connection = dbHelper.getConnection();
            //挖掘机口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '101001%'  and pm.is_show=1 ORDER BY pm.add_date DESC ",connection);
			if(koubeilist != null && koubeilist.size() > 0){
				root.put("list",koubeilist);
				freemarkerUtils.generate("create_index/index_koubei.htm",root,realPath+"create_index/index_wwj_koubei.htm");
			}
			 //装载机口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '101002%'  and pm.is_show=1 ORDER BY pm.add_date DESC ",connection);
			if(koubeilist != null && koubeilist.size() > 0){
				root.put("list",koubeilist);
				freemarkerUtils.generate("create_index/index_koubei.htm",root,realPath+"create_index/index_zzj_koubei.htm");
			}
			 //起重机口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '102%'  and pm.is_show=1 ORDER BY pm.add_date DESC ",connection);
			if(koubeilist != null && koubeilist.size() > 0){
				root.put("list",koubeilist);
				freemarkerUtils.generate("create_index/index_koubei.htm",root,realPath+"create_index/index_qzj_koubei.htm");
			}
			 //混凝土口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '103%'  and pm.is_show=1 ORDER BY pm.add_date DESC ",connection);
			if(koubeilist != null && koubeilist.size() > 0){
				root.put("list",koubeilist);
				freemarkerUtils.generate("create_index/index_koubei.htm",root,realPath+"create_index/index_hnt_koubei.htm");
			}
			
			//推土机口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '101003%'  and pm.is_show=1 ORDER BY pm.add_date DESC ",connection);
			if(koubeilist != null && koubeilist.size() > 0){
				root.put("list",koubeilist);
				freemarkerUtils.generate("create_index/index_koubei.htm",root,realPath+"create_index/index_ttj_koubei.htm");
			}
			//叉车口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '107%'  and pm.is_show=1 ORDER BY pm.add_date DESC ",connection);
			if(koubeilist != null && koubeilist.size() > 0){
				root.put("list",koubeilist);
				freemarkerUtils.generate("create_index/index_koubei.htm",root,realPath+"create_index/index_cc_koubei.htm");
			}
			//压路机口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '106001%'  and pm.is_show=1 ORDER BY pm.add_date DESC ",connection);
			if(koubeilist != null && koubeilist.size() > 0){
				root.put("list",koubeilist);
				freemarkerUtils.generate("create_index/index_koubei.htm",root,realPath+"create_index/index_ylj_koubei.htm");
			}
			//筑路机械口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '104%'  and pm.is_show=1 ORDER BY pm.add_date DESC ",connection);
			if(koubeilist != null && koubeilist.size() > 0){
				root.put("list",koubeilist);
				freemarkerUtils.generate("create_index/index_koubei.htm",root,realPath+"create_index/index_zljx_koubei.htm");
			}
			//地下矿山机械口碑
			koubeilist= dbHelper.getMapList(" SELECT top 4 substring(cast(pm.id as varchar(10)),len(cast(pm.id as varchar(10))),len(cast(pm.id as varchar(10)))) as randnum,pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pp.factoryname,pp.catalogname,pp.name product_name,pp.file_name FROM pro_comments pm inner JOIN pro_products pp ON pm.product_id = pp.id  and pp.catalognum like '110%' and pm.is_show=1 ORDER BY pm.add_date DESC ",connection);
			if(koubeilist != null && koubeilist.size() > 0){
				root.put("list",koubeilist);
				freemarkerUtils.generate("create_index/index_koubei.htm",root,realPath+"create_index/index_ksjx_koubei.htm");
			}


		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBHelper.freeConnection(connection) ;
		}

	
%>