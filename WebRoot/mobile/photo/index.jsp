<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title>铁臂图库</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="apple-mobile-web-app-title" content="Web Starter Kit">
<link rel="apple-touch-icon" href="/img/apple-touch-icon.png" />
<link rel="apple-touch-startup-image" href="/img/screen.png" />
<meta name="format-detection" content="telephone=no">
<meta name="author" content="design by www.21-sun.com">
<link href="../web/css/style.css" rel="stylesheet" />
</head>
<body class="body_bottom">
<jsp:include page="top.jsp" flush="true"></jsp:include>
<div class="kba_nav">
	<ul class="fix">
    	<li class="cur"><a href="index_activity.jsp">首页</a></li>
        <li ><a href="guize.jsp">活动规则</a></li>
        <li><a href="jiangpin.jsp">活动奖品</a></li>
        <li><a href="index_st.jsp">山推专区</a></li>
    </ul>
</div>

<div class="kba_fbwz">发布您的真实感受</div>
 <form action="/action/ajax.jsp" method="post" name="theform" id="theform">
   	<input type="hidden" name="tableName" id="tableName" value="pro_comments"/>
	<input type="hidden" name="name" id="name" value="<%  if(memberInfo!=null){CommonString.getFormatPara(memberInfo.get("username")); }%>"/>
    <input type="hidden" name="zd_userid" id="zd_userid" value="1"/>
    <input type="hidden" name="eventAfter" value="insertImages"/>
	<input type="hidden" name="comment_id" id="comment_id"  value=""/>
    <input type="hidden" name="score1" id="score1" />
    <input type="hidden" name="score2" id="score2" />
    <input type="hidden" name="score3" id="score3" />
    <input type="hidden" name="score4" id="score4" />
	<input type="hidden" name="zd_image" id="zd_image" />
	<input type="hidden" name="flag" value="new_save_comment_shouji" />
<div class="kba_fbpl">
	<div class="kba_prono kba_sele" id="optbg_1">
	<%
		if(username.equals("")){
		%>
		<a href="javascript:;" onclick="comd();"><div class="_val" ><span><i class="red">*</i> 请选择品牌</span></div></a>
		<%}else{%>
       <div class="_val"><span><i class="red">*</i> 请选择品牌</span></div><%}%>
    <jsp:include page="factoryid.jsp" flush="true"></jsp:include>
    </div>
	 <input type="hidden" name="factory" id="factory" /><!--品牌-->
    <div class="kba_probrd kba_sele" id="optbg_2">
       <div class="_val"><span><i class="red">*</i> 请选择机型</span></div>
       <div class="_option hide"> 
          
       </div>
    </div>
	 <input type="hidden" name="catalog" id="catalog" /><!--类别-->
    <div class="kba_procat kba_sele" id="optbg_3">
       <div class="_val"><span><i class="red">*</i> 请选择型号</span></div>
       <div class="_option hide"> 
          
       </div>
    </div>
	 <input type="hidden" name="product_id" id="product_id" value="" /><!--产品-->
    <div class="kba_xxval">
    	<ul class="fix kba_xxlist">
        	<li>
            	<span class="kba_xxwz"><i class="red">*</i> 价格：</span>
			   <div name="price_1" id="price_1" class="kba_xx" style="cursor: pointer; width: 100px;"><img src="/mobile/img/star-off.png" alt="1" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="2" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="3" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="4" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="5" title=""><input type="hidden" name="score"></div></li>
            <li>
            	<span class="kba_xxwz"><i class="red">*</i> 质量：</span>
                <div name="xingneng_1" id="xingneng_1" class="kba_xx" style="cursor: pointer; width: 100px;"><img src="/mobile/img/star-off.png" alt="1" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="2" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="3" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="4" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="5" title=""><input type="hidden" name="score"></div></li>
            <li>
            	<span class="kba_xxwz"><i class="red">*</i> 性能：</span>
                <div name="zhiliang_1" id="zhiliang_1" class="kba_xx" style="cursor: pointer; width: 100px;"><img src="/mobile/img/star-off.png" alt="1" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="2" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="3" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="4" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="5" title=""><input type="hidden" name="score"></div></li>
            <li>
            	<span class="kba_xxwz"><i class="red">*</i> 售后：</span>
                <div name="shouhou_1" id="shouhou_1" class="kba_xx" style="cursor: pointer; width: 100px;"><img src="/mobile/img/star-off.png" alt="1" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="2" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="3" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="4" title="">&nbsp;<img src="/mobile/img/star-off.png" alt="5" title=""><input type="hidden" name="score"></div></li>
        </ul>
    </div>
    <div class="kba_text">
    	<textarea placeholder="写点评价吧，可以帮助其他人购机" id="content" name="content"></textarea>
        <div class="upimg_btn">
		<%
		if(username.equals("")){
		%>
		<a href="javascript:;"  onclick="comd();">请选取文件</a>
		<%}else{%>
		<p id="upload" > <input type="file"   name="equi_img" id="equi_img"></p>
		<%}%>
		
		</div>
        <div class="up_smimg fix">
        	<a href="#"><img src="http://product.21-sun.com/mobile/koubei/huodong/web/img/upimg.gif" id="mig_show" /></a>
        </div>
        <div class="upsub_btn">
		<%
		if(username.equals("")){
		%>
		<a href="javascript:;"  onclick="comd();">提交评论</a>
		<%}else{%>
		<a href="javascript:;" onclick="doComments();">提交评论</a><%}%></div>
    </div>
    <div class="optbg_1"></div>
    </form>
