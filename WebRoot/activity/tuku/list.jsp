<%@ page language="java" import="java.sql.Connection,com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
  	DBHelper dbHelper = DBHelper.getInstance() ;
	String catalog=CommonString.getFormatPara(request.getParameter("sort")); 
    String offset = CommonString.getFormatPara(request.getParameter("offset"));
    String typeName="";
	Connection connection = null;
	Map memberInfo = (Map)session.getAttribute("memberInfo");
	String username = "";
	if(memberInfo != null){
		username = CommonString.getFormatPara(memberInfo.get("username"));
	}
	String whereStr=" and is_show=1 "; 
	if(!catalog.equals("")){
	   whereStr+=whereStr+"and sort_num like '%"+catalog+"%'";
	}
	try{
	connection = dbHelper.getConnection();
	String url = CommonString.getFormatPara(request.getQueryString());
	if (!"".equals(url)) {
			if (url.indexOf("offset") != -1 && url.indexOf("&") == -1) {
				url = "";
			} else if (url.indexOf("offset") != -1) {
				url = "&" + url.substring(url.indexOf("&") + 1);
			} else {
				url = "&" + url;
			}
	}
    PageBean pageBean = new PageBean(); // 分页程序
	Integer nowPage = 1; 
	pageBean.setPageSize(16); // 每页显示条数

	if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
	if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
	}
	pageBean.setParams(url);
    pageBean.setCondition(whereStr);
	pageBean.setNowPage(nowPage);
	pageBean.setFields("id,title,add_user,image,vote_count,add_date,contents");
	pageBean.setTableName("pro_photo_group");
	pageBean.setOrderBy(" vote_count desc,add_date desc"); 

	List<Map> picList = null ;
	picList =  pageBean.getDatas(connection);

	//所有类别
	List<Map> catalogList = (List<Map>)application.getAttribute("catalogList") ;
    if(catalog.equals("107002")){typeName="产品图片";}  if(catalog.equals("107001")){typeName="行业图片";} 
    if(catalog.equals("107003")){typeName="施工图片";}  if(catalog.equals("107004")){typeName="维修图片";} 
    if(catalog.equals("107005")){typeName="展会图片";}  if(catalog.equals("107006")){typeName="趣味图片";}



	String title="9要随手拍——上传"+typeName+"即有奖- 铁臂图库";
	String keywords="工程机械图片库,工程机械"+typeName;
	String description="铁臂图库9要随手拍——就要出风头摄影大赛活动，参与并上传"+typeName+"就有机会获得大奖。买工程机械产品，就上铁臂商城。";
	
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<meta name="renderer" content="webkit">
<title><%=title%></title>
<meta name="keywords" content="<%=keywords%>" />
<meta name="description" content="<%=description%>" />
<meta name="author" content="design by www.21-sun.com" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css"/>
<script type="text/javascript" src="/scripts/login.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.cookies.2.2.0.min.js"></script>

<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body class="koubei_act">
<!--top-->
<div class="topLinks">
  <div class="contain980">
    <div class="visit_21sun"><a rel="nofollow" target="_blank" href="http://www.21-sun.com/" title="访问中国工程机械商贸网首页"><img src="/images/n_toppoint.gif" align="absmiddle"> 访问中国工程机械商贸网首页</a> 
	<%if(username.equals("")){%>
	<a href="javascript:void(0)" onclick="login();" class="kba_login">请登录</a>
	<a target="_blank" href="http://product.21-sun.com/activity/koubei/register.jsp" class="kba_reg">免费注册</a>
	<%}else{%>
	欢迎您，<a href="http://product.21-sun.com/member/" target="_blank"><span style="color:red"><%=username%></span></a>！<a href="javascript:void(0);" onclick="logout()">【退出】</a>
	<%}%>
    </div>
    <ul class="tlRight">
      <li class="tl" onclick="addCookie();">加入收藏</li>
	      <!--  
      <li class="tl" onclick="window.open('http://market.21-sun.com/');">供求市场</li>
      <li class="tl" onclick="window.open('http://news.21-sun.com/');">资讯中心</li> 
       <li class="tl" onclick="window.open('http://news.21-sun.com/');">行业动态</li>
	   -->
	  <li class="tl" style="width:45px;" onclick="window.open('http://weixiu.21-sun.com/');">维修</li>
	  <li class="tl" style="width:45px;" onclick="window.open('http://koubei.21-sun.com/');">口碑</li>
      <li class="tl" onclick="window.open('http://aboutus.21-sun.com/contact/');">客服中心</li>
      <li class="guide"><span class="gt">网站导航</span>
        <ul>
          <li onclick="window.open('http://product.21-sun.com/');">铁臂商城</li>
          <li onclick="window.open('http://photo.21-sun.com/');">产品图库</li> 
          <li onclick="window.open('http://weixiu.21-sun.com/');">维　　修</li>
          <li onclick="window.open('http://koubei.21-sun.com/');">口　　碑</li>
          <li onclick="window.open('http://market.21-sun.com/');">供求市场</li>
		  <li onclick="window.open('http://news.21-sun.com/');">行业动态</li>  
          <li onclick="window.open('http://used.21-sun.com/');">二手设备</li>
          <li onclick="window.open('http://www.21-sun.com/part/');">配件市场</li>
		  <li onclick="window.open('http://www.21part.com/');">杰 配 网</li>
		  <li onclick="window.open('http://www.21-sun.com/supply/');">供 应 商</li>
          <li onclick="window.open('http://www.21taiyang.com/');">太阳商城</li>
          <li onclick="window.open('http://www.wajueji.com/');">铁臂兄弟连</li>
        </ul>
      </li>
      <li class="tl" style="width:63px; background:none; padding:4px 0px 0px 5px; height:24px"><iframe width="63" height="24" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" border="0" src="http://widget.weibo.com/relationship/followbutton.php?language=zh_cn&amp;width=63&amp;height=24&amp;uid=1904756027&amp;style=1&amp;btn=red&amp;dpc=1"></iframe></li>
      <li class="tl" style="width:80px; background:none;"><a target="_blank" href="http://www.21-sun.com/weixin/"><img width="74" height="20" src="http://www.21-sun.com/weixin/images/weixin.jpg" style="margin-top:4px;"></a></li>
    </ul>
  </div>
</div>
<!--top end-->
<div class="kb_act_banner"></div>
<div class="kb_topNav fix">
	<div class="wrap1000 fix">
    	<ul class="fix nav_list">
        	<li class="nav_scroll"><a href="/activity/tuku/#aa">大赛介绍</a></li>
            <li class="nav_scroll"><a href="/activity/tuku/#bb">大赛流程</a></li>
            <li class="nav_scroll"><a href="/activity/tuku/#cc">奖项设置</a></li>
            <li class="nav_scroll"><a href="/activity/tuku/#dd">参赛规则</a></li>
            <li class="nav_scroll"><a href="/activity/tuku/#ee">全部作品</a></li>
        </ul>
        <a href="javascript:;" class="nav_upload kbf_show" <%if(username.equals("")){%> onclick="login();"<%}else{%>onclick="showUpdate();"<%}%>></a>
    </div>
