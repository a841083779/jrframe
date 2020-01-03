<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit">
<meta name="author" content="design by www.21-sun.com">
<title>个人中心</title>
<link href="/style/style.css" rel="stylesheet" type="text/css" />
<link href="style/style.css" rel="stylesheet" type="text/css" />
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
    <div class="b_nav_member" style="background: none;width: auto;"> <a href="/member/"><img width="30" height="30" src="images/temp/tx.jpg" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" class="b_faceimg"/></a> <span class="b_name" style="width: auto;"> <a href="/member/" style="color: #FFF;">1111</a> <a href="javascript:void(0)" onclick="loginOut();"  style="color:#fff;">[退出]</a> </span> </div>
  </div>
</div>
<!--top end-->

<div class="wrapper m_contain mb20 fix" style="border:0; background:none">
  <div class="m_part">
    <h2 class="s_t"><a href="#" class="r set_btn">个人设置</a>铁臂商城登录信息：</h2>
    <div class="s_info"> <span>账号：******（用户电话）</span><span>密码：******</span> <a href="#" class="up_pa">修改密码</a> </div>
    <h2 class="s_t2">询价单信息</h2>
    <div class="cart_products_v2">
      <table width="100%" id="cart_products">
        <tbody>
          <tr>
            <th width="230" align="left"> 订单展品 </th>
            <th width="100"> 联系人 </th>
            <th width="200">电话　</th>
            <th width="120"> 询价品牌 </th>
            <th width="150"> 询价区域 </th>
            <th width="150"> 询价时间 </th>
            <th width="150"> 定金 </th>
          </tr>
          <tr class="cart_item">
            <td align="center"><div style="width:150px;"> <a target="_blank" href="/product/lp20130828143242957.htm"> <img style="margin: 5px 5px;" alt="三一1：50原厂合金越野起重机模型" src="http://resource.21-sun.com/internet/gift/image/2013/08/28/small/20130828142330_256.jpg" width="70" height="70" class="l">
                <p style="text-align:left">卡特彼勒306E挖掘机</p>
                </a> </div></td>
            <td  style="width:100px;" align="center"> 宋小姐 </td>
            <td align="center"> 13***18 </td>
            <td align="center" > 卡特彼勒 </td>
            <td align="center" > 山东烟台 </td>
            <td align="center" > 2014-08-28 </td>
            <td align="center" class="dingj"> 65.00 </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="tj fix">
      <div class="l tj1"> <span class="ftx-08">留言：</span>
        <textarea class="text inputholder">您好，我对石川岛18VX/20VXT挖掘机感兴趣，想要咨询，请您给我回复</textarea>
      </div>
      <div class="r tj2"> <span  class="ftx-08">铁臂商城优惠：</span>
        <select>
          <option>支付500元订金抵1000元购机款</option>
        </select>
        <b>-0.00</b> <span  class="ftx-03 hj">合计：￥<b>120.00</b></span> </div>
    </div>
  </div>
  
  <div  class="fix">
  <div class="r s_order">
  <div class="s_user">
  <div class="s_user_list">
  <span class="n1"><strong>实付款：</strong><b>￥</b><b>1211110.00</b></span>
  <span><strong>联系人：</strong>宋书宁</span>
  <span><strong>电&nbsp;&nbsp;&nbsp;&nbsp;话：</strong>15153458954</span>
  <span></span>
  </div>
  </div>
  <a href="#" class="s_btn">提交订单</a>
  </div>  
  </div>
</div>
<!--foot-->
<div style="background-color:#f0f0f0">
  <jsp:include page="/include/foot.jsp" flush="false"/>
</div>
<!--foot end-->
</body>
<script type="text/javascript" src="scripts/common.js"></script>
</html>
