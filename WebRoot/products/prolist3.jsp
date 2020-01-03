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
<% 
	String year = CommonString.getFormatPara(request.getParameter("year"));
	String catalog = CommonString.getFormatInt(request.getParameter("catalog")).toString();
	String inner = CommonString.getFormatInt(request.getParameter("inner")).toString();
	String ton = CommonString.getFormatPara(request.getParameter("t")).replace("0t","").replace("t","");
	String ton_tdk = CommonString.getFormatPara(request.getParameter("t"));
    String m = CommonString.getFormatPara(request.getParameter("m"));
	String state = CommonString.getFormatPara(request.getParameter("state"));
	String ton_url="0";

	String keyword="";
	String source = CommonString.getFormatPara(request.getParameter("source"));
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
	tonandmeter=tonandmeter.replace("loader_3_01","");
	String factoryid = CommonString.getFormatInt(request.getParameter("factoryid")).toString();
	String factory = CommonString.getFormatInt(request.getParameter("factory")).toString();
	String c=CommonString.getFormatPara(request.getParameter("c"));
	String f=CommonString.getFormatPara(request.getParameter("f"));
	String tont=CommonString.getFormatPara(request.getParameter("ton"));
	if(tont.equals("g_0_6")){
		ton_url="g-0-4";
	}
	if(tont.equals("g_1_13")){
		ton_url="g-4-8";
	}
	if(tont.equals("g_8_15")){
		ton_url="g-8-15";
	}
	if(tont.equals("g_14_30")){
		ton_url="g-15-25";
	}
	if(tont.equals("g_25_35")){
		ton_url="g-25-35";
	}
	if(tont.equals("g_30_1")){
		ton_url="g-35-1";
	}
	
	
	if(tont.equals("l_1_3")){
		ton_url="l-1-3";
	}
	if(tont.equals("l_3_01")){
		ton_url="l-3-01";
	}
	if(tont.equals("l_3_5")){
		ton_url="l-3-5";
	}
	if(tont.equals("l_5_1")){
		ton_url="l-5-1";
	}
	
	
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
			showtonandmeter = "迷你挖(3吨以下)";
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
		catalogMap.put("122006","垃圾转运站");
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
	//orderList.add(SolrQuery.SortClause.desc("orderno"));
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
	//品牌地址
	String brandUrl="";
	if(catalog.equals("101001")){brandUrl="wajueji/";}
	if(catalog.equals("140")){brandUrl="shuju/";}
	if(catalog.equals("101002")){brandUrl="zhuangzaiji/";}
	if(catalog.equals("101003")){brandUrl="tuituji/";}
	if(catalog.equals("101005001")){brandUrl="chanyunji/";}
	if(catalog.equals("101005002")){brandUrl="pingdiji/";}
	if(catalog.equals("102007")){brandUrl="qizhongji/qichediao/";}
	if(catalog.equals("101008")){brandUrl="zixieche/";}
	if(catalog.equals("102")){brandUrl="qizhongji/";}
	if(catalog.equals("103")){brandUrl="hunningtu/";}
	if(catalog.equals("104")){brandUrl="lumianjixie/";}
	if(catalog.equals("105")){brandUrl="zhuanggongjixie/";}
	if(catalog.equals("106001")){brandUrl="yashijixie/";}
	if(catalog.equals("107")){brandUrl="chache/";}
	if(catalog.equals("109")){brandUrl="qiaoliangjixie/";}
	if(catalog.equals("110")){brandUrl="kuangshanmeikuang/";}
	if(catalog.equals("111")){brandUrl="gangkoujixie/";}
	if(catalog.equals("118")){brandUrl="zhuanyongcheliang/";}
	if(catalog.equals("122")){brandUrl="huanweicheliang/";}
	
	if(catalog.equals("101001001")){brandUrl="wajueji/lvdaiw/";}
	if(catalog.equals("101001004")){brandUrl="wajueji/lushiw/";}
	if(catalog.equals("101001007")){brandUrl="wajueji/tezhong/";}
	
	if(catalog.equals("101001098")){brandUrl="shuju/psc/";}
	if(catalog.equals("101001099")){brandUrl="shuju/yyj/";}
	
	if(catalog.equals("101002007")){brandUrl="zhuangzaiji/lushiz/";}
	if(catalog.equals("101002003")){brandUrl="zhuangzaiji/lvdaiz/";}
	if(catalog.equals("101002004")){brandUrl="zhuangzaiji/tezhongz/";}
	if(catalog.equals("101002008")){brandUrl="zhuangzaiji/wajue/";}
	if(catalog.equals("101002009")){brandUrl="zhuangzaiji/huayi/";}
	if(catalog.equals("101002010")){brandUrl="zhuangzaiji/chazhuang/";}
	
	if(catalog.equals("106001001")){brandUrl="yashijixie/danganglun/";}
	if(catalog.equals("106001002")){brandUrl="yashijixie/shuangganglun/";}
	if(catalog.equals("106001003")){brandUrl="yashijixie/sanganglun/";}
	if(catalog.equals("106001005")){brandUrl="yashijixie/luntai/";}
	if(catalog.equals("106001004")){brandUrl="yashijixie/shoufu/";}
	if(catalog.equals("106001020")){brandUrl="yashijixie/yashi/";}
	if(catalog.equals("106001021")){brandUrl="yashijixie/hangshi/";}
	
	if(catalog.equals("102002")){brandUrl="qizhongji/tashi/";}
	if(catalog.equals("102003")){brandUrl="qizhongji/gaokong/";}
	if(catalog.equals("102006")){brandUrl="qizhongji/suiche/";}
	if(catalog.equals("102008")){brandUrl="qizhongji/lvdaiq/";}
	if(catalog.equals("102012")){brandUrl="qizhongji/shensuo/";}
	if(catalog.equals("102011")){brandUrl="qizhongji/shigong/";}
	if(catalog.equals("102013")){brandUrl="qizhongji/longmen/";}
	
	if(catalog.equals("103001")){brandUrl="hunningtu/bengche/";}
	if(catalog.equals("103021")){brandUrl="hunningtu/jiaobanji/";}
	if(catalog.equals("103019")){brandUrl="hunningtu/yunshuche/";}
	if(catalog.equals("103017")){brandUrl="hunningtu/chezaibeng/";}
	if(catalog.equals("103018")){brandUrl="hunningtu/tuobeng/";}
	if(catalog.equals("103020")){brandUrl="hunningtu/shusongbeng/";}
	if(catalog.equals("103002")){brandUrl="hunningtu/jiaobanzhan/";}
	if(catalog.equals("103005")){brandUrl="hunningtu/buliao/";}
	if(catalog.equals("103008")){brandUrl="hunningtu/ganfen/";}
	if(catalog.equals("103010")){brandUrl="hunningtu/penshi/";}
	if(catalog.equals("103015")){brandUrl="hunningtu/qitab/";}
	
	if(catalog.equals("104001")){brandUrl="lumianjixie/tanpuji/";}
	if(catalog.equals("104005")){brandUrl="lumianjixie/xianpaoji/";}
	if(catalog.equals("104003")){brandUrl="lumianjixie/kaicaoji/";}
	if(catalog.equals("104004")){brandUrl="lumianjixie/posuiji/";}
	if(catalog.equals("104002")){brandUrl="lumianjixie/zaishengxiubu/";}
	if(catalog.equals("104008")){brandUrl="lumianjixie/wendingtu/";}
	if(catalog.equals("104009")){brandUrl="lumianjixie/jiaoban/";}
	if(catalog.equals("104006")){brandUrl="lumianjixie/sanbu/";}
	
	if(catalog.equals("101003001")){brandUrl="tuituji/lvdait/";}
	if(catalog.equals("101003004")){brandUrl="tuituji/lushit/";}
	
	if(catalog.equals("105003")){brandUrl="zhuanggongjixie/xuwa/";}
	if(catalog.equals("105004")){brandUrl="zhuanggongjixie/qiankou/";}
	if(catalog.equals("105005")){brandUrl="zhuanggongjixie/dingxiang/";}
	if(catalog.equals("105007")){brandUrl="zhuanggongjixie/lianxu/";}
	if(catalog.equals("105018")){brandUrl="zhuanggongjixie/luoxuan/";}
	if(catalog.equals("105009")){brandUrl="zhuanggongjixie/yazhuang/";}
	if(catalog.equals("105028")){brandUrl="zhuanggongjixie/jiezhuang/";}
	if(catalog.equals("105027")){brandUrl="zhuanggongjixie/qitaz/";}
	
	if(catalog.equals("110001")){brandUrl="kuangshanmeikuang/dungou/";}
	if(catalog.equals("110002")){brandUrl="kuangshanmeikuang/jueji/";}
	if(catalog.equals("110008")){brandUrl="kuangshanmeikuang/zaoyan/";}
	if(catalog.equals("110009")){brandUrl="kuangshanmeikuang/posui/";}
	if(catalog.equals("110012")){brandUrl="kuangshanmeikuang/shaifen/";}
	if(catalog.equals("110013")){brandUrl="kuangshanmeikuang/banyun/";}
	if(catalog.equals("110018")){brandUrl="kuangshanmeikuang/bazha/";}
	if(catalog.equals("110019")){brandUrl="kuangshanmeikuang/caimei/";}
	
	if(catalog.equals("101008002")){brandUrl="zixieche/gangxing/";}
	if(catalog.equals("101008001")){brandUrl="zixieche/jiaojie/";}
	
	if(catalog.equals("122001")){brandUrl="huanweicheliang/qingsao/";}
	if(catalog.equals("122002")){brandUrl="huanweicheliang/laji/";}
	if(catalog.equals("122003")){brandUrl="huanweicheliang/qingxue/";}
	if(catalog.equals("122004")){brandUrl="huanweicheliang/sashui/";}
	if(catalog.equals("122005")){brandUrl="huanweicheliang/wushui/";}
	if(catalog.equals("122006")){brandUrl="huanweicheliang/zhuanyun/";}
	
	if(catalog.equals("118001")){brandUrl="zhuanyongcheliang/putong/";}
	if(catalog.equals("118013")){brandUrl="zhuanyongcheliang/gonglu/";}
	if(catalog.equals("118004")){brandUrl="zhuanyongcheliang/qianyin/";}
	if(catalog.equals("118003")){brandUrl="zhuanyongcheliang/xiaofang/";}
	if(catalog.equals("118012")){brandUrl="zhuanyongcheliang/qingzhang/";}
	if(catalog.equals("118005")){brandUrl="zhuanyongcheliang/lengcang/";}
	if(catalog.equals("118006")){brandUrl="zhuanyongcheliang/huoxiang/";}
	if(catalog.equals("118007")){brandUrl="zhuanyongcheliang/fenguan/";}
	if(catalog.equals("118008")){brandUrl="zhuanyongcheliang/youguan/";}
	if(catalog.equals("118009")){brandUrl="zhuanyongcheliang/yeguan/";}
	if(catalog.equals("118010")){brandUrl="zhuanyongcheliang/fandou/";}
	if(catalog.equals("118011")){brandUrl="zhuanyongcheliang/zhatu/";}
	if(catalog.equals("118014")){brandUrl="zhuanyongcheliang/bangua/";}
	if(catalog.equals("118002")){brandUrl="zhuanyongcheliang/qtzy/";}

	
	if(catalog.equals("107011")){brandUrl="chache/neiran/";}
	if(catalog.equals("107012")){brandUrl="chache/diandong/";}
	if(catalog.equals("107013")){brandUrl="chache/cemian/";}
	if(catalog.equals("107014")){brandUrl="chache/qiyi/";}
	if(catalog.equals("107015")){brandUrl="chache/banyunche/";}
	if(catalog.equals("107016")){brandUrl="chache/duigaoji/";}
	if(catalog.equals("107017")){brandUrl="chache/cangchu/";}
	if(catalog.equals("107018")){brandUrl="chache/zhuanyong/";}
	
	if(catalog.equals("109006")){brandUrl="qiaoliangjixie/shajiang/";}
	if(catalog.equals("109005")){brandUrl="qiaoliangjixie/jiance/";}
	if(catalog.equals("109004")){brandUrl="qiaoliangjixie/tiliang/";}
	if(catalog.equals("109002")){brandUrl="qiaoliangjixie/yunliang/";}
	if(catalog.equals("109001")){brandUrl="qiaoliangjixie/jiaqiao/";}
	
	if(catalog.equals("111001")){brandUrl="gangkoujixie/zhengmian/";}
	if(catalog.equals("111004")){brandUrl="gangkoujixie/menshi/";}
	if(catalog.equals("111002")){brandUrl="gangkoujixie/matou/";}
	if(catalog.equals("111003")){brandUrl="gangkoujixie/xiechuan/";}
	if(catalog.equals("111007")){brandUrl="gangkoujixie/tuiba/";}


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
	if(ton_tdk.equals("3")&&catalog.equals("101002")){ newKeyWord="30装载机,30铲车,3吨装载机";}
	if(ton_tdk.equals("5")&&catalog.equals("101002")){ newKeyWord="50装载机,50铲车,5吨装载机";}
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
	if(catalognum_new.equals("122006")&&newTitle.indexOf("转运站")<0){
		newDesc=newDesc+"垃圾转运站";
		newTitle=newTitle+"垃圾转运站";
	}
	String catalog_numms=catalog;
	if(catalog.equals("140")){catalog_numms="101001098";}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%if(catalognum_new.equals("101001")&&tonandmeter.equals("g_0_4")&&factory.equals("")&&factoryids.equals("")){%>
<title>[微型挖掘机]微挖/迷你小挖机/微型挖掘机价格表_挖掘机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002008")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){%>
<title>[挖掘装载机]两头忙/挖掘装载机价格表_两头忙型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101001004")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")){%>
<title>[轮式挖掘机]轮挖/轮式挖掘机价格表_挖掘机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&tonandmeter.equals("l_0_3")&&factory.equals("")&&factoryids.equals("")){%>
<title>[小型装载机]小装/小铲车/小型装载机价格表_小型装载机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101001")&&tonandmeter.equals("g_35_1")&&factory.equals("")&&factoryids.equals("")){%>
<title>[大型挖掘机]矿用挖掘机/大型挖掘机价格表_挖掘机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101001")&&factory.equals("174")&&tonandmeter.equals("") ){%>
<title>[卡特挖掘机]卡特彼勒挖掘机/卡特挖掘机价格表_型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("3")){%>
<title>[30铲车]30铲车价格大全_30铲车参数 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("3t")){%>
<title>[3吨装载机]3吨装载机价格大全_3吨装载机参数 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("30t")){%>
<title>[30装载机]30装载机价格大全_30装载机参数 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("5")){%>
<title>[50装载机]50装载机价格大全_50装载机参数 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("50t")){%>
<title>[50铲车]50铲车价格大全_50铲车参数 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("5t")){%>
<title>[5吨装载机]5吨装载机价格大全_5吨装载机参数 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101001")&&ton_tdk.equals("200t")){%>
<title>[200挖掘机]200挖掘机价格大全_200挖掘机参数 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101001")&&ton_tdk.equals("20")){%>
<title>[20吨挖掘机]20吨挖掘机价格大全_20吨挖掘机参数 - 铁臂商城</title>
<%}else if(m.equals("yy")){%>
<title>[液压挖掘机]液压挖掘机价格表_挖掘机型号大全 - 铁臂商城</title>
<%}else if(catalog.equals("101001")&&tonandmeter.equals("g_4_8")&&factory.equals("")&&factoryids.equals("")){%>
<title>[小型挖掘机]小型挖掘机价格表_挖掘机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("106001001")&&tonandmeter.equals("r_0_10")&&factory.equals("")&&factoryids.equals("")){%>
<title>[小型压路机]小型压路机价格表_压路机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("101002")&&tonandmeter.equals("l_5_1")&&factory.equals("")&&factoryids.equals("")){%>
<title>[大型装载机]大型装载机价格表_装载机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("105003")&&tonandmeter.equals("d_0.5_1")&&factory.equals("")&&factoryids.equals("")){%>
<title>[小型旋挖钻机]小型旋挖钻机价格表_旋挖钻机型号大全 - 铁臂商城</title>
<%}else if(catalognum_new.equals("102007")&&tonandmeter.equals("")&&factory.equals("")&&factoryids.equals("")&&ton.equals("")){%>
<title>[汽车起重机]汽车吊/汽车起重机价格表_汽车起重机型号大全 - 铁臂商城</title>
<%}else{%>
<title>[<%=newTitle%>]<%=newTitle%>价格表_<%=newTitle%>型号大全 - 铁臂商城</title>
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
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("3")){%>
<meta name="keywords" content="30铲车,30铲车价格大全,30铲车参数" />
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("3t")){%>
<meta name="keywords" content="3吨装载机,3吨装载机价格大全,3吨装载机参数" />
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("30t")){%>
<meta name="keywords" content="30装载机,30装载机价格大全,30装载机参数" />
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("5")){%>
<meta name="keywords" content="50装载机,50装载机价格大全,50装载机参数" />
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("50t")){%>
<meta name="keywords" content="50铲车,50铲车价格大全,50铲车参数" />
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("5t")){%>
<meta name="keywords" content="5吨装载机,5吨装载机价格大全,5吨装载机参数" />
<%}else if(catalognum_new.equals("101001")&&ton_tdk.equals("20")){%>
<meta name="keywords" content="20吨挖掘机,20吨挖掘机价格大全,20吨挖掘机参数" />
<%}else if(catalognum_new.equals("101001")&&ton_tdk.equals("200t")){%>
<meta name="keywords" content="200挖掘机,200挖掘机价格大全,200挖掘机参数" />
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
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("3")){%>
<meta name="description" content="铁臂商城,提供2018最新30铲车价格查询,包含全部品牌的30铲车型号,报价及本地报价优惠信息查询,最新30铲车报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("3t")){%>
<meta name="description" content="铁臂商城,提供2018最新3吨装载机价格查询,包含全部品牌的3吨装载机型号,报价及本地报价优惠信息查询,最新3吨装载机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("30")){%>
<meta name="description" content="铁臂商城,提供2018最新30装载机价格查询,包含全部品牌的30装载机型号,报价及本地报价优惠信息查询,最新30装载机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("5")){%>
<meta name="description" content="铁臂商城,提供2018最新50装载机价格查询,包含全部品牌的50装载机型号,报价及本地报价优惠信息查询,最新50装载机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("50t")){%>
<meta name="description" content="铁臂商城,提供2018最新50铲车价格查询,包含全部品牌的50铲车型号,报价及本地报价优惠信息查询,最新50铲车报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101002")&&ton_tdk.equals("5t")){%>
<meta name="description" content="铁臂商城,提供2018最新5吨装载机价格查询,包含全部品牌的5吨装载机型号,报价及本地报价优惠信息查询,最新5吨装载机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101001")&&ton_tdk.equals("200t")){%>
<meta name="description" content="铁臂商城,提供2018最新200挖掘机价格查询,包含全部品牌的200挖掘机型号,报价及本地报价优惠信息查询,最新200挖掘机报价信息尽在铁臂商城.[欢迎询低价]" />
<%}else if(catalognum_new.equals("101001")&&ton_tdk.equals("20")){%>
<meta name="description" content="铁臂商城,提供2018最新20吨挖掘机价格查询,包含全部品牌的20吨挖掘机型号,报价及本地报价优惠信息查询,最新20吨挖掘机报价信息尽在铁臂商城.[欢迎询低价]" />
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
<meta name="mobile-agent" content="format=html5;url=http://m.21-sun.com/product/p_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>_<%=ton_url%>_0_1_0.htm">
<script type="text/javascript" src="/Static/app/mobile.js"></script>
<script type="text/javascript">uaredirect("http://m.21-sun.com/product/p_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>_<%=ton_url%>_0_1_0.htm");</script>
<link rel="stylesheet" type="text/css" href="../resources2018/css/common.css" />
<link rel="stylesheet" type="text/css" href="../resources2018/css/style.css" />
<link href="/Static/css/style.css" rel="stylesheet" />
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
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?998e4dbd9441f628020df509fd0e9f3c";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
</head>
<body class="list machine">
<!--top_bar-->
<div class="topbar tb-topbar">
  <div class="wrap fix">
    <div class="wel l"><span class="l"><a target="_blank" href="http://www.21-sun.com/">欢迎您访问中国工程机械商贸网！</a></span>
      <ul class="l">
        <li> <a href="http://member.21-sun.com/member_login.jsp" target="_blank">[登录]</a> </li>
        <li> <a href="http://member.21-sun.com/member_reg.jsp" target="_blank">[注册]</a> </li>
      </ul>
    </div>
    <div class="sun-links r">
      <div class="link-single"> <a class="color-ff9400" href="http://toutiao.21-sun.com/" target="_blank">铁臂头条</a> </div>
      <div class="links-show links-list net-phone"> <a class="has-list" href="javascript:;"><i class="ion">&#xe631;</i>手机访问<i class="ion">&#xe63c;</i></a>
        <div class="list-box list-m"> <span class="over-line"></span>
          <ul class="fix">
            <li class="sun-mainnet"> <img src="http://www.21-sun.com/static/images/m_01.jpg" />
              <p><strong>21-SUN</strong><br>
                掌握全局，把握市场商机，行业大千世界，21SUN移网尽收眼底。 </p>
            </li>
            <li class="sun-news"> <img src="http://www.21-sun.com/static/images/m_02.jpg" />
              <p><strong>行业动态</strong><br>
                洞悉行业千百态，随时随地实时看。全方位解读工程机械，别无他恋。 </p>
            </li>
            <li class="sun-mall"> <img src="http://www.21-sun.com/static/images/m_03.jpg" />
              <p><strong>铁臂商城</strong><br>
                优惠多，机型全，在齐全的设备库中体验优惠的设备选购快感。 </p>
            </li>
          </ul>
        </div>
      </div>
      <div class="links-show links-list wechat-focus"> <a class="has-list" href="javascript:;">微信关注<i class="ion">&#xe63c;</i></a>
        <div class="list-box list-wechat"> <span class="over-line"></span>
          <ul class="fix">
            <li>
              <div class="pic-box l"> <img src="http://www.21-sun.com/static/images/shangmao.jpg">
                <p>[扫一扫]</p>
              </div>
              <div class="txt-box r">
                <p>微信名称：<strong>中国工程机械商贸网</strong></p>
                <p>微信号：<strong>www21sun</strong></p>
                <p>它陪伴、见证、服务了工程机械的一个时代、一代又一代的工程机械人。 关注21SUN，跟随21SUN，倾听行业的声音，探寻行业的足迹，感受行业的脉搏。探索行业的未来 </p>
              </div>
            </li>
            <li>
              <div class="pic-box l"> <img src="http://www.21-sun.com/static/images/tbmall.jpg">
                <p>[扫一扫]</p>
              </div>
              <div class="txt-box r">
                <p>微信名称：<strong>铁臂商城</strong></p>
                <p>微信号：<strong>TIEBIMALL</strong></p>
                <p>如何选购机器型号？哪家有优惠活动？设备市场表现怎样？<br>
                  您要知道的，都在这里。 <br>
                  设备采购咨询热线：4006-521-526 </p>
              </div>
            </li>
            <li>
              <div class="pic-box l"> <img src="http://www.21-sun.com/static/images/xdl.jpg">
                <p>[扫一扫]</p>
              </div>
              <div class="txt-box r">
                <p>微信名称：<strong>铁臂兄弟连</strong></p>
                <p>微信号：<strong>tbxdl110</strong></p>
                <p>结识战友，学习互动，提高业务，一起聊聊那些人那些事还有那些机器。这是是咱工程机械战友自己的圈子，新手、老司机、专业大拿，来者不拒。<br>
                  战友QQ群：73915368 </p>
              </div>
            </li>
          </ul>
        </div>
      </div>
      <div class="links-show links-list pro-nav show-active"> <a class="has-list" href="javascript:;">购机导航<i class="ion">&#xe63c;</i></a> </div>
      <div class="links-show links-list app-download"> <a class="has-list" href="javascript:;">APP下载<i class="ion">&#xe63c;</i></a>
        <div class="list-box list-app"> <span class="over-line"></span>
          <ul class="fix">
            <li>
              <div class="pic-box l"><img src="http://toutiao.21-sun.com/static/images/app/android.jpg"></div>
              <div class="txt-box">
                <p>微信扫一扫<br>
                  下载iPhone客户端 </p>
              </div>
            </li>
            <li>
              <div class="pic-box l"><img src="http://toutiao.21-sun.com/static/images/app/ios.jpg"></div>
              <div class="txt-box">
                <p>微信扫一扫<br>
                  下载Android客户端 </p>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="active-bg"></div>
<!--top_bar end-->
<!--top-->
<div class="wrap fix n_top">
  <div class="new_logo"> <a href="/" title="铁臂商城"><img src="../resources2018/images/logo.png" alt="铁臂商城"></a> </div>
  <div class="n_topSearch">
    <div class="input">
      <input id="keyword" name="keyword" type="text" placeholder="输入您要搜索的产品">
    </div>
    <button type="button" class="topBtn" onClick="tj3()">搜索</button>
  </div>
  <div class="fix r add_20180727"> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp" title="热门机型">热门机型</a> <a target="_blank" href="http://product.21-sun.com/brand/" title="品牌大全">品牌大全</a> <a target="_blank" href="http://product.21-sun.com/agent/" title="全国代理">全国代理</a> <a target="_blank" href="http://top.21-sun.com" title="铁臂指数">铁臂指数</a> </div>
</div>
<!--top end-->
<!--nav-->
<div class="navBox">
  <div class="navBar">
    <div class="wrap fix">
      <ul class="menu">
        <li> <a href="http://product.21-sun.com/">商城首页</a> </li>
        <li> <a href="http://product.21-sun.com/products/prolist.jsp" class="on">报价</a> </li>
        <li> <a target="_blank" href="http://photo.21-sun.com">图片</a> </li>
        <li> <a rel="nofollow"  href="http://product.21-sun.com/brand/" >品牌</a> </li>
        <li> <a target="_blank" href="http://top.21-sun.com/">排行榜</a> </li>
        <li> <a rel="nofollow" target="_blank" href="http://product.21-sun.com/agent/">代理商</a> </li>
        <li> <a target="_blank" rel="nofollow"  href="http://news.21-sun.com">资讯</a> </li>
      </ul>
      <div class="allCates">
        <div class="acn"><i class="ion">&#xe607;</i>全部产品分类</div>
      </div>
    </div>
  </div>
</div>
<!--nav end-->
<div class="wrap main fix">
  <!--left start-->
  <div class="page_left l">
    <div class="list_nav"> 
	<a title="挖掘机" href="/products/prolist.jsp?catalog=101001" <%if(catalog.equals("")||catalog.equals("101001")||catalog.equals("101001001")||catalog.equals("101001004")||catalog.equals("101001007")){%>class="on"<%}%> ><span>挖掘机</span></a> 
	<a title="属具" href="/products/prolist.jsp?catalog=140" <%if(catalog.equals("140")||catalog.equals("101001099")||catalog.equals("101001098")){%>class="on"<%}%>><span>属具</span></a>
	<a title="装载机" href="/products/prolist.jsp?catalog=101002" <%if(catalog.equals("101002")||catalog.equals("101002003")||catalog.equals("101002004")||catalog.equals("101002007")||catalog.equals("101002008")||catalog.equals("101002009")||catalog.equals("101002010")){%>class="on"<%}%>><span>装载机</span></a>
	<a title="推土机" href="/products/prolist.jsp?catalog=101003" <%if(catalog.equals("101003")||catalog.equals("101003001")||catalog.equals("101003004")){%>class="on"<%}%>><span>推土机</span></a>
	<a title="铲运机" href="/products/prolist.jsp?catalog=101005001" <%if(catalog.equals("101005001")){%>class="on"<%}%>><span>铲运机</span></a>
	<a title="平地机" href="/products/prolist.jsp?catalog=101005002" <%if(catalog.equals("101005002")){%>class="on"<%}%>><span>平地机</span></a>
	<a title="汽车吊" href="/products/prolist.jsp?catalog=102007" <%if(catalog.equals("102007")||catalog.equals("102007")||catalog.equals("102007")){%>class="on"<%}%>><span>汽车吊</span></a>
	<a title="自卸卡车/矿卡" href="/products/prolist.jsp?catalog=101008" <%if(catalog.equals("101008")||catalog.equals("101008001")||catalog.equals("101008002")){%>class="on"<%}%>><span>自卸卡车/矿卡</span></a>
	<a title="起重机" href="/products/prolist.jsp?catalog=102" <%if(catalog.equals("102")||catalog.equals("102002")||catalog.equals("102003")||catalog.equals("102006")||catalog.equals("102008")||catalog.equals("102011")||catalog.equals("102012")||catalog.equals("102013")){%>class="on"<%}%>><span>起重机</span></a>
	<a title="混凝土机械" href="/products/prolist.jsp?catalog=103" <%if(catalog.equals("103")||catalog.equals("103001")||catalog.equals("103002")||catalog.equals("103005")||catalog.equals("103008")||catalog.equals("103015")||catalog.equals("103017")||catalog.equals("103018")||catalog.equals("103019")||catalog.equals("103020")||catalog.equals("103010")){%>class="on"<%}%>><span>混凝土机械</span></a>
	<a title="路面机械" href="/products/prolist.jsp?catalog=104" <%if(catalog.equals("104")||catalog.equals("104001")||catalog.equals("104002")||catalog.equals("104003")||catalog.equals("104004")||catalog.equals("104005")||catalog.equals("104009")||catalog.equals("104008")||catalog.equals("104006")){%>class="on"<%}%>><span>路面机械</span></a>
	<a title="钻机/桩机" href="/products/prolist.jsp?catalog=105" <%if(catalog.equals("105")||catalog.equals("105003")||catalog.equals("105004")||catalog.equals("105005")||catalog.equals("105007")||catalog.equals("105009")||catalog.equals("105018")||catalog.equals("105027")||catalog.equals("105028")){%>class="on"<%}%>><span>钻机/桩机</span></a>
	<a title="压实机械" href="/products/prolist.jsp?catalog=106001" <%if(catalog.equals("106001")||catalog.equals("106001001")||catalog.equals("106001002")||catalog.equals("106001003")||catalog.equals("106001004")||catalog.equals("106001005")||catalog.equals("106001020")||catalog.equals("106001021")){%>class="on"<%}%>><span>压实机械</span></a>
	<a title="叉车" href="/products/prolist.jsp?catalog=107" <%if(catalog.equals("107")||catalog.equals("107011")||catalog.equals("107012")||catalog.equals("107013")||catalog.equals("107014")||catalog.equals("107015")||catalog.equals("107016")||catalog.equals("107017")||catalog.equals("107018")){%>class="on"<%}%>><span>叉车</span></a>
	<a title="桥梁机械" href="/products/prolist.jsp?catalog=109" <%if(catalog.equals("109")||catalog.equals("109001")||catalog.equals("109002")||catalog.equals("109004")||catalog.equals("109005")){%>class="on"<%}%>><span>桥梁机械</span></a>
	<a title="矿山/煤矿机械" href="/products/prolist.jsp?catalog=110" <%if(catalog.equals("110")||catalog.equals("110001")||catalog.equals("110002")||catalog.equals("110008")||catalog.equals("110009")||catalog.equals("110019")||catalog.equals("110012")||catalog.equals("110013")||catalog.equals("110018")){%>class="on"<%}%>><span>矿山/煤矿机械</span></a>
	<a title="港口机械" href="/products/prolist.jsp?catalog=111"  <%if(catalog.equals("111")||catalog.equals("111001")||catalog.equals("111002")||catalog.equals("111003")||catalog.equals("111004")||catalog.equals("111007")){%>class="on"<%}%>><span>港口机械</span></a> 
	<a title="专用车辆" href="/products/prolist.jsp?catalog=118"  <%if(catalog.equals("118")||catalog.equals("118001")||catalog.equals("118013")||catalog.equals("118004")||catalog.equals("118003")||catalog.equals("118012")||catalog.equals("118005")||catalog.equals("118007")||catalog.equals("118008")||catalog.equals("118009")||catalog.equals("118010")||catalog.equals("118011")||catalog.equals("118002")||catalog.equals("118014")){%>class="on"<%}%>><span>专用车辆</span></a>
	<a title="环卫车辆" href="/products/prolist.jsp?catalog=122"  <%if(catalog.equals("122")||catalog.equals("122001")||catalog.equals("122002")||catalog.equals("122003")||catalog.equals("122004")||catalog.equals("122005")){%>class="on"<%}%>><span>环卫车辆</span></a>
	</div>
	
	<div class="adv">
		<a href="https://www.wenjuan.com/s/3M7Bjqg/"><img src="/images/list_bices.jpg"/></a>
	</div>
  </div>
  <!--left end-->
  <!--right start-->
  <div class="page_right r">
    <!--面包屑 start-->
    <div class="breadCrumbs">我的位置： <a href="/">商城首页</a><em>&gt;&gt;</em> <a href="http://product.21-sun.com/products/prolist.jsp">设备导购</a><em>&gt;&gt;</em><%=newTitle%> </div>
    <!--面包屑 end-->
    <!--筛选 start-->
    <div class="screening">
      <div class="sc_head fix">
        <h1 class="name l">
          <%if(catalog.equals("101002")&&ton.equals("3")){%>
          30装载机
          <%}else if(catalog.equals("101002")&&ton.equals("5")){%>
          50装载机
          <%}else{%>
          <%=newTitle%>
          <%}%>
        </h1>
        <div class="count l">搜索到<span><%=totalParts%></span>件相关商品</div>
        <div class="a_box r">
		<%if(catalog.equals("")){%>
		<a title="图片大全" target="_blank" href="/photo/">图片大全</a>
		<a title="品牌大全" target="_blank" href="/brand/">品牌大全</a> </div>
		<%}else{%>
		<a title="<%=CommonString.getFormatPara(catalogMap.get(catalog))%>图片" target="_blank" href="/photo/list.jsp?catalog=<%=catalog%>"><%=CommonString.getFormatPara(catalogMap.get(catalog))%>图片</a>
		<a title="<%=CommonString.getFormatPara(catalogMap.get(catalog))%>品牌" target="_blank" href="/brand/<%=brandUrl%>"><%=CommonString.getFormatPara(catalogMap.get(catalog))%>品牌</a> </div>
		<%}%>
      </div>
      <%if(brandList!=null&&brandList.size()>0){ %>
      <div class="sc_line fix line_brand">
        <div class="line_head l">品牌 <a href="javascript:void(0);" class="sx sx_gn" id="gn">国内品牌</a> <a href="javascript:void(0);" class="sx sx_gw" id="gw">国外品牌</a> <a href="javascript:void(0);" class="sx sx_all" id="sy">所有品牌</a> </div>
        <div class="line_main l fix">
          <div class="cho_f fix">
            <input type="text" class="l" placeholder="可搜拼音、汉字查找品牌" />
            <div class="f_box fix l" id="letters"> <a href="javascript:void(0);" class="l" data-val="A">A</a> <a href="javascript:void(0);" class="l" data-val="B">B</a> <a href="javascript:void(0);" class="l" data-val="C">C</a> <a href="javascript:void(0);" class="l" data-val="D">D</a> <a href="javascript:void(0);" class="l" data-val="F">F</a> <a href="javascript:void(0);" class="l" data-val="G">G</a> <a href="javascript:void(0);" class="l" data-val="H">H</a> <a href="javascript:void(0);" class="l" data-val="J">J</a> <a href="javascript:void(0);" class="l" data-val="K">K</a> <a href="javascript:void(0);" class="l" data-val="L">L</a> <a href="javascript:void(0);" class="l" data-val="M">M</a> <a href="javascript:void(0);" class="l" data-val="N">N</a> <a href="javascript:void(0);" class="l" data-val="O">O</a> <a href="javascript:void(0);" class="l" data-val="P">P</a> <a href="javascript:void(0);" class="l" data-val="Q">Q</a> <a href="javascript:void(0);" class="l" data-val="R">R</a> <a href="javascript:void(0);" class="l" data-val="S">S</a> <a href="javascript:void(0);" class="l" data-val="T">T</a> <a href="javascript:void(0);" class="l" data-val="W">W</a> <a href="javascript:void(0);" class="l" data-val="X">X</a> <a href="javascript:void(0);" class="l" data-val="Y">Y</a> <a href="javascript:void(0);" class="l" data-val="Z">Z</a> </div>
            <a href="javascript:void(0);" class="height r"><i class="te">更多</i><i class="ion">&#xe63c;</i></a> </div>
          <div class="brand_box fix" id="brand_list">
		  
            <%for(Map oneMap : brandList){%>
			<%if(CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog_numms.equals("")?"0":catalog_numms)))!=0){%>
            <a title="<%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalog_numms)).replace("/属具","")%>" href="/products/prolist.jsp?factory=<%=CommonString.getFormatPara(oneMap.get("id"))%><%=catalog_numms.equals("")?"":"&catalog="+catalog_numms%><%=tont.equals("")?"":"&ton="+tont%><%=year.equals("1")?"":"&year="+year%>" data-let="A" class="l <%if(CommonString.getFormatPara(oneMap.get("is_inner")).equals("1")){%>gn<%}else{%>gw<%}%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span>(<%=CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog_numms.equals("")?"0":catalog_numms)))%>)</span></a>
            <%}}%>
          </div>
        </div>
      </div>
      <%}%>
      <% if(catalog.equals("")){if(factoryid.equals("")&&factoryids.equals("")){if(topCatalogList!=null&&topCatalogList.size()>0){%>
      <div class="sc_line fix line_kind">
        <div class="line_head l">产品类别</div>
        <div class="line_main l fix">
          <%for(Map oneMap:topCatalogList){%>
          <%if(!CommonString.getFormatPara(oneMap.get("num")).equals("101005")){%>
          <a href="/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>" class="l" title="<%=CommonString.getFormatPara(oneMap.get("name"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span>(<%=CommonString.getFormatInt(cataProMap.get(CommonString.getFormatPara(oneMap.get("num"))))%>)</span></a>
          <%}}%>
        </div>
      </div>
      <%}}else{%>
      <div class="sc_line fix line_kind">
        <div class="line_head l">产品类别</div>
        <div class="line_main l fix">
          <%
					    for(Map oneMap:topCatalogList){
							if(!CommonString.getFormatPara(oneMap.get("num")).equals("101005")){
					                if(!factoryids.equals("")){
					                    int allSum=0;
						                for(int i=0;i<factoryArray.length;i++){
	                                        if(!CommonString.getFormatPara(factoryArray[i]).equals("")){
								                allSum+=CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(factoryArray[i])+"_"+(CommonString.getFormatPara(oneMap.get("num")))));
							                }
	                                    }
		%>
          <a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>" class="l" title="<%=CommonString.getFormatPara(oneMap.get("name"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span>(<%=allSum%>)</span></a>
          <%}else if(factoryid.equals("")||factoryid.equals("0")){%>
          <a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>" class="l" title="<%=CommonString.getFormatPara(oneMap.get("name"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span>(<%=CommonString.getFormatInt(brandProMap.get((CommonString.getFormatPara(oneMap.get("num")))))%>)</span></a>
          <%}else{%>
          <a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>" class="l" title="<%=CommonString.getFormatPara(oneMap.get("name"))%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><span>(<%=CommonString.getFormatInt(brandProMap.get(factoryid+"_"+(CommonString.getFormatPara(oneMap.get("num")))))%>)</span></a>
          <%}}%>
          <%}%>
        </div>
      </div>
      <%}}%>
      <%if(!catalog.equals("")){if(catalogSecondList!=null&&catalogSecondList.size()>0){%>
      <div class="sc_line fix line_kind">
        <div class="line_head l">产品类型</div>
        <div class="line_main l fix">
          <%for(Map oneMap:catalogSecondList){%>
          <%if(!CommonString.getFormatPara(oneMap.get("num")).equals("102007")){%>
          <%  if(!factoryids.equals("")){ int allSum=0; for(int i=0;i<factoryArray.length;i++){ if(!CommonString.getFormatPara(factoryArray[i]).equals("")){ allSum+=CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(factoryArray[i])+"_"+(CommonString.getFormatPara(oneMap.get("num"))))); } }  %>
          <a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>" class="l"><%=CommonString.getFormatPara(oneMap.get("name"))%><span>(<%=allSum%>)</span></a>
          <%}else if(factoryid.equals("")){%>
          <a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>" class="l"><%=CommonString.getFormatPara(oneMap.get("name"))%><span>(<%=CommonString.getFormatInt(cataProMap.get((CommonString.getFormatPara(oneMap.get("num")))))%>)</span></a>
          <%}else{if(CommonString.getFormatInt(brandProMap.get(factoryid+"_"+(CommonString.getFormatPara(oneMap.get("num")))))!=0){%>
          <a title="<%=CommonString.getFormatPara(oneMap.get("name"))%>" href="/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=<%=CommonString.getFormatPara(oneMap.get("num"))%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>" class="l"><%=CommonString.getFormatPara(oneMap.get("name"))%><span>(<%=CommonString.getFormatInt(brandProMap.get(factoryid+"_"+(CommonString.getFormatPara(oneMap.get("num")))))%>)</span></a>
          <%}}%>
          <%}%>
          <%}%>
        </div>
      </div>
      <%}}%>
      <%if(catalog.equals("101001")||catalog.equals("101001001")||catalog.equals("101001004")||catalog.equals("101002007")||catalog_detail.equals("102")||catalog_detail.equals("102007")||catalog.equals("106001001")){%>
      <div class="sc_line fix line_heavy">
        <div class="line_head l">吨位</div>
        <div class="line_main l fix">
          <%if((catalog.equals("101001")||catalog.equals("101001001")||catalog.equals("101001004"))){%>
          <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_0_6">迷你挖(3T以下)</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_1_13">小挖(4T～8T)</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_8_15">中小挖(8T～15T)</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_14_30">中挖(15T～25T)</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_25_35">中大挖(25T～35T)</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=<%=catalog%>&ton=g_30_1">大挖(35T以上)</a>
          <%} else if(catalog.equals("101001004")){%>
          <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101001004&ton=g_0_6">迷你挖(3T以下)</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101001004&ton=g_1_13">小挖(4T～8T)</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101001004&ton=g_8_15">中小挖(8T～15T)</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101001004&ton=g_14_30">中挖(15T～25T)</a>
          <%}else if(catalog.equals("101002007")){%>
          <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101002007&ton=l_1_3">小装(3T以下)</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101002007&ton=l_3_01">3T</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101002007&ton=l_3_5">5T</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=101002007&ton=l_5_1">5T以上</a>
          <%}else if(catalog_detail.equals("102")){%>
          <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102&ton=c_1_16">16T以下</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102&ton=c_20_70">20T～70T</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102&ton=c_70_1">70T以上</a>
          <%}else if(catalog_detail.equals("102007")){%>
          <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102007&ton=c_1_16">16T以下</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102007&ton=c_20_70">20T～70T</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=102007&ton=c_70_1">70T以上</a>
          <%}else if(catalog.equals("106001001")){%>
          <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=106001001&ton=r_0_10">10T以下</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=106001001&ton=r_12_18">12T～18T</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=106001001&ton=r_20_01">20T</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?f="+factoryid+"&"%>c=106001001&ton=r_20_1">20T以上</a>
          <%}%>
        </div>
      </div>
      <%}%>
      <%if(catalog_detail.equals("103001")){%>
      <div class="sc_line fix line_heavy">
        <div class="line_head l">臂架长度</div>
        <div class="line_main l fix"> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_0_36">36米以下</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_36_44">36-44米</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_45_47">45-47米</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_48_52">48-52米</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_53_56">53-56米</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=103001&tonandmeter=lift_56_1">56米以上</a> </div>
      </div>
      <%}%>
      <%if(catalog_detail.equals("105003")){%>
      <div class="sc_line fix line_heavy">
        <div class="line_head l">直径(m)</div>
        <div class="line_main l fix"> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=105003&tonandmeter=drill_0.5_1">0.5～1</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=105003&tonandmeter=drill_0.8_1.8">0.8～1.8</a> <a class="l" href="http://product.21-sun.com/products/prolist.jsp<%= factoryid.equals("")?"?":"?factory="+factoryid+"&"%>catalog=105003&tonandmeter=drill_1_2.5">1～2.5</a> </div>
      </div>
      <%}%>
      <!-- 
      <div class="sc_line fix line_k">
        <div class="line_head l">产品类型</div>
        <div class="line_main l fix"> <a href="javascript:void(0);" class="l">挖掘机/属具<span>(2030)</span></a> <a href="javascript:void(0);" class="l">挖掘机/属具<span>(2030)</span></a> <a href="javascript:void(0);" class="l">挖掘机/属具<span>(2030)</span></a> <a href="javascript:void(0);" class="l">挖掘机/属具<span>(2030)</span></a> <a href="javascript:void(0);" class="l">挖掘机/属具<span>(2030)</span></a> <a href="javascript:void(0);" class="l">挖掘机/属具<span>(2030)</span></a> <a href="javascript:void(0);" class="l">挖掘机/属具<span>(2030)</span></a> <a href="javascript:void(0);" class="l">挖掘机/属具<span>(2030)</span></a> </div>
      </div>
	  -->
      <%if(!factoryid.equals("")||!factoryids.equals("")||!catalog.equals("")||!tonandmeter.equals("")){%>
      <div class="sc_line fix cho_show">
        <div class="line_head l">已选条件</div>
        <div class="line_main l fix">
          <%if(!factoryid.equals("")){%>
          <div class="cho_item l">
            <p class="l">品牌：<span><%=CommonString.getFormatPara(brandMap.get(factoryid))%></span></p>
            <a title="<%=CommonString.getFormatPara(brandMap.get(factoryid))%>" href="/products/prolist.jsp<%=catalog.equals("")?"":"?catalog="+catalog%>" class="l"><i class="ion">&#xe611;</i></a> </div>
          <%}%>
          <%if(!factoryids.equals("")){%>
          <div class="cho_item l">
            <p class="l">品牌：<span><%=factoryNames%></span></p>
            <a title="<%=factoryNames%>" href="/products/prolist.jsp<%=catalog.equals("")?"":"?catalog="+catalog%>" class="l"><i class="ion">&#xe611;</i></a> </div>
          <%}%>
          <%if(!catalog.equals("")){%>
          <div class="cho_item l">
            <p class="l">类型：<span><%=CommonString.getFormatPara(catalogMap.get(catalog))%></span></p>
            <a title="<%=CommonString.getFormatPara(catalogMap.get(catalog))%>" href="/products/prolist.jsp<%=factoryid.equals("")?"":"?factory="+factoryid%>" class="l"><i class="ion">&#xe611;</i></a> </div>
          <%}%>
          <%if(!tonandmeter.equals("")){String showname="吨位";if(catalog_detail.equals("105003")){ showname="直径(m)";}if(catalog_detail.equals("103001")){ showname="臂架长度";}%>
          <div class="cho_item l">
            <p class="l"><%=showname%>：<span><%=showtonandmeter%></span></p>
            <a title="<%=showtonandmeter%>" href="/products/prolist.jsp?catalog=<%=catalog%><%=factoryid.equals("")?"":"&factory="+factoryid%>" class="l"><i class="ion">&#xe611;</i></a> </div>
          <%}%>
          <a href="/products/prolist.jsp" class="clear_all l"><i class="ion">&#xe61e;</i>重置筛选条件</a> </div>
      </div>
      <%}%>
    </div>
    <!--筛选 end-->
    <%if(factory.equals("")&&catalog.equals("")){%>
    <!--热门机型 start-->
    <div class="marketing">
      <div class="marketing_hd pr fix">
        <p class="title pr l">推荐机型</p>
        <!--<a href="javascript:void(0);" class="exchange pr r">换一批<i class="ion">&#xe61e;</i></a>-->
      </div>
      <div class="marketing_bd fix"> 
	  <a title="三一SY60C挖掘机" target="_blank" href="/photo/detail_for_28675.htm" class="l el">三一SY60C挖掘机</a>
	  <a title="小松PC70-8挖掘机" target="_blank" href="/photo/detail_for_6849.htm" class="l el">小松PC70-8挖掘机</a>
	  <a title="卡特彼勒307E2挖掘机" target="_blank" href="/photo/detail_for_29164.htm" class="l el">卡特彼勒307E2挖掘机</a> 
	  <a title="卡特彼勒Cat®320GC挖掘机" target="_blank" href="/photo/detail_for_30221.htm" class="l el">卡特彼勒Cat®320GC挖掘机</a>
	  <a title="山工机械SEM618D装载机" target="_blank" href="/photo/detail_for_15628.htm" class="l el">山工机械SEM618D装载机</a> 
	  <a title="山东临工L933装载机" target="_blank" href="/photo/detail_for_7179.htm" class="l el">山东临工L933装载机</a> 
	  <a title="英轩重工YX655装载机" target="_blank" href="/photo/detail_for_15106.htm" class="l el">英轩重工YX655装载机</a> 
	  <a title="厦工XG932H轮式装载机" target="_blank" href="/photo/detail_for_20383.htm" class="l el">厦工XG932H轮式装载机</a>
	  <a title="三一SAC12000起重机" target="_blank" href="/photo/detail_for_7276.htm" class="l el">三一SAC12000起重机</a> 
	  <a title="徐工QY25K5-I起重机" target="_blank" href="/photo/detail_for_6373.htm" class="l el">徐工QY25K5-I起重机</a>
	  </div>
    </div>
    <!--热门机型 end-->
    <%}%>
	<!--热门机型 start-->
    <%if(catalog.indexOf("106001")>=0){%>
    <div class="marketing">
      <div class="marketing_hd pr fix">
        <p class="title pr l">热门机型</p>
      </div>
      <div class="marketing_bd fix"> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001&t=12" title="12吨压路机">12吨压路机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001&t=16" title="16吨压路机">16吨压路机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001&t=18" title="18吨压路机">18吨压路机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001&t=20" title="20吨压路机">20吨压路机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001&t=22" title="22吨压路机">22吨压路机</a> </div>
    </div>
    <%}%>
    <%if(catalog.indexOf("101002")>=0){%>
    <div class="marketing">
      <div class="marketing_hd pr fix">
        <p class="title pr l">热门机型</p>
      </div>
      <div class="marketing_bd fix">
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=3" title="30铲车">30铲车</a>
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=3t" title="3吨装载机">3吨装载机</a>
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=30t" title="30装载机">30装载机</a>
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=5" title="50装载机">50装载机</a>
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=50t" title="50铲车">50铲车</a> 
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&t=5t" title="5吨装载机">5吨装载机</a>
	  </div>
    </div>
    <%}%>
    <%if(catalog.indexOf("102007")>=0){%>
    <div class="marketing">
      <div class="marketing_hd pr fix">
        <p class="title pr l">热门机型</p>
      </div>
      <div class="marketing_bd fix"> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&t=8" title="8吨汽车吊">8吨汽车吊</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&t=12" title="12吨汽车吊">12吨汽车吊</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&t=16" title="16吨汽车吊">16吨汽车吊</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&t=25" title="25吨汽车吊">25吨汽车吊</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&t=50" title="50吨汽车吊">50吨汽车吊</a> </div>
    </div>
    <%}%>
    <%if(catalog.indexOf("103001")>=0){%>
    <div class="marketing">
      <div class="marketing_hd pr fix">
        <p class="title pr l">热门机型</p>
      </div>
      <div class="marketing_bd fix">  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=37" title="37米泵车">37米泵车</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=38" title="38米泵车">38米泵车</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=47" title="47米泵车">47米泵车</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=48" title="48米泵车">48米泵车</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=52" title="52米泵车">52米泵车</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=56" title="56米泵车">56米泵车</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=103001&t=62" title="62米泵车">62米泵车</a> </div>
    </div>
    <%}%>
    <%if(catalog.equals("101001")||catalog.equals("101001001")||catalog.equals("101001004")||catalog.equals("101001007")){%>
    <div class="marketing">
      <div class="marketing_hd pr fix">
        <p class="title pr l">热门机型</p>
      </div>
      <div class="marketing_bd fix">
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=yy" title="液压挖掘机">液压挖掘机</a> 
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&t=15" title="15吨挖掘机">15吨挖掘机</a>
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&t=200t" title="200挖掘机">200挖掘机</a> 
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&t=20" title="20吨挖掘机">20吨挖掘机</a> 
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=220" title="220挖掘机">220挖掘机</a>
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&t=30" title="30吨挖掘机">30吨挖掘机</a>
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=360" title="360挖掘机">360挖掘机</a> 
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=55" title="55挖掘机">55挖掘机</a> 
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=60" title="60挖掘机">60挖掘机</a>
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=65" title="65挖掘机">65挖掘机</a>
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=70" title="70挖掘机">70挖掘机</a>
	  <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001&m=85" title="85挖掘机">85挖掘机</a> </div>
    </div>
    <%}%>
    <!--热门机型 end-->
	
    <!--展示主体 start-->
    <div class="show_main">
      <!--条件 start-->
      <div class="shm_head fix">
        <div class="cons l pr fix"> <a href="http://product.21-sun.com/products/prolist.jsp?year=all<%= factoryids.equals("")?"":"&factoryids="+factoryids%><%= factoryid.equals("")?"":"&factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%>" class="l<%if(year.equals("all")){%> on<%}%>">全部</a>
          <%if(!factoryid.equals("")){%>
          <a href="http://product.21-sun.com/products/prolist.jsp?<%= factoryid.equals("")?"":"factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%>" class="l<%if(year.equals("1")){%> on<%}%>">在售</a>
          <%}else  if(!catalog.equals("")){%>
          <a href="http://product.21-sun.com/products/prolist.jsp?<%=catalog.equals("")?"":"catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%>" class="l<%if(year.equals("1")){%> on<%}%>">在售</a>
          <%}else{%>
          <a href="http://product.21-sun.com/products/prolist.jsp" class="l<%if(year.equals("1")){%> on<%}%>">在售</a>
          <%}%>
          <a href="http://product.21-sun.com/products/prolist.jsp?year=0<%= factoryids.equals("")?"":"&factoryids="+factoryids%><%= factoryid.equals("")?"":"&factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%>" class="l<%if(year.equals("0")){%> on<%}%>">停产</a> </div>
        <div class="orders r fix"> <a href="/products/prolist.jsp?order=normal<%= factoryids.equals("")?"":"&factoryids="+factoryids%><%= factoryid.equals("")?"":"&factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>" class="l <%if(!("sale").equals(order)){%>on<%}%>">热门</a> <a href="/products/prolist.jsp?order=sale<%= factoryids.equals("")?"":"&factoryids="+factoryids%><%= factoryid.equals("")?"":"&factory="+factoryid%><%=catalog.equals("")?"":"&catalog="+catalog%><%=tonandmeter.equals("")?"":"&tonandmeter="+tonandmeter%><%=year.equals("1")?"":"&year="+year%>" class="l <%if(("sale").equals(order)){%>on<%}%>">销量</a> </div>
      </div>
      <!--条件 end-->
      <!--筛选结果 start-->
      <div class="shm_con">
	  <%if(catalog.indexOf("101001")>=0){%><div class="fix"><img src="/images/cat_zbs_990.png"/></div><%}%>
        <%if(( catalog.equals(""))&&factoryid.equals("")&&nowPage==1){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="卡特彼勒Cat<sup>®</sup> 320液压挖掘机" href="http://product.21-sun.com/proDetail/320.shtm" target="_blank"><img alt="卡特彼勒Cat<sup>®</sup> 320液压挖掘机" src="http://product.21-sun.com/uploadfiles//image/2017/10/20171030133332_231.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/320.shtm" target="_blank">卡特彼勒Cat<sup>®</sup> 320液压挖掘机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/320.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320液压挖掘机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/320_parameter.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320液压挖掘机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/320_message.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320液压挖掘机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/320_pic.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320液压挖掘机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/320_agent.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320液压挖掘机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">总长度：9531</p>
              <p class="l">总宽度：3170</p>
              <p class="l">总高度（至驾驶棚顶部）：2960</p>
              <a href="http://product.21-sun.com/proDetail/320.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('30220','')" class="r ask_it">询低价</a> <a data-val="30220" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（464）</span> <a class="add_inquiry" data-val="30220" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="30220" href="javascript:void(0)">加入对比</a> <a title="更多卡特挖掘机" href="http://product.21-sun.com/products/prolist.jsp?factory=174&amp;catalog=101001" target="_blank">更多卡特挖掘机</a> </div>
          </div>
        </div>
        <%}%>
        <%if(( catalog.equals("101001004"))&&factoryid.equals("")&&nowPage==1){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="宝鼎BD95W-9A轮式挖掘机" href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ.shtm" target="_blank"><img alt="宝鼎BD95W-9A轮式挖掘机" src="http://product.21-sun.com/uploadfiles//image/2018/05/31/20180531115921_749.png" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ.shtm" target="_blank">宝鼎BD95W-9A轮式挖掘机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ.shtm" target="_blank" title="宝鼎BD95W-9A轮式挖掘机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ_parameter.shtm" target="_blank" title="宝鼎BD95W-9A轮式挖掘机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ_message.shtm" target="_blank" title="宝鼎BD95W-9A轮式挖掘机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ_pic.shtm" target="_blank" title="宝鼎BD95W-9A轮式挖掘机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ_agent.shtm" target="_blank" title="宝鼎BD95W-9A轮式挖掘机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">总长度：6369mm</p>
              <p class="l">总宽度：2030mm</p>
              <p class="l">总高度：2710mm</p>
              <a href="http://product.21-sun.com/proDetail/BD95W-9ALSWJJ.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('31695','')" class="r ask_it">询低价</a> <a data-val="31695" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（4）</span> <a class="add_inquiry" data-val="31695" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="31695" href="javascript:void(0)">加入对比</a> <a title="更多宝鼎挖掘机" href="http://product.21-sun.com/products/prolist.jsp?factory=13570&amp;catalog=101001" target="_blank">更多宝鼎挖掘机</a> </div>
          </div>
        </div>
        <%}%>
        <% if(catalog.equals("101001")&&tont.equals("g_1_13")&&factoryid.equals("")&&nowPage==1){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="卡特彼勒306E2挖掘机" href="http://product.21-sun.com/proDetail/306E2.shtm" target="_blank"><img alt="卡特彼勒306E2挖掘机" src="http://product.21-sun.com/uploadfiles//image/2017/10/20171018101808_908.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/306E2.shtm" target="_blank">卡特彼勒306E2挖掘机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/306E2.shtm" target="_blank" title="卡特彼勒306E2挖掘机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/306E2_parameter.shtm" target="_blank" title="卡特彼勒306E2挖掘机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/306E2_message.shtm" target="_blank" title="卡特彼勒306E2挖掘机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/306E2_pic.shtm" target="_blank" title="卡特彼勒306E2挖掘机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/306E2_agent.shtm" target="_blank" title="卡特彼勒306E2挖掘机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">总长度：312 mm</p>
              <p class="l">总宽度：1878 mm</p>
              <p class="l">总高度（至驾驶棚顶部）：2540 mm</p>
              <a href="http://product.21-sun.com/proDetail/306E2.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('23912','')" class="r ask_it">询低价</a> <a data-val="23912" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（106）</span> <a class="add_inquiry" data-val="23912" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="23912" href="javascript:void(0)">加入对比</a> <a title="更多卡特挖掘机" href="http://product.21-sun.com/products/prolist.jsp?factory=174&amp;catalog=101001" target="_blank">更多卡特挖掘机</a> </div>
          </div>
        </div>
        <%}%>
        <% if((catalog.equals("101001")||catalog.equals("101001001"))&&factoryid.equals("")&&nowPage==1){Random rand =new Random(); int wajueji; wajueji=rand.nextInt(10);%>
        <!--挖掘机广告-->
        <%if(wajueji==0){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="三一SY35U微型液压挖掘机" href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank"><img alt="三一SY35U微型液压挖掘机" src="http://product.21-sun.com/uploadfiles//image/2018/09/20180911164406_446.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank">三一SY35U微型液压挖掘机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank" title="三一SY35U微型液压挖掘机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/SY35_parameter.shtm" target="_blank" title="三一SY35U微型液压挖掘机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/SY35_message.shtm" target="_blank" title="三一SY35U微型液压挖掘机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/SY35_pic.shtm" target="_blank" title="三一SY35U微型液压挖掘机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/SY35_agent.shtm" target="_blank" title="三一SY35U微型液压挖掘机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">总长度：4915</p>
              <p class="l">总宽度：1720</p>
              <p class="l">总高度（至动臂顶部）：2515</p>
              <a href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('21005','')" class="r ask_it">询低价</a> <a data-val="21005" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（537）</span> <a class="add_inquiry" data-val="21005" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="21005" href="javascript:void(0)">加入对比</a> <a title="更多三一挖掘机" href="http://product.21-sun.com/products/prolist.jsp?factory=133&amp;catalog=101001" target="_blank">更多三一挖掘机</a> </div>
          </div>
        </div>
        <%}%>
        <%if(wajueji!=0&&wajueji!=2&&wajueji!=5&&wajueji!=6&&wajueji!=7){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机" href="http://product.21-sun.com/proDetail/320GC.shtm" target="_blank"><img alt="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机" src="http://product.21-sun.com/uploadfiles//image/2017/10/20171030140306_166.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/320GC.shtm" target="_blank">卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/320GC.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/320GC_parameter.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/320GC_message.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/320GC_pic.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/320GC_agent.shtm" target="_blank" title="卡特彼勒Cat<sup>®</sup> 320 GC液压挖掘机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">总长度：9531</p>
              <p class="l">总宽度：3170</p>
              <p class="l">总高度（至驾驶棚顶部）：2960</p>
              <a href="http://product.21-sun.com/proDetail/320GC.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('30221','')" class="r ask_it">询低价</a> <a data-val="30221" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（237）</span> <a class="add_inquiry" data-val="30221" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="30221" href="javascript:void(0)">加入对比</a> <a title="更多卡特挖掘机" href="http://product.21-sun.com/products/prolist.jsp?factory=174&amp;catalog=101001" target="_blank">更多卡特挖掘机</a> </div>
          </div>
        </div>
        <%}%>
        <%if(wajueji==2){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="三一SY35U微型液压挖掘机" href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank"><img alt="三一SY35U微型液压挖掘机" src="http://product.21-sun.com/uploadfiles//image/2018/09/20180911164406_446.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank">三一SY35U微型液压挖掘机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank" title="三一SY35U微型液压挖掘机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/SY35_parameter.shtm" target="_blank" title="三一SY35U微型液压挖掘机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/SY35_message.shtm" target="_blank" title="三一SY35U微型液压挖掘机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/SY35_pic.shtm" target="_blank" title="三一SY35U微型液压挖掘机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/SY35_agent.shtm" target="_blank" title="三一SY35U微型液压挖掘机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">总长度：4915</p>
              <p class="l">总宽度：1720</p>
              <p class="l">总高度（至动臂顶部）：2515</p>
              <a href="http://product.21-sun.com/proDetail/SY35.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('21005','')" class="r ask_it">询低价</a> <a data-val="21005" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（537）</span> <a class="add_inquiry" data-val="21005" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="21005" href="javascript:void(0)">加入对比</a> <a title="更多三一挖掘机" href="http://product.21-sun.com/products/prolist.jsp?factory=133&amp;catalog=101001" target="_blank">更多三一挖掘机</a> </div>
          </div>
        </div>
        <%}%>
		        <%if(wajueji==5||wajueji==6||wajueji==7){%>

		<div class="con_item fix on">
          <div class="item_img l"> <a title="神钢SK350LC-10履带挖掘机" href="http://product.21-sun.com/proDetail/SK350LC-10.shtm" target="_blank"><img alt="神钢SK350LC-10履带挖掘机" src="http://product.21-sun.com/uploadfiles//image/2018/05/20180509201856_764.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/SK350LC-10.shtm" target="_blank">神钢SK350LC-10履带挖掘机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/SK350LC-10.shtm" target="_blank" title="神钢SK350LC-10履带挖掘机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/SK350LC-10_parameter.shtm" target="_blank" title="神钢SK350LC-10履带挖掘机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/SK350LC-10_message.shtm" target="_blank" title="神钢SK350LC-10履带挖掘机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/SK350LC-10_pic.shtm" target="_blank" title="神钢SK350LC-10履带挖掘机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/SK350LC-10_agent.shtm" target="_blank" title="神钢SK350LC-10履带挖掘机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">  
              <p class="l des"><a href="http://product.21-sun.com/proDetail/SK350LC-10.shtm" target="_blank">[查看详情]</a></p>
            </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('30705','')" class="r ask_it">询低价</a> <a data-val="30705" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（4）</span> <a class="add_inquiry" data-val="30705" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="30705" href="javascript:void(0)">加入对比</a> <a title="更多神钢挖掘机" href="http://product.21-sun.com/products/prolist.jsp?factory=183&amp;catalog=101001" target="_blank">更多神钢挖掘机</a> </div>
          </div>
        </div>
		 <%}%>
        <%}%>
        <%if((catalog.equals("101002")||catalog.equals("101002007"))&&factoryid.equals("")&&nowPage==1){Random rand =new Random();int zhuangzaiji;zhuangzaiji=rand.nextInt(6);%>
        <!--装载机广告-->
        <%if(zhuangzaiji==0){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="山工SEM652D轮式装载机" href="http://product.21-sun.com/proDetail/SEM652D.shtm" target="_blank"><img alt="山工SEM652D轮式装载机" src="http://product.21-sun.com/uploadfiles//image/2016/04/20160414084318_701.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/SEM652D.shtm" target="_blank">山工SEM652D轮式装载机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/SEM652D.shtm" target="_blank" title="山工SEM652D轮式装载机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/SEM652D_parameter.shtm" target="_blank" title="山工SEM652D轮式装载机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/SEM652D_message.shtm" target="_blank" title="山工SEM652D轮式装载机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/SEM652D_pic.shtm" target="_blank" title="山工SEM652D轮式装载机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/SEM652D_agent.shtm" target="_blank" title="山工SEM652D轮式装载机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">总长度：8062</p>
              <p class="l">总宽度：2963</p>
              <p class="l">总高度：3348</p>
              <a href="http://product.21-sun.com/proDetail/SEM652D.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('863','')" class="r ask_it">询低价</a> <a data-val="863" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（1904）</span> <a class="add_inquiry" data-val="863" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="863" href="javascript:void(0)">加入对比</a> <a title="更多山工装载机" href="http://product.21-sun.com/products/prolist.jsp?factory=138&amp;catalog=101002" target="_blank">更多山工装载机</a> </div>
          </div>
        </div>
        <%}%>
        <%if(zhuangzaiji==1){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="厦工XG951H轮式装载机" href="http://product.21-sun.com/proDetail/XG951H.shtm" target="_blank"><img alt="厦工XG951H轮式装载机" src="http://product.21-sun.com/uploadfiles//image/2018/05/20180510093412_192.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/XG951H.shtm" target="_blank">厦工XG951H轮式装载机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/XG951H.shtm" target="_blank" title="厦工XG951H轮式装载机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/XG951H_parameter.shtm" target="_blank" title="厦工XG951H轮式装载机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/XG951H_message.shtm" target="_blank" title="厦工XG951H轮式装载机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/XG951H_pic.shtm" target="_blank" title="厦工XG951H轮式装载机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/XG951H_agent.shtm" target="_blank" title="厦工XG951H轮式装载机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">斗容范围：2.2～3.6</p>
              <p class="l">整机操作质量：16800</p>
              <p class="l">额定载重量：5000</p>
              <a href="http://product.21-sun.com/proDetail/XG951H.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('20381','')" class="r ask_it">询低价</a> <a data-val="20381" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（1073）</span> <a class="add_inquiry" data-val="20381" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="20381" href="javascript:void(0)">加入对比</a> <a title="更多厦工装载机" href="http://product.21-sun.com/products/prolist.jsp?factory=139&amp;catalog=101002" target="_blank">更多厦工装载机</a> </div>
          </div>
        </div>
        <%}%>
        <%if(zhuangzaiji==2){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="英轩重工YX656HPlus轮式装载机" href="http://product.21-sun.com/proDetail/YX656HPLUS.shtm" target="_blank"><img alt="英轩重工YX656HPlus轮式装载机" src="http://product.21-sun.com/uploadfiles//image/2018/05/20180529154623_974.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/YX656HPLUS.shtm" target="_blank">英轩重工YX656HPlus轮式装载机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/YX656HPLUS.shtm" target="_blank" title="英轩重工YX656HPlus轮式装载机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/YX656HPLUS_parameter.shtm" target="_blank" title="英轩重工YX656HPlus轮式装载机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/YX656HPLUS_message.shtm" target="_blank" title="英轩重工YX656HPlus轮式装载机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/YX656HPLUS_pic.shtm" target="_blank" title="英轩重工YX656HPlus轮式装载机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/YX656HPLUS_agent.shtm" target="_blank" title="英轩重工YX656HPlus轮式装载机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">总宽度：3024</p>
              <p class="l">总高度：3480</p>
              <p class="l">总长度：8125</p>
              <a href="http://product.21-sun.com/proDetail/YX656HPLUS.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('31597','')" class="r ask_it">询低价</a> <a data-val="31597" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（5）</span> <a class="add_inquiry" data-val="31597" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="31597" href="javascript:void(0)">加入对比</a> <a title="更多英轩重工装载机" href="http://product.21-sun.com/products/prolist.jsp?factory=1777&amp;catalog=101002" target="_blank">更多英轩重工装载机</a> </div>
          </div>
        </div>
        <%}%>
        <%if(zhuangzaiji==3){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="常林公司996轮式装载机" href="http://product.21-sun.com/proDetail/996.shtm" target="_blank"><img alt="常林公司996轮式装载机" src="http://product.21-sun.com/uploadfiles//image/2015/06/20150618174155_751.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/996.shtm" target="_blank">常林公司996轮式装载机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/996.shtm" target="_blank" title="常林公司996轮式装载机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/996_parameter.shtm" target="_blank" title="常林公司996轮式装载机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/996_message.shtm" target="_blank" title="常林公司996轮式装载机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/996_pic.shtm" target="_blank" title="常林公司996轮式装载机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/996_agent.shtm" target="_blank" title="常林公司996轮式装载机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">总宽度：3450</p>
              <p class="l">总高度：3894</p>
              <p class="l">总长度：9375</p>
              <a href="http://product.21-sun.com/proDetail/996.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('25245','')" class="r ask_it">询低价</a> <a data-val="25245" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（64）</span> <a class="add_inquiry" data-val="25245" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="25245" href="javascript:void(0)">加入对比</a> <a title="更多常林公司装载机" href="http://product.21-sun.com/products/prolist.jsp?factory=148&amp;catalog=101002" target="_blank">更多常林公司装载机</a> </div>
          </div>
        </div>
        <%}%>
        <%if(zhuangzaiji==4){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="雷乔曼926轮式装载机" href="http://product.21-sun.com/proDetail/926-93.shtm" target="_blank"><img alt="雷乔曼926轮式装载机" src="http://product.21-sun.com/uploadfiles//image/2018/05/20180510200333_252.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/926-93.shtm" target="_blank">雷乔曼926轮式装载机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/926-93.shtm" target="_blank" title="雷乔曼926轮式装载机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/926-93_parameter.shtm" target="_blank" title="雷乔曼926轮式装载机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/926-93_message.shtm" target="_blank" title="雷乔曼926轮式装载机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/926-93_pic.shtm" target="_blank" title="雷乔曼926轮式装载机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/926-93_agent.shtm" target="_blank" title="雷乔曼926轮式装载机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">总长度：5600</p>
              <p class="l">总宽度：1840</p>
              <p class="l">总高度：2670</p>
              <a href="http://product.21-sun.com/proDetail/926-93.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('24889','')" class="r ask_it">询低价</a> <a data-val="24889" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（30）</span> <a class="add_inquiry" data-val="24889" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="24889" href="javascript:void(0)">加入对比</a> <a title="更多雷乔曼装载机" href="http://product.21-sun.com/products/prolist.jsp?factory=16683&amp;catalog=101002" target="_blank">更多雷乔曼装载机</a> </div>
          </div>
        </div>
        <%}%>
		<%if(zhuangzaiji==5){%>
        <div class="con_item fix on">
          <div class="item_img l"> <a title="山工SEM680D轮式装载机" href="http://product.21-sun.com/proDetail/SEM952.shtm" target="_blank"><img alt="山工SEM680D轮式装载机" src="http://product.21-sun.com//uploadfiles//image/2018/11/20181117102222_612.jpg" onerror="this.src='/uploadfiles/no_big.gif';"></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="http://product.21-sun.com/proDetail/SEM952.shtm" target="_blank">山工SEM680D轮式装载机</a></h2>
              <div class="links fix l"> <a href="http://product.21-sun.com/proDetail/SEM952.shtm" target="_blank" title="山工SEM680D轮式装载机性能">性能</a>| <a href="http://product.21-sun.com/proDetail/SEM952_parameter.shtm" target="_blank" title="山工SEM680D轮式装载机参数">参数</a>| <a href="http://product.21-sun.com/proDetail/SEM952_message.shtm" target="_blank" title="山工SEM680D轮式装载机口碑">口碑</a>| <a href="http://product.21-sun.com/proDetail/SEM952_pic.shtm" target="_blank" title="山工SEM680D轮式装载机图片">图片</a>| <a href="http://product.21-sun.com/proDetail/SEM952_agent.shtm" target="_blank" title="山工SEM680D轮式装载机代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <p class="l">总长度：9166</p>
              <p class="l">总宽度：3220</p>
              <p class="l">总高度：3566</p>
              <a href="http://product.21-sun.com/proDetail/SEM952.shtm" target="_blank" class="l">[查看详情]</a> </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('881','')" class="r ask_it">询低价</a> <a data-val="881" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（32）</span> <a class="add_inquiry" data-val="881" href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="881" href="javascript:void(0)">加入对比</a> <a title="更多山工装载机" href="http://product.21-sun.com/products/prolist.jsp?factory=138&catalog=101002" target="_blank">更多山工装载机</a> </div>
          </div>
        </div>
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
                                    if(intro.length()>80){intro=intro.substring(0,60)+"...";}									
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
											paramStr+="<p class='l'>"+CommonString.getFormatPara(mmm.get("param_name"))+"："+CommonString.getFormatPara(mmm.get("param_value"))+"</p>";
									}}
									}
									int showParam=0;
									if(!paramStr.equals("")){showParam=1;}
									if(!"204".equals(factory_id)){
									if(!"20440".equals(id))	{
        %>
        <div class="con_item fix">
          <div class="item_img l"> <a title="<%=title%>" href="<%=file_name%>" target="_blank"><img alt="<%=title%>" src="<%=img%>"  onerror="this.src='/uploadfiles/no_big.gif';" /></a> </div>
          <div class="item_main l fix">
            <div class="title l fix">
              <h2 class="l"><a href="<%=file_name%>" target="_blank" ><%=title%></a></h2>
              <div class="links fix l"> <a href="<%=file_name%>" target="_blank" title="<%=title%>性能">性能</a>| <a href="<%=file_name.replace(".shtm","")%>_parameter.shtm" target="_blank" title="<%=title%>参数">参数</a>| <a href="<%=file_name.replace(".shtm","_message.shtm")%>" target="_blank" title="<%=title%>口碑">口碑</a>| <a href="<%=file_name.replace(".shtm","_pic.shtm")%>" target="_blank" title="<%=title%>图片">图片</a>| <a href="<%=file_name.replace(".shtm","_agent.shtm")%>" target="_blank" title="<%=title%>代理商">代理商</a> </div>
            </div>
            <div class="paras l fix">
              <%if(showParam==1){%>
              <%=paramStr%>
              <%}else{%>
              <p class="l des"><%=intro%><a href="<%=file_name%>" target="_blank" >[查看详情]</a></p>
              <%}%>
              <%if(showParam==1){%>
              <a href="<%=file_name%>" target="_blank" class="l">[查看详情]</a>
              <%}%>
            </div>
            <div class="btns l fix"> <a href="javascript:;" onclick="showinquery('<%=id%>','')"  class="r ask_it">询低价</a> <a data-val="<%=id%>" href="javascript:void(0)" class="r com_it add_compare_param">+对比参数</a> </div>
            <div class="oths l"> <span>询价（<%=inquiryCount%>）</span> <a  class="add_inquiry" data-val="<%=id%>"  href="javascript:void(0)">加入询价</a> <a class="add_compare" data-val="<%=id%>"  href="javascript:void(0)">加入对比</a> <a title="更多<%=factoryname%><%=CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalognum)).replace("混凝土泵车","泵车").replace("混凝土布料设备","布料机")%>" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=factory_id%>&catalog=<%=catalognum%>" target="_blank">更多<%=factoryname%><%=CommonString.getFormatPara(seoTitleKeywordMapNew.get(catalognum)).replace("混凝土泵车","泵车").replace("混凝土布料设备","布料机")%></a> </div>
          </div>
        </div>
        <%}}%>
        <%}}%>
        <div class="con_tip">如果没有找到您的信息，请重新选择您的筛选条件</div>
      </div>
      <!--筛选结果 end-->
      <!--页码 start-->
      <div class="txd_page fix">
        <div class="paging page" id="pagination">
          <tags:page_solr factoryids="<%=factoryids%>"  nowPage="<%=nowPage%>" total="<%=totalParts %>"  totalPage="<%=pageCount%>" tonandmeter="<%=tonandmeter%>" factoryid="<%=factoryid%>" catalog="<%=catalog%>" />
        </div>
      </div>
    </div>
    <!--页码 end-->

    <!--品牌推荐 start-->
    <%if(!catalog.equals("")&factory.equals("")){%>
    <div class="marketing">
      <div class="marketing_hd pr fix">
        <p class="title pr l">
          <%if(!"".equals(factoryid)&&"".equals(catalog)){%>
          <%= CommonString.getFormatPara(brandMap.get(factoryid))%>
          <%}%>
          <%if(!"".equals(factoryid)&&!"".equals(catalog)){%>
          <%= CommonString.getFormatPara(brandMap.get(factoryid)).replace("卡特彼勒","卡特")%>
          <%}%>
          <%="".equals(catalog) ? "" : CommonString.getFormatPara(catalogMap.get(catalog))%>相关推荐品牌 </p>
      </div>
      <div class="marketing_bd fix">
        <%if(catalog.indexOf("101001")>=0){%>
        <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=101001" title="三一挖掘机">三一挖掘机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=174&catalog=101001" title="卡特彼勒挖掘机">卡特彼勒挖掘机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=182&catalog=101001" title="小松挖掘机">小松挖掘机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=183&catalog=101001" title="神钢挖掘机">神钢挖掘机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=192&catalog=101001" title="斗山挖掘机">斗山挖掘机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=175&catalog=101001" title="沃尔沃挖掘机">沃尔沃挖掘机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=141&catalog=101001" title="雷沃挖掘机">雷沃挖掘机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=194&catalog=101001" title="现代挖掘机">现代挖掘机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101001" title="柳工挖掘机">柳工挖掘机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=184&catalog=101001" title="日立挖掘机">日立挖掘机</a>
        <%}else if(catalog.indexOf("101002")>=0){%>
        <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101002" title="柳工装载机">柳工装载机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=137&catalog=101002" title="临工装载机">临工装载机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=138&catalog=101002" title="山工装载机">山工装载机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=172&catalog=101002" title="晋工装载机">晋工装载机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=139&catalog=101002" title="厦工装载机">厦工装载机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=1777&catalog=101002" title="英轩装载机">英轩装载机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=141&catalog=101002" title="雷沃装载机">雷沃装载机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=101002" title="龙工装载机">龙工装载机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=101002" title="徐工装载机">徐工装载机</a> <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=182&catalog=101002" title="小松装载机">小松装载机</a>
        <%}else{%>
        <%if(brandList!=null&&brandList.size()>0){ %>
        <%if(brandList.size()>=10){
	      for(int i = 0 ; i < 10 ; i++) {
		  String f_id=CommonString.getFormatPara(brandList.get(i).get("id")); 
		  String f_name=CommonString.getFormatPara(brandList.get(i).get("name"));
	      %>
        <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=f_id%>&catalog=<%=catalog%>" title="<%=f_name%><%=CommonString.getFormatPara(catalogMap.get(catalog)).replace("/属具","")%>"><%=f_name%><%=CommonString.getFormatPara(catalogMap.get(catalog)).replace("/属具","")%></a>
        <%}}else{  for(Map oneMap : brandList){%>
        <a class="l el" href="http://product.21-sun.com/products/prolist.jsp?factory=<%=CommonString.getFormatPara(oneMap.get("id"))%>&catalog=<%=catalog%>" title="<%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(catalogMap.get(catalog)).replace("/属具","")%>"><%=CommonString.getFormatPara(oneMap.get("name"))%><%=CommonString.getFormatPara(catalogMap.get(catalog)).replace("/属具","")%></a>
        <%}}}}%>
      </div>
    </div>
    <%}%>
    <!--品牌推荐 end-->
  </div>
  <!--展示主体 end-->