</div>


<!--全部作品-->
<div class="kb_qbzp" id="ee">
	<div class="wrap1000 fix">
    	<div class="csgz_tbg">全部作品</div>
        <div class="kbpic_tab">
            <ul class="fix kbtab_list">
			    <%if(catalog.equals("107002")){%><li class="tab_key">产品图片</li><%}%>
                <%if(catalog.equals("107001")){%><li class="tab_key">行业图片</li><%}%>
                <%if(catalog.equals("107003")){%><li class="tab_key">施工图片</li><%}%>
                <%if(catalog.equals("107004")){%><li class="tab_key">维修图片</li><%}%>
                <%if(catalog.equals("107005")){%><li class="tab_key">展会图片</li><%}%>
                <%if(catalog.equals("107006")){%><li class="tab_key">趣味图片</li><%}%>
            </ul>
     
			
			
			
			
            <div class="tab_val">
            	<ul class="fix kbpic_plist">
				<%	
				    if(picList!=null && picList.size()>0){
				    for(Map m:picList){
              		String image = CommonString.getFormatPara(m.get("image"));
					if(image.indexOf("resource.21-sun.com")==-1){
					  image="http://product.21-sun.com/uploadfiles/"+image;
					}
					String contents=CommonString.getFormatPara(m.get("contents"));
					if(contents.length()>14){contents=contents.substring(0,14)+"...";}
					if(contents.equals("")){contents="无";}
				%>
                	<li>
                    	<a href="http://photo.21-sun.com/ndetail_for_<%=CommonString.getFormatPara(m.get("id"))%>.htm" title="<%=CommonString.getFormatPara(m.get("title"))%>" target="_blank"><img src="<%=image%>" alt="<%=CommonString.getFormatPara(m.get("title"))%>"/></a>
                        <div class="kbtp_sum fix">
                        	 <span class="tpuser_name">				
							<%=CommonString.getFormatPara(m.get("title"))%><br>
							 拍摄者：<%=CommonString.getFormatPara(m.get("add_user"))%><br>
							描述：<%=contents%>
							</span>
                        </div>
                    </li>
               <%}}%>  
          
                </ul>
            </div>
                   <tags:page pageBean="<%=pageBean%>" />


        </div>
        <div class="kb_upbtn kbf_show"><a href="javascript:void(0)" <%if(username.equals("")){%> onclick="login();"<%}else{%>onclick="showUpdate();"<%}%>><img src="images/up_btn2.gif"/></a></div>
    </div>
</div>
<!--全部作品结束-->
<!--foot-->
<div class="kba_foot">
<div style="width:980px; height:170px; margin:0 auto; clear:both; position:relative;" class="proFoot">
<div style="position:absolute; right:-18px; top:0px; width:160px; text-align:center; color:#fff;" class="fewm"><img src="/images/ewm_new.gif" width="90" height="90" /><br />关注铁臂商城<br />抢先查询新品信息</div>
  <link rel="stylesheet" href="http://www.21-sun.com/00css/new_21sun_include.css" type="text/css" />
  <div class="New_website">
    <div class="New_linksContain">
      <strong><span class="New_links" onclick="window.open('http://www.21-sun.com');">中国工程机械商贸网</span>旗下网站：</strong>
      <span class="New_links" onclick="window.open('http://part.21-sun.com/');">中国工程机械配件网</span>
      <span class="New_links" onclick="window.open('http://www.21-cmjob.com/');">中国工程机械人才网</span>
      <span class="New_links" onclick="window.open('http://www.21-rent.com/');">中国工程机械租赁网</span>
      <span class="New_links" onclick="window.open('http://www.21-used.com/');">中国工程机械二手网</span>
      <span class="New_links" onclick="window.open('http://www.21part.com/');">配件商城</span>
      <span class="New_links" onclick="window.open('http://www.21peitao.com/');">配套网</span>
      <span class="New_links" onclick="window.open('http://www.cmbol.com/');">工程机械外贸网</span>
      <span class="New_links" onclick="window.open('http://product.21-sun.com/');">铁臂商城</span>
    </div>
  </div>
  <div class="New_foot">
    <span class="New_links" onclick="window.open('http://www.21-sun.com/service/guanggao/index.htm');">广告服务</span><em>|</em>
    <span class="New_links" onclick="window.open('http://www.jerei.com/contact/');">联系方式</span><em>|</em>
    <span class="New_links" onclick="window.open('http://www.jerei.com/');">关于我们</span><em>|</em>
    <span class="New_links" onclick="window.open('http://www.jerei.com/news/');">本网动态</span><em>|</em>
    <span class="New_links" onclick="window.open('http://www.jerei.com/contact/legal.jsp');">法律声明</span><em>|</em>
    <span class="New_links" onclick="window.open('http://aboutus.21-sun.com/map.htm');">网站导航</span><em>|</em>
    <span class="New_links" onclick="window.open('http://www.21-sun.com/contact/');">联系客服</span><em>|</em>
    <p>产品询价专线：4006-521-526</p>
    <p><span class="New_links" onclick="window.open('http://www.21-sun.com');">中国工程机械商贸网</span>
    Copyright &copy; 2000-<script type="text/javascript">document.write((new Date()).getFullYear());</script></p>
  </div>
  <!-- Baidu Button BEGIN -->
    <div style="width:300px; margin:0px auto;" >
    <div class="bdsharebuttonbox" style="padding-left:50px;">
    <a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
<script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdPic":"","bdStyle":"0","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
</script>
    </div>
    <!-- Baidu Button END -->
</div>
<div class="n_tools">
  <ul>
    <li class="nt02"><a href="#"><i></i><span class="te">客服：4006-521-526</span></a></li>
    <li class="nt03"><a href="http://product.21-sun.com/inquiry/"><i></i><span class="te">在线询价</span></a></li>
    <li class="nt04 bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"><span class="te">点击分享</span></a></li>
    <li class="nt05"><a href="javascript:void(0)" onclick="addUrl()"><i></i><span class="te">添加收藏</span></a></li>
    <li class="nt06"><a href="javascript:void(0);" class="gotop"><i></i><span class="te">返回顶部</span></a></li>
  </ul>
