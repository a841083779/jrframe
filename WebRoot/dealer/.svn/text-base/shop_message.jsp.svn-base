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
var jrChannel='0#0'
//店铺导航选中状态
var jrChannel_shop='0#0'
</script>
</head>
<body class="shop02">
<!--top-->
<jsp:include page="include/top.jsp" flush="true" />
<!--top end-->
<div class="shop_con">
  <div class="shop_top01">
    <div class="contain980 fix">
      <h1 class="logo">信昌机器工程有限公司 永安分公司
        <strong class="site"><a href="http://product.21-sun.com/agent/xcjqgcyxgsyafgs/" target="_blank">http://product.21-sun.com/agent/xcjqgcyxgsyafgs/</a></strong>
      </h1>
      <div class="mark"><img src="images/mark.png" width="109" height="34" onclick="addShop();return false;"></div>
      <script type="text/javascript">
      function addShop(){
          try{
             window.external.addFavorite('http://product.21-sun.com/agent/xcjqgcyxgsyafgs/', '信昌机器工程有限公司');
         }catch (e){
             try{
                 window.sidebar.addPanel('信昌机器工程有限公司','http://product.21-sun.com/agent/xcjqgcyxgsyafgs/',"");
             }catch (e){
                 alert("加入收藏失败，请使用Ctrl+D进行添加");
             }
         }
      }
      </script>
    </div>
  </div>
  <div class="shop_top02">
    <div class="contain980 fix">
      <ul class="shopNav fix">
        <li><a href="#">商铺首页</a></li>
        <li><a href="#">公司介绍</a></li>
        <li><a href="#">产品展示</a></li>
        <li><a href="#">留言反馈</a></li>
        <li><a href="#">联系我们</a></li>
      </ul>
    </div>
  </div>
  
  <div class="shopBanner">
    <img src="images/temp/shop_banner.jpg" width="978" height="188">
  </div>
  <div class="contain980 fix">
    <!--left-->
    <div class="shopLeft">
      <div class="comBox03 mb10">
        <div class="hd fix">
          <h3>产品分类</h3>
        </div>
        <div class="bd fix">
          <div class="comList">
            <li><a href="#">履带式挖掘机</a></li>
            <li><a href="#">轮式装载机</a></li>
            <li><a href="#">雪犁装载机</a></li>
            <li><a href="#">自行式平地机</a></li>
            <li><a href="#">双钢轮压路机</a></li>
            <li><a href="#">轮胎压路机</a></li>
            <li><a href="#">单钢轮压路机</a></li>
          </div>
        </div>
      </div>
      <div class="comBox03 mb10 shop_contacts">
        <div class="hd fix">
          <h3>联系方式</h3>
        </div>
        <div class="bd fix">
          <div class="comList">
            <li>联系人：</li>
            <li>联系电话：</li>
            <li>邮箱：</li>
            <li>地址：</li>
          </div>
        </div>
      </div>
      
      <div class="comBox03 mb10">
        <div class="hd fix">
          <h3>其他该地域代理商</h3>
        </div>
        <div class="bd fix">
          <div class="comList">
            <li><a href="#">云南省昆明市西山区百集</a></li>
            <li><a href="#">云南省昆明市西山区百集</a></li>
            <li><a href="#">云南省昆明市西山区百集</a></li>
            <li><a href="#">云南省昆明市西山区百集</a></li>
            <li><a href="#">云南省昆明市西山区百集</a></li>
            <li><a href="#">云南省昆明市西山区百集</a></li>
          </div>
        </div>
      </div>
      
      <div class="comBox03 mb10">
        <div class="hd fix">
          <h3>更多品牌代理商</h3>
        </div>
        <div class="bd fix">
          <div class="comList">
            <li><a href="#">云南省昆明市西山区百集</a></li>
            <li><a href="#">云南省昆明市西山区百集</a></li>
            <li><a href="#">云南省昆明市西山区百集</a></li>
            <li><a href="#">云南省昆明市西山区百集</a></li>
            <li><a href="#">云南省昆明市西山区百集</a></li>
            <li><a href="#">云南省昆明市西山区百集</a></li>
          </div>
        </div>
      </div>
      
    </div>
    <!--left end-->
    <!--right-->
    <div class="shopRight">
      <div class="shop_crumbs">留言反馈&gt;&gt;</div>
      <div class="shop_message">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <th width="17%"><font>*</font>您所在的地区：</th>
            <td width="83%"><select name="select" id="select">
              <option>请选择</option>
              <option>国内</option>
            </select>
              <select name="select2" id="select2">
                <option>请选择</option>
            </select>
              <select name="select3" id="select3">
                <option>请选择</option>
            </select></td>
          </tr>
          <tr>
            <th><font>*</font>您选择的产品：</th>
            <td><select name="select4" id="select4">
              <option>请选择产品品牌</option>
            </select>
              <select name="select5" id="select5">
                <option>请选择产品分类</option>
            </select></td>
          </tr>
          <tr>
            <th><font>*</font>您的称呼：</th>
            <td><input type="text" name="textfield" id="textfield" class="ip"></td>
          </tr>
          <tr>
            <th><font>*</font>联系方式：</th>
            <td><input type="text" name="textfield2" id="textfield2" class="ip"></td>
          </tr>
          <tr>
            <th><font>*</font>Email：</th>
            <td><input type="text" name="textfield3" id="textfield3" class="ip"></td>
          </tr>
          <tr>
            <th><font>*</font>企业名称：</th>
            <td><input type="text" name="textfield4" id="textfield4" class="ip">
              如果是个人，请填写“个人”</td>
          </tr>
          <tr>
            <th><font>*</font>公司地址：</th>
            <td><input type="text" name="textfield5" id="textfield5" class="ip"></td>
          </tr>
          <tr>
            <th><font>*</font>发表提问内容：</th>
            <td><textarea name="textarea" id="textarea" class="textarea"></textarea>
            <br>
            还可输入225字</td>
          </tr>
          <tr>
            <th><font>*</font>验证码：</th>
            <td><input type="text" name="textfield6" id="textfield6" class="yzm"> <img src="images/temp/yzm.png" width="77" height="25" style="vertical-align:middle;">看不清？换一张</td>
          </tr>
          <tr>
            <th onMouseOver="">&nbsp;</th>
            <td><input type="submit" name="button2" id="button2" value="提交" class="btn"></td>
          </tr>
        </table>
        <div class="mess_list">
          <h3>在线咨询</h3>
          <div class="mess_box">
            <ul>
              <li>
                <div class="s1">来自<span class="area">贵州</span>的铁臂商城的询问 (2013-08-20 13:37:04)</div>
                <div class="s2"><strong>林先生：</strong>360二手有吗？</div>
              </li>
              <li>
                <div class="s1">来自<span class="area">贵州</span>的铁臂商城的询问 (2013-08-20 13:37:04)</div>
                <div class="s2"><strong>林先生：</strong>360二手有吗？</div>
              </li>
              <li>
                <div class="s1">来自<span class="area">贵州</span>的铁臂商城的询问 (2013-08-20 13:37:04)</div>
                <div class="s2"><strong>林先生：</strong>360二手有吗？</div>
              </li>
              <li>
                <div class="s1">来自<span class="area">贵州</span>的铁臂商城的询问 (2013-08-20 13:37:04)</div>
                <div class="s2"><strong>林先生：</strong>360二手有吗？</div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <!--right end-->
  </div>
</div>
<!--foot-->
<div class="foot_box">
<jsp:include page="/include/foot.jsp" flush="true" />
</div>
<!--foot end-->
</body>
<script type="text/javascript" src="scripts/common.js"></script>
<script type="text/javascript">
function SetFontSize(size){
   document.getElementById('mainDetail').style.fontSize=size+'px';
}
</script>
</html>