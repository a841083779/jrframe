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
    
      <div class="comBox04 mb10">
        <div class="hd fix">
          <h3>推荐产品</h3>
          <span class="more"><a href="#">更多&gt;&gt;</a></span>
        </div>
        <div class="bd shopProList">
          <ul class="comList02">
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
          </ul>
        </div>
      </div>
      
      <div class="comBox04 mb10 companyIntro">
        <div class="hd fix">
          <h3>公司介绍</h3>
        </div>
        <div class="bd fix">
          <a href="#">
            <img src="images/temp/nopic.png" width="200" height="150" class="comImg">
            <div class="text">　　内蒙古润隆化工有限责任公司始建于2002年，公司有自己的主体矿山，盛产白色膨润土，主要生产冶金球团土、铸造土、钻井泥浆土、土木工程防渗用土、生物饲料用土、高级涂料用土、化妆品用白色膨润土、猫沙、蒙脱石干燥剂。 公司本着“用户至上、诚实守信、...
              <span class="more">更多详情&gt;&gt;</span>
            </div>
          </a>
        </div>
      </div>
      
      <div class="comBox04 mb10">
        <div class="hd fix">
          <h3>供应产品</h3>
          <span class="more"><a href="#">更多&gt;&gt;</a></span>
        </div>
        <div class="bd shopProList">
          <ul class="comList02">
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
            <li><a href="#"><img src="images/temp/temp_img03.jpg" alt="供应优质P27275-3RWTL71瓦尔特厂" ><strong>供应优质P27275-3RWTL71瓦尔特厂</strong></a></li>
          </ul>
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