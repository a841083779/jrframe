<%@ page language="java" import="org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%><%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String ip  = request.getHeader("x-forwarded-for");
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("X-Real-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getHeader("WL-Proxy-Client-IP");
	}
	if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
		ip = request.getRemoteAddr();
	}
	try{
		connection = dbHelper.getConnection();
		Object [] pArr = WEBServiceUtil.executeDynamic("Area","getMyProvinceAndCity",new Object [] {
				ip
		});
		String objStr = (String)pArr[0];
		JSONObject obj = new JSONObject(objStr);
		String city = "";
		String province = "";
		if(null!=obj&&obj.length()>0){
			province = CommonString.getFormatPara(obj.getString("province"));
			city = CommonString.getFormatPara(obj.getString("city"));
		}
		List<Map> brands = dbHelper.getMapList(" select id,name from pro_agent_factory where flag = 1 and is_show = 1 ",connection);
		String name = "";
		String pinyin = "";
		for(Map m : brands){
			name = CommonString.getFormatPara(m.get("name"));
			pinyin = CnToFullSpell.getFirstSpell(name).substring(0,1);
			m.put("pinyin",pinyin);
		}
		Collections.sort(brands,new java.util.Comparator(){
			public int compare(Object o1, Object o2) {
				Map m1 = (Map)o1;
				Map m2 = (Map)o2;
				return m1.get("pinyin").toString().compareTo(m2.get("pinyin").toString());
			}
		});
		LinkedHashMap brandMap = new LinkedHashMap();
		for(Map m : brands){
			pinyin = CommonString.getFormatPara(m.get("pinyin"));
			if(pinyin.matches("[A-Z]")){
				brandMap.put(CommonString.getFormatPara(m.get("id")), pinyin+ " " + CommonString.getFormatPara(m.get("name")));
			}
		}
		List<Map> catalogs = dbHelper.getMapList(" select id,name,num from pro_catalog where len(num) = 3 ",connection);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>【<%=province %><%=city %>工程机械代理商|挖掘机代理商】 - 中国工程机械商贸网</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="工程机械代理商,挖掘机代理商" />
<meta name="description" content="找工程机械代理商，挖掘机代理商信息尽在中国工程机械商贸网产品中心。" /> 
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/plugin/tip/yitip/css/jquery.yitip.css" rel="stylesheet" type="text/css" />
<link href="../style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="../scripts/scripts.js"></script>
<script type="text/javascript" src="../scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="../scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="../scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/area/city/citys.js"></script>
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body>
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--面包屑-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"> 您现在所在的位置： <a href="/">工程机械产品中心</a> &gt;&gt; <a href="/agent/">代理商专区</a></h3>
</div>
<!--面包屑结束--> 
<!--main-->
<div class="contain980 mb10" style="margin-bottom: 0px;">
<!--left-->

	<jsp:include page="/include/agent/left.jsp" flush="true">
		<jsp:param name="province" value="<%=province %>" />
		<jsp:param name="city" value="<%=city %>" />
	</jsp:include>
<!--left end--> 
<!--right-->
<div class="w757 r mb10">
  <div class="selects">
    <%
    	if(!"".equals(city)){
    		%>
    		<div class="local" style="margin-right: 0px;"><strong>目前所在：</strong> <%=city %></div>
    		<%
    	}else if(!"".equals(province)){
    		%>
    		<div class="local" style="margin-right: 0px;"><strong>目前所在：</strong> <%=province %></div>
    		<%
    	}
    %>
    <div class="selectes_c" style="margin-left: 15px;">
      选项：
        <select name="province" id="province" onchange="set_city(this,this.value,document.getElementById('city'),'');" style="width: 100px;">
          <option value="">--省份--</option>
          <script type="text/javascript">
          	for(var c in cities){
          		document.write("<option value='"+c+"'>"+c+"</option>");
          	}
          </script>
        </select>
        <select name="city" id="city" style="width: 100px;">
          <option value="">--城市--</option>
        </select>
        <select name="brand" id="brand" style="width: 100px;">
          <option value="">--品牌--</option>
          <%=CommonForm.createSelect(brandMap,"") %>
        </select>
        <select name="model" id="model" style="width: 100px;">
          <option value="">--类型--</option>
          <%
         	List<Map> sub_catalogs = null;
	  		for(Map m : catalogs){
	  			sub_catalogs = dbHelper.getMapList(" select id,name,num from pro_catalog where len(num) = 6 and num like '"+m.get("num")+"%' ",connection);
	  			%><option value="<%=m.get("num") %>"><%=m.get("name") %></option><%
	  			if(null!=sub_catalogs&&sub_catalogs.size()>0){
	  				for(Map m1 : sub_catalogs){
	  					%><option value="<%=m1.get("num") %>">&nbsp;&nbsp;&nbsp;&nbsp;<%=m1.get("name") %></option><%
	  				}
	  			}
	  		}
          %>
        </select>
        <input type="button" name="button2" id="button2" value="搜索" class="selectBtn" onclick="doAgentSearch();" />
    </div>
  </div> 
  <div class="a_agent_tab">
    <ul>
      <li><a href="javascript:void(0);" class="selected"><%=province %><%=city %>代理商</a></li>
      <li style="display: none;"><a href="#">地图查看</a></li>
    </ul>
  </div>
  <ul class="agent_ti">
    <li class="g1">代理商</li>
    <li class="g2">代理区域</li>
    <li class="g3">主营品牌</li>
    <li class="g4">在线询价</li>
    <li class="g5">联系电话</li>
  </ul>
  
  <div class="agent_li" style="height: 311px;"><!-- 代理商列表 --></div>
  <div class="paging page" style="float: left;width: 600px;"><!-- ajax分页 --></div>
    
    <script type="text/javascript">
    var nowBrand = '';
    var nowBrandName = '';
	var nowCatalog = '';
	var nowCatalogName = '';
	var nowProvince = '<%=province %>';
	var nowCity = '<%=city %>';
    function doAgentSearch(){
    	if(jQuery("#province").val()==''&&jQuery("#city").val()==''&&jQuery("#brand").val()==''&&jQuery("#model").val()==''){
    		alert("请选择搜索条件！");
    		return;
    	}
    	var url = "list.jsp?province="+encodeURI(jQuery("#province").val())+"&city="+encodeURI(jQuery("#city").val());
    	url += "&brand="+jQuery("#brand").val()+"&model="+jQuery("#model").val();
    	if(jQuery("#brand").val()!=''){
    		url += "&brandName="+document.getElementById("brand").options[document.getElementById("brand").selectedIndex].innerHTML;
    	}
    	if(jQuery("#model").val()!=''){
    		var mName = document.getElementById("model").options[document.getElementById("model").selectedIndex].innerHTML;
    		mName = mName.replace("&nbsp;","");
    		mName = mName.replace("&nbsp;","");
    		mName = mName.replace("&nbsp;","");
    		mName = mName.replace("&nbsp;","");
    		url += "&catalogName="+mName;
    	}
    	window.location.href = url;
    }
    function setBrand(brand,brandName){
    	window.location.href = "list.jsp?brand="+brand+"&brandName="+brandName;
    }
    function setCatalog(catalog,catalogName){
    	window.location.href = "list.jsp?model="+catalog+"&catalogName="+catalogName;
    }
  	getAgentList(0,'search');
  	function setHover(){
  		 jQuery(".agent_li ul").hover(function(){
			jQuery(this).toggleClass("a_hover");
		},function(){
			jQuery(this).removeClass("a_hover");
		});
  	}
  	function getAgentList(nowPage,isAuto){
  		if(nowBrand!=null||nowBrand!=''){
  			jQuery("#brand").val(nowBrand);
  		}
  		jQuery(".agent_li").html("<img src='/images/loading.gif' style='margin:130px 0 0 350px;' />");
		var agentObj;
		jQuery.ajax({
			url : "/tools/ajax.jsp",
			data : {
				flag : "agentList",
				nowPage : nowPage ,
				province : nowProvince ,
				city : nowCity ,
				brand : nowBrand ,
				model : nowCatalog ,
				isAuto : isAuto				
			},
			type : "post",
			success : function(data){
				agentObj = eval("["+data+"]")[0];
				var agentList = agentObj.list;
				var agLi = jQuery(".agent_li");
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
					htm += '<li class="g1"><a title="'+agentList[i].full_name+'" href="/agent/'+agentList[i].usern+'/" target="_blank">'+agentList[i].full_name+'</a></li>';
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
					jQuery(".agent_li").html("<div style='text-align:center;margin:10px auto;'>暂无代理商信息！</div>");
				}
				setHover();
			}
		});
	}
	function zaiXianXunJia(id){
		jQuery.jBox("iframe:/include/agent/enquiry.jsp?id="+id,{
			title : "在线询价",
			width : 550,
			height : 360,
			top: '25%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					if(subSr){
						seePhone(id);
					}
					return subSr;
				}
			}
		});
	}
	function seePhone(id){
		jQuery.post("/tools/ajax.jsp",{
			flag : 'seePhone',
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
		jQuery.post("/tools/ajax.jsp",{flag:'viewPhoneClickCount',id:id});
		jQuery.jBox("iframe:/include/agent/show_phone.jsp?id="+id,{
			title : "查看联系电话",
			width : 400,
			height : 200,
			top: '35%',
			buttons : {"确定":true,"关闭":false},
			submit : function(v,h,f){
				if(v){
					var ifrm = jQuery.jBox.getIframe();
					var subSr = ifrm.contentWindow.doSub();
					if(subSr){
						seePhone(id);
					}
					return subSr;
				}
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
		jQuery(".paging").html(htm);
	}
  </script>
  
  <div class="agent_part">
    <div class="title">
      <h3>代理商推荐</h3>
      <span class="more"><a href="list.jsp">更多&gt;&gt;</a></span>
    </div>
    <div class="content">
      <ul class="hotAgent">
        <li>
          <div class="img"><a href="/agentshop/dingfengjixie/"><img src="http://product.21-sun.com/uploadfiles/image/2012/11/20121117113124_82.jpg" alt="浙江成峰工程机械有限公司" width="120" height="90" /></a></div>
          <h3><a href="/agentshop/dingfengjixie/" title="浙江成峰工程机械有限公司">浙江成峰工程机械有限</a></h3>
          <div class="a_brand"><a href="/agentshop/dingfengjixie/" title="三一">三一</a></div>
        </li>
        <li>
          <div class="img"><a href="/agentshop/jzlg/"><img src="http://product.21-sun.com/uploadfiles/image/2012/09/20120905174729_403.jpg" alt="武汉九州龙工程机械有限公司" width="120" height="90" /></a></div>
          <h3><a href="/agentshop/jzlg/" title="武汉九州龙工程机械有限公司">武汉九州龙工程机械有</a></h3>
          <div class="a_brand"><a href="/agentshop/jzlg/" title="三一">三一</a></div>
        </li>
        <li>
          <div class="img"><a href="/agent/nmgrq/"><img src="http://product.21-sun.com/uploadfiles/image/2012/09/20120906101026_381.jpg" alt="内蒙古日强建筑机械有限责任公司" width="120" height="90" /></a></div>
          <h3><a href="/agent/nmgrq/" title="内蒙古日强建筑机械有限责任公司">内蒙古日强建筑机械有</a></h3>
          <div class="a_brand"><a href="/agent/nmgrq/" title="日立建机">日立建机</a></div>
        </li>
        <li>
          <div class="img"><a href="/agent/lxh/"><img src="http://product.21-sun.com/uploadfiles/image/2012/09/20120917115734_628.jpg" alt="利星行机械有限公司" width="120" height="90" /></a></div>
          <h3><a href="/agent/lxh/" title="利星行机械有限公司">利星行机械有限公司</a></h3>
          <div class="a_brand"><a href="/agent/lxh/" title="卡特彼勒">卡特彼勒</a></div>
        </li>
      </ul>
    </div>
  </div>
  
  <div class="agent_part">
    <div class="title">
      <h3>品牌代理商推荐</h3>
      <span class="more"><a href="list.jsp">更多&gt;&gt;</a></span>
    </div>
    <div class="content">
      <div class="agentList">
      
        <div class="al"><a title="山重代理商" href="http://product.21-sun.com/agent/list.jsp?factory=152" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/shanz.gif"></a>
          <h3><a href="/agent/list.jsp?factory=152" target="_blank">山重代理商</a></h3>
          <ul>
            <li><a target="_blank" href="http://product.21-sun.com/agent/ynsz/">云南山重工程机械有限公司</a></li>
            <li><a target="_blank" href="http://product.21-sun.com/agent/xjsz/">新疆山重建设机械有限公司</a></li>
            <li><a target="_blank" href="http://product.21-sun.com/agent/scsz/">四川山重机械有限公司</a></li>
            <li><a target="_blank" href="http://product.21-sun.com/agent/sxmz/">陕西明志山重工程机械有限公司</a></li>
            <li><a target="_blank" href="http://product.21-sun.com/agent/sdts/">山东泰盛机电设备有限公司</a></li>
          </ul>
          <div class="more"><a target="_blank" href="http://product.21-sun.com/agent/list.jsp?factory=152">查看更多&gt;&gt;</a></div>
        </div>
        
        <div class="al"><a title="沃尔沃代理商" href="http://product.21-sun.com/agent/list.jsp?factory=175" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz02.gif"></a>
          <h3><a href="/agent/list.jsp?factory=175" target="_blank">沃尔沃代理商</a></h3>
          <ul>
	        <li><a target="_blank" href="/agent/bjrsj/">北京融世杰机械设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/whzn/">武汉中南工程机械设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/jnty/">济南天业工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/lagc/">辽宁辽鞍工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/znhx/">广州中南华星设备有限公司</a></li>
	      </ul>
          <div class="more"><a target="_blank" href="http://product.21-sun.com/agent/list.jsp?factory=175">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="小松代理商" href="http://product.21-sun.com/agent/list.jsp?factory=182" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz03.gif"></a>
          <h3><a href="/agent/list.jsp?factory=182" target="_blank">小松代理商</a></h3>
          <ul>
	        <li><a target="_blank" href="/agent/ahxs/">安徽小松工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/fjxs/">福建小松工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/sxxs/">山西小松工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/ccxs/">长春小松工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/whxs/">武汉小松工程机械有限公司</a></li>
	      </ul>
          <div class="more"><a target="_blank" href="http://product.21-sun.com/agent/list.jsp?factory=182">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="柳工代理商" href="http://product.21-sun.com/agent/list.jsp?factory=136" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/liugong.gif"></a>
          <h3><a href="/agent/list.jsp?factory=136" target="_blank">柳工代理商</a></h3>
	<ul>
        <li><a target="_blank" href="/agent/keyuan/">南京科源机械有限公司</a></li>
        <li><a target="_blank" href="/agent/hblg/">河北柳工机械贸易有限公司</a></li>
        <li><a target="_blank" href="/agent/lngl/">辽宁桂柳机械设备有限公司</a></li>
        <li><a target="_blank" href="/agent/hualiu/">安徽华柳工程机械有限责任公司 </a></li>
        <li><a target="_blank" href="/agent/gongli/">徐州工力路桥机械设备有限公司</a></li>
      </ul>
          <div class="more"><a target="_blank" href="http://product.21-sun.com/agent/list.jsp?factory=136">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="神钢代理商" href="http://product.21-sun.com/agent/list.jsp?factory=183" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz05.gif"></a>
          <h3><a href="/agent/list.jsp?factory=183" target="_blank">神钢代理商</a></h3>
		<ul>
        <li><a target="_blank" href="/agent/hfjixie/">四川汇发机械设备有限公司</a></li>
        <li><a target="_blank" href="/agent/ahly/">安徽力源工程机械限责任公司</a></li>
        <li><a target="_blank" href="/agent/ahny/">安徽南亚工程机械有限公司</a></li>
        <li><a target="_blank" href="/agent/hnlj/">湖南励骏机械设备有限公司</a></li>
        <li><a target="_blank" href="/agent/hfjixie/">汇发机械集团</a></li>
      </ul>
          <div class="more"><a target="_blank" href="http://product.21-sun.com/agent/list.jsp?factory=183">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="徐工代理商" href="http://product.21-sun.com/agent/list.jsp?factory=209" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz06.gif"></a>
          <h3><a href="/agent/list.jsp?factory=209" target="_blank">徐工代理商</a></h3>
			<ul>
	        <li><a target="_blank" href="/agent/lnyuhua/">辽宁裕华机电设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/hrbzhongcheng/">哈尔滨市中成机械设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/bjrtd/">北京瑞泰达机械设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/tajw/">泰安市巨威工程机械设备有限公司</a></li>
	        <li><a target="_blank" href="/agent/qdstd/">青岛森泰达工程机械有限公司</a></li>
	      </ul>
          <div class="more"><a target="_blank" href="http://product.21-sun.com/agent/list.jsp?factory=209">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="三一代理商" href="http://product.21-sun.com/agent/list.jsp?factory=133" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz07.gif"></a>
          <h3><a href="/agent/list.jsp?factory=133" target="_blank">三一代理商</a></h3>
		   <ul>
	        <li><a target="_blank" href="/agent/hnzw/">湖南中旺工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/hfxy/">合肥湘元工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agentshop/jzlg/">武汉九州龙工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/tyjj/">太原建机工程有限公司</a></li>
	        <li><a target="_blank" href="/agentshop/dingfengjixie/">浙江成峰工程机械有限公司</a></li>
	      </ul>
          <div class="more"><a target="_blank" href="http://product.21-sun.com/agent/list.jsp?factory=133">查看更多&gt;&gt;</a></div>
        </div>
        <div class="al"><a title="现代代理商" href="http://product.21-sun.com/agent/list.jsp?factory=193" target="_blank"><img width="141" height="36" class="aimg" src="http://product.21-sun.com/images/biaoz08.gif"></a>
          <h3><a href="/agent/list.jsp?factory=193" target="_blank">现代代理商</a></h3>
		  <ul>
	        <li><a target="_blank" href="/agent/gxxd/">广西现代星工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/jshr/">江苏恒日工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/hbhc/">河北惠诚工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/bjps/">北京排山工程机械有限公司</a></li>
	        <li><a target="_blank" href="/agent/shandongjunda/">山东骏大工程机械有限公司</a></li>
	      </ul>
          <div class="more"><a target="_blank" href="http://product.21-sun.com/agent/list.jsp?factory=193">查看更多&gt;&gt;</a></div>
        </div>
      </div>
    </div>
  </div>
  
</div>
<!--right end-->
<div class="clear"></div>
</div>
<!--main end--> 
<!--foot--> 
<jsp:include page="/include/foot.jsp" flush="true" />
</body>
</html>
<script type="text/javascript">
var sz_flag = false;
jQuery(window).scroll(function(){
	var sH = jQuery(window).scrollTop();
	var dH = jQuery(document).height()-160-530;
	var dH1 = jQuery(document).height()-131-670;
	if(sH>200){
		jQuery("#smartFloat").addClass("sfocus");
		if(!sz_flag){
			var wH = jQuery(window).height()-jQuery(".leftTab").height()-jQuery(".treeSubNavv1").height()-5;
			jQuery("#treev1").height(wH);
			jQuery("#agent_tab02").height(wH+88);
		}
		sz_flag = true;
		if(sH>dH1){
			var _w = jQuery(window).height()-131-150+(965-sH);
			if(jQuery.browser.msie){
				_w = jQuery(window).height()-131-150+(1000-sH);
			}
			jQuery("#treev1").height(_w);
			jQuery("#agent_tab02").height(_w+86);
			sz_flag = false;
		}
	}else{
		jQuery("#smartFloat").removeClass("sfocus");
	}
});
</script>
<script type="text/javascript" src="../scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="../scripts/sort.js"></script> 
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>