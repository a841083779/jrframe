<%@page import="com.jerehnet.util.dbutil.PageBean"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.jerehnet.util.dbutil.DBHelper"%>
<%@page import="com.jerehnet.util.common.CommonString"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tags"%>
<%
	DBHelper dbHelper = DBHelper.getInstance() ;
	String sel_sql = "  select top 4 * from pro_products where factoryid=1220 and catalognum_spe=? and is_show=1 " ;
	List<Map> productsList = null ;
	String whereStr = " AND 1=1" ;
	
	List<Map> recommondProductsList = new ArrayList() ;
	String rec_sql = " select top 6 * from pro_products where factoryid=13096 and zoomlion_hot=11 and is_show=1 order by order_no desc " ; // 是否热卖推荐
	recommondProductsList = dbHelper.getMapList(rec_sql) ;
	whereStr += " AND factoryid=13096" ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<title>湖南恒至凿岩官方旗舰店 - 铁臂商城</title>
<meta name="keywords" content="湖南恒至凿岩,湖南恒至凿岩产品报价,湖南恒至凿岩产品,湖南恒至凿岩产品图片,湖南恒至凿岩介绍,湖南恒至凿岩代理商" />
<meta name="description" content="铁臂商城为您提供湖南恒至凿岩介绍,湖南恒至凿岩产品介绍,湖南恒至凿岩产品报价,湖南恒至凿岩产品图片,湖南恒至凿岩产品展示等湖南恒至凿岩产品信息，帮助您全面了解湖南恒至凿岩。" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/flag_shop02.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="http://cs.ecqun.com/?id=329600" charset="utf-8"></script>
<link type="text/css" rel="stylesheet"	href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<!--[if (IE 6)]>
<link href="/style/pngfix.css" media="screen" rel="stylesheet" type="text/css" />
<![endif]-->
<script type="text/javascript">
var t = n = 0, count;
jQuery(document).ready(function(){	
	count=jQuery("#slider .bgs li").length;
	jQuery("#slider .bgs li:not(:first-child)").hide();
	jQuery("#slider .points li").click(function() {
		var i = jQuery(this).attr("value") - 1;
		n = i;
		if (i >= count) return;
		jQuery("#slider .bgs li").filter(":visible").fadeOut(800).parent().children().eq(i).fadeIn(800);
		jQuery(this).toggleClass("selected");
		jQuery(this).siblings().removeAttr("class");
	});
	t = setInterval("showAuto()", 4000);
	jQuery("#slider .points li").hover(function(){clearInterval(t)}, function(){t = setInterval("showAuto()",4000);});
})
function showAuto(){
	n = n >=(count - 1) ? 0 : ++n;
	jQuery("#slider .points li").eq(n).trigger('click');
}
</script>
</head>
<body class="flag_shop">
<!--top-->
<jsp:include page="/brandshop/include/top.jsp" flush="true"></jsp:include>
<jsp:include page="top.jsp" flush="true"></jsp:include>
<!--main-->
<div id="slider" class="new_rec">
  <ul class="bgs">
    <li style="background:url(images/new_bigbanner1.jpg) center top no-repeat;"><a href="/proDetail/HZCLY115C.shtm" target="_blank"></a></li>
    <li style="background:url(images/new_bigbanner2.jpg) center top no-repeat; display:none;"><a href="/proDetail/HZCL90-58.shtm" target="_blank"></a></li>
    <li style="background:url(images/new_bigbanner3.jpg) center top no-repeat; display:none;"><a href="/proDetail/HZCLQ120.shtm" target="_blank"></a></li>
  </ul>
  <ul class="points">
    <li value="1" class="selected"></li>
    <li value="2"></li>
    <li value="3"></li>
  </ul>
</div>
</div>
<div class="contain980 shopPart04">
  <div class="banner"><img src="images/partbanner01.jpg" width="980" height="220" /></div>
  <div class="intro">
    <h2><img src="images/part_logo01.gif" width="135" height="135" /></h2>
    <div class="intro-con">
      <p class="text">湖南恒至凿岩科技有限公司座落于国家级常德经济技术开发区核心地段德山大道359号，占地面积50亩，建筑面积20000平方米，注册资金4348万元。拥有一支由院士、教授、博士组成的研发团队和营销团队，自主研发、生产、销售全系列凿岩钻车。公司禀承“共同创造、共享成功”的核心价值观和“学习、创新、勤奋、诚信”的文化理念，力争在三年内成为行业龙头企业，在创业版上市，为振兴我国凿岩工程机械行业作出应有的贡献。  </p>
      <div class="share">
      <!-- Baidu Button BEGIN -->
      <div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
      <span class="bds_more">分享到：</span>
      <a class="bds_qzone"></a>
      <a class="bds_tsina"></a>
      <a class="bds_tqq"></a>
      <a class="bds_renren"></a>
      <a class="bds_t163"></a>
      <a class="shareCount"></a>
      </div>
      <script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=537258" ></script>
      <script type="text/javascript" id="bdshell_js"></script>
      <script type="text/javascript">
      document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
      </script>
      <!-- Baidu Button END -->
      </div>
      <!-- <a href="#" class="more">更多&gt;&gt;</a>  -->
    </div>
    <div class="Favo"><a href="javascript:;" onclick="addShop();return false;"><img src="images/part_bm.gif" alt="收藏本店" width="121" height="135" /></a></div>
  </div>
