<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%@ page session="false" %>
<%
	String type = CommonString.getFormatPara(request.getParameter("type")) ;
	if(type.equals("")){
		type = "Product";
	}
	String action = "/search/";
	if(type.equals("Photo")){
		action = "/search/photo.jsp";
	}
%>
<div class="topLinks">
  <div class="contain980">
    <div class="visit_21sun"><a rel="nofollow" target="_blank" href="http://www.21-sun.com/" title="访问中国工程机械商贸网首页"><img src="/images/n_toppoint.gif" align="absmiddle" /> 访问中国工程机械商贸网首页</a></div>
    <ul class="loginLinks_new">
      <li onclick="window.open('/admin/login.jsp');">厂家登录</li>
      <li onclick="window.open('/admin/login.jsp');">代理商登录</li>
    </ul>
    <ul class="tlRight">
      <li class="tl" onclick="addCookie();">加入收藏</li>
      <li class="tl" onclick="window.open('http://market.21-sun.com/');">供求市场</li>
      <li class="tl" onclick="window.open('http://news.21-sun.com/');">资讯中心</li>
      <li class="tl" onclick="window.open('http://aboutus.21-sun.com/contact/');">客服中心</li>
      <li class="guide"><span class="gt">网站导航</span>
        <ul>
          <li onclick="window.open('http://market.21-sun.com/');">供求市场</li>
          <li onclick="window.open('http://www.21-sun.com/supply/');">供 应 商</li>
          <li onclick="window.open('http://data.21-sun.com/');">数据分析</li>
          <li onclick="window.open('http://www.21-sun.com/bidding/');">招 投 标</li>
          <li onclick="window.open('http://www.21-cmjob.com/');">招聘求职</li>
          <li onclick="window.open('http://news.21-sun.com/');">资讯中心</li>
          <li onclick="window.open('http://product.21-sun.com/');">整机市场</li>
          <li onclick="window.open('http://stock.21-sun.com/');">行业股市</li>
          <li onclick="window.open('http://www.21-sun.com/part/');">配件市场</li>
          <li onclick="window.open('http://www.21-rent.com/');">租赁调剂</li>
          <li onclick="window.open('http://www.21part.com/');">杰配网</li>
          <li onclick="window.open('http://www.21peitao.com/');">配 套 网</li>
        </ul>
      </li>
      <li class="tl" style="width:63px; background:none; padding:4px 0px 0px 5px; height:27px"><iframe width="63" height="24" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" border="0" src="http://widget.weibo.com/relationship/followbutton.php?language=zh_cn&width=63&height=24&uid=1904756027&style=1&btn=red&dpc=1"></iframe></li>
    </ul>
  </div>
