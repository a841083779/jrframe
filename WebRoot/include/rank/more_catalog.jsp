<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
   	String year = CommonString.getFilterStr(request.getParameter("year")) ;
	String month = CommonString.getFilterStr(request.getParameter("month")) ;
    String season = CommonString.getFilterStr(request.getParameter("season")) ;
	String factory= CommonString.getFilterStr(request.getParameter("factory")) ;
%>

<div style="padding-left:0px; width:675px; float:none; margin-left:70px;" class="plmore">
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_101_0.htm"> <strong style="color:#3355AC"> 土方机械</strong> </a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_101003_0.htm"> 推土机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_101002_0.htm"> 装载机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_101001_0.htm"> 挖掘机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_101005_0.htm"> 平地机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_101004_0.htm"> 铲运机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_101008_0.htm"> 自卸卡车 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_102_0.htm"> <strong style="color:#3355AC">起重机</strong> </a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_102013_0.htm"> 桥梁式起重机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_102012_0.htm"> 伸缩臂叉装机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_102002_0.htm"> 塔式起重机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_102011_0.htm"> 施工升降机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_102010_0.htm"> 高空作业车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_102007_0.htm"> 汽车起重机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_102008_0.htm"> 履带式起重机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_102006_0.htm"> 随车起重机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_102003_0.htm"> 高空作业平台 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103_0.htm"><strong style="color:#3355AC"> 混凝土机械</strong> </a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103008_0.htm"> 干粉砂浆生产设备 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103009_0.htm"> 粉粒物料运输车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103005_0.htm"> 混凝土布料设备 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103006_0.htm"> 混凝土搅拌运输车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103015_0.htm"> 其它混凝土设备 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103012_0.htm"> 干混砂浆生产线 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103011_0.htm"> 沥青砂浆车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103014_0.htm"> 干混砂浆背罐车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103002_0.htm"> 混凝土搅拌设备 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103001_0.htm"> 混凝土泵车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_103010_0.htm"> 喷湿机 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_104_0.htm"><strong style="color:#3355AC"> 筑养路机械 </strong></a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_104006_0.htm"> 稳定土拌合机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_104005_0.htm"> 铣刨机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_104008_0.htm"> 稳定土厂拌设备 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_104007_0.htm"> 沥青混合料搅拌设备 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_104009_0.htm"> 沥青搅拌站 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_104004_0.htm"> 其它路面机械 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_104001_0.htm"> 摊铺机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_104002_0.htm"> 养护机械 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105_0.htm"><strong style="color:#3355AC"> 桩工机械</strong> </a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105017_0.htm"> 强夯机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105018_0.htm"> 长螺旋钻孔机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105009_0.htm"> 液压静力压桩机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105019_0.htm"> 多功能钻机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105007_0.htm"> 连续墙抓斗 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105028_0.htm"> 截桩机/破桩机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105011_0.htm"> 打桩机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105016_0.htm"> 连续墙钻机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105015_0.htm"> 打桩锤 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105027_0.htm"> 其它桩工机械 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105026_0.htm"> 多轴钻孔机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105013_0.htm"> 液压步履式桩架 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105003_0.htm"> 旋挖钻机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105004_0.htm"> 潜孔钻机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_105005_0.htm"> 水平定向钻 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_106_0.htm"><strong style="color:#3355AC"> 压实机械 </strong></a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_106004_0.htm"> 夯实机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_106003_0.htm"> 压实机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_106001_0.htm"> 压路机 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_107_0.htm"> <strong style="color:#3355AC"> 叉车</strong> </a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_107010_0.htm"> 专用叉车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_107001_0.htm"> 内燃叉车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_107003_0.htm"> 电动叉车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_107005_0.htm"> 仓储叉车 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_109_0.htm"><strong style="color:#3355AC"> 桥梁机械 </strong></a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_109004_0.htm"> 提梁机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_109005_0.htm"> 检测车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_109002_0.htm"> 运梁车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_109006_0.htm"> 砂浆车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_109001_0.htm"> 架桥机 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110_0.htm"> <strong style="color:#3355AC"> 地下及矿山机械</strong> </a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110010_0.htm"> 凿岩钻车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110008_0.htm"> 凿岩台车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110009_0.htm"> 破碎机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110011_0.htm"> 凿岩机和钻机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110012_0.htm"> 筛分机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110013_0.htm"> 装载及搬运设备 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110014_0.htm"> 连续采煤机和隧道掘进机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110005_0.htm"> 采煤机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110015_0.htm"> 输送和辅助设备 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110002_0.htm"> 矿用掘进机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110016_0.htm"> 全液压凿岩钻机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110017_0.htm"> 隧道轨道设备 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_110001_0.htm"> 盾构掘进机 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_111_0.htm"><strong style="color:#3355AC"> 港口机械</strong> </a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_111003_0.htm"> 吊具 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_111001_0.htm"> 正面吊 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_111002_0.htm"> 堆高机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_111007_0.htm"> 推耙机 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_111006_0.htm"> 场桥 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_113_0.htm"> <strong style="color:#3355AC"> 破碎设备</strong> </a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_113002_0.htm"> 液压剪 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_113001_0.htm"> 破碎锤 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_118_0.htm"> <strong style="color:#3355AC"> 专用汽车</strong> </a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_118004_0.htm"> 牵引车 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_118002_0.htm"> 专用车辆 </a> <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_118003_0.htm"> 消防车 </a> </div>
  <div class="pllist"> <a target="_top" class="plfl" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_119_0.htm"><strong style="color:#3355AC"> 煤炭机械</strong> </a> <br>
    <a target="_top" href="/pro_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_<%=factory.equals("")?"0":factory%>_119001_0.htm"> 煤炭机械 </a> </div>
</div>