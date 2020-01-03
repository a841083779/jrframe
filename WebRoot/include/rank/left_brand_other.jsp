<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*,java.sql.*,com.jerehnet.util.freemarker.*" pageEncoding="UTF-8"%>
    <div id="leftId">
      <div class="w208 border01 l leftPart mb10">
        <h2>品牌</h2>
        <!--字母检索--> 
        <script src="/scripts/letter_tree.js" type="text/javascript"></script>
        <div class="treeSubNavv1">
          <ul id="tree_letter">
            <li><a onclick="treeHref(1);return false;" href="javascript:void(0);">A</a></li>
            <li><a onclick="treeHref(2);return false;" href="javascript:void(0);">B</a></li>
            <li><a onclick="treeHref(3);return false;" href="javascript:void(0);">C</a></li>
            <li><a onclick="treeHref(4);return false;" href="javascript:void(0);">D</a></li>
            <li class="none">E</li>
            <li><a onclick="treeHref(5);return false;" href="javascript:void(0);">F</a></li>
            <li><a onclick="treeHref(6);return false;" href="javascript:void(0);">G</a></li>
            <li><a onclick="treeHref(7);return false;" href="javascript:void(0);">H</a></li>
            <li class="none">I</li>
            <li><a onclick="treeHref(8);return false;" href="javascript:void(0);">J</a></li>
            <li><a onclick="treeHref(9);return false;" href="javascript:void(0);">K</a></li>
            <li><a onclick="treeHref(10);return false;" href="javascript:void(0);">L</a></li>
            <li><a onclick="treeHref(11);return false;" href="javascript:void(0);">M</a></li>
            <li><a onclick="treeHref(12);return false;" href="javascript:void(0);">N</a></li>
            <li class="none">O</li>
            <li><a onclick="treeHref(13);return false;" href="javascript:void(0);">P</a></li>
            <li><a onclick="treeHref(14);return false;" href="javascript:void(0);">Q</a></li>
            <li><a onclick="treeHref(15);return false;" href="javascript:void(0);">R</a></li>
            <li><a onclick="treeHref(16);return false;" href="javascript:void(0);">S</a></li>
            <li><a onclick="treeHref(17);return false;" href="javascript:void(0);">T</a></li>
            <li class="none">U</li>
            <li class="none">V</li>
            <li><a onclick="treeHref(18);return false;" href="javascript:void(0);">W</a></li>
            <li><a onclick="treeHref(19);return false;" href="javascript:void(0);">X</a></li>
            <li><a onclick="treeHref(20);return false;" href="javascript:void(0);">Y</a></li>
            <li><a onclick="treeHref(21);return false;" href="javascript:void(0);">Z</a></li>
          </ul>
        </div>
        <div id="treev1" class="treev1">
          <ul>
            <li id="letter1" class="root"><b>A</b>
              <ul>
                <li title="阿特拉斯" id="180"> <a class="mainBrand" href="<%=url%>?factory=180"><big>阿特拉斯</big></a>
                  <ul id="180_sub">
                  </ul>
                </li>
                <li title="奥泰" id="13272"> <a class="mainBrand" href="<%=url%>?factory=13272"><big>奥泰</big></a>
                  <ul id="13272_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter2" class="root"><b>B</b>
              <ul>
                <li title="八达重工" id="791"> <a class="mainBrand" href="<%=url%>?factory=791"><big>八达重工</big></a>
                  <ul id="791_sub">
                  </ul>
                </li>
                <li title="邦立重机" id="478"> <a class="mainBrand" href="<%=url%>?factory=478"><big>邦立重机</big></a>
                  <ul id="478_sub">
                  </ul>
                </li>
                <li title="宝鼎" id="13570"> <a class="mainBrand" href="<%=url%>?factory=13570"><big>宝鼎</big></a>
                  <ul id="13570_sub">
                  </ul>
                </li>
                <li title="北车重工" id="1093"> <a class="mainBrand" href="<%=url%>?factory=1093"><big>北车重工</big></a>
                  <ul id="1093_sub">
                  </ul>
                </li>
                <li title="甘肃宝龙" id="1703"> <a class="mainBrand" href="<%=url%>?factory=1703"><big>甘肃宝龙</big></a>
                  <ul id="1703_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter3" class="root"><b>C</b>
              <ul>
                <li title="长阳机械" id="615"> <a class="mainBrand" href="<%=url%>?factory=615"><big>长阳机械</big></a>
                  <ul id="615_sub">
                  </ul>
                </li>
                <li title="常林股份" id="148"> <a class="mainBrand" href="<%=url%>?factory=148"><big>常林股份</big></a>
                  <ul id="148_sub">
                  </ul>
                </li>
                <li title="朝工" id="485"> <a class="mainBrand" href="<%=url%>?factory=485"><big>朝工</big></a>
                  <ul id="485_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter4" class="root"><b>D</b>
              <ul>
                <li title="大信重工" id="171"> <a class="mainBrand" href="<%=url%>?factory=171"><big>大信重工</big></a>
                  <ul id="171_sub">
                  </ul>
                </li>
                <li title="道辰格" id="1243"> <a class="mainBrand" href="<%=url%>?factory=1243"><big>道辰格</big></a>
                  <ul id="1243_sub">
                  </ul>
                </li>
                <li title="道胜" id="1218"> <a class="mainBrand" href="<%=url%>?factory=1218"><big>道胜</big></a>
                  <ul id="1218_sub">
                  </ul>
                </li>
                <li title="鼎盛重工" id="140"> <a class="mainBrand" href="<%=url%>?factory=140"><big>鼎盛重工</big></a>
                  <ul id="140_sub">
                  </ul>
                </li>
                <li title="东德重工" id="1763"> <a class="mainBrand" href="<%=url%>?factory=1763"><big>东德重工</big></a>
                  <ul id="1763_sub">
                  </ul>
                </li>
                <li title="东方红" id="1187"> <a class="mainBrand" href="<%=url%>?factory=1187"><big>东方红</big></a>
                  <ul id="1187_sub">
                  </ul>
                </li>
                <li title="斗山" id="192"> <a class="mainBrand" href="<%=url%>?factory=192"><big>斗山</big></a>
                  <ul id="192_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter5" class="root"><b>F</b>
              <ul>
                <li title="福工" id="1183"> <a class="mainBrand" href="<%=url%>?factory=1183"><big>福工</big></a>
                  <ul id="1183_sub">
                  </ul>
                </li>
                <li title="福临" id="682"> <a class="mainBrand" href="<%=url%>?factory=682"><big>福临</big></a>
                  <ul id="682_sub">
                  </ul>
                </li>
                <li title="福田雷沃" id="141"> <a class="mainBrand" href="<%=url%>?factory=141"><big>福田雷沃</big></a>
                  <ul id="141_sub">
                  </ul>
                </li>
                <li title="抚挖" id="164"> <a class="mainBrand" href="<%=url%>?factory=164"><big>抚挖</big></a>
                  <ul id="164_sub">
                  </ul>
                </li>
                <li title="富亿机械" id="1888"> <a class="mainBrand" href="<%=url%>?factory=1888"><big>富亿机械</big></a>
                  <ul id="1888_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter6" class="root"><b>G</b>
              <ul>
                <li title="格瑞德" id="477"> <a class="mainBrand" href="<%=url%>?factory=477"><big>格瑞德</big></a>
                  <ul id="477_sub">
                  </ul>
                </li>
                <li title="国机重工" id="1369"> <a class="mainBrand" href="<%=url%>?factory=1369"><big>国机重工</big></a>
                  <ul id="1369_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter7" class="root"><b>H</b>
              <ul>
                <li title="海斗" id="1109"> <a class="mainBrand" href="<%=url%>?factory=1109"><big>海斗</big></a>
                  <ul id="1109_sub">
                  </ul>
                </li>
                <li title="合矿" id="1525"> <a class="mainBrand" href="<%=url%>?factory=1525"><big>合矿</big></a>
                  <ul id="1525_sub">
                  </ul>
                </li>
                <li title="恒特" id="170"> <a class="mainBrand" href="<%=url%>?factory=170"><big>恒特</big></a>
                  <ul id="170_sub">
                  </ul>
                </li>
                <li title="恒天九五" id="1147"> <a class="mainBrand" href="<%=url%>?factory=1147"><big>恒天九五</big></a>
                  <ul id="1147_sub">
                  </ul>
                </li>
                <li title="鸿达" id="217"> <a class="mainBrand" href="<%=url%>?factory=217"><big>鸿达</big></a>
                  <ul id="217_sub">
                  </ul>
                </li>
                <li title="华力重工" id="206"> <a class="mainBrand" href="<%=url%>?factory=206"><big>华力重工</big></a>
                  <ul id="206_sub">
                  </ul>
                </li>
                <li title="华伟重工" id="1526"> <a class="mainBrand" href="<%=url%>?factory=1526"><big>华伟重工</big></a>
                  <ul id="1526_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter8" class="root"><b>J</b>
              <ul>
                <li title="JCB" id="177"> <a class="mainBrand" href="<%=url%>?factory=177"><big>JCB</big></a>
                  <ul id="177_sub">
                  </ul>
                </li>
                <li title="加藤" id="189"> <a class="mainBrand" href="<%=url%>?factory=189"><big>加藤</big></a>
                  <ul id="189_sub">
                  </ul>
                </li>
                <li title="嘉和重工" id="13176"> <a class="mainBrand" href="<%=url%>?factory=13176"><big>嘉和重工</big></a>
                  <ul id="13176_sub">
                  </ul>
                </li>
                <li title="建德机械" id="1352"> <a class="mainBrand" href="<%=url%>?factory=1352"><big>建德机械</big></a>
                  <ul id="1352_sub">
                  </ul>
                </li>
                <li title="江淮重工" id="479"> <a class="mainBrand" href="<%=url%>?factory=479"><big>江淮重工</big></a>
                  <ul id="479_sub">
                  </ul>
                </li>
                <li title="江麓" id="487"> <a class="mainBrand" href="<%=url%>?factory=487"><big>江麓</big></a>
                  <ul id="487_sub">
                  </ul>
                </li>
                <li title="劲工" id="1586"> <a class="mainBrand" href="<%=url%>?factory=1586"><big>劲工</big></a>
                  <ul id="1586_sub">
                  </ul>
                </li>
                <li title="晋工" id="172"> <a class="mainBrand" href="<%=url%>?factory=172"><big>晋工</big></a>
                  <ul id="172_sub">
                  </ul>
                </li>
                <li title="京城长野" id="1759"> <a class="mainBrand" href="<%=url%>?factory=1759"><big>京城长野</big></a>
                  <ul id="1759_sub">
                  </ul>
                </li>
                <li title="久保田" id="187"> <a class="mainBrand" href="<%=url%>?factory=187"><big>久保田</big></a>
                  <ul id="187_sub">
                  </ul>
                </li>
                <li title="久工" id="1232"> <a class="mainBrand" href="<%=url%>?factory=1232"><big>久工</big></a>
                  <ul id="1232_sub">
                  </ul>
                </li>
                <li title="巨超重工" id="1193"> <a class="mainBrand" href="<%=url%>?factory=1193"><big>巨超重工</big></a>
                  <ul id="1193_sub">
                  </ul>
                </li>
                <li title="军联" id="681"> <a class="mainBrand" href="<%=url%>?factory=681"><big>军联</big></a>
                  <ul id="681_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter9" class="root"><b>K</b>
              <ul>
                <li title="卡特彼勒" id="174"> <a class="mainBrand" href="<%=url%>?factory=174"><big>卡特彼勒</big></a>
                  <ul id="174_sub">
                  </ul>
                </li>
                <li title="卡特重工" id="178"> <a class="mainBrand" href="<%=url%>?factory=178"><big>卡特重工</big></a>
                  <ul id="178_sub">
                  </ul>
                </li>
                <li title="开普动力" id="14247"> <a class="mainBrand" href="<%=url%>?factory=14247"><big>开普动力</big></a>
                  <ul id="14247_sub">
                  </ul>
                </li>
                <li title="开元智富" id="160"> <a class="mainBrand" href="<%=url%>?factory=160"><big>开元智富</big></a>
                  <ul id="160_sub">
                  </ul>
                </li>
                <li title="凯斯" id="455"> <a class="mainBrand" href="<%=url%>?factory=455"><big>凯斯</big></a>
                  <ul id="455_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter10" class="root"><b>L</b>
              <ul>
                <li title="力士" id="13683"> <a class="mainBrand" href="<%=url%>?factory=13683"><big>力士</big></a>
                  <ul id="13683_sub">
                  </ul>
                </li>
                <li title="力士德" id="157"> <a class="mainBrand" href="<%=url%>?factory=157"><big>力士德</big></a>
                  <ul id="157_sub">
                  </ul>
                </li>
                <li title="利勃海尔" id="179"> <a class="mainBrand" href="<%=url%>?factory=179"><big>利勃海尔</big></a>
                  <ul id="179_sub">
                  </ul>
                </li>
                <li title="临工" id="137"> <a class="mainBrand" href="<%=url%>?factory=137"><big>临工</big></a>
                  <ul id="137_sub">
                  </ul>
                </li>
                <li title="灵升机械" id="1509"> <a class="mainBrand" href="<%=url%>?factory=1509"><big>灵升机械</big></a>
                  <ul id="1509_sub">
                  </ul>
                </li>
                <li title="柳工" id="136"> <a class="mainBrand" href="<%=url%>?factory=136"><big>柳工</big></a>
                  <ul id="136_sub">
                  </ul>
                </li>
                <li title="龙工" id="135"> <a class="mainBrand" href="<%=url%>?factory=135"><big>龙工</big></a>
                  <ul id="135_sub">
                  </ul>
                </li>
                <li title="洛阳东方红" id="749"> <a class="mainBrand" href="<%=url%>?factory=749"><big>洛阳东方红</big></a>
                  <ul id="749_sub">
                  </ul>
                </li>
                <li title="洛阳路通" id="673"> <a class="mainBrand" href="<%=url%>?factory=673"><big>洛阳路通</big></a>
                  <ul id="673_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter11" class="root"><b>M</b>
              <ul>
                <li title="闽工" id="13697"> <a class="mainBrand" href="<%=url%>?factory=13697"><big>闽工</big></a>
                  <ul id="13697_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter12" class="root"><b>N</b>
              <ul>
                <li title="纳科重工" id="13700"> <a class="mainBrand" href="<%=url%>?factory=13700"><big>纳科重工</big></a>
                  <ul id="13700_sub">
                  </ul>
                </li>
                <li title="南车北京时代" id="1209"> <a class="mainBrand" href="<%=url%>?factory=1209"><big>南车北京时代</big></a>
                  <ul id="1209_sub">
                  </ul>
                </li>
                <li title="南特" id="169"> <a class="mainBrand" href="<%=url%>?factory=169"><big>南特</big></a>
                  <ul id="169_sub">
                  </ul>
                </li>
                <li title="农友" id="1748"> <a class="mainBrand" href="<%=url%>?factory=1748"><big>农友</big></a>
                  <ul id="1748_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter13" class="root"><b>P</b>
              <ul>
                <li title="普什重机" id="486"> <a class="mainBrand" href="<%=url%>?factory=486"><big>普什重机</big></a>
                  <ul id="486_sub">
                  </ul>
                </li>
                <li title="上海彭浦" id="156"> <a class="mainBrand" href="<%=url%>?factory=156"><big>上海彭浦</big></a>
                  <ul id="156_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter14" class="root"><b>Q</b>
              <ul>
                <li title="七天阳" id="686"> <a class="mainBrand" href="<%=url%>?factory=686"><big>七天阳</big></a>
                  <ul id="686_sub">
                  </ul>
                </li>
                <li title="奇瑞迪凯重科" id="1184"> <a class="mainBrand" href="<%=url%>?factory=1184"><big>奇瑞迪凯重科</big></a>
                  <ul id="1184_sub">
                  </ul>
                </li>
                <li title="勤牛" id="582"> <a class="mainBrand" href="<%=url%>?factory=582"><big>勤牛</big></a>
                  <ul id="582_sub">
                  </ul>
                </li>
                <li title="全工机械" id="1750"> <a class="mainBrand" href="<%=url%>?factory=1750"><big>全工机械</big></a>
                  <ul id="1750_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter15" class="root"><b>R</b>
              <ul>
                <li title="日立" id="184"> <a class="mainBrand" href="<%=url%>?factory=184"><big>日立</big></a>
                  <ul id="184_sub">
                  </ul>
                </li>
                <li title="熔盛机械" id="173"> <a class="mainBrand" href="<%=url%>?factory=173"><big>熔盛机械</big></a>
                  <ul id="173_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter16" class="root"><b>S</b>
              <ul>
                <li title="三一" id="133"> <a class="mainBrand" href="<%=url%>?factory=133"><big>三一</big></a>
                  <ul id="133_sub">
                  </ul>
                </li>
                <li title="森田重机" id="626"> <a class="mainBrand" href="<%=url%>?factory=626"><big>森田重机</big></a>
                  <ul id="626_sub">
                  </ul>
                </li>
                <li title="山河智能" id="142"> <a class="mainBrand" href="<%=url%>?factory=142"><big>山河智能</big></a>
                  <ul id="142_sub">
                  </ul>
                </li>
                <li title="山猫" id="454"> <a class="mainBrand" href="<%=url%>?factory=454"><big>山猫</big></a>
                  <ul id="454_sub">
                  </ul>
                </li>
                <li title="山挖重工" id="1207"> <a class="mainBrand" href="<%=url%>?factory=1207"><big>山挖重工</big></a>
                  <ul id="1207_sub">
                  </ul>
                </li>
                <li title="山重建机" id="152"> <a class="mainBrand" href="<%=url%>?factory=152"><big>山重建机</big></a>
                  <ul id="152_sub">
                  </ul>
                </li>
                <li title="上力重工" id="13718"> <a class="mainBrand" href="<%=url%>?factory=13718"><big>上力重工</big></a>
                  <ul id="13718_sub">
                  </ul>
                </li>
                <li title="神钢" id="183"> <a class="mainBrand" href="<%=url%>?factory=183"><big>神钢</big></a>
                  <ul id="183_sub">
                  </ul>
                </li>
                <li title="神娃机械" id="14235"> <a class="mainBrand" href="<%=url%>?factory=14235"><big>神娃机械</big></a>
                  <ul id="14235_sub">
                  </ul>
                </li>
                <li title="石川岛" id="190"> <a class="mainBrand" href="<%=url%>?factory=190"><big>石川岛</big></a>
                  <ul id="190_sub">
                  </ul>
                </li>
                <li title="现代建机" id="1227"> <a class="mainBrand" href="<%=url%>?factory=1227"><big>现代建机</big></a>
                  <ul id="1227_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter17" class="root"><b>T</b>
              <ul>
                <li title="泰安鲁能" id="1728"> <a class="mainBrand" href="<%=url%>?factory=1728"><big>泰安鲁能</big></a>
                  <ul id="1728_sub">
                  </ul>
                </li>
                <li title="特雷克斯" id="176"> <a class="mainBrand" href="<%=url%>?factory=176"><big>特雷克斯</big></a>
                  <ul id="176_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter18" class="root"><b>W</b>
              <ul>
                <li title="威盛" id="1738"> <a class="mainBrand" href="<%=url%>?factory=1738"><big>威盛</big></a>
                  <ul id="1738_sub">
                  </ul>
                </li>
                <li title="沃得重工" id="149"> <a class="mainBrand" href="<%=url%>?factory=149"><big>沃得重工</big></a>
                  <ul id="149_sub">
                  </ul>
                </li>
                <li title="沃尔华" id="662"> <a class="mainBrand" href="<%=url%>?factory=662"><big>沃尔华</big></a>
                  <ul id="662_sub">
                  </ul>
                </li>
                <li title="沃尔沃" id="175"> <a class="mainBrand" href="<%=url%>?factory=175"><big>沃尔沃</big></a>
                  <ul id="175_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter19" class="root"><b>X</b>
              <ul>
                <li title="犀牛重工" id="623"> <a class="mainBrand" href="<%=url%>?factory=623"><big>犀牛重工</big></a>
                  <ul id="623_sub">
                  </ul>
                </li>
                <li title="厦工" id="139"> <a class="mainBrand" href="<%=url%>?factory=139"><big>厦工</big></a>
                  <ul id="139_sub">
                  </ul>
                </li>
                <li title="厦装" id="13783"> <a class="mainBrand" href="<%=url%>?factory=13783"><big>厦装</big></a>
                  <ul id="13783_sub">
                  </ul>
                </li>
                <li title="现代" id="194"> <a class="mainBrand" href="<%=url%>?factory=194"><big>现代</big></a>
                  <ul id="194_sub">
                  </ul>
                </li>
                <li title="小橋" id="1741"> <a class="mainBrand" href="<%=url%>?factory=1741"><big>小橋</big></a>
                  <ul id="1741_sub">
                  </ul>
                </li>
                <li title="小松" id="182"> <a class="mainBrand" href="<%=url%>?factory=182"><big>小松</big></a>
                  <ul id="182_sub">
                  </ul>
                </li>
                <li title="新宇机械" id="13098"> <a class="mainBrand" href="<%=url%>?factory=13098"><big>新宇机械</big></a>
                  <ul id="13098_sub">
                  </ul>
                </li>
                <li title="新源机械" id="1683"> <a class="mainBrand" href="<%=url%>?factory=1683"><big>新源机械</big></a>
                  <ul id="1683_sub">
                  </ul>
                </li>
                <li title="新筑股份" id="690"> <a class="mainBrand" href="<%=url%>?factory=690"><big>新筑股份</big></a>
                  <ul id="690_sub">
                  </ul>
                </li>
                <li title="徐工" id="209"> <a class="mainBrand" href="<%=url%>?factory=209"><big>徐工</big></a>
                  <ul id="209_sub">
                  </ul>
                </li>
                <li title="徐挖" id="150"> <a class="mainBrand" href="<%=url%>?factory=150"><big>徐挖</big></a>
                  <ul id="150_sub">
                  </ul>
                </li>
                <li title="徐威重科" id="544"> <a class="mainBrand" href="<%=url%>?factory=544"><big>徐威重科</big></a>
                  <ul id="544_sub">
                  </ul>
                </li>
                <li title="宣工" id="154"> <a class="mainBrand" href="<%=url%>?factory=154"><big>宣工</big></a>
                  <ul id="154_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter20" class="root"><b>Y</b>
              <ul>
                <li title="烟工" id="155"> <a class="mainBrand" href="<%=url%>?factory=155"><big>烟工</big></a>
                  <ul id="155_sub">
                  </ul>
                </li>
                <li title="洋马" id="191"> <a class="mainBrand" href="<%=url%>?factory=191"><big>洋马</big></a>
                  <ul id="191_sub">
                  </ul>
                </li>
                <li title="宜工" id="770"> <a class="mainBrand" href="<%=url%>?factory=770"><big>宜工</big></a>
                  <ul id="770_sub">
                  </ul>
                </li>
                <li title="移山" id="161"> <a class="mainBrand" href="<%=url%>?factory=161"><big>移山</big></a>
                  <ul id="161_sub">
                  </ul>
                </li>
                <li title="忆辉" id="1749"> <a class="mainBrand" href="<%=url%>?factory=1749"><big>忆辉</big></a>
                  <ul id="1749_sub">
                  </ul>
                </li>
                <li title="永工" id="647"> <a class="mainBrand" href="<%=url%>?factory=647"><big>永工</big></a>
                  <ul id="647_sub">
                  </ul>
                </li>
                <li title="愚公机械" id="562"> <a class="mainBrand" href="<%=url%>?factory=562"><big>愚公机械</big></a>
                  <ul id="562_sub">
                  </ul>
                </li>
                <li title="玉柴" id="146"> <a class="mainBrand" href="<%=url%>?factory=146"><big>玉柴</big></a>
                  <ul id="146_sub">
                  </ul>
                </li>
                <li title="约翰迪尔" id="14238"> <a class="mainBrand" href="<%=url%>?factory=14238"><big>约翰迪尔</big></a>
                  <ul id="14238_sub">
                  </ul>
                </li>
              </ul>
            </li>
            <li id="letter21" class="root"><b>Z</b>
              <ul>
                <li title="合肥中达" id="1757"> <a class="mainBrand" href="<%=url%>?factory=1757"><big>合肥中达</big></a>
                  <ul id="1757_sub">
                  </ul>
                </li>
                <li title="山东众和" id="13209"> <a class="mainBrand" href="<%=url%>?factory=13209"><big>山东众和</big></a>
                  <ul id="13209_sub">
                  </ul>
                </li>
                <li title="詹阳动力" id="195"> <a class="mainBrand" href="<%=url%>?factory=195"><big>詹阳动力</big></a>
                  <ul id="195_sub">
                  </ul>
                </li>
                <li title="中国重汽" id="1214"> <a class="mainBrand" href="<%=url%>?factory=1214"><big>中国重汽</big></a>
                  <ul id="1214_sub">
                  </ul>
                </li>
                <li title="中联重科" id="134"> <a class="mainBrand" href="<%=url%>?factory=134"><big>中联重科</big></a>
                  <ul id="134_sub">
                  </ul>
                </li>
                <li title="竹内" id="188"> <a class="mainBrand" href="<%=url%>?factory=188"><big>竹内</big></a>
                  <ul id="188_sub">
                  </ul>
                </li>
                <li title="住友" id="185"> <a class="mainBrand" href="<%=url%>?factory=185"><big>住友</big></a>
                  <ul id="185_sub">
                  </ul>
                </li>
              </ul>
            </li>
          </ul>
        </div>
        <!--字母检索结束--> 
      </div>
    </div>