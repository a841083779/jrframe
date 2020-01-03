﻿<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
    	DBHelper dbHelper = DBHelper.getInstance();
	String id = CommonString.getFormatPara(request.getParameter("id"));
	Map commentMap = dbHelper.getMap("select factoryname,catalogname,factoryid,catalognum,name,img2,id from pro_products where  id='"+id+"' ");
	String parent_factoryname="";String parent_catalogname="";String parent_name="";String img="";int score1=0;int score2=0;int score3=0;int score4=0;int score =0;
	String factory =""; String catalog = ""; String ided="";
	if(commentMap!=null){
		parent_factoryname = CommonString.getFormatPara(commentMap.get("factoryname"));
		parent_catalogname = CommonString.getFormatPara(commentMap.get("catalogname"));
		factory=CommonString.getFormatPara(commentMap.get("factoryid"));
		catalog=CommonString.getFormatPara(commentMap.get("catalognum"));
		parent_name = CommonString.getFormatPara(commentMap.get("name"));
		img = CommonString.getFormatPara(commentMap.get("img2"));
		ided = CommonString.getFormatPara(commentMap.get("id"));
	}
	
	
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	 Map	userInfos = (Map) session.getAttribute("memberInfo");
	 String user_no="";
	 if(userInfos!=null){
	  user_no=CommonString.getFormatPara(userInfos.get("username"));
	 }
	
	Map model = new HashMap();
    StringBuffer whereStr = new StringBuffer(" and product_id!='' ");
	if (!"".equals(id)) {
			whereStr.append(" and product_id='"+id+"' ");
	}
	Connection connection = null;
	try{
	   connection = dbHelper.getConnection();
	    Map one = null ;
		PageBean pageBean = new PageBean(); // 分页程序
		pageBean.setPageSize(6); // 每页显示条数
		pageBean.setCondition(whereStr.toString());
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
		pageBean.setNowPage(nowPage);
		String url = CommonString.getFormatPara(request.getQueryString());
		if (!"".equals(url)) {
			if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
				url = "";
			} else if (url.indexOf("offset") != -1) {
				url = "&" + url.substring(url.indexOf("&") + 1);
			} else {
				url = "&" + url;
			}
		}
		pageBean.setOrderBy(" add_date desc"); // 点击量排序
		pageBean.setParams(url);
		pageBean.setIsShowSql(false);
		pageBean.setFields(" *");
		pageBean.setTableName("pro_mobile_koubei_list");
		List<Map> koubeiProducts = pageBean.getDatas(connection); // 根据条件查出的产品
	
	
	 if(catalog.length()>6){
	 catalog=catalog.substring(0,6);
	 }
	
	
%><!DOCTYPE html>
<html>
<head>
<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<title>【点评】<%=parent_factoryname%><%=parent_name%><%=parent_catalogname%>怎么样_<%=parent_factoryname%><%=parent_name%><%=parent_catalogname%>真实口碑 - 铁臂口碑</title>
<meta name="keywords" content="<%=parent_factoryname%><%=parent_name%><%=parent_catalogname%>,<%=parent_factoryname%><%=parent_name%><%=parent_catalogname%>怎么样,<%=parent_factoryname%><%=parent_name%><%=parent_catalogname%>好不好,<%=parent_factoryname%><%=parent_name%><%=parent_catalogname%>真实口碑" />
<meta name="description" content="铁臂口碑包含大量<%=parent_factoryname%><%=parent_name%><%=parent_catalogname%>真实口碑、点评信息,让您清楚地了解<%=parent_factoryname%><%=parent_name%><%=parent_catalogname%>怎么样,有哪些优缺点,买<%=parent_factoryname%><%=parent_name%><%=parent_catalogname%>就上铁臂商城。" />

<link href="Static/css/style.css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
</head>
<body class="kbddetail_body">
<jsp:include page="top.jsp" flush="true"/>
<div style=" text-align: center;">
	<a href="http://m.koubei.21-sun.com/index_activity.jsp"><img src="http://product.21-sun.com/mobile/koubei/huodong/web/img/banner.jpg" alt="铁臂口碑"></a>
