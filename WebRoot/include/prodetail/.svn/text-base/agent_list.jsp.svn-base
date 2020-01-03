<%@ page language="java" import="java.sql.Connection,com.jerehnet.util.dbutil.*,java.util.*,com.jerehnet.util.common.*,org.json.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache cron="*/1 * * * *">
<%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String id = CommonString.getFormatPara(request.getParameter("id"));
	String agentname = CommonString.getFormatPara(request.getParameter("agentname"));
	String factoryid=CommonString.getFormatPara(request.getParameter("factoryid"));
	 Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	if(factoryid.equals("")&&!id.equals("")){
	  factoryid=id;
	  agentname=CommonString.getFormatPara(brandMap.get(factoryid));
	}
	String catalog=CommonString.getFormatPara(request.getParameter("catalog"));
	if(catalog.length()>6){catalog=catalog.substring(0,6);}
	String ip  = Common.getIp(request);
	String nowCity = "";
	String nowProvince = "";

	String whereStr=" flag = 2 and is_show = 1";
	if(!factoryid.equals("")){whereStr+="and  (agent_fac LIKE '%"+factoryid+",%' OR agent_fac LIKE '%,"+factoryid+"%' or agent_fac = '"+factoryid+"')";}
	if(!nowProvince.equals("")){whereStr+=" and (address like '%"+nowProvince+"%'  or full_name like '%"+nowProvince+"%' or city like '%"+nowProvince+"%')";}
	try{
		connection = dbHelper.getConnection();
%>
<%		
	    List<Map> agentListFirst = dbHelper.getMapList(" select top 15 id,full_name,agent_fac_name,city,usern,telphone,is_qijiandian,is_made from pro_agent_factory where "+whereStr+"order by  is_shop desc,flag ASC , name DESC , id DESC ",connection);
%>
<link href="/plugin/tip/yitip/css/jquery.yitip.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
<script type="text/javascript" src="/plugin/area/city/citys.js"></script>
<div id="agent_list_length">
	<div class="selects" style="background-color:#F8F8F8">
	<div style="float:left;"><%=agentname%>代理商</div>
	</div>
	<ul class="agent_ti">
	  <li class="g1">代理商</li>
	  <li class="g2">代理区域</li>
	  <li class="g3">主营品牌</li>
	  <li class="g4">在线询价</li>
	  <li class="g5">联系电话</li>
	</ul>
	<div class="agent_li" id="first"> 
	  <!-- 代理商列表 -->
      <%
	   if(agentListFirst.size()>0){
	   		int i=0;
		    for(Map oneMap:agentListFirst){
	 %>
	       <ul   class="libg0<%=((i%2)+1)%>">
        <%if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/agentstore/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="http://<%=CommonString.getFormatPara(oneMap.get("usern"))%>.product.21-sun.com" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/agentshop02/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}else{%>
        <li class="g1"><a title="<%=CommonString.getFormatPara(oneMap.get("full_name"))%>" href="/agent/<%=CommonString.getFormatPara(oneMap.get("usern"))%>/" target="_blank"><%=CommonString.getFormatPara(oneMap.get("full_name"))%></a></li>
        <%}%>
        <li class="g2"><span title="<%=CommonString.getFormatPara(oneMap.get("city"))%>"><%=CommonString.getFormatPara(oneMap.get("city"))%></span></li>
        <li class="g3" ><span title="<%=CommonString.getFormatPara(oneMap.get("agent_fac_name"))%>"><%=CommonString.getFormatPara(oneMap.get("agent_fac_name"))%></span></li>
        <li class="g4"><a href="javascript:void(0);" onClick="zaiXianXunJia('<%=CommonString.getFormatPara(oneMap.get("id"))%>');">在线询价</a></li>      
	  <li class="g5" style="overflow:hidden;"><a id="seePhone_<%=CommonString.getFormatPara(oneMap.get("id"))%>" href="javascript:void(0);" onClick="lianXiDianHua('<%=CommonString.getFormatPara(oneMap.get("id"))%>');">点击查看联系电话</a></li>
      </ul>    
      <%i++;}
      %>
      </div>
      <div class="news_daili_page">
	  <div class="paging page" style="float: left;"><!-- ajax分页 --></div>
	   <div class="more_daili"><a target="_blank" href="/agent/0_0_<%=factoryid.equals("")?"0":factoryid%>_<%=catalog.equals("")?"0":catalog%>.shtm">更多<%=agentname%>代理商</a></div>
       </div> 
      <%
      }else{%>
           <div style='text-align:center;margin:10px auto;'>暂无代理商信息！</div>
     <%}%>
