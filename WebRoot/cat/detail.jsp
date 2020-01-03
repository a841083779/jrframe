<%@ page language="java" import="com.jerehnet.util.common.*,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.dbutil.DBHelper,com.jerehnet.util.common.CommonString,java.util.*,org.json.*" pageEncoding="UTF-8"%>
<% 
	String proId = CommonString.getFormatPara(request.getParameter("id"));
	DBHelper dbHelper = DBHelper.getInstance() ;
	List<Map> paramList=new  ArrayList<Map>();
	Map keyParamMap = (Map) application.getAttribute("keyParamMap");
	Map paramListMap = (Map) application.getAttribute("paramListMap");
	Map proMap = null;
	List<Map> proImgList = null;
	List<Map> inquiryList = null;
	String id = "";
	String file_name = "";
	String img2 = "";
	String factoryname = "";
	String name = "";
	String catalogname = "";
	String factoryid_sub = "";
	String introduce = "";
	String paras = "";
	int tonandmeter = 0;
	String param="";
	String cata="挖掘机";
	String cataUrl="#";
	List <Map> categoryParamsList =null;
    List <Map> categoryList= null; 

	if(proId!=null && !proId.equals("")&& proId.indexOf("#")<0){
		 
		
		proMap = dbHelper.getMap(" select catalognum,factoryname,name,catalogname,img2,id,factoryid_sub,file_name,introduce,paras,tonandmeter,param from pro_products where id=?",new Object[]{proId}) ;
		if(proMap == null){
			response.setStatus(301);
			response.setHeader("Location", "/cat/"); 
			return;	
		}else{
			id = CommonString.getFormatPara(proMap.get("id"));
			file_name = CommonString.getFormatPara(proMap.get("file_name"));
			img2 = CommonString.getFormatPara(proMap.get("img2"));
			factoryname = CommonString.getFormatPara(proMap.get("factoryname"));
			name = CommonString.getFormatPara(proMap.get("name")).replace("^r","®");
			catalogname = CommonString.getFormatPara(proMap.get("catalogname"));
			factoryid_sub = CommonString.getFormatPara(proMap.get("factoryid_sub"));
			introduce = CommonString.getFormatPara(proMap.get("introduce")).replace("?", "").replace("^r","®");
			paras = CommonString.getFormatPara(proMap.get("paras")).replace("?", "");
			tonandmeter = CommonString.getFormatInt(proMap.get("tonandmeter"));
			if(tonandmeter<20){cata="小型挖掘机";cataUrl="/cat/list.jsp?flag=grab_1_19";}
			if(tonandmeter<30&&tonandmeter>=20){cata="中型挖掘机";cataUrl="/cat/list.jsp?flag=grab_20_30";}
			if(tonandmeter>30){cata="大型挖掘机";cataUrl="/cat/list.jsp?flag=grab_30_1";}
			param=  CommonString.getFormatPara(proMap.get("param"));
    String paramIds="";
	String  param_id="",param_value="",param_name="";
    if(!param.equals("[]")&&!param.equals("")){ 
	  	JSONArray keyParaAry = new JSONArray(param);
		if(keyParaAry!=null && keyParaAry.length()>0){
				for(int j=0;j<keyParaAry.length();j++){
				    Map parmaMap = new HashMap();
          			JSONObject keyParaObj = keyParaAry.getJSONObject(j);
					param_id = CommonString.getFormatPara(keyParaObj.get("no"));
					if(param_id.equals("")){param_id="0";}
					param_value = CommonString.getFormatPara(keyParaObj.get("value"));
					param_name = CommonString.getFormatPara(keyParaObj.get("name"));

					if(!param_value.equals("")&&paramIds.indexOf(param_id)<0){
						paramIds+=param_id+",";
					}
					parmaMap.put("param_id", param_id);
                    parmaMap.put("param_name", param_name);
					parmaMap.put("param_value", param_value);
					paramList.add(parmaMap);
				}
		}
	}
	paramIds=paramIds+"0";
			//查询图片
			String imgSqlStr = "select   name,img_name from pro_product_pic where  product_id= ? order by id asc";
			proImgList = dbHelper.getMapList(imgSqlStr, new Object[]{proId});
			 categoryParamsList =(List<Map>) paramListMap.get(CommonString.getFormatPara(proMap.get("catalognum")));
            categoryList=dbHelper.getMapList(" select id,name   from pro_category where parent_no="+CommonString.getFormatPara(proMap.get("catalognum"))+" and id in (select category_id from pro_catalog_param where id  in ("+paramIds+") group by  category_id)"); 

		}
	}else{
		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			response.setHeader("Location", "/cat/"); 
	
	}

	//TDK
	String title="";String keywords="";String description="";
	if(!id.equals("")&&!id.equals("20164")&&!id.equals("20163")&&!id.equals("4561")&&!id.equals("20735")&&!id.equals("3525")&&!id.equals("9551")){
	   title=factoryname+name+catalogname+"_"+factoryname+name+catalogname+"价格 - 铁臂商城卡特彼勒(Cat)专区";
	   keywords=factoryname+name+catalogname+","+factoryname+name+catalogname+"价格";
	   description="铁臂商城卡特彼勒(Cat)专区提供"+factoryname+name+catalogname+"所有信息，涵盖"+factoryname+name+catalogname+", "+factoryname+name+catalogname+"价格,"+factoryname+name+catalogname+"报价等，帮您全面了解"+factoryname+name+catalogname+"。";
	}else{
	    //306E
	    if(id.equals("20164")){
		   title="卡特306E挖掘机_卡特306E小挖_卡特306E价格 - 铁臂商城卡特彼勒(Cat)专区";
	       keywords="卡特306E,卡特306E挖掘机,卡特306E价格,卡特306E报价,卡特彼勒306E小型液压挖掘机";
	       description="铁臂商城卡特彼勒(Cat)专区提供卡特彼勒306E小型液压挖掘机所有信息，涵盖卡特306E,卡特306E挖掘机,卡特306E价格,卡特306E报价等，帮您全面了解卡特306E小型挖掘机。";
		}
		//307E
	    if(id.equals("20163")){
		   title="卡特307E挖掘机_卡特307E小挖_卡特307E价格 - 铁臂商城卡特彼勒(Cat)专区";
	       keywords="卡特307E,卡特307E挖掘机,卡特307E价格,卡特307E报价,卡特彼勒307E小型液压挖掘机";
	       description="铁臂商城卡特彼勒(Cat)专区提供卡特彼勒307E小型液压挖掘机所有信息，涵盖卡特307E,卡特307E挖掘机,卡特307E价格,卡特307E报价等，帮您全面了解卡特307E小型挖掘机。";
		}
		//305.5E
	    if(id.equals("4561")){
		   title="卡特305.5E挖掘机_卡特305.5E小挖_卡特305.5E价格 - 铁臂商城卡特彼勒(Cat)专区";
	       keywords="卡特305.5E,卡特305.5E挖掘机,卡特305.5E价格,卡特305.5E报价,卡特彼勒305.5E小型液压挖掘机";
	       description="铁臂商城卡特彼勒(Cat)专区提供卡特彼勒305.5E小型液压挖掘机所有信息，涵盖卡特305.5E,卡特305.5E挖掘机,卡特305.5E价格,卡特305.5E报价等，帮您全面了解卡特305.5E小型挖掘机。";
		}
		//336D2
	    if(id.equals("20735")){
		   title="卡特336D2_卡特336D2挖掘机_卡特336D2价格 - 铁臂商城卡特彼勒(Cat)专区";
	       keywords="卡特336D2,卡特336D2挖掘机,卡特336D2价格,卡特336D2报价,卡特彼勒336D2挖掘机";
	       description="铁臂商城卡特彼勒(Cat)专区提供卡特彼勒336D2挖掘机所有信息，涵盖卡特336D2,卡特336D2挖掘机,卡特336D2价格,卡特336D2报价等，帮您全面了解卡特彼勒336D2挖掘机。";
		}
		//336D/336DL
	    if(id.equals("3525")){
		   title="卡特336D/336DL挖掘机_卡特336D/336DL价格 - 铁臂商城卡特彼勒(Cat)专区";
	       keywords="卡特336D/336DL,卡特336D/336DL挖掘机,卡特336D/336DL价格,卡特336D/336DL报价,卡特彼勒336D/336DL挖掘机";
	       description="铁臂商城卡特彼勒(Cat)专区提供卡特彼勒336D/336DL挖掘机所有信息，涵盖卡特336D/336DL,卡特336D/336DL挖掘机,卡特336D/336DL价格,卡特336D/336DL报价等，帮您全面了解卡特彼勒336D/336DL挖掘机。";
		}
		//340DL
	    if(id.equals("9551")){
		   title="卡特340DL_卡特340DL挖掘机_卡特340DL价格 - 铁臂商城卡特彼勒(Cat)专区";
	       keywords="卡特340DL,卡特340DL挖掘机,卡特340DL价格,卡特340DL报价,卡特彼勒340DL挖掘机";
	       description="铁臂商城卡特彼勒(Cat)专区提供卡特彼勒340DL挖掘机所有信息，涵盖卡特340DL,卡特340DL挖掘机,卡特340DL价格,卡特340DL报价等，帮您全面了解卡特彼勒340DL挖掘机。";
		}
		
	}
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=title%></title>
<meta name="Keywords" content="<%=keywords%>" />
<meta name="Description" content="<%=description%>" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="style/jquery.jqzoom.css" type="text/css">
<script type="text/javascript" src="scripts/jquery.min.js"></script>
<script type="text/javascript" src="scripts/jquery.SuperSlide.js"></script>
<script src="scripts/jquery.jqzoom-core.js" type="text/javascript"></script>
<script src="/scripts/scripts.js" type="text/javascript"></script>
<!--[if (IE 6)]>
<script src="scripts/iepng.js" type="text/javascript"></script>
<script type="text/javascript">
   EvPNG.fix('.png'); 
