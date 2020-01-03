<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%><%
 	DBHelper dbHelper = DBHelper.getInstance() ;
	Map proParamMap = (Map) application.getAttribute("proParamMap");
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
    Connection connection = null;
	try{
		connection = dbHelper.getConnection();
		if("getModel".equals(flag)){//根据类别获取机型列表
			String cat = CommonString.getFormatPara(request.getParameter("cat"));
			String whereStr="",html="<option value=''>不限</option>";
			if("sanjiao".equals(cat)){
				whereStr+=" and catalogname ='三角式破碎锤' ";
			}
			if("zhijiao".equals(cat)){
				whereStr+=" and catalogname ='直角式破碎锤' ";
			}
			if("jingyin".equals(cat)){
				whereStr+=" and catalogname ='静音式破碎锤' ";
			}
			if("fensuiqian".equals(cat)){
				whereStr+=" and catalogname ='单缸单轴液压粉碎钳' ";
			}
			if("dangangjian".equals(cat)){
				whereStr+=" and catalogname ='单缸单轴液压剪' ";
			}
			if("shuanggangjian".equals(cat)){
				whereStr+=" and catalogname ='双缸双轴多功能液压剪' ";
			}
			if("miniqian".equals(cat)){
				whereStr+=" and catalogname ='迷你液压钳' ";
			}
			List<Map> list =dbHelper.getMapList(" select id,file_name,name from pro_products where factoryid=18936 and is_show=1 "+whereStr+" order by view_count desc,id desc ");
			if(list!=null && list.size()>0){
				for(Map m:list){
					html +="<option value='"+CommonString.getFormatPara(m.get("file_name"))+"'>"+CommonString.getFormatPara(m.get("name"))+"</option>";
				}
			}
			out.print(html);
		}
		if("orderList".equals(flag)){
			String html="";
			int total=(Integer)dbHelper.getOne(" select count(id) as a from pro_agent_products_form where factory_id=18939  ");
			String order_sql = "select top 10 factory_name,product_name,cata_name,user_name,contact_tel,contact_address,form_date from pro_agent_products_form where factory_id=18939  order by id desc" ;
			List<Map> list = dbHelper.getMapList(order_sql) ;
			if(list!=null && list.size()>0){
				int num=0;
				for(Map m:list){
					num++;
					String classs="";
					if(num%2==1){
						classs="nor_bg";
					}else{
						classs="spe_bg";
					}
					html+="<div class='li'>";
					html+="<ul class='"+classs+"'>";
					html+="<li class='i1'>"+num+"</li>";
					html+="<li class='i2'>"+CommonString.getFormatPara(m.get("factory_name"))+CommonString.getFormatPara(m.get("product_name"))+CommonString.getFormatPara(m.get("cata_name"))+"</li>";
					html+="<li class='i3'>"+CommonString.getFormatPara(m.get("user_name")).substring(0,1)+"**</li>";
					html+="<li class='i4'>"+CommonString.getFormatPara(m.get("contact_tel")).substring(0,3)+"***"+CommonString.getFormatPara(m.get("contact_tel")).substring(8,11)+"</li>";
					html+="<li class='i5'>正迪</li>";
					html+="<li class='i6'>"+CommonString.getFormatPara(m.get("contact_address"))+"</li>";
					html+="<li class='i7'>"+CommonString.getFormatPara(m.get("form_date"))+"</li>";
					html+="</ul>";
					html+="</div>";
				}
			}
			out.print(total+"@_@"+html);
		}
		if("moreModel".equals(flag)){
			String cat = CommonString.getFormatPara(request.getParameter("cat"));
			Integer pageNum = CommonString.getFormatInt(request.getParameter("pageIndex"));
			System.out.println(pageNum);
			String whereStr="",html="";
			if(!"".equals(cat) && !"undefined".equals(cat)){
				whereStr=" and (";
				for(int i=0;i<cat.split("@_@").length;i++){
					String cats=cat.split("@_@")[i];
					if("sanjiao".equals(cats)){
						whereStr+=" catalogname ='三角式破碎锤' ";
					}
					if("zhijiao".equals(cats)){
						whereStr+=" catalogname ='直角式破碎锤' ";
					}
					if("jingyin".equals(cats)){
						whereStr+=" catalogname ='静音式破碎锤'  ";
					}
					if("fensuiqian".equals(cats)){
						whereStr+=" catalogname ='单缸单轴液压粉碎钳'  ";
					}
					if("dangangjian".equals(cats)){
						whereStr+=" catalogname ='单缸单轴液压剪'  ";
					}
					if("shuanggangjian".equals(cats)){
						whereStr+=" catalogname ='双缸双轴多功能液压剪'  ";
					}
					if("miniqian".equals(cats)){
						whereStr+=" catalogname ='迷你液压钳'  ";
					}
					if(i<cat.split("@_@").length-1){
						whereStr+=" or ";
					}
				}
				whereStr +=" ) ";
			}
			
			if(pageNum==0){
		        pageNum=1;
	        }
    		String sql="select top 6 id,catalogname,name,file_name,zoomlion_hot_pic  from pro_products where factoryid=18936 and is_show=1 "+whereStr+" and id not in (select top "+(pageNum-1)*6+" id from pro_products where factoryid=18936 and is_show=1 "+whereStr+"  order by view_count desc,id desc)  order by view_count desc,id desc ";
 			List <Map> list = dbHelper.getMapList(sql,connection);
 			if(null != list && list.size() > 0){
       			for(Map m : list){
					String id =CommonString.getFormatPara(m.get("id"));
					String paramStr="";
					if(proParamMap!=null){
                        List <Map> paramList=(List<Map>)(proParamMap.get(id));	
						int num=0;						
						if(paramList != null && paramList.size() > 0) {
					        for (Map mmm : paramList) {
								num++;
								if(num==1){
									paramStr+="<p class='item_p1'>"+CommonString.getFormatPara(mmm.get("param_name"))+"："+CommonString.getFormatPara(mmm.get("param_value"))+"</p>";
								}
								if(num==2){
									paramStr+="<p class='item_p2'>"+CommonString.getFormatPara(mmm.get("param_name"))+"："+CommonString.getFormatPara(mmm.get("param_value"))+"</p>";
								}
							
						}}
					}
					html+="<div class='list_item l'>";
					html+="<a href='http://product.21-sun.com/proDetail/"+CommonString.getFormatPara(m.get("file_name"))+"' target='_blank' class='item_link'>";
					html+="<p class='item_cat'>"+CommonString.getFormatPara(m.get("catalogname"))+"</p>";
					html+="<p class='item_type'>"+CommonString.getFormatPara(m.get("name"))+"</p>";
					html+=paramStr;
					html+="<div class='item_icon'>";
					html+="<img src='http://product.21-sun.com/uploadfiles/"+CommonString.getFormatPara(m.get("zoomlion_hot_pic"))+"' onerror='this.src=\"/uploadfiles/no_big.gif\"' />";
					html+="</div>";
					html+="</a>";
					html+="</div>";
				}
			}
			out.print(html);
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>