</div>
<div class="fix kbval_det">
	<div class="kbdet_name"><%=parent_factoryname%><%=parent_catalogname%><%=parent_name%></div>
    <div class="kbdet_img"><img src="/uploadfiles/<%=img%>" alt="<%=parent_catalogname%>"/></div>
	<ul class="fix kb_nrlist">
	 <%	 
        String orderCount="";
		if (koubeiProducts != null && koubeiProducts.size() > 0) {
			for (Map koubeiMap : koubeiProducts) {
			int vote_id=CommonString.getFormatInt(koubeiMap.get("id"));
			String product_id=CommonString.getFormatPara(koubeiMap.get("product_id"));
			String factoryname=CommonString.getFormatPara(koubeiMap.get("factoryname"));
			String factoryid=CommonString.getFormatPara(koubeiMap.get("factoryid"));
			String catalognum=CommonString.getFormatPara(koubeiMap.get("catalognum"));
			String catalogname=CommonString.getFormatPara(koubeiMap.get("catalogname"));
			String name=CommonString.getFormatPara(koubeiMap.get("name"));
			String username=CommonString.getFormatPara(koubeiMap.get("username"));//口碑name
			String pro_name=CommonString.getFormatPara(koubeiMap.get("pro_name"));
			String content=CommonString.getFormatPara(koubeiMap.get("content"));
			int is_help=CommonString.getFormatInt(koubeiMap.get("is_help"));
			if(content.length()>50){
			content=content.substring(0,50);
			}
			if(username.equals("")){
			username=name;
			}
			 String add_date = CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(koubeiMap.get("add_date")));
     %>
    	<li>
            <div class="_canshu fix">
            	<p class="c_namedate"><span class="_t1"><%=username%></span><span class="_t2"><%=add_date%></span></p>
				<%
					model = dbHelper.getMap(" select count(*) as counts from pro_mobile_koubei_list where id = ? ",new Object [] {product_id} , connection);
				%>
                <p class="p_num"><a href="javascript:void(0)" onclick="vote('<%=vote_id %>')">(<span id="vote_<%=vote_id %>"><%=is_help %></span>)</a></p>
            </div>
            <div class="_sum">
            <%=content%>
            </div>
            <%
              	String imgSql = "select top 10 * from pro_comments_image where comment_id='"+vote_id+"' and is_show=1";
              	List<Map> imgsList = dbHelper.getMapList(imgSql);
              	if(imgsList!=null && imgsList.size()>0){
              %>
              <div class="_imgl fix">
             
              <% 
              	for(Map m:imgsList){
              		String image = CommonString.getFormatPara(m.get("image"));
              %>
            <p><img src="<%=image%>" alt="<%=name%>"/></p>
              <%} %>
              </div>
              <%} %>
        </li>
    <%}}%>
        
    </ul>
	<div>
   <!--  <div class="kb_more"><a href="/mobile/web_kb_list.jsp">查看更多口碑</a></div>-->
	 	<div class="paging">
       <tags:page_mobile pageBean="<%=pageBean%>" />
       </div>
    <div class="kb_xxval">
    	<ul class="fix kb_xxlist">
        	<li>
            	<span class="kb_xxwz" >价格：</span>
                <div class="kb_xx" id="price_1" name="price_1"></div></li>
            <li>
            	<span class="kb_xxwz" >质量：</span>
                <div class="kb_xx" id="xingneng_1" name="xingneng_1"></div></li>
            <li>
            	<span class="kb_xxwz" >性能：</span>
                <div class="kb_xx" id="zhiliang_1" name="zhiliang_1"></div></li>
            <li>
            	<span class="kb_xxwz" >售后：</span>
                <div class="kb_xx" id="shouhou_1" name="shouhou_1"></div></li>
        </ul>
		
		
    </div>
    <div class="kb_subpl">
	<form action="/action/ajax.jsp" method="post" name="theform" id="theform"> 
    	<div class="kb_pl_text"><textarea placeholder="写点评价吧，可以帮助更多人选机" id="content" name="content" dataType="Require" msg="请输入评价！" ></textarea></div>
         <div class="kb_upimg" >
		
		    <a href="javascript:void(0);"   id="upload" >
			    <input type="file" multiple  name="equi_img" id="equi_img">
			</a>
			 
            
            <div><a href="javascript:;"  ><img src="Static/img/upimg.gif" id="mig_show"/></a></div>
        </div>
	<div class="kb_subbtn"><a href="javascript:;" onclick="doComments();"  >发表口碑</a></div>
	<input type="hidden" name="tableName" id="tableName" value="pro_comments"/>
	<input type="hidden" name="name" id="name" value="<%  if(userInfos!=null){CommonString.getFormatPara(userInfos.get("username")); }%>"/>
    <input type="hidden" name="zd_userid" id="zd_userid" value="1"/>
    <input type="hidden" name="eventAfter" value="insertImages"/>
	<input type="hidden" name="comment_id" id="comment_id"  value="<%=id%>"/>
    <input type="hidden" name="score1" id="score1" />
    <input type="hidden" name="score2" id="score2" />
    <input type="hidden" name="score3" id="score3" />
    <input type="hidden" name="score4" id="score4" />
	<input type="hidden" name="product_id" value="<%=id%>" />
	<input type="hidden" name="zd_image" id="zd_image" />
	<input type="hidden" name="flag" value="new_save_comment_shouji" />
    </form>
    </div>