</div>
<!--right end-->
</div>
<!--foot-->
<div class="j_foot j_foot01" style="height:240px">
  <div class="wrap fix">
    <div class="j_foot01_1">
      <div class="wrap fix">
        <div class="footLeft">
          <ul class="fix">
            <li> <strong class="jf_hd"><a href="/products/prolist.jsp?catalog=101001" target="_blank" title="挖掘机/属具"><i class="fi fi01"></i>挖掘机/属具</a></strong>
              <div class="jf_bd"> <a href="/products/prolist.jsp?catalog=101001001" target="_blank" title="履带挖掘机">履带挖掘机</a> <a href="/products/prolist.jsp?catalog=101001004" target="_blank" title="轮式挖掘机">轮式挖掘机</a> <a href="/products/prolist.jsp?catalog=101001007" target="_blank" title="特种挖掘机">特种挖掘机</a> <a href="/products/prolist.jsp?catalog=101001098" target="_blank" title="破碎器">破碎器</a> <a href="/products/prolist.jsp?catalog=101001099" target="_blank" title="液压剪">液压剪</a> </div>
            </li>
            <li> <strong class="jf_hd"><a href="/products/prolist.jsp?catalog=101002" target="_blank" title="装载机"><i class="fi fi02"></i>装载机</a></strong>
              <div class="jf_bd"> <a href="/products/prolist.jsp?catalog=101002007" target="_blank" title="轮式装载机">轮式装载机</a> <a href="/products/prolist.jsp?catalog=101002006" target="_blank" title="履带装载机">履带装载机</a> <a href="/products/prolist.jsp?catalog=101002004" target="_blank" title="特种装载机">特种装载机</a> <a href="/products/prolist.jsp?catalog=101002008" target="_blank" title="挖掘装载机">挖掘装载机</a> <a href="/products/prolist.jsp?catalog=101002009" target="_blank" title="滑移装载机">滑移装载机</a> <a href="/products/prolist.jsp?catalog=101002010" target="_blank" title="叉装机">叉装机</a> </div>
            </li>
            <li> <strong class="jf_hd"><a href="/products/prolist.jsp?catalog=101003" target="_blank" title="推土机"><i class="fi fi03"></i>推土机</a></strong>
              <div class="jf_bd"> <a href="/products/prolist.jsp?catalog=101003001" target="_blank" title="履带推土机">履带推土机</a> <a href="/products/prolist.jsp?catalog=101003004" target="_blank" title="轮式推土机">轮式推土机</a> </div>
              <strong class="jf_hd"><a href="/products/prolist.jsp?catalog=101003" target="_blank" title="平地/铲运机"><i class="fi fi04"></i>平地/铲运机</a></strong>
              <div class="jf_bd"> <a href="/products/prolist.jsp?catalog=101005001" target="_blank" title="铲运机">铲运机</a> <a href="/products/prolist.jsp?catalog=101005002" target="_blank" title="平地机">平地机</a> </div>
            </li>
            <li> <strong class="jf_hd"><a href="/products/prolist.jsp?catalog=102" target="_blank" title="起重机"><i class="fi fi05"></i>起重机</a></strong>
              <div class="jf_bd"> <a href="/products/prolist.jsp?catalog=102007" target="_blank" title="汽车起重机">汽车起重机</a> <a href="/products/prolist.jsp?catalog=102002" target="_blank" title="塔式起重机">塔式起重机</a> <a href="/products/prolist.jsp?catalog=102003" target="_blank" title="高空作业车/平台">高空作业车/平台</a> <a href="/products/prolist.jsp?catalog=102006" target="_blank" title="随车起重机">随车起重机</a> <a href="/products/prolist.jsp?catalog=102008" target="_blank" title="履带起重机">履带起重机</a> <a href="/products/prolist.jsp?catalog=102012" target="_blank" title="伸缩臂叉装机">伸缩臂叉装机</a> <a href="/products/prolist.jsp?catalog=102011" target="_blank" title="施工升降机">施工升降机</a> </div>
            </li>
            <li> <strong class="jf_hd"><a href="/products/prolist.jsp?catalog=103" target="_blank" title="混凝土设备"><i class="fi fi06"></i>混凝土设备</a></strong>
              <div class="jf_bd"> <a href="/products/prolist.jsp?catalog=103001" target="_blank" title="混凝土泵车">混凝土泵车</a> <a href="/products/prolist.jsp?catalog=103019" target="_blank" title="混凝土搅拌运输车">混凝土搅拌运输车</a> <a href="/products/prolist.jsp?catalog=103017" target="_blank" title="车载泵">车载泵</a> <a href="/products/prolist.jsp?catalog=103018" target="_blank" title="拖泵">拖泵</a> <a href="/products/prolist.jsp?catalog=103020" target="_blank" title="混凝土输送泵">混凝土输送泵</a> <a href="/products/prolist.jsp?catalog=103002" target="_blank" title="混凝土搅拌站/车/楼">混凝土搅拌站/车/楼</a> <a href="/products/prolist.jsp?catalog=103005" target="_blank" title="混凝土布料杆/车">混凝土布料杆/车</a> </div>
            </li>
            <li> <strong class="jf_hd"><a href="/products/prolist.jsp?catalog=106001" target="_blank" title="压路机/压实机/夯"><i class="fi fi07"></i>压实机械</a></strong>
              <div class="jf_bd"> <a href="/products/prolist.jsp?catalog=106001001" target="_blank" title="单钢轮压路机">单钢轮压路机</a> <a href="/products/prolist.jsp?catalog=106001002" target="_blank" title="双钢轮压路机">双钢轮压路机</a> <a href="/products/prolist.jsp?catalog=106001003" target="_blank" title="三钢轮压路机">三钢轮压路机</a> <a href="/products/prolist.jsp?catalog=106001005" target="_blank" title="轮胎压路机">轮胎压路机</a> <a href="/products/prolist.jsp?catalog=106001004" target="_blank" title="手扶压路机">手扶压路机</a> <a href="/products/prolist.jsp?catalog=106001020" target="_blank" title="压实机">压实机</a> <a href="/products/prolist.jsp?catalog=106001021" target="_blank" title="夯实机">夯实机</a> </div>
            </li>
          </ul>
        </div>
        <!--二维码扫描-->
        <div class="wechat_right fix">
          <dl>
            <dt style="padding-top:2px; height:88px;"><img src="http://product.21-sun.com/img/f_ewm01.jpg" width="90" height="90"></dt>
            <dd>铁臂商城手机版随时随地询价</dd>
          </dl>
          <dl>
            <dt><img src="http://product.21-sun.com/img/f_ewm02.gif" width="90" height="90"></dt>
            <dd>关注铁臂商城抢先查询新品信息</dd>
          </dl>
        </div>
        <!--二维码扫描 end-->
      </div>
    </div>
  </div>
