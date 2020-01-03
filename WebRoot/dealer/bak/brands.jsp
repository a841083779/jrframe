<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>代理商</title>
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<link href="/style/style.css" rel="stylesheet" />
<link href="style/style.css" rel="stylesheet" />
<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript">
//导航选中状态
var jrChannel='2#0'
</script>
</head>
<body>
<!--top-->
<jsp:include page="include/top.jsp" flush="true" />
<!--top end-->
<div class="contain980 mb10">
  <h3 class="breadCrumbs"><a href="/">铁臂商城</a> &gt;&gt; <a href="#">代理商专区</a></h3>
</div>

<!--main--> 
<!--品牌索引-->
<div class="suoyin">
  <div id="suoyinfloat">
    <div class="abroadorinner">
      <ul class="bcTabs">
        <li class="selected"><a href="./index_b.shtm">全部</a></li>
        <li><a href="inner.shtm">国内</a></li>
        <li><a href="outer.shtm">国外</a></li>
      </ul>
    </div>
    <ul class="bcContain">
      <strong>品牌索引</strong>
      <li class="b"> <a href="#A">A</a> <a href="#B">B</a> <a href="#C">C</a> <a href="#D">D</a> <a style="cursor:default;"><span>E</span></a> <a href="#F">F</a> <a href="#G">G</a> <a href="#H">H</a> <a style="cursor:default;"><span>I</span></a> <a href="#J">J</a> <a href="#K">K</a> <a href="#L">L</a> <a href="#M">M</a> <a href="#N">N</a> <a style="cursor:default;"><span>O</span></a> <a href="#P">P</a> <a href="#Q">Q</a> <a href="#R">R</a> <a href="#S">S</a> <a href="#T">T</a> <a style="cursor:default;"><span>U</span></a> <a style="cursor:default;"><span>V</span></a> <a href="#W">W</a> <a href="#X">X</a> <a href="#Y">Y</a> <a href="#Z">Z</a> </li>
    </ul>
  </div>
  <script type="text/javascript" src="/scripts/smart_float.js"></script> 
</div>
<!--品牌索引结束--> 
<jsp:include page="/include/brand/all.htm" flush="true" />
<!--字母列表结束--> 
<!--main end--> 

<!--foot-->
<div class="foot_box">
<jsp:include page="/include/foot.jsp" flush="true" />
</div>
<!--foot end-->
</body>
<script type="text/javascript">
(function(jQuery){
 jQuery.extend(jQuery.fn,{
 scrollTo:function(time,to){
 time=time||0;
 to=to||1;
            jQuery('a[href*=#]', this).click(function(){
                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
      var jQuerytarget = jQuery(this.hash);
     jQuerytarget = jQuerytarget.length && jQuerytarget || jQuery('[name=' + this.hash.slice(1) + ']');
                    if (jQuerytarget.length) {
                        if (to == 1) {
                            jQuery('html,body').animate({
                                scrollTop: jQuerytarget.offset().top
                            }, 0);
                        }
                        else if(to==2){
                            jQuery('html,body').animate({
                                scrollLeft: jQuerytarget.offset().left
                            }, 0);
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
jQuery(function(){
  jQuery(".bcContain li").scrollTo(700)
});
</script>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript" src="/scripts/sort.js"></script>
<script type="text/javascript">
  $(function(){
    var url = window.location.toString();
    var id = url.split("#")[1];
    if(id){
        var t = $("#"+id).offset().top;
        setTimeout(function(){
        	$(window).scrollTop(t);
        },100) ;
    }
});
</script>
</html>