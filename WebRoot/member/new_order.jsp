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

<div class="wrapper m_contain mb20 fix"> 
  <!--left-->
  <div class="m_leftPart">
    <div class="mem-con">
      <div class="mem-face"> <img width="175" height="175" src="images/temp/tx.jpg" onerror="showImgDelay(this,'http://product.21-sun.com/uploadfiles/no_big.gif',2);" /> </div>
      <ul style="display:none" class="mem-info">
        <li><strong>780</strong><br>
          粉丝</li>
        <li style="border:none;"><strong>895</strong><br>
          关注</li>
      </ul>
      <ul align="center" class="mem-info">
        <span >1111</span>
      </ul>
    </div>
    <h3 class="mt">我发布的</h3>
    <ul class="m_leftMenu">
      <li><a class="selected" href="koubei.jsp"><span class="n"><img src="images/menu_ico01.png">我的口碑</span></a></li>
      <li><a href="#"><span class="n"><img src="images/menu_ico02.png">我上传的图片</span></a></li>
      <li><a href="/member/weixiu.jsp"><span class="n"><img src="images/menu_ico03.png">我的维修知识</span></a></li>
      <li><a href="#"><span class="n"><img src="images/menu_ico04.png">我的上传视频</span></a></li>
    </ul>
    <div class="m_line"></div>
  </div>
  <!--left end--> 
  <!--right-->
  <div class="m_rightPart">
    <div class="mem_top01 clearfix"> <span class="l"> <strong class="name">我的订单</strong> <a style="margin-right:10px;" href="/member/order/" class="selected">全部订单(4)</a> <a style="margin-right:10px;" href="/member/order/index.jsp?s=1">等待付款(1)</a> 
      <!--<a style="margin-right:10px;" href="/member/order/index.jsp?s=4">待收货(0)</a>--> 
      <a style="margin-right:10px;" href="/member/order/index.jsp?s=0">已取消(1)</a> </span> <span class="r" style="font-family:微软雅黑"> <a href="/member/">首页</a> &gt;&gt; 我的订单 </span> </div>
    <div class="filter_main">
      <ul class="filter">
        <li> <a href="javascript://void(0);" style="text-decoration: none; cursor: default;" class="selected">全部订单</a> </li>
      </ul>
    </div>
    <div class="orderList">
      <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tbody>
          <tr>
            <th width="157"> 订单产品 </th>
            <th width="93"> 联系人 </th>
            <th width="93"> 电话 </th>
            <th width="87"> 定金 </th>
            <th width="50"> 评价 </th>
            <th width="85"> 支付定金 </th>
            <th width="63"> 订单状态 </th>
            <th> 操作 </th>
          </tr>
          <tr>
            <td><a href="#" target="_blank" class="n1"><div style="text-align:left; width:157px; margin:0 auto;"> <img src="images/temp/sp.jpg" class="img"><span class="ftx-03">卡特彼勒306E
                挖掘机</span> </div></a></td>
            <td style="padding:0;"><span class="ftx-03">宋小姐</span></td>
            <td><span class="ftx-03"> 13***18</span></td>
            <td><s>￥116.0</s><span class="ftx-03" style="color:red">￥116.0</span></td>
            <td><span class="ftx-03">已评价</span></td>
            <td><span class="ftx-03">￥116.</span></td>
            <td><span class="ftx-03">已完成</span></td>
            <td width="100" class="order-doi"><input type="hidden" value="0">
              <a href="javascript://void(0)" class="btn-img btn-buyagain" onclick="buyagain('460367536825590');"> </a> <a href="#" target="_blank" style="display:block;">查看详情</a></td>
          </tr>
          <tr>
            <td><a href="#" target="_blank" class="n1"><div style="text-align:left; width:157px; margin:0 auto;"> <img src="images/temp/sp.jpg" class="img"><span class="ftx-03">卡特彼勒306E
                挖掘机</span> </div></a></td>
            <td style="padding:0;"><span class="ftx-03">宋小姐</span></td>
            <td><span class="ftx-03"> 13***18</span></td>
            <td><s>￥116.0</s><span class="ftx-03" style="color:red">￥116.0</span></td>
            <td><a href="#">评价</a></td>
            <td><span class="ftx-03">￥116.</span></td>
            <td><span class="ftx-03">已完成</span></td>
            <td width="100" class="order-doi"><input type="hidden" value="0">
              <a href="javascript://void(0)" class="btn-img btn-payfor">立即支付</a> </td>
          </tr>
          <tr>
            <td><a href="#" target="_blank" class="n1"><div style="text-align:left; width:157px; margin:0 auto;"> <img src="images/temp/sp.jpg" class="img"><span class="ftx-03">卡特彼勒306E
                挖掘机</span> </div></a></td>
            <td style="padding:0;"><span class="ftx-03">宋小姐</span></td>
            <td><span class="ftx-03"> 13***18</span></td>
            <td><s>￥116.0</s><span class="ftx-03" style="color:red">￥116.0</span></td>
            <td><a href="#">评价</a></td>
            <td><span class="ftx-03">￥116.</span></td>
            <td><span class="ftx-03">已完成</span></td>
            <td width="100" class="order-doi"><input type="hidden" value="0">
              <a href="javascript://void(0)" class="btn-img btn-buyagain" onclick="buyagain('460367536825590');"> </a> <a href="#" target="_blank" style="display:block;">查看详情</a></td>
          </tr>
          <tr>
            <td><a href="#" target="_blank" class="n1"><div style="text-align:left; width:157px; margin:0 auto;"> <img src="images/temp/sp.jpg" class="img"><span class="ftx-03">卡特彼勒306E
                挖掘机</span> </div></a></td>
            <td style="padding:0;"><span class="ftx-03">宋小姐</span></td>
            <td><span class="ftx-03"> 13***18</span></td>
            <td><s>￥116.0</s><span class="ftx-03" style="color:red">￥116.0</span></td>
            <td><span class="ftx-03">已评价</span></td>
            <td><span class="ftx-03">￥116.</span></td>
            <td><span class="ftx-03">已完成</span></td>
            <td width="100" class="order-doi"><input type="hidden" value="0">
              <a href="javascript://void(0)" class="btn-img btn-buyagain" onclick="buyagain('460367536825590');"> </a> <a href="#" target="_blank" style="display:block;">查看详情</a></td>
          </tr>
        </tbody>
      </table>
      <div class="pt10 mb10 clearfix">
        <div class="pagin r"> <span class="prev-disabled">上一页<b></b></span> <a class="current">1</a> <span class="next-disabled">下一页<b></b></span> </div>
      </div>
      <div id="order03" style="margin-top:10px;">
        <div class="mt">
          <ul class="tabs">
            <li> <a href="#order1" class="selected">猜你喜欢</a> </li>
          </ul>
        </div>
        <div class="mc clearfix">
          <ul class="list" id="order1">
            <li> <a href="#" title="1:35山工SEM8220震动压路机仿真模型" target="_blank"> <img src="images/temp/temp.jpg" onerror="noImg(this,'/images/nopic.gif',2);" width="160" height="160" class="img" alt="1:35山工SEM8220震动压路机仿真模型">
              <h3>1:35山工SEM8220震动压路机仿真模型</h3>
              <span class="price">¥ <strong>198.0</strong></span> 
              <!-- <span class="num">月销售 <strong>5816</strong> 件</span> --> 
              </a> </li>
             <li> <a href="#" title="1:35山工SEM8220震动压路机仿真模型" target="_blank"> <img src="images/temp/temp.jpg" onerror="noImg(this,'/images/nopic.gif',2);" width="160" height="160" class="img" alt="1:35山工SEM8220震动压路机仿真模型">
              <h3>1:35山工SEM8220震动压路机仿真模型</h3>
              <span class="price">¥ <strong>198.0</strong></span> 
              <!-- <span class="num">月销售 <strong>5816</strong> 件</span> --> 
              </a> </li>
             <li> <a href="#" title="1:35山工SEM8220震动压路机仿真模型" target="_blank"> <img src="images/temp/temp.jpg" onerror="noImg(this,'/images/nopic.gif',2);" width="160" height="160" class="img" alt="1:35山工SEM8220震动压路机仿真模型">
              <h3>1:35山工SEM8220震动压路机仿真模型</h3>
              <span class="price">¥ <strong>198.0</strong></span> 
              <!-- <span class="num">月销售 <strong>5816</strong> 件</span> --> 
              </a> </li>
             <li> <a href="#" title="1:35山工SEM8220震动压路机仿真模型" target="_blank"> <img src="images/temp/temp.jpg" onerror="noImg(this,'/images/nopic.gif',2);" width="160" height="160" class="img" alt="1:35山工SEM8220震动压路机仿真模型">
              <h3>1:35山工SEM8220震动压路机仿真模型</h3>
              <span class="price">¥ <strong>198.0</strong></span> 
              <!-- <span class="num">月销售 <strong>5816</strong> 件</span> --> 
              </a> </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <!--right end--> 
</div>
<!--foot-->
<jsp:include page="/include/foot.jsp" flush="false"/>
<!--foot end-->
</body>
<script type="text/javascript" src="scripts/common.js"></script>
</html>
