<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,org.apache.commons.httpclient.*,org.apache.commons.httpclient.methods.*" pageEncoding="UTF-8"%>
<link href="/Static/css/common.css" rel="stylesheet" />
<link href="/Static/css/ui.css" rel="stylesheet" />
<style>
body { overflow-y: hidden; } 
</style>
<!--topBar--> 
<div class="j_topBar">
  <div class="wrap fix">
    <div class="j_wel l j_grey" id="topLabel"><a href="http://www.21-sun.com/" target="_blank">欢迎您访问中国工程机械商贸网！</a><a href="http://product.21-sun.com/user/login.htm"  target="_blank">[登录]</a>&nbsp;&nbsp;<a href="http://product.21-sun.com/user/reg.htm" target="_blank">[注册]</a></div>
    <ul class="j_t_layer r">
      <li class="j_tl j_wei"><a href="http://www.21-sun.com/weixin/" target="_blank"><img width="74" height="20" style="margin-top:4px;" src="http://www.21-sun.com/weixin/images/weixin.jpg"></a></li>
      <li class="j_tl j_mobile">
        <div class="j_con"> <span class="j_n"><i class="ico"></i>手机商城<i class="ico ico1_3"></i></span>
          <div class="j_tlayer">
            <div><a href="http://www.21-sun.com/app/" target="_blank" rel="nofollow">手机商贸网</a></div>
            <div><a href="http://www.21-sun.com/app/phone_news.htm" target="_blank" rel="nofollow">工程机械动态</a></div>
            <div><img src="/Static/images/ewm01.png" class="j_ewm">行业讯息</div>
            <div style="border:none;"><img src="/Static/images/ewm02.png" class="j_ewm">铁臂商城微信</div>
          </div>
        </div>
      </li>
      <li class="j_tl j_about">
        <div class="j_con"> <span class="j_n"><a href="http://product.21-sun.com/about/" target="_blank" rel="nofollow">关于铁臂</a></span> </div>
      </li>
      <li class="j_tl j_siteNav">
        <div class="j_con"> <span class="j_n">网站导航<i class="ico ico1_3"></i></span>
          <div class="j_tlayer">
            <ul class="fix">
              <li onClick="window.open('http://product.21-sun.com/');">铁臂商城</li>
              <li onClick="window.open('http://photo.21-sun.com/');">产品图库</li>
              <li onClick="window.open('http://weixiu.21-sun.com/');">维　　修</li>
              <li onClick="window.open('http://koubei.21-sun.com/');">口　　碑</li>
              <li onClick="window.open('http://market.21-sun.com/');">供求市场</li>
              <li onClick="window.open('http://news.21-sun.com/');">行业动态</li>
              <li onClick="window.open('http://used.21-sun.com/');">二手设备</li>
              <li onClick="window.open('http://www.21-sun.com/part/');">配件市场</li>
              <li onClick="window.open('http://www.21part.com/');">杰 配 网</li>
              <li onClick="window.open('http://www.21-sun.com/supply/');">供 应 商</li>
              <li onClick="window.open('http://www.21taiyang.com/');">太阳商城</li>
              <li onClick="window.open('http://www.wajueji.com/');">铁臂兄弟连</li>
              <li onClick="window.open('http://dealer.21-sun.com/');">代理商</li>
              <li onClick="window.open('http://product.21-sun.com/about/case.htm');">旗舰店</li>
            </ul>
          </div>
        </div>
      </li>
      <li class="j_tl j_proNav">
        <div class="j_con topBigGuide"><span class="j_n">购机导航<i class="ico ico1_3"></i></span>
		<div class="j_tlayer j_prol">
  <ul class="fix">
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001" class="j_link01" title="挖掘机/属具">挖掘机/属具</a> <a href="http://product.21-sun.com/brand/ht95/" title="恒天九五挖掘机">恒天九五挖掘机</a></div>
     <a href="http://product.21-sun.com/brand/jcm/" class="j_link02" title="山重">山重</a> <a href="http://product.21-sun.com/brand/hi-tech/" class="j_link02" title="普堃韩泰克">普堃韩泰克</a> <a href="http://product.21-sun.com/brand/eddie/" class="j_link02" title="艾迪">艾迪</a> <a href="http://product.21-sun.com/brand/tike/" class="j_link02" title="泰科">泰科</a> <a href="http://product.21-sun.com/brand/ytxinrenty/" class="j_link02" title="DBK">DBK</a> <br> 
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001001" title="履带挖掘机">履带挖掘机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001004" title="轮式挖掘机">轮式挖掘机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001007" title="特种挖掘机">特种挖掘机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001098" title="破碎锤">破碎锤</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001099" title="液压剪">液压剪</a> </li>
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101001" class="j_link01" title="装载机">装载机</a> </div>
      <a href="http://product.21-sun.com/brand/sdlg/" class="j_link02" title="临工">临工</a>
       <a href="http://product.21-sun.com/brand/liugong/" class="j_link02" title="柳工">柳工</a>
	  <a href="http://product.21-sun.com/brandshop/xuangong/" class="j_link02" title="宣工">宣工</a><a href="http://ad.21-sun.com/link_to.jsp?paras=101,101,6850&amp;url=http://product.21-sun.com/brand/yingxuan/" class="j_link02" title="英轩">英轩</a> <br> 
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002007" title="轮式装载机">轮式装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002003" title="履带装载机">履带装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002004" title="特种装载机">特种装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002008" title="挖掘装载机">挖掘装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002009" title="滑移装载机">滑移装载机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101002010" title="滑移装载机">滑移装载机</a> </li>
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=102" class="j_link01" title="起重机">起重机</a><span class="j_tr"> <a href="http://used.21-sun.com/qizhongji/0-0-0-0-0-0-0-0-0.htm" title="二手">二手</a> / <a href="http://rent.21-sun.com/equipment/index.jsp?find_category=02" title="起重机械">租赁</a></span> </div>
	  <a href="http://product.21-sun.com/brand/xcmg/" class="j_link02" title="徐工">徐工</a> <a href="http://product.21-sun.com/brand/sany/" class="j_link02" title="三一">三一</a> <a href="http://product.21-sun.com/brand/zoomlion/" class="j_link02" title="中联">中联</a> <a href="http://product.21-sun.com/brand/fuwa/" class="j_link02" title="抚挖">抚挖</a> <a href="http://product.21-sun.com/brand/liugong/" class="j_link02" title="柳工">柳工</a> <a rel="nofollow" href="http://www.sinoboom.com.cn/" class="j_link02" title="星邦重工">星邦重工</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102007" title="汽车起重机">汽车起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102002" title="塔式起重机">塔式起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102003" title="高空作业车/平台">高空作业车/平台</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102006" title="随车起重机">随车起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102008" title="履带式起重机">履带式起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102012" title="伸缩臂叉装机">伸缩臂叉装机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102011" title="施工升降机">施工升降机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=102013" title="龙门/桥梁起重机">龙门/桥梁起重机</a> </li>   
   <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001" class="j_link01" title="压路机/压实机/夯">压路机/压实机/夯</a> <a href="http://ad.21-sun.com/link_to.jsp?paras=101,101,4544&amp;url=www.green-belt.cn/" title="垂直振动压路机">垂直振动压路机</a></div>
      <a href="http://product.21-sun.com/brand/gjzjyituo/" class="j_link02" title="洛建">洛建</a> <a href="http://product.21-sun.com/brand/shantui/" class="j_link02" title="山推">山推</a> <a href="http://product.21-sun.com/brand/sany/" class="j_link02" title="三一">三一</a> <a href="http://product.21-sun.com/brand/zoomlion/" class="j_link02" title="中联">中联</a> <a href="http://product.21-sun.com/brand/xcmg/" class="j_link02" title="徐工">徐工</a> <a href="http://product.21-sun.com/brand/changlin/" class="j_link02" title="常林">常林</a><br>
	  <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001001" title="单钢轮压路机">单钢轮压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001002" title="双钢轮压路机">双钢轮压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001003" title="三钢轮压路机">三钢轮压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001005" title="轮胎压路机">轮胎压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001004" title="手扶压路机">手扶压路机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001020" title="压实机">压实机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=106001021" title="夯实机">夯实机</a> </li>
    <li >
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003" class="j_link01" title="推土机">推土机</a> </div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003001" title="履带推土机">履带推土机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101003004" title="轮式推土机">轮式推土机</a> </li>
    <li >
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005" class="j_link01" title="平地机/铲运机">平地机/铲运机</a> </div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005001" title="自行式铲运机">自行式铲运机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101005002" title="自行式平地机">自行式平地机</a> </li>
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=109" class="j_link01" title="桥梁机械">桥梁机械</a> </div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109006" title="砂浆车">砂浆车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109005" title="检测车">检测车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109004" title="提梁机">提梁机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109002" title="运梁车">运梁车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=109001" title="架桥机">架桥机</a> </li>
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008" class="j_link01" title="自卸卡车/矿卡">自卸卡车/矿卡</a> </div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008002" title="刚性自卸卡车">刚性自卸卡车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=101008001" title="铰接式自卸卡车">铰接式自卸卡车</a> </li>
	<li  style="margin-top:-45px">
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=110" class="j_link01" title="地下及矿山机械">地下及矿山机械</a> </div>
      <a href="http://product.21-sun.com/brandshop/tiejian/" class="j_link02" title="铁建重工">铁建重工</a> <a href="http://product.21-sun.com/brand/kym/" class="j_link02" title="开元">开元</a> <a href="http://product.21-sun.com/brand/stwkks/" class="j_link02" title="山特维克">山特维克</a> <a href="http://product.21-sun.com/brand/carter/" class="j_link02" title="卡特重工">卡特重工</a> <a href="http://product.21-sun.com/brand/shanbao/" class="j_link02" title="山宝">山宝</a><br>
	  <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110001" title="盾构机">盾构机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110002" title="掘进机">掘进机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110008" title="凿岩台车/钻机">凿岩台车/钻机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110009" title="破碎机">破碎机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110012" title="筛分机">筛分机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110013" title="装载及搬运设备">装载及搬运设备</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110018" title="扒渣机">扒渣机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=110019" title="采煤机">采煤机</a> </li>
	<li  style="margin-top:-45px">
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=105" class="j_link01" title="桩工机械">桩工机械</a><span class="j_tr"> <a href="http://rent.21-sun.com/equipment/index.jsp?find_category=07" title="租赁">租赁</a></span> </div>
	  <a href="http://ad.21-sun.com/link_to.jsp?paras=101,101,7238&amp;url=http://product.21-sun.com/brandshop/hnxth/" class="j_link02" title="新天和">新天和</a> <a href="http://product.21-sun.com/brand/xcmg/" class="j_link02" title="徐工">徐工</a> <a href="http://product.21-sun.com/brand/hualizg/" class="j_link02" title="华力">华力</a> <a href="http://product.21-sun.com/brand/dongda/" class="j_link02" title="东达">东达</a> <a class="j_link02" href="http://product.21-sun.com/brand/ht95/" title="恒天九五">恒天九五</a> <a class="j_link02" href="http://product.21-sun.com/brand/yonganjixie/" title="永安">永安</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105003" title="旋挖钻机">旋挖钻机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105004" title="潜孔钻机">潜孔钻机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105005" title="水平定向钻">水平定向钻</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105007" title="连续墙设备">连续墙设备</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105018" title="螺旋钻机">螺旋钻机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105009" title="压桩机/打桩机">压桩机/打桩机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105028" title="截桩机/破桩机">截桩机/破桩机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=105027" title="其它桩工机械">其它桩工机械</a> </li>
	<li  style="margin-top:-45px">
        <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103" class="j_link01" title="混凝土机械">混凝土机械</a><a href="http://ad.21-sun.com/link_to.jsp?paras=101,101,7097&amp;url=http://product.21-sun.com/brand/roady/" title="陆德筑机">陆德筑机</a><span class="j_tr"> <a href="http://used.21-sun.com/hunningtu/0-0-0-0-0-0-0-0-0-0.htm" title="二手">二手</a> / <a href="http://rent.21-sun.com/equipment/index.jsp?find_category=03" title="租赁">租赁</a></span></div>
      <a href="http://product.21-sun.com/brand/lingyu/" class="j_link02" title="中集凌宇">中集凌宇</a> <a href="http://product.21-sun.com/brand/sany/" class="j_link02" title="三一">三一</a> <a href="http://product.21-sun.com/brand/shenglida8/" class="j_link02" title="盛利达">盛利达</a> <a href="http://product.21-sun.com/brand/haizhoujx/" class="j_link02" title="海州">海州</a> <a href="http://product.21-sun.com/brand/ftls/" class="j_link02" title="雷萨">雷萨</a> <a href="http://product.21-sun.com/brand/shantui/" class="j_link02" title="山推">山推</a><br>
	  <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001" title="混凝土泵车">混凝土泵车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103019" title="混凝土搅拌运输车">搅拌运输车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103017" title="车载泵">车载泵</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103018" title="拖泵">拖泵</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103020" title="输送泵">输送泵</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103002" title="混凝土搅拌站/楼/车">搅拌站/楼/车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103005" title="混凝土布料杆/车">布料杆/车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103008" title="干粉/砂浆生产设备">干粉/砂浆生产设备</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103010" title="喷湿机">喷湿机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103015" title="其它混凝土设备">其它混凝土设备</a> </li>
    
	<li  style="margin-top:-45px">
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=104" class="j_link01" title="路面机械">路面机械</a> </div>
	  <a href="http://product.21-sun.com/brand/xizhu/" class="j_link02" title="中交西筑">中交西筑</a> <a href="http://product.21-sun.com/brand/rehorkj/" class="j_link02" title="雷奥">雷奥</a> <a href="http://product.21-sun.com/brand/xcmg/" class="j_link02" title="徐工">徐工</a> <br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104001" title="摊铺机">摊铺机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104005" title="铣刨机">铣刨机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104003" title="开槽机/灌缝机">开槽机/灌缝机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104004" title="路面破碎机">破碎机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104002" title="再生/修补机械">再生/修补机械</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104008" title="稳定土厂拌设备">稳定土厂拌设备</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104009" title="沥青搅拌/转运">沥青搅拌/转运</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=104006" title="沥青洒布/碎石散布机">沥青洒布/碎石散布机</a> </li>
    	<li>
      <div class="j_t" style="margin-top:5px"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=118" class="j_link01" title="专用车辆">专用车辆</a> <span class="j_tr"> <a href="http://rent.21-sun.com/equipment/index.jsp?find_category=06" title="租赁">租赁</a></span></div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118001" title="普通载货车">普通载货车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118013" title="公路牵引车">公路牵引车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118004" title="场地牵引车">场地牵引车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118003" title="消防车">消防车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118012" title="清障车">清障车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118005" title="冷藏车">冷藏车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118006" title="货厢车">货厢车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118007" title="粉罐车">粉罐车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118008" title="油罐车">油罐车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118009" title="液罐车">液罐车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118010" title="翻斗车">翻斗车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118011" title="渣土车">渣土车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118014" title="半挂车">半挂车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=118002" title="其他专用车">其他专用车</a> </li>
    <li>
      <div class="j_t" style="margin-top:5px"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=107" class="j_link01" title="叉车">叉车</a> </div>
	  <a href="http://product.21-sun.com/brand/doosan/" class="j_link02" title="斗山">斗山</a> <a href="http://product.21-sun.com/brand/sunward/" class="j_link02" title="山河智能">山河智能</a> <a href="http://product.21-sun.com/brand/hyundai-bj/" class="j_link02" title="现代京城">现代京城</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107011" title="内燃平衡重叉车">内燃平衡重叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107012" title="电动叉车">电动叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107013" title="侧面叉车">侧面叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107014" title="前移叉车">前移叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107015" title="搬运车/托盘车">搬运车/托盘车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107016" title="堆高机/堆垛车">堆高机/堆垛车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107018" title="仓储叉车">仓储叉车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=107017" title="专用叉车">专用叉车</a> </li>
	<li >
      <div class="j_t" style="margin-top:5px"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=111" class="j_link01" title="港口机械">港口机械</a> </div>
	  <a href="http://product.21-sun.com/brand/sany" class="j_link02" title="三一">三一</a> <a href="http://product.21-sun.com/brand/liebherr/" class="j_link02" title="利勃海尔">利勃海尔</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111001" title="正面吊">正面吊</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111004" title="门式起重机">门式起重机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111002" title="码头堆高机">码头堆高机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111003" title="卸船机">卸船机</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=111007" title="推耙机">推耙机</a> </li>
	<li  >
      <div class="j_t" style="margin-top:5px"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=122" class="j_link01" title="环卫车辆">环卫车辆</a> </div>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122001" title="清扫车">清扫车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122002" title="垃圾车">垃圾车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122003" title="清雪车">清雪车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122004" title="酒水车">酒水车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=122005" title="污水粪便车">污水粪便车</a> </li> 
	<!--
    <li>
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=103" class="j_link01" title="混凝土机械">混凝土机械</a><span class="j_tr"> <a href="http://used.21-sun.com/hunningtu/0-0-0-0-0-0-0-0-0-0.htm" title="二手">二手</a> / <a href="http://rent.21-sun.com/equipment/index.jsp?find_category=03" title="租赁">租赁</a></span></div>
      <a href="http://product.21-sun.com/brand/lingyu/" class="j_link02" title="中集凌宇">中集凌宇</a> <a href="http://product.21-sun.com/brand/sany/" class="j_link02" title="三一">三一</a> <a href="http://product.21-sun.com/brand/shenglida8/" class="j_link02" title="盛利达">盛利达</a> <a href="http://product.21-sun.com/brand/haizhoujx/" class="j_link02" title="海州">海州</a> <a href="http://product.21-sun.com/brand/ftls/" class="j_link02" title="雷萨">雷萨</a> <a href="http://product.21-sun.com/brand/shantui/" class="j_link02" title="山推">山推</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001001" title="泵车">泵车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103001002" title="车载泵">车载泵</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103006" title="混凝土搅拌运输车">混凝土搅拌运输车</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103002002" title="搅拌站">搅拌站 </a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103002003" title="搅拌楼">搅拌楼</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=103015" title="其它混凝土机械"> 其它混凝土机械</a> </li>
    <li>
   <li class="j_short">
      <div class="j_t"><a href="http://product.21-sun.com/products/prolist.jsp?catalog=113" class="j_link01" title="破碎设备">破碎设备</a></div>
      <a href="http://product.21-sun.com/brand/hi-tech/" class="j_link02" title="普堃韩泰克">普堃韩泰克</a> <a href="http://product.21-sun.com/brand/eddie/" class="j_link02" title="艾迪">艾迪</a> <a href="http://product.21-sun.com/brand/ytbaicai/" class="j_link02" title="百财">百财</a> <a href="http://product.21-sun.com/brand/tike/" class="j_link02" title="泰科">泰科</a> <a href="http://product.21-sun.com/brand/ytxinrenty/" class="j_link02" title="DBK">DBK</a> <a href="http://product.21-sun.com/brand/ytjixing/" class="j_link02" title="吉星">吉星</a><br>
      <a href="http://product.21-sun.com/products/prolist.jsp?catalog=113001" title="破碎锤">破碎锤</a> <a href="http://product.21-sun.com/products/prolist.jsp?catalog=113002" title="液压剪">液压剪</a>
	</li>
    -->
  </ul>
  <div class="j_proCates">
    <div> <strong>挖掘机：</strong>
      <p> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=174&amp;catalog=101001" title="卡特挖掘机">卡特挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=182&amp;catalog=101001" title="小松挖掘机">小松挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=133&amp;catalog=101001" title="三一挖掘机">三一挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=184&amp;catalog=101001" title="日立挖掘机">日立挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=183&amp;catalog=101001" title="神钢挖掘机">神钢挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&amp;catalog=101001" title="徐工挖掘机">徐工挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=175&amp;catalog=101001" title="沃尔沃挖掘机">沃尔沃挖掘机</a>  <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&amp;catalog=101001" title="龙工挖掘机">龙工挖掘机</a>  <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=137&amp;catalog=101001" title="临工挖掘机">临工挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&amp;catalog=101001" title="柳工挖掘机">柳工挖掘机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=141&amp;catalog=101001" title="福田雷沃挖掘机">福田雷沃挖掘机</a> </p>
    </div>
    <div> <strong>装载机：</strong>
      <p> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=138&amp;catalog=101002" title="山工装载机">山工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=136&amp;catalog=101002" title="柳工装载机">柳工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=135&amp;catalog=101002" title="龙工装载机">龙工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=209&amp;catalog=101002" title="徐工装载机">徐工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=137&amp;catalog=101002" title="临工装载机">临工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=139&amp;catalog=101002" title="厦工装载机">厦工装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=141&amp;catalog=101002" title="福田雷沃装载机">福田雷沃装载机</a> <a target="_blank" href="http://product.21-sun.com/products/prolist.jsp?factory=174&amp;catalog=101002" title="卡特装载机">卡特装载机</a> </p>
    </div>
  </div>
