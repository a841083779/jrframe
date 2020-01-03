<%@page import="org.apache.solr.common.SolrDocumentList"%>
<%@page import="org.apache.solr.common.SolrDocument"%>
<%@page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%@page import="com.jerehnet.util.dbutil.DBHelper"%><%@ page session="false" %><%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%><%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
	DBHelper dbHelper = DBHelper.getInstance() ;
	
	String cacheKey = "brand_comments_"+factoryid;
	
	//厂家
	Map factoryMap = null; 
	List<Map> articleList = null ;
	String factoryName = "";
	String factorycatalogName = "";
	String factorypro_brand_title = "";
	String factorylogo = "";
	String factoryurl = "";
	String view_count="";
	String usern = "";
	
	
%>
<cache:cache cron="*/1 * * * *" key="<%=cacheKey%>">
<%
	if(factoryid!=null && !factoryid.equals("")){
		String factory_sql = "select is_made,pro_brand_title, is_qijiandian,usern,is_shop,id,name,is_shop,logo,full_name,introduce,mobile,url,img1,telphone,banner,create_date,master,weibo,email,view_count from pro_agent_factory where id = '"+factoryid+"' and is_show=1 and flag=1" ;
		factoryMap = dbHelper.getMap(factory_sql);
		usern = CommonString.getFormatPara(factoryMap.get("usern"));
		factoryName = CommonString.getFormatPara(factoryMap.get("name"));
		factorypro_brand_title = CommonString.getFormatPara(factoryMap.get("pro_brand_title"));
		factorylogo = CommonString.getFormatPara(factoryMap.get("logo"));
		factoryurl = CommonString.getFormatPara(factoryMap.get("url")); 
		view_count = CommonString.getFormatPara(factoryMap.get("view_count")); 
		
	}
		
	
	String sql = "select top 4 pm.id,pm.score1,pm.score2,pm.score3,pm.score4,pm.content,pm.name contact_address,pm.product_id,pp.factoryid,pp.factoryname,pp.catalognum,pp.catalogname,pp.name product_name,pp.img2,pp.file_name,pm.add_date,pm.is_help,pm.username,pp.view_count,pp.catalognum from pro_comments pm left join pro_products pp on  pm.product_id=pp.id where pm.is_show=1 and  pp.factoryid="+factoryid;
	//口碑数量
	String countSql = "select count(pm.id) as count from pro_comments pm left join pro_products pp on  pm.product_id=pp.id where pm.is_show=1 and  pp.factoryid="+factoryid;
	Map countMap = dbHelper.getMap(countSql);
	
	//排名
	String topCount = "";
	if(!view_count.equals("")){
		String topSql = "select count(id)+1 as topCount from pro_agent_factory where is_show=1 and flag=1 and  view_count>"+view_count;
		Map topMap = dbHelper.getMap(topSql);
		if(topMap!=null && topMap.size()>0){
			topCount = CommonString.getFormatPara(topMap.get("topCount"));
		}
		
	}
	//所有分类
	String allCatalogSql = "select name,num from pro_catalog where len(num) = 6";
	List<Map> catalogList = dbHelper.getMapList(allCatalogSql);
%>
<div class="comBox mb10">
        <div class="hd fix">
          <h3><%=factoryName %>口碑</h3>
          <span class="more"><a href="/comment_list.htm">更多<%=factoryName %>口碑 &gt;&gt;</a></span>
        </div>
        <div class="bd fix">
          <div class="s_kb_total fix">
            <span class="s_total">共有<b><%=countMap.get("count") %></b>条<%=factoryName %>口碑</span>
            <span class="s_rank">品牌关注度排行榜<strong>TOP<%=topCount %></strong></span>
            <span class="s_point">品牌关注指数：<%=view_count %></span>
          </div>
          
          <div class="s_kb">
            <div class="s_hd fix">
              <h3>网友口碑</h3>
              <ul class="s_cate">
                <li><a href="/brandshow/comment_list.htm" class="selected" target="_blank">全部</a></li>
                <%
                int i=1;
                for(Map m:catalogList){
                	String catalogNum = CommonString.getFormatPara(m.get("num"));
                	String catalogName = CommonString.getFormatPara(m.get("name"));
                	if(catalogNum.length()==6){
                		String catalogSql = " select top 1 c.id from pro_comments as c left join  pro_products as p on c.product_id=p.id where c.is_show=1 and p.factoryid = '"+factoryid+"' and p.catalognum like '"+catalogNum+"%'";
	                	Map cMap = dbHelper.getMap(catalogSql);
	                	if(cMap!=null &&cMap.size()>0){
	                %>
	                	<li><a href="/comment_list_<%=catalogNum %>.htm" target="_blank"><%=catalogName %></a></li>
	                <%i++;
	                	if(i==5){break;}
                	}}} %>
              </ul>
              <span class="more"><a href="http://koubei.21-sun.com/" target="_blank" title="发布口碑">发布口碑 &gt;&gt;</a></span>
            </div>
            <div class="s_bd fix">
              <div class="s_kb_list">
                <ul class="fix">
                <%
					List<Map> L = dbHelper.getMapList(sql);
					if(L!=null && L.size()>0){
						for(Map oneMap:L){
							String pId = CommonString.getFormatPara(oneMap.get("id"));
							   String pContact_address = CommonString.getFormatPara(oneMap.get("contact_address"));
							   String pFactoryname = CommonString.getFormatPara(oneMap.get("factoryname"));
							   String pProduct_name = CommonString.getFormatPara(oneMap.get("product_name"));
							   String pCatalogname = CommonString.getFormatPara(oneMap.get("catalogname"));
							   String pCatalognum = CommonString.getFormatPara(oneMap.get("catalognum"));
							   String pFile_name = CommonString.getFormatPara(oneMap.get("file_name"));
							   String pImg2 = CommonString.getFormatPara(oneMap.get("img2"));
							   String pCactoryid = CommonString.getFormatPara(oneMap.get("factoryid"));
							   String pAdd_date = CommonDate.getFormatDate("yyyy-MM-dd HH:mm", CommonString.getFormatPara(oneMap.get("add_date")));
							   String pName = CommonString.getFormatPara(oneMap.get("name"));
							   String pContent = CommonString.getFormatPara(oneMap.get("content"));
							   String pUsername = CommonString.getFormatPara(oneMap.get("username"));
				%>
                  <li>
                    <div class="user"><img src="/brandshow/images/s_face.png" /><%=pUsername.equals("")?pContact_address:pUsername %></div>
                    <div class="intro">
                      <a href="http://koubei.21-sun.com/detail/<%=pId %>.htm" title="<%=pFactoryname+pProduct_name+pCatalogname %>使用感受" target="_blank">
                      <strong class="n">真实口碑 <%=pFactoryname+pProduct_name+pCatalogname %>使用感受</h3></strong>
                      <span class="time"><%=pAdd_date %></span>
                      <div class="text"><%=pContent.length()>100?pContent.substring(0,99)+"...":pContent %></div>
                      <span class="more">查看完整口碑 &gt;&gt;</span>
                      </a>
                    </div>
                  </li>
                  <%}} %>
                </ul>
                <div class="s_more"><a href="/comment_list.htm" title="查看更多<%=factoryName %>口碑" target="_blank">查看更多<%=factoryName %>口碑</a></div>
              </div>
            </div>
          </div>
          
        </div>
      </div>
</cache:cache>