</div>
<i class="kb_ico kb_ico_3"><img src="images/ico_3.gif"/></i>
</div>
<!--foot end-->
<!--上传照片弹出-->
<div class="upimg_bg"></div>
<div class="upimg_main">
	<div class="upimg_form" style="padding-top:15px;">
    	<form name="photo_form" id="photo_form" method="post" action="/action/ajax.jsp">
        	<table cellpadding="0" cellspacing="0" border="0" width="100%">
            	<tr>
                	<td class="um_title" width="18%" align="right">标题：</td>
                    <td width="80%"><input id="jr_title" name="jr_title" type="text" class="upimg_inp"/> <span class="red">*</span></td>
                </tr>
                <tr>
                	<td class="um_title" align="right">分类：</td>
                    <td><select class="upimg_sele" id="catalog" name="catalog" onchange="showOther(this)">
					<option value="">-请选择-</option>
					<option value="107002">产品图片</option>
					<option value="107001">行业图片</option>
					<option value="107003">施工图片</option>
					<option value="107004">维修图片</option>
					<option value="107005">展会图片</option>
					<option value="107006">趣味图片</option>
					</select>
					<span class="red">*</span></td>
                </tr>
				
   
				 <tr >
                	<td class="um_title" align="right">类别：</td>
                    <td>
			<select class="upimg_sele" id="catalognum" name="catalognum">
  <option value="">-请选择类别-</option>
  <option value="101001">挖掘机</option>
  <option value="101002">装载机</option>
  <option value="101003">推土机</option>
  <option value="106001">压路机</option>
  <option value="101005">平地机</option>
  <option value="104001">摊铺机</option>
  <option value="102007">汽车起重机</option>
  <option value="105003">旋挖钻机</option>
  <option value="106003">压实机</option>
  <option value="113001">破碎锤</option>
  <option value="105027">其它桩工机械</option>
  <option value="102013">桥梁式起重机</option>
  <option value="105028">截桩机/破桩机</option>
  <option value="118003">消防车</option>
  <option value="107010">专用叉车</option>
  <option value="118004">牵引车</option>
  <option value="110017">隧道轨道设备</option>
  <option value="119001">煤炭机械</option>
  <option value="111008">海工装备</option>
  <option value="110018">扒渣机</option>
  <option value="103021">A8 砂浆大师成套设备</option>
  <option value="103022">V8 城镇先锋混凝土成套设备</option>
  <option value="103001">混凝土泵车</option>
  <option value="104008">稳定土厂拌设备</option>
  <option value="113002">液压剪</option>
  <option value="109006">砂浆车</option>
  <option value="118002">专用车辆</option>
  <option value="105026">多轴钻孔机</option>
  <option value="111007">推耙机</option>
  <option value="102006">随车起重机</option>
  <option value="103017">车载泵</option>
  <option value="103002">混凝土搅拌设备</option>
  <option value="109005">检测车</option>
  <option value="104007">沥青混合料搅拌设备</option>
  <option value="111006">场桥</option>
  <option value="106004">夯实机</option>
  <option value="110016">全液压凿岩钻机</option>
  <option value="101004">铲运机</option>
  <option value="102008">履带式起重机</option>
  <option value="103018">拖泵</option>
  <option value="107005">仓储叉车</option>
  <option value="109004">提梁机</option>
  <option value="111003">吊具</option>
  <option value="104006">稳定土拌合机</option>
  <option value="110015">输送和辅助设备</option>
  <option value="102002">塔式起重机</option>
  <option value="103019">混凝土搅拌运输车</option>
  <option value="107003">电动叉车</option>
  <option value="109002">运梁车</option>
  <option value="111002">堆高机</option>
  <option value="104005">铣刨机</option>
  <option value="103020">输送泵</option>
  <option value="110014">连续采煤机和隧道掘进机</option>
  <option value="102003">高空作业平台</option>
  <option value="104002">养护机械</option>
  <option value="107001">内燃叉车</option>
  <option value="109001">架桥机</option>
  <option value="111001">正面吊</option>
  <option value="103005">混凝土布料设备</option>
  <option value="101008">自卸卡车</option>
  <option value="110013">装载及搬运设备</option>
  <option value="102010">高空作业车</option>
  <option value="104004">其它路面机械</option>
  <option value="103010">喷湿机</option>
  <option value="110012">筛分机</option>
  <option value="103008">干粉砂浆生产设备</option>
  <option value="110011">凿岩机和钻机</option>
  <option value="102011">施工升降机</option>
  <option value="104009">沥青搅拌站</option>
  <option value="103009">粉粒物料运输车</option>
  <option value="110010">凿岩钻车</option>
  <option value="105019">多功能钻机</option>
  <option value="102012">伸缩臂叉装机</option>
  <option value="103011">沥青砂浆车</option>
  <option value="105018">长螺旋钻孔机</option>
  <option value="110009">破碎机</option>
  <option value="105017">强夯机</option>
  <option value="110008">凿岩台车</option>
  <option value="103012">干混砂浆生产线</option>
  <option value="119002">采煤机</option>
  <option value="105015">打桩锤</option>
  <option value="110002">矿用掘进机</option>
  <option value="103014">干混砂浆背罐车</option>
  <option value="110001">盾构掘进机</option>
  <option value="105013">液压步履式桩架</option>
  <option value="103015">其它混凝土设备</option>
  <option value="105011">打桩机</option>
  <option value="105016">连续墙钻机</option>
  <option value="105009">液压静力压桩机</option>
  <option value="105007">连续墙抓斗</option>
  <option value="105005">水平定向钻</option>
  <option value="105004">潜孔钻机</option>
</select>

   			        <span class="red" id="must2" style="color:white">*</span></td>
                </tr>
				             <tr >
                	<td class="um_title" align="right">品牌：</td>
                    <td>
					<select class="upimg_sele" id="brand" name="brand" onchange="chooseBrand(this.value)">
					<option value="">-请选择品牌-</option>
					<option value="1185">A-阿尔多机械</option>
