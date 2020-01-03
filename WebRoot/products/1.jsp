<%@page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Random"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@taglib uri="/WEB-INF/oscache.tld" prefix="cache"%>
<% 
	String year = CommonString.getFormatPara(request.getParameter("year"));
	String catalog = CommonString.getFormatInt(request.getParameter("catalog")).toString();
	String inner = CommonString.getFormatInt(request.getParameter("inner")).toString();
	String ton = CommonString.getFormatPara(request.getParameter("t"));
    String m = CommonString.getFormatPara(request.getParameter("m"));
	String state = CommonString.getFormatPara(request.getParameter("state"));
	String keyword="";
	String source = CommonString.getFormatPara(request.getParameter("source"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	tonandmeter=tonandmeter.replace("loader_3_01","");
	String factoryid = CommonString.getFormatInt(request.getParameter("factoryid")).toString();
	String factory = CommonString.getFormatInt(request.getParameter("factory")).toString();
	String c=CommonString.getFormatPara(request.getParameter("c"));
	String f=CommonString.getFormatPara(request.getParameter("f"));
	String tont=CommonString.getFormatPara(request.getParameter("ton"));
	Map proParamMap = (Map) application.getAttribute("proParamMap");
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	if(offset.equals("")){offset="0";}
 	if(catalog.equals("107003")){catalog="107012";}
	if(catalog.equals("107001")){catalog="107011";}
	if(catalog.equals("107005")){catalog="107018";}
	if((!c.equals("")&&!c.equals("0"))&&(catalog.equals("")||catalog.equals("0"))){catalog=c;}
	if((!f.equals("")&&!f.equals("0"))&&(factory.equals("")||factory.equals("0"))){factory=f;}
	if((!tont.equals("")&&!tont.equals("0"))&&(tonandmeter.equals("")||tonandmeter.equals("0"))){tonandmeter=tont;}	
  	if(m.equals("yy")){catalog="101001001";}
	String catalogName="";String catalog_first="";String catalog_detail="";String factoryNames="";
	if(catalog.length()>6){catalog_detail=catalog.substring(0,6);}else{catalog_detail=catalog;}
	catalog = CommonString.getFilterStr(catalog);
	if(catalog.equals("0")){ catalog = ""; }
	Map brandMap = (Map) application.getAttribute("brandMap");
	Map brandProMap=(Map)application.getAttribute("brandProMap");
	Map cataProMap=(Map)application.getAttribute("cataProMap");
	Map catalogMap3=(Map)application.getAttribute("catalogMap3");
	//顶级类别
	List <Map>topCatalogList=(List <Map>)application.getAttribute("topCatalogList");
	if(topCatalogList!=null){
		Map map1= new HashMap();
		map1.put("num","101005001");
		map1.put("name","铲运机");
        topCatalogList.add(7,map1);
		Map map2= new HashMap();
		map2.put("num","101005002");
		map2.put("name","平地机");
        topCatalogList.add(8,map2);
		Map map3= new HashMap();
		map3.put("num","102007");
		map3.put("name","汽车吊");
        topCatalogList.add(9,map3);
	}
	if(brandProMap==null){brandProMap=new HashMap();}
	if(cataProMap==null){cataProMap=new HashMap();}
	Map seoTitleKeywordMapNew = (HashMap)application.getAttribute("seoTitleKeywordMapNew") ;
	if(catalog.indexOf("10500315")!=-1){Common.do301(response,"/products/prolist.jsp?catalog=105003") ;}
	String factoryids= CommonString.getFormatPara(request.getParameter("factoryids"));
	String  factoryArray[]=null;
	if(!factoryids.equals("")){factoryArray=factoryids.split(",");}
	if(factory.equals("0")){factory = "";}
	if(factoryid.equals("0")){factoryid = "";}
	if (!"".equals(factory)) {  factoryid = factory;}
	DBHelper dbHelper = DBHelper.getInstance();
	String order = CommonString.getFormatPara(request.getParameter("order"));
	String province = "";
	String city = "";
	int pageSize=15;
	Connection connection = null;
	if (catalog.equals("101003")&&tonandmeter.equals("grab_1_120")) {	
	    DBHelper.freeConnection(connection);
		response.setStatus(301);
		response.setHeader("Location", "http://product.21-sun.com/products/prolist.jsp?catalog=101003"); 
		return;	
	}
	try{
		String showtonandmeter = "";
        if ("g_0_6".equals(tonandmeter)) {
			showtonandmeter = "微挖(3吨以下)";
			tonandmeter="g_0_4";
		}else if ("g_1_13".equals(tonandmeter)) {
			showtonandmeter = "小挖(4吨~8吨)";
			tonandmeter="g_4_8";
		} else if ("g_14_30".equals(tonandmeter)) {
			showtonandmeter = "中挖(15吨~25吨)";
			tonandmeter="g_15_25";
		} else if ("g_30_1".equals(tonandmeter)) {    
			showtonandmeter = "大挖(35吨以上)";
			tonandmeter="g_35_1";
		} else if ("l_1_3".equals(tonandmeter)) {
			showtonandmeter = "3吨以下";
			tonandmeter="l_0_3";
		} else if ("l_3_01".equals(tonandmeter)) {
			showtonandmeter = "3吨";
		} else if ("l_3_5".equals(tonandmeter)) {
			showtonandmeter = "3吨~5吨";
		} else if("l_5_1".equals(tonandmeter)){
			showtonandmeter = "5吨以上";
		} else if ("c_1_16".equals(tonandmeter)) {
			showtonandmeter = "16吨以下";
		} else if ("c_20_70".equals(tonandmeter)) {
			showtonandmeter = "20吨~70吨";
		} else if ("c_70_1".equals(tonandmeter)) {
			showtonandmeter = "70吨以上";
		} else if ("r_0_10".equals(tonandmeter)) {
			showtonandmeter = "10吨以下";
		}  else if ("r_12_18".equals(tonandmeter)) {
			showtonandmeter = "12吨~18吨";
		}  else if ("r_20_01".equals(tonandmeter)) {
			showtonandmeter = "20吨";
		}  else if ("r_20_1".equals(tonandmeter)) {
			showtonandmeter = "20吨以上";
		}  else if ("d_0.5_1".equals(tonandmeter)) {
			showtonandmeter = "0.5~1";
		}  else if ("d_0.8_1.8".equals(tonandmeter)) {
			showtonandmeter = "0.8~1.8";
		}  else if ("d_1_2.5".equals(tonandmeter)) {
			showtonandmeter = "1~2.5";
		}else if ("l_0_36".equals(tonandmeter)) {
			showtonandmeter = "36米以下";
		}  else if ("l_36_44".equals(tonandmeter)) {
			showtonandmeter = "36-44米";
		}  else if ("l_45_47".equals(tonandmeter)) {
			showtonandmeter = "45-47米";
		}  else if ("l_48_52".equals(tonandmeter)) {
			showtonandmeter = "48-52米";
		}  else if ("l_53_56".equals(tonandmeter)) {
			showtonandmeter = "53-56米";
		}  else if ("l_56_1".equals(tonandmeter)) {
			showtonandmeter = "56米以上";
		} else if ("g_8_15".equals(tonandmeter)) {
			showtonandmeter = "中小挖";
		} else if ("g_25_35".equals(tonandmeter)) {
			showtonandmeter = "中大挖";
		} else {
			showtonandmeter = "";
		}
		if ("grab_1_13".equals(tonandmeter)) {
			showtonandmeter = "小挖(1T~13T)";
		} else if ("grab_14_30".equals(tonandmeter)) {
			showtonandmeter = "中挖(14T~30T)";
		} else if ("grab_30_1".equals(tonandmeter)) {    
			showtonandmeter = "大挖(30T以上)";
		} else if ("loader_1_3".equals(tonandmeter)) {
			showtonandmeter = "3T以下";
		} else if ("loader_3_01".equals(tonandmeter)) {
			showtonandmeter = "3T";
		} else if ("loader_3_5".equals(tonandmeter)) {
			showtonandmeter = "3T~5T";
		} else if("loader_5_1".equals(tonandmeter)){
			showtonandmeter = "5T以上";
		}else if ("crane_1_16".equals(tonandmeter)) {
			showtonandmeter = "16T以下";
		} else if ("crane_20_70".equals(tonandmeter)) {
			showtonandmeter = "20T~70T";
		} else if ("crane_70_1".equals(tonandmeter)) {
			showtonandmeter = "70T以上";
		}
		Map catalogMap = (Map) application.getAttribute("catalogMap");
		catalogMap.put("104002012","其他环卫机械");
		catalogMap.put("119001","其他煤炭机械");
		catalogMap.put("103015","水泥运输车");
		catalogMap.put("104002","其他养护机械");
		catalogMap.put("105017","强夯机液压步履式桩架");
		catalogMap.put("103005002","布料机");
		catalogMap.put("103002","混凝土搅拌站");
		catalogMap.put("103018","拖泵");
		catalogMap.put("103001","泵车");
		catalogMap.put("103019","混凝土搅拌车");
		catalogMap.put("103018001","柴油拖泵");
		catalogMap.put("103018002","电动拖泵");
		catalogMap.put("101001001","履带式挖掘机");
		catalogMap.put("102008","履带式起重机");
		catalogMap.put("101003001","履带式推土机");
		catalogMap.put("101002008","挖掘装载机(两头忙)");
		catalogMap.put("104002011","路面破碎机");
		catalogMap.put("140","属具");
		brandMap.put("16941","湃力");
        seoTitleKeywordMapNew.put("140","属具");
		seoTitleKeywordMapNew.put("123","动力设备");
		seoTitleKeywordMapNew.put("123001","发电机");
		seoTitleKeywordMapNew.put("123002","空压机");
		StringBuffer whereStr = new StringBuffer(" and is_show=1 ");		
		List<String> filterQuery = new ArrayList<String>(0);
		SolrQuery query = new SolrQuery();
        query.setQuery("*:*");	
		//条件
		//拆分吨位
		String[] parttonandmeters = null;
		String firsttonandmeter = "";
		String sectonandmeter = "";
		if (!"".equals(tonandmeter) && !"undefined".equals(tonandmeter)) {
			parttonandmeters = tonandmeter.split("_");
			firsttonandmeter = parttonandmeters[1];
			sectonandmeter = parttonandmeters[2];	
			if ("0".equals(parttonandmeters[2])) {

			} else if ("1".equals(parttonandmeters[2])) {
				filterQuery.add("tonandmeter:{"+ firsttonandmeter +"f TO * }");
			} else if ("01".equals(parttonandmeters[2])) {
				filterQuery.add("tonandmeter:"+firsttonandmeter);
			} else {
				if(firsttonandmeter.equals("0")){
				filterQuery.add("tonandmeter:["+ firsttonandmeter +"f TO "+ parttonandmeters[2] +"f }");	
				}else{
				filterQuery.add("tonandmeter:["+ firsttonandmeter +"f TO "+ parttonandmeters[2] +"f ]");
				}
			}
		}			
	//搜索新	
	String httpUrl = "http://s.21-sun.com:7422/solr/sun21_product";
	HttpSolrServer server = new HttpSolrServer(httpUrl);
	/*接收参数*/
	List<SolrQuery.SortClause> orderList = new ArrayList<SolrQuery.SortClause>();
	orderList.add(SolrQuery.SortClause.desc("orderno"));
	if(order.equals("sale")){orderList.add(SolrQuery.SortClause.desc("inquiryCount"));}
	else if(order.equals("comment")){orderList.add(SolrQuery.SortClause.desc("commentCount"));}
   	else if(order.equals("pricedesc")){}
	else if(order.equals("priceasc")){}
	else{    orderList.add(SolrQuery.SortClause.desc("view_count")); }
	Integer nowPage = 1 ;
    if(!"".equals(offset) && !"0".equals(offset)){   nowPage = Integer.parseInt(offset)/pageSize+1 ; }
	List<String> whereList = new ArrayList<String>();
	/*查询条件*/
	String catalognum_new=catalog;
	if (!"".equals(catalog)) {	 
			catalognum_new=catalog;
			whereStr.append(" and catalognum_new like '%" + catalognum_new + "%'");
			catalogName=CommonString.getFormatPara(catalogMap.get(catalog)).replace("挖掘机械","挖掘机");
			//属具特殊处理
			if(catalognum_new.equals("140")){
				    filterQuery.add("catalognum:101001098 or catalognum:101001099");
            }else{
				 filterQuery.add("catalognum:"+catalognum_new+"*");	
                if ((((!ton.equals(""))||(!"".equals(tonandmeter) && !"undefined".equals(tonandmeter)))&&catalog.indexOf("101001")>=0)||catalog.equals("101001")) {
				    filterQuery.add("-catalognum:101001098");
				    filterQuery.add("-catalognum:101001099");
			    }	
			}			
	}	
	if (!"".equals(factoryid)) {  	whereStr.append(" and factoryid=" + factoryid);	filterQuery.add("factoryid:"+factoryid)	;}
	if (!"".equals(factoryids)) { 
		whereStr.append(" and factoryids=" + factoryids);
	    String factoryids_str="";
	    for(int i=0;i<factoryArray.length;i++){
	        factoryids_str+=CommonString.getFormatPara(factoryArray[i])+" or  ";
			factoryNames+=CommonString.getFormatPara(brandMap.get(CommonString.getFormatPara(factoryArray[i])))+",";
	    }
		factoryids_str=factoryids_str+"0";
		filterQuery.add("factoryid:("+factoryids_str+")")	;
	}
	if (!"".equals(ton)) {  
		filterQuery.add("tonandmeter:"+ton)	;
	}
	if (!"".equals(m)&&!m.equals("yy")) { 
        if(m.equals("220")){ filterQuery.add("tonandmeter: 22 "); }	
		if(m.equals("360")){ filterQuery.add("tonandmeter: 36"); }
		if(m.equals("55")){ filterQuery.add("tonandmeter: 5.5"); }
		if(m.equals("60")){ filterQuery.add("tonandmeter: 6"); }
		if(m.equals("65")){ filterQuery.add("tonandmeter: 6.5"); }
		if(m.equals("70")){ filterQuery.add("tonandmeter: 7"); }
		if(m.equals("85")){ filterQuery.add("tonandmeter: 8.5"); }
	}
	if(year.equals("")){year="1";}
	if(year.equals("1")||year.equals("0")){
		if(year.equals("1")){ filterQuery.add("year: 1 "); }	
		if(year.equals("0")){ filterQuery.add("year: 9999"); }
	}
    /*查询*/	
   	String [] filterArr = new String [filterQuery.size()];
	filterArr = filterQuery.toArray(filterArr);
	query.addFilterQuery(filterArr);	
	query.setRequestHandler("/jereh");
	query.setSorts(orderList);
	query.setRows(pageSize);
	query.setStart((nowPage - 1) * pageSize);
	//query.setParam("hl.fl", "title");
	int totalParts = 0;
	QueryResponse res = server.query(query);
	totalParts = (int)res.getResults().getNumFound();
	if ((CommonString.getFormatPara(brandMap.get(factoryid)).equals("")&&!factoryid.equals("")&&!factoryid.equals("0"))||(CommonString.getFormatPara(catalogMap.get(catalog)).equals("")&&!catalog.equals("")&&!catalog.equals("0"))) {	
	    //DBHelper.freeConnection(connection);
		//response.setStatus(301);
		//response.setHeader("Location", "http://product.21-sun.com/404.htm"); 
		//return;	
	}
	int pageCount =0;
	if(totalParts%pageSize>0){	pageCount=(int)(totalParts/pageSize)+1;
	}else{	pageCount=(int)(totalParts/pageSize);}
	SolrDocumentList products = res.getResults();
	//TDK
	String seoKey="";
	if(catalognum_new.equals("106001")&&!ton.equals("")){ seoKey=ton+"吨";}
	if(catalog.equals("102007")&&!ton.equals("")){ seoKey=ton+"吨"; }
	if(catalognum_new.equals("103001")&&!ton.equals("")){ seoKey=ton+"米"; }
	if(catalognum_new.indexOf("101001")>=0&&!ton.equals("")){ seoKey=ton+"吨"; }
	if(catalognum_new.indexOf("101001")>=0&&!m.equals("")&&!m.equals("yy")){ seoKey=m+""; }
	String newTitle="工程机械";
	String newDesc="工程机械";
	String newTitleEnd="工程机械";
	String keywords1="";String keywords2="";String keywords3="";String keywords4="";String keywords5=""; String keywords6="";
	if(!"".equals(factoryid)){keywords1=CommonString.getFormatPara(brandMap.get(factoryid))+","+CommonString.getFormatPara(brandMap.get(factoryid))+"价格表,"+CommonString.getFormatPara(brandMap.get(factoryid))+"大全,";}
    if(!"".equals(catalog)){keywords2=seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机")+","+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机")+"价格表,"+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机")+"大全,";}
	if(!"".equals(catalog)&&!"".equals(factoryid)){keywords3=CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机")+","+CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机")+"价格表,"+CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机")+"大全,";}
	String newKeyWord=keywords5+keywords4+keywords2+keywords1+keywords3+keywords6;
	newKeyWord=CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机")+","+CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机")+"价格表,"+CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机")+"大全,";
	if("".equals(catalog)&&"".equals(factoryid)){newKeyWord="工程机械,工程机械价格表,工程机械产品大全";}
	if(newKeyWord.equals("")){newKeyWord="工程机械,工程机械价格表,工程机械产品大全";}
	else if(newKeyWord.endsWith(",")){newKeyWord=newKeyWord.substring(0,newKeyWord.length()-1);}
	if(!"".equals(factoryid)&&!"".equals(catalog)){
		newTitle=seoKey+keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"))+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机");
		newDesc=("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"))+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机");
		newTitleEnd=keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特"))+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机");
	}else if(!"".equals(factoryid)||!"".equals(catalog)){
		newTitle=seoKey+keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机");
		newDesc=("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机");
		if("".equals(catalog)){
		   	newTitleEnd=keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机")+"产品";
		}else{
		   	 newTitleEnd=keyword+showtonandmeter +("".equals(factoryid) ? "" : CommonString.getFormatPara(brandMap.get(factoryid)))+seoKey+CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机");
		}
	}
	if(!showtonandmeter.equals("")&&showtonandmeter.indexOf("grab")>=0){
		newTitle=seoKey+newTitle.replace(CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机"),"");
		newTitleEnd=newTitleEnd.replace(CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("挖掘机械","挖掘机"),"");
	}
	if(!ton.equals("")){ newTitle=newTitle.replace("汽车起重机","汽车吊"); newTitleEnd=newTitleEnd.replace("汽车起重机","汽车吊"); newKeyWord=newKeyWord.replace("汽车起重机","汽车吊"); newDesc=newDesc.replace("汽车起重机","汽车吊");}
	if(!ton.equals("")){ newTitle=newTitle.replace("混凝土泵车","泵车"); newTitleEnd=newTitleEnd.replace("混凝土泵车","泵车"); newKeyWord=newKeyWord.replace("混凝土泵车","泵车"); newDesc=newDesc.replace("混凝土泵车","泵车");}
	if("102007".equals(catalog)){
		if(factoryid.equals("209")||factoryid.equals("189")||factoryid.equals("133")||factoryid.equals("134")||factoryid.equals("136")){
			newTitle=newTitle.replace("汽车起重机","汽车吊");
		    newTitleEnd=newTitleEnd.replace("汽车起重机","汽车吊");
			newKeyWord=newKeyWord.replace("汽车起重机","汽车吊");
		    newDesc=newDesc.replace("汽车起重机","汽车吊");
		}
	}
	if(m.equals("yy")){newKeyWord=newKeyWord.replace("履带挖掘机","液压挖掘机"); newDesc=newDesc.replace("履带挖掘机","液压挖掘机");newTitle=newTitle.replace("履带挖掘机","液压挖掘机");}
	if(ton.equals("3")&&catalog.equals("101002")){ newKeyWord="30装载机,30铲车,3吨装载机";}
	if(ton.equals("5")&&catalog.equals("101002")){ newKeyWord="50装载机,50铲车,5吨装载机";}
	if(catalog.equals("101001")&&tonandmeter.equals("g_4_8")&&factory.equals("")&&factoryids.equals("")){newDesc=newDesc.replace("挖掘机","小型挖掘机");	newTitle=newTitle.replace("挖掘机","小型挖掘机");}
	if(catalog.equals("106001001")&&tonandmeter.equals("r_0_10")&&factory.equals("")&&factoryids.equals("")){ newDesc=newDesc.replace("单钢轮压路机","小型压路机"); newTitle=newTitle.replace("单钢轮压路机","小型压路机");}
	if(catalog.equals("101002")&&tonandmeter.equals("l_5_1")&&factory.equals("")&&factoryids.equals("")){ newDesc=newDesc.replace("装载机","大型装载机"); newTitle=newTitle.replace("装载机","大型装载机");}
	if(catalog.equals("105003")&&tonandmeter.equals("d_0.5_1")&&factory.equals("")&&factoryids.equals("")){ newDesc=newDesc.replace("旋挖钻机","小型旋挖钻机"); newTitle=newTitle.replace("旋挖钻机","小型旋挖钻机");}
	if(catalognum_new.equals("102007")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")&&ton.equals("")){  newKeyWord="汽车起重机,汽车吊";}
	if(catalognum_new.equals("102006")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){ newKeyWord=newKeyWord.replace("随车起重机","随车吊"); newDesc=newDesc.replace("随车起重机","随车吊"); newTitle=newTitle.replace("随车起重机","随车吊");  newTitleEnd=newTitleEnd.replace("随车起重机","随车吊");}
	if(catalognum_new.equals("101001")&&tonandmeter.equals("g_0_4")&&factory.equals("")&&factoryids.equals("")){  newKeyWord="微挖,微型挖掘机,迷你小挖机,挖掘机";}
	if(catalognum_new.equals("101002008")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){  newKeyWord="两头忙,挖掘装载机";}
	if(catalognum_new.equals("101001004")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){  newKeyWord="轮挖,轮式挖掘机,挖掘机"; }
    if(catalognum_new.equals("101002")&&tonandmeter.equals("l_0_3")&&factory.equals("")&&factoryids.equals("")){ newKeyWord="小装,小型装载机,小铲车"; }
	if(catalognum_new.equals("101001")&&tonandmeter.equals("g_30_1")&&factory.equals("")&&factoryids.equals("")){  newKeyWord="大型挖掘机,矿用挖掘机,挖掘机";}
	if(catalognum_new.equals("101001")&&tonandmeter.equals("")&&factory.equals("174")&&factoryids.equals("")){ newKeyWord="卡特挖掘机,卡特彼勒挖掘机"; }
	if(catalognum_new.equals("106001001")&&tonandmeter.equals("r_0_10")&&factory.equals("")&&factoryids.equals("")){  newKeyWord="小型压路机";	newTitle="小型压路机";}
	if(catalognum_new.equals("101002")&&tonandmeter.equals("l_5_1")&&factory.equals("")&&factoryids.equals("")){   newKeyWord="大型装载机";	newTitle="大型装载机";}
	if(catalognum_new.equals("105003")&&tonandmeter.equals("d_0.5_1")&&factory.equals("")&&factoryids.equals("")){  newKeyWord="小型旋挖钻机";newTitle="小型旋挖钻机";}
	if(catalognum_new.equals("101001")&&tonandmeter.equals("g_0_4")&&factory.equals("")&&factoryids.equals("")){  newTitle="微型挖掘机";}
	if(catalognum_new.equals("101002008")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){newTitle="两头忙";}
	if(catalognum_new.equals("101001")&&tonandmeter.equals("g_35_1")&&factory.equals("")&&factoryids.equals("")){ newTitle="大型挖掘机"; }
	if(catalognum_new.equals("101001")&&tonandmeter.equals("g_4_8")&&factory.equals("")&&factoryids.equals("")){ newTitle="小型挖掘机"; newKeyWord="小型挖掘机"; }
	if(catalognum_new.equals("101002")&&tonandmeter.equals("l_0_3")&&factory.equals("")&&factoryids.equals("")){ newTitle="小型装载机"; }
	//厂家品牌
	List<Map> brandList=null;
	//二级
	Map bb = (Map) application.getAttribute("catalogMap4");
	//品牌
	Map cc = (Map) application.getAttribute("brandLetterList");
    brandList=(List)(cc.get(catalognum_new));
	if(brandList==null){
		 brandList=(List)(cc.get("000"));
	}
	//该类别子类别
 	List<Map> catalogSecondList=null;
	catalogSecondList=(List)(bb.get(catalogMap3.get(catalog)));
	//品牌到类别
	Map catalogFromBrandMap = (Map) application.getAttribute("CatalogFromBrandMap");
	if(catalogFromBrandMap==null){catalogFromBrandMap=new HashMap();}
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<meta name="renderer" content="webkit">
<%if(catalognum_new.equals("101001")&&tonandmeter.equals("g_0_4")&&factory.equals("")&&factoryids.equals("")){%>
<title>【微型挖掘机】微挖/迷你小挖机/微型挖掘机价格表_挖掘机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002008")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){%>
<title>【挖掘装载机】两头忙/挖掘装载机价格表_两头忙型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101001004")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){%>
<title>【轮式挖掘机】轮挖/轮式挖掘机价格表_挖掘机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&tonandmeter.equals("l_0_3")&&factory.equals("")&&factoryids.equals("")){%>
<title>【小型装载机】小装/小铲车/小型装载机价格表_小型装载机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101001")&&tonandmeter.equals("g_35_1")&&factory.equals("")&&factoryids.equals("")){%>
<title>【大型挖掘机】矿用挖掘机/大型挖掘机价格表_挖掘机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101001")&&factory.equals("174")&&tonandmeter.equals("") ){%>
<title>【卡特挖掘机】卡特彼勒挖掘机/卡特挖掘机价格表_型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&ton.equals("3")){%>
<title>【30装载机】30铲车/3吨装载机/30装载机价格表_装载机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&ton.equals("5")){%>
<title>【50装载机】50铲车/5吨装载机/50装载机价格表_装载机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101001")&&ton.equals("20")){%>
<title>【200挖掘机】20吨挖掘机/200挖掘机价格表_挖掘机型号大全 - 铁臂商城</title>
<%}else if(m.equals("yy")){%>
<title>【液压挖掘机】液压挖掘机价格表_挖掘机型号大全 - 铁臂商城</title>
<%}else if(catalog.equals("101001")&&tonandmeter.equals("g_4_8")&&factory.equals("")&&factoryids.equals("")){%>
<title>【小型挖掘机】小型挖掘机价格表_挖掘机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("106001001")&&tonandmeter.equals("r_0_10")&&factory.equals("")&&factoryids.equals("")){%>
<title>【小型压路机】小型压路机价格表_压路机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&tonandmeter.equals("l_5_1")&&factory.equals("")&&factoryids.equals("")){%>
<title>
【大型装载机】大型装载机价格表_装载机型号大全 - 铁臂商城/title>
<%}else if(catalognum_new.equals("105003")&&tonandmeter.equals("d_0.5_1")&&factory.equals("")&&factoryids.equals("")){%>
<title>【小型旋挖钻机】小型旋挖钻机价格表_旋挖钻机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("102007")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")&&ton.equals("")){%>
<title>【汽车起重机】汽车吊/汽车起重机价格表_汽车起重机型号大全 - 铁臂商城</title>
<%}else{%>
<title>【<%=newTitle%>】<%=newTitle%>价格表_<%=newTitle%>型号大全 - 铁臂商城</title>
<%}%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%if(catalognum_new.equals("101001")&&tonandmeter.equals("g_0_4")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="keywords" content="微型挖掘机,微型挖掘机价格,微挖价格,微挖型号,迷你小挖机查询" />
<%}else if(catalognum_new.equals("101002008")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="keywords" content="挖掘装载机,挖掘装载机价格,两头忙价格,两头忙型号,挖掘装载机查询" />
<%}else if(catalognum_new.equals("101001004")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="keywords" content="轮式挖掘机,轮式挖掘机价格,轮挖价格,轮挖型号,轮式挖掘机查询" />
<%}else if(catalognum_new.equals("101002")&&tonandmeter.equals("l_0_3")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="keywords" content="小型装载机,小型装载机价格,小装价格,小装型号,小铲车查询" />
<%}else if(catalognum_new.equals("101001")&&tonandmeter.equals("g_35_1")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="keywords" content="大型挖掘机,大型挖掘机价格,矿用挖掘机价格,矿用挖掘机型号,挖掘机查询" />
<%}else if(catalognum_new.equals("101001")&&factory.equals("174")&&tonandmeter.equals("") ){%>
<meta name="keywords" content="卡特挖掘机,卡特挖掘机价格,卡特彼勒挖掘机价格,卡特彼勒挖掘机型号,卡特挖掘机查询" />
<%}else if(catalognum_new.equals("101002")&&ton.equals("3")){%>
<meta name="keywords" content="30装载机,3吨装载机价格,30装载机价格,30装载机型号,3吨装载机查询" />
<%}else if(catalognum_new.equals("101002")&&ton.equals("5")){%>
<meta name="keywords" content="50装载机,5吨装载机价格,50装载机价格,50装载机型号,5吨装载机查询" />
<%}else if(catalognum_new.equals("101001")&&ton.equals("20")){%>
<meta name="keywords" content="200挖掘机,200挖掘机价格,20吨挖掘机价格,20吨挖掘机型号,200挖掘机查询" />
<%}else if(m.equals("yy")){%>
<meta name="keywords" content="液压挖掘机,液压挖掘机价格,液压挖掘机型号,液压挖掘机查询" />
<%}else if(catalog.equals("101001")&&tonandmeter.equals("g_4_8")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="keywords" content="小型挖掘机,小型挖掘机价格,小型挖掘机型号,小型挖掘机查询" />
<%}else if(catalognum_new.equals("106001001")&&tonandmeter.equals("r_0_10")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="keywords" content="小型压路机,小型压路机价格,小型压路机型号,小型压路机查询" />
<%}else if(catalognum_new.equals("101002")&&tonandmeter.equals("l_5_1")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="keywords" content="大型装载机,大型装载机价格,大型装载机型号,大型装载机查询" />
<%}else if(catalognum_new.equals("105003")&&tonandmeter.equals("d_0.5_1")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="keywords" content="小型旋挖钻机,小型旋挖钻机价格,小型旋挖钻机型号,小型旋挖钻机查询" />
<%}else if(catalognum_new.equals("102007")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")&&ton.equals("")){%>
<meta name="keywords" content="汽车起重机,汽车起重机价格,汽车吊型号,汽车吊查询" />
<%}else{%>
<meta name="keywords" content="<%=newTitle%>,<%=newTitle%>价格,<%=newTitle%>型号,<%=newTitle%>查询" />
<%}%>
<%if(catalognum_new.equals("101001")&&tonandmeter.equals("g_0_4")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="description" content="铁臂商城,提供2018最新微型挖掘机,微挖价格查询,包含全部品牌的微挖型号,迷你小挖机报价及本地报价优惠信息查询,最微型挖掘机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101002008")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="description" content="铁臂商城,提供2018最新挖掘装载机,两头忙价格查询,包含全部品牌的两头忙型号、挖掘装载机报价及本地报价优惠信息查询,最新挖掘装载机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101001004")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="description" content="铁臂商城,提供2018最新轮式挖掘机,轮挖价格查询,包含全部品牌的轮挖型号,轮式挖掘机报价及本地报价优惠信息查询,最新轮式挖掘机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101002")&&tonandmeter.equals("l_0_3")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="description" content="铁臂商城,提供2018最新小型装载机,小型装载机价格查询,包含全部品牌的小装型号、小铲车报价及本地报价优惠信息查询,最新小型装载机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101001")&&tonandmeter.equals("g_35_1")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="description" content="铁臂商城,提供2018最新大型挖掘机,大型挖掘机价格查询,包含全部品牌的矿用挖掘机型号、挖掘机报价及本地报价优惠信息查询,最新大型挖掘机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101001")&&factory.equals("174")&&tonandmeter.equals("") ){%>
<meta name="description" content="铁臂商城,提供2018最新卡特彼勒挖掘机价格查询,包含全部品牌的卡特彼勒挖掘机型号、卡特挖掘机报价及本地报价优惠信息查询,最新卡特挖掘机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101002")&&ton.equals("3")){%>
<meta name="description" content="铁臂商城,提供2018最新30装载机价格查询,包含全部品牌的3吨装载机型号,30铲车报价及本地报价优惠信息查询,最新30装载机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101002")&&ton.equals("5")){%>
<meta name="description" content="铁臂商城,提供2018最新50装载机价格查询,包含全部品牌的3吨装载机型号,50铲车报价及本地报价优惠信息查询,最新50装载机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101001")&&ton.equals("20")){%>
<meta name="description" content="铁臂商城,提供2018最新200挖掘机价格查询,包含全部品牌的20吨挖掘机型号,200挖掘机报价及本地报价优惠信息查询,最新20吨挖掘机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(m.equals("yy")){%>
<meta name="description" content="铁臂商城,提供2018最新液压挖掘机价格查询,包含全部品牌的液压挖掘机型号,报价及本地报价优惠信息查询,最新液压挖掘机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalog.equals("101001")&&tonandmeter.equals("g_4_8")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="description" content="铁臂商城,提供2018最新小型挖掘机价格查询,包含全部品牌的小型挖掘机型号,报价及本地报价优惠信息查询,最新小型挖掘机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("106001001")&&tonandmeter.equals("r_0_10")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="description" content="铁臂商城,提供2018最新小型压路机价格查询,包含全部品牌的小型压路机型号,报价及本地报价优惠信息查询,最新小型压路机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101002")&&tonandmeter.equals("l_5_1")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="description" content="铁臂商城,提供2018最新大型装载机价格查询,包含全部品牌的大型装载机型号,报价及本地报价优惠信息查询,最新大型装载机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("105003")&&tonandmeter.equals("d_0.5_1")&&factory.equals("")&&factoryids.equals("")){%>
<meta name="description" content="铁臂商城,提供2018最新小型旋挖钻机价格查询,包含全部品牌的小型旋挖钻机型号,报价及本地报价优惠信息查询,最新小型旋挖钻机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("102007")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")&&ton.equals("")){%>
<meta name="description" content="铁臂商城,提供2018最新汽车吊价格查询,包含全部品牌的汽车起重机型号,汽车吊报价及本地报价优惠信息查询,最新汽车吊报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else{%>
<meta name="description" content="铁臂商城提供2018最新<%=newDesc%>厂家报价、<%=newDesc%>报价查询,包含全部品牌的<%=newDesc%>型号及全国报价优惠信息查询,最新<%=newDesc%>报价信息尽在铁臂商城.[欢迎询低价]" />
<%}%>
<meta name="mobile-agent" content="format=html5;url=http://m.21-sun.com/product/p_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>_0.htm">
<script type="text/javascript" src="/Static/app/mobile.js"></script>
<script type="text/javascript">uaredirect("http://m.21-sun.com/product/p_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>_0.htm");</script>
<link href="/Static/grid/grid12.css" rel="stylesheet" />
<link href="/Static/css/ui.css" rel="stylesheet" />
<link href="/Static/css/common.css" rel="stylesheet" />
<link href="/Static/css/style.css" rel="stylesheet" />
<link href="http://www.21-sun.com/css/topbar_new.css" rel="stylesheet">
<%if(order.equals("normal")){%>
<%if(!catalog.equals("")&&!factoryid.equals("")){%>
<link rel="canonical" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factoryid%>&catalog=<%=catalog%>"/>
<%}else if(!factoryid.equals("")){%>
<link rel="canonical" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factoryid%>"/>
<%}else if(!catalog.equals("")){%>
<link rel="canonical" href="http://product.21-sun.com/products/prolist.jsp?catalog=<%=catalog%>"/>
<%}}else{%>
<%if(tont.equals("")&&ton.equals("")&&m.equals("")){%>
<%if(!catalog.equals("")&&!factoryid.equals("")){%>
<link rel="canonical" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factoryid%>&catalog=<%=catalog%>"/>
<%}else if(!factoryid.equals("")){%>
<link rel="canonical" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factoryid%>"/>
<%}else if(!catalog.equals("")){%>
<link rel="canonical" href="http://product.21-sun.com/products/prolist.jsp?catalog=<%=catalog%>"/>
<%}%>
<%}%>
<%}%>
<!--[if lt IE 9]><script src="/Static/lib/H5shiv.js"></script>
<![endif]-->
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?998e4dbd9441f628020df509fd0e9f3c";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
<style>
.txd_nleft {
	width: 228px;
}
.list04 ul li {
	height: 20px;
	float: left;
	border-right: #d8d8d8 0px solid;
	padding: 0px 22px;
}
.kind0518 {
	background-color:#ececec;
	float:  right;
	height:  30px;
	margin-top:  6px;
	line-height:  30px;
	width: 93px;
	text-align:  center;
	box-sizing:  border-box;
	border: #e0e0e0 1px solid;
	border-right: none;
}
.kind0518c {
	background-color: #fff;
	width: 94px;
	height:0;
	margin-top: -1px;
	margin-left: -1px;
	overflow:  hidden;
	background-color:#f5f5f5;
}
.kind0518cc {
	display:block;
	border: #e0e0e0 1px solid;
	border-top: none;
}
.txd_nmain #main1 {
	position: relative;
	z-index: 100;
}
.kind0518:hover .kind0518c {
	height:auto;
}
.kind0518cc:hover {
	color:#ff9900;
}
.kind0518, .kind0518cc {
	cursor:pointer;
}
.attr_brand ul li {
	margin:2px;
	width:105px;
	height:25px;
}
.attr_brand ul li img {
	display:none;
}
.attr_brand ul li.br01 {
	height:25px;
	border-color:transparent;
	color:#806f66;
}
.attr_brand ul li.br01 a {
	height:25px;
	color:#806f66;
}
.attr_brand ul li.br01 a:hover {
	border-color:#ff7700;
	color:#ff7700;
	background-color:#fff;
}
.attr_brand ul li.br02 {
	height:25px;
	border-color:transparent;
	color:#806f66;
}
.attr_brand ul li.br02 a {
	height:25px;
	color:#806f66;
}
.attr_brand ul li.br02 a:hover {
	border-color:#1369c0;
	color:#1369c0;
	background-color:#fff;
}
.attr_brand ul li a {
	line-height:25px;
	font-size:13px;
	font-family:Arial;
	width:auto;
	display:block;
}
.attr_brand ul li .m, .attr_brand ul li .s {
	display:block;
	white-space:nowrap;
	text-overflow:ellipsis;
	overflow:hidden;
}
.attr_brand ul li .m {
	padding-top:0px;
}
.n_top {
	position:relative;
}
.n_wechat {
	float:right;
	position:absolute;
	right:0;
	top:5px;
	width:81px;
	height:84px;
	border:#f1f1f1 solid 1px;
}
.n_wechat span {
	display:block;
	position:absolute;
	right:81px;
	top:0;
	width:100px;
	padding-top:18px;
	padding-right:4px;
	font-size:13px;
	color:#ff9400;
	line-height:24px;
}
.txd_sx_plist li .tsx_pnr {
	width: 570px;
}
.txd_sx_plist li .tsx_pnr b {
	font-size: 12px;
	font-weight: normal;
	color: #6666dd;
	margin-right: 10px;
}
.listMode li .tsx_pprice a {
	width:100px;
	font-size:18px;
}
.listMode li .tsx_duibi0726 {
	right: 130px;
}
.listMode li .tsx_duibi0726 a {
	font-size: 16px;
	background-color: transparent;
	color: #555;
	border-color: #ccc;
}
.listMode li .tsx_duibi0726 a:hover {
	color:#fff;
	border-color:#fe6005;
	background-color:#fe6005;
}

