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
				html+="<loc>http://m.21-sun.com/product/rank_0_"+CommonString.getFormatPara(m.get("num"))+"_0_0_0.htm</loc>";
				html+="<lastmod>2019-09-27</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.9</priority>";
				html+="</url>";
				html+="<url>";
				html+="<loc>http://m.21-sun.com/product/p_0_"+CommonString.getFormatPara(m.get("num"))+"_0_0_1_0.htm</loc>";
				html+="<lastmod>2019-09-27</lastmod>";
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
				html+="<loc>http://m.21-sun.com/product/rank_"+CommonString.getFormatPara(m.get("id"))+"_0_0_1_0.htm</loc>";
				html+="<lastmod>2019-09-27</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.9</priority>";
				html+="</url>";
				html+="<url>";
				html+="<loc>http://m.21-sun.com/product/p_"+CommonString.getFormatPara(m.get("id"))+"_0_0_0_1_0.htm</loc>";
				html+="<lastmod>2019-09-27</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.9</priority>";
				html+="</url>";
			}
		}
		out.print(html);
	}
	if("catalogBrand".equals(flag)){
		String html="";
		String parentId=CommonString.getFormatPara(request.getParameter("parentId"));
		List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=? ",new Object[]{parentId},conn);
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
		//List<Map> list =dbHelper.getMapList(" select num from pro_catalog where parentid=508 ",conn);
		if(list!=null&&list.size()>0){
			for(Map m:list){
				List<Map> brandList =dbHelper.getMapList(" select id from pro_agent_factory where is_show=1 and flag=1 ",conn);
				if(brandList!=null && brandList.size()>0){
					for(Map model:brandList){
						html+="";
						html+="<url>";
						html+="<loc>http://m.21-sun.com/product/rank_"+CommonString.getFormatPara(model.get("id"))+"_"+CommonString.getFormatPara(m.get("num"))+"_0_1_0.htm</loc>";
						html+="<lastmod>2019-09-27</lastmod>";
						html+="<changefreq>monthly</changefreq>";
						html+="<priority>0.9</priority>";
						html+="</url>";
						html+="<url>";
						html+="<loc>http://m.21-sun.com/product/p_"+CommonString.getFormatPara(model.get("id"))+"_"+CommonString.getFormatPara(m.get("num"))+"_0_0_1_0.htm</loc>";
						html+="<lastmod>2019-09-27</lastmod>";
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
		List<Map> list =dbHelper.getMapList(" select top 1000 id,file_name from pro_products where is_create_mobile=0  ",conn);
		//List<Map> list =dbHelper.getMapList(" select top 1000 id,file_name from pro_products where file_name_y like '%&%'  ",conn);
		if(list!=null&&list.size()>0){
			for(Map m:list){
				String id =CommonString.getFormatPara(m.get("id"));
				String fileName=CommonString.getFormatPara(m.get("file_name"));
				html+="<url>";
				html+="<loc>http://m.21-sun.com/product/proDetail/"+fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+".htm</loc>";
				html+="<lastmod>2019-09-27</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.8</priority>";
				html+="</url>";
				html+="<url>";
				html+="<loc>http://m.21-sun.com/product/proDetail/"+fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_param.htm</loc>";
				html+="<lastmod>2019-09-27</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.8</priority>";
				html+="</url>";
				html+="<url>";
				html+="<loc>http://m.21-sun.com/product/proDetail/"+fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_pic.htm</loc>";
				html+="<lastmod>2019-09-27</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.8</priority>";
				html+="</url>";
				html+="<url>";
				html+="<loc>http://m.21-sun.com/product/proDetail/"+fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_agent.htm</loc>";
				html+="<lastmod>2019-09-27</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.8</priority>";
				html+="</url>";
				html+="<url>";
				html+="<loc>http://m.21-sun.com/product/proDetail/"+fileName.substring(0,fileName.lastIndexOf(".shtm")>=0?fileName.lastIndexOf(".shtm"):fileName.length())+"_koubei.htm</loc>";
				html+="<lastmod>2019-09-27</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.8</priority>";
				html+="</url>";
				
				dbHelper.executeUpdate(" update pro_products set is_create_mobile=1 where id=?  ",new Object[]{id},conn);
			}
		}
		out.print(html);
	}
	if("agent".equals(flag)){
		String html="";
		List<Map> list =dbHelper.getMapList(" select id from pro_agent_factory where flag=1 ",conn);
		if(list!=null&&list.size()>0){
			for(Map m:list){
				html+="";
				html+="<url>";
				html+="<loc>http://m.21-sun.com/product/a__"+CommonString.getFormatPara(m.get("id"))+".htm</loc>";
				html+="<lastmod>2019-09-27</lastmod>";
				html+="<changefreq>monthly</changefreq>";
				html+="<priority>0.7</priority>";
				html+="</url>";
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