</div>
<!--<div class="j_foot j_foot02" style="height:auto">
  <div class="wrap fix">
    <div class="j_foot_link_tab j_tab">
      <div class="j_tab_keylist">
        <ul class="fix">
          <li class="j_tab_key">友情链接</li>
        </ul>
      </div>

      <div class="j_tab_val" style="display: none;">
        <ul class="fix j_link_list">

        </ul>
      </div>
    </div>
  </div>
</div>-->
<div class="j_bottom">
  <div class="wrap fix">
    <div class="j_bottom_left l"> <a class="New_links" rel="nofollow" href="http://www.21-sun.com/service/guanggao/index.htm">广告服务</a><em>|</em> <a class="New_links" rel="nofollow" target="_blank" href="http://aboutus.21-sun.com/contact/">联系方式</a><em>|</em> <a class="New_links" rel="nofollow" target="_blank" href="http://product.21-sun.com/about/">关于我们</a><em>|</em> <a class="New_links" rel="nofollow" target="_blank" href="http://www.jerei.com/news/index-list-0.htm">本网动态</a><em>|</em> <a class="New_links" rel="nofollow" target="_blank" href="http://www.jerei.com/contact/legal.jsp">法律声明</a><em>|</em> <a class="New_links" href="http://aboutus.21-sun.com/map.htm">网站导航</a><em>|</em> <a class="New_links" rel="nofollow" target="_blank" href="http://aboutus.21-sun.com/contact/">联系客服</a> </div>
    <div class="j_bottom_left r">中国工程机械商贸网 © copyright 2000-<span class="currentDate">
      <script type="text/javascript">document.write((new Date()).getFullYear());</script>
      </span></div>
  </div>
