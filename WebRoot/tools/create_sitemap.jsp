<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,org.json.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerUtils"%>
<%@page import="com.jerehnet.util.common.Common"%>
<%@page import="com.jerehnet.webservice.*"%>
<%@page import="com.jerehnet.util.freemarker.FreemarkerWebserviceUtils"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
DBHelper dbHelper = DBHelper.getInstance();
Connection conn = null;
String flag=CommonString.getFormatPara(request.getParameter("flag"));

try{
	conn = dbHelper.getConnection();
	if("catalog".equals(flag)){
		String html="";
		List<Map> list =dbHelper.getMapList(" select num from pro_catalog where is_show=1 ",conn);
		if(list!=null&&list.size()>0){
			for(Map m:list){
				html+="";
				html+="<url>";
				html+="<loc>http://product.21-sun.com/products/prolist.jsp?catalog="+CommonString.getFormatPara(m.get("num"))+"</loc>";
				html+="<lastmod>2019-09-25</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.9</priority>";
				html+="</url>";
			}
		}
		out.print(html);
	}
	if("brand".equals(flag)){
		String html="";
		List<Map> list =dbHelper.getMapList(" select id from pro_agent_factory where is_show=1 and flag=1 ",conn);
		if(list!=null&&list.size()>0){
			for(Map m:list){
				html+="";
				html+="<url>";
				html+="<loc>http://product.21-sun.com/products/prolist.jsp?factory="+CommonString.getFormatPara(m.get("id"))+"</loc>";
				html+="<lastmod>2019-09-25</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.9</priority>";
				html+="</url>";
			}
		}
		out.print(html);
	}
	if("catalogBrand".equals(flag)){
		String html="";
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=0 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=2 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=10 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=14 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=28 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=32 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=59 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=104 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=136 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=151 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=160 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=186 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=192 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=199 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=230 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=365 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=492 ",conn);
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=505 ",conn);
		List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=508 ",conn);
		if(list!=null&&list.size()>0){
			for(Map m:list){
				List<Map> brandList =dbHelper.getMapList(" select id from pro_agent_factory where is_show=1 and flag=1 ",conn);
				if(brandList!=null && brandList.size()>0){
					for(Map model:brandList){
						html+="";
						html+="<url>";
						html+="<loc>http://product.21-sun.com/products/prolist.jsp?factory="+CommonString.getFormatPara(model.get("id"))+"&catalog="+CommonString.getFormatPara(m.get("num"))+"</loc>";
						html+="<lastmod>2019-09-25</lastmod>";
						html+="<changefreq>monthly</changefreq>";
						html+="<priority>0.9</priority>";
						html+="</url>";
					}
				}
			}
		}
		out.print(html);
	}
	if("detail".equals(flag)){
		String html="";
		//List<Map> list =dbHelper.getMapList(" select top 1000 id,file_name from pro_products where is_create_mobile=0  ",conn);
		List<Map> list =dbHelper.getMapList(" select top 1000 id,file_name from pro_products where file_name_y like '%&%'  ",conn);
		if(list!=null&&list.size()>0){
			for(Map m:list){
				String id =CommonString.getFormatPara(m.get("id"));
				String fileName=CommonString.getFormatPara(m.get("file_name"));
				html+="<url>";
				html+="<loc>http://product.21-sun.com/proDetail/"+fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+".shtm</loc>";
				html+="<lastmod>2019-09-25</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.8</priority>";
				html+="</url>";
				html+="<url>";
				html+="<loc>http://product.21-sun.com/proDetail/"+fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_parameter.shtm</loc>";
				html+="<lastmod>2019-09-25</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.8</priority>";
				html+="</url>";
				html+="<url>";
				html+="<loc>http://product.21-sun.com/proDetail/"+fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_pic.shtm</loc>";
				html+="<lastmod>2019-09-25</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.8</priority>";
				html+="</url>";
				html+="<url>";
				html+="<loc>http://product.21-sun.com/proDetail/"+fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_agent.shtm</loc>";
				html+="<lastmod>2019-09-25</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.8</priority>";
				html+="</url>";
				html+="<url>";
				html+="<loc>http://product.21-sun.com/proDetail/"+fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_message.shtm</loc>";
				html+="<lastmod>2019-09-25</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.8</priority>";
				html+="</url>";
				
				dbHelper.executeUpdate(" update pro_products set is_create_mobile=1 where id=?  ",new Object[]{id},conn);
			}
		}
		out.print(html);
	}
	if("brandMenu".equals(flag)){
		String html="";
		List<Map> list =dbHelper.getMapList(" select usern from pro_agent_factory where flag=1 ",conn);
		if(list!=null&&list.size()>0){
			for(Map m:list){
				html+="";
				html+="<url>";
				html+="<loc>http://product.21-sun.com/brand/"+CommonString.getFormatPara(m.get("usern"))+"/</loc>";
				html+="<lastmod>2019-09-25</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.7</priority>";
				html+="</url>";
			}
		}
		out.print(html);
	}
	if("agentCatalog".equals(flag)){
		String html="";
		List<Map> list =dbHelper.getMapList(" select num from pro_catalog where is_show=1 and parentid=0 ",conn);
		if(list!=null&&list.size()>0){
			for(Map m:list){
				html+="";
				html+="<url>";
				html+="<loc>http://product.21-sun.com/agent/0_"+CommonString.getFormatPara(m.get("num"))+"_0_0.shtm</loc>";
				html+="<lastmod>2019-09-25</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.7</priority>";
				html+="</url>";
			}
		}
		out.print(html);
	}
	if("agentBrand".equals(flag)){
		String html="";
		List<Map> list =dbHelper.getMapList(" select id from pro_agent_factory where is_show=1 and flag=1 ",conn);
		if(list!=null&&list.size()>0){
			for(Map m:list){
				html+="";
				html+="<url>";
				html+="<loc>http://product.21-sun.com/agent/0_0_"+CommonString.getFormatPara(m.get("id"))+"_0.shtm</loc>";
				html+="<lastmod>2019-09-25</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.7</priority>";
				html+="</url>";
			}
		}
		out.print(html);
	}
	if("agentCatalogBrand".equals(flag)){
		String html="";
		List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=0 ",conn);
		if(list!=null&&list.size()>0){
			for(Map m:list){
				List<Map> brandList =dbHelper.getMapList(" select id from pro_agent_factory where is_show=1 and flag=1 ",conn);
				if(brandList!=null && brandList.size()>0){
					for(Map model:brandList){
						html+="";
						html+="<url>";
						html+="<loc>http://product.21-sun.com/agent/0_"+CommonString.getFormatPara(m.get("num"))+"_"+CommonString.getFormatPara(model.get("id"))+"_0.shtm</loc>";
						html+="<lastmod>2019-09-25</lastmod>";
						html+="<changefreq>monthly</changefreq>";
						html+="<priority>0.7</priority>";
						html+="</url>";
					}
				}
			}
		}
		out.print(html);
	}
	
	
} catch (Exception ex) {
	ex.printStackTrace();
} finally {
	dbHelper.freeConnection(conn);
}
   
%>