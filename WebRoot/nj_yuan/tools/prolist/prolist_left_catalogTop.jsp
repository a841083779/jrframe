<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	// 生成所有产品详细页
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = null;
	Map roots = null;
	String factoryid="";
	String factoryname="";
	String catalognum="";
	String catalogname="";
	List<Map> catalog_list = dbHelper.getMapList("select  catalog_num,name from pro_catalog where is_show=1") ;
	for(Map cata:catalog_list){
	catalognum=CommonString.getFormatPara(cata.get("catalog_num"));
	catalogname=CommonString.getFormatPara(cata.get("name"));
	List<Map> list = dbHelper.getMapList("SELECT top 15 name,id FROM pro_agent_factory AS a INNER JOIN (SELECT factoryid,SUM(view_count) as counts FROM pro_products WHERE catalognum_new LIKE '"+catalognum+"%'  GROUP BY factoryid) AS b ON a.id=b.factoryid ORDER BY b.counts desc") ;
		  String tid="";
		 String factorynames="";
		if(null != list && list.size()>0){
				root = new HashMap();
				root.put("list", list); 
				root.put("catalogName", catalogname); 
				root.put("catalognum", catalognum); 
			    freemarkerUtils.generate("prolist/product_list_left_catalogTop.shtm",root,realPath+"/include/prolist/prolist_left_cataolgTop/prolist_left_cataolgTop_"+catalognum+".htm") ;  				
			
		}
		
		String sql = " SELECT top 4 * FROM ( SELECT * , ROW_NUMBER() OVER ( PARTITION BY factoryid ORDER BY view_count DESC ) rid FROM pro_products where catalognum_new LIKE '"+catalognum+"%' ) AS t WHERE rid = 1 order by view_count desc ";
       List <Map> lists = dbHelper.getMapList(sql);
	   if(lists != null && lists.size() > 0){
	   roots = new HashMap();
	   roots.put("list", lists); 
	   freemarkerUtils.generate("prolist/product_list_left_catalogView.shtm",roots,realPath+"/include/prolist/prolist_left_cataolgView/prolist_left_cataolgView_"+catalognum+".htm") ;  				
			
	   }
		}
	out.println("ok") ;
%>
