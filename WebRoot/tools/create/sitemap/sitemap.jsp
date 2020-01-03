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
    //通过
	//freemarkerUtils.generate("sitemap/brand_menu.shtm",root,realPath+"/include/sitemap/sitemap1.xml") ; 
	//通过
    //freemarkerUtils.generate("sitemap/brand_menu_second.shtm",root,realPath+"/include/sitemap/sitemap2.xml") ;  				
	//通过
    //freemarkerUtils.generate("sitemap/agent_detail_list.shtm",root,realPath+"/include/sitemap/sitemap3.xml") ;  				
    //通过 
	//freemarkerUtils.generate("sitemap/agent_detail_list_second1.shtm",root,realPath+"/include/sitemap/sitemap4.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_detail_list_second2.shtm",root,realPath+"/include/sitemap/sitemap5.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_detail_list_second3.shtm",root,realPath+"/include/sitemap/sitemap6.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_detail_list_second4.shtm",root,realPath+"/include/sitemap/sitemap7.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_detail_list_second5.shtm",root,realPath+"/include/sitemap/sitemap8.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_detail_list_second6.shtm",root,realPath+"/include/sitemap/sitemap9.xml") ; 
	//通过
	//freemarkerUtils.generate("sitemap/case_list.shtm",root,realPath+"/include/sitemap/sitemap10.xml") ;  				
 	//通过			
	//freemarkerUtils.generate("sitemap/top_list.shtm",root,realPath+"/include/sitemap/sitemap11.xml") ;  		 
	//通过 
	//freemarkerUtils.generate("sitemap/pro_pic_list.shtm",root,realPath+"/include/sitemap/sitemap12.xml") ;  				
    //通过 
	//freemarkerUtils.generate("sitemap/pro_pic_list_second.shtm",root,realPath+"/include/sitemap/sitemap13.xml") ;  
	
	//通过 
	//freemarkerUtils.generate("sitemap/prodetail_list.shtm",root,realPath+"/include/sitemap/sitemap14.xml") ;  				
	//freemarkerUtils.generate("sitemap/prodetail_list1.shtm",root,realPath+"/include/sitemap/sitemap15.xml") ;  				
	//freemarkerUtils.generate("sitemap/prodetail_list2.shtm",root,realPath+"/include/sitemap/sitemap16.xml") ;  				
	//freemarkerUtils.generate("sitemap/prodetail_list3.shtm",root,realPath+"/include/sitemap/sitemap17.xml") ;  				
	//freemarkerUtils.generate("sitemap/prodetail_list4.shtm",root,realPath+"/include/sitemap/sitemap18.xml") ;  				
			
    //通过
	//freemarkerUtils.generate("sitemap/inquiry_list.shtm",root,realPath+"/include/sitemap/sitemap19.xml") ; 
	//freemarkerUtils.generate("sitemap/inquiry_list1.shtm",root,realPath+"/include/sitemap/sitemap20.xml") ; 
	//freemarkerUtils.generate("sitemap/inquiry_list2.shtm",root,realPath+"/include/sitemap/sitemap21.xml") ; 
	//freemarkerUtils.generate("sitemap/inquiry_list3.shtm",root,realPath+"/include/sitemap/sitemap22.xml") ; 
	//freemarkerUtils.generate("sitemap/inquiry_list4.shtm",root,realPath+"/include/sitemap/sitemap23.xml") ; 
	//freemarkerUtils.generate("sitemap/inquiry_list5.shtm",root,realPath+"/include/sitemap/sitemap24.xml") ; 
	//freemarkerUtils.generate("sitemap/inquiry_list6.shtm",root,realPath+"/include/sitemap/sitemap25.xml") ; 
	//freemarkerUtils.generate("sitemap/inquiry_list7.shtm",root,realPath+"/include/sitemap/sitemap26.xml") ; 
	//freemarkerUtils.generate("sitemap/inquiry_list8.shtm",root,realPath+"/include/sitemap/sitemap27.xml") ; 
	//freemarkerUtils.generate("sitemap/inquiry_list9.shtm",root,realPath+"/include/sitemap/sitemap28.xml") ; 
	//freemarkerUtils.generate("sitemap/inquiry_list10.shtm",root,realPath+"/include/sitemap/sitemap29.xml") ; 
   // freemarkerUtils.generate("sitemap/inquiry_list11.shtm",root,realPath+"/include/sitemap/sitemap30.xml") ;
    //freemarkerUtils.generate("sitemap/inquiry_list12.shtm",root,realPath+"/include/sitemap/sitemap31.xml") ;
	 //通过
	//freemarkerUtils.generate("sitemap/agent_list.shtm",root,realPath+"/include/sitemap/sitemap32.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_list1.shtm",root,realPath+"/include/sitemap/sitemap33.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_list2.shtm",root,realPath+"/include/sitemap/sitemap34.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_list3.shtm",root,realPath+"/include/sitemap/sitemap35.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_list4.shtm",root,realPath+"/include/sitemap/sitemap36.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_list5.shtm",root,realPath+"/include/sitemap/sitemap37.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_list6.shtm",root,realPath+"/include/sitemap/sitemap38.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_list7.shtm",root,realPath+"/include/sitemap/sitemap39.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_list8.shtm",root,realPath+"/include/sitemap/sitemap40.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_list9.shtm",root,realPath+"/include/sitemap/sitemap41.xml") ; 
	//freemarkerUtils.generate("sitemap/agent_list10.shtm",root,realPath+"/include/sitemap/sitemap42.xml") ; 
    //freemarkerUtils.generate("sitemap/agent_list11.shtm",root,realPath+"/include/sitemap/sitemap43.xml") ;
    //freemarkerUtils.generate("sitemap/agent_list12.shtm",root,realPath+"/include/sitemap/sitemap44.xml") ;