</div>
<!--foot end-->
<!--购机导航内容-->
<div class="list-box list-pro" id="topCataPro"> <span class="over-line"></span>
  <ul>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001" target="_blank"><strong>挖掘机/属具</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001001" target="_blank">履带挖掘机</a> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001004" target="_blank">轮式挖掘机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001007" target="_blank">特种挖掘机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001098" target="_blank">破碎锤</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001099" target="_blank">液压剪</a> </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002" target="_blank"><strong>装载机</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002007" target="_blank">轮式装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002003" target="_blank">履带装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002004" target="_blank">特种装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002008" target="_blank">挖掘装载机</a> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002009" target="_blank">滑移装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002010" target="_blank">叉装机</a> </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003" target="_blank"><strong>推土机</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=101003001" target="_blank">履带推土机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003004" target="_blank">轮式推土机</a> </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102" target="_blank"><strong>起重机</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=102007" target="_blank">汽车起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102002" target="_blank">塔式起重机</a> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=102003" target="_blank">高空作业车/平台</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102006" target="_blank">随车起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102008" target="_blank">履带式起重机</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=102012" target="_blank">伸缩臂叉装机</a>-->
          <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102011" target="_blank">施工升降机</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=102013" target="_blank">龙门/桥梁起重机</a>-->
        </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001" target="_blank"><strong>压路机/压实机/夯</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001001" target="_blank">单钢轮压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001002" target="_blank">双钢轮压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001003" target="_blank">三钢轮压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001005" target="_blank">轮胎压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001004" target="_blank">手扶压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001020" target="_blank">压实机</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001021" target="_blank">夯实机</a>-->
        </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103" target="_blank"><strong>混凝土机械</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=103001" target="_blank">泵车</a> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=103019" target="_blank">搅拌运输车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103017" target="_blank">车载泵</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103018" target="_blank">拖泵</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103020" target="_blank">输送泵</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103002" target="_blank">搅拌站/楼/车</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=103005" target="_blank">布料杆/车</a>-->
          <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103008" target="_blank">干粉/砂浆生产设备</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=103010" target="_blank">喷湿机</a>
                  <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103015" target="_blank">其它混凝土设备</a>-->
        </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105" target="_blank"><strong>桩工机械</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=105003" target="_blank">旋挖钻机</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=105004" target="_blank">潜孔钻机</a>-->
          <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105005" target="_blank">水平定向钻</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105007" target="_blank">连续墙设备</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=105018" target="_blank">螺旋钻机</a>-->
          <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105009" target="_blank">压桩机/打桩机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105028" target="_blank">截桩机/破桩机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105027" target="_blank">其它桩工机械</a> </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005" target="_blank"><strong>平地机/铲运机</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005001" target="_blank">自行式铲运机</a> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=101005002" target="_blank">自行式平地机</a> </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104" target="_blank"><strong>路面机械</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=104001" target="_blank">摊铺机</a> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=104005" target="_blank">铣刨机</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=104003" target="_blank">开槽机/灌缝机</a>-->
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=104004" target="_blank">破碎机</a>-->
          <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104002" target="_blank">再生机械</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104008" target="_blank">稳定土厂拌设备</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104009" target="_blank">沥青搅拌/转运</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104006" target="_blank">沥青洒布/碎石散布机</a> </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110" target="_blank"><strong>地下及矿山机械</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=110001" target="_blank">盾构机</a> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=110002" target="_blank">掘进机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110008" target="_blank">凿岩台车/钻机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110009" target="_blank">破碎机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110012" target="_blank">筛分机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110013" target="_blank">装载及搬运设备</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110018" target="_blank">扒渣机</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=110019" target="_blank">采煤机</a>-->
        </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107" target="_blank"><strong>叉车</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=107011" target="_blank">内燃平衡重叉车</a> <a class="active" href="http://product.21-sun.com/products/prolist.jsp?catalog=107012" target="_blank">电动叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107013" target="_blank">侧面叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107014" target="_blank">前移叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107015" target="_blank">搬运车/托盘车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107016" target="_blank">堆高机/堆垛车</a> </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122" target="_blank"><strong>环卫车辆</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122001" target="_blank">清扫车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122002" target="_blank">垃圾车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122003" target="_blank">清雪车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122004" target="_blank">酒水车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122005" target="_blank">污水粪便车</a> </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118" target="_blank"><strong>专用车辆</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118001" target="_blank">普通载货车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118013" target="_blank">公路牵引车</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=118004" target="_blank">场地牵引车</a>-->
          <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118003" target="_blank">消防车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118012" target="_blank">清障车</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=118005" target="_blank">冷藏车</a>
                  <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118006" target="_blank">货厢车</a>-->
          <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118007" target="_blank">粉罐车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118008" target="_blank">油罐车</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=118009" target="_blank">液罐车</a>
                  <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118010" target="_blank">翻斗车</a>-->
          <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118011" target="_blank">渣土车</a>
          <!--<a href="http://product.21-sun.com/products/prolist.jsp?catalog=118014" target="_blank">半挂车</a>-->
          <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118002" target="_blank">其他专用车</a> </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008" target="_blank"><strong>自卸卡车/矿卡</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008002" target="_blank">刚性自卸卡车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008001" target="_blank">铰接式自卸卡车</a> </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109" target="_blank"><strong>桥梁机械</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109006" target="_blank">砂浆车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109005" target="_blank">检测车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109004" target="_blank">提梁机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109002" target="_blank">运梁车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109001" target="_blank">架桥机</a> </div>
      </div>
    </li>
    <li class="fix">
      <div class="list-ele-left l"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111" target="_blank"><strong>港口机械</strong></a> </div>
      <div class="list-ele-right r">
        <div class="list-wrapper"> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111001" target="_blank">正面吊</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111004" target="_blank">门式起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111002" target="_blank">码头堆高机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111003" target="_blank">卸船机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111007" target="_blank">推耙机</a> </div>
      </div>
    </li>
  </ul>
  <div class="rec-pro fix"> <a href="http://product.21-sun.com/products/prolist.jsp?factory=174&catalog=101001" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">卡特挖掘机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=101001" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">三一挖掘机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=101001" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">徐工挖掘机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=101001" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">龙工挖掘机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=137&catalog=101001" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">临工挖掘机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101001" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">柳工挖掘机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=141&catalog=101001" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">雷沃挖掘机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=138&catalog=101002" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">山工装载机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101002" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">柳工装载机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=101002" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">龙工装载机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=101002" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">徐工装载机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=137&catalog=101002" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">临工装载机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=139&catalog=101002" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">厦工装载机</span></span> </span> </a> <a href="http://product.21-sun.com/products/prolist.jsp?factory=174&catalog=101002" target="_blank"><span class="link-btn-left"><span class="link-btn-right"><span class="link-btn-center">卡特装载机</span></span> </span> </a> </div>
