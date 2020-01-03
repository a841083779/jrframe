<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.webservice.WEBDBHelper"%>
<%
	
	DBHelper dbHelper = DBHelper.getInstance();

	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Map CatalogFromBrandMap = (HashMap)application.getAttribute("CatalogFromBrandMap") ;
	Map BrandCatalogMap = (HashMap)application.getAttribute("BrandCatalogMap") ;
	if(CatalogFromBrandMap==null){
		CatalogFromBrandMap=new HashMap();
	}
	if(BrandCatalogMap==null){
		BrandCatalogMap=new HashMap();
	}
	Connection connection = null;
	Map model = null;
	List <Map>list = null;
	String flag=CommonString.getFormatPara(request.getParameter("flag"));
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		
		List<Map> allList=dbHelper.getMapList("select id from pro_comments where is_show=1  order by id desc");
		for(Map m:allList){
			
			String id = CommonString.getFormatPara(m.get("id"));
out.println("id:"+id+";");
            String realPath = Common.getAbsolutePath(request) ;

			model = dbHelper.getMap(" select pm.id,pm.score1,pm.is_help,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pm.product_id,pp.factoryid,pp.factoryname,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pp.view_count from pro_comments pm left join pro_products pp on pm.product_id=pp.id where pm.id="+id+" order by pm.add_date desc ");
			
			
			//其他口碑
			List<Map> otherList=null;
			String productId="0";
			String catalog="0";
			String factoryId="0";
			if(model!=null){
				productId=CommonString.getFormatPara(model.get("product_id"));
				catalog=CommonString.getFormatPara(model.get("catalognum"));
				factoryId=CommonString.getFormatPara(model.get("factoryid"));
				otherList = dbHelper.getMapList("select top 5 pm.id,pm.score1,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pm.product_id,pm.is_help,pp.factoryid,pp.factoryname,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pp.view_count from pro_comments pm inner join pro_products pp on pm.product_id=pp.id where pm.product_id=" + productId + " and pm.id<>" + id + " order by pm.add_date desc");
				//if(otherList==null || otherList.size()<=0){ 
				//	if(factoryId!=null&&factoryId.equals("")){
						
				//		otherList = dbHelper.getMapList("select top 5 pm.id,pm.score1,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pm.product_id,pm.is_help,pp.factoryid,pp.factoryname,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pp.view_count from pro_comments pm inner join pro_products pp on pm.product_id=pp.id where pm.id<>" + id + " and pp.catalognum='" + catalog + "' and pp.factoryid=" + factoryId + " order by pm.add_date desc");
				//	}
				//}
			}
			//所有机型
			String allCatalog=CommonString.getFormatPara(CatalogFromBrandMap.get(factoryId));
			String allcatalogs[]=allCatalog.split(",");		
			String brandRank=CommonString.getFormatPara(BrandCatalogMap.get(catalog));
			String brandRanks[]=brandRank.split(",");

			List<String> allCatalogList=new ArrayList<String>();
			for(int i=0;i<allcatalogs.length;i++){
				allCatalogList.add(allcatalogs[i]+"@_@"+CommonString.getFormatPara(catalogMap.get(allcatalogs[i])));
			}
			
			List<String> brandRankList=new ArrayList<String>();
			for(int i=0;i<brandRanks.length&&i<=14;i++){
				brandRankList.add(brandRanks[i]+"@_@"+CommonString.getFormatPara(brandMap.get(brandRanks[i])).replace("卡特彼勒","卡特"));
			}

			//开始生成
			Map root = new HashMap();
			String absPath = Common.getAbsolutePath(request);
			FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"/template/");

			String catalogname3="";String catalogname6="";
			if(catalogMap.get(catalog.substring(0,3))!=null){
				catalogname3=CommonString.getFormatPara(catalogMap.get(catalog.substring(0,3)));
			}
			
			if(catalogMap.get(catalog.substring(0,6))!=null){
				catalogname6=CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6)));
			}

			root.put("otherList", otherList);  
			root.put("model", model);
			root.put("three",catalogname3);
			root.put("six",catalogname6);
			root.put("allCatalogList",allCatalogList);
			root.put("brandRankList",brandRankList);

			String fileName = CommonString.getFormatPara(model.get("file_name"));
			String  createName = absPath+"/koubei/detail_all/"+id+".htm";
				
			freemarkerUtils.generate("/koubei/detail.htm", root, createName ,request);

			

		
		
		}

		
		
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}

%>