</div>
<script type="text/javascript">
//sunyanbin 2014-9-20 修改id
var nowBrand = '<%=factoryid %>';
var nowBrandName = '';
var nowCatalog = '';
var nowCatalogName = '';
var nowProvince = '';
var nowCity = '';
getAgentListNew(0,'search');
var loadTimes = 0;
function setNowSearch(){
	nowProvince = jQuery("#province").val();
	//nowCatalog = jQuery("#model").val();
	//nowCatalogName = document.getElementById("model").options[document.getElementById("model").selectedIndex].innerHTML;
	getAgentList(0,'search');
}
function getAgentList(nowPage,isAuto){
loadTimes++;
jQuery(".agent_li").html("<img src='/images/loading.gif' style='margin:200px 0  0 350px;' />");
jQuery(".agent_li").height(470);
var agentObj;
jQuery.ajax({
	url : "/tools/ajax.jsp",
	data : {
		flag : "agentList",
		nowPage : nowPage ,
		province : nowProvince ,
		city : nowCity ,
		brand : nowBrand ,
		orderProvince : '<%=nowCity %>',
		orderCity : '<%=nowProvince %>',
		model : nowCatalog ,
		isAuto : isAuto ,
		pageSize : 15	
	},
	type : "post",
	success : function(data){
		agentObj = eval("["+data+"]")[0];
		var agentList = agentObj.list;
		if(agentList.length==0&&loadTimes==0){
			jQuery("#agent_list_length").remove();
			return;
		}
		jQuery("#dlCount").html(agentObj.total);
		var agLi = jQuery(".agent_li");
		agLi.html("");
		var htm = '';
		var i_f = 1;
		if(agentList.length<15){
			jQuery(".agent_li").css("height","auto");
		}
		for(var i=0;i<agentList.length;i++){
			if((i%2)==0){
				i_f = 2;
			}else{
				i_f = 1;
			}
			htm += '<ul class="libg0'+i_f+'">';
			if(agentList[i].is_qijiandian==1&&agentList[i].is_made==1){ // 开通定制旗舰店
						htm += '<li class="g1"><a title="'+agentList[i].full_name+'" href="/agentstore/'+agentList[i].usern+'/" target="_blank">'+agentList[i].full_name+'</a></li>';
					}else if(agentList[i].is_qijiandian==1&&agentList[i].is_made!=1){ // 开通普通旗舰店
						htm += '<li class="g1"><a title="'+agentList[i].full_name+'" href="http://'+agentList[i].usern+'.product.21-sun.com" target="_blank">'+agentList[i].full_name+'</a></li>';
					}else if(agentList[i].is_qijiandian==2&&agentList[i].is_made!=1){ // 开通模板二旗舰店
						htm += '<li class="g1"><a title="'+agentList[i].full_name+'" href="/agentshop02/'+agentList[i].usern+'/" target="_blank">'+agentList[i].full_name+'</a></li>';
					}else{  //  普通跳转
						htm += '<li class="g1"><a title="'+agentList[i].full_name+'" href="/agent/'+agentList[i].usern+'/" target="_blank">'+agentList[i].full_name+'</a></li>';
					}
			htm += '<li class="g2"><span title="'+agentList[i].city+'">'+agentList[i].city+'</span></li>';
			htm += '<li class="g3"><span title="'+agentList[i].agent_fac_name+'">'+agentList[i].agent_fac_name+'</span></li>';
			htm += '<li class="g4"><a href="javascript:void(0);" onclick="zaiXianXunJia(\''+agentList[i].id+'\');">在线询价</a></li>';
			if(null!=agentList[i].telphone&&agentList[i].telphone!=''){
				htm += '<li class="g5" style="width:130px;overflow:hidden;"><a id="seePhone_'+agentList[i].id+'" href="javascript:void(0);" onclick="lianXiDianHua(\''+agentList[i].id+'\');">点击查看联系电话</a></li>';
			}else{
				htm += '<li class="g5" style="width:130px;overflow:hidden;"><a class="gcur" href="javascript:void(0);">暂无联系方式</a></li>';
			}
			htm += '</ul>';
		}
		agLi.html(htm);
		jQuery(".paging").html("");
		if(jQuery.trim(htm)!=''){
			createPage(agentObj);
		}else{
			alert("暂无代理商信息");
			jQuery(".agent_li").html("<div style='text-align:center;margin:10px auto;'>暂无代理商信息！</div>");
		}
		jQuery("#treev1").height(jQuery(".w757").height()-120);
		//setHover();
	}
});
	function setHover(){
  		 jQuery(".agent_li ul").hover(function(){
			jQuery(this).toggleClass("a_hover");
		},function(){
			jQuery(this).removeClass("a_hover");
		});
  	}
	function createPage(obj){
		var htm = '';
		if(obj.nowPage>1){
			htm += '<a class="pre" href="javascript:void(0);" onclick="getAgentList('+(obj.nowPage-1)+',\'search\');">&nbsp;</a>';
		}else{
			htm += '<a class="pre" href="javascript:void(0);" style="cursor: default;">&nbsp;</a>';
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
				htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-1)+',\'search\');">&nbsp;'+(obj.pageCount-1)+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-0)+',\'search\');">&nbsp;'+(obj.pageCount-0)+'&nbsp;</a>';
			}else if( middle > 5 && middle > rightCount){
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+1+',\'search\');">&nbsp;'+1+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+2+',\'search\');">&nbsp;'+2+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
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
					htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-2)+',\'search\');">&nbsp;'+(middle-2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-1)+',\'search\');">&nbsp;'+(middle-1)+'&nbsp;</a>';
					htm += '<span class="current"><b>&nbsp;'+middle+'&nbsp;</b></span>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle+1)+',\'search\');">&nbsp;'+(middle+1)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle+2)+',\'search\');">&nbsp;'+(middle+2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-1)+',\'search\');">&nbsp;'+(obj.pageCount-1)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-0)+',\'search\');">&nbsp;'+(obj.pageCount-0)+'&nbsp;</a>';
			}
		}else{
			left = 0;
			right = obj.pageCount;
			for(var i=left;i<right;i++){
				if((i+1)==obj.nowPage){
					htm += '<span class="current"><b>&nbsp;'+(i+1)+'&nbsp;</b></span>';
				}else{
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(i+1)+',\'search\');">&nbsp;'+(i+1)+'&nbsp;</a>';
				}
			}
		}
		if(obj.nowPage>=obj.pageCount){
			htm += '<a class="next" href="javascript:void(0);" style="cursor: default;">&nbsp;</a>';
		}else{
			htm += '<a class="next" href="javascript:void(0);" onclick="getAgentList('+(obj.nowPage+1)+',\'search\');">&nbsp;</a>';
		}
		jQuery(".paging").html(htm);
	}
	}
