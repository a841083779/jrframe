<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<cache:cache  cron="* * * */1 *">
<%
	DBHelper dbHelper = DBHelper.getInstance();
	Map catalogMap = (Map) application.getAttribute("catalogMap");
	Map brandMap = (Map) application.getAttribute("brandMap");
	String areaQuery = "select  name,num  from pro_agent_province_city";
    List<Map> numNameMap1 = dbHelper.getMapList(areaQuery);
    LinkedHashMap numNameMap = new LinkedHashMap();
	for(Map areaM : numNameMap1){
			numNameMap.put(CommonString.getFormatPara(areaM.get("num")), CommonString.getFormatPara(areaM.get("name")));
	}
	//Map nameNumMap = (Map) application.getAttribute("nameNumMap");
   //Map numNameMap = (Map) application.getAttribute("numNameMap");

	String offset = CommonString.getFormatPara(request.getParameter("offset"));
	String url = CommonString.getFormatPara(request.getQueryString());
	String province = CommonString.getFormatPara(request.getParameter("province"));
	String city = CommonString.getFormatPara(request.getParameter("city"));
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	if(province.equals("")){province="0";}  	if(city.equals("")){city="0";}
	if(factory.equals("")){factory="0";}  	if(catalog.equals("")){catalog="0";}
	StringBuffer whereStr = new StringBuffer(" and is_show=1 and flag=2 ");
	
	String catalogStr="";
    if(!catalog.equals("0")&&!catalog.equals("")){catalogStr=" and id in ( select distinct agent_id from pro_agent_products where catalognum like '"+catalog+"%')";}
	if(!catalogStr.equals("")){whereStr.append(catalogStr);}
		
    if(!factory.equals("0")&&!factory.equals("")){whereStr.append(" and ( agent_fac LIKE '%"+factory+",%' OR agent_fac LIKE '%,"+factory+"%' or agent_fac = '"+factory+"' ) ");}
    if(!province.equals("0")&&!province.equals("")){
	    String p=CommonString.getFormatPara(numNameMap.get(province));
	    whereStr.append(" and (full_name like '%"+p+"%' or address like '%"+p+"%' or city like '%"+p+"%')");
	}
    if(!city.equals("0")&&!city.equals("")){
	    String c=CommonString.getFormatPara(numNameMap.get(city));
	    whereStr.append(" and (full_name like '%"+c+"%' or address like '%"+c+"%' or city like '%"+c+"%')");
	}

	    Connection connection = null;
		try{
		connection = dbHelper.getConnection();
		PageBean pageBean = new PageBean(); // 分页程序
		pageBean.setPageSize(6); // 每页显示条数
		pageBean.setCondition(whereStr.toString());
		pageBean.setParams(url);
		pageBean.setIsShowSql(false);
		pageBean.setFields(" usern,is_qijiandian,is_made,full_name,city,address,img1,agent_fac_name,agent_fac ");
		pageBean.setTableName("pro_agent_factory");
		pageBean.setOrderBy(" is_shop desc,view_count DESC , name DESC , id DESC ") ;

		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
		pageBean.setNowPage(nowPage);
		List<Map> cityList= null ;
		if(!province.equals("0")&&!province.equals("101")&&!province.equals("102")&&!province.equals("103")&&!province.equals("104")){
	    cityList = dbHelper.getMapList(" select * from  pro_agent_province_city where parent_num ='"+province+"' ") ; 
		}
		//TDK
		String title="【工程机械代理商】工程机械代理商商家信息– 铁臂商城代理商平台";
		String keywords="工程机械代理商,工程机械代理商商家信息";
		String description="铁臂商城代理商平台拥有全国各个地区的工程机械代理商信息,是工程机械代理商信息最全的平台，买工程机械产品就上铁臂商城。";
		if(province.equals("0")&&city.equals("0")){
		    if(!factory.equals("0")||!catalog.equals("0")){
		        title="【"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商】"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商商家信息 – 铁臂商城代理商平台";
		        keywords=CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商,"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商商家信息";
		        description="铁臂商城代理商平台拥有全国各个地区的"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商信息,是"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商信息最全的代理商平台，买"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"就上铁臂商城。";
		    }
		}else{
		     title="【"+CommonString.getFormatPara(numNameMap.get(province))+CommonString.getFormatPara(numNameMap.get(city))+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商】"+CommonString.getFormatPara(numNameMap.get(province))+CommonString.getFormatPara(numNameMap.get(city))+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商商家信息 – 铁臂商城代理商平台";
			 keywords=""+CommonString.getFormatPara(numNameMap.get(province))+CommonString.getFormatPara(numNameMap.get(city))+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商,"+CommonString.getFormatPara(numNameMap.get(province))+CommonString.getFormatPara(numNameMap.get(city))+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商商家信息";
			 description="铁臂商城代理商平台拥有"+CommonString.getFormatPara(numNameMap.get(province))+CommonString.getFormatPara(numNameMap.get(city))+"地区的"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商信息,是"+CommonString.getFormatPara(numNameMap.get(province))+CommonString.getFormatPara(numNameMap.get(city))+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商信息最全的代理商平台，买"+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"就上铁臂商城。";
		}
		String h1="工程机械代理商";
		if(!factory.equals("0")||!catalog.equals("0")||!province.equals("0")||!city.equals("0"))
		{
		   h1=CommonString.getFormatPara(numNameMap.get(province))+CommonString.getFormatPara(numNameMap.get(city))+CommonString.getFormatPara(brandMap.get(factory))+CommonString.getFormatPara(catalogMap.get(catalog))+"代理商";
		}
		List<Map> listBrand=null;
%>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=title%></title>
<meta name="keywords" content="<%=keywords%>" />
<meta name="description" content="<%=description%>" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<link href="http://product.21-sun.com/style/style.css" rel="stylesheet" />
<link href="http://product.21-sun.com/dealer/style/style.css" rel="stylesheet" />
<script type="text/javascript" src="http://product.21-sun.com/scripts/jquery.min.js"></script>
<script type="text/javascript" src="http://product.21-sun.com/scripts/scripts.js"></script>
<script type="text/javascript">
//导航选中状态
//var jrChannel='4#0'
</script>
</head>
<body>
<!--top-->
<jsp:include page="include/top.jsp" flush="true" />
<!--top end-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂商城代理商平台</a>
  <%if(!province.equals("0")){%>
  &gt;&gt; <a href="/<%=province%>_0_0_0_0.shtm"><%=CommonString.getFormatPara(numNameMap.get(province))%></a>
  <%}%>
  <%if(!city.equals("0")){%>
   &gt;&gt; <a href="/<%=province%>_<%=city%>_0_0_0.shtm"><%=CommonString.getFormatPara(numNameMap.get(city))%></a>
  <%}%>
  <%if(!factory.equals("0")){%>
	&gt;&gt; <a href="/0_0_<%=factory%>_0_0.shtm"><%=CommonString.getFormatPara(brandMap.get(factory))%></a>
  <%}%>
  <%if(!catalog.equals("0")){%>
	 &gt;&gt; <a href="/0_0_0_<%=catalog%>_0.shtm"><%=CommonString.getFormatPara(catalogMap.get(catalog))%></a>
  <%}%>
	  &gt;&gt; <%=CommonString.getFormatPara(numNameMap.get(province))%><%=CommonString.getFormatPara(numNameMap.get(city))%><%=CommonString.getFormatPara(brandMap.get(factory))%><%=catalog.equals("0")?"工程机械":CommonString.getFormatPara(catalogMap.get(catalog))%>代理商
  </h3>
</div>

<div class="contain980 fix">
  <!--left-->
  <div class="w210 l">
    <div class="comBox02 mb10">
      <div class="hd">
        <h3>代理商热点</h3>
      </div>
      <div class="bd">
        <ul class="comList">
		<jsp:include page="/include/agent_new/agent_left_news.jsp" flush="true" />
        </ul>
      </div>
    </div>
    
    <div class="comBox02 mb10 ag_rank">
      <div class="hd">
        <h3><%=CommonString.getFormatPara(brandMap.get(factory))%><%=CommonString.getFormatPara(catalogMap.get(catalog))%>代理商关注排行</h3>
      </div>
      <div class="bd">
        <ul class="list003">
		    <jsp:include page="/include/agent_new/agent_left_rank.jsp" flush="true" >
                <jsp:param name="factory" value="<%=factory%>"></jsp:param>
				<jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
            </jsp:include>      
        </ul>
      </div>
    </div>
    
    <div class="comBox02 mb10 ag_rank">
      <div class="hd">
        <h3>猜你想看</h3>
      </div>
      <div class="bd">
        <ul class="list003">
		    <jsp:include page="/include/agent_new/guess_like.jsp" flush="true" >
                <jsp:param name="factory" value="<%=factory%>"></jsp:param>
				<jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
            </jsp:include> 
        </ul>
      </div>
    </div>
    
  </div>
  <!--left end-->
  <!--right-->
  <div class="w757 r">
    <!--代理商筛选-->
    <div class="w755 border03 l Condition mb10">
      <div class="ConditionTop">
        <div class="l">

          <%if(!"0".equals(catalog) || !"0".equals(factory)|| !"0".equals(province)|| !"0".equals(city)) { %>
         <a href="/0_0_0_0_0.shtm"> <span class="reset" >重置</span></a>
          <%}%>
          <%if (!"0".equals(province) ) { %>
          <span><em><%=CommonString.getFormatPara(numNameMap.get(province))%></em> <a  class="delete"href="/0_0_<%=factory%>_<%=catalog%>_0.shtm"></a> </span>
          <% } %>
          <% if (!"0".equals(city) ) { %>
          <span><em><%=CommonString.getFormatPara(numNameMap.get(city))%></em> <a class="delete" href="/<%=province%>_0_<%=factory%>_<%=catalog%>_0.shtm"  ></a> </span>
          <% } %>
          <%if (!"0".equals(factory) ) { %>
          <span><em><%=CommonString.getFormatPara(brandMap.get(factory))%></em> <a class="delete" href="/<%=province%>_<%=city%>_0_<%=catalog%>_0.shtm"></a> </span>
          <% } %>
		  <%if (!"0".equals(catalog) ) { %>
          <span><em><%=CommonString.getFormatPara(catalogMap.get(catalog))%></em> <a class="delete" href="/<%=province%>_<%=city%>_<%=factory%>_0_0.shtm"></a> </span>
          <% } %>

		</div>
        <h1 style="font-size:14px;" class="r"><%=h1%></h1>
      </div>
      <ul class="ConditionBottom">
        <script type="text/javascript">
        jQuery(document).ready(function() {
            jQuery(".pbtn").click(function(){
                jQuery(this).next("div").slideToggle(0)
                .siblings(".plmore:visible").slideUp(0);
                jQuery(this).toggleClass("pbon");
                jQuery(this).siblings(".pbon").removeClass("pbon");
            });	
        });
        </script>
        <li class="cblist">
          <dt> 省份 </dt>
          <dd> <a href="/0_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("0")){%>class='select'<%}%>>不限</a>
		  <a   href="/101_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("101")){%>class='select'<%}%>>北京</a> 
		  <a   href="/102_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("102")){%>class='select'<%}%>>天津</a> 
		  <a   href="/103_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("103")){%>class='select'<%}%>>上海</a> 
		  <a   href="/104_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("104")){%>class='select'<%}%>>重庆</a> 
		  <a   href="/105_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("105")){%>class='select'<%}%>>山东</a> 
		  <a   href="/106_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("106")){%>class='select'<%}%>>河北</a> 
		  <a   href="/107_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("107")){%>class='select'<%}%>>山西</a> 
		  <a   href="/108_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("108")){%>class='select'<%}%>>内蒙古</a> 
		  <a   href="/109_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("109")){%>class='select'<%}%> >江苏</a> 
		  <a   href="/110_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("110")){%>class='select'<%}%>>浙江</a> 
		  <a   href="/111_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("111")){%>class='select'<%}%>>安徽</a> 
		  <a   href="/112_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("112")){%>class='select'<%}%>>广东</a> 
		  <a   href="/113_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("113")){%>class='select'<%}%>>福建</a> 
		  <a   href="/114_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("114")){%>class='select'<%}%>>广西</a> 
		  <a   href="/115_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("115")){%>class='select'<%}%>>江西</a> 
		  <a   href="/116_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("116")){%>class='select'<%}%>>海南</a> 
		  <a   href="/117_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("117")){%>class='select'<%}%>>河南</a> 
		  <a   href="/118_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("118")){%>class='select'<%}%> >湖北</a> 
		  <a   href="/119_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("119")){%>class='select'<%}%>>湖南</a> 
		  <a   href="/120_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("120")){%>class='select'<%}%>>辽宁</a> 
		  <a   href="/121_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("121")){%>class='select'<%}%>>吉林</a> 
		  <a   href="/122_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("122")){%>class='select'<%}%>>黑龙江</a> 
		  <a   href="/123_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("123")){%>class='select'<%}%>>四川</a> 
		  <a   href="/124_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("124")){%>class='select'<%}%>>贵州</a> 
		  <a   href="/125_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("125")){%>class='select'<%}%>>云南</a> 
		  <a   href="/126_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("126")){%>class='select'<%}%>>西藏</a> 
		  <a   href="/127_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("127")){%>class='select'<%}%>>陕西</a> 
		  <a   href="/128_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("128")){%>class='select'<%}%>>甘肃</a> 
		  <a   href="/129_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("129")){%>class='select'<%}%>>青海</a> 
		  <a   href="/130_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("130")){%>class='select'<%}%>>宁夏</a> 
		  <a   href="/131_0_<%=factory%>_<%=catalog%>_0.shtm" <%if(province.equals("131")){%>class='select'<%}%>>新疆</a> 
		  </dd>
        </li>
		<%	if(!province.equals("0")&&!province.equals("101")&&!province.equals("102")&&!province.equals("103")&&!province.equals("104")&&cityList != null && cityList.size() > 0){%>
        <li class="cblist" id="city"  >
          <dt> 城市 </dt>
          <dd class="city"> 
		  <a href="/<%=province%>_0_<%=factory%>_<%=catalog%>_0.shtm" <%if("0".equals(city)){%>class='select' <%}%>>不限</a>
		  <%for (Map oneMap : cityList) {%>
		  <a <%if(city.equals(CommonString.getFormatPara(oneMap.get("num")))){%>class='select'<%}%>  href="/<%=province%>_<%=CommonString.getFormatPara(oneMap.get("num"))%>_<%=factory%>_<%=catalog%>_0.shtm"><%=CommonString.getFormatPara(oneMap.get("name"))%></a> 
		  <%}%>
        </li>
		<%}%>
        <li class="cblist">
          <dt> 类别 </dt>
          <dd> <a href="/<%=province%>_<%=city%>_<%=factory%>_0_0.shtm"  <%if(catalog.equals("0")){%>class='select'<%}%>>不限</a> 
		  <a href="/<%=province%>_<%=city%>_<%=factory%>_101001_0.shtm" <%if(catalog.equals("101001")){%>class='select'<%}%>>挖掘机</a>
		  <a href="/<%=province%>_<%=city%>_<%=factory%>_101002_0.shtm" <%if(catalog.equals("101002")){%>class='select'<%}%>>装载机</a>
		  <a href="/<%=province%>_<%=city%>_<%=factory%>_102_0.shtm" <%if(catalog.equals("102")){%>class='select'<%}%>>起重机</a>
		  <a href="/<%=province%>_<%=city%>_<%=factory%>_101003_0.shtm" <%if(catalog.equals("101003")){%>class='select'<%}%>>推土机</a>
		  <a href="/<%=province%>_<%=city%>_<%=factory%>_103_0.shtm" <%if(catalog.equals("103")){%>class='select'<%}%>>混凝土</a>
		  <a href="/<%=province%>_<%=city%>_<%=factory%>_106001_0.shtm" <%if(catalog.equals("106001")){%>class='select'<%}%>>压路机</a>
		  <a href="/<%=province%>_<%=city%>_<%=factory%>_101005_0.shtm" <%if(catalog.equals("101005")){%>class='select'<%}%>>平地机</a>
		  <a href="/<%=province%>_<%=city%>_<%=factory%>_105003_0.shtm" <%if(catalog.equals("105003")){%>class='select'<%}%>>旋挖钻</a>
		  <a href="/<%=province%>_<%=city%>_<%=factory%>_113001_0.shtm" <%if(catalog.equals("113001")){%>class='select'<%}%>>破碎锤</a>
		  <a href="/<%=province%>_<%=city%>_<%=factory%>_104001_0.shtm" <%if(catalog.equals("104001")){%>class='select'<%}%>>摊铺机</a>
            <div id="changethis" class="pbtn"></div>
            <div class="plmore" style="padding-left: 0px; width: 680px;">
		    <jsp:include page="/include/agent_new/catalog.jsp" flush="true" >
                <jsp:param name="province" value="<%=province%>"></jsp:param>
				<jsp:param name="city" value="<%=city%>"></jsp:param>
            </jsp:include>  
            </div>
          </dd>
        </li>

        <li class="cblist">
          <dt> 品牌 </dt>
          <dd>
		  <a <%if("0".equals(factory)){%>class='select'<%}%>  href="/<%=province%>_<%=city%>_0_<%=catalog%>_0.shtm">不限</a>
		  
		  <%if(catalog.equals("0")||catalog.equals("")){%>
		  <a <%if("133".equals(factory)){%> class='select' <%} %>   href="/<%=province%>_<%=city%>_133_<%=catalog%>_0.shtm">三一</a>
		  <a <%if("182".equals(factory)){%>class='select'<%}%>  href="/<%=province%>_<%=city%>_182_<%=catalog%>_0.shtm">小松</a>
		  <a <%if("192".equals(factory)){%>class='select'<%}%>  href="/<%=province%>_<%=city%>_192_<%=catalog%>_0.shtm">斗山</a>
		  <a <%if("184".equals(factory)){%>class='select'<%}%>  href="/<%=province%>_<%=city%>_184_<%=catalog%>_0.shtm">日立</a>
		  <a <%if("183".equals(factory)){%>class='select'<%}%>  href="/<%=province%>_<%=city%>_183_<%=catalog%>_0.shtm">神钢</a>
		  <a <%if("175".equals(factory)){%>class='select'<%}%>  href="/<%=province%>_<%=city%>_175_<%=catalog%>_0.shtm">沃尔沃</a>
		  <a <%if("174".equals(factory)){%>class='select'<%}%> href="/<%=province%>_<%=city%>_174_<%=catalog%>_0.shtm">卡特彼勒</a>
		  <a <%if("146".equals(factory)){%>class='select'<%}%>  href="/<%=province%>_<%=city%>_146_<%=catalog%>_0.shtm">玉柴重工</a>
		  <a <%if("136".equals(factory)){%>class='select'<%}%> href="/<%=province%>_<%=city%>_136_<%=catalog%>_0.shtm">柳工</a>
		  <a <%if("194".equals(factory)){%>class='select'<%}%>  href="/<%=province%>_<%=city%>_194_<%=catalog%>_0.shtm">现代京城</a>
		  <a <%if("1220".equals(factory)){%>class='select'<%}%> href="/<%=province%>_<%=city%>_1220_<%=catalog%>_0.shtm">华通动力</a>
		  <%}else{
		  listBrand= dbHelper.getMapList("select top 10 name,id from pro_agent_factory where id in(select distinct(factoryid) from pro_products  where is_show=1 and catalognum like '"+catalog+"%') order by view_count desc",connection) ;
          if(listBrand!=null&& listBrand.size() > 0){	
             for (Map oneMap : listBrand) {		  
		 %>
		  	 <a <%if((CommonString.getFormatPara(oneMap.get("id"))).equals(factory)){%>class='select'<%}%> href="/<%=province%>_<%=city%>_<%=CommonString.getFormatPara(oneMap.get("id"))%>_<%=catalog%>_0.shtm"><%=CommonString.getFormatPara(oneMap.get("name"))%></a>
		  <%}}}%>
		  
            <div id="changethis" class="pbtn"></div>
            <div class="plmore" style="padding-left: 0px; width: 680px;">
   		    <jsp:include page="/include/agent_new/brand.jsp" flush="true" >
                <jsp:param name="province" value="<%=province%>"></jsp:param>
				<jsp:param name="city" value="<%=city%>"></jsp:param>
				<jsp:param name="catalog" value="<%=catalog%>"></jsp:param>
            </jsp:include>  
            </div>
          </dd>
        </li>
        
      </ul>
    </div>

	<%List<Map> agentList = pageBean.getDatas(connection); %>
    <div class="agent_list">
      <ul class="fix">
	    <%	
			    int i=1; String area=""; String agentUrl="";  String showUrl=""; String facList [];  String facId="";
				if (agentList != null && agentList.size() > 0) {
					for (Map oneMap : agentList) {
					area=CommonString.getFormatPara(oneMap.get("city")) ;
					if(area.length()>20){area=area.substring(0,20)+"...";}
					if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){
					   url="http://product.21-sun.com/agentstore/"+CommonString.getFormatPara(oneMap.get("usern"))+"/";
					   showUrl=url;
					}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){
					   url="http://"+CommonString.getFormatPara(oneMap.get("usern"))+".product.21-sun.com";
					   showUrl=url;
					}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){
					   url="http://product.21-sun.com/agentshop02/"+CommonString.getFormatPara(oneMap.get("usern"))+"/";
					   showUrl=url;
					}else{
					   url="/"+CommonString.getFormatPara(oneMap.get("usern"))+"/";
					   showUrl="http://dealer.21-sun.com"+url;
					}
					facId=CommonString.getFormatPara(oneMap.get("agent_fac"));
					facList=facId.split(",");
	    %>
        <li><em class="nm"><%=i%></em>
		
          <a href="<%=url%>" target="blank" title="<%=CommonString.getFormatPara(oneMap.get("full_name")) %>">
		  
		  <img onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"  src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img1")) %>" class="agimg"></a>
          <div class="intro">
            <h2><a target="_blank" href="<%=url%>" title="<%=CommonString.getFormatPara(oneMap.get("full_name")) %>"><%=CommonString.getFormatPara(oneMap.get("full_name")) %></a></h2>
            <div class="text">
              <dl><strong>主营品牌：</strong>
			  <%for(int ii=0;ii<facList.length;ii++){%>
			  [<a title="<%=CommonString.getFormatPara(brandMap.get(facList[ii]))%>" href="/0_0_<%=facList[ii]%>_0_0.shtm"><%=CommonString.getFormatPara(brandMap.get(facList[ii]))%></a>] 
			  <%}%>
			  </dl>
              <dl><strong>代理区域：</strong> <%=area%></dl>
              <dl><strong>详细地址：</strong> <%=CommonString.getFormatPara(oneMap.get("address")).equals("")?"暂无":CommonString.getFormatPara(oneMap.get("address")) %></dl>
              <dl><strong>公司网址：</strong> <a target="_blank" href="<%=showUrl%>" title="<%=showUrl%>"><%=showUrl%></a></dl>
            </div>
          </div>
        </li>
    <%i++;}}else{%>
	   <div align="center" style="padding-top:10px;font-size:14px;">暂无此代理商，给您推荐其他代理商！</div>
	<%
	     agentList=dbHelper.getMapList(" select top 10 usern,is_qijiandian,is_made,full_name,city,address,img1,agent_fac_name,agent_fac from  pro_agent_factory where flag=2 and is_show=1 order by is_shop desc,view_count DESC") ; 
		 if (agentList != null && agentList.size() > 0) {
			for (Map oneMap : agentList) {
				    area=CommonString.getFormatPara(oneMap.get("city")) ;
					if(area.length()>20){area=area.substring(0,20)+"...";}
					if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){
					   url="http://product.21-sun.com/agentstore/"+CommonString.getFormatPara(oneMap.get("usern"))+"/";
					   showUrl=url;
					}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("1")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){
					   url="http://"+CommonString.getFormatPara(oneMap.get("usern"))+".product.21-sun.com";
					   showUrl=url;
					}else if(CommonString.getFormatPara(oneMap.get("is_qijiandian")).equals("2")&&!CommonString.getFormatPara(oneMap.get("is_made")).equals("1")){
					   url="http://product.21-sun.com/agentshop02/"+CommonString.getFormatPara(oneMap.get("usern"))+"/";
					   showUrl=url;
					}else{
					   url="/"+CommonString.getFormatPara(oneMap.get("usern"))+"/";
					   showUrl="http://dealer.21-sun.com"+url;
					}
					facId=CommonString.getFormatPara(oneMap.get("agent_fac"));
					facList=facId.split(",");
	%>
	        <li><em class="nm"><%=i%></em>
		
          <a href="<%=url%>" target="blank" title="<%=CommonString.getFormatPara(oneMap.get("full_name")) %>">
		  
		  <img onerror="showImgDelay(this,'/uploadfiles/no_big.gif',2);"  src="http://product.21-sun.com/uploadfiles/<%=CommonString.getFormatPara(oneMap.get("img1")) %>" class="agimg"></a>
          <div class="intro">
            <h2><a target="_blank" href="<%=url%>" title="<%=CommonString.getFormatPara(oneMap.get("full_name")) %>"><%=CommonString.getFormatPara(oneMap.get("full_name")) %></a></h2>
            <div class="text">
              <dl><strong>主营品牌：</strong>
			  <%for(int ii=0;ii<facList.length;ii++){%>
			  [<a title="<%=CommonString.getFormatPara(brandMap.get(facList[ii]))%>" href="/0_0_<%=facList[ii]%>_0_0.shtm"><%=CommonString.getFormatPara(brandMap.get(facList[ii]))%></a>] 
			  <%}%>
			  </dl>
              <dl><strong>代理区域：</strong> <%=area%></dl>
              <dl><strong>详细地址：</strong> <%=CommonString.getFormatPara(oneMap.get("address")).equals("")?"暂无":CommonString.getFormatPara(oneMap.get("address")) %></dl>
              <dl><strong>公司网址：</strong> <a target="_blank" href="<%=showUrl%>" title="<%=showUrl%>"><%=showUrl%></a></dl>
            </div>
          </div>
        </li>
	
	<%i++;}}}%>
      </ul>
      
      <div class="comPage">
        <div class="page" id="pagination">
		          <tags:page_agent_new pageBean="<%=pageBean %>"   province="<%=province %>" city="<%=city %>"  factoryid="<%=factory%>"  catalog="<%=catalog%>" />
        </div>
      </div>
      
    </div>
  </div>
  <!--right end-->
</div>

<!--foot-->
<div class="foot_box">
<jsp:include page="/include/foot.jsp" flush="true" />
</div>
<!--foot end-->
<div style="display:none">     <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_5953941'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/stat.php%3Fid%3D5953941' type='text/javascript'%3E%3C/script%3E"));</script> </div>

</body>
<script type="text/javascript" src="http://product.21-sun.com/dealer/scripts/common.js"></script>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>
</cache:cache>