<option value="1185">A-阿尔多机械</option>
<option value="180">A-阿特拉斯</option>
<option value="482">A-阿特拉斯·科普柯</option>
<option value="402">A-艾迪</option>
<option value="772">A-艾思博</option>
<option value="14236">A-安鼎重工</option>
<option value="1710">A-安迈</option>
<option value="1169">A-安丘通用</option>
<option value="13271">A-奥津</option>
<option value="1778">A-奥盛特重工</option>
<option value="13272">A-奥泰</option>
<option value="484">B-八达</option>
<option value="791">B-八达重工</option>
<option value="13557">B-巴里巴</option>
<option value="1108">B-百财</option>
<option value="13562">B-百巨建机</option>
<option value="13560">B-百开</option>
<option value="13565">B-百力克</option>
<option value="13561">B-百灵</option>
<option value="1168">B-百脉建机</option>
<option value="478">B-邦立重机</option>
<option value="13569">B-宝达</option>
<option value="13570">B-宝鼎</option>
<option value="1715">B-宝骊</option>
<option value="13550">B-宝马格</option>
<option value="13558">B-宝象</option>
<option value="13567">B-暴风雪</option>
<option value="1093">B-北车重工</option>
<option value="14144">B-北方红阳</option>
<option value="167">B-北方交通</option>
<option value="13551">B-北京加隆</option>
<option value="186">B-北起多田野</option>
<option value="1714">B-北山机械</option>
<option value="420">B-贝力特</option>
<option value="13556">B-贝司特</option>
<option value="13568">B-泵虎</option>
<option value="13553">B-边宁荷夫</option>
<option value="13566">B-滨州钻机</option>
<option value="13552">B-波坦</option>
<option value="13571">B-波特重工</option>
<option value="13559">B-博德</option>
<option value="1206">B-博汇机械</option>
<option value="13555">B-博纳地</option>
<option value="13093">B-博山</option>
<option value="1234">B-博亚</option>
<option value="13624">B-博洋</option>
<option value="825">B-搏浪沙</option>
<option value="13572">C-沧田重工</option>
<option value="13575">C-昌世</option>
<option value="13578">C-长春神骏</option>
<option value="13142">C-长高一品</option>
<option value="13094">C-长海科技</option>
<option value="13174">C-长河</option>
<option value="147">C-长江</option>
<option value="13579">C-长盛机械</option>
<option value="615">C-长阳机械</option>
<option value="148">C-常林股份</option>
<option value="485">C-朝工</option>
<option value="13576">C-朝阳建工</option>
<option value="13574">C-郴筑</option>
<option value="145">C-成工</option>
<option value="1591">C-楚工龙泰</option>
<option value="13573">C-创一</option>
<option value="1716">D-达刚</option>
<option value="13587">D-达力</option>
<option value="13580">D-达宇重工</option>
<option value="162">D-大地</option>
<option value="13584">D-大方</option>
<option value="1122">D-大汉</option>
<option value="13592">D-大宏立</option>
<option value="1195">D-大江</option>
<option value="13586">D-大连</option>
<option value="13589">D-大山路桥</option>
<option value="171">D-大信重工</option>
<option value="212">D-戴纳派克</option>
<option value="1243">D-道辰格</option>
<option value="1218">D-道胜</option>
<option value="13588">D-道维施</option>
<option value="151">D-德工</option>
<option value="683">D-德国宝峨</option>
<option value="489">D-德基机械</option>
<option value="13597">D-德科达</option>
<option value="16351">D-德力重工</option>
<option value="213">D-德玛格</option>
<option value="13598">D-德通</option>
<option value="1719">D-德威土行孙</option>
<option value="13595">D-德亿重工</option>
<option value="140">D-鼎盛重工</option>
<option value="14222">D-东倡机械</option>
<option value="1351">D-东达桩工</option>
<option value="1763">D-东德重工</option>
<option value="1187">D-东方红</option>
<option value="13591">D-东方冶矿</option>
<option value="616">D-东方之星</option>
<option value="1755">D-东风</option>
<option value="405">D-东空</option>
<option value="14169">D-东立机械</option>
<option value="13583">D-东泷</option>
<option value="13590">D-东蒙机械</option>
<option value="1717">D-东南机械</option>
<option value="163">D-东岳重工</option>
<option value="1098">D-斗昌</option>
<option value="192">D-斗山</option>
<option value="671">F-方圆集团</option>
<option value="13630">F-飞涛机械</option>
<option value="1120">F-丰汇技术</option>
<option value="1729">F-丰田</option>
<option value="1188">F-福大机械</option>
<option value="215">F-福格勒</option>
<option value="1183">F-福工</option>
<option value="682">F-福临</option>
<option value="141">F-福田雷沃</option>
<option value="1208">F-福威重工</option>
<option value="165">F-抚顺起重机</option>
<option value="164">F-抚挖</option>
<option value="1225">F-抚挖锦重</option>
<option value="1721">F-富豪</option>
<option value="1888">F-富亿机械</option>
<option value="1124">F-富友正和</option>
<option value="1703">G-甘肃宝龙</option>
<option value="14252">G-冈研</option>
<option value="13604">G-高达</option>
<option value="492">G-高马科</option>
<option value="534">G-高远路业</option>
<option value="1754">G-高远圣工</option>
<option value="13606">G-格鲁夫</option>
<option value="477">G-格瑞德</option>
<option value="13603">G-格瑞特</option>
<option value="423">G-工兵</option>
<option value="417">G-古河</option>
<option value="13605">G-谷登机械</option>
<option value="424">G-广林产机</option>
<option value="1116">G-广西建机</option>
<option value="13608">G-国发</option>
<option value="1369">G-国机重工</option>
<option value="893">H-海德</option>
<option value="1109">H-海斗</option>
<option value="13611">H-海华筑机</option>
<option value="203">H-海诺</option>
<option value="1091">H-海山</option>
<option value="1733">H-海斯特</option>
<option value="1176">H-海泰</option>
<option value="1105">H-海特</option>
<option value="13620">H-海天路矿</option>
<option value="1128">H-海威斯帝尔</option>
<option value="664">H-海州机械</option>
<option value="415">H-韩川</option>
<option value="1112">H-韩工</option>
<option value="14253">H-韩农</option>
<option value="845">H-韩锐</option>
<option value="421">H-韩宇</option>
<option value="16385">H-汉欣利</option>
<option value="216">H-悍马</option>
<option value="426">H-悍狮</option>
<option value="814">H-捍宇</option>
<option value="1734">H-杭叉</option>
<option value="13628">H-杭重威施诺</option>
<option value="1732">H-杭州爱知</option>
<option value="1724">H-杭州市政</option>
<option value="1757">H-合肥中达</option>
<option value="1525">H-合矿</option>
<option value="158">H-合力</option>
<option value="13632">H-和盛达</option>
<option value="154">H-河北宣工</option>
<option value="1103">H-黑金钢</option>
<option value="13623">H-恒端机械</option>
<option value="16376">H-恒辉重工</option>
<option value="13641">H-恒康</option>
<option value="1761">H-恒诺机械</option>
<option value="1508">H-恒日重工</option>
<option value="1735">H-恒润高科</option>
<option value="13614">H-恒升</option>
<option value="170">H-恒特</option>
<option value="1147">H-恒天九五</option>
<option value="16381">H-恒旺工矿</option>
<option value="13636">H-恒兴机械</option>
<option value="13096">H-恒至凿岩</option>
<option value="13613">H-红旗</option>
<option value="13639">H-宏昌</option>
<option value="13633">H-宏达</option>
<option value="13609">H-宏大科技</option>
<option value="13629">H-宏建机械</option>
<option value="13618">H-宏力液压</option>
<option value="217">H-鸿达</option>
<option value="202">H-鸿得利重工</option>
<option value="13626">H-鸿源车业</option>
<option value="819">H-虎霸集团</option>
<option value="13617">H-虎力</option>
<option value="13577">H-华贝尔</option>
<option value="13627">H-华丰桩工</option>
<option value="13634">H-华光机械</option>
<option value="206">H-华力重工</option>
<option value="13640">H-华南重工</option>
<option value="1725">H-华骐</option>
<option value="1727">H-华强京工</option>
<option value="1731">H-华山</option>
<option value="1220">H-华通动力</option>
<option value="1526">H-华伟重工</option>
<option value="1512">H-华中建机</option>
<option value="13625">H-华重</option>
<option value="14111">H-环球</option>
<option value="13621">浣-浣熊</option>
<option value="13622">H-惠工机械</option>
<option value="14283">H-惠龙机械</option>
<option value="13616">H-惠山</option>
<option value="554">J-吉公</option>
<option value="1157">J-吉宏机械</option>
<option value="1524">J-吉尼</option>
<option value="1229">J-吉星</option>
<option value="1179">J-济南建机</option>
<option value="13655">J-冀中能源</option>
<option value="189">J-加藤</option>
<option value="13645">J-佳乐</option>
<option value="13654">J-佳一</option>
<option value="1145">J-佳弋建机</option>
<option value="13656">J-嘉成</option>
<option value="13176">J-嘉和重工</option>
<option value="407">J-甲南</option>
<option value="1352">J-建德机械</option>
<option value="13659">J-建丰机械</option>
<option value="1127">J-建神</option>
<option value="1736">J-建研机械</option>
<option value="1357">J-建友机械</option>
<option value="479">J-江淮重工</option>
<option value="13643">J-江加</option>
<option value="487">J-江麓</option>
<option value="13647">J-江苏路通</option>
<option value="1643">J-江苏意玛</option>
<option value="1136">J-江苏正兴</option>
<option value="1355">J-矫马</option>
<option value="1137">J-杰渝</option>
<option value="13657">J-金城</option>
<option value="1094">J-金菱机械</option>
<option value="13651">J-金茂</option>
<option value="1141">J-金桥塔机</option>
<option value="1142">J-金塔</option>
<option value="13653">J-金源</option>
<option value="1737">J-金正神力</option>
<option value="1132">J-锦城建机</option>
<option value="1586">J-劲工</option>
<option value="172">J-晋工</option>
<option value="1759">J-京城长野</option>
<option value="166">J-京城重工</option>
<option value="1159">J-京龙</option>
<option value="401">J-惊天液压</option>
<option value="13649">J-精功</option>
<option value="13650">J-靖江（JJCC）</option>
<option value="187">J-久保田</option>
<option value="1232">J-久工</option>
<option value="13652">J-久润</option>
<option value="197">J-酒井</option>
<option value="1193">J-巨超重工</option>
<option value="1130">J-巨神</option>
<option value="13648">J-聚龙</option>
<option value="679">J-军恒斯帕克</option>
<option value="681">J-军联</option>
<option value="816">J-骏马</option>
<option value="13667">K-卡萨阁蓝地</option>
<option value="174">K-卡特彼勒</option>
<option value="178">K-卡特重工</option>
<option value="14247">K-开普动力</option>
<option value="160">K-开元智富</option>
<option value="1135">K-凯捷</option>
<option value="1322">K-凯雷</option>
<option value="13661">K-凯联</option>
<option value="480">K-凯莫尔</option>
<option value="455">K-凯斯</option>
<option value="1756">K-凯威</option>
<option value="13682">K-凯兴</option>
<option value="1210">K-康柏机械</option>
<option value="1118">K-科曼萨杰牌</option>
<option value="13705">K-科尼乐机械</option>
<option value="13664">K-科尼乐重工</option>
<option value="13663">K-科泰重工</option>
<option value="14243">K-科友机械</option>
<option value="13666">K-科筑机械</option>
<option value="1779">K-克拉士</option>
<option value="13665">K-克瑞</option>
<option value="14265">K-孔山重工</option>
<option value="1223">K-坤宇重工</option>
<option value="13668">K-坤宇重装</option>
<option value="1144">K-昆明力神</option>
<option value="13097">L-莱工</option>
<option value="1194">L-蓝翔重工</option>
<option value="16378">L-朗信机械</option>
<option value="543">L-雷奥科技</option>
<option value="1718">L-雷萨重机</option>
<option value="13681">L-黎明</option>
<option value="412">L-力博士</option>
<option value="13678">L-力尔美</option>
<option value="13683">L-力士</option>
<option value="157">L-力士德</option>
<option value="13687">L-立藤</option>
<option value="13676">L-立新</option>
<option value="179">L-利勃海尔</option>
<option value="13677">L-利洲</option>
<option value="776">L-连云港工兵GBPSC</option>
<option value="13684">L-联丰机械</option>
<option value="13686">L-辽原筑机</option>
<option value="204">L-辽筑</option>
<option value="1742">L-林德</option>
<option value="13680">L-林泰阁</option>
<option value="16359">L-临工重特</option>
<option value="1509">L-灵升机械</option>
<option value="1181">L-凌虹建机</option>
<option value="767">L-凌宇汽车</option>
<option value="1180">L-凌云建机</option>
<option value="136">L-柳工</option>
<option value="135">L-龙工</option>
<option value="14233">L-龙兴机械</option>
<option value="1739">L-鲁青</option>
<option value="14257">L-鲁宇重工</option>
<option value="688">L-鲁岳</option>
<option value="207">L-陆德筑机</option>
<option value="13688">L-路宝</option>
<option value="13631">L-路畅养护</option>
<option value="13679">L-路达</option>
<option value="13669">L-路大</option>
<option value="13673">L-路德克</option>
<option value="13670">L-路虹</option>
<option value="13675">L-路维</option>
<option value="13674">L-路星</option>
<option value="552">L-绿地</option>
<option value="1709">L-滦州重工</option>
<option value="1231">L-洛建</option>
<option value="16366">L-洛克斯特</option>
<option value="749">L-洛阳东方红</option>
<option value="673">L-洛阳路通</option>
<option value="13689">M-玛连尼</option>
<option value="13208">M-麦恩</option>
<option value="418">M-麦恩</option>
<option value="13693">M-曼尼通</option>
<option value="14262">M-曼托瓦尼</option>
<option value="13692">M-梅狮</option>
<option value="1743">M-美科斯</option>
<option value="13095">M-美通筑机</option>
<option value="13696">M-美卓</option>
<option value="422">M-猛士</option>
<option value="14278">M-蒙地机械</option>
<option value="14300">M-民盛水山</option>
<option value="13697">M-闽工</option>
<option value="13691">M-闽科</option>
<option value="13737">M-明山路桥</option>
<option value="1125">M-明威塔机</option>
<option value="16371">M-明宇重工</option>
<option value="13694">M-摩纳凯</option>
<option value="1126">M-牡丹江</option>
<option value="13695">M-牡丹江专用汽车</option>
<option value="13700">N-纳科重工</option>
<option value="1209">N-南车北京时代</option>
<option value="200">N-南方路机</option>
<option value="1134">N-南京绿野</option>
<option value="13698">N-南侨</option>
<option value="169">N-南特</option>
<option value="14249">N-宁工重机</option>
<option value="1748">N-农友</option>
<option value="14186">N-诺尔</option>
<option value="13699">N-诺力</option>
<option value="1585">N-诺森机械</option>
<option value="13702">O-欧霸重工</option>
<option value="13701">O-欧亚机械</option>
<option value="1588">P-平汉重工</option>
<option value="199">P-普茨迈斯特</option>
<option value="403">P-普堃韩泰克</option>
<option value="486">P-普什重机</option>
<option value="686">Q-七天阳</option>
<option value="1184">Q-奇瑞迪凯重科</option>
<option value="14232">Q-千里马</option>
<option value="1139">Q-强力</option>
<option value="582">Q-勤牛</option>
<option value="14250">Q-青岛雅凯</option>
<option value="13708">Q-青山</option>
<option value="1750">Q-全工机械</option>
<option value="198">Q-全进重工</option>
<option value="13704">Q-泉成机械</option>
<option value="13706">Q-泉工</option>
<option value="16372">Q-泉州鑫豪</option>
<option value="13703">Q-泉筑</option>
<option value="13707">Q-群峰智能</option>
<option value="196">R-日工</option>
<option value="184">R-日立</option>
<option value="173">R-熔盛机械</option>
<option value="409">R-锐马机械</option>
<option value="805">R-锐泰</option>
<option value="13709">R-瑞龙重工(欧盟技术)</option>
<option value="1216">R-瑞诺</option>
<option value="14211">R-润邦机械</option>
<option value="810">R-润弘</option>
<option value="14281">R-若鞍亿科技</option>
<option value="16368">S-赛地重工</option>
<option value="13724">S-赛格玛</option>
<option value="1762">S-赛力斯特</option>
<option value="13717">S-赛奇</option>
<option value="868">S-赛通重工</option>
<option value="14248">S-赛宇重工</option>
<option value="14187">S-三驾机械</option>
<option value="13740">S-三力机械</option>
<option value="13749">S-三笠</option>
<option value="13732">S-三联机械</option>
<option value="13721">S-三菱</option>
<option value="13748">S-三隆重工</option>
<option value="13725">S-三洋重工</option>
<option value="133">S-三一</option>
<option value="14217">S-三一帕尔菲格</option>
<option value="1711">S-扫地王</option>
<option value="626">S-森田重机</option>
<option value="13730">S-森源</option>
<option value="13713">S-森远</option>
<option value="1221">S-山宝</option>
<option value="153">S-山东常林</option>
<option value="14280">S-山东海宏</option>
<option value="1123">S-山东华夏</option>
<option value="13744">S-山东汇强</option>
<option value="137">S-山东临工</option>
<option value="13118">S-山东鲁工</option>
<option value="16382">S-山东鲁一</option>
<option value="13747">S-山东明龙</option>
<option value="13209">S-山东众和</option>
<option value="138">S-山工</option>
<option value="142">S-山河智能</option>
<option value="454">S-山猫</option>
<option value="13731">S-山美</option>
<option value="1722">S-山猛机械</option>
<option value="1304">S-山特维克</option>
<option value="144">S-山推</option>
<option value="13723">S-山推格林</option>
<option value="1207">S-山挖重工</option>
<option value="152">S-山重建机</option>
<option value="668">S-陕建机械</option>
<option value="1753">S-陕汽</option>
<option value="13728">S-陕西科尼乐</option>
<option value="16386">S-上海华东建筑</option>
<option value="691">S-上海华建</option>
<option value="13735">S-上海建冶</option>
<option value="201">S-上海金泰</option>
<option value="156">S-上海彭浦</option>
<option value="211">S-上海施维英</option>
<option value="13733">S-上海威力特</option>
<option value="13715">S-上海西芝</option>
<option value="1095">S-上海振中</option>
<option value="13718">S-上力重工</option>
<option value="741">S-上騏</option>
<option value="1113">S-神斧</option>
<option value="183">S-神钢</option>
<option value="1523">S-神马科技</option>
<option value="14235">S-神娃机械</option>
<option value="16383">S-神宇机械</option>
<option value="13746">S-沈阳广成</option>
<option value="830">S-沈阳三洋</option>
<option value="1720">S-沈阳山河</option>
<option value="1138">S-升立建机</option>
<option value="1090">S-盛利达</option>
<option value="618">S-盛隆</option>
<option value="190">S-石川岛</option>
<option value="168">S-石煤</option>
<option value="13727">S-世邦</option>
<option value="14255">S-世工机械</option>
<option value="13710">S-世联</option>
<option value="14251">S-世鑫源机械</option>
<option value="413">S-世运</option>
<option value="13711">S-仕高玛</option>
<option value="13714">S-首钢泰晟</option>
<option value="13719">S-双力</option>
<option value="13745">S-双牛</option>
<option value="771">S-双友机械</option>
<option value="419">S-水山</option>
<option value="13729">S-思嘉特</option>
<option value="13751">S-思拓瑞克</option>
<option value="16379">S-斯巴达</option>
<option value="13722">S-斯贝柯</option>
<option value="1102">S-斯达格思</option>
<option value="14279">S-斯泰克</option>
<option value="1117">S-四川建机</option>
<option value="13742">S-四通重工</option>
<option value="13739">嵩-嵩山重工</option>
<option value="1730">T-台励福</option>
<option value="538">T-太腾机械</option>
<option value="1728">T-泰安鲁能</option>
<option value="404">T-泰戈</option>
<option value="406">T-泰科</option>
<option value="14241">T-泰山力源</option>
<option value="1353">T-泰石克</option>
<option value="14261">T-泰信机械</option>
<option value="176">T-特雷克斯</option>
<option value="827">T-腾迈机械</option>
<option value="16384">滕-滕州远大</option>
<option value="13231">T-天地奔牛</option>
<option value="476">T-天地重工</option>
<option value="13754">T-天顺长城</option>
<option value="774">T-天为</option>
<option value="13755">T-天宇</option>
<option value="13752">T-田中铁工</option>
<option value="620">T-铁兵</option>
<option value="1758">T-铁建重工</option>
<option value="218">T-铁拓机械</option>
<option value="1726">T-通亚汽车</option>
<option value="1211">T-同力重工</option>
<option value="13753">T-土力机械</option>
<option value="210">T-拓能重机</option>
<option value="614">W-万邦重科</option>
<option value="16377">W-万龙机械</option>
<option value="1140">W-威海固恒</option>
<option value="1189">W-威肯</option>
<option value="491">W-威猛</option>
<option value="1738">W-威盛</option>
<option value="14256">W-威源机械</option>
<option value="214">W-维特根</option>
<option value="14263">W-潍柴特种车</option>
<option value="149">W-沃得重工</option>
<option value="662">W-沃尔华</option>
<option value="175">W-沃尔沃</option>
<option value="16352">W-沃特重工</option>
<option value="1760">W-无锡泰特</option>
<option value="1160">W-五羊建机</option>
<option value="13778">X-西安路邦</option>
<option value="1589">X-西贝</option>
<option value="13777">X-西尔玛</option>
<option value="13177">X-西林</option>
<option value="1590">X-西子起重</option>
<option value="623">X-犀牛重工</option>
<option value="13786">X-夏洲重工</option>
<option value="139">X-厦工</option>
<option value="13175">X-厦金</option>
<option value="13784">X-厦强</option>
<option value="1744">X-厦盛</option>
<option value="13783">X-厦装</option>
<option value="410">X-先锋</option>
<option value="194">X-现代</option>
<option value="1359">X-现代（山东）</option>
<option value="1227">X-现代建机</option>
<option value="1741">X-小橋</option>
<option value="182">X-小松</option>
<option value="13787">X-协兴</option>
<option value="13785">X-欣融</option>
<option value="13814">X-新波臣</option>
<option value="1708">X-新特重工</option>
<option value="1236">X-新天和</option>
<option value="13779">X-新型</option>
<option value="13098">X-新宇机械</option>
<option value="1683">X-新源机械</option>
<option value="690">X-新筑股份</option>
<option value="692">鑫-鑫国重机</option>
<option value="1115">鑫-鑫天地</option>
<option value="1235">X-信达机械</option>
<option value="1097">X-星邦重工</option>
<option value="205">X-星马汽车</option>
<option value="13788">X-雄辉</option>
<option value="1212">X-雄鹏机械</option>
<option value="209">X-徐工</option>
<option value="561">X-徐工汽车</option>
<option value="1522">X-徐工特机</option>
<option value="131">X-徐随</option>
<option value="150">X-徐挖</option>
<option value="544">X-徐威重科</option>
<option value="128">X-徐重</option>
<option value="1129">X-徐州建机</option>
<option value="867">X-徐州凯尔</option>
<option value="129">X-徐筑</option>
<option value="13619">X-雪狼</option>
<option value="687">X-雪桃</option>
<option value="13805">Y-亚工</option>
<option value="13798">Y-亚洁</option>
<option value="1148">Y-亚特</option>
<option value="155">Y-烟工</option>
<option value="425">Y-烟台瑞工</option>
<option value="14112">Y-烟台信人</option>
<option value="191">Y-洋马</option>
<option value="13795">Y-业豪</option>
<option value="13738">Y-一鼎重工</option>
<option value="13803">Y-一帆机械</option>
<option value="663">Y-一工机械</option>
<option value="159">Y-一拖</option>
<option value="13800">Y-依格曼</option>
<option value="770">Y-宜工</option>
<option value="680">Y-宜兴巍宇</option>
<option value="161">Y-移山</option>
<option value="13791">Y-亿龙机械</option>
<option value="13801">Y-亿通正龙</option>
<option value="1749">Y-忆辉</option>
<option value="13792">Y-易山重工</option>
<option value="13808">Y-益鑫</option>
<option value="1751">Y-银锚建机</option>
<option value="13232">Y-银起</option>
<option value="13793">Y-英达</option>
<option value="1777">Y-英轩重工</option>
<option value="1930">Y-永安机械</option>
<option value="647">Y-永工</option>
<option value="843">Y-永茂</option>
<option value="13806">Y-尤尼克</option>
<option value="408">Y-友一</option>
<option value="16327">Y-友一机械</option>
<option value="562">Y-愚公机械</option>
<option value="13802">Y-宇泰</option>
<option value="143">Y-宇通重工</option>
<option value="146">Y-玉柴</option>
<option value="13796">Y-豫弘重工</option>
<option value="13794">Y-原进</option>
<option value="16367">Y-原装日立</option>
<option value="16373">Y-原装神钢</option>
<option value="1152">Y-圆鑫建机</option>
<option value="1092">Y-圆友</option>
<option value="13799">Y-远东</option>
<option value="13736">Y-远华机械</option>
<option value="14238">Y-约翰迪尔</option>
<option value="13797">Y-岳首</option>
<option value="13804">Y-粤工</option>
<option value="13807">Y-运想重工</option>
<option value="13821">Z-泽通</option>
<option value="195">Z-詹阳动力</option>
<option value="1149">Z-章丘机械</option>
<option value="13811">Z-浙江赤道</option>
<option value="1119">Z-浙江建机</option>
<option value="14220">Z-浙江振中</option>
<option value="13817">Z-正泰</option>
<option value="13816">Z-郑州鼎盛</option>
<option value="813">Z-郑州富岛（川岛）</option>
<option value="13824">Z-中材建科</option>
<option value="13810">Z-中方机械</option>
<option value="1582">Z-中国虎工</option>
<option value="1214">Z-中国重汽</option>
<option value="13819">Z-中海恒通</option>
<option value="1219">Z-中环动力</option>
<option value="1106">Z-中集华骏</option>
<option value="13813">Z-中际</option>
<option value="1951">Z-中建机械</option>
<option value="542">Z-中交西筑</option>
<option value="1780">Z-中联土方</option>
<option value="134">Z-中联重科</option>
<option value="553">Z-中龙建机</option>
<option value="13820">Z-中青林</option>
<option value="13812">Z-中升</option>
<option value="1131">Z-中昇建机</option>
<option value="1682">Z-中铁二十局</option>
<option value="1151">Z-中文实业</option>
<option value="13823">Z-中意</option>
<option value="13815">Z-中誉鼎力</option>
<option value="1161">Z-重庆中建机械</option>
<option value="188">Z-竹内</option>
<option value="185">Z-住友</option>
<option value="13809">Z-筑马</option>
<option value="13818">Z-钻通</option>

					</select> 
					<span class="red" id="must1" style="color:white">*</span></td>
                </tr>
                <tr >
                	<td class="um_title" align="right">型号：</td>
                    <td><select class="upimg_sele"  id="model" name="model">
					<option value="">-请选择型号-</option>
					</select> <span class="red" id="must3" style="color:white">*</span></td>
                </tr>
				
				
                <tr>
                	<td class="um_title" align="right">描述：</td>
                    <td>
                    	<textarea placeholder="丰富你的图片描述吧：得票数高+标题及描述完善+迎合主题=更容易获奖！"  class="upimg_area" id="description" name="description"></textarea>
                    </td>
                </tr>
                <tr>
                	<td class="um_title" align="right">选择图片：</td>
                    <td>
                    	   <span id="addImgs"></span>
                    </td>
                </tr>
				 <tr>
                      <td colspan="2" style="padding-left:65px; padding-top:10px;"><ul class="showpic clearfix" id="addImgs_show">
                      </ul></td>         
               </tr>
                <tr>
                	<td class="um_title" align="right">&nbsp;</td>
                    <td>
                    	<span style="font-size:14px; color:#ff6600;">单张图片不超过6MB，图片尺寸 高520px × 宽440px。(可选择多张图片上传)</span>
                    </td>
                </tr>
                <tr>
                	<td class="um_title" align="right">&nbsp;</td>
                    <td>
                    	<a href="javascript:void(0)" onclick="doSubmit()"><img src="images/up_btn3.gif"/></a>
                    </td>
                </tr>
            </table>
			
			<input type="hidden" name="flag" value="photo_activity_save" />
	        <input type="hidden" name="jr_username" id="jr_username"  value="<%=username%>"/>
	        <input type="hidden" name="is_image" id="is_image"  value="0"/>

        </form>
    </div>
    <div class="kbclose_btn kbf_close"><img src="images/close_btn_03.gif"/></div>