</div>
<div class="contain980 shopPart05">
  <div class="partTitle">
    <h2>
      <em>推荐产品 /</em>
 	  PRODUCTS<br />RECOMMENDED
    </h2>
    <span class="more"><img src="images/icon.gif" /></span>
  </div>
  <div class="partContain">
    <ul class="list ProRec">
      <li>
        <div class="img">
        <a href="/proDetail/HZCLY115C.shtm" target="_blank"><img src="images/rec_ico.png" class="recIco" />
        <img src="images/hz_img.jpg" width="290" height="285" />
        </a></div>
        <div class="intro">
          <h2><a href="/proDetail/HZCLY115C.shtm" target="_blank">恒至凿岩HZCLY115C全液压露天凿岩钻车</a></h2>
          <img src="images/part_logo02.gif" alt="恒至凿岩" width="90" height="90" class="logo" />
          <p class="text">
          <a href="/proDetail/HZCLY115C_intro.shtm" target="_blank">节能环保:采用自主研发的三通道反冲集成器与专门除尘马达，除尘效果好。整机采用现代设计、系统优化并用系列专利技术精心设计制造，油耗低，经济效益显著。<br />
          工作范围大:采用侧摆机构，实现全方位钻孔，工作范围大，地形适应性强、效率高。<br />
          可靠性高:螺杆式空压机、液压及电控等主要元器件均选用国际一线品牌产品。所采用的自主研发的液压凿岩机，故障率低，维修方便，特别适合于流动性野外作业。<span class="tr">&gt;&gt;</span>
          </a></p>
          <div class="sale">最近已售出0件  收藏0件</div>
          <div class="btn"><a href="/proDetail/HZCLY115C.shtm" title="产品详情" target="_blank"><img src="images/part_btn.gif" alt="产品详情" width="107" height="24" /></a></div>
        </div>
      </li>
      <li class="last">
        <div class="img"> <a href="/proDetail/HZCLQ120.shtm" target="_blank"><img src="images/rec_ico.png" class="recIco" /> <img src="images/hz_img06.jpg" width="290" height="285" /> </a></div>
        <div class="intro">
          <h2><a href="/proDetail/HZCLQ120.shtm" target="_blank">恒至凿岩HZCLQ120A潜孔钻机</a></h2>
          <img src="images/part_logo02.gif" alt="恒至凿岩" width="90" height="90" class="logo" />
          <p class="text">
          <a href="/proDetail/HZCLQ120_intro.shtm" target="_blank">节能环保:采用自主研发的三通道反冲集成器与专门除尘马达，除尘效果好。整机采用现代设计、系统优化并用系列专利技术精心设计制造，油耗低，经济效益显著。<br />
          工作范围大:采用侧摆机构，实现全方位钻孔，工作范围大，地形适应性强、效率高。<br />
          可靠性高:螺杆式空压机、液压及电控等主要元器件均选用国际一线品牌产品。所采用的英格索兰进口冲击器凿</a></p>
          <div class="sale">最近已售出0件  收藏0件</div>
          <div class="btn"><a href="/proDetail/HZCLQ120.shtm" target="_blank" title="产品详情"><img src="images/part_btn.gif" alt="产品详情" width="107" height="24" /></a></div>
        </div>
      </li>
    </ul>
  </div>
