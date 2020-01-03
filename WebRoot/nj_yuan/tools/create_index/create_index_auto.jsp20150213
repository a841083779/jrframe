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
%>
<%
   DBHelper dbHelper = DBHelper.getInstance() ;
	Connection conn_21sun = null;
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
	List <Map>productMap = null;
	List <Map>walist = null;
	List <Map>zhuanglist = null;
		Map root = new HashMap();
	if(flag.equals("sanxiaoshi")){
	freemarkerUtils.generate("index_new/index_inquiry.htm",realPath+"/index_new/index_new/index_inquiry.htm") ;//生成首页最新询价
	}else if(flag.equals("yitain")){
	freemarkerUtils.generate("index_new/index_inquiry.htm",realPath+"/index_new/index_new/index_inquiry.htm") ;//生成首页最新询价
	freemarkerUtils.generate("index_new/index_wajueji_top.htm",realPath+"/index_new/index_new/index_wajueji_top.htm") ;//生成首页挖掘机排行
	freemarkerUtils.generate("index_new/index_comment_3.htm",realPath+"/index_new/index_new/index_comment_3.htm") ;//生成首页评论_(最上面3条)
	freemarkerUtils.generate("index_new/index_comment_9.htm",realPath+"/index_new/index_new/index_comment_9.htm") ;//生成首页评论_(最下面9条)
	try{
        conn_21sun = dbHelper.getConnection();//二手
   	     productMap = WEBDBHelper.getMapList(" select  top 5  used_equipment.import_brand   ,used_equipment.price,used_equipment.workingtime,used_equipment.img1_1,used_equipment.factorydate,used_equipment.model,used_equipment.id,used_catalog.name from used_equipment,used_catalog where  used_equipment.brand_id!='' and used_equipment.category_id=used_catalog.id   and used_equipment.price > 0 order by  used_equipment.id desc","Web21usedDBHelper");		
		 if(productMap != null && productMap.size() > 0){
				root.put("list",productMap);
				freemarkerUtils.generate("index_new/index_used.htm",root,realPath+"/index_new/index_new/index_used.htm");
			}	
		
			//挖掘机铁臂排行榜
			walist = WEBDBHelper.getMapList(" SELECT top 6 100 as fm,allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from  pro_product_form  WHERE  is_deleted=0 and catanum like '101001%' GROUP BY factoryid ) as h INNER JOIN ( SELECT  name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 ) AS j ON  j.id=h.factoryid ORDER BY  (h.allCount) DESC ","Web21proDBHelper");
			if(walist != null && walist.size() > 0){
				root.put("list",walist);
				freemarkerUtils.generate("index_new/index_top.htm",root,realPath+"index_new/index_new/index_top_wajueji.htm");
			}
			//装载机铁臂排行榜
			zhuanglist = WEBDBHelper.getMapList(" SELECT top 6 90 as fm,allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from  pro_product_form  WHERE  is_deleted=0 and catanum like '101002%' GROUP BY factoryid ) as h INNER JOIN ( SELECT  name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 ) AS j ON  j.id=h.factoryid ORDER BY  (h.allCount) DESC ","Web21proDBHelper");
			if(zhuanglist != null && zhuanglist.size() > 0){
				root.put("list",zhuanglist);
				freemarkerUtils.generate("index_new/index_top.htm",root,realPath+"index_new/index_new/index_top_zhuangzaiji.htm");
			}
			
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(conn_21sun) ;
	}
	}
	
%>