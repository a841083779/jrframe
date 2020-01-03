<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>  
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoy_id")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter")) ;
	String order = CommonString.getFormatPara(request.getParameter("order")) ;
	String flag = CommonString.getFormatPara(request.getParameter("flag")) ;
	String province = CommonString.getFormatPara(request.getParameter("province")) ;
	String city = CommonString.getFormatPara(request.getParameter("city")) ;
	String url = "/products/prolist.jsp";
    if(province.equals("")){province="0";}
	if(city.equals("")){city="0";}
	if(factoryid.equals("")){factoryid="0";}
%>
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_101.shtm" class="plfl" target="_top"> <strong style="color:#3355AC">土方机械</strong> </a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_101003.shtm" target="_top"> 推土机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_101002.shtm" target="_top"> 装载机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_101001.shtm" target="_top"> 挖掘机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_101005.shtm" target="_top"> 平地机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_101004.shtm" target="_top"> 铲运机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_101008.shtm" target="_top"> 自卸卡车 </a>
      </div>       
          <div class="pllist">
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_102.shtm" class="plfl" target="_top"> <strong style="color:#3355AC">起重机 </strong></a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_102013.shtm" target="_top"> 桥梁式起重机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_102012.shtm" target="_top"> 伸缩臂叉装机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_102002.shtm" target="_top"> 塔式起重机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_102011.shtm" target="_top"> 施工升降机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_102010.shtm" target="_top"> 高空作业车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_102007.shtm" target="_top"> 汽车起重机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_102008.shtm" target="_top"> 履带式起重机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_102006.shtm" target="_top"> 随车起重机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_102003.shtm" target="_top"> 高空作业平台 </a>
      </div>       
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103.shtm" class="plfl" target="_top"><strong style="color:#3355AC"> 混凝土机械</strong> </a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103008.shtm" target="_top"> 干粉砂浆生产设备 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103009.shtm" target="_top"> 粉粒物料运输车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103005.shtm" target="_top"> 混凝土布料设备 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103006.shtm" target="_top"> 混凝土搅拌运输车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103015.shtm" target="_top"> 其它混凝土设备 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103012.shtm" target="_top"> 干混砂浆生产线 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103011.shtm" target="_top"> 沥青砂浆车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103014.shtm" target="_top"> 干混砂浆背罐车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103002.shtm" target="_top"> 混凝土搅拌设备 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103001.shtm" target="_top"> 混凝土泵车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_103010.shtm" target="_top"> 喷湿机 </a>
      </div>       
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_104.shtm" class="plfl" target="_top"> <strong style="color:#3355AC">筑养路机械</strong> </a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_104006.shtm" target="_top"> 稳定土拌合机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_104005.shtm" target="_top"> 铣刨机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_104008.shtm" target="_top"> 稳定土厂拌设备 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_104007.shtm" target="_top"> 沥青混合料搅拌设备 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_104009.shtm" target="_top"> 沥青搅拌站 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_104004.shtm" target="_top"> 其它路面机械 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_104001.shtm" target="_top"> 摊铺机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_104002.shtm" target="_top"> 养护机械 </a>
      </div>       
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105.shtm" class="plfl" target="_top"> <strong style="color:#3355AC">桩工机械</strong> </a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105017.shtm" target="_top"> 强夯机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105018.shtm" target="_top"> 长螺旋钻孔机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105009.shtm" target="_top"> 液压静力压桩机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105019.shtm" target="_top"> 多功能钻机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105007.shtm" target="_top"> 连续墙抓斗 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105028.shtm" target="_top"> 截桩机/破桩机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105011.shtm" target="_top"> 打桩机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105016.shtm" target="_top"> 连续墙钻机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105015.shtm" target="_top"> 打桩锤 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105027.shtm" target="_top"> 其它桩工机械 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105026.shtm" target="_top"> 多轴钻孔机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105013.shtm" target="_top"> 液压步履式桩架 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105003.shtm" target="_top"> 旋挖钻机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105004.shtm" target="_top"> 潜孔钻机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_105005.shtm" target="_top"> 水平定向钻 </a>
      </div>       
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_106.shtm" class="plfl" target="_top"><strong style="color:#3355AC"> 压实机械</strong> </a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_106004.shtm" target="_top"> 夯实机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_106003.shtm" target="_top"> 压实机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_106001.shtm" target="_top"> 压路机 </a>
      </div>       
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_107.shtm" class="plfl" target="_top"> <strong style="color:#3355AC">叉车</strong> </a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_107010.shtm" target="_top"> 专用叉车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_107001.shtm" target="_top"> 内燃叉车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_107003.shtm" target="_top"> 电动叉车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_107005.shtm" target="_top"> 仓储叉车 </a>
      </div>       
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_109.shtm" class="plfl" target="_top"><strong style="color:#3355AC"> 桥梁机械</strong> </a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_109004.shtm" target="_top"> 提梁机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_109005.shtm" target="_top"> 检测车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_109002.shtm" target="_top"> 运梁车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_109006.shtm" target="_top"> 砂浆车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_109001.shtm" target="_top"> 架桥机 </a>
      </div>       
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110.shtm" class="plfl" target="_top"><strong style="color:#3355AC"> 地下及矿山机械</strong> </a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110010.shtm" target="_top"> 凿岩钻车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110008.shtm" target="_top"> 凿岩台车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110009.shtm" target="_top"> 破碎机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110011.shtm" target="_top"> 凿岩机和钻机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110012.shtm" target="_top"> 筛分机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110013.shtm" target="_top"> 装载及搬运设备 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110014.shtm" target="_top"> 连续采煤机和隧道掘进机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110005.shtm" target="_top"> 采煤机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110015.shtm" target="_top"> 输送和辅助设备 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110002.shtm" target="_top"> 矿用掘进机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110016.shtm" target="_top"> 全液压凿岩钻机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110017.shtm" target="_top"> 隧道轨道设备 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_110001.shtm" target="_top"> 盾构掘进机 </a>
      </div>       
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_111.shtm" class="plfl" target="_top"> <strong style="color:#3355AC">港口机械 </strong></a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_111003.shtm" target="_top"> 吊具 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_111001.shtm" target="_top"> 正面吊 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_111002.shtm" target="_top"> 堆高机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_111007.shtm" target="_top"> 推耙机 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_111006.shtm" target="_top"> 场桥 </a>
      </div>       
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_113.shtm" class="plfl" target="_top"> <strong style="color:#3355AC">破碎设备</strong> </a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_113002.shtm" target="_top"> 液压剪 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_113001.shtm" target="_top"> 破碎锤 </a>
      </div>       
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_118.shtm" class="plfl" target="_top"><strong style="color:#3355AC"> 专用汽车</strong> </a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_118004.shtm" target="_top"> 牵引车 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_118002.shtm" target="_top"> 专用车辆 </a>
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_118003.shtm" target="_top"> 消防车 </a>
      </div>       
          <div class="pllist">
            <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_119.shtm" class="plfl" target="_top"><strong style="color:#3355AC"> 煤炭机械</strong> </a> <br/>                
             <a href="/agent/<%=province%>_<%=city%>_<%=factoryid%>_119001.shtm" target="_top"> 煤炭机械 </a>
      </div>       
