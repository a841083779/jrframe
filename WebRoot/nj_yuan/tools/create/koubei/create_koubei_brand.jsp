<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
// 生成所有的品牌详显页
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(realPath+"template/") ;
    FreemarkerWebserviceUtils freemarkerWebserviceUtils = new FreemarkerWebserviceUtils(realPath+"template/") ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = new HashMap() ;
	Map root1 = new HashMap() ;
	List<Map> cataloglist = dbHelper.getMapList("select  num from pro_catalog") ;	
	if(null != cataloglist && cataloglist.size()>0){
	for(Map catalogs:cataloglist){
	String catalog=CommonString.getFormatPara(catalogs.get("num")) ;
   String catalognum_new="";
	Map catalog_numNew = dbHelper.getMap("select top 1 catalog_num from pro_catalog where num='"+catalog+"' and  is_show=1 ") ;
	if(catalog_numNew!=null&&catalog_numNew.size()>0){
	catalognum_new=CommonString.getFormatPara(catalog_numNew.get("catalog_num"));}
	if(catalognum_new.equals("")){catalognum_new=catalog;}	
	//国内品牌
	List<Map> allbrandMap_in = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where id in(select distinct(pro_products.factoryid) from pro_products  where is_show=1 and catalognum_new like '%"+catalognum_new+"%') and is_inner=1 order by view_count desc") ;
	//国外品牌
	List<Map> allbrandMap_out = dbHelper.getMapList("select name,id,is_inner from pro_agent_factory where id in(select distinct(pro_products.factoryid) from pro_products  where is_show=1 and catalognum_new like '%"+catalognum_new+"%')and is_inner=0 order by view_count desc") ;
	
			if(null != allbrandMap_in&&allbrandMap_out!=null&&allbrandMap_out.size()>0 && allbrandMap_in.size()>0){
					root.put("list",allbrandMap_in) ;
					root1.put("list",allbrandMap_out) ;
					freemarkerUtils.generate("koubei/koubei_brand.htm",root,realPath+"/include/koubei/koubei_brand/inner_"+catalog+".jsp") ;  // 国内品牌
					freemarkerUtils.generate("koubei/koubei_brand.htm",root1,realPath+"/include/koubei/koubei_brand/outner_"+catalog+".jsp") ;  //国外品牌
			
			}
	
		}
     }
	
	out.println("ok") ;
%>
