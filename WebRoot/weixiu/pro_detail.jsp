<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%  
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
	}
    DBHelper dbHelper = DBHelper.getInstance();
	Map brandMap = (Map) application.getAttribute("brandMap");
    Map catalogMap = (Map) application.getAttribute("catalogMap");
	String pro_id = CommonString.getFormatPara(request.getParameter("id"));
	Map productMap = dbHelper.getMap("select catalognum,factoryname,name,factoryid,catalognum,img2,catalogname from pro_products where id=" + pro_id + " order by id desc");	
	String id = ""; String catalog = ""; String factory = ""; String factoryname = ""; String name = ""; String catalognum = "";  String catalogname = ""; String img2="";
	String topNum=""; String topName="";
	if(productMap!=null){
		catalog = CommonString.getFormatPara(productMap.get("catalognum"));
		factoryname = CommonString.getFormatPara(productMap.get("factoryname"));
		name = CommonString.getFormatPara(productMap.get("name"));
		factory = CommonString.getFormatPara(productMap.get("factoryid"));
		catalognum = CommonString.getFormatPara(productMap.get("catalognum"));
		if(catalognum.length()>6){topNum=catalognum.substring(0,6);}else{topNum=catalognum;}
		topName=CommonString.getFormatPara(catalogMap.get(topNum));
		img2 = CommonString.getFormatPara(productMap.get("img2"));
		catalogname = CommonString.getFormatPara(productMap.get("catalogname"));
	}else if(productMap==null){
	        //Common.do302(response,"http://weixiu.21-sun.com/");
			//return;
	}
	//查询维修心得
	//String sql="select top 10 username,add_date,reply_id,content,id from pro_weixiu_comment where reply_id=0 and  pro_id="+pro_id+" order by add_date desc";
	String sql="SELECT  a.username,a.add_date,a.reply_id,a.content,a.id,b.image FROM(select top 10 username,add_date,reply_id,content,id from pro_weixiu_comment where reply_id=0 and  pro_id="+pro_id+" order by add_date desc  ) as a LEFT JOIN (SELECT image,username from  pro_member )  as b ON a.username=b.username";
	List<Map> weixiuList = dbHelper.getMapList(sql);
	//查询该产品评分
	int waiguandafang=0; int caozuoshushi=0; int youhaodi=0; int dongliqiangjin=0; int caozuojianbian=0;
	int xingnengzhuoyue=0; int jienenghuanbao=0; int guzhangludi=0; int shouhoufuwu=0; int jishouzuiai=0;
	int baoyangbianjie=0; int kuanchangshushi=0; int zaoyindi=0;
    Map proScoreMap = dbHelper.getMap("select waiguandafang,caozuoshushi,youhaodi,dongliqiangjin,caozuojianbian,xingnengzhuoyue,jienenghuanbao,guzhangludi,shouhoufuwu,jishouzuiai,baoyangbianjie,kuanchangshushi,zaoyindi from pro_weixiu_advantage where pro_id=" + pro_id );	
    if(proScoreMap!=null){  
	waiguandafang=CommonString.getFormatInt(proScoreMap.get("waiguandafang")); 
	caozuoshushi=CommonString.getFormatInt(proScoreMap.get("caozuoshushi")); 
	youhaodi=CommonString.getFormatInt(proScoreMap.get("youhaodi"));
	dongliqiangjin=CommonString.getFormatInt(proScoreMap.get("dongliqiangjin")); 
	caozuojianbian=CommonString.getFormatInt(proScoreMap.get("caozuojianbian"));
	xingnengzhuoyue=CommonString.getFormatInt(proScoreMap.get("xingnengzhuoyue"));
	jienenghuanbao=CommonString.getFormatInt(proScoreMap.get("jienenghuanbao"));
	guzhangludi=CommonString.getFormatInt(proScoreMap.get("guzhangludi")); 
	shouhoufuwu=CommonString.getFormatInt(proScoreMap.get("shouhoufuwu"));
	jishouzuiai=CommonString.getFormatInt(proScoreMap.get("jishouzuiai"));
	baoyangbianjie=CommonString.getFormatInt(proScoreMap.get("baoyangbianjie")); 
	kuanchangshushi=CommonString.getFormatInt(proScoreMap.get("kuanchangshushi")); 
	zaoyindi=CommonString.getFormatInt(proScoreMap.get("zaoyindi"));
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta name="renderer" content="webkit">
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/style/new_style.css" rel="stylesheet" type="text/css" />
<link href="/weixiu/style/style.css" rel="stylesheet" type="text/css" />
<link href="/weixiu/style/weixiu.css" rel="stylesheet" type="text/css" />
<link href="/style/friendly_link.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/citys_weixiu.js"></script>
<script type="text/javascript" src="/scripts/login.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<title><%=factoryname+name+catalogname%>维修心得_<%=factoryname+catalogname%>维修 - 铁臂维修</title>
<meta name="keywords" content="<%=factoryname+name+catalogname%>,<%=factoryname+name+catalogname%>维修心得,<%=factoryname+name+catalogname%>维修知识" />
<meta name="description" content="铁臂维修为您提供<%=factoryname+name+catalogname%>维修心得,<%=factoryname+name+catalogname%>维修知识,买<%=factoryname+name+catalogname%>就上铁臂商城。" />
</head>
<body>
<jsp:include page="/weixiu/top.jsp" flush="true" />
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂维修</a>&nbsp;&gt;&gt;&nbsp;<a href="/prolist/">产品维修</a>&nbsp;&gt;&gt;&nbsp;<a href="/plist-<%=topNum%>-0-<%=factory%>.htm"><%=factoryname+catalogname%></a>&nbsp;&gt;&gt;&nbsp;<%=factoryname+name+catalogname%>维修</h3>
</div>
<div class="contain980 clearfix mb10">
<!-- left start-->
<div class="nre_left">
      
    <div class="rp clearfix mb10">
      <div class="title">
        <h3><%=factoryname%><%=topName%>维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
		<jsp:include page="/include/weixiu/detail_pro_list.jsp" flush="true">
         <jsp:param name="catalog" value="<%=catalognum%>"></jsp:param>
         <jsp:param name="factory" value="<%=factory%>"></jsp:param>
       </jsp:include>
        </ul>
      </div>
    </div>

    <div class="rp clearfix mb10 area">
      <div class="title">
        <h3><%=factoryname%>其他产品维修</h3>
      </div>
      <div class="content rList01">
        <ul class="list">
		<jsp:include page="/include/weixiu/detail_main_pro.jsp" flush="true">
         <jsp:param name="factoryname" value="<%=factoryname%>"></jsp:param>
         <jsp:param name="factory" value="<%=factory%>"></jsp:param>
       </jsp:include>
        </ul>
      </div>
    </div>

    <div class="rp clearfix mb10 area">
      <div class="title">
	      	<%if(catalognum.length() >= 6){%>
        	<h3><%=CommonString.getFormatPara(catalogMap.get(catalog.substring(0,3))) %>产品维修细分</h3>
        <%} %>
      </div>
      <div class="content rList01">
        <ul class="list">
		<jsp:include page="/include/weixiu/detail_catalog.jsp" flush="true">
         <jsp:param name="catalog" value="<%=catalognum%>"></jsp:param>
       </jsp:include>
	   </ul>
      </div>
    </div>

  </div>
<!-- left end-->
<!-- right start-->
  <style>
  .ConditionBottom li.cblist dd a{padding: 0px 6px;margin-right: 6px;}
  </style>
<div class="nre_right">
	<div class="pro_detail_head clearfix">
    	<h1 class="_title"><%=factoryname+name+catalogname%></h1>
        <div class="_img">
        	<img src="http://product.21-sun.com/uploadfiles/<%=img2%>" title="<%=factoryname+name+catalogname%>" alt="<%=factoryname+name+catalogname%>" />
        </div>
        <div class="_detail">
        	<table width="100%" border="0" cellpadding="0" cellspacing="0">
            	<tr>
                	<th style="text-align:left"><strong>配置：</strong></th>
                    <td>
                    	<a onclick="vote('waiguandafang');" style="cursor:pointer;"><span class="_cell" >外观大方(<span id="num_waiguandafang"><%=waiguandafang%></span>)</span></a>
                    	<a onclick="vote('caozuoshushi');" style="cursor:pointer;"><span class="_cell">操作舒适(<span id="num_caozuoshushi"><%=caozuoshushi%></span>)</span></a>
                    	<a onclick="vote('youhaodi');" style="cursor:pointer;"><span class="_cell">油耗低(<span id="num_youhaodi"><%=youhaodi%></span>)</span></a>
						<a onclick="vote('dongliqiangjin');" style="cursor:pointer;"><span class="_cell">动力强劲(<span id="num_dongliqiangjin"><%=dongliqiangjin%></span>)</span></a>
                    </td>
                </tr>
            	<tr>
                	<th style="text-align:left"><strong>优势：</strong></th>
                    <td>
                    	<a onclick="vote('caozuojianbian');" style="cursor:pointer;"><span class="_cell">操作简便(<span id="num_caozuojianbian"><%=caozuojianbian%></span>)</span></a>
                    	<a onclick="vote('xingnengzhuoyue');" style="cursor:pointer;"><span class="_cell">性能卓越(<span id="num_xingnengzhuoyue"><%=xingnengzhuoyue%></span>)</span></a>
                    	<a onclick="vote('jienenghuanbao');" style="cursor:pointer;"><span class="_cell">节能环保(<span id="num_jienenghuanbao"><%=jienenghuanbao%></span>)</span></a>
                    	<a onclick="vote('guzhangludi');" style="cursor:pointer;"><span class="_cell">故障率低(<span id="num_guzhangludi"><%=guzhangludi%></span>)</span></a>
						<a onclick="vote('shouhoufuwu');" style="cursor:pointer;"><span class="_cell">售后服务体系保障(<span id="num_shouhoufuwu"><%=shouhoufuwu%></span>)</span></a>
                    </td>
                </tr>
            	<tr>
                	<th style="text-align:left"><strong>其它：</strong></th>
                    <td>
                    	<a onclick="vote('jishouzuiai');" style="cursor:pointer;"><span class="_cell">机手最爱(<span id="num_jishouzuiai"><%=jishouzuiai%></span>)</span></a>
						<a onclick="vote('baoyangbianjie');" style="cursor:pointer;"><span class="_cell">保养便捷(<span id="num_baoyangbianjie"><%=baoyangbianjie%></span>)</span></a>
                    	<a onclick="vote('kuanchangshushi');" style="cursor:pointer;"><span class="_cell">宽敞舒适(<span id="num_kuanchangshushi"><%=kuanchangshushi%></span>)</span></a>
                    	<a onclick="vote('zaoyindi');" style="cursor:pointer;"><span class="_cell">噪音低(<span id="num_zaoyindi"><%=zaoyindi%></span>)</span></a>
                    </td>
                </tr>
            </table>
            <div class="_act">
            	<a href="#publish_reply" class="_btn">发布我的维修心得</a>
            </div>
        </div>
    </div>
    
    
    <div class="pro_detail_recom mb20">
    	<div class="_title_bar">
        	<a href="#" class="_item">维修心得</a>
        	<a style="display:none" href="#" class="_item">回复最多</a>
            <span class="_total" style="display:none">共有1545412条</span>
        </div>
    	<ul class="_list">
		<%
			if(weixiuList!=null && weixiuList.size()>0){
				   List<Map> secondList=null;
				   String secondSql="";
		           for(Map one:weixiuList){
		%>
        	<li>
            	<span class="_avat"><img src="<%=CommonString.getFormatPara(one.get("image"))%>"  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);" /></span>
                <div class="_info_bar">
                	<a href="javascript:void(0)" class="user"><b><%=CommonString.getFormatPara(one.get("username")).equals("front")?"铁臂商城用户":CommonString.getFormatPara(one.get("username"))%></b></a>
                    <div class="_total" style="display:none">
                    	评论<span>(3)</span>
                    </div>
                    <div class="_date"><%=CommonDate.getFormatDate("yyyy-MM-dd",CommonString.getFormatPara(one.get("add_date")) )%></div>
                </div>
                <div class="_cont"><%=CommonString.getFormatPara(one.get("content"))%></div>
				 
              <%
              	String imgSql = "select top 10 * from pro_weixiu_image where weixiu_id='"+pro_id+"' ";
              	List<Map> imgsList = dbHelper.getMapList(imgSql);
              	if(imgsList!=null && imgsList.size()>0){
              %>
              <div class="diy_pic fix">
              <ul class="fix">
              <% 
              	for(Map m:imgsList){
              		String image = CommonString.getFormatPara(m.get("image"));
              %>
              <li><a href="javascript:void(0)"><img src="<%=image %>" width="40" height="40"><i></i></a></li>
              <%} %>
              </ul>
             <div class="pic_yuan"><a href="javascript:void(0)">收起</a><img src="" onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);" width="300" height="400" /></div>
              </div>
              <%} %>

				<%
					 secondSql="SELECT  a.username,a.add_date,a.reply_id,a.content,a.id,b.image FROM(select top 10 username,add_date,reply_id,content,id from pro_weixiu_comment where reply_id= "+CommonString.getFormatPara(one.get("id"))+" order by add_date desc  ) as a LEFT JOIN (SELECT image,username from  pro_member )  as b ON a.username=b.username";
				     secondList = dbHelper.getMapList(secondSql);
				%>
		  
                <div class="_reply">
				   <%
				   int height=0;
			       if(secondList!=null && secondList.size()>0){
				   if(secondList.size()>4){height=300;}else{height=85*(secondList.size());}
				    %>
                	<% if(secondList.size()>4){%><a href="javascript:void(0)" class="_more" onclick="showMoreSecond()">显示更多</a><%}%>
                    <ul style="height:<%=height%>px;overflow:hidden;" id="replyAll">
					<% for(Map oneMap:secondList){  %>
                    	<li>
            				<span class="_avat"><img src="<%=CommonString.getFormatPara(oneMap.get("image"))%>"  onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/></span>
                            <div class="_info_bar">
                                <a href="javascript:void(0)" class="user"><%=CommonString.getFormatPara(oneMap.get("username")).equals("front")?"铁臂商城用户":CommonString.getFormatPara(oneMap.get("username"))%></a>
                                <div class="_date"><%=CommonDate.getFormatDate("yyyy-MM-dd",CommonString.getFormatPara(oneMap.get("add_date")) )%></div>
                            </div>
                            <div class="_cont"><%=CommonString.getFormatPara(oneMap.get("content"))%></div>
                        </li>
                   <%}%>
                    </ul>
				    <%}%>
                    <div class="_input">
                    	<div class="_inp"><input type="text" name="reply_<%=CommonString.getFormatPara(one.get("id"))%>" id="reply_<%=CommonString.getFormatPara(one.get("id"))%>" /></div>
                        <a href="javascript:void(0)" class="_btn" onclick="replyXinde(<%=CommonString.getFormatPara(one.get("id"))%>)">回复</a>
                        <div class="_input_num" style="display:none">
                        	<span id="already">0</span>/300字
                        </div>
                    </div>
                </div>
            </li>
     <%}}%> 
        </ul>
    </div>
    
    
    <div class="publish_reply" id="publish_reply">
    	<div class="_title">
        	我要发布心得
        </div>
        <div class="_cont">
                <textarea class="textarea" name="myXinde" id="myXinde"></textarea>
                <div class="_tip">10-2000个字</div>
				<div><ul class="showpic clearfix" id="addImgs_show"></ul></div>
                <div class="_upload">上传图片：<span <%if(memberInfo!=null){%>id="addImgs"<%}else{%>onclick="login();"<%}%>  class="_upbtn"></span>
                </div>
                <p>单张图片不超过100M,尺寸不小于300px * 300px，支持png，jpg和bmp</p>
                <div class="_act">
                	<button class="_btn" <%if(memberInfo!=null){%>onclick="pubXinde()"<%}else{%>onclick="login();"<%}%>></button>
                </div>
        </div>
		<input type="hidden" name="images" id="images" value=""/>
    </div>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<!-- right end-->
