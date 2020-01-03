<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/classes/oscache.tld" prefix="cache"%>
<%  
    Map memberInfo = (Map)session.getAttribute("memberInfo");
    if(memberInfo==null){
		  Common.do302(response,"http://product.21-sun.com/tuan/");
			return;
	}
	String order_num = CommonString.getFormatPara(request.getParameter("order_num"));
	DBHelper dbHelper = DBHelper.getInstance() ;
	Map orderMap = dbHelper.getMap("select order_state from pro_online_order where order_no='"+order_num+"'");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<title>个人中心</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />

<link href="style/member_cart.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/scripts/jquery.min.js"></script>
<script type="text/javascript" src="/scripts/jquery.raty.min.js"></script>
<script type="text/javascript" src="/scripts/scripts.js"></script>
<script type="text/javascript" src="/scripts/idTabs.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="/scripts/jBox-v2.3/i18n/jquery.jBox-zh-CN.js"></script>
<link type="text/css" rel="stylesheet" href="/scripts/jBox-v2.3/Skins2/Blue/jbox.css" />
<style type="text/css">
body { background-color: #fff; }
</style>
</head>
<body>
<!--top-->
<div class="m_newTop">
  <div class="wrapper">
    <h2 class="l"><a href="/member/index.jsp"><img width="219" height="40" src="images/mem_logo.png" alt="铁臂商城购物中心"></a></h2>
    <ul class="m_nav">
      <li><a href="#" class="n">网站<i></i></a>
        <div class="box"> <a href="http://www.21-sun.com/" target="_blank">网站首页</a> <a href="http://product.21-sun.com/" target="_blank">铁臂商城</a> <a href="http://www.wajueji.com/" target="_blank">铁臂兄弟连</a> <a href="http://koubei.21-sun.com/" target="_blank">铁臂口碑</a> <a href="http://photo.21-sun.com/" target="_blank">铁臂图库</a> <a href="http://weixiu.21-sun.com/" target="_blank">铁臂维修</a> <a href="http://video.21-sun.com/" target="_blank">铁臂视频</a> <a href="http://news.21-sun.com/" target="_blank">铁臂资讯</a> </div>
      </li>
      <li><a href="#" class="n">应用<i></i></a>
        <div class="box"> <a href="/member/koubei.jsp">我的口碑</a> <a href="#">我上传的图片</a> <a href="/member/weixiu.jsp">我的维修知识</a> <a href="#">我上传的视频</a> </div>
      </li>
    </ul>
    <div class="top_search" style="display:none">
      <input type="text" name="top_input" id="top_input" value="请输入搜索内容" onfocus="if(this.value == '请输入搜索内容'){this.value=''}" onblur="if(this.value == ''){this.value='请输入搜索内容'}" class="top_input">
      <li class="select_box"> <span>帖子</span>
        <ul style="display: none;" class="son_ul">
          <li value="0">帖子</li>
          <li value="1">用户</li>
        </ul>
      </li>
      <input type="hidden" id="top_select" value="0">
      <a class="top_btn" href="javascript:void(0);" onclick="goSearch()"></a> 
      <script type="text/javascript">
          $(document).ready(function(){
             $('.son_ul').hide(); //初始ul隐藏
             $('.select_box span').hover(function(){ //鼠标移动函数
                $(this).parent().find('ul.son_ul').slideDown(200);  //找到ul.son_ul显示
                $(this).parent().find('li').hover(function(){$(this).addClass('hover')},function(){$(this).removeClass('hover')}); //li的hover效果
                $(this).parent().hover(function(){},
                                       function(){
                                           $(this).parent().find("ul.son_ul").slideUp(200); 
                                           }
                                       );
                },function(){}
                );
            $('ul.son_ul li').click(function(){
              $("#top_select").val($(this).attr('value'));
              $(this).parents('li').find('span').html($(this).html());
              $(this).parents('li').find('ul').slideUp(200);
            });
          });
          function goSearch(){
              var tar = $("#top_select").val();
              var str = $("#top_input").val();
              if($.trim(str) == ''){
                  $.jBox.tip('请输入搜索内容');
              }
              if(tar == 0){
                   window.location.href='/service/searchList.jsp?keyWord='+str;
              }else{
                  window.location.href='/newMember.jsp?keyWord='+str;
              }
          }
      </script> 
    </div>
    <div class="mtl m_set"><a class="m_Ico" href="info_edit.jsp"><em></em></a></div>
    <div class="b_nav_member" style="background: none;width: auto;"> <a href="/member/"><img width="30" height="30" src="<%=CommonString.getFormatPara(memberInfo.get("image"))%>" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" class="b_faceimg"/></a> <span class="b_name" style="width: auto;"> <a href="/member/" style="color: #FFF;"><%=CommonString.getFormatPara(memberInfo.get("username"))%></a> <a href="javascript:void(0)" onclick="loginOut();"  style="color:#fff;">[退出]</a> </span> </div>
  </div>
</div>
<!--top end-->

<div class="mainContain" style="padding-top:60px;">
  <div id="cart"> 	
  	<div class="cart_left">
        <div class="paytype">
          <div id="paytype_gateway">
            <div style="_height: 1%" class="gateway_list" id="gateway_list">
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="success">
                <tbody><tr>
                  <td width="7%"><img src="/images/pur-icon.gif" width="48" height="48"></td>
                  <td width="93%">
				  <% if(!CommonString.getFormatPara(orderMap.get("order_state")).equals("1")){%>
                  <h3 style="font: 100 18px/20px 微软雅黑;margin-bottom: 10px;color: #009900;margin-top: 10px;">订单提交成功，请您尽快付款！</h3>
                  <span style="line-height: 22px;" class="order_num">订单号：<%=order_num%></span><em style="line-height: 22px;margin: 0px 8px;">|</em><span style="line-height: 22px;" class="pay_num">应付金额：<strong ><span style="font-size: 14px;color: #cc0000;">2000.0元</span></strong></span>
                  <%}else{%>
				  <h3 style="font: 100 18px/20px 微软雅黑;margin-bottom: 10px;color: #009900;margin-top: 10px;">恭喜您付款成功！</h3>
                  <span style="line-height: 22px;" class="order_num">订单号：<%=order_num%></span><em style="line-height: 22px;margin: 0px 8px;">|</em><span style="line-height: 22px;" class="pay_num">支付金额：<strong ><span style="font-size: 14px;color: #cc0000;">2000.0元</span></strong></span>
				  <%}%>
				  </td>
                </tr>
              </tbody></table>
              
              <div class="base_line" style="clear: both;border-bottom: #ccc 1px solid;margin-top: 20px;"></div>
            
              <div class="title">支付方式</div>   
              <ul id="last_select"><!-- 上次付款时的支付方式 -->
              	<li class="selected">
                  <label class="czBank"></label>                 
                </li>
              </ul>
    
              <div class="clear"></div>
            </div>
            <div class="clear"></div>
          </div>
        </div>
		<% if(!CommonString.getFormatPara(orderMap.get("order_state")).equals("1")){%>
        <div class="confirm_pay" style="margin:0px; background:none; padding-bottom:15px;">
        	<input type="hidden" id="pay_mode" name="pay_mode" value="168003">
        	<input type="hidden" id="pay_gateway_no" name="pay_gateway_no" value="czBank">
            <input type="button" value="立即支付" onclick="pay();" class="btn_pink_big" id="btn_confirm_pay" style="float:left;">
        </div>
		<%}%>
        <div class="clear"></div>
    </div>
  </div>
<div class="clear"></div>  
</div>

<!--foot-->
<div style="background-color:#f0f0f0">
  <jsp:include page="/include/foot.jsp" flush="false"/>
</div>
<!--foot end-->
</body>
<script type="text/javascript" src="scripts/common.js"></script>
<script>
        function submitOrder(){
            //判断收货地址是否选择
            var selected_address=false;
            $("#address-list").children("li").each(function(){
                if($(this).hasClass("selected")){
                    selected_address=true;
                    return false;
                }
            });
            if(!selected_address){
                alert("请选择收货地址!");
                return;
            }
            
            var address_id = $("#address-list").children("li.selected").attr("data-id");
            var coupon_no = $.trim($("#coupon_no").val());
            var used_point = $.trim($("#hid_used_point").val());
            var card_no = $.trim($("#hid_used_card_no").val());
            var card_money = $.trim($("#hid_used_card_money").val());
            
            $.ajax({
                type:"post",
                url:"/action/ajax_r.jsp",
                data:{flag:"createOrder",address_id:address_id,coupon_no:coupon_no,used_point:used_point,card_no:card_no,card_money:card_money},
                success:function(result){
                    var order_num=$.trim(result);
                    if(order_num == ""){
                    	alert("此订单已提交或购物车中没有商品，请重新挑选商品！");
                    }else if(order_num!="fail"){
                        window.location.href="/member/purchase/success.jsp?order_num=" + order_num;
                    }else{
                        alert("系统错误，订单提交失败，请稍后重试！");
                    }
                }
            });
        }
		
		function pay(){
			window.open("/tools/pay/czbankapi.jsp?order_num=<%=order_num %>&pay_mode=168003&pay_gateway_no=czBank ");
		}
</script>
</html>