</div>
<div class="kba_fbwz mt10">口碑热门机型</div>
<div class="kba_hotp mt10">
	<ul class="fix kba_hotp_list">
	<%
	for(Map hot:hotLists){
    			String hot_id = CommonString.getFormatPara(hot.get("id"));
		String querys="select id,factoryname,catalogname,name,img2 from pro_products where id="+hot_id+" and is_show=1";
		hot_pro = dbHelper.getMapList(querys);
    		for(Map hotPro:hot_pro){	
			String id = CommonString.getFormatPara(hotPro.get("id"));
			String factoryname = CommonString.getFormatPara(hotPro.get("factoryname"));
			String catalogname = CommonString.getFormatPara(hotPro.get("catalogname"));
			String name = CommonString.getFormatPara(hotPro.get("name"));
			String img2 = CommonString.getFormatPara(hotPro.get("img2"));
	%>
    	<li>
        	<a href="/web_kb_detail.jsp?id=<%=id%>" title="<%=factoryname%><%=name%><%=catalogname%>">
            	<img src="/uploadfiles/<%=img2%>" alt="<%=factoryname%><%=name%><%=catalogname%>"/>
                <div class="kb_hopname"><%=factoryname%><%=name%><%=catalogname%></div>
            </a>
        </li>
      <%}}%>
    </ul>
</div>
<!--foot-->
<jsp:include page="foot.jsp" flush="true"></jsp:include>
<!--foot end-->
</body>
<script src="/mobile/koubei/huodong/modules/seajs/sea.js" id="seanode" ></script>
<script src="/mobile/koubei/huodong/web/seajs.config.js"></script>
<script>
	var jrChannel='0#0';
	seajs.use('./mobile/koubei/huodong/web/app/index.js')
</script>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script>
//未登录提示
function comd(){
alert("请您登陆后再发表评论，谢谢");
window.location.href="/web_login_activity.jsp";
}


//星星
        $("#price_1,#xingneng_1,#zhiliang_1,#shouhou_1").raty({
	    path: "/mobile/img",
	    half : true ,
	    score : 0
        });
	       
			
			//评论提交
function doComments(){
			var catalog = $("#catalog").val();
			var a = '';
			if(catalog==a){
				alert("请选择机型！");
				return false;
			}
	
			var product = $("#product_id").val();
			var p = '';
			if(product==p){
				alert("请选择产品！");
				return false;
			}
			var price = jQuery("#price_1").raty("score");
			var xingneng = jQuery("#xingneng_1").raty("score");
			var zhiliang = jQuery("#zhiliang_1").raty("score");
			var shouhou = jQuery("#shouhou_1").raty("score");
			if(typeof(price)=="undefined"){
				alert("请您点击星星为该机型价格打分！");
				return false;
			}
			if(typeof(zhiliang)=="undefined"){
				alert("请您点击星星为该机型质量打分！");
				return false;
			}
			if(typeof(xingneng)=="undefined"){
				alert("请您点击星星为该机型性能打分！");
				return false;
			}
			if(typeof(shouhou)=="undefined"){
				alert("请您点击星星为该机型售后打分！");
				return false;
			}
			var content = $.trim($("#content").val());
			var c = '';
			if(content==c){
				alert("请填写您的评价！");
				return false;
			}else if(content.length<10||content.length>1999){
				alert("请按要求填写您的评价！");
				return false;
			}

			
			jQuery("#score1").val(parseFloat(jQuery("#price_1").raty("score"),10)*20);
			jQuery("#score2").val(parseFloat(jQuery("#xingneng_1").raty("score"),10)*20);
			jQuery("#score3").val(parseFloat(jQuery("#zhiliang_1").raty("score"),10)*20);
			jQuery("#score4").val(parseFloat(jQuery("#shouhou_1").raty("score"),10)*20);

			jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data){
			     if(jQuery.trim(data)=='no'){
				   alert("您输入的评价中含有敏感词，请重新输入") ;

				   return ;
				}
				if(jQuery.trim(data)=='0'){
				   alert("评论失败") ;
 
				   return ;
				}
					alert("评论提交成功！");
		            setTimeout("window.location.reload()",1000);
				}					  
			});
		}
</script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbHelper.freeConnection(connection);
	}
%>