</div>
<div class="bottomBar">
  <div class="share bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more">分享</a></div>
  <div class="tel"><a href="tel:4006-521-526"><img src="Static/img/tel_ico.png"><span>4006-521-526</span></a></div>
  <div class="comment"><a href="brands_list_news.jsp?catalog=<%=catalog%>"><img src="Static/img/fdj_03.png" class="io">品牌</a></div>
</div>
</body>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script type="text/javascript" src="Static/js/modules/jquery.min.js"></script>
<script>

function loginOut(){
	$.post("/action/ajax_mobile.jsp",{message:"exit"},function(data){
		if($.trim(data)=="loginOut"){
			 location.reload();
		}
	});
}
	var jrChannel='0#0';
	seajs.use('app/index.js');
</script>
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/validator.alert.js"></script>
<script type="text/javascript" src="/plugin/validator/rjboy/Validform_v5.3.1.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script>
         //星星
        $("#price_1,#xingneng_1,#zhiliang_1,#shouhou_1").raty({
	    path: "/mobile/img",
	    half : true ,
	    score : 0
        });

		/* var s1 = (parseInt(parseFloat($("#price_1").raty("score"),10)/20));
		 var s2 = (parseInt(parseFloat($("#xingneng_1").raty("score"),10)/20));
		 var s3 = (parseInt(parseFloat($("#zhiliang_1").raty("score"),10)/20));
		 var s4 = (parseInt(parseFloat($("#shouhou_1").raty("score"),10)/20));

		 jQuery("#price_1").raty({
				path: "/mobile/img", //图片路径  
				half : true ,
			    readOnly : true,
				score : s1
			});
			jQuery("#xingneng_1").raty({
				path: "/mobile/img", //图片路径  
				half : true ,
				readOnly : true,
				score : s2
			});
			jQuery("#zhiliang_1").raty({
				path: "/mobile/img", //图片路径  
				half : true ,
				readOnly : true,
				score : s3
			});
			jQuery("#shouhou_1").raty({
				path: "/mobile/img", //图片路径  
				half : true ,
				readOnly : true,
				score : s4
			});*/
        function doComments(){
		var de='<%=user_no%>';
		if(de!=''){
		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
		 jQuery("#score1").val(parseFloat($("#price_1").raty("score"),10)*20);
	     jQuery("#score2").val(parseFloat($("#xingneng_1").raty("score"),10)*20);
		 jQuery("#score3").val(parseFloat($("#zhiliang_1").raty("score"),10)*20);
		 jQuery("#score4").val(parseFloat($("#shouhou_1").raty("score"),10)*20);
		  $("#theform").ajaxSubmit(function (data) {
 			if((data)=="ok"){
				alert("评论提交成功！");
				window.location.reload();
			}else{
				alert("评论提交失败！");
			}
          });
		}
		}else{
		alert('请登录后再发表评论，谢谢！');
		window.location.href="web_login.jsp";
		}
		}
</script>
<script>

function vote(id){
		var help = parseInt($("#vote_"+id).html());
		if(setlooked(id)==1){
			$.ajax({
			  url: "/action/ajax.jsp?flag=koubeiHelp&id="+id,
			  cache: false,
			  async: true,
			  success: function(html){
			  }
			});
			$("#vote_"+id).html(help+1);
			alert('感谢您的支持！');
		}else{
			alert('您已经投过票了哟！');
		}
	}
	function setlooked(id){
		var x = 0;
		var imgs = $.cookies.get("help_imgs");
		if(imgs==null || imgs == "" || imgs.indexOf("help"+id) < 0){
			var newImgs = imgs+",help"+id;
			$.cookies.set("help_imgs",newImgs,{hoursToLive : 10});
			x = 1;
		}
		return x;
	}
</script>
<script>
/*//获得评论分数
	$("#pricescore").raty({
		path: "/mobile/img", //图片路径  
		half : true ,
		readOnly : true,
		score : 0
	});
	$("#abilityscore").raty({
		path: "/mobile/img", //图片路径  
		half : true ,
		readOnly : true,
		score : 0
	});
	$("#qualityscore").raty({
		path: "/mobile/img", //图片路径  
		half : true ,
		readOnly : true,
		score : 0
	});
	$("#servicescore").raty({
		path: "/mobile/img", //图片路径  
		half : true ,
		readOnly : true,
		score : 0
	});


*/

</script>

</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>