</div>
<!--头部购机导航内容 end-->
<!--全部产品分类-->
<div class="acLayer">
  <!--挖掘机-->
  <div class="acb">
    <div class="hn"><i class="ion">&#xe601;</i> <strong class="n"><a style="color:#fff" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001" target="_blank">挖掘机</a></strong>/ <a target="_blank" target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=101001">三一</a>/ <a target="_blank" target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=174&catalog=101001">卡特彼勒</a> </div>
    <div class="acbBox">
      <div class="hd">
        <h3>品牌推荐</h3>
      </div>
      <div class="bd">
        <div class="ac_imgList">
          <ul>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=174&catalog=101001"><img src="http://product.21-sun.com/uploadfiles/20081204173853_0.jpg" alt="卡特彼勒"><strong class="n">卡特彼勒</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=101001"><img src="http://product.21-sun.com/uploadfiles/09070916592948_0.jpg" alt="三一"><strong class="n">三一</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/brand/lovol/"><img src="http://product.21-sun.com/uploadfiles/0903171119171_0.jpg" alt="雷沃重工"><strong class="n">雷沃重工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=182&catalog=101001"><img src="http://product.21-sun.com/uploadfiles/09031711183542_0.jpg" alt="小松"><strong class="n">小松</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101001"><img src="http://product.21-sun.com/uploadfiles/09031711214794_0.jpg" alt="柳工"><strong class="n">柳工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=183&catalog=101001"><img src="http://product.21-sun.com/uploadfiles/20081205142130_0.jpg" alt="神钢"><strong class="n">神钢</strong></a> </li>
          </ul>
        </div>
      </div>
      <div class="hd" style="margin-bottom:0px">
        <h3>产品分类</h3>
      </div>
      <div class="bd" style="margin-bottom:0px">
        <dl class="ac_linkList dash_border">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001001">履带挖掘机</a></dt>
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?c=101001&ton=g_0_6">迷你挖(3吨以下)</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?c=101001&ton=g_1_13">小挖(4-8吨)</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?c=101001&ton=g_8_15">中小挖(8-15吨)</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?c=101001&ton=g_14_30">中挖(15-25吨)</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?c=101001&ton=g_25_35">中大挖(25-30吨)</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?c=101001&ton=g_30_1">大挖(35吨以上)</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/activity/ihisce/">石川岛迷你挖</a> </dd>
        </dl>
        <dl class="ac_linkList">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001004">轮式挖掘机</a><em>|</em><a  target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001007">其他挖掘机</a></dt>
        </dl>
      </div>
      <div class="hd" style="margin-bottom:0px">
        <h3>推荐产品</h3>
        <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001" class="more">更多<i class="ion">&#xe601;</i></a> </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=101001">三一挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=174&catalog=101001">卡特彼勒挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=137&catalog=101001">山东临工挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=182&catalog=101001">小松挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101001">柳工挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=152&catalog=101001">山重建机挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=184&catalog=101001">日立挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=183&catalog=101001">神钢挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=194&catalog=101001">现代挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=187&catalog=101001">久保田挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=190&catalog=101001">石川岛挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=192&catalog=101001">斗山挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=101001">徐工挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=141&catalog=101001">雷沃重工挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=14238&catalog=101001">约翰迪尔挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=189&catalog=101001">加藤挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=101001">龙工挖掘机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=142&catalog=101001">山河智能挖掘机</a> </dd>
        </dl>
      </div>
    </div>
  </div>
  <!--装载机-->
  <div class="acb">
    <div class="hn"><i class="ion">&#xe601;</i> <strong class="n"><a style="color:#fff" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002" target="_blank">装载机</a></strong>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=101002">龙工</a>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101002">柳工</a> </div>
    <div class="acbBox">
      <div class="hd">
        <h3>品牌推荐</h3>
      </div>
      <div class="bd">
        <div class="ac_imgList">
          <ul>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=141&catalog=101002"><img src="http://product.21-sun.com/uploadfiles/0903171119171_0.jpg" alt="雷沃重工"><strong class="n">雷沃重工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=138&catalog=101002"><img src="http://product.21-sun.com/uploadfiles//image/2014/02/20140211113606_389.jpg" alt="山工机械"><strong class="n">山工机械</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=101002"><img src="http://product.21-sun.com/uploadfiles/11091416204918_0.jpg" alt="龙工"><strong class="n">龙工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=139&catalog=101002"><img src="http://product.21-sun.com/uploadfiles/09031711274964_0.jpg" alt="厦工"><strong class="n">厦工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=137&catalog=101002"><img src="http://product.21-sun.com/uploadfiles/09031711372951_0.jpg" alt="山东临工"><strong class="n">山东临工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101002"><img src="http://product.21-sun.com/uploadfiles/09031711214794_0.jpg" alt="柳工"><strong class="n">柳工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=101002"><img src="http://product.21-sun.com/uploadfiles/09070916592948_0.jpg" alt="三一"><strong class="n">三一</strong></a> </li>
          </ul>
        </div>
      </div>
      <div class="hd">
        <h3>产品分类</h3>
      </div>
      <div class="bd">
        <dl class="ac_linkList dash_border">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002007">轮式装载机</a></dt>
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&tonandmeter=loader_1_3">装载机（3吨以下）</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&tonandmeter=loader_3_01">装载机（3吨）</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&factory=136&tonandmeter=loader_3_5">装载机（3-5吨）</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002&factory=136&tonandmeter=loader_5_1">装载机（5吨以上）</a> </dd>
        </dl>
        <dl class="ac_linkList">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002003">履带式装载机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002010">叉装机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002009">滑移装载机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002008">挖掘装载机</a></dt>
        </dl>
      </div>
      <div class="hd">
        <h3>推荐产品</h3>
        <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101002" class="more">更多<i class="ion">&#xe601;</i></a> </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=101002">龙工装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101002">柳工装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=101002">徐工装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=138&catalog=101002">山工机械装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=139&catalog=101002">厦工装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=141&catalog=101002">雷沃重工装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=145&catalog=101002">成工装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=137&catalog=101002">山东临工装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=149&catalog=101002">沃得重工装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=172&catalog=101002">晋工装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=192&catalog=101002">斗山装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=14238&catalog=101002">约翰迪尔装载机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=144&catalog=101002">山推装载机</a> </dd>
        </dl>
      </div>
    </div>
  </div>
  <!--起重机-->
  <div class="acb">
    <div class="hn"><i class="ion">&#xe601;</i> <strong class="n"><a style="color:#fff" href="http://product.21-sun.com/products/prolist.jsp?catalog=102" target="_blank">起重机</a></strong>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=102">三一</a>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=102">徐工</a> </div>
    <div class="acbBox">
      <div class="hd">
        <h3>品牌推荐</h3>
      </div>
      <div class="bd">
        <div class="ac_imgList">
          <ul>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=102"><img src="http://product.21-sun.com/uploadfiles/20081212082831_0.jpg" alt="徐工"><strong class="n">徐工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=102"><img src="http://product.21-sun.com/uploadfiles/09070916592948_0.jpg" alt="三一"><strong class="n">三一</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=134&catalog=102"><img src="http://product.21-sun.com/uploadfiles/20081208093148_0.jpg" alt="中联重科"><strong class="n">中联重科</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=189&catalog=102"><img src="http://product.21-sun.com/uploadfiles/09031713193821_0.jpg" alt="加藤"><strong class="n">加藤</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=102"><img src="http://product.21-sun.com/uploadfiles/09031711214794_0.jpg" alt="柳工"><strong class="n">柳工</strong></a> </li>
            <li> <a href="http://product.21-sun.com/products/prolist.jsp?factory=167&catalog=102"><img src="http://product.21-sun.com/uploadfiles/20081213162759_0.jpg" alt="北方交通"><strong class="n">北方交通</strong></a> </li>
          </ul>
        </div>
      </div>
      <div class="hd">
        <h3>产品分类</h3>
      </div>
      <div class="bd">
        <dl class="ac_linkList dash_border">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102007">汽车起重机</a></dt>
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&tonandmeter=crane_1_16">起重机（16吨以下）</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&tonandmeter=crane_20_70">起重机（20-70吨）</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102007&tonandmeter=crane_70_1">起重机（70吨以上）</a> </dd>
        </dl>
        <dl class="ac_linkList">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102008">履带式起重机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102002">塔式起重机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102003">高空作业车/平台</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102006">随车起重机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102011">施工升降机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102012">伸缩臂叉装机</a></dt>
        </dl>
      </div>
      <div class="hd">
        <h3>推荐产品</h3>
        <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=102" class="more">更多<i class="ion">&#xe601;</i></a> </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=102">徐工起重机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=102">三一起重机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=134&catalog=102">中联重科起重机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=189&catalog=102">加藤起重机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=102">柳工起重机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=167&catalog=102">北方交通起重机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=139&catalog=102">厦工起重机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=179&catalog=102">利勃海尔起重机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=176&catalog=102">特雷克斯起重机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=186&catalog=102">北起多田野起重机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=14217&catalog=102">三一帕尔菲格起重机</a> </dd>
        </dl>
      </div>
    </div>
  </div>
  <!--推土机-->
  <div class="acb">
    <div class="hn"><i class="ion">&#xe601;</i> <strong class="n"><a style="color:#fff" href="http://product.21-sun.com/products/prolist.jsp?catalog=101003" target="_blank">推土机</a></strong>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=144&catalog=101003">山推</a>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=154&catalog=101003">宣工</a> </div>
    <div class="acbBox">
      <div class="hd">
        <h3>品牌推荐</h3>
      </div>
      <div class="bd">
        <div class="ac_imgList">
          <ul>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=144&catalog=101003"><img src="http://product.21-sun.com/uploadfiles//image/2014/02/20140221154814_568.jpg" alt="山推"><strong class="n">山推</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=154&catalog=101003"><img src="http://product.21-sun.com/images/hbxg.jpg" alt="宣工"><strong class="n">宣工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=138&catalog=101003"><img src="http://product.21-sun.com/uploadfiles//image/2014/02/20140211113606_389.jpg" alt="山工机械"><strong class="n">山工机械</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=143&catalog=101003"><img src="http://product.21-sun.com/uploadfiles/20081211172557_0.jpg" alt="宇通重工"><strong class="n">宇通重工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=161&catalog=101003"><img src="http://product.21-sun.com/uploadfiles/20081212105232_0.jpg" alt="移山"><strong class="n">移山</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101003"><img src="http://product.21-sun.com/uploadfiles/09031711214794_0.jpg" alt="柳工"><strong class="n">柳工</strong></a> </li>
          </ul>
        </div>
      </div>
      <div class="hd">
        <h3>产品分类</h3>
      </div>
      <div class="bd">
        <dl class="ac_linkList dash_border">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101003004">轮胎式推土机</a></dt>
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101003&tonandmeter=tuitu_1_120">120马力以下</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101003&tonandmeter=tuitu_120_220">120-220马力</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101003&tonandmeter=tuitu_220_230">220-230马力</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101003&tonandmeter=tuitu_230_1">320马力以上</a> </dd>
        </dl>
        <dl class="ac_linkList">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101003001">履带式推土机</a></dt>
        </dl>
      </div>
      <div class="hd">
        <h3>推荐产品</h3>
        <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101003" class="more">更多<i class="ion">&#xe601;</i></a> </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=144&catalog=101003">山推推土机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=154&catalog=101003">宣工推土机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=138&catalog=101003">山工机械推土机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=143&catalog=101003">宇通重工推土机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=161&catalog=101003">移山推土机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=101003">柳工推土机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=140&catalog=101003">鼎盛重工推土机</a> </dd>
        </dl>
      </div>
    </div>
  </div>
  <!--混凝土-->
  <div class="acb">
    <div class="hn"><i class="ion">&#xe601;</i> <strong class="n"><a style="color:#fff" href="http://product.21-sun.com/products/prolist.jsp?catalog=103" target="_blank">混凝土</a></strong>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=103">三一</a>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=134&catalog=103">中联重科</a> </div>
    <div class="acbBox">
      <div class="hd">
        <h3>品牌推荐</h3>
      </div>
      <div class="bd">
        <div class="ac_imgList">
          <ul>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=103"><img src="http://product.21-sun.com/uploadfiles/09070916592948_0.jpg" alt="三一"><strong class="n">三一</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=202&catalog=103"><img src="http://product.21-sun.com/uploadfiles/09031718293914_0.jpg" alt="鸿得利重工"><strong class="n">鸿得利重工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=671&catalog=103002"><img src="http://product.21-sun.com/uploadfiles/10031711232772_0.jpg" alt="方圆集团"><strong class="n">方圆集团</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/brandshop/lingyu/"><img src="http://product.21-sun.com/uploadfiles//image/2013/09/20130909151051_309.jpg" alt="中集凌宇"><strong class="n">中集凌宇</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=218&catalog=103"><img src="http://product.21-sun.com/uploadfiles/10072609324085_0.jpg" alt="铁拓"><strong class="n">铁拓</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=200&catalog=103"><img src="http://product.21-sun.com/uploadfiles/20081213175805_0.jpg" alt="南方路机"><strong class="n">南方路机</strong></a> </li>
          </ul>
        </div>
      </div>
      <div class="hd">
        <h3>产品分类</h3>
      </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dt><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001">泵车</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=103017">车载泵</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=103018">拖泵/输送泵</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=103019">混凝土搅拌车</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=103002">混凝土搅拌站/楼搅拌机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=103005002">布料机/布料杆</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=103008">干粉砂浆生产设备</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=103010">喷湿机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=103015">其它混凝土设备</a></dt>
        </dl>
      </div>
      <div class="hd">
        <h3>推荐产品</h3>
        <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=103" class="more">更多<i class="ion">&#xe601;</i></a> </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=103">三一混凝土机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=103001">三一泵车</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=103019">三一搅拌车</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=134&catalog=103">中联重科混凝土机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=202&catalog=103">鸿得利重工混凝土机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=671&catalog=103002">方圆集团混凝土机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=767&catalog=103">中集凌宇混凝土机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=218&catalog=103">铁拓混凝土机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=200&catalog=103">南方路机混凝土机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=207&catalog=103">陆德筑机混凝土机械</a> </dd>
        </dl>
      </div>
    </div>
  </div>
  <!--叉车-->
  <div class="acb">
    <div class="hn"><i class="ion">&#xe601;</i> <strong class="n"><a style="color:#fff" href="http://product.21-sun.com/products/prolist.jsp?catalog=107" target="_blank">叉车</a></strong>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1742&catalog=107">林德</a>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=13699&catalog=107011">诺力</a> </div>
    <div class="acbBox">
      <div class="hd">
        <h3>品牌推荐</h3>
      </div>
      <div class="bd">
        <div class="ac_imgList">
          <ul>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1742&catalog=107"><img src="http://product.21-sun.com/uploadfiles//image/2012/10/20121019134726_641.jpg" alt="林德"><strong class="n">林德</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=107"><img src="http://product.21-sun.com/uploadfiles/09070916592948_0.jpg" alt="三一"><strong class="n">三一</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=158&catalog=107"><img src="http://product.21-sun.com/uploadfiles/20081211153837_0.jpg" alt="合力"><strong class="n">合力</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=107"><img src="http://product.21-sun.com/uploadfiles/11091416204918_0.jpg" alt="龙工"><strong class="n">龙工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=107"><img src="http://product.21-sun.com/uploadfiles/20081212082831_0.jpg" alt="徐工"><strong class="n">徐工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1715&catalog=107"><img src="http://product.21-sun.com/uploadfiles//image/2012/10/20121017132449_891.jpg" alt="宝骊"><strong class="n">宝骊</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=107"><img src="http://product.21-sun.com/uploadfiles/09031711214794_0.jpg" alt="柳工"><strong class="n">柳工</strong></a> </li>
          </ul>
        </div>
      </div>
      <div class="hd">
        <h3>产品分类</h3>
      </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=107012">电动叉车</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=107011">内燃叉车</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=107018">仓储叉车</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=118004">牵引车</a></dt>
        </dl>
      </div>
      <div class="hd">
        <h3>推荐产品</h3>
        <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=107" class="more">更多<i class="ion">&#xe601;</i></a> </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1742&catalog=107">林德叉车</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=13699&catalog=107011">诺力叉车</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=158&catalog=107">合力叉车</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=107">龙工叉车</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=107">徐工叉车</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1715&catalog=107">宝骊叉车</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=107">柳工叉车</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=192&catalog=107">斗山叉车</a> </dd>
        </dl>
      </div>
    </div>
  </div>
  <!--压路机-->
  <div class="acb">
    <div class="hn"><i class="ion">&#xe601;</i> <strong class="n"><a style="color:#fff" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001" target="_blank">压路机</a></strong>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=106001">徐工</a>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=106001">柳工</a> </div>
    <div class="acbBox">
      <div class="hd">
        <h3>品牌推荐</h3>
      </div>
      <div class="bd">
        <div class="ac_imgList">
          <ul>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=106001"><img src="http://product.21-sun.com/uploadfiles/20081212082831_0.jpg" alt="徐工"><strong class="n">徐工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=106001"><img src="http://product.21-sun.com/uploadfiles/09070916592948_0.jpg" alt="三一"><strong class="n">三一</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=106001"><img src="http://product.21-sun.com/uploadfiles/11091416204918_0.jpg" alt="龙工"><strong class="n">龙工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=138&catalog=106001"><img src="http://product.21-sun.com/uploadfiles//image/2014/02/20140211113606_389.jpg" alt="山工机械"><strong class="n">山工机械</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=106001"><img src="http://product.21-sun.com/uploadfiles/09031711214794_0.jpg" alt="柳工"><strong class="n">柳工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=139&catalog=106001"><img src="http://product.21-sun.com/uploadfiles/09031711274964_0.jpg" alt="厦工"><strong class="n">厦工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=148&catalog=106001"><img src="http://product.21-sun.com/uploadfiles/20081211135543_0.jpg" alt="常林股份"><strong class="n">常林股份</strong></a> </li>
          </ul>
        </div>
      </div>
      <div class="hd">
        <h3>产品分类</h3>
      </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001001">单钢轮压路机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001002">双钢轮压路机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001005">轮胎压路机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001003">三轮压路机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001004">光轮压路机</a><em>|</em></dt>
        </dl>
      </div>
      <div class="hd">
        <h3>推荐产品</h3>
        <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=106001" class="more">更多<i class="ion">&#xe601;</i></a> </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=106001">徐工压路机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&catalog=106001">柳工压路机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&catalog=106001">龙工压路机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=138&catalog=106001">山工机械压路机</a><em>|</em> <a target="_blank" target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=139&catalog=106001">厦工压路机</a><em>|</em> <a target="_blank" target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=148&catalog=106001">常林股份压路机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=212&catalog=106001">戴纳派克压路机</a> </dd>
        </dl>
      </div>
    </div>
  </div>
  <!--旋挖钻-->
  <div class="acb">
    <div class="hn"><i class="ion">&#xe601;</i> <strong class="n"><a style="color:#fff" href="http://product.21-sun.com/products/prolist.jsp?catalog=105003" target="_blank">旋挖钻</a></strong>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=105003">徐工</a>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=142&catalog=105003">山河智能</a> </div>
    <div class="acbBox">
      <div class="hd">
        <h3>品牌推荐</h3>
      </div>
      <div class="bd">
        <div class="ac_imgList">
          <ul>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=105003"><img src="http://product.21-sun.com/uploadfiles/20081212082831_0.jpg" alt="徐工"><strong class="n">徐工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=105003"><img src="http://product.21-sun.com/uploadfiles/09070916592948_0.jpg" alt="三一"><strong class="n">三一</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=142&catalog=105003"><img src="http://product.21-sun.com/uploadfiles//image/2013/08/20130807155848_987.jpg" alt="山河智能"><strong class="n">山河智能</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=683&catalog=105003"><img src="http://product.21-sun.com/uploadfiles/10052610253281_0.jpg" alt="德国宝峨"><strong class="n">德国宝峨</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=134&catalog=105003"><img src="http://product.21-sun.com/uploadfiles/20081208093148_0.jpg" alt="中联重科"><strong class="n">中联重科</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=141&catalog=105003"><img src="http://product.21-sun.com/uploadfiles/0903171119171_0.jpg" alt="雷沃重工"><strong class="n">雷沃重工</strong></a> </li>
          </ul>
        </div>
      </div>
      <div class="hd">
        <h3>产品分类</h3>
      </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?offset=0&catalog=105003">旋挖钻机</a></dt>
        </dl>
      </div>
      <div class="hd">
        <h3>推荐产品</h3>
        <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=105003" class="more">更多<i class="ion">&#xe601;</i></a> </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=105003">徐工旋挖钻机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=142&catalog=105003">山河智能旋挖钻机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=105003">三一旋挖钻机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=683&catalog=105003">德国宝峨旋挖钻机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=134&catalog=105003">中联重科旋挖钻机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=141&catalog=105003">雷沃重工旋挖钻机</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=14261&catalog=105003">泰信机械旋挖钻机</a> </dd>
        </dl>
      </div>
    </div>
  </div>
  <!--地下矿山机械-->
  <div class="acb">
    <div class="hn"><i class="ion">&#xe601;</i> <strong class="n"><a style="color:#fff" href="http://product.21-sun.com/products/prolist.jsp?catalog=110" target="_blank">地下矿山机械</a></strong>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1304&catalog=110">山特维克</a> </div>
    <div class="acbBox">
      <div class="hd">
        <h3>品牌推荐</h3>
      </div>
      <div class="bd">
        <div class="ac_imgList">
          <ul>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1304&catalog=110"><img src="http://product.21-sun.com/uploadfiles//image/2013/03/20130301135306_26.jpg" alt="山特维克"><strong class="n">山特维克</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=110"><img src="http://product.21-sun.com/uploadfiles/09070916592948_0.jpg" alt="三一"><strong class="n">三一</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=110"><img src="http://product.21-sun.com/uploadfiles/20081212082831_0.jpg" alt="徐工"><strong class="n">徐工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1758&catalog=110"><img src="http://product.21-sun.com/uploadfiles//image/2012/10/20121031172146_568.jpg" alt="铁建重工"><strong class="n">铁建重工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/brandshop/hengri/"><img src="http://product.21-sun.com/uploadfiles/12052510060812_0.jpg" alt="恒日重工"><strong class="n">恒日重工</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=167&catalog=110"><img src="http://product.21-sun.com/uploadfiles/20081213162759_0.jpg" alt="北方交通"><strong class="n">北方交通</strong></a> </li>
          </ul>
        </div>
      </div>
      <div class="hd">
        <h3>产品分类</h3>
      </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dt> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=110013">装载及搬运设备</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=110002">矿用掘进机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=110008">凿岩台车</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=110012">筛分机</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=110001">盾构掘进机</a> </dt>
        </dl>
      </div>
      <div class="hd">
        <h3>推荐产品</h3>
        <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=110" class="more">更多<i class="ion">&#xe601;</i></a> </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1304&catalog=110">山特维克地下及矿山机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&catalog=110">徐工地下及矿山机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&catalog=110">三一地下及矿山机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1758&catalog=110">铁建重工地下及矿山机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1508&catalog=110">恒日重工地下及矿山机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=167&catalog=110">北方交通地下及矿山机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=1236&catalog=110">新天和地下及矿山机械</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=13096&catalog=110">恒至凿岩地下及矿山机械</a> </dd>
        </dl>
      </div>
    </div>
  </div>
  <!--破碎设备-->
  <div class="acb">
    <div class="hn"><i class="ion">&#xe601;</i> <strong class="n"><a style="color:#fff" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001098" target="_blank">破碎设备</a></strong>/ <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=419&catalog=101001098">水山</a> </div>
    <div class="acbBox">
      <div class="hd">
        <h3>品牌推荐</h3>
      </div>
      <div class="bd">
        <div class="ac_imgList">
          <ul>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=417&catalog=101001098"><img src="http://product.21-sun.com/uploadfiles/12020215540740_0.jpg" alt="古河"><strong class="n">古河</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=402&catalog=101001098"><img src="http://product.21-sun.com/uploadfiles/08122309094362_0.jpg" alt="艾迪"><strong class="n">艾迪</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=419&catalog=101001098"><img src="http://product.21-sun.com/uploadfiles/08122313405889_0.jpg" alt="水山"><strong class="n">水山</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=192&catalog=101001098"><img src="http://product.21-sun.com/uploadfiles/20081204182013_0.jpg" alt="斗山"><strong class="n">斗山</strong></a> </li>
            <li> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=401&catalog=101001098"><img src="http://product.21-sun.com/uploadfiles/11031114434183_0.jpg" alt="惊天液压"><strong class="n">惊天液压</strong></a> </li>
            <li> <a target="_blank" href="http://www.nuosen.cn"><img src="http://product.21-sun.com/images/nslogocp.gif" alt="江苏诺森"><strong class="n">江苏诺森</strong></a> </li>
          </ul>
        </div>
      </div>
      <div class="hd">
        <h3>产品分类</h3>
      </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dt><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001098">破碎锤</a><em>|</em><a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001099">液压剪</a></dt>
        </dl>
      </div>
      <div class="hd">
        <h3>推荐产品</h3>
        <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?catalog=101001098" class="more">更多<i class="ion">&#xe601;</i></a> </div>
      <div class="bd">
        <dl class="ac_linkList">
          <dd> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=417&catalog=101001098">古河破碎锤</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=402&catalog=101001098">艾迪破碎锤</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=419&catalog=101001098">水山破碎锤</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=192&catalog=101001098">斗山破碎锤</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=401&catalog=101001098">惊天液压破碎锤</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=406&catalog=113">泰科破碎锤</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=403&catalog=113">普堃韩泰克破碎锤</a><em>|</em> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=404&catalog=113">泰戈破碎锤</a> </dd>
        </dl>
      </div>
    </div>
  </div>
