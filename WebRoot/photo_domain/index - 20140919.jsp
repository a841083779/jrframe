<%@ page language="java" import="java.util.*,com.jerehnet.util.common.CommonString,java.sql.Connection,com.jerehnet.util.dbutil.*,com.jerehnet.util.dbutil.*" pageEncoding="utf-8"%><%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection conn = null;
	try{
		conn = dbHelper.getConnection();
		String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
		if(catalog.equals("")){
		catalog="100101";
		}
		System.out.println(catalog);   
		//行业图片
		String hySql = "select top 4 id,image,title from pro_photo_group where is_show=1  and sort_num like '%107001%' order by pub_date desc,id desc";
		List<Map> hyList = dbHelper.getMapList(hySql,conn);
		
		//施工图片
		String sgSql = "select top 4 id,image,title from pro_photo_group where is_show=1  and sort_num like '%107003%' order by pub_date desc,id desc";
		List<Map> sgList = dbHelper.getMapList(sgSql,conn);
		//维修图片
		String wxSql = "select top 4 id,image,title from pro_photo_group where is_show=1  and sort_num like '%107004%' order by pub_date desc,id desc";
		List<Map> wxList = dbHelper.getMapList(wxSql,conn);
		//展会图片
		String zhSql = "select top 4 id,image,title from pro_photo_group where is_show=1  and sort_num like '%107005%' order by pub_date desc,id desc";
		List<Map> zhList = dbHelper.getMapList(zhSql,conn);
		//趣味图片
		String qwSql = "select top 4 id,image,title from pro_photo_group where is_show=1  and sort_num like '%107006%' order by pub_date desc,id desc";
		List<Map> qwList = dbHelper.getMapList(qwSql,conn);
		
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>工程机械图片大全_工程机械图片库 - 铁臂图库</title>
<meta name="renderer" content="webkit">
<meta name="keywords" content="工程机械图片,工程机械图片大全,工程机械,铁臂图库" />
<meta name="description" content="铁臂图库为您提供各种品牌工程机械高清图片，包括产品图片,施工图片,维修图片,展会图片,行业图片,趣味图片。买工程机械就上铁臂商城。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<link href="../style/new_style.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
</head>
<body class="photobg">
<!--top--> 
<a class="shop_topbg"></a>
<jsp:include page="/include/top_photo_news.jsp" flush="true"/>
<div class="contain980 mb10">
  
</div>
<!--main-->
<div class="contain980">
    <div class="pho_pic_val j_tab" id="pic2">
    	<div class="phopic_t fix">
        	<h2><div class="l phott1" >产品图片</div></h2>
            <ul class="cates_tab">
              <li class="j_tab_key"><a href="/list.jsp?catalog=101001">挖掘机</a></li>
              <li class="j_tab_key"><a href="/list.jsp?catalog=101002">装载机</a></li>
              <li class="j_tab_key"><a href="/list.jsp?catalog=101003">推土机</a></li>
              <li class="j_tab_key"><a href="/list.jsp?catalog=102">起重机</a></li>
              <li class="j_tab_key"><a href="/list.jsp?catalog=106001">压路机</a></li>
              <li class="j_tab_key"><a href="/list.jsp?catalog=101005">平地机</a></li>
              <li class="j_tab_key"><a href="/list.jsp?catalog=104001">摊铺机</a></li>
              <li class="j_tab_key"><a href="/list.jsp?catalog=103">混凝土</a></li>
            </ul>
            <!--<div class="r phott2"><a href="/pro_index.jsp">更多&gt;&gt;</a></div>-->
        </div>
        <div class="phopic_list">
        	<ul class="fix j_tab_val">
            	<%
				//产品图片
		String cpSql = "select top 4 id,img2,name,catalogname,factoryname from pro_products where is_show=1 and catalognum like '101001%' and img2!='' order by view_count desc,id desc";
		List<Map> cpList = dbHelper.getMapList(cpSql,conn);
        		for(Map m:cpList){
        			String id = CommonString.getFormatPara(m.get("id"));
        			String image = CommonString.getFormatPara(m.get("img2"));
        			if(image.indexOf("UserFiles")<0){
        				image = "http://product.21-sun.com/uploadfiles/"+image;
        			}
        			String title= "";
        			String name = CommonString.getFormatPara(m.get("name"));
        			String catalogname = CommonString.getFormatPara(m.get("catalogname"));
        			String factoryname = CommonString.getFormatPara(m.get("factoryname"));
        			title = factoryname+name+catalogname;
					
					 Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where product_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"))+1;
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
			<ul class="fix j_tab_val">
            	<%
				//产品图片
				//去除一个柳工的，写死一个默认山工的
		String cpSql1 = "select top 4 id,img2,name,catalogname,factoryname from pro_products where is_show=1 and id!=817 and catalognum like '101002%' and img2!='' order by view_count desc,id desc";
		List<Map> zzjList = dbHelper.getMapList(cpSql1,conn);
        		for(Map zzj:zzjList){
        			String id = CommonString.getFormatPara(zzj.get("id"));
        			String image = CommonString.getFormatPara(zzj.get("img2"));
        			if(image.indexOf("UserFiles")<0){
        				image = "http://product.21-sun.com/uploadfiles/"+image;
        			}
        			String title= "";
        			String name = CommonString.getFormatPara(zzj.get("name"));
        			String catalogname = CommonString.getFormatPara(zzj.get("catalogname"));
        			String factoryname = CommonString.getFormatPara(zzj.get("factoryname"));
        			title = factoryname+name+catalogname;
					
					 Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where product_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"))+1;
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
			<ul class="fix j_tab_val">
            	<%
				//产品图片
		String cpSql2 = "select top 4 id,img2,name,catalogname,factoryname from pro_products where is_show=1 and catalognum like '101003%' and img2!='' order by view_count desc,id desc";
		List<Map> ttjList = dbHelper.getMapList(cpSql2,conn);
        		for(Map ttj:ttjList){
        			String id = CommonString.getFormatPara(ttj.get("id"));
        			String image = CommonString.getFormatPara(ttj.get("img2"));
        			if(image.indexOf("UserFiles")<0){
        				image = "http://product.21-sun.com/uploadfiles/"+image;
        			}
        			String title= "";
        			String name = CommonString.getFormatPara(ttj.get("name"));
        			String catalogname = CommonString.getFormatPara(ttj.get("catalogname"));
        			String factoryname = CommonString.getFormatPara(ttj.get("factoryname"));
        			title = factoryname+name+catalogname;
					
					 Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where product_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"))+1;
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
			<ul class="fix j_tab_val">
            	<%
				String cpSql3 = "select top 4 id,img2,name,catalogname,factoryname from pro_products where is_show=1 and catalognum like '102%' and img2!='' order by view_count desc,id desc";
		        List<Map> qzjList = dbHelper.getMapList(cpSql3,conn);
        		for(Map qzj:qzjList){
        			String id = CommonString.getFormatPara(qzj.get("id"));
        			String image = CommonString.getFormatPara(qzj.get("img2"));
        			if(image.indexOf("UserFiles")<0){
        				image = "http://product.21-sun.com/uploadfiles/"+image;
        			}
        			String title= "";
        			String name = CommonString.getFormatPara(qzj.get("name"));
        			String catalogname = CommonString.getFormatPara(qzj.get("catalogname"));
        			String factoryname = CommonString.getFormatPara(qzj.get("factoryname"));
        			title = factoryname+name+catalogname;
					
					Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where product_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"))+1;
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
			<ul class="fix j_tab_val">
            	<%
				String cpSql4 = "select top 4 id,img2,name,catalogname,factoryname from pro_products where is_show=1 and catalognum like '106001%' and img2!='' order by view_count desc,id desc";
	        	List<Map> yljList = dbHelper.getMapList(cpSql4,conn);
        		for(Map ylj:yljList){
        			String id = CommonString.getFormatPara(ylj.get("id"));
        			String image = CommonString.getFormatPara(ylj.get("img2"));
        			if(image.indexOf("UserFiles")<0){
        				image = "http://product.21-sun.com/uploadfiles/"+image;
        			}
        			String title= "";
        			String name = CommonString.getFormatPara(ylj.get("name"));
        			String catalogname = CommonString.getFormatPara(ylj.get("catalogname"));
        			String factoryname = CommonString.getFormatPara(ylj.get("factoryname"));
        			title = factoryname+name+catalogname;
					
					Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where product_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"))+1;
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
			<ul class="fix j_tab_val">
            	<%
				String cpSql5 = "select top 4 id,img2,name,catalogname,factoryname from pro_products where is_show=1 and catalognum like '101005%' and img2!='' order by view_count desc,id desc";
	        	List<Map> pdjList = dbHelper.getMapList(cpSql5,conn);
        		for(Map pdj:pdjList){
        			String id = CommonString.getFormatPara(pdj.get("id"));
        			String image = CommonString.getFormatPara(pdj.get("img2"));
        			if(image.indexOf("UserFiles")<0){
        				image = "http://product.21-sun.com/uploadfiles/"+image;
        			}
        			String title= "";
        			String name = CommonString.getFormatPara(pdj.get("name"));
        			String catalogname = CommonString.getFormatPara(pdj.get("catalogname"));
        			String factoryname = CommonString.getFormatPara(pdj.get("factoryname"));
        			title = factoryname+name+catalogname;
					
					Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where product_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"))+1;
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
			<ul class="fix j_tab_val">
            	<%
				String cpSql6 = "select top 4 id,img2,name,catalogname,factoryname from pro_products where is_show=1 and catalognum like '104001%' and id!=12542 and img2!='' order by view_count desc,id desc";
	        	List<Map> tpjList = dbHelper.getMapList(cpSql6,conn);
        		for(Map tpj:tpjList){
        			String id = CommonString.getFormatPara(tpj.get("id"));
        			String image = CommonString.getFormatPara(tpj.get("img2"));
        			if(image.indexOf("UserFiles")<0){
        				image = "http://product.21-sun.com/uploadfiles/"+image;
        			}
				
        			String title= "";
        			String name = CommonString.getFormatPara(tpj.get("name"));
        			String catalogname = CommonString.getFormatPara(tpj.get("catalogname"));
        			String factoryname = CommonString.getFormatPara(tpj.get("factoryname"));
        			title = factoryname+name+catalogname;
					
					Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where product_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"))+1;
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
			<ul class="fix j_tab_val">
            	<%
				String cpSql7 = "select top 4 id,img2,name,catalogname,factoryname from pro_products where is_show=1 and catalognum like '103%' and img2!='' order by view_count desc,id desc";
	        	List<Map> hntList = dbHelper.getMapList(cpSql7,conn);
        		for(Map hnt:hntList){
        			String id = CommonString.getFormatPara(hnt.get("id"));
        			String image = CommonString.getFormatPara(hnt.get("img2"));
        			if(image.indexOf("UserFiles")<0){
        				image = "http://product.21-sun.com/uploadfiles/"+image;
        			}
        			String title= "";
        			String name = CommonString.getFormatPara(hnt.get("name"));
        			String catalogname = CommonString.getFormatPara(hnt.get("catalogname"));
        			String factoryname = CommonString.getFormatPara(hnt.get("factoryname"));
        			title = factoryname+name+catalogname;
					
					Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_product_pic where product_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"))+1;
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="detail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
        </div>
    </div>
    <div class="pho_pic_val" id="pic1">
    	<div class="phopic_t fix">
        	<h2><div class="l phott1">行业图片</div></h2>
            <div class="r phott2"><a href="/nlist_0_0_107001_0.htm" title="更多行业图片">更多&gt;&gt;</a></div>
        </div>
        <div class="phopic_list">
        	<ul class="fix">
        	<%
        		for(Map m:hyList){
        			String id = CommonString.getFormatPara(m.get("id"));
        			String image = CommonString.getFormatPara(m.get("image"));
        			String title = CommonString.getFormatPara(m.get("title"));
					if(image.indexOf("resource")<0){
						   if(image.indexOf("uploadfiles")<0){
        			     	image = "http://product.21-sun.com/uploadfiles/"+image;
        			        }
						  }
				 Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_photo where group_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"));
				  if(x==0){
				  x=1;
				  }
        	%>
            	<li>
                	<div class="pholist_img"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
                    <div class="pholist_name"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                    <div class="num">共<%=x%>张图片</div>
                </li>
            <%} %>
            </ul>
        </div>
    </div>
    
    <div class="pho_pic_val" id="pic3">
    	<div class="phopic_t fix">
        	<h2><div class="l phott1">施工图片</div></h2>
            <div class="r phott2"><a href="/other_0_0_107003_0.htm"  title="更多施工图片">更多&gt;&gt;</a></div>
        </div>
        <div class="phopic_list">
        	<ul class="fix">
            	<%
        		for(Map m:sgList){
        			String id = CommonString.getFormatPara(m.get("id"));
        			String image = CommonString.getFormatPara(m.get("image"));
        			String title = CommonString.getFormatPara(m.get("title"));
					if(image.indexOf("resource")<0){
						   if(image.indexOf("uploadfiles")<0){
        			     	image = "http://product.21-sun.com/uploadfiles/"+image;
        			        }
						  }
					 Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_photo where group_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"));
				  if(x==0){
				  x=1;
				  }
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
        </div>
    </div>
    <div class="pho_pic_val" id="pic4">
    	<div class="phopic_t fix">
        	<h2><div class="l phott1">维修图片</div></h2>
            <div class="r phott2"><a href="/other_0_0_107004_0.htm"  title="更多维修图片">更多&gt;&gt;</a></div>
        </div>
        <div class="phopic_list">
        	<ul class="fix">
            	<%
	        		for(Map m:wxList){
	        			String id = CommonString.getFormatPara(m.get("id"));
	        			String image = CommonString.getFormatPara(m.get("image"));
	        			String title = CommonString.getFormatPara(m.get("title"));
						if(image.indexOf("resource")<0){
						   if(image.indexOf("uploadfiles")<0){
        			     	image = "http://product.21-sun.com/uploadfiles/"+image;
        			        }
						  }
					 Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_photo where group_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"));
				  if(x==0){
				  x=1;
				  }
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
        </div>
    </div>
    <div class="pho_pic_val" id="pic5">
    	<div class="phopic_t fix">
        	<h2><div class="l phott1">展会图片</div></h2>
            <div class="r phott2"><a href="/zhanhui_0_0_0_107005_0.htm"  title="更多展会图片">更多&gt;&gt;</a></div>
        </div>
        <div class="phopic_list">
        	<ul class="fix">
            	<%
        		for(Map m:zhList){
        			String id = CommonString.getFormatPara(m.get("id"));
        			String image = CommonString.getFormatPara(m.get("image"));
        			String title = CommonString.getFormatPara(m.get("title"));
					if(image.indexOf("resource")<0){
						   if(image.indexOf("uploadfiles")<0){
        			     	image = "http://product.21-sun.com/uploadfiles/"+image;
        			        }
						  }
					 Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_photo where group_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"));
				  if(x==0){
				  x=1;
				  }
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
        </div>
    </div>
    <div class="pho_pic_val" id="pic6">
    	<div class="phopic_t fix">
        	<h2><div class="l phott1">趣味图片</div></h2>
            <div class="r phott2"><a href="/other_0_0_107006_0.htm"   title="更多趣味图片">更多&gt;&gt;</a></div>
        </div>
        <div class="phopic_list">
        	<ul class="fix">
            	<%
        		for(Map m:qwList){
        			String id = CommonString.getFormatPara(m.get("id"));
        			String image = CommonString.getFormatPara(m.get("image"));
        			String title = CommonString.getFormatPara(m.get("title"));
					if(image.indexOf("resource")<0){
						   if(image.indexOf("uploadfiles")<0){
        			     	image = "http://product.21-sun.com/uploadfiles/"+image;
        			        }
						  }
					 Map sub_photoCount5 = dbHelper.getMap(" select count(id) as count  from pro_photo where group_id= '"+id+"'") ;
			      int x=CommonString.getFormatInt(sub_photoCount5.get("count"));
				  if(x==0){
				  x=1;
				  }
	        	%>
	            	<li>
	                	<div class="pholist_img"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><img onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" 
 src="<%=image %>" style="width:225px;height:170px;" alt="<%=title %>"/></a></div>
	                    <div class="pholist_name"><a href="ndetail_for_<%=id %>.htm" target="_blank" title="<%=title %>"><%=title %></a></div>
                        <div class="num">共<%=x%>张图片</div>
	                </li>
	            <%} %>
            </ul>
        </div>
    </div>
</div>
<jsp:include page="/include/index/friendlink_photo.htm" flush="true"/>
<jsp:include page="/include/koubei_ad.jsp" flush="false"/>

<!--main end-->
<!--foot-->
<jsp:include page="../include/foot_photo.jsp"/>
<!--foot end-->
<!--图库漂浮-->
<div class="sideLayer">
  <ul>
    <li class="si si01"><a href="#pic2" title="产品图片"></a></li>
    <li class="si si02"><a href="#pic1" title="行业图片"></a></li>
    <li class="si si03"><a href="#pic5" title="展会图片"></a></li>
    <li class="si si04"><a href="#pic6" title="活动图片"></a></li>
    <li class="si si05"><a href="#pic4" title="维修图片"></a></li>
    <li class="si si06"><a href="#pic3" title="施工图片"></a></li>
  </ul>
</div>
<!--图库漂浮结束-->



</body>
<script>
$.fn.tab=function(){
	var $key=$(this).find('.j_tab_key'),
		 $val=$(this).find('.j_tab_val');
	$key.first().addClass('cur');
	$val.first().show();
	$key.each(function(index){
		$(this).hover(function(event){
			event.preventDefault();
			$(this).addClass('cur').siblings().removeClass('cur');
			$val.hide().eq(index).show();
			})
		})
	};
$('.j_tab').each(function() { $(this).tab()});

</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(conn);
	}
%>