</div>
		</div>
      </li>
    </ul>
  </div>
</div>
<!--topBar end--> 
<!--top--> 
<div class="wrap fix n_top">
  <h1 class="new_logo"><a href="/" title="铁臂商城"><img src="/Static/images/logo.png" alt="铁臂商城"></a></h1>
  <div class="n_topSearch">
      <div class="input">
        <input id="keyword" name="keyword" type="text" placeholder="输入您要搜索的产品" onKeyDown="tjEnter1();">
      </div>
      <button type="button" class="topBtn" onclick="tj3()">搜索</button>
  </div>
  <script>
  	  function tj3(){ 
		  if(jQuery('#keyword').val()==''){
		     alert("请输入您要搜索的关键词");
		     jQuery('#keyword').focus();
			 return false;
		  }
		  var keyword=jQuery('#keyword').val();
		  window.open("http://product.21-sun.com/search/"+keyword+"_0_0_0.htm");
	  }
	 function tjEnter1(){
		$('#keyword').on('keydown', function (e) {
		    if (e.keyCode == 13){
		        if(jQuery('#keyword').val()==''){
		            //alert("请输入您要搜索的关键词");
		            jQuery('#keyword').focus();
			        return false;
		        }
				var keyword=jQuery('#keyword').val();
		         window.open("http://product.21-sun.com/search/"+keyword+"_0_0_0.htm");
			}
        })
	 }
  </script>
  <div class="n_hotwords"> <a target="_blank" href="http://product.21-sun.com/search/%E6%8C%96%E6%8E%98%E6%9C%BA_0_0_0.htm">挖掘机</a><a target="_blank" href="http://product.21-sun.com/search/%E8%A3%85%E8%BD%BD%E6%9C%BA_0_0_0.htm">装载机</a><a target="_blank" href="http://product.21-sun.com/search/%E8%B5%B7%E9%87%8D%E6%9C%BA_0_0_0.htm">起重机</a><br>
    <a target="_blank" href="http://product.21-sun.com/search/%E5%8E%8B%E8%B7%AF%E6%9C%BA_0_0_0.htm">压路机</a><a target="_blank" href="http://product.21-sun.com/search/%E5%B9%B3%E5%9C%B0%E6%9C%BA_0_0_0.htm">平地机</a><a target="_blank" href="http://product.21-sun.com/products/" class="more">更多<i class="ion">&#xe69f;</i></a> </div>
    <!--<div class="n_tel"><img src="/Static/images/tel.png" alt="4006-521-526"></div>-->
