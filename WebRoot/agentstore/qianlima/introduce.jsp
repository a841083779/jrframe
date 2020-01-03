<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
String factoryid = CommonString.getFormatPara(request.getParameter("factoryid")) ;
String catalognum = CommonString.getFormatPara(request.getParameter("num")) ;   // 栏目 
String factoryid_sub = CommonString.getFormatPara(request.getParameter("factoryid_sub")) ; // 品牌 id
String sel_sql = " select catalogname from pro_factory_category where factoryid=? and num =?" ;
DBHelper dbHelper = DBHelper.getInstance() ;
//选出所有的类别
String sel_sql2 = " select num,catalogname from dbo.pro_factory_category where factoryid=1236 order by id" ;
List<Map> catalogList = dbHelper.getMapList(sel_sql2) ;
String catalogname = "" ;
if(null!=catalogList && catalogList.size()>0){
	for(Map oneMap:catalogList){
		if(catalognum.equals(CommonString.getFormatPara(oneMap.get("num")))){
			catalogname = CommonString.getFormatPara(oneMap.get("catalogname")) ;
			break ;
		}
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>千里马官方旗舰店_中国工程机械商贸网</title>
<meta name="keywords" content="千里马,千里马产品报价,千里马产品,千里马产品图片,千里马介绍,千里马代理商" />
<meta name="description" content="中国工程机械商贸网为您提供千里马介绍,千里马产品介绍,千里马产品报价,千里马产品图片,千里马产品展示等千里马产品信息，帮助您全面了解千里马相关的斗山产品、临工产品、山猫滑移产品、千里马产品。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<link href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true">
<jsp:param value="<%=factoryid %>" name="factoryid"/>
</jsp:include>
<!--main-->
<div class="shopPart03">
  <div class="contain980 pt20 clearfix">
    <div class="shopContain">
      <div class="shopLeftPart">
        <h2>产品列表</h2>
        <ul class="shopListMenu" id="leftNav">
          <li><a href="javascript:;" value="192">斗山</a>
            <ul>
              <li><a href="list.jsp?factoryid=192&catanum=101001">挖掘机</a></li>
              <li><a href="list.jsp?factoryid=192&catanum=101002">装载机</a></li>
              <li><a href="list.jsp?factoryid=192&catanum=101008">铰接式自卸卡车</a></li>
              <li><a href="list.jsp?factoryid=192&catanum=113001">破碎锤</a></li>
            </ul>
          </li>
          <li><a href="javascript:;" value="137">临工</a>
            <ul>
             <li><a href="list.jsp?factoryid=137&catanum=101001">液压控掘机</a></li>
              <li><a href="list.jsp?factoryid=137&catanum=101002">装载机</a></li>
              <li><a href="list.jsp?factoryid=137&catanum=106001">压路机</a></li>
            </ul>
          </li>
          <li><a href="javascript:;" value="454">山猫</a>
            <ul>
              <li><a href="list.jsp?factoryid=454&catanum=101001">挖掘机</a></li>
              <li><a href="list.jsp?factoryid=454&catanum=101002">装载机</a></li>
            </ul>
          </li>
          <li><a href="javascript:;" value="1661">千里马</a>
            <ul>
              <li><a href="list.jsp?factoryid=1661&catanum=33333">再制造产品</a></li>
              <li><a href="list.jsp?factoryid=1661&catanum=113001">破碎锤</a></li>
            </ul>
          </li>
        </ul>
        </ul>
        <div class="shopIntro">
          <div class="title">
            <h2>店铺介绍</h2>
          </div>
          <div class="content">
            <p class="intro"> <strong class="name">千里马工程机械集团<br />股份有限公司</strong> <a href="introduce.jsp" target="_blank" style="color:#939191!important;">千里马工程机械集团股份有限公司(简称千里马)，成立于2002年，是中国领先的工程机械绿色连锁服务商，是中国工程机械工业协会代理商委员会副会长单位，旗下包括武汉千</a> <span class="more"><a href="introduce.jsp" target="_blank">更多&gt;&gt;</a></span> 
            </p>
            <ul>
              <li>商　　家：<strong class="name">千里马官方旗舰店</strong></li>
              <li>所&nbsp;&nbsp;在&nbsp;&nbsp;地：武汉</li>
              <li>客服电话：400-889-6977</li>
              <li>销售热线：027-83382896<br />
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13871282300</li>
            </ul>
            <div style="text-align:center;"><a href="./"><img src="images/enter_btn.gif" alt="进入店铺" width="127" height="30" /></a></div>
          </div>
        </div>
      </div>
      <div class="shopRightPart">
      
        <div class="listBanner"><a title="做世界级的工程机械绿色连锁服务商" href="/agentstore/qianlima/"><img src="images/listbanner.gif" width="700" height="183" /></a></div>
        
        <div class="intro_text">
           <div style="width:650px;">　　
             千里马工程机械集团股份有限公司(简称千里马)，成立于2002年，是中国领先的工程机械绿色连锁服务商，是中国工程机械工业协会代理商委员会副会长单位，旗下包括武汉千里马工程机械有限公司、新疆千里马工程机械有限公司、重庆千里马工程机械有限公司、广西千里马工程机械有限公司、千里马沃特（四川）工程机械有限公司。力争做世界级的工程机械绿色连锁服务商的千里马，致力于商业模式创新，不断延伸产业链条，充分培育后市场服务能力，业已形成以工程机械产品的传统销售和售后服务为圆心，以融资管理服务、保险兼业代理等现代类金融服务为外延，以专业化的行业培训为提升，以工程机械再制造为循环的高附加值的同心圆商业模式，为客户提供一揽子综合服务，领跑中国工程机械行业流通、服务和再制造领域。</p>
             <p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;总部坐落于武汉市东西湖区循环经济工业园的千里马，与中国经济复兴的跨越式发展并进，在全国已拥有直营连锁店80余家，连锁网络覆盖湖北、新疆、广西、四川和重庆。目前公司经营的主要产品为挖掘机、装载机、破碎器及多种工程机械零配件，主要经营韩国斗山（原韩国大宇）、山东临工、山猫、韩宇、滑移等国内外工程机械知名品牌。2007-2012年，千里马规模快速扩张，主营业务收入年均复合增长率近60%。</p>
             <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2009年12月，千里马获国家工业和信息化部批准，与六家国内外工程机械制造商共同跻身首批国家“机电产品再制造试点单位”。2010年1月，公司获国家发改委批准，再制造项目成为全国第5批“循环经济和环境保护试点项目”。公司是唯一一家同时获得两部委重点扶持的再制造循环经济试点单位，是循环经济（工程机械再制造）的典范。<br />
             秉承“服务，为客户创造价值”的经营理念和“诚实做人、诚信做事、愈挫愈奋、追求卓越”的企业精神，契机国务院“十二五”规划纲要和中国城镇化建设下，中国工程机械的蓬勃发展，千里马将继往开来，自主创新，开拓进取，整合政策效应、区域效应、人才效应和品牌效应，为社会、为客户、为员工、为股东创造更多的回报。</p>
           </div>
        </div>
        
        <div class="w755 border03 l mb10 list08">
          <div class="title12">
		         <%
		         String offset = CommonString.getFormatPara(request.getParameter("offset"));
		         List<Map> orderList = null ;
		         PageBean pageBean = new  PageBean() ;
		  		Integer nowPage = 1;
		  		if("".equals(offset) || Integer.parseInt(offset)<=0){
		  			offset = "0" ;
		  		}
		  		if (!"".equals(offset) && !"0".equals(offset)) {
		  			nowPage = Integer.parseInt(offset) / pageBean.getPageSize() + 1;
		  		}
		         pageBean.setTableName("pro_agent_products_form") ;
		         pageBean.setFields("factory_id factoryid ,id,factory_name factoryname,product_name,contact_address,cata_name cataname,user_name name,contact_tel mobile_phone,province,city,add_date") ;
		         pageBean.setPageSize(10) ;
		         pageBean.setCondition(" and agent_id=1661 and factory_name <>'' and factory_name is not null and user_name is not null and user_name<>'' and product_name is not null and product_name<>''") ;
		         pageBean.setNowPage(nowPage) ;
		         pageBean.setOrderBy(" add_date desc") ;
		         pageBean.setParams("#to_order") ;
		         orderList = pageBean.getDatas() ;
       %>
            <h3>千里马产品订单</h3>
                <a name="to_order" href="#">&nbsp;</a>
            <span><a target="_blank" href="/inquiry/">&nbsp;</a></span> </div>
          <div class="title08">
            <h3><b>询价总数：<%=pageBean.getTotal()%></b> - 采购询价</h3>
            <span>共有<font><%=pageBean.getTotal() %></font>个符合条件</span> </div>
          <ul class="ti">
            <li class="i1">编号</li>
            <li class="i2">询价产品</li>
            <li class="i3">联系人</li>
            <li class="i4">电话</li>
            <li class="i5">询价品牌</li>
            <li class="i6">询价区域</li>
            <li class="i7">询价时间</li>
          </ul>
          <div class="li">
	    <%
	  if(null!=orderList && orderList.size()>0){
		  int k = orderList.size()>10?10:orderList.size() ;
      	 String showtel = "" ; 
      	 Map oneMap = null ;
	  	 for(int i=0;i<k;i++){
	  		oneMap = orderList.get(i) ;
    		showtel = "".equals(CommonString.getFormatPara(oneMap.get("mobile_phone")))?CommonString.getFormatPara(oneMap.get("contact_tel")):CommonString.getFormatPara(oneMap.get("mobile_phone")) ;
    		
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
            <li class="i2"><a href="/inquiry/details_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
            <li class="i3"><%=(CommonString.getFormatPara(oneMap.get("name")).length()>0)?CommonString.getFormatPara(oneMap.get("name")).substring(0,1)+"***":"张**" %></li>
            <li class="i4"><%=showtel %></li>
            <li class="i5"><a target="_blank" href="/inquiry/?factory=<%=CommonString.getFormatPara(oneMap.get("factoryid")) %>"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %></a></li>
            <li class="i6"><%="".equals(CommonString.getFormatPara(oneMap.get("contact_address")))?"-":CommonString.getFormatPara(oneMap.get("contact_address"))  %></li>
            <li class="i7"><%=(CommonString.getFormatPara(oneMap.get("add_date")).length()>15)?CommonString.getFormatPara(oneMap.get("add_date")).substring(0,16):CommonString.getFormatPara(oneMap.get("add_date")) %></li>
          </ul>
    		<%
	  	 }
	  }
	  %>
      </div>
        </div>                
      </div>
    <div class="page" style="margin-right:10px;width:500px;"><tags:page pageBean="<%=pageBean%>" /></div></div>
    </div>
  </div>
</div>
<!--main end--> 
<!--foot-->
<div class="flagshopbg">
<jsp:include page="/include/foot.jsp" flush="true"></jsp:include>
</div>
<!--end of foot-->
<script type="text/javascript">
jQuery(function(){
	jQuery(".shopPros01 li").hover(function(){ 
		jQuery(this).toggleClass("hover");
	},function(){
		jQuery(this).removeClass("hover");
	});
})
</script>
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="jquery.hoveraccordion.js"></script>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
  try{
       window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
   }catch (e){
       try{
           window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/sevalo/', '千里马官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('千里马官方旗舰店','http://product.21-sun.com/brandshop/hengzhi/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
DK.load('scripts/core.js', function(){ 
	DK.index.init();
});
jQuery(function(){
	    jQuery("#leftNav").hoverAccordion({
    	keepHeight : false,
        onClickOnly : true 
    }) ;
})
</script> 
</body>
</html>