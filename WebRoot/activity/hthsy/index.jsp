<%@ page language="java" import="java.util.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%
DBHelper dbHelper = DBHelper.getInstance();
Integer msgCounts = (Integer)dbHelper.getOne(" select count(*) from activities_reg where CONVERT(varchar(100), reg_date, 1) = '"+CommonDate.getToday("MM/dd/yy")+"' and type_id = 2 ");
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>三一挖掘机-318三一挖掘机抢购活动，疯抢史上最低折扣 - 铁臂商城</title>
<meta name="keywords" content="三一挖掘机,3.18抢购活动,挖掘机限时抢购,挖掘机优惠" />
<meta name="description" content="中国工程机械商贸网与宏通机械联合发起318三一挖掘机优惠促销活动，联系电话4006-521-526。" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="design by www.21-sun.com" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="/plugin/dialog/jBox/Skins/Red/jbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/scripts/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<link href="style/style_sany.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="style/jquery.ad-gallery.css" />
<script type="text/javascript" src="scripts/jquery.ad-gallery.js"></script>
<script type="text/javascript">
$(function() {
  var galleries = $('.ad-gallery').adGallery();
});
</script>

</head>
<body class="active_sany">
<!--top-->
<jsp:include page="/include/top.jsp" flush="true" />
<!--main-->
<div class="active_bannerbg">
  <div class="contain980"><img src="images/sany_bannerimg.jpg" alt="宏通好声音，三一挖掘机全城乐享惠，2013年3月18日 潍坊三一重机宏通机械大型订货会，仅限烟台、威海、青岛、潍坊、济南、东营、滨州地区" width="980" height="454" />
  <a href="http://www.hongtongjixie.com/" target="_blank" title="点击进入官网" class="bannerBtn"></a>
  </div>
</div>
<div class="contain980 activePart01">
  <img src="images/sany_img01.jpg" width="980" height="257" />
  <div class="active_share">
    <!-- Baidu Button BEGIN -->
    <div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
    <span class="bds_more">推荐好友购买</span>
    </div>
    <script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=537258" ></script>
    <script type="text/javascript" id="bdshell_js"></script>
    <script type="text/javascript">
    document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
    </script>
    <!-- Baidu Button END -->
  </div>
</div>
<div class="contain980 activePart02">
<img src="images/sany_img02.jpg" width="980" height="387" />
  <div class="a_Form">
    <div class="a_formTopbg"></div>
    <div class="a_formbg">
      <div class="pt5 pb5"><img src="images/form_text.gif" alt="本次活动仅限：烟台、威海、青岛、潍坊、济南、东营、滨州 地区" width="372" height="50" /></div>
      <form id="theform" name="theform" method="post" action="action.jsp?flag=reg">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <th>所在城市：</th>
            <td>
            <select name="city" id="city" class="a_select">
              <option value="">==请选择==</option>
              <option value="烟台">烟台</option>
              <option value="威海">威海</option>
              <option value="青岛">青岛</option>
              <option value="潍坊">潍坊</option>
              <option value="济南">济南</option>
              <option value="东营">东营</option>
              <option value="滨州">滨州</option>
            </select>
            </td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <th>预约车型：</th>
            <td>
            <select name="model" id="model" class="a_select">
              <option value="">==请选择车型==</option>
              <option value="">大挖系列</option>
              <option value="SY425C">&nbsp;&nbsp;&nbsp;&nbsp;SY425C</option>
              <option value="SY465C">&nbsp;&nbsp;&nbsp;&nbsp;SY465C</option>
              <option value="SY700C">&nbsp;&nbsp;&nbsp;&nbsp;SY700C</option>
              <option value="SY850C">&nbsp;&nbsp;&nbsp;&nbsp;SY850C</option>
              <option value="SY2000C">&nbsp;&nbsp;&nbsp;&nbsp;SY2000C</option>
              <option value="">中挖系列</option>
              <option value="SY205C-8">&nbsp;&nbsp;&nbsp;&nbsp;SY205C-8</option>
              <option value="SY215C-8">&nbsp;&nbsp;&nbsp;&nbsp;SY215C-8</option>
              <option value="SY235C-8">&nbsp;&nbsp;&nbsp;&nbsp;SY235C-8</option>
              <option value="SY285C-8">&nbsp;&nbsp;&nbsp;&nbsp;SY285C-8</option>
              <option value="SY335C-8">&nbsp;&nbsp;&nbsp;&nbsp;SY335C-8</option>
              <option value="">小挖系列</option>
              <option value="SY55">&nbsp;&nbsp;&nbsp;&nbsp;SY55</option>
              <option value="SY65">&nbsp;&nbsp;&nbsp;&nbsp;SY65</option>
              <option value="SY75">&nbsp;&nbsp;&nbsp;&nbsp;SY75</option>
              <option value="SY135C-8">&nbsp;&nbsp;&nbsp;&nbsp;SY135C-8</option>
            </select>
            </td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <th>真实姓名：</th>
            <td><input type="text" name="name" id="name" class="a_input" /></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <th>联系电话：</th>
            <td><input type="text" name="phone" id="phone" class="a_input" /></td>
            <td>&nbsp;</td>
          </tr>
          <%
          if(msgCounts<200){
          		%>
          <tr>
            <th>验<span style="margin: 0 7px 0 7px;">证</span>码：</th>
            <td><input type="text" name="code" id="code" maxlength="4" class="a_input" /></td>
            <td>&nbsp;</td>
          </tr>
          		<%
          	}
          %>

          <tr>
            <td>&nbsp;</td>
            <td colspan="2"><input type="button" name="button2" id="button2" onclick="doSub();" value="&nbsp;" class="a_btn" /></td>
          </tr>
        </table>
      </form>
    </div>
    <div class="a_formBottombg"></div>
  </div>