</div>
</div>
<jsp:include page="/include/index/friendlink_weixiu.htm" flush="true"/>
<jsp:include page="/include/foot.jsp" flush="true"/>
<script>
	//发布新的
	function pubXinde(){	
	var content=jQuery("#myXinde").val();
	if(content==''){alert("请输入维修心得内容");}
	else{
	var images=jQuery("#images").val();
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=pubXinde',
	    data: { content: content,proid:'<%=pro_id%>',username:'<%=username%>',images:images},
		async:false,
		success:function(data){
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("发布成功！");
          setTimeout("window.location.reload()",2000);
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("发布失败，请重新发布！");
			}
		}
	});	
	}
  }
  //回复评论
	function replyXinde(a){	
	var content=jQuery("#reply_"+a).val();
	if(content==''){alert("请输入回复内容");}
	else{
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=pubXinde',
	    data: { content: content,proid:'<%=pro_id%>',reply_id:a},
		async:false,
		success:function(data){
			if($.trim(data)=="ok"){
				jQuery.jBox.tip("发布成功！");
          setTimeout("window.location.reload()",2000);
			}else if($.trim(data)=="no"){
				jQuery.jBox.tip("发布失败，请重新发布！");
			}
		}
	});	
	}
  }
//显示更多  
function showMoreSecond(){
var m = $("#replyAll");  
m.css("height","auto"); 
}
//点击
	function vote(id){
		var help = parseInt($("#num_"+id).html());
		if(setlooked(id)==1){
			$.ajax({
			  url: "/action/ajax.jsp?flag=pubProAd&param="+id+"&pro_id=<%=pro_id%>",
			  cache: false,
			  async: true,
			  success: function(html){
			  }
			});
			$("#num_"+id).html(help+1);
			$.jBox.tip('感谢您的支持！');
		}else{
			$.jBox.tip('您已经投过票了哟！');
		}
	}
	function setlooked(id){
		var x = 0;
		var imgs = jQuery.cookies.get("help_imgs");
		if(imgs==null || imgs == "" || imgs.indexOf("help"+id) < 0){
			var newImgs = imgs+",help"+id;
			jQuery.cookies.set("help_imgs",newImgs,{hoursToLive : 10});
			x = 1;
		}
		return x;
	}
	//上传图片
	jQuery(function(){
		jQuery("#addImgs").JrUpload({
			remotUrl : "http://resource.21-sun.com/upload.jsp",
			folder : "product/koubei" ,
			sizeLimit:10*1024*1024, //10M
			multi : true,
			beforeCallback : "beforeCallback",
			callback : "setImgs" ,
			style : "width:98px;height:30px;",
			buttonImg : "<%=Common.getDomain(request) %>/activity/koubei/images/1_22.jpg" ,
			buttonImgWidth : 77 ,
			buttonImgHeight : 30
		});
	});
	function beforeCallback(){
		$.jBox.tip("图片上传中，请稍后。。。", "loading");
	}
	function setImgs(data){
		var images=jQuery("#images").val();
		var imgs = data.split(",");
		var htm = '';
		var f = 'http://resource.21-sun.com';
		for(var i=0;i<imgs.length;i++){
			htm += '<li><img class="img" src="'+f+imgs[i]+'" width="90" height="60" /><input type="hidden" name="img" value="'+f+imgs[i]+'" /><a href="javascript:void(0);" onclick="removeThis(this);" attrId="0" class="img_delete" style="position:absolute;top:-7px;left:80px;"><img src="http://member.21-sun.com/home/used/images/delete.png" /></a></li>';
		   images+=f+imgs[i]+",";
		}
		jQuery("#images").val(images);
		jQuery("#addImgs_show").append(htm);
		regEvent();
		$.jBox.closeTip();
	}
	function regEvent(){
		jQuery("#addImgs_show>li").mouseover(function(){
			jQuery(".img_delete").hide();
			jQuery(this).find(".img_delete").show();
		});
		jQuery("#addImgs_show>li").mouseout(function(){
			jQuery(".img_delete").hide();
		});
	}
	function removeThis(o){
		var attrId = jQuery(o).attr("attrId")+"";
		if(attrId=='0'){
			jQuery(o).parent().remove();
		}else{
			if(confirm("确定删除该张图片吗？")){
				jQuery(o).parent().remove();
			}
		}
	}
</script>
</body>
</html>