function getAgentListNew(nowPage,isAuto){
loadTimes++;
var agentObj;
jQuery.ajax({
	url : "/tools/ajax.jsp",
	data : {
		flag : "agentList",
		nowPage : nowPage ,
		province : nowProvince ,
		city : nowCity ,
		brand : nowBrand ,
		orderProvince : '<%=nowCity %>',
		orderCity : '<%=nowProvince %>',
		model : nowCatalog ,
		isAuto : isAuto ,
		pageSize : 15	
	},
	type : "post",
	success : function(data){
		agentObj = eval("["+data+"]")[0];
		var agentList = agentObj.list;
		var htm = '';
		var i_f = 1;
		jQuery(".paging").html("");
		createPageNew(agentObj);
		jQuery("#treev1").height(jQuery(".w757").height()-120);
		setHover();
	}
});
	function createPageNew(obj){
		var htm = '';
		if(obj.nowPage>1){
			htm += '<a class="pre" href="javascript:void(0);" onclick="getAgentList('+(obj.nowPage-1)+',\'search\');">&nbsp;</a>';
		}else{
			htm += '<a class="pre" href="javascript:void(0);" style="cursor: default;">&nbsp;</a>';
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
				htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-1)+',\'search\');">&nbsp;'+(obj.pageCount-1)+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-0)+',\'search\');">&nbsp;'+(obj.pageCount-0)+'&nbsp;</a>';
			}else if( middle > 5 && middle > rightCount){
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+1+',\'search\');">&nbsp;'+1+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+2+',\'search\');">&nbsp;'+2+'&nbsp;</a>';
				htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
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
					htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-2)+',\'search\');">&nbsp;'+(middle-2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle-1)+',\'search\');">&nbsp;'+(middle-1)+'&nbsp;</a>';
					htm += '<span class="current"><b>&nbsp;'+middle+'&nbsp;</b></span>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle+1)+',\'search\');">&nbsp;'+(middle+1)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(middle+2)+',\'search\');">&nbsp;'+(middle+2)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" style="cursor: default;border:none;color:#000;">...</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-1)+',\'search\');">&nbsp;'+(obj.pageCount-1)+'&nbsp;</a>';
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(obj.pageCount-0)+',\'search\');">&nbsp;'+(obj.pageCount-0)+'&nbsp;</a>';
			}
		}else{
			left = 0;
			right = obj.pageCount;
			for(var i=left;i<right;i++){
				if((i+1)==obj.nowPage){
					htm += '<span class="current"><b>&nbsp;'+(i+1)+'&nbsp;</b></span>';
				}else{
					htm += '<a class="num" href="javascript:void(0);" onclick="getAgentList('+(i+1)+',\'search\');">&nbsp;'+(i+1)+'&nbsp;</a>';
				}
			}
		}
		if(obj.nowPage>=obj.pageCount){
			htm += '<a class="next" href="javascript:void(0);" style="cursor: default;">&nbsp;</a>';
		}else{
			htm += '<a class="next" href="javascript:void(0);" onclick="getAgentList('+(obj.nowPage+1)+',\'search\');">&nbsp;</a>';
		}
		jQuery(".paging").html(htm);
	}
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
			province : '<%=nowProvince %>',
			catalog : xunjia_catalog,
			catalogName : xunjia_catalog_name,
			brand : xunjia_brand ,
			brandName : xunjia_brand_name ,
			city : '<%=nowCity %>',
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

</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
</cache:cache>