</script>
<![endif]-->
</head>
<body>
<!--top--begin-->
<jsp:include page="include/top.jsp" flush="true"></jsp:include>
<jsp:include page="include/nav.jsp" flush="true"></jsp:include>
<!--top--end-->
<div class="wrap_list">
  <div class="list_banner" <%if(tonandmeter<20){%>style="background: url(images/2018/301.5.jpg) no-repeat;"<%}else if(tonandmeter>=20&&tonandmeter<30){%>style="background: url(images/2018/330.jpg) no-repeat;"<%}else{%>style="background: url(images/2018/336.jpg) no-repeat;"<%}%>>
  <div class="word">
   	<h3><%if(tonandmeter<20){%>新一代CAT®301.5挖掘机<%}else if(tonandmeter>=20&&tonandmeter<30){%>新一代CAT®330挖掘机<%}else{%>新一代CAT®336挖掘机<%}%></h3>
        <p>以更低的油耗实现更高的性能<br />
          易于使用的技术功能、新型舒适驾驶室<br />
          操作简单，安全性更好<br />
          通过驾驶室内的监视器跟踪挖掘机的滤清器使用寿命和维护间隔。

</p>
      </div>
  </div>
  <div class="list_con clearfix">
    <div class="list_left l">
      <ul class="up">
        <% if(tonandmeter<20){	%>
        <li class="cur"><a href="list.jsp?flag=grab_1_19">Cat<sup>&reg;</sup>小型挖掘机</a></li>
        <%	}else{	%>
        <li><a href="list.jsp?flag=grab_1_19">Cat<sup>&reg;</sup>小型挖掘机</a></li>
        <%	} %>
        <% if(tonandmeter>=20&&tonandmeter<30){	%>
        <li class="cur"><a href="list.jsp?flag=grab_20_30">Cat<sup>&reg;</sup>中型挖掘机</a></li>
        <%	}else{	%>
        <li><a href="list.jsp?flag=grab_20_30">Cat<sup>&reg;</sup>中型挖掘机</a></li>
        <%	} %>
        <% if(tonandmeter>=30){	%>
        <li class="cur"><a href="list.jsp?flag=grab_30_1">Cat<sup>&reg;</sup>大型挖掘机</a></li>
        <%	}else{	%>
        <li><a href="list.jsp?flag=grab_30_1">Cat<sup>&reg;</sup>大型挖掘机</a></li>
        <%	} %>
      </ul>
      <!--  
      <div class="down"> <a href="#">我要购机</a> <a href="#">我要询价</a> <a href="#">下载产品手册</a> <strong>查找经销商</strong>
        <select name="select" id="select">
          <option>请选择</option>
        </select>
        <select name="select" id="select">
          <option>请选择</option>
        </select>
        <input type="button" />
      </div>
      -->
    </div>
    <div class="pro_right">
      <div class="right_top clearfix">
        <div class=" share clearfix">
          <h1><%=factoryname %><%=name %><%=catalogname %></h1>
          <!-- JiaThis Button BEGIN -->
          <div class="jiathis_style"> <a class="jiathis_button_renren"></a> <a class="jiathis_button_tsina"></a> <a class="jiathis_button_douban"></a> <a class="jiathis_button_tqq"></a> <a class="jiathis_button_kaixin001"></a> </div>
          <script type="text/javascript" src="http://v3.jiathis.com/code/jia.js?uid=undefined" charset="utf-8"></script>
          <!-- JiaThis Button END -->
        </div>
        <div class="picBtnLeft l">
          <%
		if(proImgList!=null && proImgList.size()>0){
			int i = 0;
			for(Map m:proImgList){
				String img_name = CommonString.getFormatPara(m.get("img_name"));
				img_name = img_name.indexOf("uploadfiles")>0?"http://product.21-sun.com/"+img_name:"http://product.21-sun.com/uploadfiles/"+img_name;
	%>
          <a href="<%=img_name %>" class="jqzoom" rel='gal1'  title="triumph" > <img src="<%=img_name %>" onerror="showImgDelay(this,'/cat/images/zwtp.jpg',2);"  width="365" height="246"  style="border: 1px solid #dfdfdf;" title="triumph"></a>
          <% 	break;
	}}else{%>
          <a href="http://product.21-sun.com/uploadfiles/<%=img2 %>" class="jqzoom" rel='gal1'  title="triumph" > <img src="http://product.21-sun.com/uploadfiles/<%=img2 %>" onerror="showImgDelay(this,'/cat/images/zwtp.jpg',2);"  width="365" height="246"  style="border: 1px solid #dfdfdf;" title="triumph"></a>
          <%} %>
          <br>
		  
		  
		 	<div class="list_box0528">
			 <div class="left_arr"><img src="images/left_arr.png"/></div>
          	<div class="list_main">

			
          <div class="clearfix" style="clear:both;">
            <ul id="thumblist" class="clearfix" >
              <%
		if(proImgList!=null && proImgList.size()>0){
			int j = 0;
			for(Map m:proImgList){
				String img_name = CommonString.getFormatPara(m.get("img_name"));
				img_name = img_name.indexOf("uploadfiles")>0?"http://product.21-sun.com/"+img_name:"http://product.21-sun.com/uploadfiles/"+img_name;
	%>
              <li><a <% if(j==0){ %>class="zoomThumbActive"<%} %> href='javascript:void(0);' rel="{gallery: 'gal1', smallimage: '<%=img_name %>',largeimage: '<%=img_name %>'}"><img src='<%=img_name %>' width="59" height="59"></a></li>
              <% 	j++;
	}}else{%>
              <li><a class="zoomThumbActive" href='javascript:void(0);' rel="{gallery: 'gal1', smallimage: 'http://product.21-sun.com/uploadfiles/<%=img2 %>',largeimage: 'http://product.21-sun.com/uploadfiles/<%=img2 %>'}"><img onerror="showImgDelay(this,'/cat/images/zwtp.jpg',2);"  src='http://product.21-sun.com/uploadfiles/<%=img2 %>' width="59" height="59"></a></li>
              <%} %>
            </ul>
          </div>
		  	  	</div>
          	<div class="right_arr"><img src="images/right_arr.png"/></div>
		  
		  
		  </div>
		  
		  
		  
		  
        </div>
        <div class="info">
          <p>挖机型号: <%=name %><br />
            所属品牌: <%=factoryname %><br />
            所属类别: <a href="/cat/" title="<%=catalogname %>"><%=catalogname %></a><br />
            工作重量: <%=tonandmeter %>吨<br />
            所属类别: <a href="<%=cataUrl%>" title="卡特<%=cata%>"><%=cata%></a><br />
          </p>
          <div class="inquiry"> <a class="a_5" href="order.jsp?id=<%=id %>" target="_blank"><img src="http://product.21-sun.com/images/pd_btn.gif" alt="免费询价" width="188" height="45" /></a>
            <p>因不同地区代理商及价格差异，请您点击<a href="order.jsp?id=<%=id %>" target="_blank">咨询最低价</a>。</p>
          </div>
          <div class="link"> <a class="a3" href="#param">参数配置</a> <a class="a3" href="#intro">产品介绍</a> <a class="a3" href="#inquirys">询价单</a></div>
        </div>
      </div>
      <div class="right_mid" id="param">
        <h3 class="tit">参数配置</h3>
        <div class="wfull l tableContain mb10" id="myTab2_ContentA0">
          <%
		        if(!param.equals("[]")&&!param.equals("")){
		  %>
          <table cellspacing="0" cellpadding="0" width="100%">
            <tbody>
		    <%
		        if(categoryList!=null && categoryList.size()>0){
			        for(Map m:categoryList){
	        %>
              <tr>
                <td width="717" colspan="2"><%=name%></td>
              </tr>
              <tr>
                <td colspan="2"><strong><%=CommonString.getFormatPara(m.get("name"))%></strong></td>
              </tr>
			 <%
		        if(categoryParamsList!=null && categoryParamsList.size()>0){
			        for(Map mm:categoryParamsList){
						  if(CommonString.getFormatPara(m.get("id")).equals(CommonString.getFormatPara(mm.get("category_id")))){
								        if(paramList!=null && paramList.size()>0){
			                                   for(Map mmm:paramList){
                                                       if(!CommonString.getFormatPara(mmm.get("param_value")).equals("")&&CommonString.getFormatPara(mmm.get("param_id")).equals(CommonString.getFormatPara(mm.get("id")))){											   
											    
	         %>
			  <tr>
                <td><%=CommonString.getFormatPara(mmm.get("param_name"))%></td>
                <td><%=CommonString.getFormatPara(mmm.get("param_value"))%></td>
              </tr>
			 
				<%}	}}}}}%>

      
			<%}}%>
            </tbody>
          </table>
          <%}else{%>
          暂无参数
          <%}%>
        </div>
      </div>
      <div class="right_down clearfix" id="intro">
        <h3 class="tit">产品介绍</h3>
        <div class="wfull l tableContain mb10" id="myTab2_ContentA1"> <%=introduce.equals("")?"暂无介绍":introduce %> </div>
      </div>
	  
 
	  
    </div>
  </div>
  <!--foot--begin-->
  <jsp:include page="include/foot.jsp" flush="true"></jsp:include>
  <!--foot--end-->
