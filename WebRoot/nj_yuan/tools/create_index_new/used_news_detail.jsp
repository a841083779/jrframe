<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*,org.json.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.webservice.WEBDBHelper"%>
<%
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
    String log="";
	Map root = new HashMap();
	String absPath = Common.getAbsolutePath(request);
	String realPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"/template/");
    try{
		connection = dbHelper.getConnection();
	    List <Map> proList =  dbHelper.getMapList(" select top 100 id,name from pro_agent_factory  where   is_show=1 and flag=1 order by view_count desc " ); 
	    for(Map m : proList){  
	   		//List<Map> getNewsList  = WEBDBHelper.getMapList("select top 5 title,CONVERT(varchar(100),add_date, 23) as add_date,html_filename from article where is_pub=1 and title like '%"+CommonString.getFormatPara(m.get("name"))+"%'  order by id desc","Web21NewsDBHelper");
			//root.put("getNewsList",getNewsList) ;
			//root.put("factoryname",CommonString.getFormatPara(m.get("name"))) ;
            //freemarkerUtils.generate("proDetail_temp/news_list.shtm",root,realPath+"/include/prodetail_new/news/news_"+CommonString.getFormatPara(m.get("id"))+".htm") ;	
			List<Map> usedList  = WEBDBHelper.getMapList("select  top 4  used_area.area_name,used_equipment.import_brand,used_equipment.price,used_equipment.workingtime,used_equipment.img1_1,used_equipment.factorydate,used_equipment.model,used_equipment.id,used_catalog.name from used_equipment,used_catalog,used_area  where used_equipment.is_review=1 and used_equipment.brand_id="+CommonString.getFormatPara(m.get("id"))+" and  used_equipment.is_pub=1 and  used_equipment.brand_id!='' and used_equipment.category_id=used_catalog.id and used_area.area_id=used_equipment.province_id and used_equipment.img1_1 like '%resource.21-sun%' order by  used_equipment.id desc","Web21usedDBHelper");
			root.put("factoryid",CommonString.getFormatPara(m.get("id"))) ;
			root.put("usedList",usedList) ;
			freemarkerUtils.generate("proDetail_temp/used_list.shtm",root,realPath+"/include/prodetail_new/used/used_"+CommonString.getFormatPara(m.get("id"))+".htm") ;	

	    }	
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>