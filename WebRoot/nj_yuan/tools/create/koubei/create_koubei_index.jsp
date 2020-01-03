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
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	String resule="false";
	String sql="";
	String sql1="";
	try{
		List <Map>list = null;
		List <Map>list1 = null;
		Map root = new HashMap();
		Map root1 = new HashMap();
			//挖掘机口碑排行
			sql = " SELECT top 4 a.factoryname,a.name,a.catalogname,a.file_name,b.allcount,a.id,a.img2 from (select  factoryname,name,catalogname,file_name,id,img2 from pro_products where is_show=1 AND catalognum LIKE '%101001%' )as a INNER  JOIN ( SELECT COUNT(product_id) as allcount,product_id  FROM pro_comments  GROUP BY product_id  ) as b ON a.id=b.product_id  ORDER BY  b.allcount desc ";
			list = dbHelper.getMapList(sql);
			sql1 = "SELECT top 2 a.factoryname,a.name,a.catalogname,a.file_name,a.id,a.img2,b.add_date,b.content,b.id as commentid from (select  factoryname,name,catalogname,file_name,id,img2 from pro_products where is_show=1 AND catalognum LIKE '%101001%' )as a INNER  JOIN ( SELECT product_id,add_date,content ,id FROM pro_comments  where is_show=1  ) as b ON a.id=b.product_id  ORDER BY  b.add_date desc ";
			list1= dbHelper.getMapList(sql1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				root.put("list1",list1);
				freemarkerUtils.generate("koubei_page/koubei_index_top.htm",root,realPath+"koubei/include/koubei_index_wjj_top.htm");
				freemarkerUtils.generate("koubei_page/koubei_index_right.htm",root,realPath+"koubei/include/koubei_index_wjj_right.htm");
				resule="true";
			}
            //装载机口碑排行
			sql = " SELECT top 4 a.factoryname,a.name,a.catalogname,a.file_name,b.allcount,a.id,a.img2 from (select  factoryname,name,catalogname,file_name,id,img2 from pro_products where is_show=1 AND catalognum LIKE '%101002%' )as a INNER  JOIN ( SELECT COUNT(product_id) as allcount,product_id  FROM pro_comments  GROUP BY product_id  ) as b ON a.id=b.product_id  ORDER BY  b.allcount desc ";
			list = dbHelper.getMapList(sql);
			sql1 = "SELECT top 2 a.factoryname,a.name,a.catalogname,a.file_name,a.id,a.img2,b.add_date,b.content,b.id as commentid from (select  factoryname,name,catalogname,file_name,id,img2 from pro_products where is_show=1 AND catalognum LIKE '%101002%' )as a INNER  JOIN ( SELECT product_id,add_date,content ,id FROM pro_comments  where is_show=1  ) as b ON a.id=b.product_id  ORDER BY  b.add_date desc ";
			list1= dbHelper.getMapList(sql1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				root.put("list1",list1);
				freemarkerUtils.generate("koubei_page/koubei_index_top.htm",root,realPath+"koubei/include/koubei_index_zzj_top.htm");
				freemarkerUtils.generate("koubei_page/koubei_index_right.htm",root,realPath+"koubei/include/koubei_index_zzj_right.htm");
				resule="true";
			}
             //起重机口碑排行
			sql = " SELECT top 4 a.factoryname,a.name,a.catalogname,a.file_name,b.allcount,a.id,a.img2 from (select  factoryname,name,catalogname,file_name,id,img2 from pro_products where is_show=1 AND catalognum LIKE '%102%' )as a INNER  JOIN ( SELECT COUNT(product_id) as allcount,product_id  FROM pro_comments  GROUP BY product_id  ) as b ON a.id=b.product_id  ORDER BY  b.allcount desc ";
			list = dbHelper.getMapList(sql);
			sql1 = "SELECT top 2 a.factoryname,a.name,a.catalogname,a.file_name,a.id,a.img2,b.add_date,b.content,b.id as commentid from (select  factoryname,name,catalogname,file_name,id,img2 from pro_products where is_show=1 AND catalognum LIKE '%102%' )as a INNER  JOIN ( SELECT product_id,add_date,content ,id FROM pro_comments  where is_show=1  ) as b ON a.id=b.product_id  ORDER BY  b.add_date desc ";
			list1= dbHelper.getMapList(sql1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				root.put("list1",list1);
				freemarkerUtils.generate("koubei_page/koubei_index_top.htm",root,realPath+"koubei/include/koubei_index_qzj_top.htm");
				freemarkerUtils.generate("koubei_page/koubei_index_right.htm",root,realPath+"koubei/include/koubei_index_qzj_right.htm");
				resule="true";
			}
             //推土机口碑排行
			sql = " SELECT top 4 a.factoryname,a.name,a.catalogname,a.file_name,b.allcount,a.id,a.img2 from (select  factoryname,name,catalogname,file_name,id,img2 from pro_products where is_show=1 AND catalognum LIKE '%101003%' )as a INNER  JOIN ( SELECT COUNT(product_id) as allcount,product_id  FROM pro_comments  GROUP BY product_id  ) as b ON a.id=b.product_id  ORDER BY  b.allcount desc ";
			list = dbHelper.getMapList(sql);
			sql1 = "SELECT top 2 a.factoryname,a.name,a.catalogname,a.file_name,a.id,a.img2,b.add_date,b.content,b.id as commentid from (select  factoryname,name,catalogname,file_name,id,img2 from pro_products where is_show=1 AND catalognum LIKE '%101003%' )as a INNER  JOIN ( SELECT product_id,add_date,content ,id FROM pro_comments  where is_show=1  ) as b ON a.id=b.product_id  ORDER BY  b.add_date desc ";
			list1= dbHelper.getMapList(sql1);
			if(list != null && list.size() > 0){
				root.put("list",list);
				root.put("list1",list1);
				freemarkerUtils.generate("koubei_page/koubei_index_top.htm",root,realPath+"koubei/include/koubei_index_ttj_top.htm");
				freemarkerUtils.generate("koubei_page/koubei_index_right.htm",root,realPath+"koubei/include/koubei_index_ttj_right.htm");
				resule="true";
			}		


    freemarkerUtils.generate("koubei/list_wjj.htm",realPath+"/include/koubei/list_wjj.htm") ;  
    freemarkerUtils.generate("koubei/list_zzj.htm",realPath+"/include/koubei/list_zzj.htm") ;  
    freemarkerUtils.generate("koubei/list_qzj.htm",realPath+"/include/koubei/list_qzj.htm") ;  
    freemarkerUtils.generate("koubei/list_ttj.htm",realPath+"/include/koubei/list_ttj.htm") ;
    freemarkerUtils.generate("koubei/list_pdj.htm",realPath+"/include/koubei/list_pdj.htm") ; 
    freemarkerUtils.generate("koubei/list_ylj.htm",realPath+"/include/koubei/list_ylj.htm") ; 
			
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		
	}
	out.println(resule) ;	
	%>