</div>
<!--全部产品分类 end-->
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<!--询价弹层-->
<div class="sb_layer yincang sb_layer_xunjia" id="xjtc">
  <div class="sb_hd"><span class="check_box">
    <input type="checkbox" id="checkAll_xunjia">
    共<b class="all" id="inquiryCount">0</b>件，已选<b class="fn">0</b>件</span><a style="margin-left:25px" id="closexunjia" href="javascript:void(0)" >[关闭]</a></div>
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
    共<b class="all" id="compareCount">0</b>件，已选<b class="fn">0</b>件</span><a id="closecompare" href="javascript:void(0)" style="margin-left:25px">[关闭]</a></div>
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
<div style="display:none;">
  <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_2697829'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s6.cnzz.com/stat.php%3Fid%3D2697829' type='text/javascript'%3E%3C/script%3E"));</script>
</div>
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
</script>
</body>
<script src="/resources2018/js/common.js" type="text/javascript" charset="utf-8"></script>
<script src="/resources2018/js/machineList.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link href="/plugin/dialog/jBox/Skins/GreyBlue/jbox.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/scripts/rememberAccount.js"></script>
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" />
<script type="text/javascript" src="/scripts/prolist.js"></script>
<input type="hidden" id="catalog" name="catalog" value="<%=catalog%>" />
<input type="hidden" id="tonandmeter" name="tonandmeter" value="<%=tonandmeter%>" />
<input type="hidden" id="year" name="year" value="<%=year%>" />
<input type="hidden" id="letter" name="letter"  />
<input type="hidden" id="brands" name="brands"  />
<div class="blackBar">
  <div class="bb01"><a target="_blank" href="http://product.21-sun.com/user/login.htm" class="si"><i class="sb_ion sb01"></i></a><a title="批量询价" alt="批量询价" href="#" class="si sb_xunjia"><i class="sb_ion sb02"></i><b>批量询价</b><em id="plxj" class="num">0</em><i class="arr"></i></a><a title="机型对比" alt="机型对比" style="margin-top:20px" href="#" class="si sb_duibi"><b>机型对比</b><em id="jxdb" class="num">0</em><i class="arr"></i></a></div>
  <div class="bb02"><a href="javascript:void(0)" class="si sb_ewm"><i class="sb_ion sb03"></i></a><a href="#" class="si gotop" title="返回顶部"><i class="sb_ion sb04"></i></a></div>
  <div class="hide">
    <div class="bb_ewm"><img src="/Static/images/ewm02.png"></div>
  </div>
</div>
<script>
	function tj3(){ 
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("http://product.21-sun.com/search/"+keyword+"_0_0_0.htm");
	}
	$('#keyword').on('keydown', function (e) { if (e.keyCode == 13) {tj3()} })

</script>

</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);	
	}
%>