<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="newspart blue mb10">
    <div class="title bigTitle">
      <h3>新车图库</h3>
      <ul class="t-con">
        <li>搜索图片：</li>
        <li>
          <select name="select" id="select" class="select">
            <option>选择品牌</option>
          </select>
        </li>
        <li>
          <select name="select2" id="select2" class="select">
            <option>选择车系(可不选)</option>
          </select>
        </li>
        <li>
          <input type="submit" name="button2" id="button2" value="搜索" class="btn" />
        </li>
      </ul>
      <span class="more"><a href="#">更多&gt;&gt;</a></span>
    </div>
    <div class="content NewsImgscroll" id="NewsImgscroll">
      <div class="hd"> 
        <a class="newsImgnext"></a>
        <ul>
        </ul>
        <a class="newsImgprev"></a> 
      </div>
      <div class="bd">
        <ul class="newsPicList">
          <li>
            <div class="newsBigimg"><a href="#"><img src="../images/news_img05.jpg" alt="三一土压平衡盾构掘进机" width="369" height="262" /><h3>三一土压平衡盾构掘进机</h3></a></div>
            <div class="newsSmallimg">
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS</a></dl>
            </div>
          </li>
          <li>
            <div class="newsBigimg"><a href="#"><img src="../images/news_img05.jpg" alt="三一土压平衡盾构掘进机" width="369" height="262" /><h3>三一土压平衡盾构掘进机</h3></a></div>
            <div class="newsSmallimg">
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS111</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS111</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS111</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS111</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS111</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS111</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS111</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS111</a></dl>
            </div>
          </li>
          <li>
            <div class="newsBigimg"><a href="#"><img src="../images/news_img05.jpg" alt="三一土压平衡盾构掘进机" width="369" height="262" /><h3>三一土压平衡盾构掘进机</h3></a></div>
            <div class="newsSmallimg">
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS222</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS222</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS222</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS222</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS222</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS111</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS111</a></dl>
              <dl><a href="#"><img src="../images/news_img04.jpg" alt="外形前卫 雷克萨斯IS" width="120" height="90" /><br />
              外形前卫 雷克萨斯IS111</a></dl>
            </div>
          </li>
        </ul>
      </div>
    </div>
    <script type="text/javascript">jQuery("#NewsImgscroll").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"left",vis:1,scroll:1,autoPlay:true,autoPage:true});</script> 
  </div>
