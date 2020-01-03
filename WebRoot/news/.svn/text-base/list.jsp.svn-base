<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.regex.*" pageEncoding="UTF-8"%><%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%><%
	String flag = CommonString.getFormatPara(request.getParameter("flag"));
	String showtip = "最新动态";
	String tableName = "article";
	String whereStr = " and is_pub=1";
	String orderBy = "pub_date desc";
	String t_flag = "" ;
	if ("newprorec".equals(flag)) {
		showtip = "新品推荐";
		whereStr += " and sort_num like '%,35,%' ";
	}
	if ("pronews".equals(flag)) {
		showtip = "企业动态";
		whereStr += " and sort_num like '%,22,%'";
	}
	if ("service".equals(flag)) {
		showtip = "维修一线";
		tableName = "article_other";
		whereStr += "and sort_num like '%0500%'";
		t_flag = "service" ;
	}
	if("".equals(flag)){
		whereStr += " and sort_num like '%,35,%' or sort_num like '%,22,%' ";
	}
	int pageSize = 50;
	List<Map> getNewsList = null;
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
	PageBean pageBean = new PageBean();
	DBHelper dbHelper = DBHelper.getInstance();
	Connection conn_21sun = null;
	pageBean.setFields("*") ;
	pageBean.setPageSize(pageSize);
	pageBean.setTableName(tableName);
	Integer nowPage = 1;
	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	if("".equals(offset) || Integer.parseInt(offset)<=0){
		offset = "0" ;
	}
	if (!"".equals(offset) && !"0".equals(offset)) {
		nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}
	pageBean.setNowPage(nowPage);
	pageBean.setCondition(whereStr);
	pageBean.setParams(url);
	pageBean.setOrderBy(orderBy);
	 
	// 是否有图
	Pattern pattern = Pattern.compile(".*?<img\\s*.*?\\s*src=\\\"(.*)\\\"\\s*.*?>.*");
	Matcher matcher = null;
	// 获得地区
	String ip  = Common.getIp(request);
	String jsonStr = Tools.getMyProvinceAndCity(ip);
	String city = "";
	String province = "";
	if(!CommonString.getFormatPara(jsonStr).equals("")){
		JSONObject obj = new JSONObject(jsonStr);
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
	}
	try {
		conn_21sun = dbHelper.getConnection();
		getNewsList = pageBean.getDatasByWebService("Web21sunDBHelper");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="工程机械动态,行业动态动态,产品中心动态,产品中心" />
<meta name="description" content="最新动态包含工程机械行业的重点动态和最新动态，中国工程机械商贸网产品中心专业提供工程机械企业动态，工程机械行业聚焦，工程机械维修等工程机械行业最新动态、行业分析。" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title><%=showtip %>--工程机械行业动态动态--中国工程机械商贸网产品中心动态</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="/plugin/dialog/jBox/Skins/Blue/jbox.css" type="text/css"/>
<link rel="stylesheet" href="/plugin/dialog/jBox/Skins/Blue/jbox.css" type="text/css"></link>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/flash.js"></script>
<script type="text/javascript" src="/plugin/dialog/jBox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/scripts/history/json.js"></script>
<script type="text/javascript" src="/scripts/history/history.js"></script>
<script type="text/javascript" src="/plugin/dialog/jBox/jquery.jBox-2.3.min.js"></script><body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> 您现在所在的位置： <a href="/news/">工程机械产品中心</a> &gt;&gt; 行情.导购</h3>
</div>
<!--面包屑结束--> 
<!--广告-->
<div class="contain980 mb10"> 
  <script language="javascript" type="text/javascript">
writeflashhtml("_swf=../images/hy.swf", "_width=980", "_height=60" ,"_wmode=opaque");
</script> 
</div>
<!--广告结束--> 
<!--main-->
<div class="contain980">
  <div class="newsListLeft">
    <div class="newsLeftpart mb10">
      <div class="title">
        <h3><%=showtip%></h3>
      </div>
      <ul class="list">
        <%
							if (null != getNewsList && getNewsList.size() > 0) {
									Map oneMap = null;
									for (int i = 0; i < getNewsList.size(); i++) {
										oneMap = (HashMap) getNewsList.get(i);
										if (i > 0 && i % 5 == 0) {
											out.println("<li class='blank'></li>");
										}
										if(!CommonString.getFormatPara(oneMap.get("link_other")).equals("")&&!CommonString.getFormatPara(oneMap.get("link_other")).equals("null")){
										
										
						%>
				 <li>
                    <h3> <a href="<%=CommonString.getFormatPara(oneMap.get("link_other"))%>"
				target="_blank"><%=CommonString.substringByte(CommonString.getFormatPara(oneMap.get("title")), 55)%>
                        <%
										matcher = pattern.matcher(CommonString.getFormatPara(oneMap.get("content")));
													if (matcher.find()) {
														out.println("（图）");
							}
									%>
            </a> </h3>
          <span class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(oneMap.get("pub_date")))%></span> </li>
											<%
										}else{
						%>
        <li>
          <h3> <a href="/news/detail.jsp?id=<%=CommonString.getFormatPara(oneMap.get("id"))%>&t_flag=<%=t_flag %>"
									target="_blank"><%=CommonString.substringByte(CommonString.getFormatPara(oneMap.get("title")), 55)%>
            <%
										matcher = pattern.matcher(CommonString.getFormatPara(oneMap.get("content")));
													if (matcher.find()) {
														out.println("（图）");
													}
									%>
            </a> </h3>
          <span class="time"><%=CommonDate.getFormatDate("yyyy-MM-dd", CommonString.getFormatPara(oneMap.get("pub_date")))%></span> </li>
        <%
									}
							}
								}
						%>
      </ul>
      <div class="pages">
        <form id="theform" name="theform" method="post" action="">
		<div id="pagination" class="paging  page" style="margin-right:3px;">
			<tags:page pageBean="<%=pageBean%>" />
		</div>
        </form>
      </div>
    </div>
    <div class="newsLeftpart nlp02 mb10">
      <div class="title">
        <h3><%=province%><%=city%>经销商推荐 </h3>
        <span class="more"><a href="/agent/list.jsp" target="_blank">更多&gt;&gt;</a> </span> </div>
      <div class="agent_li">
        <div class="agent_li" id="agent_info"> 
          <!-- 代理商动态 --> 
        </div>
             <div class="paging page" id="agent_page" style="width: 400px; float: left;margin-left:325px;"> 
          <!-- ajax分页 --> 
       </div>
        </div>
      </div>
  </div>
  <div class="newsListRight">
    <div class="w100 l mb10" style="display:none;"> 
               <a href="#"><img src="../images/news_img08.jpg" width="240" height="80" /> </a> 
	</div>
    <div class="w100 l mb10" style="display:none;"> <a href="#"><img src="../images/news_img09.jpg" width="240"
							height="80" /> </a> </div>
    <div class="newsRightpart nrp01 mb10">
      <div class="title">
        <h3> 最新产品图片 </h3>
        <span class="more"><a href="/photo/list.jsp" target="_blank">更多&gt;&gt;</a> </span> </div>
      <div class="content">
        <ul class="list">
          <%
          
		 String sel_pic_sql = "select top 8 id,img2,add_date,factoryname,catalogname,name from pro_products where img2 is not null and img2 != '' order by newid()";
		List<Map> newPics = dbHelper.getMapList(sel_pic_sql, conn_21sun);
		if (null != newPics && newPics.size() > 0) {
		for (Map oneMap : newPics) {
		%>
          <li> <a	href="/photo/detail_for_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm"
									target="_blank"><img
										src="/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img2"))%>"
										onerror="this.src='/images/nopic.gif'" width="90" height="60" />
            <h3><%=CommonString.getFormatPara(oneMap.get("factoryname")) + CommonString.getFormatPara(oneMap.get("catalogname"))
								+ CommonString.getFormatPara(oneMap.get("name"))%></h3>
            </a> </li>
          <%
								}
									}
							%>
        </ul>
      </div>
    </div>
    <div class="newsRightpart nrp02 mb10">
      <div class="title">
        <h3> 最新看看 </h3>
        <span class="more"><a href="http://video.21-sun.com" target="_blank">更多&gt;&gt;</a> </span> </div>
      <div class="content">
        <ul class="list">
          <%
								String sel_video_sql = "select top 3 * from article where sort_num like '%,869,%' and  is_pub=1 and is_del=0 and flag=3 and area_flag<>4 order by newid()";
									List<Map> videoList = WEBDBHelper.getMapList(sel_video_sql, "Web21sunDBHelper");
									if (null != videoList && videoList.size() > 0) {
										for (Map oneMap : videoList) {
							%>
			          <li> <a href="<%=CommonString.getFormatPara(oneMap.get("link_other")) %>" target="_blank">
			          <img src="/images/nopic.gif" onerror="this.src='/images/nopic.gif'" width="90" height="50" />
			            <h3 style="height:48px;"> <%=CommonString.getFormatPara(oneMap.get("title")) %></h3>
			            </a> </li>
          <%
								}
									}
							%>
        </ul>
      </div>
    </div>
    <div class="w100 l mb10" style="display:none;"> <a href="#"><img src="../images/news_img10.jpg" width="240"
							height="200" /> </a> </div>
    <div class="w100 l mb10" style="display:none;"> <a href="#"><img src="../images/news_img11.jpg" width="240"
							height="200" /> </a> </div>
    <div class="w100 l mb10" style="display:none;"> <a href="#"><img src="../images/news_img12.jpg" width="240"
							height="200" /> </a> </div>
    <div class="clear"></div>  
    <div class="newsRightpart nrp03 mb10" id="tophistory">
      <div class="title">
        <h3> 您最近浏览过的产品 <a href="javascript:;" onclick="clearHistory();"><font color='red'>清空</font></a></h3>
      </div>
      <div class="content">
        <ul class="list" id="history">
        </ul>
      </div>
    </div>
    <div class="clear"></div>
    <div class="newsRightpart nrp04 mb10">
      <div class="title">
        <h3>相关二手机
        </h3>
        <span class="more">
        <a href="http://www.21-used.com/equipment/" target="_blank">更多>></a>
        </span>
      </div>
      <div class="content">
        <ul class="list">
          <%
		String sel_sql = "select top 5 eq.id,eq.province,eq.model,brand.brand_name,eq.price from dbo.used_equipment eq  left join used_brand brand on eq.brand_id=brand.id where eq.category_id=1 and eq.is_pub=1 order by eq.id desc";
		List<Map> usedVehicle = WEBDBHelper.getMapList(sel_sql,"Web21usedDBHelper") ;
		if (null != usedVehicle && usedVehicle.size() > 0) {
			for (Map oneMap : usedVehicle) {
							%>
          <li class="t-d">
            <h3 class="n01"> <a href="http://www.21-used.com/equipment/equipmentdetail_for_<%=CommonString.getFormatPara(oneMap.get("id"))%>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("brand_name")) + CommonString.getFormatPara(oneMap.get("model")) + "挖掘机"%></a> </h3>
            <span class="n02"><%=CommonString.getFormatPara(oneMap.get("province"))%></span> <span class="n03"><%=((CommonString.getFormatPara(oneMap.get("price")).equals("0.00")||CommonString.getFormatPara(oneMap.get("price")).equals("0")) ? "面议" :( "￥"+CommonString.getFormatPara(oneMap.get("price")))+"万")%></span></li>
          <%
								}
									}
							%>                     
        </ul>
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>
<!--main end--> 
<!--foot-->
<jsp:include page="/include/foot.jsp"></jsp:include>
<!--end of foot--> 
<script type="text/javascript" src="/scripts/sort.js"></script> 
<script type="text/javascript">
	    var nowBrand = '';
    var nowBrandName = '';
	var nowCatalog = '';
	var nowCatalogName = '';
	var nowProvince = '<%=province%>';
	var nowCity = '<%=city%>';
    function doAgentSearch(){
    	if(jQuery("#province").val()==''&&jQuery("#city").val()==''&&jQuery("#brand").val()==''&&jQuery("#model").val()==''&&jQuery("#agent_q").val()==''){
    		alert("请选择搜索条件！");
    		return;
    	}
    	if(jQuery("#agent_q").val()!=''){
    		var provinceHTML ='';
    		if(document.getElementById("province").value!=''){
    			provinceHTML=document.getElementById("province").options[document.getElementById("province").selectedIndex].innerHTML;
    			provinceHTML = provinceHTML.split(" ")[1];
    		}
    		var cityHTML ='';
    		if(document.getElementById("city").value!=''){
    			cityHTML=document.getElementById("city").options[document.getElementById("city").selectedIndex].innerHTML;
    			cityHTML = cityHTML.split(" ")[1];
    		}
    		var brandHTML ='';
    		if(document.getElementById("brand").value!=''){
    			brandHTML=document.getElementById("brand").options[document.getElementById("brand").selectedIndex].innerHTML;
    			brandHTML = brandHTML.split(" ")[1];
    			brandHTML = brandHTML.replace("&nbsp;","");
    			brandHTML = brandHTML.replace("&nbsp;","");
    			brandHTML = brandHTML.replace("&nbsp;","");
    			brandHTML = brandHTML.replace("&nbsp;","");
    		}
    		var modelHTML ='';
    		if(document.getElementById("model").value!=''){
    			modelHTML=document.getElementById("model").options[document.getElementById("model").selectedIndex].innerHTML;
    			modelHTML = modelHTML.replace("&nbsp;","");
    			modelHTML = modelHTML.replace("&nbsp;","");
    			modelHTML = modelHTML.replace("&nbsp;","");
    			modelHTML = modelHTML.replace("&nbsp;","");
    		}
    		var goHtm = provinceHTML+cityHTML+brandHTML+modelHTML+jQuery("#agent_q").val();
    		goHtm = jQuery("#agent_q").val();
    		window.open("http://sowa.21-sun.com/?q="+encodeURIComponent(goHtm)+"&f=supply");
    	}else{
    		var url = "";
	    	if(jQuery("#brand").val()!=''){
	    		url += "&factoryid="+jQuery("#brand").val();
	    	}
	    	if(jQuery("#city").val()!=''){
	    		var city = jQuery("#city").val();
	    		city = city.split(" ")[1];
	    		url += "&city="+city;
	    	}
	    	if(jQuery("#province").val()!=''){
	    		var province = jQuery("#province").val();
	    		province = province.split(" ")[1];
	    		url += "&province="+province;
	    	}
	    	if(jQuery("#model").val()!=''){
	    		url += "&catalogid="+jQuery("#model").val();
	    	}
	    	if(""!=url){
	    		url = url.substring(1);
	    		url = "/agent/list.jsp?"+url;
	    	}else{
	    		url = "/agent/list.jsp";
	    	}
	    	window.location.href = url;
    	}
    }
  	getAgentList(0,'search');
  	function setHover(){
  		 jQuery("#agent_info ul").hover(function(){
			jQuery(this).toggleClass("a_hover");
		},function(){
			jQuery(this).removeClass("a_hover");
		});
  	}
  	function getAgentList(nowPage,isAuto){
  		if(nowBrand!=null||nowBrand!=''){
  			jQuery("#brand").val(nowBrand);
  		}
  		jQuery("#agent_info").html("<img src='/images/loading.gif' style='margin:130px 0 0 350px;' />");
		var agentObj;
		jQuery.ajax({
			url : "/tools/ajax.jsp",
			data : {
				flag : "agentList",
				nowPage : nowPage ,
				province : nowProvince ,
				city : nowCity ,
				orderProvince : nowProvince ,
				orderCity : nowCity ,
				brand : nowBrand ,
				model : nowCatalog ,
				isAuto : isAuto				
			},
			type : "post",
			success : function(data){
				agentObj = eval("["+data+"]")[0];
				var agentList = agentObj.list;
				var agLi = jQuery("#agent_info");
				agLi.html("");
				var htm = '';
				var i_f = 1;
				for(var i=0;i<agentList.length;i++){
					if((i%2)==0){
						i_f = 2;
					}else{
						i_f = 1;
					}
					htm += '<ul class="libg0'+i_f+'">';
					if(agentList[i].is_qijiandian==1){
					htm += '<li class="g1"><a title="'+agentList[i].full_name+'" href="/agentshop/'+agentList[i].usern+'/" target="_blank">'+agentList[i].full_name+'</a></li>';
					}else{
					htm += '<li class="g1"><a title="'+agentList[i].full_name+'" href="/agent/'+agentList[i].usern+'/" target="_blank">'+agentList[i].full_name+'</a></li>';
					}
					htm += '<li class="g4"><a href="javascript:void(0);" onclick="zaiXianXunJia(\''+agentList[i].id+'\');">在线询价</a></li>';
					if(null!=agentList[i].telphone&&agentList[i].telphone!=''){
						htm += '<li class="g5" style="width:130px;overflow:hidden;"><a id="seePhone_'+agentList[i].id+'" href="javascript:void(0);" onclick="lianXiDianHua(\''+agentList[i].id+'\');">点击查看联系电话</a></li>';
					}else{
						htm += '<li class="g5" style="width:130px;overflow:hidden;"><a class="gcur" href="javascript:void(0);">暂无联系方式</a></li>';
					}
					htm += '</ul>';
				}
				agLi.html(htm);
				jQuery("#agent_page").html("");
				if(jQuery.trim(htm)!=''){
					createPage(agentObj);
				}else{
					jQuery("#agent_info").html("<div style='text-align:center;margin:10px auto;'>暂无代理商动态！</div>");
				}
				setHover();
			}
		});
	}
	function zaiXianXunJia(id){
		var url = '/include/agent/enquiry.jsp?id='+id;
		if(nowBrand!=''){
			url += "&nowBrand="+nowBrand;
		}
		if(nowBrandName!=''){
			url += "&nowBrandName="+nowBrandName;
		}
		if(nowCatalog!=''){
			url += "&nowCatalog="+nowCatalog;
		}
		if(nowCatalogName!=''){
			url += "&nowCatalogName="+nowCatalogName;
		}
		jQuery.jBox("iframe:"+url,{
			title : "在线询价",
			width : 550,
			height : 380,
			iframeScrolling:'no' ,
			top: '25%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return false;
				}
				return true;
			}
		});
	}
	function seePhone(id){
		jQuery.post("/tools/ajax.jsp",{flag:'viewPhoneClickCount',id:id});
		var xunjia_user = jQuery.cookies.get("xunjia_user");
		var xunjia_phone = jQuery.cookies.get("xunjia_phone");
		var xunjia_catalog = jQuery.cookies.get("xunjia_catalog");
		var xunjia_catalog_name = jQuery.cookies.get("xunjia_catalog_name");
		var xunjia_brand = jQuery.cookies.get("xunjia_brand");
		var xunjia_brand_name = jQuery.cookies.get("xunjia_brand_name");
		jQuery.post("/tools/ajax.jsp",{
			flag : 'seePhone',
			name : xunjia_user,
			mobile_phone : xunjia_phone,
			province : '<%=province%>',
			city : '<%=city%>',
			catalog : xunjia_catalog,
			catalogName : xunjia_catalog_name,
			brand : xunjia_brand ,
			brandName : xunjia_brand_name ,
			id : id
		},function(data){
			jQuery("#seePhone_"+id).addClass("gcur");
			jQuery("#seePhone_"+id).html(data);
			jQuery("#seePhone_"+id).attr("tip_title",data);
			jQuery("#seePhone_"+id).removeAttr("onclick");
			jQuery("#seePhone_"+id).yitip();
			var singleTitleTip = jQuery("#seePhone_"+id).yitip("api");
			singleTitleTip.setPosition("rightMiddle");
		});
	}
	function lianXiDianHua(id){
		var xunjia_user = jQuery.cookies.get("xunjia_user");
		if(null!=xunjia_user){
			seePhone(id);
			return;
		}
		jQuery.jBox("iframe:/include/agent/show_phone.jsp?id="+id,{
			title : "查看联系电话",
			width : 400,
			height : 290,
			top: '35%',
			iframeScrolling:'no' ,
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					return false;
				}
				return true;
			}
		});
	}
	function createPage(obj){
		var htm = '';
		if(obj.nowPage>1){
			htm += '<a class="pre" href="javascript:void(0);" onclick="getAgentList('+(obj.nowPage-1)+',\'search\');">&nbsp;</a>';
		}else{
			htm += '<a class="pre" style="cursor: default;">&nbsp;</a>';
		}
		var left = 0;
		var right = 0;
		var middle = obj.nowPage;
		var rightCount = 0; 
		if(obj.pageCount>10){
			rightCount = obj.pageCount - 5;
			if (middle <= 5 && middle < rightCount) {
				for(var i=0;i<5;i++){
					if((i+1)==obj.nowPage){
						htm += '<span class="current"><b>&nbsp;'+(i+1)+'&nbsp;</b></span>';
					}else{
						htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(i+1)+',\'search\');">&nbsp;'+(i+1)+'&nbsp;</a>';
					}
				}
				if(middle==5){
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+6+',\'search\');">&nbsp;'+6+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+7+',\'search\');">&nbsp;'+7+'&nbsp;</a>';
				}
				htm += '<a class="num" href="javascript:void(0);">...</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-2)+',\'search\');">&nbsp;'+(obj.pageCount-2)+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-1)+',\'search\');">&nbsp;'+(obj.pageCount-1)+'&nbsp;</a>';
			}else if( middle > 5 && middle > rightCount){
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+1+',\'search\');">&nbsp;'+1+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+2+',\'search\');">&nbsp;'+2+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);">...</a>';
				if(middle==(rightCount+1)){
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-2)+',\'search\');">&nbsp;'+(middle-2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-1)+',\'search\');">&nbsp;'+(middle-1)+'&nbsp;</a>';
				}
				for(var i = rightCount;i<obj.pageCount;i++){
						if((i+1)==obj.nowPage){
							htm += '<span class="current"><b>&nbsp;'+(i+1)+'&nbsp;</b></span>';
						}else{
							htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(i+1)+',\'search\');">&nbsp;'+(i+1)+'&nbsp;</a>';
						}
					}
				} else {
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+1+',\'search\');">&nbsp;'+1+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+2+',\'search\');">&nbsp;'+2+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);">...</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-2)+',\'search\');">&nbsp;'+(middle-2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-1)+',\'search\');">&nbsp;'+(middle-1)+'&nbsp;</a>';
					htm += '<span class="current"><b>&nbsp;'+middle+'&nbsp;</b></span>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle+1)+',\'search\');">&nbsp;'+(middle+1)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle+2)+',\'search\');">&nbsp;'+(middle+2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);">...</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-1)+',\'search\');">&nbsp;'+(obj.pageCount-1)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-0)+',\'search\');">&nbsp;'+(obj.pageCount-0)+'&nbsp;</a>';
			}
		}else{
			left = 0;
			right = obj.pageCount;
			for(var i=left;i<right;i++){
				if((i+1)==obj.nowPage){
					htm += '<span class="current" style="cursor: default;"><b>&nbsp;'+(i+1)+'&nbsp;</b></span>';
				}else{
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(i+1)+',\'search\');">&nbsp;'+(i+1)+'&nbsp;</a>';
				}
			}
		}
		if(obj.nowPage>=obj.pageCount){
			htm += '<a class="next" style="cursor: default;">&nbsp;</a>';
		}else{
			htm += '<a class="next" href="javascript:void(0);" onclick="getAgentList('+(obj.nowPage+1)+',\'search\');">&nbsp;</a>';
		}
	// 	htm += '<a href="/agent/list.jsp" target="_blank">更多>></a>';
 		jQuery("#agent_page").html(htm);
	}
	// 显示浏览记录
		setTimeout(function(){
		 	   if(jQuery.trim(jQuery("#history").html())==''){
		 	   jQuery("#tophistory").hide() ;
		 	   }
		 },1000) ;
jQuery(function(){
		 	 DisplayHistory() ;
	}) ;
function clearHistory(){
	jQuery("#tophistory").fadeOut("slow") ;
	DeleteCookie("history") ;
}
</script>
</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		DBHelper.freeConnection(conn_21sun);
	}
%>
