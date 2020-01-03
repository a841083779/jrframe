<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.webservice.WEBDBHelper"%>
<%
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
	}
	String cookieusername= CommonString.getFormatPara(Common.getCookies(request,"cookieMemNo"));
	if(username.equals("")&&!cookieusername.equals("")){
		username=cookieusername;
	}
	
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
		List<Map> allList=dbHelper.getMapList("select id from pro_products where is_show=1 order by id desc");
		for(Map m:allList){

			String productId = CommonString.getFormatPara(m.get("id"));
			out.println("id:"+productId+";");

            String realPath = Common.getAbsolutePath(request) ;
			String catalog="0";String factoryId="0";
			model = dbHelper.getMap(" select id,catalognum,factoryname,name,factoryid,file_name,catalognum,img2,catalogname,view_count,add_date from pro_products where id=" + productId + " order by id desc ");
			if(model!=null){
				catalog=CommonString.getFormatPara(model.get("catalognum"));
				factoryId=CommonString.getFormatPara(model.get("factoryid"));
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
			
			List<Map> allCommentList = dbHelper.getMapList("select top 6 pm.id,pm.score1,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.username,pm.product_id,pm.is_help,pp.factoryid,pp.factoryname,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pp.view_count from pro_comments pm inner join pro_products pp on pm.product_id=pp.id where pm.product_id=" + productId + "  order by pm.add_date desc");
			
			
			//开始生成
			Map root = new HashMap();
			String absPath = Common.getAbsolutePath(request);
			FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"/template/");

			String catalogname6="";
			if(catalog.length()>6){
				if(catalogMap.get(catalog.substring(0,6))!=null){
					catalogname6=CommonString.getFormatPara(catalogMap.get(catalog.substring(0,6)));
				}
			}else{
				if(catalogMap.get(catalog)!=null){
					catalogname6=CommonString.getFormatPara(catalogMap.get(catalog));
				}
			}
			

			root.put("allCommentList", allCommentList);  
			root.put("model", model);
			root.put("six",catalogname6);
			root.put("allCatalogList",allCatalogList);
			root.put("brandRankList",brandRankList);
			root.put("username",username);

			String fileName = CommonString.getFormatPara(model.get("file_name"));
			String  createName = absPath+"/koubei/list/"+productId+".htm";
				
			freemarkerUtils.generate("/koubei/listDetail.htm", root, createName ,request);

		}
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}

%>