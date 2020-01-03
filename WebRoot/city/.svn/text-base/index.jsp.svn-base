<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="org.apache.solr.common.SolrDocumentList"%>
<%@ page import="org.apache.solr.common.SolrDocument"%>
<%@ page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@ page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@ page import="org.apache.solr.client.solrj.impl.HttpSolrServer"%>
<%@ page language="java" import="java.sql.Connection,java.util.*,com.jerehnet.util.common.*,com.jerehnet.webservice.*" pageEncoding="UTF-8"%>
<%@ page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;

	String areapy = CommonString.getFormatPara(request.getParameter("areapy"));
	areapy="shandong";
	String areaName = (String)dbHelper.getOne(" select name from pro_agent_province_city where areapy = '"+ areapy +"'") ;
	String sql=" select full_name,telphone,address,lng,lat from pro_agent_factory where is_show = 1 and city like '%" + areaName + "%' and address like '%" + areaName + "%' and lng is not null and lng !='' and lat is not null and lat !=''";
	List<Map> pointRs = dbHelper.getMapList(sql);
	String citys = "'北京','上海','广州','天津','杭州','深圳','济南','南京','福州','青岛','苏州','东莞','太原','宁波','佛山','石家庄','合肥','南昌','长春','成都','郑州','沈阳','重庆','武汉','哈尔滨','西安','长沙','大连','昆明','南宁','兰州','扬州','牡丹江','西宁','海口'";//,'呼和浩特'
	/*
	List<Map> hotcitypyList = (List<Map>)dbHelper.getMapList("SELECT a.name,CASE when b.areapy is null then a.areapy else b.areapy end parent_areapy from pro_agent_province_city a "+ 
			"LEFT JOIN pro_agent_province_city b  on a.parent_num=b.num "+
			"where a.name in ("+citys+")") ;
	*/
	List<Map> hotcitypyList = (List<Map>)dbHelper.getMapList("SELECT name,areapy as parent_areapy from pro_agent_province_city "+
			"where name in ("+citys+")") ;
%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>工程机械城市大全_全国热门城市 - 铁臂城市</title>
<meta name="keywords" content="工程机械地区信息" />
<meta name="description" content="铁臂城市，为您提供全国各个城市工程机械信息，包括地区工程机械代理商，地区工程机械资讯，地区热销工程机械产品，方便您在自己的城市找到心仪的产品，买工程机械产品就上铁臂商城。" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<link href="/style/style.css" rel="stylesheet" />
<link href="/style/city.css" rel="stylesheet" />
<link href="/agent_new/style/style.css" rel="stylesheet" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>
<script type="text/javascript">
//导航选中状态
var jrChannel='3#0'
</script>
<script>
//标注点数组
var markerArr = [
<%
				if (null != pointRs && pointRs.size() > 0) {
						for (int i = 0;i<pointRs.size();i++) {
							String full_name = CommonString.getFormatPara(pointRs.get(i).get("full_name"));
							String lng = CommonString.getFormatPara(pointRs.get(i).get("lng"));
							String lat = CommonString.getFormatPara(pointRs.get(i).get("lat"));	
							String telphone = CommonString.getFormatPara(pointRs.get(i).get("telphone"));	
							String address = CommonString.getFormatPara(pointRs.get(i).get("address"));	
%>
	{title:'<%=full_name%>',content:"<%if(address != null && address != ""){%>地址：<%=address%><%}%><br/><%if(telphone != null && telphone != ""){%>电话：<%=telphone%><%}%>",point:"<%=lng%>|<%=lat%>",isOpen:0,icon:{w:23,h:25,l:46,t:21,x:9,lb:12}}
		<%if(i<pointRs.size()){%>,<%}%>
<%}}%>	
];
markerArr=[];
</script>

</head>
<body class="city_body" >
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--top end-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂城市 </a><div style="display:none"> &gt;&gt; <a href="#"><%=areaName%></a></div></h3>
</div>
<div class="contain980 fix mb20">
	<div class="city_cx">
    	<div class="bdt fix">
        	<h3>城市查询</h3>
        </div>
        <div class="hdn fix">
        	<div class="citycx_map" id="map"></div>
            <div class="citycx_hot">
            	<div class="htt">热门城市直达</div>
                <div class="city_hot">
                	<ul class="fix city_hotlist">
                	<%
						if (null != hotcitypyList && hotcitypyList.size() > 0) {
						for (Map m:hotcitypyList) {
							String hotcityname = CommonString.getFormatPara(m.get("name"));
							String hotcitypy = CommonString.getFormatPara(m.get("parent_areapy"));
					%>
                        <li><a href="http://city.21-sun.com/<%=hotcitypy%>/"><%=hotcityname %></a></li>
                    <%}} %>    
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="contain980 agent_area fix">
<!-- -->
<jsp:include page="arealist.jsp" flush="true" />
<!-- -->
</div>
<!--foot-->
<div class="foot_box">
<jsp:include page="/include/foot.jsp" flush="true" />
</div>
<!--foot end-->
</body>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="/scripts/idTabs.js"></script>
<script type="text/javascript">
$(".idTabs").idTabs("!mouseover");
</script>

<script src="/internet/scripts/comm.js"></script>

<script type="text/javascript">
//创建和初始化地图函数：
function initMap(){
	createMap();//创建地图
	setMapEvent();//设置地图事件
	addMapControl();//向地图添加控件
	addMarker();//向地图中添加marker
}
//创建地图函数：
function createMap(){
	var map = new BMap.Map("map");//在百度地图容器中创建一个地图
	var point = new BMap.Point(104.114129,37.550339);//定义一个中心点坐标
	map.centerAndZoom(point,5);//设定地图的中心点和坐标并将地图显示在地图容器中
	window.map = map;//将map变量存储在全局
}
//地图事件设置函数：
function setMapEvent(){
	map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
	map.enableScrollWheelZoom();//启用地图滚轮放大缩小
	map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
	map.enableKeyboard();//启用键盘上下左右键移动地图
}
//地图控件添加函数：
function addMapControl(){
	//向地图中添加缩放控件
	var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_SMALL});
	map.addControl(ctrl_nav);
	//向地图中添加比例尺控件
	var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
	map.addControl(ctrl_sca);
}
//创建marker
function addMarker(){
	for(var i=0;i<markerArr.length;i++){
		var json = markerArr[i];
		var p0 = json.point.split("|")[0];
		var p1 = json.point.split("|")[1];
		var point = new BMap.Point(p0,p1);
		var iconImg = createIcon(json.icon);
		var marker = new BMap.Marker(point,{icon:iconImg});
		var iw = createInfoWindow(i);
		map.addOverlay(marker);
		(function(){
			var index = i;
			var _iw = createInfoWindow(i);
			var _marker = marker;
			_marker.addEventListener("click",function(){
				map.centerAndZoom(point,12);
				this.openInfoWindow(_iw);
			});
		})()
	}
}
//创建InfoWindow
function createInfoWindow(i){
	var json = markerArr[i];
	var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.title + "'>" + json.title + "</b><div class='iw_poi_content'>"+json.content+"</div>");
	return iw;
}
//创建一个Icon
function createIcon(json){
	var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w,json.h),{imageOffset: new BMap.Size(-json.l,-json.t),infoWindowOffset:new BMap.Size(json.lb+5,1),offset:new BMap.Size(json.x,json.h)})
	return icon;
}
//创建和初始化地图
initMap();



</script>


</html>