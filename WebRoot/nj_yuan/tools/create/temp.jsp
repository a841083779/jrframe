<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	// 生成所有产品详细页
	String absPath = Common.getAbsolutePath(request) ;
	FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"template/") ; 
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map root = null;
	 //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id<6544") ;	
	 //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id>=6544  and id<10131") ;	
	 //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id>=10131  and id<14218") ;	
	 //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id>=14218  and id<17808") ;	
	 //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id>=17808 and id<20092") ;
	 //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id>=20092") ;
	   
	   
	 //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id>=20092 and id<20599") ;
	 //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id>=20599 and id<20941") ;
	 //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id>=20941 and id<20992") ;
	 //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id>=20992 and id<21042") ; 
	 
	 		//zfc
		    //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id>=21042 and id<21073") ;
	        //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and id>=21073") ;
	
	 //List<Map> list = dbHelper.getMapList(" select * from pro_products where is_show = 1 and file_name is not null and factoryid=174") ;	
     List<Map> list = dbHelper.getMapList(" select * from pro_products where file_name is not null and file_name !='' and  factoryid=816  order by id asc") ;			
		if(null != list && list.size()>0){
			for(Map model:list){
				root = new HashMap();
				//产品的品牌信息
				String sql=" select full_name,logo from pro_agent_factory where id="+model.get("factoryid");
				List<Map> brandInfo = dbHelper.getMapList(sql) ;
				if(null != brandInfo && brandInfo.size()>0){
					for(Map brandMode:brandInfo){
						root.put("brandMode", brandMode);
					}
				}
				//产品品牌信息结束		
				String catalognum = (String)model.get("catalognum") ;
				String precatalogname = CommonString.getFormatPara(catalognum).length()>6?CommonString.getFormatPara(catalogMap.get(catalognum.substring(0,6))):CommonString.getFormatPara(catalogMap.get(catalognum)) ;
				String precatalognum="";
				String topcatalogname="";
				String topcatalognum="";
				if(catalognum.length()>6){precatalognum=catalognum.substring(0,6);}else{precatalognum=catalognum;}	
				if(catalognum.length()>3){topcatalognum=catalognum.substring(0,3);topcatalogname=CommonString.getFormatPara(catalogMap.get(topcatalognum));}
				else{topcatalognum=catalognum; topcatalogname=CommonString.getFormatPara(catalogMap.get(topcatalognum));}	

				root.put("model", model);
				root.put("precatalogname",precatalogname) ;
				root.put("precatalognum",precatalognum) ;
				root.put("topcatalogname",topcatalogname) ;
				root.put("topcatalognum",topcatalognum) ;
				String pageFlag1 = "paras";	
				String fileName = CommonString.getFormatPara(model.get("file_name"));
				String  createName1 = absPath+"proDetail/"+fileName;
				root.put("cName1","/proDetail/"+fileName);
				
				String pageFlag2 = "intro";
				String fileName2 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag2+".shtm";
				String createName2 = absPath+"proDetail/"+fileName2;			
				root.put("cName2","/proDetail/"+fileName2);
				
				String pageFlag3 = "pic";
				String fileName3 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag3+".shtm";
				String createName3 = absPath+"proDetail/"+fileName3;			
				root.put("cName3","/proDetail/"+fileName3);
				
				String pageFlag4 = "agent";
				String fileName4 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag4+".shtm";
				String createName4 = absPath+"proDetail/"+fileName4;			
				root.put("cName4","/proDetail/"+fileName4);
				
				String pageFlag5 = "message";
				String fileName5 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag5+".shtm";
				String createName5 = absPath+"proDetail/"+fileName5;			
				root.put("cName5","/proDetail/"+fileName5);
				
				String pageFlag6 = "order";
				String fileName6 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag6+".shtm";
				String createName6 = absPath+"proDetail/"+fileName6;			
				root.put("cName6","/proDetail/"+fileName6);
				
				String pageFlag7 = "parameter";
				String fileName7 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag7+".shtm";
				String createName7 = absPath+"proDetail/"+fileName7;			
				root.put("cName7","/proDetail/"+fileName7);
				
				String pageFlag8 = "video";
				String fileName8 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag8+".shtm";
				String createName8 = absPath+"proDetail/"+fileName8;			
				root.put("cName8","/proDetail/"+fileName8);
				
			    String pageFlag9 = "story";
				String fileName9 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag9+".shtm";
				String createName9 = absPath+"proDetail/"+fileName9;			
				root.put("cName9","/proDetail/"+fileName9);
					
                String pageFlag10 = "manual";
				String fileName10 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag10+".shtm";
				String createName10 = absPath+"proDetail/"+fileName10;			
				root.put("cName10","/proDetail/"+fileName10);	
				
				String pageFlag11 = "weixiu";
				String fileName11 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag11+".shtm";
				String createName11 = absPath+"proDetail/"+fileName11;			
				root.put("cName11","/proDetail/"+fileName11);
				
				String pageFlag12 = "shouhou";
				String fileName12 = fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_"+pageFlag12+".shtm";
				String createName12 = absPath+"proDetail/"+fileName12;			
				root.put("cName12","/proDetail/"+fileName12);	
				
				root.put("pageFlag",pageFlag1);
				freemarkerUtils.generate("/proDetail/detail_zongshu.shtm", root, createName1 ,request);
							
				root.put("pageFlag",pageFlag2);
				
				
				root.put("pageFlag",pageFlag3);
			
				
				root.put("pageFlag",pageFlag4);
				
				
				root.put("pageFlag",pageFlag5);
			
				root.put("pageFlag",pageFlag6);
				
				
				root.put("pageFlag",pageFlag7);
			
				root.put("pageFlag",pageFlag8);
				
				
				root.put("pageFlag",pageFlag9);
				
				
				root.put("pageFlag",pageFlag10);
			
				
				root.put("pageFlag",pageFlag11);
				
				root.put("pageFlag",pageFlag12);
				
			}
		}
	out.println("ok") ;
%>