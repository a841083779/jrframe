<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%
   	String year = CommonString.getFilterStr(request.getParameter("year")) ;
	String month = CommonString.getFilterStr(request.getParameter("month")) ;
    String season = CommonString.getFilterStr(request.getParameter("season")) ;
	String area = CommonString.getFilterStr(request.getParameter("area")) ;
	String tonnage = CommonString.getFilterStr(request.getParameter("tonnage")) ;
%>
	<div id="leftId">
      <div class="w208 border01 l leftPart mb10">
        <h2>类型</h2>
        
        <div style="height:487px;*height:453px; overflow-x:hidden;overflow-y:scroll;" id="agent_tab02" class="w208 l leftPart mb10">
          <ul>
            <li>
              <h3 class="agent_tab_name">土方机械</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_101001_<%=area.equals("")?"0":area%>.htm">挖掘机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_101002_<%=area.equals("")?"0":area%>.htm">装载机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_101003_<%=area.equals("")?"0":area%>.htm">推土机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_101004_<%=area.equals("")?"0":area%>.htm">铲运机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_101005_<%=area.equals("")?"0":area%>.htm">平地机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_101008_<%=area.equals("")?"0":area%>.htm">自卸卡车</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">起重机</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_102007_<%=area.equals("")?"0":area%>.htm">汽车起重机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_102006_<%=area.equals("")?"0":area%>.htm">随车起重机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_102008_<%=area.equals("")?"0":area%>.htm">履带式起重机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_102002_<%=area.equals("")?"0":area%>.htm">塔式起重机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_102003_<%=area.equals("")?"0":area%>.htm">高空作业平台</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_102010_<%=area.equals("")?"0":area%>.htm">高空作业车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_102011_<%=area.equals("")?"0":area%>.htm">施工升降机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_102012_<%=area.equals("")?"0":area%>.htm">伸缩臂叉装机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_102013_<%=area.equals("")?"0":area%>.htm">桥梁式起重机</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">混凝土机械</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103001_<%=area.equals("")?"0":area%>.htm">混凝土泵车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103017_<%=area.equals("")?"0":area%>.htm">车载泵</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103018_<%=area.equals("")?"0":area%>.htm">拖泵</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103002_<%=area.equals("")?"0":area%>.htm">混凝土搅拌设备</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103019_<%=area.equals("")?"0":area%>.htm">混凝土搅拌运输车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103005_<%=area.equals("")?"0":area%>.htm">混凝土布料设备</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103010_<%=area.equals("")?"0":area%>.htm">喷湿机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103008_<%=area.equals("")?"0":area%>.htm">干粉砂浆生产设备</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103009_<%=area.equals("")?"0":area%>.htm">粉粒物料运输车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103020_<%=area.equals("")?"0":area%>.htm">输送泵</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103011_<%=area.equals("")?"0":area%>.htm">沥青砂浆车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103012_<%=area.equals("")?"0":area%>.htm">干混砂浆生产线</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103014_<%=area.equals("")?"0":area%>.htm">干混砂浆背罐车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_103015_<%=area.equals("")?"0":area%>.htm">其它混凝土设备</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">筑养路机械</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_104001_<%=area.equals("")?"0":area%>.htm">摊铺机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_104004_<%=area.equals("")?"0":area%>.htm">其它路面机械</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_104002_<%=area.equals("")?"0":area%>.htm">养护机械</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_104005_<%=area.equals("")?"0":area%>.htm">铣刨机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_104006_<%=area.equals("")?"0":area%>.htm">稳定土拌合机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_104007_<%=area.equals("")?"0":area%>.htm">沥青混合料搅拌设备</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_104008_<%=area.equals("")?"0":area%>.htm">稳定土厂拌设备</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_104009_<%=area.equals("")?"0":area%>.htm">沥青搅拌站</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">桩工机械</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105003_<%=area.equals("")?"0":area%>.htm">旋挖钻机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105004_<%=area.equals("")?"0":area%>.htm">潜孔钻机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105005_<%=area.equals("")?"0":area%>.htm">水平定向钻</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105007_<%=area.equals("")?"0":area%>.htm">连续墙抓斗</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105009_<%=area.equals("")?"0":area%>.htm">液压静力压桩机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105016_<%=area.equals("")?"0":area%>.htm">连续墙钻机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105011_<%=area.equals("")?"0":area%>.htm">打桩机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105013_<%=area.equals("")?"0":area%>.htm">液压步履式桩架</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105015_<%=area.equals("")?"0":area%>.htm">打桩锤</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105017_<%=area.equals("")?"0":area%>.htm">强夯机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105018_<%=area.equals("")?"0":area%>.htm">长螺旋钻孔机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105019_<%=area.equals("")?"0":area%>.htm">多功能钻机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105026_<%=area.equals("")?"0":area%>.htm">多轴钻孔机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105027_<%=area.equals("")?"0":area%>.htm">其它桩工机械</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_105028_<%=area.equals("")?"0":area%>.htm">截桩机/破桩机</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">压实机械</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_106001_<%=area.equals("")?"0":area%>.htm">压路机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_106003_<%=area.equals("")?"0":area%>.htm">压实机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_106004_<%=area.equals("")?"0":area%>.htm">夯实机</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">叉车</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_107001_<%=area.equals("")?"0":area%>.htm">内燃叉车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_107003_<%=area.equals("")?"0":area%>.htm">电动叉车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_107005_<%=area.equals("")?"0":area%>.htm">仓储叉车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_107010_<%=area.equals("")?"0":area%>.htm">专用叉车</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">桥梁机械</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_109001_<%=area.equals("")?"0":area%>.htm">架桥机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_109002_<%=area.equals("")?"0":area%>.htm">运梁车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_109004_<%=area.equals("")?"0":area%>.htm">提梁机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_109005_<%=area.equals("")?"0":area%>.htm">检测车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_109006_<%=area.equals("")?"0":area%>.htm">砂浆车</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">地下及矿山机械</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110001_<%=area.equals("")?"0":area%>.htm">盾构掘进机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110002_<%=area.equals("")?"0":area%>.htm">矿用掘进机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110005_<%=area.equals("")?"0":area%>.htm">采煤机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110008_<%=area.equals("")?"0":area%>.htm">凿岩台车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110009_<%=area.equals("")?"0":area%>.htm">破碎机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110010_<%=area.equals("")?"0":area%>.htm">凿岩钻车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110011_<%=area.equals("")?"0":area%>.htm">凿岩机和钻机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110012_<%=area.equals("")?"0":area%>.htm">筛分机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110013_<%=area.equals("")?"0":area%>.htm">装载及搬运设备</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110014_<%=area.equals("")?"0":area%>.htm">连续采煤机和隧道掘进机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110015_<%=area.equals("")?"0":area%>.htm">输送和辅助设备</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110016_<%=area.equals("")?"0":area%>.htm">全液压凿岩钻机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110017_<%=area.equals("")?"0":area%>.htm">隧道轨道设备</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_110018_<%=area.equals("")?"0":area%>.htm">扒渣机</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">港口机械</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_111001_<%=area.equals("")?"0":area%>.htm">正面吊</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_111002_<%=area.equals("")?"0":area%>.htm">堆高机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_111003_<%=area.equals("")?"0":area%>.htm">吊具</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_111006_<%=area.equals("")?"0":area%>.htm">场桥</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_111007_<%=area.equals("")?"0":area%>.htm">推耙机</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_111008_<%=area.equals("")?"0":area%>.htm">海工装备</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">破碎设备</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_113001_<%=area.equals("")?"0":area%>.htm">破碎锤</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_113002_<%=area.equals("")?"0":area%>.htm">液压剪</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">专用汽车</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_118002_<%=area.equals("")?"0":area%>.htm">专用车辆</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_118003_<%=area.equals("")?"0":area%>.htm">消防车</a></li>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_118004_<%=area.equals("")?"0":area%>.htm">牵引车</a></li>
              </ul>
            </li>
            <li>
              <h3 class="agent_tab_name">煤炭机械</h3>
              <ul>
                <li><a href="/brand_<%=year.equals("")?"0":year%>_<%=month.equals("")?"0":month%>_<%=season.equals("")?"0":season%>_119001_<%=area.equals("")?"0":area%>.htm">煤炭机械</a></li>
              </ul>
            </li>
          </ul>
        </div>
        
      </div>
    </div>