</div>
<!--top end--> 
<!--nav--> 
<style>
.navBar .menus { margin-left:220px;}
.navBar .menus li { float:left; margin-right:2px;}
.navBar .menus a { display:inline-block; width:auto; height:35px; line-height:34px; padding:0 25px; font-size:16px; font-weight:bold;}
</style>
<div class="navBox">
  <div class="navBar">
    <div class="wrap fix" style="height:38px">
      <ul class="menus">
        <li><a href="http://product.21-sun.com/">商城首页</a></li>
        <li><a href="http://product.21-sun.com/products/prolist.jsp">设备导购</a></li>
        <li><a target="_blank"  href="http://product.21-sun.com/brand/">热销品牌</a></li>
        <li><a target="_blank"  href="http://product.21-sun.com/agent/">代理商</a></li>
        <li><a href="http://top.21-sun.com/">铁臂指数</a></li>
        <li><a target="_blank"  href="http://product.21-sun.com/about/qjd.htm">旗舰店</a></li>
        <li><a target="_blank"  href="http://product.21-sun.com/tuan/">优买团</a></li>
      </ul>
    <div class="nav_proCate"> <strong class="n">全部产品分类<i class="ico ico2_3"></i></strong>
      <div class="ShowAllCate">
        <ul class="sacontain">
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=101001">挖掘机/属具</a></h3>
            <ul>
              <li  class="short"> <a href="/products/prolist.jsp?catalog=101001001">履带挖掘机</a> </li>
              <li  class="short"><a href="/products/prolist.jsp?catalog=101001004">轮式挖掘机</a> </li>
              <li  class="short"><a href="/products/prolist.jsp?catalog=101001007">特种挖掘机</a>
              <li  class="short"><a href="/products/prolist.jsp?catalog=101001098">破碎器</a> </li>
              <li  class="short"><a href="/products/prolist.jsp?catalog=101001099">液压剪</a> </li>
            </ul>
             <h3><a href="/products/prolist.jsp?catalog=101002">装载机</a></h3>
            <ul>
              <li  class="short"> <a href="/products/prolist.jsp?catalog=101002007">轮式装载机</a> </li>
              <li  class="short"><a href="/products/prolist.jsp?catalog=101002003">履带装载机</a> </li>
              <li  class="short"><a href="/products/prolist.jsp?catalog=101002004">特种装载机</a>
              <li  class="short"><a href="/products/prolist.jsp?catalog=101002008">挖掘装载机</a> </li>
              <li  class="short"><a href="/products/prolist.jsp?catalog=101002009">滑移装载机</a> </li>
              <li  class="short"><a href="/products/prolist.jsp?catalog=101002010">叉装机</a> </li>
            </ul>
          </li>
 <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=102">起重机</a></h3>
            <ul>
              <li> <a href="/products/prolist.jsp?catalog=102007">汽车起重机</a> </li>
              <li><a href="/products/prolist.jsp?catalog=102002">塔式起重机</a></li>
              <li><a href="/products/prolist.jsp?catalog=102003">高空作业车/平台</a></li>
              <li><a href="/products/prolist.jsp?catalog=102006">随车起重机</a></li>
              <li><a href="/products/prolist.jsp?catalog=102008">履带起重机</a></li>
              <li><a href="/products/prolist.jsp?catalog=102012">伸缩臂叉装机</a></li>
              <li><a href="/products/prolist.jsp?catalog=102011">施工升降机</a></li>
              <li><a href="/products/prolist.jsp?catalog=102013">龙门/桥梁起重机</a></li>
            </ul>
          </li>
          <li class="scl inm">
            <h3><a href="/products/prolist.jsp?catalog=101003">推土机</a></h3>
            <ul>
              <li> <a href="/products/prolist.jsp?catalog=101003001">履带推土机</a> </li>
              <li><a href="/products/prolist.jsp?catalog=101003004">轮式推土机</a> </li>
            </ul>
            <h3><a href="/products/prolist.jsp?catalog=101005">平地/铲运机</a></h3>
            <ul>
              <li  class="short"> <a href="/products/prolist.jsp?catalog=101005001">铲运机</a> </li>
              <li  class="short"><a href="/products/prolist.jsp?catalog=101005002">平地机</a> </li>
            </ul>
            <h3><a href="/products/prolist.jsp?catalog=101008">自卸车/矿卡</a></h3>
            <ul>
              <li> <a href="/products/prolist.jsp?catalog=101008001">铰接式自卸卡车</a> </li>
              <li><a href="/products/prolist.jsp?catalog=101008002">钢性自卸卡车</a> </li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=103">混凝土设备</a></h3>
            <ul>
              <li><a href="/products/prolist.jsp?catalog=103001">混凝土泵车</a></li>
              <li><a href="/products/prolist.jsp?catalog=103019">混凝土搅拌运输车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=103017">车载泵</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=103018">拖泵</a></li>
              <li><a href="/products/prolist.jsp?catalog=103020">混凝土输送泵</a></li>
              <li><a href="/products/prolist.jsp?catalog=103002">混凝土搅拌站/车/楼</a></li>
              <li><a href="/products/prolist.jsp?catalog=103005">混凝土布料杆/车</a></li>
              <li><a href="/products/prolist.jsp?catalog=103008">干粉/砂浆生产设备</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=103010">喷湿机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=103015">其他混凝土设备</a></li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=104">路面机械</a></h3>
            <ul>
              <li class="short"><a href="/products/prolist.jsp?catalog=104001">摊铺机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=104005">铣刨机</a></li>
              <li><a href="/products/prolist.jsp?catalog=104002005">开槽机/灌缝机</a></li>
              <li><a href="/products/prolist.jsp?catalog=104004">路面破碎机</a></li>
              <li><a href="/products/prolist.jsp?catalog=104002">再生/修补机械</a></li>
              <li><a href="/products/prolist.jsp?catalog=104008">稳定土厂拌设备</a></li>
              <li><a href="/products/prolist.jsp?catalog=104009">沥青搅拌/转运</a></li>
              <li><a href="/products/prolist.jsp?catalog=104006">沥青洒布/碎石散布机</a></li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=105">钻机/桩机</a></h3>
            <ul>
              <li><a href="/products/prolist.jsp?catalog=105003">旋挖钻机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105004">潜孔钻机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105005">水平定向钻</a></li>
              <li><a href="/products/prolist.jsp?catalog=105007">连续墙设备</a></li>
              <li><a href="/products/prolist.jsp?catalog=105018">长螺旋钻孔机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105009">压桩/打桩机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105028">截桩机/破桩机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105027">其他钻机</a></li>
            </ul>
          </li>
         <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=106001">压路机/压实机/夯</a></h3>
            <ul>
              <li><a href="/products/prolist.jsp?catalog=106001001">单钢轮压路机</a></li>
              <li><a href="/products/prolist.jsp?catalog=106001002">双钢轮压路机</a></li>
              <li><a href="/products/prolist.jsp?catalog=106001003">三钢轮压路机</a></li>
              <li><a href="/products/prolist.jsp?catalog=106001005">轮胎压路机</a></li>
             <li><a href="/products/prolist.jsp?catalog=106001004">手扶压路机</a></li>
              <li><a href="/products/prolist.jsp?catalog=106001020">压实机</a></li>
              <li><a href="/products/prolist.jsp?catalog=106001021">夯实机</a></li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=104">叉车</a></h3>
            <ul>
              <li><a href="/products/prolist.jsp?catalog=107011">内燃平衡重叉车</a></li>
              <li><a href="/products/prolist.jsp?catalog=107012">电动式叉车</a></li>
              <li><a href="/products/prolist.jsp?catalog=107013">侧面叉车</a></li>
              <li><a href="/products/prolist.jsp?catalog=107014">前移叉车</a></li>
              <li><a href="/products/prolist.jsp?catalog=107015">电动/手动搬运车</a></li>
              <li><a href="/products/prolist.jsp?catalog=107016">堆垛车/堆高车</a></li>
              <li><a href="/products/prolist.jsp?catalog=107018">仓储叉车</a></li>
              <li><a href="/products/prolist.jsp?catalog=107017">其他叉车</a></li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=109">桥梁机械</a></h3>
            <ul>
              <li class="short"><a href="/products/prolist.jsp?catalog=109005">检测车</a></li>
              <li  class="short"><a href="/products/prolist.jsp?catalog=109004">提梁机</a></li>
              <li  class="short"><a href="/products/prolist.jsp?catalog=109002">运梁车</a></li>
              <li  class="short"><a href="/products/prolist.jsp?catalog=109001">架桥机</a></li>
            </ul>
            <h3><a href="/products/prolist.jsp?catalog=111">港口机械</a></h3>
            <ul>
              <li class="short"><a href="/products/prolist.jsp?catalog=111001">正面吊</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=111002">码头堆高机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=111003">卸船机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=111004">门式起重机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=111007">推耙机</a></li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=110">矿山/煤矿机械</a></h3>
            <ul>
              <li><a href="/products/prolist.jsp?catalog=110001">盾构机</a></li>
              <li><a href="/products/prolist.jsp?catalog=110002">掘进机</a></li>
              <li><a href="/products/prolist.jsp?catalog=110008">凿岩车/凿岩钻机</a></li>
              <li><a href="/products/prolist.jsp?catalog=110009">矿石破碎机</a></li>
              <li><a href="/products/prolist.jsp?catalog=110012">筛分机</a></li>
              <li><a href="/products/prolist.jsp?catalog=110013">输送/转载设备</a></li>
              <li><a href="/products/prolist.jsp?catalog=110018">扒渣机</a></li>
              <li><a href="/products/prolist.jsp?catalog=110019">采煤机</a></li>
            </ul>
          </li>

          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=118">专用车辆</a></h3>
            <ul>
              <li class="short"><a href="/products/prolist.jsp?catalog=118001">普通载货车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118013">公路牵引车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118004">场地牵引车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118003">消防车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118012">清障车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118005">冷藏车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118007">粉罐车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118008">油罐车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118009">液罐车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118010">翻斗车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118011">渣土车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118014">半挂车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=118002">其他专用车</a></li>
            </ul>
          </li>
          <li class="scl">
                    
            <h3><a href="/products/prolist.jsp?catalog=122">环卫车辆</a></h3>
            <ul>
              <li class="short"><a href="/products/prolist.jsp?catalog=122001">扫地车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=122002">垃圾车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=122003">清雪车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=122004">洒水车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=122005">污水/粪便车</a></li>
            </ul>
          </li>
          
        </ul>
        <ul class="ShowAllCateBottom">
           <a href="#" title="关闭" class="CloseAllBtn"></a>
        </ul>
      </div>
    </div>
    </div>
  </div>
</div>
<!--nav end-->
<script>
jQuery(function(){
    jQuery.post("/action/ajax.jsp", {
        flag: "isLogin_Tiebi"
    }, function(data){
        var tData = jQuery.trim(data);
        if (tData != 'no') {
            jQuery("#topLabel").html("<a href='http://www.21-sun.com/' target='_blank'>欢迎您访问中国工程机械商贸网！</a><a href='javascript:void(0);' onclick='logout();' style='text-decoration: underline;'>退出</a> | 欢迎您，<a target='_blank' href='/member/'>" + tData + "</a>");
           
        }
    });
});
//退出
function logout(){
	jQuery.ajax({
		url:'/action/ajax.jsp?flag=logout&r='+new Date(),
		async:false,
		cache:false,
		success:function(data){
			alert("您已退出登录！");
			setTimeout("window.location.reload()",1000);
		}
	});
}
</script>