<div class="clear"></div>  
</div>
<div class="contain980 shopPart06">
  <div class="banner mb20"><img src="images/partbanner02.jpg" width="980" height="315" /></div>
  
  <div class="partTitle">
    <h2 style="line-height:38px;">
      <em>产品展示 /</em>
 	  PRODUCTS
    </h2>
    <span class="more"><img src="images/icon.gif" /></span>
  </div>
  
  <div class="partList">
    <ul>
      <li>
      <a class="img" title="HZCLY115A全液压露天凿岩钻车" target="_blank" href="/proDetail/HZCLY115A.shtm">
      <img src="images/rec_ico01.png" alt="产品展示" class="recIco" />
      <img alt="HZCLY115A全液压露天凿岩钻车" src="images/hz_img01.jpg"></a>
        <div class="intro">
          <h3><a target="_blank" href="/proDetail/HZCLY115A.shtm">HZCLY115A全液压露天凿岩钻车</a></h3>
          <span><a target="_blank" href="/proDetail/HZCLY115A.shtm">参数</a><em>|</em><a target="_blank" href="/proDetail/HZCLY115A_message.shtm">评论</a></span> <a class="plBtn" href="javascript:;" onclick="showinquery('15608','')">立即询价</a> </div>
      </li>
      <li>
      <a class="img" title="HZCLY115B全液压露天凿岩钻车" target="_blank" href="/proDetail/HZCLY115B.shtm">
      <img src="images/rec_ico01.png" alt="产品展示" class="recIco" />
      <img alt="HZCLY115B全液压露天凿岩钻车" src="images/hz_img03.jpg" /></a>
        <div class="intro">
          <h3><a target="_blank" href="/proDetail/HZCLY115B.shtm">HZCLY115B全液压露天凿岩钻车</a></h3>
          <span><a target="_blank" href="/proDetail/HZCLY115B.shtm">参数</a><em>|</em><a target="_blank" href="/proDetail/HZCLY115B_message.shtm">评论</a></span> <a class="plBtn" href="javascript:;" onclick="showinquery('15607','')">立即询价</a> </div>
      </li>
      <li>
      <a class="img" title="HZCLY115C全液压露天凿岩钻车" target="_blank" href="/proDetail/HZCLY115C.shtm">
      <img src="images/rec_ico01.png" alt="产品展示" class="recIco" />
      <img alt="HZCLY115C全液压露天凿岩钻车" src="images/hz_img01.jpg"></a>
        <div class="intro">
          <h3><a target="_blank" href="/proDetail/HZCLY115C.shtm">HZCLY115C全液压露天凿岩钻车</a></h3>
          <span><a target="_blank" href="/proDetail/HZCLY115C.shtm">参数</a><em>|</em><a target="_blank" href="/proDetail/HZCLY115C_message.shtm">评论</a></span> <a class="plBtn" href="javascript:;" onclick="showinquery('15606','')">立即询价</a> </div>
      </li>
      <li>
      <a class="img" title="HZCLQ120A全液压露天潜孔钻车" target="_blank" href="/proDetail/HZCLQ120.shtm">
      <img src="images/rec_ico01.png" alt="产品展示" class="recIco" /><img alt="HZCLQ120A全液压露天潜孔钻车" src="images/hz_img06.jpg" /></a>
        <div class="intro">
          <h3><a target="_blank" href="/proDetail/HZCLQ120.shtm">HZCLQ120A全液压露天潜孔钻车</a></h3>
        <span><a target="_blank" href="/proDetail/HZCLQ120.shtm">参数</a><em>|</em><a target="_blank" href="/proDetail/HZCLQ120_message.shtm">评论</a></span> <a class="plBtn" href="javascript:;" onclick="showinquery('15609','')">立即询价</a> </div>
      </li>
      <li> <a class="img" title="HZCLQ140全液压露天潜孔钻车" target="_blank" href="/proDetail/HZCLQ140.shtm"> <img src="images/rec_ico01.png" alt="产品展示" class="recIco" /> <img alt="HZCLQ140全液压露天潜孔钻车" src="images/hz_img07.jpg" /></a>
        <div class="intro">
          <h3><a target="_blank" href="/proDetail/HZCLQ140.shtm">HZCLQ140全液压露天潜孔钻车</a></h3>
          <span><a target="_blank" href="/proDetail/HZCLQ140.shtm">参数</a><em>|</em><a target="_blank" href="/proDetail/HZCLQ140_message.shtm">评论</a></span> <a class="plBtn" href="javascript:;" onclick="showinquery('15610','')">立即询价</a></div>
      </li>
      <li>
        <a class="img" title="HZCL90A多功能凿岩钻车" target="_blank" href="/proDetail/HZCL90A.shtm">
        <img src="images/rec_ico01.png" alt="产品展示" class="recIco" /><img alt="HZCL90A多功能凿岩钻车" src="images/hz_img04.jpg" /></a>
        <div class="intro">  
          <h3><a target="_blank" href="/proDetail/HZCL90A.shtm">HZCL90A多功能凿岩钻车</a></h3>
          <span><a target="_blank" href="/proDetail/HZCL90A.shtm">参数</a><em>|</em><a target="_blank" href="/proDetail/HZCL90A_message.shtm">评论</a></span> <a class="plBtn" href="javascript:;" onclick="showinquery('15605','')">立即询价</a> </div>
      </li>
      <li>
      <a class="img" title="HZCL90B多功能凿岩钻车" target="_blank" href="/proDetail/HZCL90-58.shtm">
      <img src="images/rec_ico01.png" alt="产品展示" class="recIco" />
      <img alt="HZCL90B多功能凿岩钻车" src="images/hz_img09.jpg"></a>
        <div class="intro">
          <h3><a target="_blank" href="/proDetail/HZCL90-58.shtm">HZCL90B多功能凿岩钻车</a><a target="_blank" href="/proDetail/HZCL90-58.shtm"></a></h3>
          <span><a target="_blank" href="/proDetail/HZCLQ140.shtm">参数</a><em>|</em><a target="_blank" href="/proDetail/HZCL90-58_message.shtm">评论</a></span> <a class="plBtn" href="javascript:;" onclick="showinquery('15604','')">立即询价</a> </div>
      </li> 
      
    </ul>
  </div>
  
