<%@page contentType="text/html;charset=utf-8" import="java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*,org.json.*" %>

<link href="/plugin/tip/yitip/css/jquery.yitip.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="/plugin/tip/yitip/jquery.yitip.js"></script>
<script type="text/javascript" src="/plugin/area/city/citys.js"></script>
 
      <div class="fix jxs_search">
        <div class="jxs_search_map" id="baiduMap" style="width:530px;height:483px;" >  </div>
      </div>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js"></script>
<script type="text/javascript">
	
//标注点数组
var markerArr = [{title:"上海分公司",flag:"1",content:"地址：上海宝山国际汽配城宝山区友谊路1500号<br />电话：021-51267776　51267778<br />传真：021-51267779",point:"121.463989|31.401273",isOpen:0,icon:{w:23,h:25,l:46,t:21,x:9,lb:12}}];
//创建和初始化地图函数：
function initMap(){
	createMap();//创建地图
	setMapEvent();//设置地图事件
	addMapControl();//向地图添加控件
	addMarker();//向地图中添加marker
	console.log('add map');
}
//创建地图函数：
function createMap(){
	var map = new BMap.Map("baiduMap");//在百度地图容器中创建一个地图
	var point = new BMap.Point(123.368155,42.007252);//定义一个中心点坐标
	map.centerAndZoom(point,7);//设定地图的中心点和坐标并将地图显示在地图容器中
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
	console.log('add point');
		var json = markerArr[i];
		var p0 = json.point.split("|")[0];
		var p1 = json.point.split("|")[1];
		var point = new BMap.Point(p0,p1);
		var iconImg ;
        iconImg="/web/img/zuobiao02.png";		
		iconImg = new BMap.Icon(iconImg, new BMap.Size(20, 29)); 

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
