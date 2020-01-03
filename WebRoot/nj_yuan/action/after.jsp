<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*" pageEncoding="UTF-8"%><%
	String event = CommonString.getFormatPara(request.getParameter("eventAfter"));
	String keyId = CommonString.getFormatPara(request.getParameter("keyId"));
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	String [] eventArr = event.split(",");
	List<String> eventList =Arrays.asList(eventArr);
	DBHelper dbHelper = DBHelper.getInstance();
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	Connection connection = null;
	Map model = null;
	try{
		connection = dbHelper.getConnection();
		connection.setAutoCommit(false);
		if(eventList.contains("createSubblock_lost")){
			String sql = CommonString.getFormatPara(request.getParameter("zd_data_sql"));
			String listName = CommonString.getFormatPara(request.getParameter("zd_list_name"));
			String tName = CommonString.getFormatPara(request.getParameter("zd_template_file_name"));
			String cName = CommonString.getFormatPara(request.getParameter("zd_create_file_name"));
			FreemarkerUtils fm = new FreemarkerUtils(application.getRealPath("/"));
			fm.toHtml(sql, listName, tName, application.getRealPath("/")+cName);
			fm = null;
		}

		//枚举更新Application
		if(eventList.contains("updateApplicationEnum")){
			CommonApplication.getEnumMap(application);
		}
		//栏目更新Application
		if(eventList.contains("updateApplicationChannel")){
			CommonApplication.getChannelMap(application);
		}
		//seo Application
		//产品类别更新Application
		if(eventList.contains("updateApplicationCatalog")){
			CommonApplication.getCatalogMap(application);
			CommonApplication.getSEOTitleKeyword(application);
		}
		//子块生成静态页
		if(eventList.contains("createSubblock_lost")){
			String sql = CommonString.getFormatPara(request.getParameter("zd_data_sql"));
			String listName = CommonString.getFormatPara(request.getParameter("zd_list_name"));
			String tName = CommonString.getFormatPara(request.getParameter("zd_template_file_name"));
			String cName = CommonString.getFormatPara(request.getParameter("zd_create_file_name"));
			FreemarkerUtils fm = new FreemarkerUtils(application.getRealPath("/"));
			fm.toHtml(sql, listName, tName, application.getRealPath("/")+cName);
			fm = null;
		}
		
		//生成产品的详细页
		if(eventList.contains("productsCreate")){
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
			Map<String,String> postMap = new HashMap<String,String>();
			postMap.put("id",id);
            String realPath = Common.getAbsolutePath(request) ;
            //提交id
			Common.doPostHttpAsync("http://spec.21-sun.com/tools/create_detail.jsp?id="+id,postMap);
			Common.doPostHttpAsync("http://m.product.21-sun.com/tools/create/create_mobile_detail.jsp?id="+id,postMap);
			
			//本条产品信息
			model = dbHelper.getMap(" select * from "+request.getParameter("tableName")+" where id = ? ",new Object [] {id},connection);
			Common.println("select * from "+request.getParameter("tableName")+" where id="+id);
			String is_show = CommonString.getFormatPara(model.get("is_show")) ;
		// 	if(!"".equals(is_show) && "1".equals(is_show)){  // 产品显示时才生成静态页
			String catalognum = (String)model.get("catalognum") ;
			String precatalogname = CommonString.getFormatPara(catalognum).length()>6?CommonString.getFormatPara(catalogMap.get(catalognum.substring(0,6))):CommonString.getFormatPara(catalogMap.get(catalognum)) ;
			String precatalognum="";
			String topcatalogname="";
			String topcatalognum="";
			if(catalognum.length()>6){precatalognum=catalognum.substring(0,6);}else{precatalognum=catalognum;}
			if(catalognum.length()>3){topcatalognum=catalognum.substring(0,3);topcatalogname=CommonString.getFormatPara(catalogMap.get(topcatalognum));}
			else{topcatalognum=catalognum; topcatalogname=CommonString.getFormatPara(catalogMap.get(topcatalognum));}	
			Map root = new HashMap();
			root.put("model", model);
			root.put("precatalogname",precatalogname) ;
			root.put("precatalognum",precatalognum) ;
			root.put("topcatalogname",topcatalogname) ;
			root.put("topcatalognum",topcatalognum) ;
				//产品的品牌信息
				String sql=" select full_name,logo,usern  from pro_agent_factory where id="+model.get("factoryid");
				List<Map> brandInfo = dbHelper.getMapList(sql) ;
				if(null != brandInfo && brandInfo.size()>0){
					for(Map brandMode:brandInfo){
						root.put("brandMode", brandMode);
					}
				}
			String absPath = Common.getAbsolutePath(request);
			FreemarkerUtils freemarkerUtils = new FreemarkerUtils(absPath+"/template/");
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
				freemarkerUtils.generate("/proDetail_new/detail_zongshu.shtm", root, createName1 ,request);
							
				root.put("pageFlag",pageFlag2);
				freemarkerUtils.generate("/proDetail_new/detail_xingneng.shtm", root, createName2 ,request);
				
				root.put("pageFlag",pageFlag3);
				freemarkerUtils.generate("/proDetail_new/detail_pic.shtm", root, createName3 ,request);
				
				root.put("pageFlag",pageFlag4);
				freemarkerUtils.generate("/proDetail_new/detail_dailishang.shtm", root, createName4 ,request);
				
				root.put("pageFlag",pageFlag5);
				freemarkerUtils.generate("/proDetail_new/detail_koubei.shtm", root, createName5 ,request);
				
				root.put("pageFlag",pageFlag6);
				freemarkerUtils.generate("/proDetail_new/detail_xunjia.shtm", root, createName6 ,request);
				
				root.put("pageFlag",pageFlag7);
				freemarkerUtils.generate("/proDetail_new/detail_canshu.shtm", root, createName7 ,request);
				
				root.put("pageFlag",pageFlag8);
				freemarkerUtils.generate("/proDetail_new/detail_video.shtm", root, createName8 ,request);
				
				root.put("pageFlag",pageFlag9);
				freemarkerUtils.generate("/proDetail_new/detail_story.shtm", root, createName9 ,request);
				
				root.put("pageFlag",pageFlag10);
				freemarkerUtils.generate("/proDetail_new/detail_manual.shtm", root, createName10 ,request);
				
				root.put("pageFlag",pageFlag11);
				freemarkerUtils.generate("/proDetail_new/detail_weixiu.shtm", root, createName11 ,request);
				
				root.put("pageFlag",pageFlag12);
				freemarkerUtils.generate("/proDetail_new/detail_shouhou.shtm", root, createName12 ,request);
				
				//生成详细页面中的引入页面
				root.put("pro_id",CommonString.getFormatPara(model.get("id"))) ;
			    root.put("factoryname",CommonString.getFormatPara(model.get("factoryname"))) ;
			    root.put("proname",CommonString.getFormatPara(model.get("name"))) ;
			    root.put("catalogname",CommonString.getFormatPara(model.get("catalogname"))) ;
                freemarkerUtils.generate("proDetail/include_comment_list.shtm",root,realPath+"/include/prodetail_comment/comment_list_"+id+".htm") ;
			    freemarkerUtils.generate("proDetail/include_order_list.shtm",root,realPath+"/include/prodetail_order/order_list_"+id+".htm") ;
		// 	}
		}
	
		//存元素和频道的关系
		if(eventList.contains("saveChannelSubblock")){
			//信息表
			String id = CommonString.getFormatPara(request.getParameter("keyId"));
			String channel_uuid = CommonString.getFormatPara(request.getParameter("channel_uuid"));
			String [] cuuidArr = channel_uuid.split(",");
			Map subblock = dbHelper.getMap(" select * from "+tablePrefix+"common_channel_subblock where id = ? ",new Object [] {id},connection);
			String uuid = (String)subblock.get("uuid");
			dbHelper.execute(" delete from " + tablePrefix + "common_acl_channel_subblock where subblock_uuid = ? " , new Object [] {uuid},connection);
			for(int i=0;i<cuuidArr.length;i++){
				dbHelper.execute(" insert into "+tablePrefix+"common_acl_channel_subblock ( channel_uuid , subblock_uuid ) values ( ? , ? )", new Object [] {cuuidArr[i],uuid},connection);
			}
		}
		//删除元素和频道的关系
		if(eventList.contains("deleteChannelSubblock")){
			String id = CommonString.getFormatPara(request.getParameter("del_id"));
			dbHelper.execute(" delete from "+tablePrefix+"common_acl_channel_subblock where subblock_uuid in ("+id+") " , connection);
		}
		// 更新 application 品牌
		if(eventList.contains("updateBrand")){
			CommonApplication.getBrandMap(application);
		}
		if(eventList.contains("updateAdAreaAgent")){
		 // 设置代理商信息的时候进行广告投放区域表设定
			List<Map> agent_facsList = null;
			String is_shop = CommonString.getFormatPara(request.getParameter("zd_is_shop")) ;
			String agentId = CommonString.getFormatPara(request.getParameter("zd_id")) ;
			String del_sql = "delete from pro_agent_ad_area where agent_id=?" ;
			if(!"".equals(agentId)){
				dbHelper.execute(del_sql,new Object[]{agentId}) ;
			}
			if("1".equals(is_shop) || "2".equals(is_shop) ||"3".equals(is_shop)){
			String fac_sql = "select agent_fac from pro_agent_factory where id=?" ;  // 选出当前代理商代理的品牌
			String agent_fac = "" ;
			 if(!"".equals(agentId)){
					agent_fac = CommonString.getFormatPara(dbHelper.getMap(fac_sql,new Object[]{agentId}).get("agent_fac")) ;  // 得到 代理商代理的品牌id
				}
				StringBuffer agent_fac_sbf = new StringBuffer("") ;
				String[] agent_facs_arr = null ;
				if(!"".equals(agent_fac)){
					agent_facs_arr = agent_fac.split(",") ;
					if(agent_facs_arr!=null && agent_facs_arr.length>0){
						for(int i=0;i<agent_facs_arr.length;i++){
							 if(!agent_facs_arr[i].trim().equals("")){
								 agent_fac_sbf.append(agent_facs_arr[i]).append(",") ;
							 }
						}
					}else{
						agent_fac_sbf = new StringBuffer(agent_fac) ;
					}
				}
				if(!"".equals(agent_fac_sbf.toString())&&agent_fac_sbf.toString().indexOf(",")!=-1){
					agent_fac_sbf = new StringBuffer(agent_fac_sbf.substring(0,agent_fac_sbf.length()-1)) ;
				}
				if(!"".equals(agent_fac)){
					if(agent_fac.startsWith(",")){
						agent_fac = "0"+agent_fac;
					}
					if(agent_fac.endsWith(",")){
						agent_fac = agent_fac + "0";
					}
				}
				String agent_facs = "select id,name,logo from pro_agent_factory where id in("+agent_fac_sbf+")" ;
				agent_facsList = dbHelper.getMapList(agent_facs,connection);	
				List<Map> cityList = null ;
		    	   String fid = "";
		    	   String sql = " select b.area_id,b.area_name,b.parent_area_id";
		    	   sql += ",checked = ( case when c.agent_id is null then 'false' else 'true' end )";
		    	   sql += " from pro_agent_factory_and_area a ";
		    	   sql += " inner join comm_area b on a.area_id = b.area_id and a.agent_id = "+agentId+" and a.factory_id = ?";
		    	   sql += " left join pro_agent_ad_area c on a.area_id = c.area_id and c.agent_id = "+agentId+" and c.factory_id = ?";
		    	   sql += " order by b.area_id asc ";
		    	   String ins_sql = "insert into pro_agent_ad_area(agent_id,area_id,factory_id) values(?,?,?)" ;
		    	   if(null!=agent_facsList && agent_facsList.size()>0){
		    		   for(Map oneMap:agent_facsList){
		    			   fid = CommonString.getFormatPara(oneMap.get("id")) ;
		    			   cityList = dbHelper.getMapList(sql,new Object[]{fid,fid}) ;
		    			   if(null!=cityList && cityList.size()>0){
		    				   for(Map twoMap:cityList){
		    					   dbHelper.execute(ins_sql,new Object[]{agentId,CommonString.getFormatPara(twoMap.get("area_id")),fid}) ;
		    				   }
		    			   }
		    		   }
		    	   }
		}
		}
		if(eventList.contains("open_mem_shop")){
			String is_shop_flag = CommonString.getFormatPara(request.getParameter("is_shop_flag")) ;
			String is_shop = CommonString.getFormatPara(request.getParameter("zd_is_shop")) ; 
			String zd_id = CommonString.getFormatPara(request.getParameter("zd_id")) ;
			String upt_sql = "update pro_agent_factory set mem_open_date=? ,mem_end_date = ? where id=?" ;
			if(!"0".equals(is_shop) && !is_shop.equals(is_shop_flag)){
				dbHelper.execute(upt_sql,new Object[]{CommonDate.getToday("yyyy-MM-dd HH:mm:ss"),CommonDate.dateAdd("365","yyyy-MM-dd HH:mm:ss"),zd_id}) ;
			}
		}
		connection.commit();
	}catch(Exception e){
		connection.rollback();
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
	request.getRequestDispatcher("/action/after_own.jsp").forward(request,response);
%>