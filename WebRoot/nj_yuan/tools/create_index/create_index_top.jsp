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
	Map root = new HashMap();
	
	/*测试定时器*/
		try {
		Map roots = new HashMap() ;
		roots.put("to","songlf@21-sun.com") ;
		roots.put("title","产品首页头部右侧订单生成") ;
		roots.put("content","产品首页头部右侧订单生成");
		String srt=Common.doPost("http://service.21-sun.com/http/utils/sendmail.jsp", roots) ;
	   } catch (Exception e) {}
	
	if(flag.equals("sanxiaoshi")){
	  freemarkerUtils.generate("index_page/index_inquiry.htm",realPath+"/index_new/index_page/index_inquiry.htm") ;//生成首页最新询价
	}else if(flag.equals("yitain")){
	  freemarkerUtils.generate("index_page/index_inquiry.htm",realPath+"/index_new/index_page/index_inquiry.htm") ;//生成首页最新询价
	  freemarkerUtils.generate("index_page/index_wajueji_top.htm",realPath+"/index_new/index_page/index_wajueji_top.htm") ;//生成首页挖掘机排行
	  freemarkerUtils.generate("index_page/index_comment_3.htm",realPath+"/index_new/index_page/index_comment_3.htm") ;//生成首页评论_(最上面3条)
	try{
	        connection = dbHelper.getConnection();
            //挖掘机铁臂排行榜
			walist= dbHelper.getMapList(" SELECT top 10 100 as fm,allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from  pro_product_form  WHERE  is_deleted=0 and catanum like '101001%' GROUP BY factoryid ) as h INNER JOIN ( SELECT  name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY  (h.allCount) DESC ",connection);
			if(walist != null && walist.size() > 0){
				root.put("list",walist);
				freemarkerUtils.generate("index_page/index_top.htm",root,realPath+"index_new/index_page/index_top_wajueji.htm");
			}
			//装载机铁臂排行榜
			zhuanglist = dbHelper.getMapList(" SELECT top 10 90 as fm,allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from  pro_product_form  WHERE  is_deleted=0 and catanum like '101002%' GROUP BY factoryid ) as h INNER JOIN ( SELECT  name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1 ) AS j ON  j.id=h.factoryid ORDER BY  (h.allCount) DESC ",connection);
			if(zhuanglist != null && zhuanglist.size() > 0){
				root.put("list",zhuanglist);
				freemarkerUtils.generate("index_page/index_top.htm",root,realPath+"index_new/index_page/index_top_zhuangzaiji.htm");
			}
			//起重机铁臂排行榜
			qizhongjilist = dbHelper.getMapList(" SELECT top 10 90 as fm,allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from  pro_product_form  WHERE  is_deleted=0 and catanum like '102%' GROUP BY factoryid ) as h INNER JOIN ( SELECT  name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1) AS j ON  j.id=h.factoryid ORDER BY  (h.allCount) DESC ",connection);
			if(qizhongjilist != null && qizhongjilist.size() > 0){
				root.put("list",qizhongjilist);
				freemarkerUtils.generate("index_page/index_top.htm",root,realPath+"index_new/index_page/index_top_qizhongji.htm");
			}
			//混凝土铁臂排行榜
			hunningtulist = dbHelper.getMapList(" SELECT top 10 90 as fm,allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from  pro_product_form  WHERE  is_deleted=0 and catanum like '103%' GROUP BY factoryid ) as h INNER JOIN ( SELECT  name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1 ) AS j ON  j.id=h.factoryid ORDER BY  (h.allCount) DESC ",connection);
			if(hunningtulist != null && hunningtulist.size() > 0){
				root.put("list",hunningtulist);
				freemarkerUtils.generate("index_page/index_top.htm",root,realPath+"index_new/index_page/index_top_hunningtu.htm");
			}
			
			//铁臂排行榜
			zhishu = dbHelper.getMapList(" SELECT top 8 90 as fm,allCount,factoryid,name,full_name,logo,english_name,usern from (SELECT COUNT(*) AS allCount,factoryid from  pro_product_form  WHERE  is_deleted=0  GROUP BY factoryid ) as h INNER JOIN ( SELECT  name,full_name,logo,id,english_name,usern,view_count  FROM pro_agent_factory WHERE flag=1 and is_show=1 ) AS j ON  j.id=h.factoryid ORDER BY  (h.allCount) DESC ",connection);
			if(zhishu != null && zhishu.size() > 0){
				root.put("list",zhishu);
				freemarkerUtils.generate("index_page/index_top.htm",root,realPath+"index_new/index_page/index_top_tiebizhishu.htm");
			}
			
		
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBHelper.freeConnection(connection) ;
		}
	}
	
%>