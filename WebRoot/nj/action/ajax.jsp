<%@ page language="java" import="org.apache.commons.httpclient.params.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*,com.jerehnet.webservice.*,java.util.regex.*,org.json.*,java.util.*,com.jerehnet.util.common.*,java.sql.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.alipay.util.*"%>

<%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String tableName = CommonString.getFormatPara(request.getParameter("tableName"));
	String table_prefix = Env.getInstance().getProperty("table_prefix");
	String referer = CommonString.getFormatPara(request.getHeader("referer")) ;
	Connection connection = null;
	DBHelper dbHelper = DBHelper.getInstance();
	String rs = "fail";
	String callback = CommonString.getFilterStr(request.getParameter("callback"));
	Map catalogMap = (HashMap)application.getAttribute("catalogMap") ;
	
	Map brandProMap=(Map)application.getAttribute("machineBrandProMap");
	Map cataProMap=(Map)application.getAttribute("machineCataProMap");
 	if(brandProMap==null){
		brandProMap=new HashMap();
	}
	if(cataProMap==null){
		cataProMap=new HashMap();
	}


	
	try{
		connection = dbHelper.getConnection(); 	

		
		//更新浏览次数
		if("viewCount".equals(flag)){
			String uuid = CommonString.getFormatPara(request.getParameter("id"));
			dbHelper.execute(" update "+tableName+" set view_count = isnull(view_count,0)+1 where id = ? ",new Object [] {uuid},connection);
			
		}
		
		
		//询价单总数
		if("inquiryCount".equals(flag)){
			String uuid = CommonString.getFormatPara(request.getParameter("id"));
			dbHelper.execute(" update "+tableName+" set inquiry_count = isnull(inquiry_count,0)+1 where id = ? ",new Object [] {uuid},connection);		
		}
		//询价列表
		if("inquiry_list".equals(flag)){
			String id = CommonString.getFormatPara(request.getParameter("id"));
            List<Map> inquiryList = null ;
			String sql ="select top 5 add_date,province,city,name,id,product_name   from pro_machine_products_inquiry  where   product_id ="+id+" and is_del=0 order by add_date desc";
			inquiryList = dbHelper.getMapList(sql,connection) ;
			StringBuffer html = new StringBuffer("<li>暂无相关询价！</li>") ;
			if(null!=inquiryList && inquiryList.size()>0){
				html = new StringBuffer("") ;
			    for(Map oneMap:inquiryList){
			        html.append("<li>"+CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(oneMap.get("add_date")))+CommonString.getFormatPara(oneMap.get("province"))+CommonString.getFormatPara(oneMap.get("city"))+"的 "+((CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**")+" 询："+CommonString.getFormatPara(oneMap.get("product_name"))+"</li>") ;
			    }
		    }
			rs=html.toString();
		}


		
				
		//列表获取省市
		if("get_city_by_name".equals(flag)){
			String province = CommonString.getFormatPara(request.getParameter("province"));
			String area_id = CommonString.getFormatPara(request.getParameter("area_id"));
			Map map = dbHelper.getMap("select area_id  from comm_area   where  area_name like '%"+province+"%' ");
            if(map!=null){
				area_id= CommonString.getFormatPara(map.get("area_id"));
			}
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {area_id},connection);
			StringBuffer html = new StringBuffer("<option value=''>选择城市</option>");
		    for(Map m : areas){
				    html.append("<option value='"+CommonString.getFormatPara(m.get("area_name"))+"'>"+CommonString.getFormatPara(m.get("area_name"))+"</option>");
			}
			rs=html.toString();
		}
		
		//列表获取省市
		if("get_city".equals(flag)){
			String area_id = CommonString.getFormatPara(request.getParameter("area_id"));
			List<Map> areas = dbHelper.getMapList(" select area_id,area_name from comm_area where parent_area_id = ? ",new Object [] {area_id},connection);
			StringBuffer html = new StringBuffer("<option value=''>选择城市</option>");
		    for(Map m : areas){
				    html.append("<option value='"+CommonString.getFormatPara(m.get("area_name"))+"'>"+CommonString.getFormatPara(m.get("area_name"))+"</option>");
			}
			rs=html.toString();
		}
		
		
		
		//获取城市名称
		if("get_city_name".equals(flag)){
			String city = CommonString.getFormatPara(request.getParameter("city"));
			rs=city;
			Map areaMap = dbHelper.getMap(" select top 1 area_name  from comm_area where area_name  like '%"+city+"%' ");
			if(areaMap!=null){
				rs=CommonString.getFormatPara(areaMap.get("area_name"));
			}
		}
		
		
		//按照字母搜索品牌
		if("searchByLetter".equals(flag)){
			String whereStr="";
			String letter = CommonString.getFormatPara(request.getParameter("letter"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(!catalog.equals("")){
			whereStr+=" and id in (select brand_id from pro_machine_products where is_show=1 and catalog_num like '%"+catalog+"%' group by brand_id)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,first_letter  from pro_machine_brand  where   first_letter='"+letter+"' and  is_show=1"+whereStr;
			System.out.println(sql);
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br01'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/nj/prolist.jsp?factory="+CommonString.getFormatPara(oneMap.get("id"))+(catalog.equals("")?"":"&catalog="+catalog)+"'><span class='m'>"+CommonString.getFormatPara(oneMap.get("first_letter"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"<span style='color:red'>("+CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog.equals("")?"0":catalog)))+")"+"</span></span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();								
		}
				
		//搜索品牌
		if("searchBrand".equals(flag)){
			String whereStr="";
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(!catalog.equals("")){
			whereStr+=" and id in (select brand_id from pro_machine_products where is_show=1 and catalog_num like '%"+catalog+"%' group by brand_id)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,first_letter  from pro_machine_brand where    is_show=1 and (  name like  '%"+keyword+"%'  or   full_name  like '%"+keyword+"%'   ) "+whereStr+" order by first_letter  asc,id desc";
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br01'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/nj/prolist.jsp?factory="+CommonString.getFormatPara(oneMap.get("id"))+(catalog.equals("")?"":"&catalog="+catalog)+"'><span class='m'>"+CommonString.getFormatPara(oneMap.get("first_letter"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"<span style='color:red'>("+CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog.equals("")?"0":catalog)))+")"+"</span></span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();								
		}
						
		//搜索所有品牌
		if("searchAllBrand".equals(flag)){
			String whereStr="";
			String keyword = CommonString.getFormatPara(request.getParameter("keyword"));
			String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
			String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter"));
			if(!catalog.equals("")){
		    whereStr+=" and id in (select brand_id from pro_machine_products where is_show=1 and catalog_num like '%"+catalog+"%' group by brand_id)";
			}
			List<Map> brandList = null ;
			String sql ="select name,id,first_letter   from pro_machine_brand where  is_show=1 "+whereStr+" order by first_letter  asc ";
			StringBuffer html = new StringBuffer("") ;
		    brandList = dbHelper.getMapList(sql,connection) ;
	        if(brandList!=null&&brandList.size()>0){
		        for(Map oneMap:brandList){
				    html.append("<li class='br01'><a data-val='"+CommonString.getFormatPara(oneMap.get("id"))+"' title='"+CommonString.getFormatPara(oneMap.get("name"))+"' href='/nj/prolist.jsp?factory="+CommonString.getFormatPara(oneMap.get("id"))+(catalog.equals("")?"":"&catalog="+catalog)+"'><span class='m'>"+CommonString.getFormatPara(oneMap.get("first_letter"))+"-"+CommonString.getFormatPara(oneMap.get("name"))+"<span style='color:red'>("+CommonString.getFormatInt(brandProMap.get(CommonString.getFormatPara(oneMap.get("id"))+"_"+(catalog.equals("")?"0":catalog)))+")"+"</span></span></a><b></b></li>") ;
			    }
			}
			rs=html.toString();								
		}
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
	out.print(rs);
%>