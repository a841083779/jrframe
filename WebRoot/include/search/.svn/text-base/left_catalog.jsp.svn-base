<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="java.sql.Connection"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%
String factory = CommonString.getFormatPara(request.getParameter("factory")) ; // 品牌id 
String catalog = CommonString.getFormatPara(request.getParameter("catalog")) ; // 
String keyword = CommonString.getFormatPara(request.getParameter("keyword")) ; 
if(catalog.length()>3){catalog=catalog.substring(0,3);}
%>

<div class="nph_val mb10">
  <ul class="nph_list">
    <li <%if(catalog.equals("101")){%>class="cur"<%}%>> <a href="/search/<%=keyword%>_<%=factory%>_101_0.htm">土方机械</a>
      <ul <%if(catalog.equals("101")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_101_101001"> <a href="/search/<%=keyword%>_<%=factory%>_101001_0.htm" class="mainBrand"> 挖掘机 </a> </li>
        <li id="cat_101_101002"> <a href="/search/<%=keyword%>_<%=factory%>_101002_0.htm" class="mainBrand"> 装载机 </a> </li>
        <li id="cat_101_101003"> <a href="/search/<%=keyword%>_<%=factory%>_101003_0.htm" class="mainBrand"> 推土机 </a> </li>
        <li id="cat_101_101004"> <a href="/search/<%=keyword%>_<%=factory%>_101004_0.htm" class="mainBrand"> 铲运机 </a> </li>
        <li id="cat_101_101005"> <a href="/search/<%=keyword%>_<%=factory%>_101005_0.htm" class="mainBrand"> 平地机 </a> </li>
        <li id="cat_101_101008"> <a href="/search/<%=keyword%>_<%=factory%>_101008_0.htm" class="mainBrand"> 自卸卡车 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("102")){%>class="cur"<%}%>> <a href="/search/<%=keyword%>_<%=factory%>_102_0.htm">起重机</a>
      <ul <%if(catalog.equals("102")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_102_102013"> <a href="/search/<%=keyword%>_<%=factory%>_102013_0.htm" class="mainBrand"> 桥梁式起重机 </a> </li>
        <li id="cat_102_102007"> <a href="/search/<%=keyword%>_<%=factory%>_102007_0.htm" class="mainBrand"> 汽车起重机 </a> </li>
        <li id="cat_102_102006"> <a href="/search/<%=keyword%>_<%=factory%>_102006_0.htm" class="mainBrand"> 随车起重机 </a> </li>
        <li id="cat_102_102008"> <a href="/search/<%=keyword%>_<%=factory%>_102008_0.htm" class="mainBrand"> 履带式起重机 </a> </li>
        <li id="cat_102_102002"> <a href="/search/<%=keyword%>_<%=factory%>_102002_0.htm" class="mainBrand"> 塔式起重机 </a> </li>
        <li id="cat_102_102003"> <a href="/search/<%=keyword%>_<%=factory%>_102003_0.htm" class="mainBrand"> 高空作业平台 </a> </li>
        <li id="cat_102_102010"> <a href="/search/<%=keyword%>_<%=factory%>_102010_0.htm" class="mainBrand"> 高空作业车 </a> </li>
        <li id="cat_102_102011"> <a href="/search/<%=keyword%>_<%=factory%>_102011_0.htm" class="mainBrand"> 施工升降机 </a> </li>
        <li id="cat_102_102012"> <a href="/search/<%=keyword%>_<%=factory%>_102012_0.htm" class="mainBrand"> 伸缩臂叉装机 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("103")){%>class="cur"<%}%>><a href="/search/<%=keyword%>_<%=factory%>_103_0.htm">混凝土机械</a>
      <ul <%if(catalog.equals("103")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_103_103001"> <a href="/search/<%=keyword%>_<%=factory%>_103001_0.htm" class="mainBrand"> 混凝土泵车 </a> </li>
        <li id="cat_103_103017"> <a href="/search/<%=keyword%>_<%=factory%>_103017_0.htm" class="mainBrand"> 车载泵 </a> </li>
        <li id="cat_103_103002"> <a href="/search/<%=keyword%>_<%=factory%>_103002_0.htm" class="mainBrand"> 混凝土搅拌设备 </a> </li>
        <li id="cat_103_103018"> <a href="/search/<%=keyword%>_<%=factory%>_103018_0.htm" class="mainBrand"> 拖泵 </a> </li>
        <li id="cat_103_103019"> <a href="/search/<%=keyword%>_<%=factory%>_103019_0.htm" class="mainBrand"> 混凝土搅拌运输车 </a> </li>
        <li id="cat_103_103020"> <a href="/search/<%=keyword%>_<%=factory%>_103020_0.htm" class="mainBrand"> 输送泵 </a> </li>
        <li id="cat_103_103005"> <a href="/search/<%=keyword%>_<%=factory%>_103005_0.htm" class="mainBrand"> 混凝土布料设备 </a> </li>
        <li id="cat_103_103010"> <a href="/search/<%=keyword%>_<%=factory%>_103010_0.htm" class="mainBrand"> 喷湿机 </a> </li>
        <li id="cat_103_103008"> <a href="/search/<%=keyword%>_<%=factory%>_103008_0.htm" class="mainBrand"> 干粉砂浆生产设备 </a> </li>
        <li id="cat_103_103009"> <a href="/search/<%=keyword%>_<%=factory%>_103009_0.htm" class="mainBrand"> 粉粒物料运输车 </a> </li>
        <li id="cat_103_103011"> <a href="/search/<%=keyword%>_<%=factory%>_103011_0.htm" class="mainBrand"> 沥青砂浆车 </a> </li>
        <li id="cat_103_103012"> <a href="/search/<%=keyword%>_<%=factory%>_103012_0.htm" class="mainBrand"> 干混砂浆生产线 </a> </li>
        <li id="cat_103_103014"> <a href="/search/<%=keyword%>_<%=factory%>_103014_0.htm" class="mainBrand"> 干混砂浆背罐车 </a> </li>
        <li id="cat_103_103015"> <a href="/search/<%=keyword%>_<%=factory%>_103015_0.htm" class="mainBrand"> 其它混凝土设备 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("104")){%>class="cur"<%}%>><a href="/search/<%=keyword%>_<%=factory%>_104_0.htm">筑养路机械</a>
      <ul <%if(catalog.equals("104")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_104_104008"> <a href="/search/<%=keyword%>_<%=factory%>_104008_0.htm" class="mainBrand"> 稳定土厂拌设备 </a> </li>
        <li id="cat_104_104007"> <a href="/search/<%=keyword%>_<%=factory%>_104007_0.htm" class="mainBrand"> 沥青混合料搅拌设备 </a> </li>
        <li id="cat_104_104006"> <a href="/search/<%=keyword%>_<%=factory%>_104006_0.htm" class="mainBrand"> 稳定土拌合机 </a> </li>
        <li id="cat_104_104005"> <a href="/search/<%=keyword%>_<%=factory%>_104005_0.htm" class="mainBrand"> 铣刨机 </a> </li>
        <li id="cat_104_104002"> <a href="/search/<%=keyword%>_<%=factory%>_104002_0.htm" class="mainBrand"> 养护机械 </a> </li>
        <li id="cat_104_104004"> <a href="/search/<%=keyword%>_<%=factory%>_104004_0.htm" class="mainBrand"> 其它路面机械 </a> </li>
        <li id="cat_104_104001"> <a href="/search/<%=keyword%>_<%=factory%>_104001_0.htm" class="mainBrand"> 摊铺机 </a> </li>
        <li id="cat_104_104009"> <a href="/search/<%=keyword%>_<%=factory%>_104009_0.htm" class="mainBrand"> 沥青搅拌站 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("105")){%>class="cur"<%}%>><a href="/search/<%=keyword%>_<%=factory%>_105_0.htm">桩工机械</a>
      <ul <%if(catalog.equals("105")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_105_105027"> <a href="/search/<%=keyword%>_<%=factory%>_105027_0.htm" class="mainBrand"> 其它桩工机械 </a> </li>
        <li id="cat_105_105028"> <a href="/search/<%=keyword%>_<%=factory%>_105028_0.htm" class="mainBrand"> 截桩机/破桩机 </a> </li>
        <li id="cat_105_105026"> <a href="/search/<%=keyword%>_<%=factory%>_105026_0.htm" class="mainBrand"> 多轴钻孔机 </a> </li>
        <li id="cat_105_105019"> <a href="/search/<%=keyword%>_<%=factory%>_105019_0.htm" class="mainBrand"> 多功能钻机 </a> </li>
        <li id="cat_105_105018"> <a href="/search/<%=keyword%>_<%=factory%>_105018_0.htm" class="mainBrand"> 长螺旋钻孔机 </a> </li>
        <li id="cat_105_105017"> <a href="/search/<%=keyword%>_<%=factory%>_105017_0.htm" class="mainBrand"> 强夯机 </a> </li>
        <li id="cat_105_105015"> <a href="/search/<%=keyword%>_<%=factory%>_105015_0.htm" class="mainBrand"> 打桩锤 </a> </li>
        <li id="cat_105_105013"> <a href="/search/<%=keyword%>_<%=factory%>_105013_0.htm" class="mainBrand"> 液压步履式桩架 </a> </li>
        <li id="cat_105_105011"> <a href="/search/<%=keyword%>_<%=factory%>_105011_0.htm" class="mainBrand"> 打桩机 </a> </li>
        <li id="cat_105_105016"> <a href="/search/<%=keyword%>_<%=factory%>_105016_0.htm" class="mainBrand"> 连续墙钻机 </a> </li>
        <li id="cat_105_105009"> <a href="/search/<%=keyword%>_<%=factory%>_105009_0.htm" class="mainBrand"> 液压静力压桩机 </a> </li>
        <li id="cat_105_105007"> <a href="/search/<%=keyword%>_<%=factory%>_105007_0.htm" class="mainBrand"> 连续墙抓斗 </a> </li>
        <li id="cat_105_105005"> <a href="/search/<%=keyword%>_<%=factory%>_105005_0.htm" class="mainBrand"> 水平定向钻 </a> </li>
        <li id="cat_105_105004"> <a href="/search/<%=keyword%>_<%=factory%>_105004_0.htm" class="mainBrand"> 潜孔钻机 </a> </li>
        <li id="cat_105_105003"> <a href="/search/<%=keyword%>_<%=factory%>_105003_0.htm" class="mainBrand"> 旋挖钻机 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("106")){%>class="cur"<%}%>><a href="/search/<%=keyword%>_<%=factory%>_106_0.htm">压实机械</a>
      <ul <%if(catalog.equals("106")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_106_106001"> <a href="/search/<%=keyword%>_<%=factory%>_106001_0.htm" class="mainBrand"> 压路机 </a> </li>
        <li id="cat_106_106003"> <a href="/search/<%=keyword%>_<%=factory%>_106003_0.htm" class="mainBrand"> 压实机 </a> </li>
        <li id="cat_106_106004"> <a href="/search/<%=keyword%>_<%=factory%>_106004_0.htm" class="mainBrand"> 夯实机 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("107")){%>class="cur"<%}%>><a href="/search/<%=keyword%>_<%=factory%>_107_0.htm">叉车</a>
      <ul <%if(catalog.equals("107")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_107_107010"> <a href="/search/<%=keyword%>_<%=factory%>_107010_0.htm" class="mainBrand"> 专用叉车 </a> </li>
        <li id="cat_107_107005"> <a href="/search/<%=keyword%>_<%=factory%>_107005_0.htm" class="mainBrand"> 仓储叉车 </a> </li>
        <li id="cat_107_107003"> <a href="/search/<%=keyword%>_<%=factory%>_107003_0.htm" class="mainBrand"> 电动叉车 </a> </li>
        <li id="cat_107_107001"> <a href="/search/<%=keyword%>_<%=factory%>_107001_0.htm" class="mainBrand"> 内燃叉车 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("113")){%>class="cur"<%}%>><a href="/search/<%=keyword%>_<%=factory%>_113_0.htm">破碎设备</a>
      <ul <%if(catalog.equals("113")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_113_113002"> <a href="/search/<%=keyword%>_<%=factory%>_113002_0.htm" class="mainBrand"> 液压剪 </a> </li>
        <li id="cat_113_113001"> <a href="/search/<%=keyword%>_<%=factory%>_113001_0.htm" class="mainBrand"> 破碎锤 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("110")){%>class="cur"<%}%>><a href="/search/<%=keyword%>_<%=factory%>_110_0.htm">地下及矿山机械</a>
      <ul <%if(catalog.equals("110")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_110_110017"> <a href="/search/<%=keyword%>_<%=factory%>_110017_0.htm" class="mainBrand"> 隧道轨道设备 </a> </li>
        <li id="cat_110_110018"> <a href="/search/<%=keyword%>_<%=factory%>_110018_0.htm" class="mainBrand"> 扒渣机 </a> </li>
        <li id="cat_110_110016"> <a href="/search/<%=keyword%>_<%=factory%>_110016_0.htm" class="mainBrand"> 全液压凿岩钻机 </a> </li>
        <li id="cat_110_110015"> <a href="/search/<%=keyword%>_<%=factory%>_110015_0.htm" class="mainBrand"> 输送和辅助设备 </a> </li>
        <li id="cat_110_110014"> <a href="/search/<%=keyword%>_<%=factory%>_110014_0.htm" class="mainBrand"> 连续采煤机和隧道掘进机 </a> </li>
        <li id="cat_110_110013"> <a href="/search/<%=keyword%>_<%=factory%>_110013_0.htm" class="mainBrand"> 装载及搬运设备 </a> </li>
        <li id="cat_110_110012"> <a href="/search/<%=keyword%>_<%=factory%>_110012_0.htm" class="mainBrand"> 筛分机 </a> </li>
        <li id="cat_110_110011"> <a href="/search/<%=keyword%>_<%=factory%>_110011_0.htm" class="mainBrand"> 凿岩机和钻机 </a> </li>
        <li id="cat_110_110010"> <a href="/search/<%=keyword%>_<%=factory%>_110010_0.htm" class="mainBrand"> 凿岩钻车 </a> </li>
        <li id="cat_110_110009"> <a href="/search/<%=keyword%>_<%=factory%>_110009_0.htm" class="mainBrand"> 破碎机 </a> </li>
        <li id="cat_110_110008"> <a href="/search/<%=keyword%>_<%=factory%>_110008_0.htm" class="mainBrand"> 凿岩台车 </a> </li>
        <li id="cat_110_110005"> <a href="/search/<%=keyword%>_<%=factory%>_110005_0.htm" class="mainBrand"> 采煤机 </a> </li>
        <li id="cat_110_110002"> <a href="/search/<%=keyword%>_<%=factory%>_110002_0.htm" class="mainBrand"> 矿用掘进机 </a> </li>
        <li id="cat_110_110001"> <a href="/search/<%=keyword%>_<%=factory%>_110001_0.htm" class="mainBrand"> 盾构掘进机 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("119")){%>class="cur"<%}%>><a href="/search/<%=keyword%>_<%=factory%>_119_0.htm">煤炭机械</a>
      <ul <%if(catalog.equals("119")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_119_119001"> <a href="/search/<%=keyword%>_<%=factory%>_119001_0.htm" class="mainBrand"> 煤炭机械 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("109")){%>class="cur"<%}%>><a href="/search/<%=keyword%>_<%=factory%>_109_0.htm">桥梁机械</a>
      <ul <%if(catalog.equals("119")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_109_109006"> <a href="/search/<%=keyword%>_<%=factory%>_109006_0.htm" class="mainBrand"> 砂浆车 </a> </li>
        <li id="cat_109_109005"> <a href="/search/<%=keyword%>_<%=factory%>_109005_0.htm" class="mainBrand"> 检测车 </a> </li>
        <li id="cat_109_109004"> <a href="/search/<%=keyword%>_<%=factory%>_109004_0.htm" class="mainBrand"> 提梁机 </a> </li>
        <li id="cat_109_109002"> <a href="/search/<%=keyword%>_<%=factory%>_109002_0.htm" class="mainBrand"> 运梁车 </a> </li>
        <li id="cat_109_109001"> <a href="/search/<%=keyword%>_<%=factory%>_109001_0.htm" class="mainBrand"> 架桥机 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("111")){%>class="cur"<%}%>><a href="/search/<%=keyword%>_<%=factory%>_111_0.htm">港口机械</a>
      <ul <%if(catalog.equals("111")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_111_111008"> <a href="/search/<%=keyword%>_<%=factory%>_111008_0.htm" class="mainBrand"> 海工装备 </a> </li>
        <li id="cat_111_111007"> <a href="/search/<%=keyword%>_<%=factory%>_111007_0.htm" class="mainBrand"> 推耙机 </a> </li>
        <li id="cat_111_111006"> <a href="/search/<%=keyword%>_<%=factory%>_111006_0.htm" class="mainBrand"> 场桥 </a> </li>
        <li id="cat_111_111003"> <a href="/search/<%=keyword%>_<%=factory%>_111003_0.htm" class="mainBrand"> 吊具 </a> </li>
        <li id="cat_111_111002"> <a href="/search/<%=keyword%>_<%=factory%>_111002_0.htm" class="mainBrand"> 堆高机 </a> </li>
        <li id="cat_111_111001"> <a href="/search/<%=keyword%>_<%=factory%>_111001_0.htm" class="mainBrand"> 正面吊 </a> </li>
      </ul>
    </li>
    <li <%if(catalog.equals("118")){%>class="cur"<%}%>><a href="/search/<%=keyword%>_<%=factory%>_118_0.htm">专用汽车</a>
      <ul <%if(catalog.equals("118")){%>style="display:block"<%}else{%>style="display:none"<%}%>>
        <li id="cat_118_118003"> <a href="/search/<%=keyword%>_<%=factory%>_118003_0.htm" class="mainBrand"> 消防车 </a> </li>
        <li id="cat_118_118004"> <a href="/search/<%=keyword%>_<%=factory%>_118004_0.htm" class="mainBrand"> 牵引车 </a> </li>
        <li id="cat_118_118002"> <a href="/search/<%=keyword%>_<%=factory%>_118002_0.htm" class="mainBrand"> 专用车辆 </a> </li>
      </ul>
    </li>
  </ul>
</div>
