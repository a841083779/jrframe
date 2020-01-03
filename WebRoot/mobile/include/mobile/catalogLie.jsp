<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%

	 String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String city = CommonString.getFormatPara(request.getParameter("city"));
	String url="agent_list.jsp";
	String where="";
	if(!factory.equals("")){where+="&factory="+factory;}
	if(!city.equals("")){where+="&city="+city;}
%>

 <ul>
<li><a href="javascript:;" target="_top" style="font-weight: bold"> 土方机械 </a></li>
<li><a href="<%=url%>?catalog=101003<%=where%>" target="_top"> 推土机 </a></li>
<li><a href="<%=url%>?catalog=101002<%=where%>" target="_top"> 装载机 </a></li>
<li><a href="<%=url%>?catalog=101001<%=where%>" target="_top"> 挖掘机 </a></li>
<li><a href="<%=url%>?catalog=101002009<%=where%>" target="_top"> 滑移装载机 </a></li>
<li><a href="<%=url%>?catalog=101004<%=where%>" target="_top"> 铲运机 </a></li>
<li><a href="<%=url%>?catalog=101008<%=where%>" target="_top"> 自卸卡车 </a></li>	

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 挖掘机械 </a></li>
<li><a href="<%=url%>?catalog=101001001<%=where%>" target="_top"> 履带式挖掘机 </a></li>			
<li><a href="<%=url%>?catalog=101001004<%=where%>" target="_top"> 轮式挖掘机 </a></li>
<li><a href="<%=url%>?catalog=101001006<%=where%>" target="_top"> 正铲挖掘机 </a></li>
<li><a href="<%=url%>?catalog=101001007<%=where%>" target="_top"> 其他挖掘机 </a></li>
<li><a href="<%=url%>?catalog=101001&tonandmeter=grab_1_13<%=where%>" target="_top"> 小挖(1T～13T) </a></li>
<li><a href="<%=url%>?catalog=101001&tonandmeter=grab_14_30<%=where%>" target="_top"> 中挖(14T～30T) </a></li>
<li><a href="<%=url%>?catalog=101001&tonandmeter=grab_30_1<%=where%>" target="_top"> 大挖(30T以上) </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 起重机 </a></li>
<li><a href="<%=url%>?catalog=102007<%=where%>" target="_top"> 汽车起重机 </a></li>
<li><a href="<%=url%>?catalog=102008<%=where%>" target="_top"> 履带式起重机 </a></li>
<li><a href="<%=url%>?catalog=102002<%=where%>" target="_top"> 塔式起重机 </a></li>
<li><a href="<%=url%>?catalog=102010<%=where%>" target="_top"> 高空作业车 </a></li>
<li><a href="<%=url%>?catalog=102003<%=where%>" target="_top"> 高空作业平台 </a></li>
<li><a href="<%=url%>?catalog=102006<%=where%>" target="_top"> 随车起重机 </a></li>
<li><a href="<%=url%>?catalog=102012<%=where%>" target="_top"> 伸缩臂叉装机 </a></li>
<li><a href="<%=url%>?catalog=102011<%=where%>" target="_top"> 施工升降机 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 混凝土机械 </a></li>
<li><a href="<%=url%>?catalog=103001<%=where%>" target="_top"> 泵车 </a></li>
<li><a href="<%=url%>?catalog=103017<%=where%>" target="_top"> 车载泵 </a></li>
<li><a href="<%=url%>?catalog=103018<%=where%>" target="_top"> 拖泵/输送泵 </a></li>
<li><a href="<%=url%>?catalog=103019<%=where%>" target="_top"> 搅拌运输车 </a></li>
<li><a href="<%=url%>?catalog=103002<%=where%>" target="_top"> 混凝土搅拌站/楼 </a></li>
<li><a href="<%=url%>?catalog=103002001<%=where%>" target="_top"> 搅拌机 </a></li>
<li><a href="<%=url%>?catalog=103005002<%=where%>" target="_top"> 布料机/布料杆 </a></li>
<li><a href="<%=url%>?catalog=103009<%=where%>" target="_top"> 粉粒物料运输车 </a></li>
<li><a href="<%=url%>?catalog=103012<%=where%>" target="_top"> 干粉砂浆生产设备 </a></li>
<li><a href="<%=url%>?catalog=103008<%=where%>" target="_top"> 干混砂浆背罐车 </a></li>
<li><a href="<%=url%>?catalog=103010<%=where%>" target="_top"> 喷湿机 </a></li>
<li><a href="<%=url%>?catalog=103015<%=where%>" target="_top"> 其它混凝土设备 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 路面机械 </a></li>
<li><a href="<%=url%>?catalog=106001<%=where%>" target="_top"> 压路机 </a></li>
<li><a href="<%=url%>?catalog=104001<%=where%>" target="_top"> 摊铺机 </a></li>
<li><a href="<%=url%>?catalog=101005<%=where%>" target="_top"> 平地机 </a></li>
<li><a href="<%=url%>?catalog=106004<%=where%>" target="_top"> 夯实机 </a></li>
<li><a href="<%=url%>?catalog=104004005<%=where%>" target="_top"> 沥青搅拌机 </a></li>
<li><a href="<%=url%>?catalog=104004001<%=where%>" target="_top"> 沥青混合料转运车 </a></li>
<li><a href="<%=url%>?catalog=104007<%=where%>" target="_top"> 沥青混合料搅拌设备 </a></li>
<li><a href="<%=url%>?catalog=104008<%=where%>" target="_top"> 稳定土厂拌设备 </a></li>
<li><a href="<%=url%>?catalog=104009<%=where%>" target="_top"> 沥青搅拌站 </a></li>
<li><a href="<%=url%>?catalog=104006<%=where%>" target="_top"> 稳定土拌合机 </a></li>
<li><a href="<%=url%>?catalog=104004<%=where%>" target="_top"> 其它路面机械 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 桩工机械 </a></li>
<li><a href="<%=url%>?catalog=105003<%=where%>" target="_top"> 旋挖钻机 </a></li>
<li><a href="<%=url%>?catalog=105009<%=where%>" target="_top"> 液压静力压桩机 </a></li>
<li><a href="<%=url%>?catalog=105005<%=where%>" target="_top"> 水平定向钻 </a></li>
<li><a href="<%=url%>?catalog=105007<%=where%>" target="_top"> 连续墙抓斗 </a></li>
<li><a href="<%=url%>?catalog=105011<%=where%>" target="_top"> 打桩机 </a></li>
<li><a href="<%=url%>?catalog=105018<%=where%>" target="_top"> 长螺旋钻孔机 </a></li>
<li><a href="<%=url%>?catalog=105015<%=where%>" target="_top"> 打桩锤 </a></li>
<li><a href="<%=url%>?catalog=105004<%=where%>" target="_top"> 潜孔钻机 </a></li>
<li><a href="<%=url%>?catalog=105019<%=where%>" target="_top"> 多功能钻机 </a></li>
<li><a href="<%=url%>?catalog=105017<%=where%>" target="_top"> 强夯机液压步履式桩架 </a></li>
<li><a href="<%=url%>?catalog=105026<%=where%>" target="_top"> 多轴钻孔机 </a></li>
<li><a href="<%=url%>?catalog=105016<%=where%>" target="_top"> 连续墙钻机 </a></li>
<li><a href="<%=url%>?catalog=105028<%=where%>" target="_top"> 截桩机/破桩机 </a></li>
<li><a href="<%=url%>?catalog=105027<%=where%>" target="_top"> 其它桩工机械 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 压实机械 </a></li>
<li><a href="<%=url%>?catalog=106001001<%=where%>" target="_top"> 单钢轮压路机 </a></li>
<li><a href="<%=url%>?catalog=106001002<%=where%>" target="_top"> 双钢轮压路机 </a></li>
<li><a href="<%=url%>?catalog=106001009<%=where%>" target="_top"> 振动压路机 </a></li>
<li><a href="<%=url%>?catalog=106001005<%=where%>" target="_top"> 轮胎压路机 </a></li>
<li><a href="<%=url%>?catalog=106001003<%=where%>" target="_top"> 三轮压路机 </a></li>
<li><a href="<%=url%>?catalog=106001004<%=where%>" target="_top"> 光轮压路机 </a></li>
<li><a href="<%=url%>?catalog=106001006<%=where%>" target="_top"> 冲击式压路机 </a></li>
<li><a href="<%=url%>?catalog=106001008<%=where%>" target="_top"> 静碾压路机 </a></li>
<li><a href="<%=url%>?catalog=106003<%=where%>" target="_top"> 压实机 </a></li>
<li><a href="<%=url%>?catalog=106004<%=where%>" target="_top"> 夯实机 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 养护机械 </a></li>
<li><a href="<%=url%>?catalog=104005<%=where%>" target="_top"> 铣刨机 </a></li>
<li><a href="<%=url%>?catalog=104002004<%=where%>" target="_top"> 再生机械 </a></li>
<li><a href="<%=url%>?catalog=104002011<%=where%>" target="_top"> 路面破碎机 </a></li>
<li><a href="<%=url%>?catalog=104002009<%=where%>" target="_top"> 沥青洒布车 </a></li>
<li><a href="<%=url%>?catalog=104002005<%=where%>" target="_top"> 灌缝机械 </a></li>
<li><a href="<%=url%>?catalog=104002006<%=where%>" target="_top"> 开槽机 </a></li>
<li><a href="<%=url%>?catalog=104004008<%=where%>" target="_top"> 碎石撒布机 </a></li>
<li><a href="<%=url%>?catalog=104002<%=where%>" target="_top"> 其他养护机械 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 叉车 </a></li>
<li><a href="<%=url%>?catalog=107003<%=where%>" target="_top"> 电动叉车 </a></li>
<li><a href="<%=url%>?catalog=107001<%=where%>" target="_top"> 内燃叉车 </a></li>	
<li><a href="<%=url%>?catalog=107005<%=where%>" target="_top"> 仓储叉车 </a></li>			 
<li><a href="<%=url%>?catalog=118004<%=where%>" target="_top"> 牵引车 </a></li>
<li><a href="<%=url%>?catalog=107002<%=where%>" target="_top"> 其他种类叉车 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 地下及矿山机械 </a></li>
<li><a href="<%=url%>?catalog=110010<%=where%>" target="_top"> 凿岩机和钻机 </a></li>
<li><a href="<%=url%>?catalog=110015<%=where%>" target="_top"> 输送和辅助设备 </a></li>
<li><a href="<%=url%>?catalog=110009<%=where%>" target="_top"> 破碎机 </a></li>
<li><a href="<%=url%>?catalog=110013<%=where%>" target="_top"> 装载及搬运设备 </a></li>
<li><a href="<%=url%>?catalog=110002<%=where%>" target="_top"> 矿用掘进机 </a></li>
<li><a href="<%=url%>?catalog=110008<%=where%>" target="_top"> 凿岩台车 </a></li>
<li><a href="<%=url%>?catalog=110012<%=where%>" target="_top"> 筛分机 </a></li>
<li><a href="<%=url%>?catalog=110016<%=where%>" target="_top">全液压凿岩钻机 </a></li>
<li><a href="<%=url%>?catalog=110001<%=where%>" target="_top"> 盾构掘进机 </a></li>
<li><a href="<%=url%>?catalog=110010<%=where%>" target="_top"> 凿岩钻车 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 桥梁机械 </a></li>
<li><a href="<%=url%>?catalog=109004<%=where%>" target="_top"> 提梁机 </a></li>
<li><a href="<%=url%>?catalog=109005<%=where%>" target="_top"> 检测车 </a></li>
<li><a href="<%=url%>?catalog=109002<%=where%>" target="_top"> 运梁车 </a></li>
<li><a href="<%=url%>?catalog=109006<%=where%>" target="_top"> 砂浆车 </a></li>
<li><a href="<%=url%>?catalog=109001<%=where%>" target="_top"> 架桥机 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 港口机械 </a></li>
<li><a href="<%=url%>?catalog=111002<%=where%>" target="_top"> 堆高机 </a></li>
<li><a href="<%=url%>?catalog=111001<%=where%>" target="_top"> 正面吊 </a></li>
<li><a href="<%=url%>?catalog=111006<%=where%>" target="_top"> 场桥 </a></li>
<li><a href="<%=url%>?catalog=111007<%=where%>" target="_top"> 推耙机 </a></li>
<li><a href="<%=url%>?catalog=111004<%=where%>" target="_top"> 港口起重机 </a></li>
<li><a href="<%=url%>?catalog=111008<%=where%>" target="_top"> 海工装备 </a></li>
<li><a href="<%=url%>?catalog=111003<%=where%>" target="_top"> 吊具 </a></li>
<li><a href="<%=url%>?catalog=111009<%=where%>" target="_top"> 其他港口机械 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 破碎设备 </a></li>
<li><a href="<%=url%>?catalog=113002<%=where%>" target="_top"> 液压剪 </a></li>
<li><a href="<%=url%>?catalog=113001<%=where%>" target="_top"> 破碎锤 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 专用汽车 </a></li>
<li><a href="<%=url%>?catalog=118003<%=where%>" target="_top"> 消防车 </a></li>
<li><a href="<%=url%>?catalog=118001<%=where%>" target="_top"> 半挂车 </a></li>
<li><a href="<%=url%>?catalog=118005<%=where%>" target="_top"> 油罐车 </a></li>
<li><a href="<%=url%>?catalog=118006<%=where%>" target="_top"> 化工液体运输车 </a></li>
<li><a href="<%=url%>?catalog=118007<%=where%>" target="_top"> 冷藏车 </a></li>
<li><a href="<%=url%>?catalog=103015<%=where%>" target="_top"> 水泥运输车 </a></li>
<li><a href="<%=url%>?catalog=118009<%=where%>" target="_top"> 厢式车 </a></li>
<li><a href="<%=url%>?catalog=118002<%=where%>" target="_top"> 专用车辆 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 煤炭机械 </a></li>
<li><a href="<%=url%>?catalog=119002<%=where%>" target="_top"> 采煤机 </a></li>
<li><a href="<%=url%>?catalog=119005<%=where%>" target="_top"> 输送机 </a></li>
<li><a href="<%=url%>?catalog=119001<%=where%>" target="_top"> 其他煤炭机械 </a></li>

<li><a href="javascript:;" target="_top" style="font-weight: bold"> 环卫机械 </a></li>
<li><a href="<%=url%>?catalog=104002008<%=where%>" target="_top"> 清扫机 </a></li>
<li><a href="<%=url%>?catalog=104002007<%=where%>" target="_top"> 洒水车 </a></li>
<li><a href="<%=url%>?catalog=104002002<%=where%>" target="_top"> 垃圾车 </a></li>
<li><a href="<%=url%>?catalog=104002011<%=where%>" target="_top"> 其他环卫机械 </a></li>
</ul>