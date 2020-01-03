<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ; 
	FreemarkerWebserviceUtils freemarkerWebserviceUtils = new FreemarkerWebserviceUtils(realPath+"template/") ; 	
	freemarkerWebserviceUtils.generate("index/news_product.htm",realPath+"/include/index/news_product.htm") ;  // 生成新品速递
	freemarkerWebserviceUtils.generate("index/news_factory.htm",realPath+"/include/index/news_factory.htm") ;  // 生成商家动态
	freemarkerUtils.generate("index/comment.htm",realPath+"/include/index/comment.htm") ;//生成首页评论
	
	Map map = new HashMap();
	map.put("count",7);
	map.put("catalognum","101001");	
	freemarkerUtils.generate("index/inquiry.htm",map,realPath+"/include/index/inquiry_wjj.htm") ;  // 挖掘机询价单
	
	map.put("count",6);
	map.put("catalognum","101002");	
	freemarkerUtils.generate("index/inquiry.htm",map,realPath+"/include/index/inquiry_zzj.htm") ;  // 装载机询价单
	
	map.put("count",6);
	map.put("catalognum","102");	
	freemarkerUtils.generate("index/inquiry.htm",map,realPath+"/include/index/inquiry_qzj.htm") ;  // 起重机询价单
	
	map.put("count",5);
	map.put("catalognum","101003");	
	freemarkerUtils.generate("index/inquiry.htm",map,realPath+"/include/index/inquiry_ttj.htm") ;  // 推土机询价单
	
	map.put("count",5);
	map.put("catalognum","103");	
	freemarkerUtils.generate("index/inquiry.htm",map,realPath+"/include/index/inquiry_hnt.htm") ;  // 混凝土询价单
	
	map.put("count",5);
	map.put("catalognum","113001");	
	freemarkerUtils.generate("index/inquiry.htm",map,realPath+"/include/index/inquiry_psc.htm") ;  // 破碎锤询价单
	
	//freemarkerUtils.generate("index/photo.htm",realPath+"/include/index/photo.htm") ;  // 生成产品图库区
	// freemarkerUtils.generate("index/friendlink.htm",realPath+"/include/index/friendlink.htm") ;//生成友情链接
	
	freemarkerWebserviceUtils.generate("index/data_report.htm",realPath+"/include/index/data_report.htm") ;  // 生成行业聚焦
/**
	try{
		String sql = " select top 9 id,title,oldflag from analysis_article  where is_pub=1 ORDER BY (CASE WHEN add_date IS NULL THEN pub_date ELSE add_date END) DESC,nyear desc,nmonth desc ";
		
		List <Map>list = WEBDBHelper.getMapList(sql,"Web21reportDBHelper");
		Map root = new HashMap();
		root.put("dataList",list);
		freemarkerUtils.generate("index/data_report.htm",root,realPath+"include/index/data_report.htm");//生成数据报告
	}catch(Exception e){
		e.printStackTrace();
	}finally{
	}
**/

	    freemarkerUtils.generate("koubei/koubei_index_wjj_right.htm",realPath+"/include/koubei/koubei_index_wjj_right.htm") ;  
    freemarkerUtils.generate("koubei/koubei_index_zzj_right.htm",realPath+"/include/koubei/koubei_index_zzj_right.htm") ;  
   freemarkerUtils.generate("koubei/koubei_index_ttj_right.htm",realPath+"/include/koubei/koubei_index_ttj_right.htm") ;  
    freemarkerUtils.generate("koubei/koubei_index_pdj_right.htm",realPath+"/include/koubei/koubei_index_pdj_right.htm") ; 
	out.println("ok") ;
%>