.txd_sx_plist li .txs_psum{
	max-width:500px;
}
 
.listMode li:hover .tsx_duibi0726 a{color:#555;border-color:#ccc;background-color:transparent;}
.listMode li.active .tsx_duibi0726 a{color:#555;border-color:#ccc;background-color:transparent;}
.listMode li .tsx_duibi0726 a:hover{color:#555;border-color:#ccc;background-color:transparent;}

</style>
</head>
<body>
<!--top-->
<!--topBar-->
<div class="topbar tb-topbar">
  <div class="wrap fix">
    <div class="wel l"><span class="l">欢迎您访问中国工程机械商贸网！</span>
      <ul class="l">
        <li><a href="http://member.21-sun.com/member_login.jsp" target="_blank">[登录]</a></li>
        <li><a href="http://member.21-sun.com/member_reg.jsp" target="_blank">[注册]</a></li>
      </ul>
    </div>
    <div class="sun-links r">
      <div class="link-single"><a class="color-ff9400" href="http://toutiao.21-sun.com/" target="_blank">铁臂头条</a></div>
      <div class="links-show links-list net-phone"><a class="has-list" href="javascript:;">手机访问</a>
        <div class="list-box list-m"><span class="over-line"></span>
          <ul class="fix">
            <li class="sun-mainnet"><img src="http://www.21-sun.com/static/images/m_01.jpg" />
              <p><strong>21-SUN</strong><br>
                掌握全局，把握市场商机，行业大千世界，21SUN移网尽收眼底。</p>
            </li>
            <li class="sun-news"><img src="http://www.21-sun.com/static/images/m_02.jpg" />
              <p><strong>行业动态</strong><br>
                洞悉行业千百态，随时随地实时看。全方位解读工程机械，别无他恋。</p>
            </li>
            <li class="sun-mall"><img src="http://www.21-sun.com/static/images/m_03.jpg" />
              <p><strong>铁臂商城</strong><br>
                优惠多，机型全，在齐全的设备库中体验优惠的设备选购快感。</p>
            </li>
          </ul>
        </div>
      </div>
      <div class="links-show links-list wechat-focus"><a class="has-list" href="javascript:;">微信关注</a>
        <div class="list-box list-wechat"><span class="over-line"></span>
          <ul class="fix">
            <li>
              <div class="pic-box l"><img src="http://www.21-sun.com/static/images/shangmao.jpg">
                <p>【扫一扫】</p>
              </div>
              <div class="txt-box r">
                <p>微信名称：<strong>中国工程机械商贸网</strong></p>
                <p>微信号：<strong>www21sun</strong></p>
                <p>它陪伴、见证、服务了工程机械的一个时代、一代又一代的工程机械人。关注21SUN，跟随21SUN，倾听行业的声音，探寻行业的足迹，感受行业的脉搏。探索行业的未来 </p>
              </div>
            </li>
            <li>
              <div class="pic-box l"><img src="http://www.21-sun.com/static/images/tbmall.jpg">
                <p>【扫一扫】</p>
              </div>
              <div class="txt-box r">
                <p>微信名称：<strong>铁臂商城</strong></p>
                <p>微信号：<strong>TIEBIMALL</strong></p>
                <p>如何选购机器型号？哪家有优惠活动？设备市场表现怎样？<br>
                  您要知道的，都在这里。<br>
                  设备采购咨询热线：4006-521-526</p>
              </div>
            </li>
            <li>
              <div class="pic-box l"><img src="http://www.21-sun.com/static/images/xdl.jpg">
                <p>【扫一扫】</p>
              </div>
              <div class="txt-box r">
                <p>微信名称：<strong>铁臂兄弟连</strong></p>
                <p>微信号：<strong>tbxdl110</strong></p>
                <p>结识战友，学习互动，提高业务，一起聊聊那些人那些事还有那些机器。这是是咱工程机械战友自己的圈子，新手、老司机、专业大拿，来者不拒。<br>
                  战友QQ群：73915368</p>
              </div>
            </li>
          </ul>
        </div>
      </div>
      <div class="links-show links-list pro-nav show-active"><a class="has-list" href="javascript:;">购机导航</a></div>
      <div class="links-show links-list app-download"><a class="has-list" href="javascript:;">APP下载</a>
        <div class="list-box list-app"><span class="over-line"></span>
          <ul class="fix">
            <li>
              <div class="pic-box l"><img src="http://toutiao.21-sun.com/static/images/app/android.jpg"></div>
              <div class="txt-box">
                <p>微信扫一扫<br>
                  下载iPhone客户端</p>
              </div>
            </li>
            <li>
              <div class="pic-box l"><img src="http://toutiao.21-sun.com/static/images/app/ios.jpg"></div>
              <div class="txt-box">
                <p>微信扫一扫<br>
                  下载Android客户端</p>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="active-bg"></div>
<!--topBar end-->
<!--top-->
<div class="wrap fix n_top">
  <div class="new_logo"><a href="/" title="铁臂商城"><img src="/Static/images/logo.png" alt="铁臂商城"></a></div>
  <div class="n_topSearch">
    <div class="input">
      <input id="keyword" name="keyword" type="text" placeholder="输入您要搜索的产品" >
    </div>
    <button type="button" class="topBtn" onClick="tj3()">搜索</button>
  </div>
  <script>
function tj3(){if(jQuery("#keyword").val()==""){alert("请输入您要搜索的关键词");jQuery("#keyword").focus();return false}var keyword=jQuery("#keyword").val();window.open("http://product.21-sun.com/search/"+keyword+"_0_0_0.htm")}$("#keyword").on("keydown",function(e){if(e.keyCode==13){tj3()}});
</script>
  <div class="n_hotwords"> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001001">挖掘机</a><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002">装载机</a><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102">起重机</a><br>
    <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001">压路机</a><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101005">平地机</a><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp" class="more">更多<i class="ion">&#xe69f;</i></a> </div>
  <div class="n_wechat"><img src="/Static/images/wechat.jpg" alt="铁臂商城手机版"><span>铁臂商城手机版<br>
    购机方便又快捷</span></div>
</div>
<!--top end-->
<!--nav-->
<div class="navBox">
  <div class="navBar">
    <div class="wrap fix">
      <ul class="menu">
        <li><a href="http://product.21-sun.com/">商城首页</a></li>
        <li><a href="http://product.21-sun.com/products/prolist.jsp">设备导购</a></li>
        <li><a target="_blank" href="http://product.21-sun.com/brand/">热销品牌</a></li>
        <li><a rel="nofollow" target="_blank" href="http://product.21-sun.com/agent/">代理商</a></li>
        <li><a href="http://top.21-sun.com/">铁臂指数</a></li>
        <li><a rel="nofollow" target="_blank" href="http://product.21-sun.com/about/qjd.htm">旗舰店</a></li>
        <li><a rel="nofollow" target="_blank" href="http://product.21-sun.com/tuan/">优买团</a></li>
        <li><a rel="nofollow" target="_blank" href="http://product.21-sun.com/3d/">3D展厅</a></li>
      </ul>
      <div class="allCates">
        <div class="acn"><i class="ico ico2_5"></i>全部产品分类</div>
      </div>
    </div>
  </div>
</div>
<!--nav end-->
<!--top end-->
<!--main-->
<div class="txd_nmain">
  <div class="wrap fix listbg">
    <div class="txd_nleft" id="left_condition">
      <div class="allCates_">
        <div class="acn"><i class="ico ico2_5"></i>选机中心</div>
      </div>
      <div class="txd_nlant"></div>
      <div class="txd_filter t_tab">
        <div class="t_tab_val">
          <div class="leftHeight">
            <div class="txd_filter_val">
              <ul class="fix txd_filter_plist txd_filter_plist_cat">
                <li class="<%if(catalog.equals("")||catalog.equals("101001")||catalog.equals("101001001")||catalog.equals("101001004")||catalog.equals("101001007")){%>cur<%}%>"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001"  title="挖掘机">挖掘机</a>
                  <div class="txd_filter_pnc"  style="background-color: white;height:584px">
                    <ul class="fix">
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001001"  title="履带挖掘机">履带挖掘机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001004"  title="轮式挖掘机">轮式挖掘机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001007"  title="特种挖掘机">特种挖掘机</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("140")||catalog.equals("101001099")||catalog.equals("101001098")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=140"  title="属具">属具</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001098"  title="破碎器">破碎器</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001099"  title="液压剪">液压剪</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("101002")||catalog.equals("101002003")||catalog.equals("101002004")||catalog.equals("101002007")||catalog.equals("101002008")||catalog.equals("101002009")||catalog.equals("101002010")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002"  title="装载机">装载机</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002003"  title="履带装载机">履带装载机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002004"  title="特种装载机">特种装载机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002007"  title="轮式装载机">轮式装载机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002008"  title="挖掘装载机">挖掘装载机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002009"  title="滑移装载机">滑移装载机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002010"  title="叉装机">叉装机</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("101003")||catalog.equals("101003001")||catalog.equals("101003004")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003"  title="推土机">推土机</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003001"  title="履带推土机">履带推土机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003004"  title="轮式推土机">轮式推土机</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("101005")||catalog.equals("101005001")||catalog.equals("101005002")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005"  title="平地/铲运机">平地/铲运机</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005001"  title="铲运机">铲运机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005002"  title="平地机">平地机</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("101008")||catalog.equals("101008001")||catalog.equals("101008002")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008"  title="自卸车/矿卡">自卸车/矿卡</a>
                  <div class="txd_filter_pnc"  style="background-color: white;height:584px">
                    <ul class="fix">
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008001"  title="铰接式自卸卡车">铰接式自卸卡车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008002"  title="钢性自卸卡车">钢性自卸卡车</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("102")||catalog.equals("102002")||catalog.equals("102003")||catalog.equals("102006")||catalog.equals("102007")||catalog.equals("102008")||catalog.equals("102011")||catalog.equals("102012")||catalog.equals("102013")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102"  title="起重机">起重机</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102002"  title="塔式起重机">塔式起重机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102003"  title="高空作业车/平台">高空作业车/平台</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102006"  title="随车起重机">随车起重机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102007"  title="汽车起重机">汽车起重机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102008"  title="履带起重机">履带起重机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102011"  title="施工升降机">施工升降机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102012"  title="伸缩臂叉装机">伸缩臂叉装机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102013"  title="龙门/桥梁起重机">龙门/桥梁起重机</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("103")||catalog.equals("103001")||catalog.equals("103002")||catalog.equals("103005")||catalog.equals("103008")||catalog.equals("103015")||catalog.equals("103017")||catalog.equals("103018")||catalog.equals("103019")||catalog.equals("103020")||catalog.equals("103010")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103"  title="混凝土设备">混凝土设备</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001"  title="混凝土泵车">混凝土泵车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103002"  title="混凝土搅拌站/车/楼">混凝土搅拌站</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103005"  title="混凝土布料杆/车">混凝土布料杆/车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103008"  title="砂浆设备">砂浆设备</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103015"  title="其他混凝土设备">其他混凝土设备</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103017"  title="车载泵">车载泵</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103018"  title="拖泵">拖泵</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103019"  title="混凝土搅拌运输车">混凝土搅拌运输车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103020"  title="混凝土输送泵">混凝土输送泵</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103010"  title="喷湿机">喷湿机</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("104")||catalog.equals("104001")||catalog.equals("104002")||catalog.equals("104003")||catalog.equals("104004")||catalog.equals("104005")||catalog.equals("104009")||catalog.equals("104008")||catalog.equals("104006")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104"  title="路面机械">路面机械</a>
                  <div class="txd_filter_pnc"  style="background-color: white;height:584px">
                    <ul class="fix">
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104001"  title="摊铺机">摊铺机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104002"  title="再生/修补机械">再生/修补机械</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104003"  title="开槽机/灌缝机">开槽机/灌缝机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104004"  title="路面破碎机">路面破碎机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104005"  title="铣刨机">铣刨机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104009"  title="沥青搅拌/转运">沥青搅拌/转运</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104008"  title="稳定土厂拌设备">稳定土厂拌设备</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104006"  title="沥青洒布/碎石散布机">沥青洒布机</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("105")||catalog.equals("105003")||catalog.equals("105004")||catalog.equals("105005")||catalog.equals("105007")||catalog.equals("105009")||catalog.equals("105018")||catalog.equals("105027")||catalog.equals("105028")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105"  title="钻机/桩机">钻机/桩机</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105003"  title="旋挖钻机">旋挖钻机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105004"  title="潜孔钻机">潜孔钻机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105005"  title="水平定向钻">水平定向钻</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105007"  title="连续墙设备">连续墙设备</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105009"  title="压桩/打桩机">压桩/打桩机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105018"  title="螺旋钻机">螺旋钻机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105027"  title="其他钻机">其他钻机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105028"  title="截桩机/破桩机">截桩机/破桩机</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("106001")||catalog.equals("106001001")||catalog.equals("106001002")||catalog.equals("106001003")||catalog.equals("106001004")||catalog.equals("106001005")||catalog.equals("106001020")||catalog.equals("106001021")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001"  title="压路机/压实机/夯">压实机械</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001001"  title="单钢轮压路机">单钢轮压路机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001002"  title="双钢轮压路机">双钢轮压路机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001003"  title="三钢轮压路机">三钢轮压路机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001005"  title="轮胎压路机">轮胎压路机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001004"  title="手扶压路机">手扶压路机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001020"  title="压实机">压实机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001021"  title="夯实机">夯实机</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("107")||catalog.equals("107011")||catalog.equals("107012")||catalog.equals("107013")||catalog.equals("107014")||catalog.equals("107015")||catalog.equals("107016")||catalog.equals("107017")||catalog.equals("107018")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107"  title="叉车">叉车</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107011"  title="内燃平衡重叉车">内燃平衡重叉车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107012"  title="电动式叉车">电动式叉车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107013"  title="侧面叉车">侧面叉车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107014"  title="前移">前移</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107015"  title="电动/手动搬运车">电动/手动搬运车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107016"  title="堆垛车/堆高车">堆垛车/堆高车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107017"  title="其他叉车">其他叉车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107018"  title="仓储叉车">仓储叉车</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("109")||catalog.equals("109001")||catalog.equals("109002")||catalog.equals("109004")||catalog.equals("109005")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=109"  title="桥梁机械">桥梁机械</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=109001"  title="架桥机">架桥机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=109002"  title="运梁车">运梁车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=109004"  title="提梁机">提梁机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=109005"  title="检测车">检测车</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("110")||catalog.equals("110001")||catalog.equals("110002")||catalog.equals("110008")||catalog.equals("110009")||catalog.equals("110019")||catalog.equals("110012")||catalog.equals("110013")||catalog.equals("110018")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110"  title="矿山/煤矿机械">矿山/煤矿机械</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110001"  title="盾构机">盾构机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110002"  title="掘进机">掘进机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110008"  title="凿岩车/凿岩钻机">凿岩车/凿岩钻机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110009"  title="矿石破碎机">矿石破碎机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110012"  title="筛分机">筛分机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110013"  title="输送/转载设备">输送/转载设备</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110018"  title="扒渣机">扒渣机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110019"  title="采煤机">采煤机</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("111")||catalog.equals("111001")||catalog.equals("111002")||catalog.equals("111003")||catalog.equals("111004")||catalog.equals("111007")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111"  title="港口机械">港口机械</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111001"  title="正面吊">正面吊</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111002"  title="码头堆高机">码头堆高机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111003"  title="卸船机">卸船机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111004"  title="门式起重机">门式起重机</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111007"  title="推耙机">推耙机</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("118")||catalog.equals("118001")||catalog.equals("118013")||catalog.equals("118004")||catalog.equals("118003")||catalog.equals("118012")||catalog.equals("118005")||catalog.equals("118007")||catalog.equals("118008")||catalog.equals("118009")||catalog.equals("118010")||catalog.equals("118011")||catalog.equals("118002")||catalog.equals("118014")){%>class="cur"<%}%>><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118"  title="专用车辆">专用车辆</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118001"  title="普通载货车">普通载货车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118013"  title="公路牵引车">公路牵引车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118004"  title="场地牵引车">场地牵引车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118003"  title="消防车">消防车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118012"  title="清障车">清障车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118005"  title="冷藏车">冷藏车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118007"  title="粉罐车">粉罐车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118008"  title="油罐车">油罐车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118009"  title="液罐车">液罐车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118010"  title="翻斗车">翻斗车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118011"  title="渣土车">渣土车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118014"  title="半挂车">半挂车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118002"  title="其他专用车">其他专用车</a></li>
                    </ul>
                  </div>
                </li>
                <li <%if(catalog.equals("122")||catalog.equals("122001")||catalog.equals("122002")||catalog.equals("122003")||catalog.equals("122004")||catalog.equals("122005")){%>class="cur"<%}%> style="border-bottom:1px solid #c7c7c7;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122"  title="环卫车辆">环卫车辆</a>
                  <div class="txd_filter_pnc" style="background-color: white;height:584px">
                    <ul class="fix" >
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <br>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122001"  title="扫地车">扫地车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122002"  title="垃圾车">垃圾车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122003"  title="清雪车">清雪车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122004"  title="洒水车">洒水车</a></li>
                      <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122005"  title="污水/粪便车">污水/粪便车</a></li>
                    </ul>
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div class="txd_nlant"></div>
    </div>
    <div class="txd_nright">
      <!--面包屑-->
      <div class="breadCrumbs">我的位置：<a href="/">商城首页</a><em>&gt;&gt;</em><a href="http://product.21-sun.com/products/prolist.jsp" >设备导购</a><em>&gt;&gt;</em><%=newTitle%></div>
      <!--面包屑 end-->
      <!--筛选-->
      <div id="main1">
        <div id="main"  style="background-color:white">
          <div class="filter fix" >
            <div class="filter_hd" style="background-color:white">
              <h1 class="_n">
                <%if(catalog.equals("101002")&&ton.equals("3")){%>
                30装载机
                <%}else if(catalog.equals("101002")&&ton.equals("5")){%>
                50装载机
                <%}else{%>
                <%=newTitle%>
                <%}%>
              </h1>
              <span class="_tip">搜索到<%=totalParts%>件相关商品</span> <span style="float:right;padding-right:10px;display:none" id="show_tj"><a class="on" style="color:#fe6000" href="javascript:void(0)" id="show_select">显示筛选条件</a></span> </div>
            <%if(!factoryid.equals("")||!factoryids.equals("")||!catalog.equals("")||!tonandmeter.equals("")){%>
            <div class="j_Prop attr" id="select_condition">
              <div class="attrKey">已选条件</div>
              <div class="attrValues selectValues">
                <ul class="select_val">
                  <%if(!factoryid.equals("")){%>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%=catalog.equals("")?"":"?catalog="+catalog%>" title="<%=CommonString.getFormatPara(brandMap.get(factoryid))%>">品牌：<strong><%=CommonString.getFormatPara(brandMap.get(factoryid))%></strong></a><b></b></li>
                  <%}%>
                  <%if(!factoryids.equals("")){%>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%=catalog.equals("")?"":"?catalog="+catalog%>" title="<%=factoryNames%>">品牌：<strong><%=factoryNames%></strong></a><b></b></li>
                  <%}%>
                  <%if(!catalog.equals("")){%>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%=factoryid.equals("")?"":"?factory="+factoryid%>" title="<%=CommonString.getFormatPara(catalogMap.get(catalog))%>">类型：<strong><%=CommonString.getFormatPara(catalogMap.get(catalog))%></strong></a><b></b></li>
                  <%}%>
                  <%if(!tonandmeter.equals("")){String showname="吨位";if(catalog_detail.equals("105003")){ showname="直径(m)";}if(catalog_detail.equals("103001")){ showname="臂架长度";}%>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp?catalog=<%=catalog%><%=factoryid.equals("")?"":"&factory="+factoryid%>" title="<%=showtonandmeter%>"><%=showname%>：<strong><%=showtonandmeter%></strong></a><b></b></li>
                  <%}%>
                </ul>
                <%if(!catalog.equals("")||!factoryid.equals("")||!tonandmeter.equals("")||!factoryids.equals("")){%>
                <a href="http://product.21-sun.com/products/prolist.jsp" class="resetFilter"><i class="ion">&#xe70f;</i>重置筛选条件</a>
                <%}%>
              </div>
            </div>
            <%}%>
            <% if(catalog.equals("")){if(factoryid.equals("")&&factoryids.equals("")){if(topCatalogList!=null&&topCatalogList.size()>0){%>
            <div class="j_Prop attr j_Propli" id="select_category">
              <div class="attrKey">产品类别</div>
              <div class="attrValues">
                <ul class="av-collapse" style="visibility:visible;height:auto">
                  <%for(Map oneMap:topCatalogList){%>
                  <li style="margin: 0 10px 10px 0;"><a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span style="color:red">(<%=CommonString.getFormatInt(cataProMap.get(CommonString.getFormatPara(oneMap.get("num"))))%>)</span></a></li>
                  <%}%>
                </ul>
              </div>
            </div>
            <%}}else{%>
            <div class="j_Prop attr j_Propli" id="select_category">
              <div class="attrKey">产品类别</div>
              <div class="attrValues">
                <ul class="av-collapse" style="visibility:visible;height:auto">
                  <%
					    for(Map oneMap:topCatalogList){
					                if(!factoryids.equals("")){
					                    int allSum=0;
						                for(int i=0;i<factoryArray.length;i++){
	                                        if(!CommonString.getFormatPara(factoryArray[i]).equals("")){
								                allSum+=CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(factoryArray[i])+"_"+(CommonString.getFormatPara(oneMap.get("num")))));
							                }
	                                    }
			%>
                  <li style="margin: 0 10px 10px 0;"><a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span style="color:red">(<%=allSum%>)</span></a></li>
                  <%}else if(factoryid.equals("")||factoryid.equals("0")){%>
                  <li style="margin: 0 10px 10px 0;"><a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span style="color:red">(<%=CommonString.getFormatInt(brandProMap.get((CommonString.getFormatPara(oneMap.get("num")))))%>)</span></a></li>
                  <%}else{%>
                  <li style="margin: 0 10px 10px 0;"><a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span style="color:red">(<%=CommonString.getFormatInt(brandProMap.get(factoryid+"_"+(CommonString.getFormatPara(oneMap.get("num")))))%>)</span></a></li>
                  <%}%>
                  <%}%>
                </ul>
              </div>
            </div>
            <%}}%>
            <%if(!catalog.equals("")){if(catalogSecondList!=null&&catalogSecondList.size()>0){%>
            <div class="j_Prop attr j_Propli" id="select_catalog">
              <div class="attrKey">产品类型</div>
              <div class="attrValues">
                <ul class="av-collapse" style="visibility:visible;height:auto">
                  <%for(Map oneMap:catalogSecondList){%>
                  <%  if(!factoryids.equals("")){ int allSum=0; for(int i=0;i<factoryArray.length;i++){ if(!CommonString.getFormatPara(factoryArray[i]).equals("")){ allSum+=CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(factoryArray[i])+"_"+(CommonString.getFormatPara(oneMap.get("num"))))); } }  %>
                  <li><a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span style="color:red">(<%=allSum%>)</span></a></li>
                  <%}else if(factoryid.equals("")){%>
                  <li><a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span style="color:red">(<%=CommonString.getFormatInt(cataProMap.get((CommonString.getFormatPara(oneMap.get("num")))))%>)</span></a></li>
                  <%}else{if(CommonString.getFormatInt(brandProMap.get(factoryid+"_"+(CommonString.getFormatPara(oneMap.get("num")))))!=0){%>
                  <li><a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span style="color:red">(<%=CommonString.getFormatInt(brandProMap.get(factoryid+"_"+(CommonString.getFormatPara(oneMap.get("num")))))%>)</span></a></li>
                  <%}}%>
                  <%}%>
                </ul>
              </div>
            </div>
            <%}}%>
            <%if(catalog.equals("140")){%>
            <div class="j_Prop attr j_Propli" id="select_catalog">
              <div class="attrKey">产品类型</div>
              <div class="attrValues">
                <ul class="av-collapse" style="visibility:visible;height:auto">
                  <li><a title="破碎器" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001098">破碎器<span style="color:red">(<%=CommonString.getFormatInt(cataProMap.get((CommonString.getFormatPara("101001098"))))%>)</span></a></li>
                  <li><a title="液压剪" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001099">液压剪<span style="color:red">(<%=CommonString.getFormatInt(cataProMap.get((CommonString.getFormatPara("101001099"))))%>)</span></a></li>
                </ul>
              </div>
            </div>
            <%}%>
            <%if(catalog.equals("101001")||catalog.equals("101001001")||catalog.equals("101001004")||catalog.equals("101002007")||catalog_detail.equals("102")||catalog_detail.equals("102007")||catalog.equals("106001001")){%>
            <div class="j_Prop attr j_Propli" id="select_tonandmeter">
              <div class="attrKey">吨位</div>
              <div class="attrValues">
                <ul class="av-collapse" style="visibility:visible;">
                  <%if((catalog.equals("101001")||catalog.equals("101001001")||catalog.equals("101001004"))){%>
                  <li style="margin:0 15px 10px 0"><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_0_6">微挖(3T以下)</a></li>
                  <li style="margin:0 15px 10px 0"><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_1_13">小挖(4T～8T)</a></li>
                  <li style="margin:0 15px 10px 0"><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_8_15">中小挖(8T～15T)</a></li>
                  <li style="margin:0 15px 10px 0"><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_14_30">中挖(15T～25T)</a></li>
                  <li style="margin:0 15px 10px 0"><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_25_35">中大挖(25T～35T)</a></li>
                  <li style="margin:0 15px 10px 0"><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_30_1">大挖(35T以上)</a></li>
                  <%} else if(catalog.equals("101001004")){%>
                  <li style="margin:0 15px 10px 0"><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101001004&ton=g_0_6">微挖(3T以下)</a></li>
                  <li style="margin:0 15px 10px 0"><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101001004&ton=g_1_13">小挖(4T～8T)</a></li>
                  <li style="margin:0 15px 10px 0"><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101001004&ton=g_8_15">中小挖(8T～15T)</a></li>
                  <li style="margin:0 15px 10px 0"><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101001004&ton=g_14_30">中挖(15T～25T)</a></li>
                  <%}else if(catalog.equals("101002007")){%>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101002007&ton=l_1_3">小装(3T以下)</a></li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101002007&ton=l_3_01">3T</a></li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101002007&ton=l_3_5">5T</a></li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101002007&ton=l_5_1">5T以上</a></li>
                  <%}else if(catalog_detail.equals("102")){%>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102&ton=c_1_16">16T以下</a> </li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102&ton=c_20_70">20T～70T</a> </li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102&ton=c_70_1">70T以上</a></li>
                  <%}else if(catalog_detail.equals("102007")){%>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102007&ton=c_1_16">16T以下</a> </li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102007&ton=c_20_70">20T～70T</a> </li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102007&ton=c_70_1">70T以上</a></li>
                  <%}else if(catalog.equals("106001001")){%>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=106001001&ton=r_0_10">10T以下</a> </li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=106001001&ton=r_12_18">12T～18T</a> </li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=106001001&ton=r_20_01">20T</a></li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=106001001&ton=r_20_1">20T以上</a></li>
                  <%}%>
                </ul>
              </div>
            </div>
            <%}%>
            <%if(catalog_detail.equals("105003")){%>
            <div class="j_Prop attr j_Propli" id="select_tonandmeter">
              <div class="attrKey">直径(m)</div>
              <div class="attrValues">
                <ul class="av-collapse" style="visibility:visible;">
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=105003&tonandmeter=drill_0.5_1">0.5～1</a></li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=105003&tonandmeter=drill_0.8_1.8">0.8～1.8</a></li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=105003&tonandmeter=drill_1_2.5">1～2.5</a></li>
                </ul>
              </div>
            </div>
            <%}%>
            <%if(catalog_detail.equals("103001")){%>
            <div class="j_Prop attr j_Propli" id="select_tonandmeter">
              <div class="attrKey">臂架长度</div>
              <div class="attrValues">
                <ul class="av-collapse" style="visibility:visible;">
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_0_36">36米以下</a></li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_36_44">36-44米</a></li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_45_47">45-47米</a></li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_48_52">48-52米</a></li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_53_56">53-56米</a></li>
                  <li><a href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_56_1">56米以上</a></li>
                </ul>
              </div>
            </div>
            <%}%>
            <%if(brandList!=null&&brandList.size()>0){ %>
            <div class="j_Prop attr hasMore attr_brand j_Propli" id="select_brand">
              <div class="attrKey">品牌
                <div class="brandTip" style="white-space:normal;text-indent:0;position:static;padding:10px;"><a href="javascript:void(0)" id="inner" class="br01">国内品牌</a><a id="out" href="javascript:void(0)" class="br02">国外品牌</a><a href="javascript:void(0)" class="all" style="border-color:red;color:red">所有品牌</a></div>
              </div>
              <div class="attrValues">
                <div class="j_BrandSearch av-search fix">
                  <input id="brand"  name="brand" type="text" value="" placeholder="可搜拼音、汉字查找品牌" />
                </div>
                <div class="letters"><a data-val="A" href="javascript:void(0)" >A</a><a href="javascript:void(0)" data-val="B" >B</a><a data-val="C" href="javascript:void(0)">C</a><a href="javascript:void(0)" data-val="D" >D</a><a href="javascript:void(0)" data-val="F">F</a><a href="javascript:void(0)" data-val="G">G</a><a href="javascript:void(0)" data-val="H">H</a><a href="javascript:void(0)" data-val="J">J</a><a href="javascript:void(0)" data-val="K">K</a><a href="javascript:void(0)" data-val="L">L</a><a href="javascript:void(0)" data-val="M">M</a><a href="javascript:void(0)" data-val="N">N</a><a href="javascript:void(0)" data-val="O">O</a><a href="javascript:void(0)" data-val="P">P</a><a href="javascript:void(0)" data-val="Q">Q</a><a href="javascript:void(0)" data-val="R">R</a><a href="javascript:void(0)" data-val="S">S</a><a href="javascript:void(0)" data-val="T">T</a><a href="javascript:void(0)" data-val="W">W</a><a href="javascript:void(0)" data-val="X">X</a><a href="javascript:void(0)" data-val="Y">Y</a><a data-val="Z" href="javascript:void(0)">Z</a></div>
                <ul class="av-collapse" id="brand_list" style="margin-right:35px">
                  <%for(Map oneMap : brandList){%>
                  <li <%if(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")){%>class="br01"<%}else{%>class="br02"<%}%>><a data-val="<%=CommonString.getFormatPara(oneMap.get("id"))%>"  title="<%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog)).replace("/属具","")%>" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(oneMap.get("id"))%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tont.equals("")?"":"&ton="+tont%><%=year.equals("1")?"":"&year="+year%>"><span class="m"><%=CommonString.getFormatPara(oneMap.get("upper_index"))%>-<%=CommonString.getFormatPara(oneMap.get("name"))%><span style="color:red">(<%=CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog.equals("")?"0":catalog)))%>)</span></span></a><b></b></li>
                  <%}%>
                </ul>
                <div class="av-options"> <a href="javascript:;" class="j_Multiple avo-multiple">多选<i></i></a> <a href="javascript:;" class="j_More avo-more ui-more-drop-l">更多<i class="ui-more-drop-l-arrow"></i></a> </div>
                <div class="av-btns" style="display:none;"> <a id="multipleBrand01" href="javascript:;" class="j_SubmitBtn ui-btn-s-primary ui-btn-disable">确定</a> <a href="javascript:;" class="j_CancelBtn ui-btn-s">取消</a> </div>
              </div>
            </div>
            <%}%>
            <input type="hidden" id="catalog" name="catalog" value="<%=catalog%>" />
            <input type="hidden" id="tonandmeter" name="tonandmeter" value="<%=tonandmeter%>" />
            <input type="hidden" id="year" name="year" value="<%=year%>" />
            <input type="hidden" id="letter" name="letter"  />
            <input type="hidden" id="brands" name="brands"  />
          </div>
          <!--筛选 end-->
          <div class="filterBox">
            <div class="filterBar fix "> <a class="fSort default <%if(year.equals("all")){%>fSort-cur<%}%> " href="http://product.21-sun.com/products/prolist.jsp?year=all<%= factoryids.equals("")?"":"&factoryids="+factoryids%><%= factoryid.equals("")?"":"&factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%>" title="全部">全部</a>
              <%if(!factoryid.equals("")){%>
              <a class="fSort <%if(year.equals("1")){%>fSort-cur<%}%> " href="http://product.21-sun.com/products/prolist.jsp?<%= factoryid.equals("")?"":"factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%>" title="在售">在售</a>
              <%}else  if(!catalog.equals("")){%>
              <a class="fSort <%if(year.equals("1")){%>fSort-cur<%}%> " href="http://product.21-sun.com/products/prolist.jsp?<%=catalog.equals("")?"":"catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%>" title="在售">在售</a>
              <%}else{%>
              <a class="fSort <%if(year.equals("1")){%>fSort-cur<%}%> " href="http://product.21-sun.com/products/prolist.jsp" title="在售">在售</a>
              <%}%>
              <a class="fSort <%if(year.equals("0")){%>fSort-cur<%}%> " href="http://product.21-sun.com/products/prolist.jsp?year=0<%= factoryids.equals("")?"":"&factoryids="+factoryids%><%= factoryid.equals("")?"":"&factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%>" title="停产">停产</a>
              <div class="filterPage"> <a <%if(nowPage==1){%>href="javascript:void(0)"<%}else{%>href="http://product.21-sun.com/products/prolist.jsp?offset=<%=(Integer.parseInt(offset)-pageSize)%><%= factoryid.equals("")?"":"&factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%><%=order.equals("")?"":"&order="+order%>"<%}%> class="prev <%if(nowPage==1){%>disable<%}%>"><i class="ion">&#xe6c3;</i></a> <span class="total"><%=nowPage%>/<%=pageCount%></span> <a <%if(nowPage==pageCount){%>href="javascript:void(0)"<%}else{%>href="http://product.21-sun.com/products/prolist.jsp?offset=<%=(Integer.parseInt(offset)+pageSize)%><%= factoryid.equals("")?"":"&factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%><%=order.equals("")?"":"&order="+order%>"<%}%> class="next <%if(nowPage==pageCount){%>disable<%}%>"><i class="ion">&#xe6c4;</i></a> </div>
              <!--<span class="modeSwitch switch_on" title="点击切换到大图模式"></span>-->
              <div class='kind0518'>排序
                <div class='kind0518c'>
                  <div class='kind0518cc'><a href="http://product.21-sun.com/products/prolist.jsp?order=normal<%= factoryids.equals("")?"":"&factoryids="+factoryids%><%= factoryid.equals("")?"":"&factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>">点击量</a></div>
                  <div class='kind0518cc'><a href="http://product.21-sun.com/products/prolist.jsp?order=sale<%= factoryids.equals("")?"":"&factoryids="+factoryids%><%= factoryid.equals("")?"":"&factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>">销量</a></div>
                  <div class='kind0518cc'><a href="http://product.21-sun.com/products/prolist.jsp?order=comment<%= factoryids.equals("")?"":"&factoryids="+factoryids%><%= factoryid.equals("")?"":"&factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>">评价</a></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="txd_sx_plist mainList listMode">
        <ul class="fix">
          <%if(( catalog.equals("102")||catalog.equals("102007"))&&factoryid.equals("")&&nowPage==1&&2==1){%>
<!--
 <li  class="active"><div class="box"><div class="tsx_pimg"><a href="http://product.21-sun.com/proDetail/SMQ5152JQZ.shtm" title="森源SMQ5152JQZ五节臂汽车起重机（国五）" target="_blank"> <img src="http://product.21-sun.com/uploadfiles//image/2018/06/20180630154309_330.jpg" alt="森源SMQ5152JQZ五节臂汽车起重机（国五）" onerror="this.src='/uploadfiles/no_big.gif';"></a></div><div class="tsx_pnr"><h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/SMQ5152JQZ.shtm" target="_blank" title="森源SMQ5152JQZ五节臂汽车起重机（国五）">森源SMQ5152JQZ五节臂汽车起重机（国五）</a></h2><div class="txs_plink"><span class="pmhide"></span><a href="http://product.21-sun.com/proDetail/SMQ5152JQZ.shtm#xingn" target="_blank" title="森源SMQ5152JQZ五节臂汽车起重机（国五）性能">性能</a> <em>|</em><a href="http://product.21-sun.com/proDetail/SMQ5152JQZ.shtm#cans" target="_blank" title="森源SMQ5152JQZ五节臂汽车起重机（国五）参数">参数</a> <em>|</em><a href="http://product.21-sun.com/proDetail/SMQ5152JQZ_message.shtm#position" target="_blank" title="森源SMQ5152JQZ五节臂汽车起重机（国五）口碑">口碑</a><em>|</em><a href="http://product.21-sun.com/proDetail/SMQ5152JQZ_pic.shtm#position" target="_blank" title="森源SMQ5152JQZ五节臂汽车起重机（国五）图片">图片</a><em>|</em><a href="http://product.21-sun.com/proDetail/SMQ5152JQZ_agent.shtm#position" target="_blank" title="森源SMQ5152JQZ五节臂汽车起重机（国五）代理商">代理商</a> </div><div class="txs_psum"><div style="width:250px;float:left">总长度：10745</div><div style="width:250px;float:left">总高度：3430</div><div style="width:250px;float:left">总宽度：2400</div><a href="http://product.21-sun.com/proDetail/SMQ5152JQZ.shtm" target="_blank">[查看详情]</a></div></div><div class="oi"><div class="l"> <span class="thisxj"><b>询价（231）</b></span><a href="javascript:void(0)" class="add_inquiry" data-val="31240"><b>加入询价</b></a><a href="javascript:void(0)" class="add_compare" data-val="31240"><b>加入对比</b></a><a title="更多森源汽车起重机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=13730&catalog=102007" target="_blank"><b>更多森源汽车起重机</b></a><div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
</div><span class="pmh"><div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('31240','')">询最低价</a></div><div class="r">231人已询价</div></span> </div></div></li> 
-->
          <%}%>
          <%if(( catalog.equals("103")||catalog.equals("103019"))&&factoryid.equals("")&&nowPage==1&&2==1){%>
<!--
<li class="active"><div class="box"><div class="tsx_pimg"><a href="http://product.21-sun.com/proDetail/27MHNTBC.shtm" title="森源重工SMQ5160THB27米混凝土泵车" target="_blank"> <img src="http://product.21-sun.com/uploadfiles//image/2015/08/20150804085314_196.jpg" alt="森源重工SMQ5160THB27米混凝土泵车" onerror="this.src='/uploadfiles/no_big.gif';"></a></div><div class="tsx_pnr"><h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/27MHNTBC.shtm" target="_blank" title="森源重工SMQ5160THB27米混凝土泵车">森源重工SMQ5160THB27米混凝土泵车</a></h2><div class="txs_plink"><span class="pmhide"></span><a href="http://product.21-sun.com/proDetail/27MHNTBC.shtm#xingn" target="_blank" title="森源重工SMQ5160THB27米混凝土泵车性能">性能</a> <em>|</em><a href="http://product.21-sun.com/proDetail/27MHNTBC.shtm#cans" target="_blank" title="森源重工SMQ5160THB27米混凝土泵车参数">参数</a> <em>|</em><a href="http://product.21-sun.com/proDetail/27MHNTBC_message.shtm#position" target="_blank" title="森源重工SMQ5160THB27米混凝土泵车口碑">口碑</a><em>|</em><a href="http://product.21-sun.com/proDetail/27MHNTBC_pic.shtm#position" target="_blank" title="森源重工SMQ5160THB27米混凝土泵车图片">图片</a><em>|</em><a href="http://product.21-sun.com/proDetail/27MHNTBC_agent.shtm#position" target="_blank" title="森源重工SMQ5160THB27米混凝土泵车代理商">代理商</a> </div><div class="txs_psum"><div style="width:250px;float:left">总长度：10.02</div><div style="width:250px;float:left">总宽度：2.37</div><div style="width:250px;float:left">总高度：3.61</div><a href="http://product.21-sun.com/proDetail/27MHNTBC.shtm" target="_blank">[查看详情]</a></div></div><div class="oi"><div class="l"> <span class="thisxj"><b>询价（38）</b></span><a href="javascript:void(0)" class="add_inquiry" data-val="17506"><b>加入询价</b></a><a href="javascript:void(0)" class="add_compare" data-val="17506"><b>加入对比</b></a><a title="更多森源重工泵车" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=13730&catalog=103001" target="_blank"><b>更多森源重工泵车</b></a><div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
</div><span class="pmh"><div class="tsx_pprice"><a href="javascript:;" onclick="showinquery('17506','')">询最低价</a></div><div class="r">38人已询价</div></span> </div></div></li>
-->
          <%}%>
          <%if(( catalog.equals(""))&&factoryid.equals("")&&nowPage==1){%>
          <li class="active">
            <div class="box">
              <div class="tsx_pimg"> <a href="http://product.21-sun.com/proDetail/320GC.shtm" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2017/10/20171030140306_166.jpg" alt="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/320GC.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机">卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span> <a href="http://product.21-sun.com/proDetail/320GC.shtm#xingn" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机性能">性能</a><em>|</em> <a href="http://product.21-sun.com/proDetail/320GC.shtm#cans" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机参数">参数</a><em>|</em> <a href="http://product.21-sun.com/proDetail/320GC_message.shtm#position" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机口碑">口碑</a><em>|</em> <a href="http://product.21-sun.com/proDetail/320GC_pic.shtm#position" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机图片">图片</a><em>|</em> <a href="http://product.21-sun.com/proDetail/320GC_agent.shtm#position" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机代理商">代理商</a> </div>
                <div class="txs_psum">
                  <div style="width:250px;float:left">总长度：9531</div>
                  <div style="width:250px;float:left">总宽度：3170</div>
                  <div style="width:250px;float:left">总高度（至驾驶棚顶部）：2960</div>
                  <a href="http://product.21-sun.com/proDetail/320GC.shtm" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（209）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="30221"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="30221" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多卡特挖掘机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=174&catalog=101001" target="_blank"><b>更多卡特挖掘机</b></a>
                  <div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onClick="showinquery('30221','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726"> <a  class="add_compare_param" data-val="30221" href="javascript:;">+加入对比</a> </div>
                </span> </div>
            </div>
          </li>
          <%}%>
          <%if(( catalog.equals("101001004"))&&factoryid.equals("")&&nowPage==1){%>
          <li class="active">
            <div class="box">
              <div class="tsx_pimg"> <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ.shtm" title="宝鼎BD95W-9A轮式挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2018/05/31/20180531115921_749.png" alt="宝鼎BD95W-9A轮式挖掘机" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ.shtm" target="_blank" title="宝鼎BD95W-9A轮式挖掘机">宝鼎BD95W-9A轮式挖掘机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span> <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ.shtm#xingn" target="_blank" title="宝鼎BD95W-9A轮式挖掘机性能">性能</a><em>|</em> <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ.shtm#cans" target="_blank" title="宝鼎BD95W-9A轮式挖掘机参数">参数</a><em>|</em> <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ_message.shtm#position" target="_blank" title="宝鼎BD95W-9A轮式挖掘机口碑">口碑</a><em>|</em> <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ_pic.shtm#position" target="_blank" title="宝鼎BD95W-9A轮式挖掘机图片">图片</a><em>|</em> <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ_agent.shtm#position" target="_blank" title="宝鼎BD95W-9A轮式挖掘机代理商">代理商</a> </div>
                <div class="txs_psum">
                  <div style="width:250px;float:left">总长度：6369mm</div>
                  <div style="width:250px;float:left">总宽度：2030mm</div>
                  <div style="width:250px;float:left">总高度：2710mm</div>
                  <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ.shtm" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（0）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="31695"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="31695" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多宝鼎挖掘机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=13570&catalog=101001" target="_blank"><b>更多宝鼎挖掘机</b></a>
                  <div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onClick="showinquery('31695','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726"> <a data-val="31695" href="javascript:;" class="add_compare_param">+对比参数</a> </div>
                </span> </div>
            </div>
          </li>
          <%}%>
          <% if(catalog.equals("101001")&&tont.equals("g_1_13")&&factoryid.equals("")&&nowPage==1){%>
          <li class="active">
            <div class="box">
              <div class="tsx_pimg"> <a href="http://product.21-sun.com/proDetail/306E2.shtm" title="卡特彼勒306E2挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2017/10/20171018101808_908.jpg" alt="卡特彼勒306E2挖掘机" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/306E2.shtm" target="_blank" title="卡特彼勒306E2挖掘机">卡特彼勒306E2挖掘机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span> <a href="http://product.21-sun.com/proDetail/306E2.shtm#xingn" target="_blank" title="卡特彼勒306E2挖掘机性能">性能</a><em>|</em> <a href="http://product.21-sun.com/proDetail/306E2.shtm#cans" target="_blank" title="卡特彼勒306E2挖掘机参数">参数</a><em>|</em> <a href="http://product.21-sun.com/proDetail/306E2_message.shtm#position" target="_blank" title="卡特彼勒306E2挖掘机口碑">口碑</a><em>|</em> <a href="http://product.21-sun.com/proDetail/306E2_pic.shtm#position" target="_blank" title="卡特彼勒306E2挖掘机图片">图片</a><em>|</em> <a href="http://product.21-sun.com/proDetail/306E2_agent.shtm#position" target="_blank" title="卡特彼勒306E2挖掘机代理商">代理商</a> </div>
                <div class="txs_psum">
                  <div style="width:250px;float:left">总长度：312 mm</div>
                  <div style="width:250px;float:left">总宽度：1878 mm</div>
                  <div style="width:250px;float:left">总高度（至驾驶棚顶部）：2540 mm</div>
                  <a href="http://product.21-sun.com/proDetail/306E2.shtm" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（91）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="23912"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="23912" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多卡特挖掘机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=174&catalog=101001" target="_blank"><b>更多卡特挖掘机</b></a>
                  <div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onClick="showinquery('23912','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726"> <a data-val="23912" href="javascript:;" class="add_compare_param">+对比参数</a> </div>
                </span> </div>
            </div>
          </li>
          <%}%>
          <% if((catalog.equals("101001")||catalog.equals("101001001"))&&factoryid.equals("")&&nowPage==1){Random rand =new Random(); int wajueji; wajueji=rand.nextInt(10);%>
          <!--挖掘机广告-->
          <%if(wajueji==0){%>
            <li class="active">
            <div class="box">
              <div class="tsx_pimg"> <a href="http://product.21-sun.com/proDetail/SY35.shtm" title="三一SY35U微型液压挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2018/07/20180727154626_633.jpg" alt="三一SY35U微型液压挖掘机" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank" title="三一SY35U微型液压挖掘机">三一SY35U微型液压挖掘机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span> <a href="http://product.21-sun.com/proDetail/SY35.shtm#xingn" target="_blank" title="三一SY35U微型液压挖掘机性能">性能</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SY35.shtm#cans" target="_blank" title="三一SY35U微型液压挖掘机参数">参数</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SY35_message.shtm#position" target="_blank" title="三一SY35U微型液压挖掘机口碑">口碑</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SY35_pic.shtm#position" target="_blank" title="三一SY35U微型液压挖掘机图片">图片</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SY35_agent.shtm#position" target="_blank" title="三一SY35U微型液压挖掘机代理商">代理商</a> </div>
                <div class="txs_psum"> <div style="width:250px;float:left">总长度：4915</div><div style="width:250px;float:left">总宽度：1720</div><div style="width:250px;float:left">总高度（至动臂顶部）：2515</div> <a href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（513）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="21005"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="21005" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多三一挖掘机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=101001" target="_blank"><b>更多三一挖掘机</b></a>
					<div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onclick="showinquery('21005','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726"> <a data-val="21005" href="javascript:;" class="add_compare_param">+对比参数</a> </div>
                </span> </div>
            </div>
          </li>
          <%}%>
          <%if(wajueji!=0&&wajueji!=2){%>
         <li class="active">
            <div class="box">
              <div class="tsx_pimg"> <a href="http://product.21-sun.com/proDetail/320GC.shtm" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2017/10/20171030140306_166.jpg" alt="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/320GC.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机">卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span> <a href="http://product.21-sun.com/proDetail/320GC.shtm#xingn" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机性能">性能</a><em>|</em> <a href="http://product.21-sun.com/proDetail/320GC.shtm#cans" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机参数">参数</a><em>|</em> <a href="http://product.21-sun.com/proDetail/320GC_message.shtm#position" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机口碑">口碑</a><em>|</em> <a href="http://product.21-sun.com/proDetail/320GC_pic.shtm#position" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机图片">图片</a><em>|</em> <a href="http://product.21-sun.com/proDetail/320GC_agent.shtm#position" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机代理商">代理商</a> </div>
                <div class="txs_psum"> <div style="width:250px;float:left">总长度：9531</div><div style="width:250px;float:left">总宽度：3170</div><div style="width:250px;float:left">总高度（至驾驶棚顶部）：2960</div> <a href="http://product.21-sun.com/proDetail/320GC.shtm" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（209）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="30221"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="30221" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多卡特挖掘机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=174&catalog=101001" target="_blank"><b>更多卡特挖掘机</b></a>
					<div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onclick="showinquery('30221','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726"> <a data-val="30221" href="javascript:;" class="add_compare_param">+对比参数</a> </div>
                </span> </div>
            </div>
          </li>
          <%}%>
          <%if(wajueji==2){%>
            <li class="active">
            <div class="box">
              <div class="tsx_pimg"> <a href="http://product.21-sun.com/proDetail/SY35.shtm" title="三一SY35U微型液压挖掘机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2018/07/20180727154626_633.jpg" alt="三一SY35U微型液压挖掘机" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank" title="三一SY35U微型液压挖掘机">三一SY35U微型液压挖掘机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span> <a href="http://product.21-sun.com/proDetail/SY35.shtm#xingn" target="_blank" title="三一SY35U微型液压挖掘机性能">性能</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SY35.shtm#cans" target="_blank" title="三一SY35U微型液压挖掘机参数">参数</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SY35_message.shtm#position" target="_blank" title="三一SY35U微型液压挖掘机口碑">口碑</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SY35_pic.shtm#position" target="_blank" title="三一SY35U微型液压挖掘机图片">图片</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SY35_agent.shtm#position" target="_blank" title="三一SY35U微型液压挖掘机代理商">代理商</a> </div>
                <div class="txs_psum"> <div style="width:250px;float:left">总长度：4915</div><div style="width:250px;float:left">总宽度：1720</div><div style="width:250px;float:left">总高度（至动臂顶部）：2515</div> <a href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（513）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="21005"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="21005" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多三一挖掘机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=101001" target="_blank"><b>更多三一挖掘机</b></a>
					<div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onclick="showinquery('21005','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726"> <a data-val="21005" href="javascript:;" class="add_compare_param">+对比参数</a> </div>
                </span> </div>
            </div>
          </li>
          <%}%>
          <%}%>
          <%if((catalog.equals("101002")||catalog.equals("101002007"))&&factoryid.equals("")&&nowPage==1){Random rand =new Random();int zhuangzaiji;zhuangzaiji=rand.nextInt(5);%>
          <!--装载机广告-->
          <%if(zhuangzaiji==0){%>
           <li class="active">
            <div class="box">
              <div class="tsx_pimg"> <a href="http://product.21-sun.com/proDetail/SEM652D.shtm" title="山工SEM652D轮式装载机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2016/04/20160414084318_701.jpg" alt="山工SEM652D轮式装载机" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/SEM652D.shtm" target="_blank" title="山工SEM652D轮式装载机">山工SEM652D轮式装载机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span> <a href="http://product.21-sun.com/proDetail/SEM652D.shtm#xingn" target="_blank" title="山工SEM652D轮式装载机性能">性能</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SEM652D.shtm#cans" target="_blank" title="山工SEM652D轮式装载机参数">参数</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SEM652D_message.shtm#position" target="_blank" title="山工SEM652D轮式装载机口碑">口碑</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SEM652D_pic.shtm#position" target="_blank" title="山工SEM652D轮式装载机图片">图片</a><em>|</em> <a href="http://product.21-sun.com/proDetail/SEM652D_agent.shtm#position" target="_blank" title="山工SEM652D轮式装载机代理商">代理商</a> </div>
                <div class="txs_psum"> <div style="width:250px;float:left">总长度：8062</div><div style="width:250px;float:left">总宽度：2963</div><div style="width:250px;float:left">总高度：3348</div> <a href="http://product.21-sun.com/proDetail/SEM652D.shtm" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（1694）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="863"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="863" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多山工装载机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=138&catalog=101002" target="_blank"><b>更多山工装载机</b></a>
					<div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onclick="showinquery('863','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726"> <a data-val="863" href="javascript:;" class="add_compare_param">+对比参数</a> </div>
                </span> </div>
            </div>
          </li>
          <%}%>
          <%if(zhuangzaiji==1){%>
          <li  class="active">
            <div class="box">
              <div class="tsx_pimg"> <a href="http://product.21-sun.com/proDetail/XG951H.shtm" title="厦工XG951H轮式装载机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2018/05/20180510093412_192.jpg" alt="厦工XG951H轮式装载机" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/XG951H.shtm" target="_blank" title="厦工XG951H轮式装载机">厦工XG951H轮式装载机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span> <a href="http://product.21-sun.com/proDetail/XG951H.shtm#xingn" target="_blank" title="厦工XG951H轮式装载机性能">性能</a><em>|</em> <a href="http://product.21-sun.com/proDetail/XG951H.shtm#cans" target="_blank" title="厦工XG951H轮式装载机参数">参数</a><em>|</em> <a href="http://product.21-sun.com/proDetail/XG951H_message.shtm#position" target="_blank" title="厦工XG951H轮式装载机口碑">口碑</a><em>|</em> <a href="http://product.21-sun.com/proDetail/XG951H_pic.shtm#position" target="_blank" title="厦工XG951H轮式装载机图片">图片</a><em>|</em> <a href="http://product.21-sun.com/proDetail/XG951H_agent.shtm#position" target="_blank" title="厦工XG951H轮式装载机代理商">代理商</a> </div>
                <div class="txs_psum"> <div style="width:250px;float:left">斗容范围：2.2～3.6</div><div style="width:250px;float:left">整机操作质量：16800</div><div style="width:250px;float:left">额定载重量：5000</div> <a href="http://product.21-sun.com/proDetail/XG951H.shtm" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（1039）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="20381"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="20381" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多厦工装载机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=139&catalog=101002" target="_blank"><b>更多厦工装载机</b></a>
					<div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onclick="showinquery('20381','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726"> <a data-val="20381" href="javascript:;" class="add_compare_param">+对比参数</a> </div>
                </span> </div>
            </div>
          </li>
          <%}%>
          <%if(zhuangzaiji==2){%>
           <li class="active">
            <div class="box">
              <div class="tsx_pimg"> <a href="http://product.21-sun.com/proDetail/YX656HPLUS.shtm" title="英轩重工YX656HPlus轮式装载机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2018/05/20180529154623_974.jpg" alt="英轩重工YX656HPlus轮式装载机" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/YX656HPLUS.shtm" target="_blank" title="英轩重工YX656HPlus轮式装载机">英轩重工YX656HPlus轮式装载机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span> <a href="http://product.21-sun.com/proDetail/YX656HPLUS.shtm#xingn" target="_blank" title="英轩重工YX656HPlus轮式装载机性能">性能</a><em>|</em> <a href="http://product.21-sun.com/proDetail/YX656HPLUS.shtm#cans" target="_blank" title="英轩重工YX656HPlus轮式装载机参数">参数</a><em>|</em> <a href="http://product.21-sun.com/proDetail/YX656HPLUS_message.shtm#position" target="_blank" title="英轩重工YX656HPlus轮式装载机口碑">口碑</a><em>|</em> <a href="http://product.21-sun.com/proDetail/YX656HPLUS_pic.shtm#position" target="_blank" title="英轩重工YX656HPlus轮式装载机图片">图片</a><em>|</em> <a href="http://product.21-sun.com/proDetail/YX656HPLUS_agent.shtm#position" target="_blank" title="英轩重工YX656HPlus轮式装载机代理商">代理商</a> </div>
                <div class="txs_psum"> <div style="width:250px;float:left">总宽度：3024</div><div style="width:250px;float:left">总高度：3480</div><div style="width:250px;float:left">总长度：8125</div> <a href="http://product.21-sun.com/proDetail/YX656HPLUS.shtm" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（0）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="31597"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="31597" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多英轩重工装载机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=1777&catalog=101002" target="_blank"><b>更多英轩重工装载机</b></a>
					<div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onclick="showinquery('31597','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726"> <a data-val="31597" href="javascript:;" class="add_compare_param">+对比参数</a> </div>
                </span> </div>
            </div>
          </li>
          <%}%>
          <%if(zhuangzaiji==3){%>
           <li class="active">
            <div class="box">
              <div class="tsx_pimg"> <a href="http://product.21-sun.com/proDetail/966.shtm" title="常林公司966轮式装载机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2015/06/20150618172743_471.jpg" alt="常林公司966轮式装载机" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/966.shtm" target="_blank" title="常林公司966轮式装载机">常林公司966轮式装载机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span> <a href="http://product.21-sun.com/proDetail/966.shtm#xingn" target="_blank" title="常林公司966轮式装载机性能">性能</a><em>|</em> <a href="http://product.21-sun.com/proDetail/966.shtm#cans" target="_blank" title="常林公司966轮式装载机参数">参数</a><em>|</em> <a href="http://product.21-sun.com/proDetail/966_message.shtm#position" target="_blank" title="常林公司966轮式装载机口碑">口碑</a><em>|</em> <a href="http://product.21-sun.com/proDetail/966_pic.shtm#position" target="_blank" title="常林公司966轮式装载机图片">图片</a><em>|</em> <a href="http://product.21-sun.com/proDetail/966_agent.shtm#position" target="_blank" title="常林公司966轮式装载机代理商">代理商</a> </div>
                <div class="txs_psum"> <div style="width:250px;float:left">整机操作质量：20000±5%(kg)</div><div style="width:250px;float:left">斗容范围：3.5(m3)</div><div style="width:250px;float:left">额定载重量：6000(Kg)</div> <a href="http://product.21-sun.com/proDetail/966.shtm" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（111）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="10603"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="10603" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多常林公司装载机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=148&catalog=101002" target="_blank"><b>更多常林公司装载机</b></a>
					<div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onclick="showinquery('10603','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726"> <a data-val="10603" href="javascript:;" class="add_compare_param">+对比参数</a> </div>
                </span> </div>
            </div>
          </li>
          <%}%>
          <%if(zhuangzaiji==4){%>
          <li class="active">
            <div class="box">
              <div class="tsx_pimg"> <a href="http://product.21-sun.com/proDetail/926-93.shtm" title="雷乔曼926轮式装载机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2018/05/20180510200333_252.jpg" alt="雷乔曼926轮式装载机" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/926-93.shtm" target="_blank" title="雷乔曼926轮式装载机">雷乔曼926轮式装载机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span> <a href="http://product.21-sun.com/proDetail/926-93.shtm#xingn" target="_blank" title="雷乔曼926轮式装载机性能">性能</a><em>|</em> <a href="http://product.21-sun.com/proDetail/926-93.shtm#cans" target="_blank" title="雷乔曼926轮式装载机参数">参数</a><em>|</em> <a href="http://product.21-sun.com/proDetail/926-93_message.shtm#position" target="_blank" title="雷乔曼926轮式装载机口碑">口碑</a><em>|</em> <a href="http://product.21-sun.com/proDetail/926-93_pic.shtm#position" target="_blank" title="雷乔曼926轮式装载机图片">图片</a><em>|</em> <a href="http://product.21-sun.com/proDetail/926-93_agent.shtm#position" target="_blank" title="雷乔曼926轮式装载机代理商">代理商</a> </div>
                <div class="txs_psum"> <div style="width:250px;float:left">总长度：5600</div><div style="width:250px;float:left">总宽度：1840</div><div style="width:250px;float:left">总高度：2670</div> <a href="http://product.21-sun.com/proDetail/926-93.shtm" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（28）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="24889"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="24889" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多雷乔曼装载机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=16683&catalog=101002" target="_blank"><b>更多雷乔曼装载机</b></a>
					<div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onclick="showinquery('24889','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726"> <a data-val="24889" href="javascript:;" class="add_compare_param">+对比参数</a> </div>
                </span> </div>
            </div>
          </li>
          <%}%>
          <%}%>
          <%	  
			if (totalParts>0) {				
							int flagNum=1;
								for(SolrDocument mm : products){
								    flagNum++;
			                        String img=CommonString.getFormatPara(mm.getFieldValue("img"));
			                        String id = CommonString.getFormatPara(mm.getFieldValue("id"));
			                        String title = CommonString.getFormatPara(mm.getFieldValue("title")).replace("^r","<sup>®</sup>");
			                        String url = CommonString.getFormatPara(mm.getFieldValue("url"));
			                        //String link_other = CommonString.getFormatPara(mm.getFieldValue("link_other"));
			                        String file_name = "http://product.21-sun.com"+CommonString.getFormatPara(mm.getFieldValue("url"));
			                        String intro = CommonString.getFormatPara(mm.getFieldValue("intro")).replace("^r","<sup>®</sup>");
                                    if(intro.length()>180){intro=intro.substring(0,140)+"...";}									
                                    String factory_id=CommonString.getFormatPara(mm.getFieldValue("factoryid"));
                                    String factoryname=CommonString.getFormatPara(mm.getFieldValue("factoryname")).replace("卡特彼勒","卡特");	
                                    String catalognum=CommonString.getFormatPara(mm.getFieldValue("catalognum"));
									if(catalognum.length()>=6){catalognum=catalognum.substring(0,6);}
                                    String cataname=CommonString.getFormatPara(mm.getFieldValue("catalogname"));		
									int score1=CommonString.getFormatInt(mm.getFieldValue("score1"));	
                                    int score2=CommonString.getFormatInt(mm.getFieldValue("score2"));	
                                    int score3=CommonString.getFormatInt(mm.getFieldValue("score3"));	
                                    int score4=CommonString.getFormatInt(mm.getFieldValue("score4"));
                                    int inquiryCount=CommonString.getFormatInt(mm.getFieldValue("inquiryCount"));
                                    int commentCount=CommonString.getFormatInt(mm.getFieldValue("commentCount"));
									String paramStr="";
									if(proParamMap!=null){
                                   	List <Map> paramList=(List<Map>)(proParamMap.get(id));								
									if(paramList != null && paramList.size() > 0) {
					                    for (Map mmm : paramList) {
											paramStr+="<div style='width:250px;float:left'>"+CommonString.getFormatPara(mmm.get("param_name"))+"："+CommonString.getFormatPara(mmm.get("param_value"))+"</div>";
									}}
									}
									if(!paramStr.equals("")){intro=paramStr;}
									if(!"204".equals(factory_id)){
									if(!"20440".equals(id))	{
            %>
          <li >
            <div class="box">
              <div class="tsx_pimg"> <a href="<%=file_name%>" title="<%=title%>" target="_blank"><img src="<%=img%>" alt="<%=title%>" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="<%=file_name%>" target="_blank" title="<%=title%>"><%=title%></a></h2>
                <div class="txs_plink">
 
				<span class="pmhide"></span> <a href="<%=file_name%>#xingn" target="_blank" title="<%=title%>性能">性能</a><em>|</em> <a href="<%=file_name%>#cans" target="_blank" title="<%=title%>参数">参数</a><em>|</em> <a href="<%=file_name.replace(".shtm","_message.shtm#position")%>" target="_blank" title="<%=title%>口碑">口碑</a><em>|</em> <a href="<%=file_name.replace(".shtm","_pic.shtm#position")%>" target="_blank" title="<%=title%>图片">图片</a><em>|</em> <a href="<%=file_name.replace(".shtm","_agent.shtm#position")%>" target="_blank" title="<%=title%>代理商">代理商</a> </div>
                <div class="txs_psum"> <%=intro%> <a href="<%=file_name%>" target="_blank">[查看详情]</a> </div>
                <div class="" style=""> <span class="thisxj"> <b>询价（<%=inquiryCount%>）</b> </span> <a href="javascript:void(0)" class="add_inquiry" data-val="<%=id%>"> <b>加入询价</b></a> <a href="javascript:void(0)" class="add_compare" data-val="<%=id%>" style="color: #6666dd;"> <b>加入对比</b></a> <a title="更多<%=factoryname%><%=CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalognum)).replace("混凝土泵车","泵车").replace("混凝土布料设备","布料机")%>" class="morepro"  href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factory_id%>&catalog=<%=catalognum%>"   target="_blank" ><b>更多<%=factoryname%><%=CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalognum)).replace("混凝土泵车","泵车").replace("混凝土布料设备","布料机")%></b></a>
                  <!--
					<div class="pro-tip" style="position:relative; right:-350px; top:-24px; font-size:14px; font-weight:bold; color:#f00;"> [推广]</div>
					-->
                </div>
              </div>
              <div class="oi"> <span class="pmh">
                <div class="tsx_pprice"> <a href="javascript:;" onClick="showinquery('<%=id%>','')">询低价</a> </div>
                <div class="tsx_pprice tsx_duibi0726" > <a data-val="<%=id%>"  href="javascript:;" class="add_compare_param">+对比参数</a> </div>
                </span> </div>
            </div>
          </li>
          <%}}%>
          <%if(flagNum==3&&catalognum.equals("101002")&&factory_id.equals("")){%>
          <!--英轩产品广告20151216-->
		  <!--
          <li>
            <div class="box">
              <div class="tsx_pimg"><a href="http://product.21-sun.com/proDetail/YX655.shtm" title="英轩重工YX655轮式装载机" target="_blank"><img src="http://product.21-sun.com/uploadfiles//image/2015/09/20150906101703_207.jpg" alt="英轩重工YX655轮式装载机" onerror="this.src='/uploadfiles/no_big.gif';"></a></div>
              <div class="tsx_pnr">
                <h2 class="txs_ptitle"><a href="http://product.21-sun.com/proDetail/YX655.shtm" target="_blank" title="英轩重工YX655轮式装载机">英轩重工YX655轮式装载机</a></h2>
                <div class="txs_plink"><span class="pmhide"></span><a href="http://product.21-sun.com/proDetail/YX655.shtm#xingn" target="_blank" title="英轩重工YX655轮式装载机性能">性能</a><em>|</em><a href="http://product.21-sun.com/proDetail/YX655.shtm#cans" target="_blank" title="英轩重工YX655轮式装载机参数">参数</a><em>|</em><a href="http://product.21-sun.com/proDetail/YX655_message.shtm#position" target="_blank" title="英轩重工YX655轮式装载机口碑">口碑</a><em>|</em><a href="http://product.21-sun.com/proDetail/YX655_pic.shtm#position" target="_blank" title="英轩重工YX655轮式装载机图片">图片</a><em>|</em><a href="http://product.21-sun.com/proDetail/YX655_agent.shtm#position" target="_blank" title="英轩重工YX655轮式装载机代理商">代理商</a></div>
                <div class="txs_psum">●全景车窗，外观时尚；高强度整体式框架结构，安全性高；密封减震性好，●豪华座椅，可选装空调，给用户提供舒适的操作环境；●采用符合非公路II阶段排放要求的节能型低速<a href="http://product.21-sun.com/proDetail/YX655.shtm" target="_blank">[查看详情]</a></div>
              </div>
              <div class="oi">
                <div class="l"><span class="thisxj"><b>询价（373）</b></span><a href="javascript:void(0)" class="add_inquiry" data-val="15106"><b>加入询价</b></a><a href="javascript:void(0)" class="add_compare" data-val="15106"><b>加入对比</b></a><a title="更多英轩重工装载机" class="morepro" href="http://product.21-sun.com/products/prolist.jsp?factory=1777&catalog=101002" target="_blank"><b>更多英轩重工装载机</b></a></div>
                <span class="pmh">
                <div class="tsx_pprice"><a href="javascript:;" onClick="showinquery('15106','')">询最低价</a></div>
                <div class="r">373人已询价</div>
                </span></div>
            </div>
          </li>
		  -->
          <%}}}%>
        </ul>
      </div>
      <div class="txd_bottomtel fix">如果没有找到您的信息，请重新选择您的筛选条件</div>
      <div class="txd_page fix">
        <div class="paging page" id="pagination">
          <tags:page_solr factoryids="<%=factoryids%>"  nowPage="<%=nowPage%>" total="<%=totalParts %>"  totalPage="<%=pageCount%>" tonandmeter="<%=tonandmeter%>" factoryid="<%=factoryid%>" catalog="<%=catalog%>" />
        </div>
      </div>
    </div>
  </div>
</div>
<!--main end-->
<%if(catalog.indexOf("106001")>=0){%>
<div class="txd_new_order" style="min-width: 1200px; max-width: 1200px;margin-right: auto;margin-left: auto;clear: both;">
  <div class="wrap fix" style="width:950px;max-width:950px;min-width:950px;float:right;margin-bottom:10px">
    <div class="title04">
      <h2>热门机型</h2>
    </div>
    <div class="list04">
      <div id="MarqueeDiv" class="fix">
        <ul>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001&t=12" title="12吨压路机">12吨压路机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001&t=16" title="16吨压路机">16吨压路机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001&t=18" title="18吨压路机">18吨压路机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001&t=20" title="20吨压路机">20吨压路机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001&t=22" title="22吨压路机">22吨压路机</a></li>
        </ul>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<%}%>
<%if(catalog.indexOf("101002")>=0){%>
<div class="txd_new_order" style="min-width: 1200px; max-width: 1200px;margin-right: auto;margin-left: auto;clear: both;">
  <div class="wrap fix" style="width:950px;max-width:950px;min-width:950px;float:right;margin-bottom:10px">
    <div class="title04">
      <h2>热门机型</h2>
    </div>
    <div class="list04">
      <div id="MarqueeDiv" class="fix">
        <ul>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=3" title="30铲车">30铲车</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=3" title="3吨装载机">3吨装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=3" title="30装载机">30装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=5" title="50装载机">50装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=5" title="50铲车">50铲车</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=5" title="5吨装载机">5吨装载机</a></li>
        </ul>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<%}%>
<%if(catalog.indexOf("102007")>=0){%>
<div class="txd_new_order" style="min-width: 1200px; max-width: 1200px;margin-right: auto;margin-left: auto;clear: both;">
  <div class="wrap fix" style="width:950px;max-width:950px;min-width:950px;float:right;margin-bottom:10px">
    <div class="title04">
      <h2>热门机型</h2>
    </div>
    <div class="list04">
      <div id="MarqueeDiv" class="fix">
        <ul>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&t=8" title="8吨汽车吊">8吨汽车吊</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&t=12" title="12吨汽车吊">12吨汽车吊</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&t=16" title="16吨汽车吊">16吨汽车吊</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&t=25" title="25吨汽车吊">25吨汽车吊</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&t=50" title="50吨汽车吊">50吨汽车吊</a></li>
        </ul>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<%}%>
<%if(catalog.indexOf("103001")>=0){%>
<div class="txd_new_order" style="min-width: 1200px; max-width: 1200px;margin-right: auto;margin-left: auto;clear: both;">
  <div class="wrap fix" style="width:950px;max-width:950px;min-width:950px;float:right;margin-bottom:10px">
    <div class="title04">
      <h2>热门机型</h2>
    </div>
    <div class="list04">
      <div id="MarqueeDiv" class="fix">
        <ul>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=26" title="26米泵车">26米泵车</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=37" title="37米泵车">37米泵车</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=38" title="38米泵车">38米泵车</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=47" title="47米泵车">47米泵车</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=48" title="48米泵车">48米泵车</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=52" title="52米泵车">52米泵车</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=56" title="56米泵车">56米泵车</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=62" title="62米泵车">62米泵车</a></li>
        </ul>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<%}%>
<%if(catalog.equals("101001")||catalog.equals("101001001")||catalog.equals("101001004")||catalog.equals("101001007")){%>
<div class="txd_new_order" style="min-width: 1200px; max-width: 1200px;margin-right: auto;margin-left: auto;clear: both;">
  <div class="wrap fix" style="width:950px;max-width:950px;min-width:950px;float:right;margin-bottom:10px">
    <div class="title04">
      <h2>热门机型</h2>
    </div>
    <div class="list04">
      <div id="MarqueeDiv" class="fix">
        <ul>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=yy" title="液压挖掘机">液压挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&t=15" title="15吨挖掘机">15吨挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&t=20" title="200挖掘机">200挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&t=20" title="20吨挖掘机">20吨挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=220" title="220挖掘机">220挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&t=30" title="30吨挖掘机">30吨挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=360" title="360挖掘机">360挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=55" title="55挖掘机">55挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=60" title="60挖掘机">60挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=65" title="65挖掘机">65挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=70" title="70挖掘机">70挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=85" title="85挖掘机">85挖掘机</a></li>
        </ul>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<%}%>
<%if(!catalog.equals("")&factory.equals("")){%>
<div class="txd_new_order" style="min-width: 1200px;    max-width: 1200px;margin-right: auto;margin-left: auto;clear: both;">
  <div class="wrap fix" style="width:950px;max-width:950px;min-width:950px;float:right;margin-bottom:10px">
    <div class="title04">
      <h2>
        <%if(!"".equals(factoryid)&&"".equals(catalog)){%>
        <%= CommonString.getFormatPara(brandMap.get(factoryid))%>
        <%}%>
        <%if(!"".equals(factoryid)&&!"".equals(catalog)){%>
        <%= CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")%>
        <%}%>
        <%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>相关推荐品牌</h2>
    </div>
    <div class="list04">
      <div id="MarqueeDiv" class="fix">
        <ul>
          <%if(catalog.indexOf("101001")>=0){%>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=101001" title="三一挖掘机">三一挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=174&catalog=101001" title="卡特彼勒挖掘机">卡特彼勒挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=182&catalog=101001" title="小松挖掘机">小松挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=101001" title="徐工挖掘机">徐工挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=183&catalog=101001" title="神钢挖掘机">神钢挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=192&catalog=101001" title="斗山挖掘机">斗山挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=175&catalog=101001" title="沃尔沃挖掘机">沃尔沃挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=141&catalog=101001" title="雷沃挖掘机">雷沃挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=184&catalog=101001" title="日立挖掘机">日立挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101001" title="柳工挖掘机">柳工挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=137&catalog=101001" title="临工挖掘机">临工挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=194&catalog=101001" title="现代挖掘机">现代挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=101001" title="龙工挖掘机">龙工挖掘机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=139&catalog=101001" title="厦工挖掘机">厦工挖掘机</a></li>
          <%}else if(catalog.indexOf("101002")>=0){%>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=101002" title="徐工装载机">徐工装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=101002" title="三一装载机">三一装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=182&catalog=101002" title="小松装载机">小松装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101002" title="柳工装载机">柳工装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=137&catalog=101002" title="临工装载机">临工装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=138&catalog=101002" title="山工装载机">山工装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=172&catalog=101002" title="晋工装载机">晋工装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=192&catalog=101002" title="斗山装载机">斗山装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=175&catalog=101002" title="沃尔沃装载机">沃尔沃装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=141&catalog=101002" title="雷沃装载机">雷沃装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=101002" title="龙工装载机">龙工装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=144&catalog=101002" title="山推装载机">山推装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=1777&catalog=101002" title="英轩装载机">英轩装载机</a></li>
          <li style="width:130px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=139&catalog=101002" title="厦工装载机">厦工装载机</a></li>
          <%}else{%>
          <%if(brandList!=null&&brandList.size()>0){ %>
          <%if(brandList.size()>=12){
	  for(int i = 0 ; i < 12 ; i++) {
		  String f_id=CommonString.getFormatPara(brandList.get(i).get("id")); 
		  String f_name=CommonString.getFormatPara(brandList.get(i).get("name"));
	  %>
          <li style="width:150px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=<%=f_id%>&catalog=<%=catalog%>" title="<%=f_name%><%=CommonString.getFormatPara(catalogMap.get(catalog)).replace("/属具","")%>"><%=f_name%><%=CommonString.getFormatPara(catalogMap.get(catalog)).replace("/属具","")%></a></li>
          <%}}else{  for(Map oneMap : brandList){%>
          <li style="width:150px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(oneMap.get("id"))%>&catalog=<%=catalog%>" title="<%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(catalogMap.get(catalog)).replace("/属具","")%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(catalogMap.get(catalog)).replace("/属具","")%></a></li>
          <%}}}}%>
        </ul>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<%}%>
<%if(catalog.equals("")&!factory.equals("")){
	 String zy_cata=(String)catalogFromBrandMap.get(factory);
	 String[] cataList=zy_cata.split(",");
	 %>
<div class="txd_new_order" style="min-width: 1200px; max-width: 1200px;margin-right: auto;margin-left: auto;clear: both;">
  <div class="wrap fix" style="width:950px;max-width:950px;min-width:950px;float:right;margin-bottom:10px">
    <div class="title04">
      <h2>
        <%if(!"".equals(factoryid)&&"".equals(catalog)){%>
        <%= CommonString.getFormatPara(brandMap.get(factoryid))%>
        <%}%>
        <%if(!"".equals(factoryid)&&!"".equals(catalog)){%>
        <%= CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")%>
        <%}%>
        <%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>主营产品推荐</h2>
    </div>
    <div class="list04">
      <div id="MarqueeDiv" class="fix">
        <ul>
          <%if(cataList.length>0){
	  for(int i = 0 ; i < cataList.length ; i++) {
		  String c_id=CommonString.getFormatPara(cataList[i]); 
		  String c_name=CommonString.getFormatPara(catalogMap.get(c_id)).replace("/属具","");
%>
          <li style="width:150px;padding: 0px 0px 0px 10px;"><a   href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factory%>&catalog=<%=c_id%>" title="<%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=c_name%>"><%=CommonString.getFormatPara(brandMap.get(factoryid))%><%=c_name%></a></li>
          <%}%>
        </ul>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<%}}%>
<!--最新订单 end-->
<!--end-->
<jsp:include page="/include/new_foot_prolist.htm" flush="true"/>
<!--foot end-->
<div class="blackBar">
  <div class="bb01"><a target="_blank" href="http://product.21-sun.com/user/login.htm" class="si"><i class="sb_ion sb01"></i></a><a title="批量询价" alt="批量询价" href="#" class="si sb_xunjia"><i class="sb_ion sb02"></i><b>批量询价</b><em id="plxj" class="num">0</em><i class="arr"></i></a><a title="机型对比" alt="机型对比" style="margin-top:20px" href="#" class="si sb_duibi"><b>机型对比</b><em id="jxdb" class="num">0</em><i class="arr"></i></a></div>
  <div class="bb02"><a href="javascript:void(0)" class="si sb_ewm"><i class="sb_ion sb03"></i></a><a href="#" class="si gotop" title="返回顶部"><i class="sb_ion sb04"></i></a></div>
  <div class="hide">
    <div class="bb_ewm"><img src="/Static/images/ewm02.png"></div>
  </div>
</div>
<!--询价弹层-->
<div class="sb_layer yincang sb_layer_xunjia" id="xjtc">
  <div class="sb_hd"><span class="check_box">
    <input type="checkbox" id="checkAll_xunjia">
    共<b class="all" id="inquiryCount">0</b>件，已选<b class="fn">0</b>件</span><a style="margin-left:25px" id="closexunjia" href="javascript:void(0)" >【关闭】</a></div>
  <div class="sb_bd">
    <ul id="xunjiaContent">
    </ul>
    <div class="sb_xunjiaForm" style="bottom:50px">
      <div class="dl">
        <div class="dt">姓名：</div>
        <div class="dd">
          <input type="text" class="form-control" id="uname">
          <em>*</em></div>
      </div>
      <div class="dl">
        <div class="dt">手机：</div>
        <div class="dd">
          <input type="text" class="form-control" id="phone">
          <em>*</em></div>
      </div>
      <div class="dl area">
        <div class="dt">地区：</div>
        <div class="dd">
          <select class="form-control" onChange="set_my_city(this);" id="select_province">
            <option>选择省</option>
            <option value="100110">山东</option>
            <option value="101800">安徽</option>
            <option value="103100">江西</option>
            <option value="104200">浙江</option>
            <option value="105290">上海</option>
            <option value="105499">北京</option>
            <option value="105689">天津</option>
            <option value="105879">重庆</option>
            <option value="106400">河北</option>
            <option value="108300">山西</option>
            <option value="109700">内蒙古</option>
            <option value="110900">江苏</option>
            <option value="113000">广西</option>
            <option value="115000">西藏</option>
            <option value="116000">宁夏</option>
            <option value="117000">新疆</option>
            <option value="119000">吉林</option>
            <option value="120000">辽宁</option>
            <option value="122000">黑龙江</option>
            <option value="124000">湖北</option>
            <option value="126000">湖南</option>
            <option value="128000">广东</option>
            <option value="130000">河南</option>
            <option value="132000">贵州</option>
            <option value="133000">青海</option>
            <option value="134000">甘肃</option>
            <option value="135500">陕西</option>
            <option value="137000">云南</option>
            <option value="139000">四川</option>
            <option value="141500">海南</option>
            <option value="142000">福建</option>
          </select>
          <input type="hidden" name="province" id="province" value="" />
          <select class="form-control" style="margin-right:0;" id="city_lists"  onchange="set_area(this);">
            <option value="">选择城市</option>
          </select>
          <em>*</em>
          <input type="hidden" name="city" id="city" value="" />
        </div>
      </div>
    </div>
  </div>
  <div class="sb_fd" style="margin-top:-40px"><span class="check_box"> 已选<b class="fn">0</b>件</span><a href="javascript:void(0)" id="ljxj" class="xjBtn">立即询价</a></div>
</div>
<!--对比弹层-->
<div class="sb_layer yincang sb_layer_duibi"  id="dbtc">
  <div class="sb_hd"><span class="check_box">
    <input type="checkbox" id="checkAll_duibi">
    共<b class="all" id="compareCount">0</b>件，已选<b class="fn">0</b>件</span><a id="closecompare" href="javascript:void(0)" style="margin-left:25px">【关闭】</a></div>
  <div class="sb_bd">
    <ul id="cmpContent">
    </ul>
  </div>
  <div class="sb_fd"><span class="check_box"> 已选<b class="fn">0</b>件</span><a href="javascript:void(0)" id="ksdb" class="xjBtn">开始对比</a></div>
</div>
<script src="../Static/modules/seajs/sea.js" id="seajsnode" ></script>
<script src="../seajs.config.js"></script>
<script src="http://www.21-sun.com/js/topbar.js"></script>
<script>
var jrChannel='1#0';
seajs.use('app/product_list.js');
define("page_use",function(require,exports,module) {
	var $ = require('jquery');
	var base = require('base');
	require('tip');
	$('.sb_ewm').tip($('.bb_ewm'), {place:'left-center'});
	
	$('.sb_bd').height($('.sb_layer').height()-$('.sb_hd').outerHeight()-$('.sb_fd').outerHeight());
	$(window).resize(function(){
		$('.sb_bd').height($('.sb_layer').height()-$('.sb_hd').outerHeight()-$('.sb_fd').outerHeight());
	});
	//询价
	$('.sb_layer_xunjia').on('click','#checkAll_xunjia',function(){
		var xjCheck = $('input[name="xj_subBox"]');
		if($(this).prop('checked')){
			xjCheck.prop("checked",true);	
		}else{
			xjCheck.prop("checked",false);		
		}
		$('.sb_layer_xunjia .check_box').find('.fn').html($('#xunjiaContent').find("input[name='xj_subBox']:checked").length);
	});
	$('.sb_layer_xunjia').on('click','input[name="xj_subBox"]',function(){
		var xjCheck = $('input[name="xj_subBox"]');
		$("#checkAll_xunjia").prop("checked",xjCheck.length == $('input[name="xj_subBox"]:checked').length ? true : false);
		$('.sb_layer_xunjia .check_box').find('.fn').html($('#xunjiaContent').find("input[name='xj_subBox']:checked").length);
	})
	//询价添加总数
	$('.sb_layer_xunjia .check_box').find('.all').html($('#xunjiaContent').find("input[name='xj_subBox']").length);
	$('.sb_xunjia .num').html($('#xunjiaContent').find("input[name='xj_subBox']").length);
	//弹出询价
	$('.sb_xunjia').click(function(e){
		e.preventDefault();
		$('.sb_layer').stop().animate({right:'-100%'},500);
		$(this).addClass('si_act').siblings().removeClass('si_act');
		if($('.sb_layer_xunjia').hasClass('yincang')){
			$('.sb_layer_xunjia').removeClass('yincang').stop().animate({right:35},500);
			$(this).addClass('si_act');
		}else{
			$('.sb_layer_xunjia').addClass('yincang').stop().animate({right:'-100%'},500);
			$(this).removeClass('si_act');
		}
	});
	$('#closexunjia').click(function(e){
		e.preventDefault();
		$('.sb_layer').stop().animate({right:'-100%'},500);
		$(this).addClass('si_act').siblings().removeClass('si_act');
		if($('.sb_layer_xunjia').hasClass('yincang')){
			$('.sb_layer_xunjia').removeClass('yincang').stop().animate({right:35},500);
			$(this).addClass('si_act');
		}else{
			$('.sb_layer_xunjia').addClass('yincang').stop().animate({right:'-100%'},500);
			$(this).removeClass('si_act');
		}
	});
	//对比
	$('.sb_layer_duibi').on('click','#checkAll_duibi',function(){
		var dbCheck = $('input[name="db_subBox"]');
		if($(this).prop('checked')){
			dbCheck.prop("checked",true);	
		}else{
			dbCheck.prop("checked",false);		
		}
		$('.sb_layer_duibi .check_box').find('.fn').html($('#cmpContent').find("input[name='db_subBox']:checked").length);
	});
	$('.sb_layer_duibi').on('click','input[name="db_subBox"]',function(){
		var dbCheck = $('input[name="db_subBox"]');
		$("#checkAll_duibi").prop("checked",dbCheck.length == $('input[name="db_subBox"]:checked').length ? true : false);
		$('.sb_layer_duibi .check_box').find('.fn').html($('#cmpContent').find("input[name='db_subBox']:checked").length);
	})
	//对比添加总数
	$('.sb_layer_duibi .check_box').find('.all').html($('#cmpContent').find("input[name='db_subBox']").length);
	//弹出对比
	
 

	$('.sb_duibi').click(function(e){
		        var compareids="";		
         var dbCheck = $('input[class="compare"]');
		 $.each(dbCheck, function(i, item){   
               if(dbCheck[i].checked){		 
				  compareids+=dbCheck[i].value+",";
			   }				  
          }); 
		  if(compareids==''){
			jQuery.jBox.tip("请选择需要对比的产品");  
		  }else{
			compareids=compareids.substring(0,compareids.length-1);
		    window.open("http://product.21-sun.com/compares/index.jsp?pids="+compareids);
		  }
		  	/*
		e.preventDefault();
		$('.sb_layer').stop().animate({right:'-100%'},500);
		$(this).addClass('si_act').siblings().removeClass('si_act');
		if($('.sb_layer_duibi').hasClass('yincang')){
			$('.sb_layer_duibi').removeClass('yincang').stop().animate({right:35},500);
			$(this).addClass('si_act');
		}else{
			$('.sb_layer_duibi').addClass('yincang').stop().animate({right:'-100%'},500);
			$(this).removeClass('si_act');
		}
		*/
	});
	
	$('#closecompare').click(function(e){
		e.preventDefault();
		$('.sb_layer').stop().animate({right:'-100%'},500);
		$(this).addClass('si_act').siblings().removeClass('si_act');
		if($('.sb_layer_duibi').hasClass('yincang')){
			$('.sb_layer_duibi').removeClass('yincang').stop().animate({right:35},500);
			$(this).addClass('si_act');
		}else{
			$('.sb_layer_duibi').addClass('yincang').stop().animate({right:'-100%'},500);
			$(this).removeClass('si_act');
		}
	});
});
seajs.use("page_use");
</script>
</body>
</html>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<link href="/plugin/dialog/jBox/Skins/GreyBlue/jbox.css" type="text/css" rel="stylesheet"/>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" />
<script type="text/javascript" src="/scripts/prolist.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<%if(source.equals("baidu")){%>
<script>
	SetCookie("source",'baidu') ;
</script>
<%}%>
<script>
    $('#xjtc').mouseleave(function(){
        //e.preventDefault();
		$('.sb_layer').stop().animate({right:'-100%'},500);
		$(this).addClass('si_act').siblings().removeClass('si_act');
		if($('.sb_layer_xunjia').hasClass('yincang')){
			$('.sb_layer_xunjia').removeClass('yincang').stop().animate({right:35},500);
			$(this).addClass('si_act');
		}else{
			$('.sb_layer_xunjia').addClass('yincang').stop().animate({right:'-100%'},500);
			$(this).removeClass('si_act');
		}
    });   
	$('#dbtc').mouseleave(function(){
        //e.preventDefault();
		$('.sb_layer').stop().animate({right:'-100%'},500);
		$(this).addClass('si_act').siblings().removeClass('si_act');
		if($('.sb_layer_duibi').hasClass('yincang')){
			$('.sb_layer_duibi').removeClass('yincang').stop().animate({right:35},500);
			$(this).addClass('si_act');
		}else{
			$('.sb_layer_duibi').addClass('yincang').stop().animate({right:'-100%'},500);
			$(this).removeClass('si_act');
		}
    });
</script>
<script>
(function(){
    var bp = document.createElement('script');
    var curProtocol = window.location.protocol.split(':')[0];
    if (curProtocol === 'https') {
        bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';        
    }
    else {
        bp.src = 'http://push.zhanzhang.baidu.com/push.js';
    }
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();

$('.kind0518').on('click','.kind0518cc',function(){
	$('.kind0518').find('span').text($(this).text());
})
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);	
	}
%>