</div>
<script type="text/javascript" src="scripts/comm.js"></script>
<script type="text/javascript">
function nTabs(thisObj, Num) {
	if (thisObj.className == "active") return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for (i = 0; i < tabList.length; i++) {
		if (i == Num) {
			thisObj.className = "active";
			document.getElementById(tabObj + "_Content" + i).style.display = "block";
		} else {
			tabList[i].className = "normal";
			document.getElementById(tabObj + "_Content" + i).style.display = "none";
		}
	}
}
$(document).ready(function(e) {
    $('.TabTitle li').click(function(){
		$('html,body').stop(1,0).animate({scrollTop:$('.TabTitle').offset().top},500);
	})
});
</script>
<script type="text/javascript">
$(document).ready(function() {
	$('.jqzoom').jqzoom({
            zoomType: 'reverse',
            lens:true,
            preloadImages: false,
            alwaysOn:false
        });
	//$('.jqzoom').jqzoom();
});


          	var imgLength = $('#thumblist').find('img').length,
          	count = imgLength - 4,
          	tran = 0;
          	$('.left_arr').on('click','img',function(){
							if(count>0&&tran>0){
								tran--;
								$('#thumblist').css('margin-left','-'+tran*75+'px')
							}
          	})
          	$('.right_arr').on('click','img',function(){
							if(count>0&&tran<count){
								tran++;
								$('#thumblist').css('margin-left','-'+tran*75+'px')
							}
          	})
$('#thumblist').width(75*imgLength+'px');
</script>
<div id="topcontrol" title="返回顶部"></div>
<script type="text/javascript" src="scripts/jr_top.js"></script>
<script type="text/javascript">
jQuery.JrTop({
left : 550
});
</script>
<script>
 
</script>
</body>
</html>