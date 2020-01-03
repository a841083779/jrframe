<%@page contentType="text/html;charset=utf-8" import="java.sql.Connection,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.util.*,org.json.*" %>
<%
	DBHelper dbHelper = DBHelper.getInstance();
	Connection connection = null;
	String province=CommonString.getFormatPara(request.getParameter("province"));
	String provinceid=CommonString.getFormatPara(request.getParameter("provinceid"));
	String city=CommonString.getFormatPara(request.getParameter("city"));
	String factoryid=CommonString.getFormatPara(request.getParameter("factoryid"));
	Map brandMap = (HashMap)application.getAttribute("brandMap") ;
	 String factoryname=CommonString.getFormatPara(brandMap.get(factoryid));
	String where="";
	if(!province.equals("")&&!city.equals("")){
	where=" and city like '%"+province+"%' and address like '%"+city+"%'  ";
	}
	
	try{
		connection = dbHelper.getConnection();
		//地区（省）
		List<Map> areas = dbHelper.getMapList(" SELECT area_id,area_name FROM comm_area WHERE parent_area_id = 0 ",connection);
	
	    List<Map> agentListFirst = dbHelper.getMapList(" select  name,full_name,lng,lat,city,address,telphone,concatus from pro_agent_factory where agent_fac like'%"+factoryid+"%' "+where,connection);
      
  	    List<Map> agentListSecond	 = new ArrayList();   
		 if(agentListFirst.size()==0){agentListSecond=dbHelper.getMapList(" select top 10  name,full_name,lng,lat,city,address,telphone,concatus from pro_agent_factory where agent_fac like'%"+factoryid+"%' ",connection);}
	    
	   List<Map> list = new ArrayList();
%>
<link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.css" />
      <div class="fix jxs_search" id="removeAll">
        <div class="jxs_search_map" id="baiduMap" style="width:530px;height:483px;" >  </div>
        <div class="jxs_search_result fix">
            <form name="netform" id="netform" method="post" action="">
            <div class="pr fix jxs_filter">
              <select style="width:98px;"  name="zd_provincess" id="zd_provincess" onChange="set_myy_city(this);" >
			  <option value="<%=province %>" area_id="<%=provinceid%>"><%=province%></option>
         				
			   
			  <%
         			if(null!=areas&&areas.size()>0){
         				for(Map m : areas){
         					%><option value="<%=CommonString.getFormatPara(m.get("area_name")) %>" area_id="<%=CommonString.getFormatPara(m.get("area_id")) %>"><%=CommonString.getFormatPara(m.get("area_name")) %></option><%
         				}
         			}
         		%>
			  </select>
             <select  name="zd_city" id="zd_city"  style="width:100px;"  onChange="getNewsMessages('<%=factoryid%>')">
             <option value="<%=city%>" ><%=city%></option>
             </select>            
            </div>
            <input type="hidden" name="serAddress" id="serAddress" value="山东">
            <input type="hidden" name="serPlace" id="serPlace" value="">
            <input type="hidden" name="channelName" id="channelName" value="">
          </form>
          <div class="pannel">
            <div class="scrollbar pr oh">
              <div class="scroll_c">
                <div id="jxs_result">
				<%
				if(agentListFirst!=null&&agentListFirst.size()>0){
				%>
                  <ul class="jxs_result_list">
				  <%
				  for(Map newsmap:agentListFirst){
				  
				  %>
                    <li> <strong title="<%=CommonString.getFormatPara(newsmap.get("full_name"))%>" class="t m1"><%=CommonString.getFormatPara(newsmap.get("full_name"))%></strong>
                      <div class="p">地区：<%=CommonString.getFormatPara(newsmap.get("city"))%><br>
                        地址：<%=CommonString.getFormatPara(newsmap.get("address"))%><br>
                        电话：<%=CommonString.getFormatPara(newsmap.get("telphone"))%><br>
                        联系人：<%=CommonString.getFormatPara(newsmap.get("concatus"))%></div>
                    </li>
                   <%}%>
                  </ul>
				  <%}else{%>
				<p style="text-align: center;line-height: 20px;font-weight: bolder;margin-bottom: 10px;"> 您所在区域暂无售后服务网点，<br />为您推荐其他售后服务网点：</p>
             <%
				if(agentListSecond!=null&&agentListSecond.size()>0){
				%>
                  <ul class="jxs_result_list">
				  <%
				  for(Map newsmap:agentListSecond){
				  
				  %>
                    <li> <strong title="<%=CommonString.getFormatPara(newsmap.get("full_name"))%>" class="t m1"><%=CommonString.getFormatPara(newsmap.get("full_name"))%></strong>
                      <div class="p">地区：<%=CommonString.getFormatPara(newsmap.get("city"))%><br>
                        地址：<%=CommonString.getFormatPara(newsmap.get("address"))%><br>
                        电话：<%=CommonString.getFormatPara(newsmap.get("telphone"))%><br>
                        联系人：<%=CommonString.getFormatPara(newsmap.get("concatus"))%></div>
                    </li>
                   <%}%>
                  </ul>
				  <%}}%>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.4"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.4/src/SearchInfoWindow_min.js"></script>
<script type="text/javascript">
//标注点数组
var markerArr = [
<%int count=0;
	for(Map pointRs:agentListFirst){
	count++;
		Map map = new HashMap();
		map.put("title",CommonString.getFormatPara(pointRs.get("full_name")));
		map.put("content",CommonString.getFormatPara(pointRs.get("address")).replaceAll("\r\n","").replaceAll("\"","'"));
		map.put("longitude",CommonString.getFormatPara(pointRs.get("lng")));
		map.put("latitude",CommonString.getFormatPara(pointRs.get("lat")));
		map.put("telephone",CommonString.getFormatPara(pointRs.get("telphone")));
		list.add(map);
%>
	<%if(count==agentListFirst.size()){%>
	{title:"公司名称：<%=CommonString.getFormatPara(pointRs.get("full_name"))%>",content:"地址：<%=CommonString.getFormatPara(pointRs.get("address")).replaceAll("\r\n","")%><br />电话：<%=CommonString.getFormatPara(pointRs.get("telphone"))%>",point:"<%=CommonString.getFormatPara(pointRs.get("lng"))%>|<%=CommonString.getFormatPara(pointRs.get("lat"))%>",isOpen:0,icon:{w:23,h:25,l:46,t:21,x:9,lb:12}}
	<%}else{%>
	{title:"公司名称：<%=CommonString.getFormatPara(pointRs.get("full_name"))%>",content:"地址：<%=CommonString.getFormatPara(pointRs.get("address")).replaceAll("\r\n","")%><br />电话：<%=CommonString.getFormatPara(pointRs.get("telphone"))%>",point:"<%=CommonString.getFormatPara(pointRs.get("lng"))%>|<%=CommonString.getFormatPara(pointRs.get("lat"))%>",isOpen:0,icon:{w:23,h:25,l:46,t:21,x:9,lb:12}},
	<%}%>
<%}%>
];
//创建和初始化地图函数：
function initMap(){
	createMap();//创建地图
	setMapEvent();//设置地图事件
	addMapControl();//向地图添加控件
	addMarker();//向地图中添加
}
//创建地图函数：
function createMap(){
	var map = new BMap.Map("baiduMap");//在百度地图容器中创建一个地图
	var point = new BMap.Point(108.952523,34.276607);//定义一个中心点坐标
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
		var iconImgiconImg ;
        iconImg="/img/map_mark.png";		
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

//获取省市
jQuery.getScript("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js",function(){
	var province ;
	var city ;
	//jQuery("#zd_provincess option:contains("+province+")").attr("selected",true);
	//jQuery("#zd_provincess").change();
	set_myy_city(document.getElementById("zd_provincess"),city);
	
}) ;
	

	
	function set_myy_city(o,cked){
		var area_id = o.options[o.selectedIndex].getAttribute("area_id");
		jQuery.ajax({
			url : '/tools/ajax.jsp',
			async : false,
			type : 'post',
			data : {
				flag : 'get_city',
				p : area_id
			},
			success : function(data){
				var arr = eval(data);
				var zd_city = document.getElementById("zd_city");
				zd_city.length = 1;
				var opt;
				var aname;
				var hname;
				for(var i=0;i<arr.length;i++){
					aname = arr[i].area_name;
					hname = aname;
					aname = aname;
					opt = new Option(aname,hname);
					if(aname.indexOf(cked)!=-1){
						opt.selected = true;
					}
					zd_city.options.add(opt);
				}
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