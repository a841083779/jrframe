<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>  
<%
	String factoryid = CommonString.getFormatPara(request.getParameter("factoy_id")) ;
	String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ;
	String tonandmeter = CommonString.getFormatPara(request.getParameter("tonandmeter")) ;
	String order = CommonString.getFormatPara(request.getParameter("order")) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>  
   
 <style type="text/css">
a:link,a:visited { color:#666666;}
a:hover { color:#ff6600;}
.STYLE1 {color: #FFFFFF}
.pllist { width:90%;  min-height:50px; height:auto!important; height:50px; overflow:visible; position:relative; padding-top:23px; 

border-bottom:#ccc 1px dotted; margin-right:1%; padding-left:8px;}
.pllist a.plfl { position:absolute; left:8px; height:40px; top:0px; margin:5px; font-size:14px; font-family:Verdana; font-weight:bold; color:#3355AC; float:none; padding:0px; width:auto; text-decoration:none;}
.pllist a { display:inline-block; margin:0px 5px; font-size:12px; line-height:20px; height:20px; overflow:hidden; float:none; padding:0px; width:auto; text-decoration:none;}
</style>
</head>
<body style="background-color:transparent;">
<div class="plmore"  style="padding-left:0px; width:650px;">    

          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=101&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 土方机械 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=101003<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 推土机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=101002<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 装载机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=101001<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 挖掘机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=101005<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 平地机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=101004<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 铲运机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=101008<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 自卸卡车 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=102&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 起重机械 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=102013<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 桥梁式起重机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=102012<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 伸缩臂叉装机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=102002<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 塔式起重机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=102011<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 施工升降机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=102010<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 高空作业车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=102007<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 汽车起重机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=102008<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 履带式起重机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=102006<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 随车起重机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=102003<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 高空作业平台 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 混凝土机械 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103008<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 干粉砂浆生产设备 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103009<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 粉粒物料运输车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103005<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 混凝土布料设备 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103006<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 混凝土搅拌运输车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103015<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 其它混凝土设备 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103012<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 干混砂浆生产线 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103011<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 沥青砂浆车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103014<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 干混砂浆背罐车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103002<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 混凝土搅拌设备 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103001<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 混凝土泵车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=103010<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 喷湿机 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=104&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 筑养路机械 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=104006<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 稳定土拌合机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=104005<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 铣刨机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=104008<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 稳定土厂拌设备 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=104007<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 沥青混合料搅拌设备 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=104009<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 沥青搅拌站 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=104004<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 其它路面机械 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=104001<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 摊铺机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=104002<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 养护机械 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 桩工机械 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105017<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 强夯机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105018<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 长螺旋钻孔机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105009<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 液压静力压桩机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105019<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 多功能钻机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105007<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 连续墙抓斗 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105028<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 截桩机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105011<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 打桩机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105016<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 连续墙钻机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105015<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 打桩锤 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105027<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 其它桩工机械 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105026<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 多轴钻孔机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105013<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 液压步履式桩架 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105003<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 旋挖钻机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105004<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 潜孔钻机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=105005<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 水平定向钻 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=106&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 压实机械 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=106004<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 夯实机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=106003<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 压实机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=106001<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 压路机 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=107&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 机动工业车辆 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=107008<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 半挂车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=107001<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 内燃叉车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=107003<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 电动叉车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=107005<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 仓储叉车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=107007<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 其它机动工业车辆 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=109&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 桥梁机械 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=109004<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 提梁机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=109005<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 检测车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=109002<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 运梁车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=109006<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 砂浆车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=109001<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 架桥机 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 地下及矿山机械 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110010<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 凿岩钻车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110008<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 凿岩台车 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110009<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 破碎机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110011<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 凿岩机和钻机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110012<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 筛分机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110013<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 装载及搬运设备 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110005<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 采煤机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110014<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 连续采煤机和隧道掘进机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110002<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 矿用掘进机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110015<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 输送和辅助设备 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110016<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 全液压凿岩钻机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=110001<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 盾构掘进机 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=111&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 港口机械 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=111003<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 吊具 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=111001<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 正面吊 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=111002<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 堆高机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=111007<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 推耙机 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=111006<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 场桥 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=113&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 破碎设备 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=113003<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 破碎枪 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=113002<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 液压剪 </a>
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=113001<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 破碎锤 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=117&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 消防机械 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=117001<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 消防车 </a>
      </div>       
          <div class="pllist">
            <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=118&tonandmeter=<%=tonandmeter %>&order=<%=order %>" class="plfl" target="_top"> 专用汽车 </a> <br/>                
             <a href="/photo/list.jsp?factoryid=<%=factoryid %>&catalogid=118002<%="".equals(tonandmeter)?"":"&tonandmeter="+tonandmeter+""%><%="".equals(order)?"\"":"&order="+order+"\"" %> target="_top"> 专用车辆 </a>
      </div>       
</div>
</body>
</html>