<div class="clear"></div>
</div>
<div class="contain980 shopPart08">
  <div class="partTitle">
    <h2 style="line-height:38px;">
      <em>恒至凿岩产品订单</em>
    </h2>
    <span class="more"><a href="/inquiry/?factory=13096" target="_blank">更多&gt;&gt;</a></span>
     <a name="to_order" id="to_order">&nbsp;</a>
  </div>
  <div class="content">
    <div class="w978 border03 l list08">
      <div class="title08">
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
       pageBean.setCondition(" and factoryid=13096 and factoryname <>'' and factoryname is not null and name is not null and name<>'' and product_name is not null and product_name<>''") ;
       pageBean.setNowPage(nowPage) ;
       pageBean.setOrderBy(" add_date desc") ;
       pageBean.setParams("#to_order") ;
       orderList = pageBean.getDatas() ;
       %>
        <h3><b>询价总数：<%=pageBean.getTotal() %></b> - 采购询价</h3>
        <span>共有<font><%=pageBean.getTotal()  %></font>个符合条件</span> </div>
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
            <li class="i2"><a href="/inquiry/detail_for_<%=CommonString.getFormatPara(oneMap.get("id")) %>.htm" target="_blank"><%=CommonString.getFormatPara(oneMap.get("factoryname")) %><%=CommonString.getFormatPara(oneMap.get("product_name")) %><%=CommonString.getFormatPara(oneMap.get("cataname")) %></a></li>
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
    <div class="page paging" style="margin-left:450px;width:500px;clear:both;float:left;"><tags:page pageBean="<%=pageBean%>" /></div></div>
  </div>
<div class="clear"></div>
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
<script type="text/javascript">
(function(jQuery){
 jQuery.extend(jQuery.fn,{
 scrollTo:function(time,to){
 time=time||800;
 to=to||1;
            jQuery('a[href*=#]', this).click(function(){
                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && 
location.hostname == this.hostname) {
      var jQuerytarget = jQuery(this.hash);
     jQuerytarget = jQuerytarget.length && jQuerytarget || jQuery('[name=' + this.hash.slice(1) + ']');
                    if (jQuerytarget.length) {
                        if (to == 1) {
                            jQuery('html,body').animate({
                                scrollTop: jQuerytarget.offset().top
                            }, time);
                        }
                        else if(to==2){
                            jQuery('html,body').animate({
                                scrollLeft: jQuerytarget.offset().left
                            }, time);
                        }else{
alert('argument error');
  }
                        return false;
                    }
                }
            });
  }
 });
})(jQuery);
</script> 
<script type="text/javascript" language="javascript">
jQuery(function(){
  jQuery(".shopNav").scrollTo(700)
});
</script> 
<script type="text/javascript">
function addShop(){　 // 收藏我们
    try{
       window.external.addFavorite('http://product.21-sun.com/brandshop/hengzhi/', '湖南恒至凿岩官方旗舰店');
   }catch (e){
       try{
           window.sidebar.addPanel('湖南恒至凿岩官方旗舰店','http://product.21-sun.com/brandshop/hengzhi/',"");
       }catch (e){
           alert("加入收藏失败，请使用Ctrl+D进行添加");
       }
   }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
</script> 
<script type="text/javascript" src="/scripts/scrolltopcontrol.js"></script> 
<script type="text/javascript" src="/scripts/sort.js"></script>
</body>
</html>