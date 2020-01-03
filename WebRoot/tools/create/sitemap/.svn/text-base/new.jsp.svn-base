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
	String factoryid="";
	String factoryname="";

   	
	Integer products_counts = (Integer)dbHelper.getOne("select count(id) from pro_products ") ;
	Integer photo_group_counts = (Integer)dbHelper.getOne("select count(id) from pro_photo_group where is_show = 1");
	List<Map> agent_factoryMap = dbHelper.getMapList("select id from pro_agent_factory where is_show = 1 and flag =1") ;
	List<Map> catalog_factoryMap = dbHelper.getMapList("select num from pro_catalog where is_show = 1 ") ;
	String agent_factory_id = "";
	String catalog_factory_catalognum = "" ;

   	//首页--口碑
	freemarkerUtils.generate("sitemap/koubei/koubei_index.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_index.xml") ;
    //首页 --专题
	freemarkerUtils.generate("sitemap/spec/spec_index.shtm", root,realPath+"/include/sitemap/spec/sitemap_spec_index.xml") ;
    //首页 --图片
	freemarkerUtils.generate("sitemap/photo/photo_index.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_index.xml") ;
   
    /*
    //按品牌--口碑
	freemarkerUtils.generate("sitemap/koubei/koubei_brands_1.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_brands_1.xml") ;
	freemarkerUtils.generate("sitemap/koubei/koubei_brands_2.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_brands_2.xml") ;
	freemarkerUtils.generate("sitemap/koubei/koubei_brands_3.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_brands_3.xml") ;
	freemarkerUtils.generate("sitemap/koubei/koubei_brands_4.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_brands_4.xml") ;
	//按分类--口碑
	freemarkerUtils.generate("sitemap/koubei/koubei_catalog_1.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_catalog_1.xml") ;
	freemarkerUtils.generate("sitemap/koubei/koubei_catalog_2.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_catalog_2.xml") ;
	freemarkerUtils.generate("sitemap/koubei/koubei_catalog_3.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_catalog_3.xml") ;
	freemarkerUtils.generate("sitemap/koubei/koubei_catalog_4.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_catalog_4.xml") ;
    //口碑排行榜--口碑
	freemarkerUtils.generate("sitemap/koubei/koubei_products.shtm", root,realPath+"/include/sitemap/koubei/koubei_products.xml") ;
    //口碑排行榜--口碑
	freemarkerUtils.generate("sitemap/koubei/koubei_rank.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_rank.xml") ;
   	//产品口碑--口碑(网上)
	freemarkerUtils.generate("sitemap/koubei/koubei_comments.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_comments.xml") ;
    //品牌街--专题
	freemarkerUtils.generate("sitemap/spec/spec_brands.shtm", root,realPath+"/include/sitemap/spec/sitemap_spec_brands.xml") ;
    //产品详情--专题
	freemarkerUtils.generate("sitemap/spec/spec_proDetail.shtm", root,realPath+"/include/sitemap/spec/sitemap_spec_proDetail.xml") ;
	//列表--专题
	freemarkerUtils.generate("sitemap/spec/spec_list.shtm", root,realPath+"/include/sitemap/spec/sitemap_spec_list.xml") ;
    //品牌加类别组合
	freemarkerUtils.generate("sitemap/spec/spec_list_factory_catalog_1.shtm", root,realPath+"/include/sitemap/spec/spec_list_factory_catalog_1.xml") ;
	freemarkerUtils.generate("sitemap/spec/spec_list_factory_catalog_2.shtm", root,realPath+"/include/sitemap/spec/spec_list_factory_catalog_2.xml") ;
	freemarkerUtils.generate("sitemap/spec/spec_list_factory_catalog_3.shtm", root,realPath+"/include/sitemap/spec/spec_list_factory_catalog_3.xml") ;
	freemarkerUtils.generate("sitemap/spec/spec_list_factory_catalog_4.shtm", root,realPath+"/include/sitemap/spec/spec_list_factory_catalog_4.xml") ;
	freemarkerUtils.generate("sitemap/spec/spec_list_factory_catalog_5.shtm", root,realPath+"/include/sitemap/spec/spec_list_factory_catalog_5.xml") ;
	freemarkerUtils.generate("sitemap/spec/spec_list_factory_catalog_6.shtm", root,realPath+"/include/sitemap/spec/spec_list_factory_catalog_6.xml") ;
    */
	
	


	//图片大全列表 --图片 
	freemarkerUtils.generate("sitemap/photo/photo_list_all.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_list_all.xml") ;
    //图片大全列表 --图片 
	freemarkerUtils.generate("sitemap/photo/photo_list_agent_factory_catalog_1.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_pro_list_1.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_agent_factory_catalog_2.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_pro_list_2.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_agent_factory_catalog_3.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_pro_list_3.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_agent_factory_catalog_4.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_pro_list_4.xml") ;
	
	//施工图片列表 --图片
	freemarkerUtils.generate("sitemap/photo/photo_list_shigong_1.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_shigong_list_1.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_shigong_2.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_shigong_list_2.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_shigong_3.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_shigong_list_3.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_shigong_4.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_shigong_list_4.xml") ;
	
	//维修图片列表 --图片
	freemarkerUtils.generate("sitemap/photo/photo_list_weixiu_1.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_weixiu_list_1.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_weixiu_2.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_weixiu_list_2.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_weixiu_3.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_weixiu_list_3.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_weixiu_4.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_weixiu_list_4.xml") ;
	
	//趣味图片列表 --图片
	freemarkerUtils.generate("sitemap/photo/photo_list_quwei_1.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_quwei_list_1.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_quwei_2.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_quwei_list_2.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_quwei_3.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_quwei_list_3.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_quwei_4.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_quwei_list_4.xml") ;
 
	out.println("ok") ;
%>