</div>
<!--上传照片弹出结束-->
<script type="text/javascript" src="scripts/comm.js"></script>
<script type="text/javascript">
$('.kbf_close').click(function(){
	$('.upimg_bg').hide();
	$('.upimg_main').hide();
	$("#photo_form")[0].reset();
	jQuery("#model").empty("");
			
});

function showOther(obj){
    if(obj.value=='107002'){
		document.getElementById('must1').style.color= 'red'; 
		document.getElementById('must2').style.color= 'red'; 
		document.getElementById('must3').style.color= 'red'; 

	}else{
		document.getElementById('must1').style.color= 'white'; 
		document.getElementById('must2').style.color= 'white'; 
		document.getElementById('must3').style.color= 'white'; 
	}
}
/*
$('.kbf_show').click(function(){
	$('.upimg_bg').show();
	$('.upimg_main').show();
});
*/
function showUpdate(){
	$('.upimg_bg').show();
	$('.upimg_main').show();
}

</script>
<script type="text/javascript">
function addUrl(){
	var url = window.location.href;
    try{
       window.external.addFavorite(url, '铁臂商城');
   }catch (e){
       try{
           window.sidebar.addPanel('铁臂商城',url,"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}

$('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});
</script>
<div style="display:none"> 
<script src="http://s5.cnzz.com/stat.php?id=1253256301&web_id=1253256301" language="JavaScript"></script>
 <!-- <script src="http://s17.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script> -->
  <script src="http://s6.cnzz.com/stat.php?id=2697829&web_id=2697829" language="JavaScript"></script>
  <script src='http://w.cnzz.com/c.php?id=30058227&l=3' language='JavaScript'></script> 
</div>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="/scripts/validator.alert.js"></script>
<script type="text/javascript" src="http://resource.21-sun.com/plugin/upload/jr_upload.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script src="Static/js/seajs/sea.js" id="seanode"></script>
<script src="Static/js/seajs/seajs.config.js"></script>
<script>
	seajs.use('app/index.js');
</script>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
  try{
       window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
   }catch (e){
       try{
           window.sidebar.addPanel('21-sun产品中心', 'http://product.21-sun.com', "");
       }catch (e){
           alert("请使用Ctrl+D进行添加");
       }
   }
}

	jQuery.ajax({
    	type:'post',
    	url:'http://product.21-sun.com/action/ajax.jsp',
    	data:{flag:'product_visit'} ,
    	success:function(msg){
    	}
    });
	
	
	function vote(a){
	   if(setlooked(a)==1){
		jQuery.ajax({
    	type:'post',
    	url:'/action/ajax.jsp',
    	data:{flag:'photo_activity_vote',vote_id:a} ,
    	success:function(msg){
		    	if($.trim(msg)=="1"){
					alert('投票成功，感谢您的支持！'); 
				}else{
					alert('投票失败！'); 
				}
    	}
        });
		}else{
			alert('您已经投过票了哟！');
		}
   }
   
   	function setlooked(id){
		var x = 0;
		var imgs = jQuery.cookies.get("vote_photo");
		if(imgs==null || imgs == "" || imgs.indexOf("photo"+id) < 0){
			var newImgs = imgs+",photo"+id;
			jQuery.cookies.set("vote_photo",newImgs,{hoursToLive : 10});
			x = 1;
		}
		return x;
	}
	
	jQuery(function(){
		jQuery("#addImgs").JrUpload({
			remotUrl : "/activity/tuku/upload.jsp",
			folder : "product/photo_activity" ,
			sizeLimit:10*1024*1024, //10M
			multi : true,
			beforeCallback : "beforeCallback",
			callback : "setImgs" ,
			style : "width:98px;height:30px;",
			buttonImg : "/activity/tuku/images/1_22.jpg" ,
			buttonImgWidth : 77 ,
			buttonImgHeight : 30
		});
	});
	function beforeCallback(){
		$.jBox.tip("图片上传中，请稍后。。。", "loading");
	}
	function setImgs(data){
		var imgs = data.split(",");
		var htm = '';
		var f = 'http://product.21-sun.com/';
		for(var i=0;i<imgs.length;i++){
		    jQuery("#is_image").val('1');
			//htm += '<img style="margin-left:4px;" class="img" src="'+f+imgs[i]+'" width="90" height="60" />&nbsp;&nbsp;<input type="hidden" id="images" name="images" value="'+f+imgs[i]+'" /><a href="javascript:void(0);" onclick="removeThis(this);" attrId="0" class="img_delete" style="position:absolute;top:-7px;left:80px;"><img src="http://member.21-sun.com/home/used/images/delete.png" /></a>';
			htm += '<li style="float:left"><img class="img" src="'+f+imgs[i]+'" width="90" height="60" /><input type="hidden" id="images" name="images"  value="'+imgs[i]+'" /><a href="javascript:void(0);" onclick="removeThis(this);" attrId="0" class="img_delete" style="position:absolute;top:-7px;left:80px;"><img src="http://member.21-sun.com/home/used/images/delete.png" /></a></li>';
		}
		jQuery("#addImgs_show").append(htm);
		regEvent();
		$.jBox.closeTip();
	}
	function regEvent(){
		jQuery("#addImgs_show>li").mouseover(function(){
			jQuery(".img_delete").hide();
			jQuery(this).find(".img_delete").show();
		});
		jQuery("#addImgs_show>li").mouseout(function(){
			jQuery(".img_delete").hide();
		});
	}
	function removeThis(o){
		var attrId = jQuery(o).attr("attrId")+"";
		if(attrId=='0'){
			jQuery(o).parent().remove();
		}else{
			if(confirm("确定删除该张图片吗？")){
				jQuery(o).parent().remove();
			}
		}
	}
	
	
	function doSubmit(){
	 	    if(jQuery("#jr_title").val()==''){
			  alert("请填写标题!");
			  return ;
			} 
		    if(jQuery("#is_image").val()=='0'){
			  alert("请选择上传的图片!");
			  return ;
			}
            if(jQuery("#catalog").val()==''){
			  alert("请选择上传的类别!");
			  return ;
			}
	        if(jQuery("#catalog").val()=='107002'){
			    if(jQuery("#catalognum").val()==''){alert("请选择机器类别!");return;}
				if(jQuery("#brand").val()==''){alert("请选择机器厂家!");return;};
				if(jQuery("#model").val()==''){alert("请选择机器型号!");return;};
				
			}
	
			jQuery("#photo_form").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data){
					if($.trim(data)=="fail"){
						 alert('图片提交失败！'); 
					}else{
					  alert('图片提交成功！'); 
	                 setTimeout("window.location.reload()",1000);					}
				}					  
			});
	}
	
	
	function chooseBrand(v){
	var rand = Math.random();
	var c = $.trim(jQuery("#catalognum").val());
	var v = $.trim(jQuery("#brand").val());
	if(c!=""&&v!=""){
		jQuery.ajax({
			url:'products.jsp?r='+rand+'&v='+encodeURI(v)+'&c='+encodeURI(c),
			async:false,
			cache:false,
			success:function(data){
				jQuery("#model").empty("");
				jQuery("#model").append(jQuery.trim(data));
			}
		});
	}
	}
</script> 
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>