/*
	List<Map> allbrandMap = dbHelper.getMapList("select  id from pro_agent_factory where  is_show=1 and  flag = 1 and usern<>'tdbenniu'  order by id asc") ;
   	if(null != allbrandMap && allbrandMap.size()>0){
	root = new HashMap();
		for(Map oneMap:allbrandMap){
			factoryid = CommonString.getFormatPara(oneMap.get("id")) ;
			root.put("factoryid",factoryid) ;
          freemarkerUtils.generate("sitemap/agent_list13.shtm",root,realPath+"/include/sitemap/agent/sitemap_agent_"+factoryid+".xml") ;
			freemarkerUtils.generate("sitemap/inquiry_list13.shtm",root,realPath+"/include/sitemap/inquiry/sitemap_inquiry_"+factoryid+".xml") ;
		}
	}
*/
   	
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
    //最新口碑--口碑
	freemarkerUtils.generate("sitemap/koubei/koubei_new.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_new.xml") ;

	//产品口碑--口碑
	freemarkerUtils.generate("sitemap/koubei/koubei_comments.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_comments.xml") ;
	
    //口碑排行榜--口碑
	freemarkerUtils.generate("sitemap/koubei/koubei_rank.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_rank.xml") ;

    //品牌街--专题
	freemarkerUtils.generate("sitemap/spec/spec_brands.shtm", root,realPath+"/include/sitemap/spec/sitemap_spec_brands.xml") ;
  	
    //产品详情--专题
	freemarkerUtils.generate("sitemap/spec/spec_proDetail.shtm", root,realPath+"/include/sitemap/spec/sitemap_spec_proDetail.xml") ;

	//列表--专题
	freemarkerUtils.generate("sitemap/spec/spec_list.shtm", root,realPath+"/include/sitemap/spec/sitemap_spec_list.xml") ;
    
    //施工图片列表 --图片
	freemarkerUtils.generate("sitemap/photo/photo_other_catalog.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_other_catalog.xml") ;

    //施工图片列表 --图片
	freemarkerUtils.generate("sitemap/photo/photo_other_agent_factory.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_other_agent_factory.xml") ;
    
    //施工图片列表 --图片
	freemarkerUtils.generate("sitemap/photo/photo_other_agent_factory_catalog_1.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_other_agent_factory_catalog_1.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_other_agent_factory_catalog_2.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_other_agent_factory_catalog_2.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_other_agent_factory_catalog_3.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_other_agent_factory_catalog_3.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_other_agent_factory_catalog_4.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_other_agent_factory_catalog_4.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_other_agent_factory_catalog_5.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_other_agent_factory_catalog_5.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_other_agent_factory_catalog_6.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_other_agent_factory_catalog_6.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_other_agent_factory_catalog_7.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_other_agent_factory_catalog_7.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_other_agent_factory_catalog_8.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_other_agent_factory_catalog_8.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_other_agent_factory_catalog_9.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_other_agent_factory_catalog_9.xml") ;

	//行业图片--图片
	freemarkerUtils.generate("sitemap/photo/photo_nlist.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_nlist.xml") ;
    //图片大全列表 --图片 
	freemarkerUtils.generate("sitemap/photo/photo_list_catalog.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_list_catalog.xml") ;
    //图片大全列表 --图片 
	freemarkerUtils.generate("sitemap/photo/photo_list_agent_factory.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_list_agent_factory.xml") ;
    //图片大全列表 --图片 
	freemarkerUtils.generate("sitemap/photo/photo_list_agent_factory_catalog_1.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_list_agent_factory_catalog_1.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_agent_factory_catalog_2.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_list_agent_factory_catalog_2.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_agent_factory_catalog_3.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_list_agent_factory_catalog_3.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_list_agent_factory_catalog_4.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_list_agent_factory_catalog_4.xml") ;
	
	//产品详情--口碑
	freemarkerUtils.generate("sitemap/koubei/koubei_products.shtm", root,realPath+"/include/sitemap/koubei/sitemap_koubei_products.xml") ;
	
	//产品图片 --图片
	freemarkerUtils.generate("sitemap/photo/photo_detail.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_detail.xml") ;

    //行业图片 --图片
	freemarkerUtils.generate("sitemap/photo/photo_ndetail.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_ndetail.xml") ;
	
    //展会图片 --图片
	freemarkerUtils.generate("sitemap/photo/photo_zhanhui_1.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_zhanhui_1.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_zhanhui_2.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_zhanhui_2.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_zhanhui_3.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_zhanhui_3.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_zhanhui_4.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_zhanhui_4.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_zhanhui_5.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_zhanhui_5.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_zhanhui_6.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_zhanhui_6.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_zhanhui_7.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_zhanhui_7.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_zhanhui_8.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_zhanhui_8.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_zhanhui_9.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_zhanhui_9.xml") ;
	freemarkerUtils.generate("sitemap/photo/photo_zhanhui_10.shtm", root,realPath+"/include/sitemap/photo/sitemap_photo_zhanhui_10.xml") ;

	out.println("ok") ;
%>