</div>
<%
	List<Map> list = dbHelper.getMapList(" select title,introduce,add_date,image_name from article_picture where group_id = 62 and is_pub=1 and image_name<>''  order by group_id desc, add_date ");
%>
<div class="contain980 activeimg"><img src="images/sany_img03.jpg" width="980" height="420" /></div>
<div class="contain980 activeimg"><img src="images/sany_img04.jpg" width="980" height="452" /></div>
<div class="contain980 activeimg"><img src="images/sany_img05.jpg" width="980" height="556" /></div>

          <%
          	if(null!=list&&list.size()>0){
          		%>
<div class="contain980 gallery">
  <h3><img src="images/sany_gallery_title.jpg" width="980" height="122"  /></h3>
  <div class="galleryContain">
    
    <div id="gallery" class="ad-gallery">
      <div class="ad-image-wrapper"></div>
      <div class="ad-controls"> </div>
      <div class="ad-nav">
        <div class="ad-thumbs">
          <ul class="ad-thumb-list">
			<%
				for(Map m : list){
					%>
            <li> <a href="http://news.21-sun.com/UserFiles/Image/<%=CommonString.getFormatPara(m.get("image_name")) %>"> <img src="http://news.21-sun.com/UserFiles/Image/<%=CommonString.getFormatPara(m.get("image_name")) %>" class="image73"	title="<%=CommonString.getFormatPara(m.get("title")) %>" /> </a> </li>
					<%
				}
			%>
		 </ul>
        </div>
      </div>
    </div>
    
  </div>
  
</div>
          		<%
          	}
          %>


<!--main end-->
<!--foot-->
<div class="footbg">
<jsp:include page="/include/foot.jsp" flush="true" />
</div>
<div style="display: none;"><script src="http://s85.cnzz.com/stat.php?id=5099776&web_id=5099776" language="JavaScript"></script></div>
<!--end of foot--> 
</body>
</html>
<script type="text/javascript" src="/plugin/dialog/jBox/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript" src="index.js"></script>
<script type="text/javascript">
function addCookie(){　 // 加入收藏夹
    if (document.all){
        window.external.addFavorite('http://product.21-sun.com', '21-sun产品中心');
    }else if (window.sidebar){
        window.sidebar.addPanel('21-sun产品中心', 'http://www.product.21-sun.com', "");
    }
}
jQuery("body").bind("contextmenu", function() {
  return false;
});
</script> 
<script type="text/javascript" src="../scripts/scrolltopcontrol.js"></script>