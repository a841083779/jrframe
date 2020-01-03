<%@ page language="java" import="com.jerehnet.util.dbutil.PageBean,com.jerehnet.util.common.CommonString,com.jerehnet.util.dbutil.DBHelper,java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags" %>
<%
   Map oneMap = null ;
	String fullName=null;
	String imgSrc=null;
	String catalogName="";
	String name=null;
	String file_name=null;	
	String id =null;
  DBHelper dbHelper = DBHelper.getInstance() ;
	
  //热销车型
  String sql = "select id,name,factoryname,file_name,img2,zoomlion_hot_pic ,catalogname  from pro_products where factoryid=767 and is_show=1 and id=20385 or id=9797 or id=20412 order by view_count desc" ;
  List<Map> productsList = null ;
  productsList = dbHelper.getMapList(sql) ;
  //罐车产品
   String sql_gc = "select  id,name,factoryname,file_name,img2,catalogname,zoomlion_hot_pic ,catalogname_spe  from pro_products where factoryid=767 and is_show=1 and id=20385 or id=9801 or id=10312 or id=20408  order by view_count desc" ;
	List<Map> productsListgc = null ;
	productsListgc = dbHelper.getMapList(sql_gc) ;
   //环卫产品
	String sql_hw = "select top 3 id,name,factoryname,file_name,img2,catalogname,zoomlion_hot_pic ,catalogname_spe  from pro_products where catalognum_spe like '102%' and factoryid=767 and is_show=1 and img2 <>'' order by view_count desc" ;
	List<Map> productsListhw = null ;
	productsListhw = dbHelper.getMapList(sql_hw) ;
  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>中集凌宇旗舰店-中国工程机械商贸网</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/lingyu.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="/scripts/jquery.SuperSlide.js"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if IE 6]>
<script src="/scripts/iepng.js"></script>
<script>
   EvPNG.fix('.png')
</script>
<![endif]-->
</head>
<body class="fy_body">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<!--top end--> 
<!--main-->
<div class="ly_top">
  <div class="wrap ly_fav">联系电话：0379-65937600<span onclick="addShop()" style="cursor:pointer">收藏本店</span></div>
  <div class="ly_nav">
    <div class="wrap fix ly_mu">
      <h1><a href="/brandshop/lingyu/"><img src="images/logo.png" width="308" height="75" alt="凌宇汽车" /></a></h1>
      <ul class="fix">
        <li class="f"><a href="/brandshop/lingyu/" class="cur">首页</a></li>
        <li><a href="/brandshop/lingyu/list.jsp?catalog=101" title="罐车产品">罐车产品</a></li>
        <li class="l"><a href="/brandshop/lingyu/list.jsp?catalog=102" title="环卫产品" >环卫产品</a></li>
      </ul>
    </div>
  </div>
</div>
<div class="wrap ly_lx fix">
  <div class="dg">产品推荐</div>
  <div class="bd">
    <ul>
	<li><img src="images/lx_01.jpg" width="703" height="322"></li>
      <li><img src="images/lx_03.jpg" width="703" height="322"></li>  
    </ul>
  </div>
  
  <div class="hd">
    <ul>
      <li><img src="images/lx_05.jpg" width="266" height="148"></li>
      <li><img src="images/lx_03.jpg" width="266" height="148"></li>
    </ul>
  </div>
  <a href="javascript:void(0)" class="h_btn prev"></a> <a href="javascript:void(0)" class="h_btn next"></a> </div>