</div>
<div class="topbg">
  <div class="top contain980">
    <h1><a href="/"><img src="/images/new_n_21sun.gif" alt="中国工程机械商贸网" width="136" height="72" /><img src="/images/new_n_pro_name.gif" alt="产品中心" width="53" height="72" /></a></h1>
    <div class="new_topMid">
      <ul class="news_topSearch">
        <form id="top_search" name="top_search" method="get" action="<%=action%>" onsubmit="if(jQuery('#keyword').val()==''){alert('请输入您要搜索的关键词');jQuery('#keyword').focus();return false;}" target="_blank">
          <li class="ntsi">
            <input type="text" name="keyword" id="keyword" maxlength="30" value="<%=CommonString.getFormatPara(request.getParameter("keyword"))%>"/>
          </li>
          <li class="ntsb">
            <input type="submit" id="button" value="&nbsp;" />
          </li>
          <input type="hidden" id="type" name="type" value="<%=type%>" />
        </form>
      </ul>
      <div class="hotWords">热门搜索：<a href="/products/prolist.jsp?catalog=101001"><b>挖掘机</b></a> <a href="/products/prolist.jsp?catalog=101002">装载机</a> <a href="/products/prolist.jsp?catalog=102">起重机</a> <a href="/products/prolist.jsp?factory=133&catalog=101001">三一挖掘机</a></div>
    </div>
    <div class="topHot" id="topHot">
      <ul class="thl">
        <li><img src="/images/tu1.png" width="260" height="80" alt="产品数据分析" onclick="window.open('http://data.21-sun.com/');" style="cursor:pointer" /></li>
        <li><img src="/images/tu2.png" width="260" height="80" alt="工程机械供求市场" onclick="window.open('http://market.21-sun.com/');" style="cursor:pointer" /></li>
        <li><img src="/images/tu3.png" width="260" height="80" alt="工程机械资讯" onclick="window.open('http://news.21-sun.com/');" style="cursor:pointer" /></li>
      </ul>
      <ul class="thn">
        <li>1</li>
        <li>2</li>
        <li>3</li>
      </ul>
      <p><span><em id="showNumId">1</em>/3</span><a href="javascript:showPre();" class="imgPrev" title="上一张">上一张</a><a href="javascript:showAuto();" class="imgNext" title="下一张">下一张</a></p>
    </div>
  </div>
  <div class="nav contain980">
    <script type="text/javascript">
	jQuery(function(){
		jQuery(".scl ul li").hover(function(){
			jQuery(this).toggleClass("cur");
		},function(){
			jQuery(this).removeClass("cur");
		});
		jQuery("a.CloseAllBtn").click(function(){
			jQuery(".bigBtn.bigBtnCur").removeClass("bigBtnCur");
		});
		jQuery(".btname").click(function(){
			   var par = jQuery(this).parent();
			   var cls = par.attr("class");
			   if(cls.indexOf("bigBtnCur")!=-1){
				   par.removeClass("bigBtnCur");
			   }else{
				   par.addClass("bigBtnCur");
			   }
		 });
	})
	</script>
    <div class="bigBtn"> <span class="btname" title="点击展开">全部产品分类</span> 
      <div class="ShowAllCate">
        <ul class="sacontain">
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=101">土方机械</a></h3>
            <ul>
              <li><a href="/products/prolist.jsp?catalog=101001">挖掘机</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=101001001">履带式挖掘机</a> <a href="/products/prolist.jsp?catalog=101001004">轮式挖掘机</a> <a href="/products/prolist.jsp?catalog=101001006">正铲挖掘机</a> <a href="/products/prolist.jsp?catalog=101001008">反铲挖掘机</a> <a href="/products/prolist.jsp?catalog=101001007">其它挖掘机</a></div>
              </li>
              <li><a href="/products/prolist.jsp?catalog=101002">装载机</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=101002007">轮式装载机</a><em>|</em><a href="/products/prolist.jsp?catalog=101002009">滑移装载机</a><em>|</em><a href="/products/prolist.jsp?catalog=101002008">挖掘装载机</a><em>|</em><a href="/products/prolist.jsp?catalog=101002003">履带式装载机</a><em>|</em><a href="/products/prolist.jsp?catalog=101002010">叉装机</a><em>|</em><a href="/products/prolist.jsp?catalog=101002004">其它装载机</a></div>
              </li>
              <li><a href="/products/prolist.jsp?catalog=101003">推土机</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=101003001">履带推土机</a><em>|</em><a href="/products/prolist.jsp?catalog=101003004">轮式推土机</a></div>
              </li>
              <li><a href="/products/prolist.jsp?catalog=101005">平地机</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=101005002">自行式平地机</a></div>
              </li>
              <li><a href="/products/prolist.jsp?catalog=101008">自卸卡车</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=101008001">铰接式自卸卡车</a><em>|</em><a href="/products/prolist.jsp?catalog=101008002">刚性自卸卡车</a><em>|</em><a href="/products/prolist.jsp?catalog=101008003">矿用车</a></div>
              </li>
              <li><a href="/products/prolist.jsp?catalog=101004">铲运机</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=101004001">自行式铲运机</a><em>|</em><a href="/products/prolist.jsp?catalog=101004003">地下铲运机</a></div>
              </li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=102">起重机械</a></h3>
            <ul>
              <li><a href="/products/prolist.jsp?catalog=102002">塔式起重机</a></li>
              <li><a href="/products/prolist.jsp?catalog=102007">汽车起重机</a></li>
              <li><a href="/products/prolist.jsp?catalog=102008">履带式起重机</a></li>
              <li><a href="/products/prolist.jsp?catalog=102003">高空作业平台</a></li>
              <li><a href="/products/prolist.jsp?catalog=102010">高空作业车</a></li>
              <li><a href="/products/prolist.jsp?catalog=102006">随车起重机</a></li>
              <li><a href="/products/prolist.jsp?catalog=102011">施工升降机</a></li>
              <li><a href="/products/prolist.jsp?catalog=102012">伸缩臂叉装机</a></li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=103">混凝土机械</a></h3>
            <ul>
              <li class="short"><a href="/products/prolist.jsp?catalog=103001">混凝土泵车</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=103001001">泵车</a><em>|</em><a href="/products/prolist.jsp?catalog=103001003">拖泵</a><em>|</em><a href="/products/prolist.jsp?catalog=103001004">输送泵</a><em>|</em><a href="/products/prolist.jsp?catalog=103001002">车载泵</a></div>
              </li>
              <li class="short"><a href="/products/prolist.jsp?catalog=103002">混凝土搅拌设备</a>
                <div class="moreScl"><s></s>

                <a href="/products/prolist.jsp?catalog=103002002">搅拌站</a><em>|</em><a href="/products/prolist.jsp?catalog=103002001">搅拌机</a><em>|</em><a href="/products/prolist.jsp?catalog=103002003">搅拌楼</a></div>
              </li>
              <li class="short"><a href="/products/prolist.jsp?catalog=103005">混凝土布料设备</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=103005002">布料机</a><em>|</em><a href="/products/prolist.jsp?catalog=103005001">布料杆</a></div>
              </li>
              <li class="short"><a href="/products/prolist.jsp?catalog=103009">粉粒物料运输车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=103015">其它混凝土设备</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=103012">干混砂浆生产线</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=103011">沥青砂浆车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=103014">干混砂浆背罐车</a></li>
              <li><a href="/products/prolist.jsp?catalog=103006">混凝土搅拌运输车</a></li>
              <li><a href="/products/prolist.jsp?catalog=103008">干粉砂浆生产设备</a></li>
              <li><a href="/products/prolist.jsp?catalog=103010">喷湿机</a></li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=104">筑养路机械</a></h3>
            <ul>
              <li class="short"><a href="/products/prolist.jsp?catalog=104001">摊铺机</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=104001002">履带式摊铺机</a><em>|</em><a href="/products/prolist.jsp?catalog=104001001">轮式摊铺机</a><em>|</em><a href="/products/prolist.jsp?catalog=104001005">滑模摊铺机</a><em>|</em><a href="/products/prolist.jsp?catalog=104001004">熨平板</a><em>|</em><a href="/products/prolist.jsp?catalog=104001006">混凝土摊铺机</a></div>
              </li>
              <li class="short"><a href="/products/prolist.jsp?catalog=104002">养护机械</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=104002010">环卫机械</a><em>|</em><a href="/products/prolist.jsp?catalog=104002004">再生机械</a><em>|</em><a href="/products/prolist.jsp?catalog=104002008">清扫机</a><em>|</em><a href="/products/prolist.jsp?catalog=104002007">洒水车</a><em>|</em><a href="/products/prolist.jsp?catalog=104002009">沥青洒布车</a><em>|</em><a href="/products/prolist.jsp?catalog=104002005">灌缝机械</a><em>|</em><a href="/products/prolist.jsp?catalog=104002006">开槽机</a></div>
              </li>
              <li class="short"><a href="/products/prolist.jsp?catalog=104004">其它路面机械</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=104004008">碎石撒布机</a><em>|</em><a href="/products/prolist.jsp?catalog=104004005">沥青搅拌机</a><em>|</em><a href="/products/prolist.jsp?catalog=104004001">沥青混合料转运车</a></div>
              </li>
              <li class="short"><a href="/products/prolist.jsp?catalog=104005">铣刨机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=104008">稳定土厂拌设备</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=104009">沥青搅拌站</a></li>
              <li><a href="/products/prolist.jsp?catalog=104006">稳定土拌合机</a></li>
              <li><a href="/products/prolist.jsp?catalog=104007">沥青混合料搅拌设备</a></li>
            </ul>
          </li>
          <li class="scl rside">
            <h3><a href="/products/prolist.jsp?catalog=106">压实机械</a></h3>
            <ul>
              <li><a href="/products/prolist.jsp?catalog=106001">压路机</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=106001001">单钢轮压路机</a><em>|</em><a href="/products/prolist.jsp?catalog=106001002">双钢轮压路机</a><em>|</em><a href="/products/prolist.jsp?catalog=106001009">振动压路机</a><em>|</em><a href="/products/prolist.jsp?catalog=106001005">轮胎压路机</a><em>|</em><a href="/products/prolist.jsp?catalog=106001003">三轮压路机</a><em>|</em><a href="/products/prolist.jsp?catalog=106001004">光轮压路机</a><em>|</em><a href="/products/prolist.jsp?catalog=106001006">冲击式压路机</a><a href="/products/prolist.jsp?catalog=106001008">静碾压路机</a></div>
              </li>
              <li><a href="/products/prolist.jsp?catalog=106003">压实机</a></li>
              <li><a href="/products/prolist.jsp?catalog=106004">夯实机</a></li>
            </ul>
          </li>
          <li class="scl other" style="">
            <h3><a href="/products/prolist.jsp?catalog=105">桩工机械</a></h3>
            <ul>
              <li><a href="/products/prolist.jsp?catalog=105003">旋挖钻机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105011">打桩机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105005">水平定向钻</a></li>
              <li><a href="/products/prolist.jsp?catalog=105007">连续墙抓斗</a></li>
              <li><a href="/products/prolist.jsp?catalog=105018">长螺旋钻孔机</a></li>
              <li><a href="/products/prolist.jsp?catalog=10500315">打桩锤</a></li>
              <li><a href="/products/prolist.jsp?catalog=105004">潜孔钻机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105019">多功能钻机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105017">强夯机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105026">多轴钻孔机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105016">连续墙钻机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105013">液压步履式桩架</a></li>
              <li><a href="/products/prolist.jsp?catalog=105009">液压静力压桩机</a></li>
              <li><a href="/products/prolist.jsp?catalog=105028">截桩机</a></li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=107">机动工业车辆</a></h3>
            <ul>
              <li><a href="/products/prolist.jsp?catalog=107001">内燃叉车</a>
                <div class="moreScl"><s></s>
                <a href="/products/prolist.jsp?catalog=107001001">普通内燃叉车</a><em>|</em><a href="/products/prolist.jsp?catalog=107001002">重型叉车</a><em>|</em><a href="/products/prolist.jsp?catalog=107001003">侧面叉车</a></div>
              </li>
              <li><a href="/products/prolist.jsp?catalog=107003">电动叉车</a></li>
              <li><a href="/products/prolist.jsp?catalog=107005">仓储叉车</a></li>
              <li><a href="/products/prolist.jsp?catalog=107008">半挂车</a></li>
              <li><a href="/products/prolist.jsp?catalog=107007">其它机动工业车辆</a></li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=110">地下及矿山机械</a></h3>
            <ul>
              <li><a href="/products/prolist.jsp?catalog=110014">连续采煤机和隧道掘进机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=110011">凿岩机和钻机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=110015">输送和辅助设备</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=110009">破碎机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=110013">装载及搬运设备</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=110002">矿用掘进机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=110005">采煤机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=110008">凿岩台车</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=110012">筛分机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=110016">全液压凿岩钻机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=110001">盾构掘进机</a></li>
              <li class="short"><a href="/products/prolist.jsp?catalog=110010">凿岩钻车</a></li>
            </ul>
          </li>
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=109">桥梁机械</a></h3>
            <ul>    
              <li><a href="/products/prolist.jsp?catalog=109005">检测车</a></li>
              <li><a href="/products/prolist.jsp?catalog=109002">运梁车</a></li>
              <li><a href="/products/prolist.jsp?catalog=109001">架桥机</a></li>
              <li><a href="/products/prolist.jsp?catalog=109004">提梁机</a></li>
              <li><a href="/products/prolist.jsp?catalog=109006">砂浆车</a></li>
            </ul>
          </li>
          
          <li class="scl">
            <h3><a href="/products/prolist.jsp?catalog=111">港口机械</a></h3>
            <ul> 
              <li><a href="/products/prolist.jsp?catalog=111002">堆高机</a></li>
              <li><a href="/products/prolist.jsp?catalog=111001">正面吊</a></li>
              <li><a href="/products/prolist.jsp?catalog=111006">场桥</a></li>
              <li><a href="/products/prolist.jsp?catalog=111007">推耙机</a></li>
              <li><a href="/products/prolist.jsp?catalog=111003">吊具</a></li>
            </ul>
          </li>
          <li class="scl rside" style="height:auto;">
            <h3><a href="/products/prolist.jsp?catalog=113">破碎设备</a></h3>
            <ul> 
              <li><a href="/products/prolist.jsp?catalog=113001">破碎锤</a></li>
              <li style="border-bottom:none;"><a href="/products/prolist.jsp?catalog=113002">液压剪</a></li>
            </ul>
          </li>
          <li class="scl rside" style="height:63px;">
            <h3><a href="/products/prolist.jsp?catalog=117">消防机械</a></h3>
            <ul> 
              <li style="border-bottom:none;"><a href="/products/prolist.jsp?catalog=117001">消防车</a></li>
            </ul>
          </li>
          <li class="scl rside" style="height:auto;">
            <h3><a href="/products/prolist.jsp?catalog=118">专用汽车</a></h3>
            <ul> 
              <li><a href="/products/prolist.jsp?catalog=118002">专用车辆</a></li>
              <li style="border-bottom:none;"></li>
            </ul>
          </li>
        </ul>
        <ul class="ShowAllCateBottom">
          <a href="#" title="关闭" class="CloseAllBtn"></a>
        </ul>
      </div>
    </div>
    
    
    <ul class="navlist">
      <li id="top_1"><a href="/">首页</a></li>
      <li id="top_2"><a href="/products/">产品大全</a></li>
      <li id="top_3"><a href="/brand/">品牌大全</a></li>
      <li id="top_8"><a href="/news/">行情▪导购</a></li>
      <li id="top_9" style="position:relative;"><a href="/tuan/" style="color:#f8454b!important;" target="_blank">优买团</a><img src="/images/new_ico.gif" width="23" height="11" style="position:absolute; right:5px; top:-5px;" /></li>
      <li id="top_4"><a href="/inquiry/">采购询价</a></li>
      <li id="top_5"><a href="/photo/">图库</a></li>
      <li id="top_6"><a href="/top_list/">排行榜</a></li>
      <li id="top_7"><a href="/agent/">代理商</a></li>
    </ul>
  </div>
</div>
<%
	String thisUrl = CommonString.getFormatPara(request.getRequestURI());
%>
<script language="javascript" type="text/javascript">
	var thisUrl = window.location.href;
	jQuery(".r li").removeClass("cur");
	if(thisUrl.indexOf("/products/") >= 0){
		jQuery("#top_2").addClass("cur");	
	}else if(thisUrl.indexOf("/brand/") >= 0){
		jQuery("#top_3").addClass("cur");	
	}else if(thisUrl.indexOf("/inquiry/") >= 0){
		jQuery("#top_4").addClass("cur");	
	}else if(thisUrl.indexOf("/photo/") >= 0){
		jQuery("#top_5").addClass("cur");	
	}else if(thisUrl.indexOf("/top_list/") >= 0){
		jQuery("#top_6").addClass("cur");	
	}else if(thisUrl.indexOf("/agent/") >= 0){
		jQuery("#top_7").addClass("cur");	
	}else if(thisUrl.indexOf("/agent_new/") >= 0){
		jQuery("#top_7").addClass("cur");	
	}else if(thisUrl.indexOf("/news/") >= 0){
		jQuery("#top_8").addClass("cur");	
	}else{
		jQuery("#top_1").addClass("cur");
	}
</script>