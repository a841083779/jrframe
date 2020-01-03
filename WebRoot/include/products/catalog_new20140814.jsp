<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>  
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoy_id")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter")) ;
	String order = CommonString.getFormatPara(request.getParameter("order")) ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	String url = "/products/prolist.jsp";
	if(flag.equals("photo")){
		url = "/list.jsp";
	}
%>
          <div class="pllist">
            <a href="<%=url%>?catalog=101" class="plfl" target="_top"> <strong style="color:#3355AC"> 土方机械</strong> </a> <br/>                
             <a href="<%=url%>?catalog=101003" target="_top"> 推土机 </a>
             <a href="<%=url%>?catalog=101002" target="_top"> 装载机 </a>
             <a href="<%=url%>?catalog=101001" target="_top"> 挖掘机 </a>
             <a href="<%=url%>?catalog=101002009" target="_top"> 滑移装载机 </a>
             <a href="<%=url%>?catalog=101004" target="_top"> 铲运机 </a>
             <a href="<%=url%>?catalog=101008" target="_top"> 自卸卡车 </a>
      </div>    
             <div class="pllist">
            <a href="<%=url%>?catalog=108" class="plfl" target="_top"> <strong style="color:#3355AC"> 挖掘机械</strong> </a> <br/>                
             <a href="<%=url%>?catalog=" target="_top"> 迷你小挖（6吨以下） </a>
             <a href="<%=url%>?catalog=" target="_top"> 小挖（6-15吨） </a>
             <a href="<%=url%>?catalog=" target="_top"> 中挖（15-25吨） </a>
             <a href="<%=url%>?catalog=" target="_top"> 大挖（25-45吨） </a>
             <a href="<%=url%>?catalog=101004" target="_top"> 特大挖机（45吨以上） </a>
             <a href="<%=url%>?catalog=101001004" target="_top"> 轮式挖掘机 </a>
             <a href="<%=url%>?catalog=101001006" target="_top"> 正铲挖掘机 </a>
             <a href="<%=url%>?catalog=101001007" target="_top"> 其他挖掘机 </a>
      </div>     	  
          <div class="pllist">
             <a href="<%=url%>?catalog=102" class="plfl" target="_top"> <strong style="color:#3355AC">起重机</strong> </a> <br/>  
			 <a href="<%=url%>?catalog=102007" target="_top"> 汽车起重机 </a>
			 <a href="<%=url%>?catalog=102008" target="_top"> 履带式起重机 </a>
             <a href="<%=url%>?catalog=102002" target="_top"> 塔式起重机 </a>
             <a href="<%=url%>?catalog=102010" target="_top"> 高空作业车 </a>
             <a href="<%=url%>?catalog=102003" target="_top"> 高空作业平台 </a>
             <a href="<%=url%>?catalog=102006" target="_top"> 随车起重机 </a>
             <a href="<%=url%>?catalog=102012" target="_top"> 伸缩臂叉装机 </a>
             <a href="<%=url%>?catalog=102011" target="_top"> 施工升降机 </a>
          
             
      </div>       
          <div class="pllist">
            <a href="<%=url%>?catalog=103" class="plfl" target="_top"><strong style="color:#3355AC"> 混凝土机械</strong> </a> <br/>                
             <a href="<%=url%>?catalog=" target="_top"> 泵车 </a>
			 <a href="<%=url%>?catalog=103017" target="_top"> 车载泵 </a>
			 <a href="<%=url%>?catalog=103018" target="_top"> 拖泵/输送泵 </a>
			 <a href="<%=url%>?catalog=103019" target="_top"> 搅拌运输车 </a>
             <a href="<%=url%>?catalog=103002002" target="_top"> 混凝土搅拌站/楼 </a>
			 <a href="<%=url%>?catalog=103002001" target="_top"> 搅拌机 </a>
			 <a href="<%=url%>?catalog=103005001" target="_top"> 布料机/布料杆 </a>
             <a href="<%=url%>?catalog=103009" target="_top"> 粉粒物料运输车 </a>
             <a href="<%=url%>?catalog=103008" target="_top"> 干粉砂浆生产设备 </a>
             <a href="<%=url%>?catalog=103014" target="_top"> 干混砂浆背罐车 </a>
			 <a href="<%=url%>?catalog=103010" target="_top"> 喷湿机 </a>
             <a href="<%=url%>?catalog=103015" target="_top"> 其它混凝土设备 </a>
             
      </div>       
          <div class="pllist">
            <a href="<%=url%>?catalog=104" class="plfl" target="_top"><strong style="color:#3355AC"> 路面机械 </strong></a> <br/>                
             <a href="<%=url%>?catalog=106001" target="_top"> 压路机 </a>
             <a href="<%=url%>?catalog=104001" target="_top"> 摊铺机 </a>
             <a href="<%=url%>?catalog=101005" target="_top"> 平地机 </a>
             <a href="<%=url%>?catalog=106002001" target="_top"> 压实机 </a>
             <a href="<%=url%>?catalog=106004" target="_top"> 夯实机 </a>
             <a href="<%=url%>?catalog=104004005" target="_top"> 沥青搅拌机 </a>
             <a href="<%=url%>?catalog=104004001" target="_top"> 沥青混合料转运车 </a>
             <a href="<%=url%>?catalog=104007" target="_top"> 沥青混合料搅拌设备 </a>
             <a href="<%=url%>?catalog=104008" target="_top"> 稳定土厂拌设备 </a>
             <a href="<%=url%>?catalog=104009" target="_top"> 沥青搅拌站 </a>
             <a href="<%=url%>?catalog=104006" target="_top"> 稳定土拌合机 </a>
             <a href="<%=url%>?catalog=104004" target="_top"> 其它路面机械 </a>
      </div>       
          <div class="pllist">
            <a href="<%=url%>?catalog=105" class="plfl" target="_top"><strong style="color:#3355AC">  桩工机械</strong> </a> <br/>                
             <a href="<%=url%>?catalog=105003" target="_top"> 旋挖钻机 </a>
             <a href="<%=url%>?catalog=105009" target="_top"> 液压静力压桩机 </a>
             <a href="<%=url%>?catalog=105005" target="_top"> 水平定向钻 </a>
             <a href="<%=url%>?catalog=105007" target="_top"> 连续墙抓斗 </a>
             <a href="<%=url%>?catalog=105011" target="_top"> 打桩机 </a>
             <a href="<%=url%>?catalog=105018" target="_top"> 长螺旋钻孔机 </a>
             <a href="<%=url%>?catalog=105015" target="_top"> 打桩锤 </a>
             <a href="<%=url%>?catalog=105004" target="_top"> 潜孔钻机 </a>
             <a href="<%=url%>?catalog=105019" target="_top"> 多功能钻机 </a>
			 <a href="<%=url%>?catalog=105017" target="_top"> 强夯机液压步履式桩架 </a>
             <a href="<%=url%>?catalog=105026" target="_top"> 多轴钻孔机 </a>
             <a href="<%=url%>?catalog=105016" target="_top"> 连续墙钻机 </a>
             <a href="<%=url%>?catalog=105028" target="_top"> 截桩机/破桩机 </a>
             <a href="<%=url%>?catalog=105027" target="_top"> 其它桩工机械 </a>
      </div>       
          <div class="pllist">
            <a href="<%=url%>?catalog=106" class="plfl" target="_top"><strong style="color:#3355AC">  压实机械 </strong></a> <br/>                
             <a href="<%=url%>?catalog=106001001" target="_top"> 单钢轮压路机 </a>
             <a href="<%=url%>?catalog=106001002" target="_top"> 双钢轮压路机 </a>
             <a href="<%=url%>?catalog=106001009" target="_top"> 振动压路机 </a>
             <a href="<%=url%>?catalog=106001005" target="_top"> 轮胎压路机 </a>
             <a href="<%=url%>?catalog=106001003" target="_top"> 三轮压路机 </a>
             <a href="<%=url%>?catalog=106001004" target="_top"> 光轮压路机 </a>
             <a href="<%=url%>?catalog=106001006" target="_top"> 冲击式压路机 </a>
             <a href="<%=url%>?catalog=106001008" target="_top"> 静碾压路机 </a>
             <a href="<%=url%>?catalog=106003" target="_top"> 压实机 </a>
             <a href="<%=url%>?catalog=106004" target="_top"> 夯实机 </a>
      </div>       
	   <div class="pllist">
            <a href="<%=url%>?catalog=112" class="plfl" target="_top"><strong style="color:#3355AC">  养护机械 </strong></a> <br/>                
             <a href="<%=url%>?catalog=104005" target="_top"> 铣刨机 </a>
             <a href="<%=url%>?catalog=104002004" target="_top"> 再生机械 </a>
             <a href="<%=url%>?catalog=104002011" target="_top"> 路面破碎机 </a>
             <a href="<%=url%>?catalog=104002009" target="_top"> 沥青洒布车 </a>
             <a href="<%=url%>?catalog=104002005" target="_top"> 灌缝机械 </a>
             <a href="<%=url%>?catalog=104002006" target="_top"> 开槽机 </a>
             <a href="<%=url%>?catalog=104004008" target="_top"> 碎石撒布机 </a>
             <a href="<%=url%>?catalog=" target="_top"> 垃圾车 </a>
             <a href="<%=url%>?catalog=104002" target="_top"> 其他养护机械 </a>
      </div>       
          <div class="pllist">
            <a href="<%=url%>?catalog=107" class="plfl" target="_top"> <strong style="color:#3355AC"> 叉车</strong> </a> <br/>             
            
             <a href="<%=url%>?catalog=107003" target="_top"> 电动叉车 </a>	
             <a href="<%=url%>?catalog=107001" target="_top"> 内燃叉车 </a>	
             <a href="<%=url%>?catalog=107005" target="_top"> 仓储叉车 </a>			 
             <a href="<%=url%>?catalog=118004" target="_top"> 牵引车 </a>
             <a href="<%=url%>?catalog=" target="_top"> 其他种类叉车 </a>
      </div> 
          <div class="pllist">
            <a href="<%=url%>?catalog=110" class="plfl" target="_top"> <strong style="color:#3355AC"> 地下及矿山机械</strong> </a> <br/>                
             <a href="<%=url%>?catalog=110010" target="_top"> 凿岩机和钻机 </a>
             <a href="<%=url%>?catalog=110015" target="_top"> 输送和辅助设备 </a>
             <a href="<%=url%>?catalog=110009" target="_top"> 破碎机 </a>
             <a href="<%=url%>?catalog=110013" target="_top"> 装载及搬运设备 </a>
             <a href="<%=url%>?catalog=110002" target="_top"> 矿用掘进机 </a>
             <a href="<%=url%>?catalog=110005" target="_top"> 采煤机 </a>
             <a href="<%=url%>?catalog=110008" target="_top"> 凿岩台车 </a>
             <a href="<%=url%>?catalog=110012" target="_top"> 筛分机 </a>
			   <a href="<%=url%>?catalog=110016" target="_top">全液压凿岩钻机 </a>
             <a href="<%=url%>?catalog=110001" target="_top"> 盾构掘进机 </a>
             <a href="<%=url%>?catalog=110010" target="_top"> 凿岩钻车 </a>
      </div>             
          <div class="pllist">
            <a href="<%=url%>?catalog=109" class="plfl" target="_top"><strong style="color:#3355AC">  桥梁机械 </strong></a> <br/>                
             <a href="<%=url%>?catalog=109004" target="_top"> 提梁机 </a>
             <a href="<%=url%>?catalog=109005" target="_top"> 检测车 </a>
             <a href="<%=url%>?catalog=109002" target="_top"> 运梁车 </a>
             <a href="<%=url%>?catalog=109006" target="_top"> 砂浆车 </a>
             <a href="<%=url%>?catalog=109001" target="_top"> 架桥机 </a>
      </div>       
         
          <div class="pllist">
            <a href="<%=url%>?catalog=111" class="plfl" target="_top"><strong style="color:#3355AC">  港口机械</strong> </a> <br/>                
            
             <a href="<%=url%>?catalog=111002" target="_top"> 堆高机 </a>
             <a href="<%=url%>?catalog=111001" target="_top"> 正面吊 </a>
             <a href="<%=url%>?catalog=111006" target="_top"> 场桥 </a>
             <a href="<%=url%>?catalog=111007" target="_top"> 推耙机 </a>
             <a href="<%=url%>?catalog="" target="_top"> 港口起重机 </a>
             <a href="<%=url%>?catalog=111008" target="_top"> 海工装备 </a>
			  <a href="<%=url%>?catalog=111003" target="_top"> 吊具 </a>
             <a href="<%=url%>?catalog="" target="_top"> 其他港口机械 </a>
      </div>       
          <div class="pllist">
            <a href="<%=url%>?catalog=113" class="plfl" target="_top"> <strong style="color:#3355AC"> 破碎设备</strong> </a> <br/>                
             <a href="<%=url%>?catalog=113002" target="_top"> 液压剪 </a>
             <a href="<%=url%>?catalog=113001" target="_top"> 破碎锤 </a>
      </div>       
          <div class="pllist">
            <a href="<%=url%>?catalog=118" class="plfl" target="_top"> <strong style="color:#3355AC"> 专用汽车</strong> </a> <br/>                
             
             <a href="<%=url%>?catalog=118003" target="_top"> 消防车 </a>
			<a href="<%=url%>?catalog=" target="_top"> 半挂车 </a>
			<a href="<%=url%>?catalog=" target="_top"> 油罐车 </a>
			<a href="<%=url%>?catalog=" target="_top"> 化工液体运输车 </a>
			 <a href="<%=url%>?catalog=" target="_top"> 冷藏车 </a>
			  <a href="<%=url%>?catalog=" target="_top"> 水泥运输车 </a>
			   <a href="<%=url%>?catalog=" target="_top"> 厢式车 </a>
			 <a href="<%=url%>?catalog=118002" target="_top"> 专用车辆 </a>
      </div>       
          <div class="pllist">
            <a href="<%=url%>?catalog=119" class="plfl" target="_top"><strong style="color:#3355AC">  煤炭机械</strong> </a> <br/>                
             <a href="<%=url%>?catalog=110005" target="_top"> 采煤机 </a>
			 <a href="<%=url%>?catalog=" target="_top"> 输送机 </a>
			 <a href="<%=url%>?catalog=119001" target="_top"> 其他煤炭机械 </a>
      </div>       
    <div class="pllist">
            <a href="<%=url%>?catalog=114" class="plfl" target="_top"><strong style="color:#3355AC">  环卫机械</strong> </a> <br/>                
             <a href="<%=url%>?catalog=104002008" target="_top"> 清扫机 </a>
			 <a href="<%=url%>?catalog=104002007" target="_top"> 洒水车 </a>
			 <a href="<%=url%>?catalog=" target="_top"> 垃圾车 </a>
			 <a href="<%=url%>?catalog=104002010" target="_top"> 其他环卫机械 </a>
      </div>     