<div class="ly_pro">
  <div class="hot wrap">
    <ul class="fix">
		   <% 
                  
                  if(null!=productsList && productsList.size()>0){
                    for(int i=0;i<productsList.size();i++){
                      oneMap = (HashMap)productsList.get(i);		
					  catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));					  
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
      <li>
        <div class="hot_png">
          <div class="rxcx">热销车型</div>
        </div>
		<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
		<img title="<%=fullName+catalogName%>" width="274" height="160" src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"alt="<%=fullName+catalogName%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/>
		</a>
        <div class="pro_info fix">
		<div class="l">
			<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
          <strong><%=catalogName%><br /><%=name%></strong>	
			</a>
			<a target="_blank" class="cs" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")  %>_parameter.shtm">参数</a>
			<a  target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2" class="pj">评论</a>
			</div>
          <div class="r"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','144')"  class="ljxj">立即询价</a></div>
        </div>
      </li>
      <%}}%>
    </ul>
  </div>
  <div class="channel fix">
    <h2>罐车产品</h2>
    <span><a href="list.jsp?catalog=101" title="罐车产品">更多></a></span> </div>
  <div class="hot wrap gc">
    <ul class="fix">
	<% 
                  
                  if(null!=productsListgc && productsListgc.size()>0){
                    for(int i=0;i<productsListgc.size();i++){
                      oneMap = (HashMap)productsListgc.get(i);		
					  catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));					  
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
      <li>
       <div class="dg"><%=catalogName.substring(0,catalogName.length()-3)%></div>
	   <a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
		<img title="<%=fullName+catalogName%>" width="460" height="265" src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"alt="<%=fullName+catalogName%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/>
		</a>
        <div class="pro_info fix">
		<div class="l">
          <a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
          <strong><%=catalogName%><br /><%=name%></strong>	
			</a>											
			<a target="_blank" class="cs" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")  %>_parameter.shtm">参数</a>
			<a  target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2" class="pj">评论</a>
			</div>
          <div class="r"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','144')"  class="ljxj">立即询价</a></div>
        </div>
      </li>
	  <%}}%>
    </ul>
  </div>
  <div class="pro_btm_bg"></div>
  <div class="channel fix">
    <h2>环卫产品</h2>
    <span><a href="list.jsp?catalog=102" title="环卫产品">更多></a></span> </div>
  <div class="wrap gc"> <img src="images/hwcp.jpg" width="939" height="267"> </div>
  <div class="pro_btm_bg mb20"></div>
  <div class="hot wrap">
    <ul class="fix">
	<% 
                  
                  if(null!=productsListhw && productsListhw.size()>0){
                    for(int i=0;i<productsListhw.size();i++){
                      oneMap = (HashMap)productsListhw.get(i);		
					  catalogName=CommonString.getFormatPara(oneMap.get("catalogname"));					  
                      fullName=CommonString.getFormatPara(oneMap.get("factoryname"))+CommonString.getFormatPara(oneMap.get("name"));
                      
                      imgSrc=CommonString.getFormatPara(oneMap.get("zoomlion_hot_pic"));
					  name=CommonString.getFormatPara(oneMap.get("name"));
					  file_name=CommonString.getFormatPara(oneMap.get("file_name"));
					  id=CommonString.getFormatPara(oneMap.get("id"));
					  if(imgSrc.equals("")){imgSrc=CommonString.getFormatPara(oneMap.get("img2"));}
                  %>
      <li>
			<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
		<img title="<%=fullName+catalogName%>" width="274" height="160" src="http://product.21-sun.com/uploadfiles/<%=imgSrc %>"alt="<%=fullName+catalogName%>" onerror="showImgDelay(this,'/uploadfiles/no_small.gif',2);"/>
		</a>        
        <div class="pro_info fix" >
          <div class="l">
			<a title="<%=fullName+catalogName%>"href="/proDetail/<%=file_name %>" target="_blank">
          <strong><%=catalogName%><br /><%=name%></strong>	
			</a>
			<a target="_blank" class="cs" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","")  %>_parameter.shtm">参数</a>
			<a  target="_blank" href="/proDetail/<%=CommonString.getFormatPara(oneMap.get("file_name")).replace(".shtm","") %>_message.shtm#myTab2" class="pj">评论</a>
			</div>
          <div class="r"><a href="javascript:void(0);" onclick="showinquery('<%=id %>','144')"  class="ljxj">立即询价</a></div>
        </div>
        
		
      </li>
     
      <%}}%>
       
    </ul>
  </div>
  <div class="channel fix">
    <h2>公司简介</h2>
  </div>
  <div class="wrap gc about"> <img src="images/about_temp.jpg" width="939" height="267" alt="公司简介" />
    <p class="mt15">洛阳中集凌宇汽车有限公司位于有着“千年帝都，牡丹花城”美誉的九朝古都洛阳，是一家具有40余年汽车生产历史的企业，是中集车辆（集团)有限公司（简称：中集车辆集团）的骨干成员企业之一。 </p>
    <p> 公司主要有三大系列产品：罐式专用车、环卫设备和客车。罐式车主要包括全系列混凝土搅拌车、粉罐车、普通碳钢液罐车、中高档铝合金和不锈钢液罐车等。环卫设备包括压缩式垃圾站、压缩垃圾车、收集车、勾臂车、洒水车、吸污车、餐厨垃圾车等。目前已在全国十几个省市实现销售，环卫设备预计将成为公司未来发展的支柱产品。客车主要是公交车、校车、石油测井车等客车专用车产品。在专业化区域性市场具有一定的知名度。 </p>
  </div>
  <div class="pro_btm_bg mb20"></div>
  <div class="channel fix">
    <h2>产品订单</h2>    
	
	 <%
   	    String offset = CommonString.getFormatPara(request.getParameter("offset"));
       List<Map> orderList = null ;
       PageBean pageBean = new  PageBean() ;
       pageBean.setPageSize(10) ;
		Integer nowPage = 1;
		if("".equals(offset) || Integer.parseInt(offset)<=0){
			offset = "0" ;
		}
		if (!"".equals(offset) && !"0".equals(offset)) {
			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		}
       pageBean.setTableName("pro_product_form") ;
       pageBean.setFields("factoryid ,id, factoryname,product_name,contact_address,cataname,name,mobile_phone,province,city,add_date") ;
       pageBean.setCondition(" and factoryid=767 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(nowPage) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
       %>
    </div>
        <div class="wrap gc fix">
    
    <div class=" border03 l list08 fix">
	 
      <div class="title08">
        <h3><b>询价总数：<%=pageBean.getTotal() %></b> - 采购询价</h3>
        <span>共有<font><%=pageBean.getTotal() %></font>个符合条件</span> </div>
      <ul class="ti fix">
        <li class="i1">编号</li>
        <li class="i2">询价产品</li>
        <li class="i3">联系人</li>
        <li class="i4">电话</li>
        <li class="i5">询价品牌</li>
        <li class="i6">询价区域</li>
        <li class="i7">询价时间</li>
      </ul>
      <div class="li fix">
	  <%
	  if(null!=orderList && orderList.size()>0){
		  int k = orderList.size()>10?10:orderList.size() ;
      	 String showtel = "" ; 
      	 Map oneMaps = null ;
	  	 for(int i=0;i<k;i++){
	  		oneMaps = orderList.get(i) ;
    		showtel = "".equals(CommonString.getFormatPara(oneMaps.get("mobile_phone")))?CommonString.getFormatPara(oneMaps.get("contact_tel")):CommonString.getFormatPara(oneMaps.get("mobile_phone")) ;
    		
    		if(showtel.length()>7&&showtel.length()<=20){
    			showtel = showtel.substring(0,3)+"***"+showtel.substring(showtel.length()-3) ;
    		}else if(showtel.length()>3){
    			showtel = showtel.substring(0,4)+"***" ;
    		}else
    		{
    			showtel = showtel+"***" ;
    		}
    		%> 
        <ul class="libg01">
          <li class="i1"><%=i+1 %></li>
          <li class="i2"><a target="_blank" href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMaps.get("id")) %>.htm">凌宇<%=CommonString.getFormatPara(oneMaps.get("product_name")) %><%=CommonString.getFormatPara(oneMaps.get("cataname")) %></a></li>
          <li class="i3"><%=(CommonString.getFormatPara(oneMaps.get("name")).length()>0)?CommonString.getFormatPara(oneMaps.get("name")).substring(0,1)+"***":"张**" %></li>
          <li class="i4"><%=showtel %></li>
          <li class="i5"><a href="/inquiry/0_0_767_0_0.shtm" target="_blank">凌宇汽车</a></li>
          <li class="i6"><%="".equals(CommonString.getFormatPara(oneMaps.get("contact_address")))?"-":CommonString.getFormatPara(oneMaps.get("contact_address"))  %></li>
          <li class="i7"><%=(CommonString.getFormatPara(oneMaps.get("add_date")).length()>15)?CommonString.getFormatPara(oneMaps.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMaps.get("add_date")) %></li>
        </ul>
     <%}}%> 
     
      
      </div>
    </div>
    <div>
	 <div class="page paging" style="margin-left:450px;width:500px;clear:both;float:left;"><tags:page pageBean="<%=pageBean%>" /></div></div>
    </div>
        </div>
		
  </div>
  <div class="pro_btm_bg"></div>
</div>
<!--main end--> 

<!--foot-->
<div class="john_foot">
  <jsp:include page="/include/foot.jsp"/>
</div>
<!--foot end--> 

<script type="text/javascript">
$(".ly_lx").slide({ titCell:".hd li", mainCell:".bd ul",effect:"leftLoop",vis:1,scroll:1,autoPlay:true,interTime:4000,prevCell:'.prev',nextCell:'.next'});
function addShop(){ // 收藏店铺
      var url = 'http://product.21-sun.com/brandshop/lingyu/';
    try{
       window.external.addFavorite(url, '中集凌宇汽车');
   }catch (e){
       try{
           window.sidebar.addPanel('中集凌宇汽车',url,"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
</script>
</body>
</html>