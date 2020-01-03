<%@ page language="java" import="java.sql.Connection,com.jerehnet.webservice.*,org.json.*,java.util.*,com.jerehnet.util.common.*,com.jerehnet.util.dbutil.*" pageEncoding="UTF-8"%>

<%
	String factory = CommonString.getFormatPara(request.getParameter("factory"));
	String catalog = CommonString.getFormatPara(request.getParameter("catalog"));
	String url="";
	if(!catalog.equals("")){url=url+"catalog="+catalog;}
	if(!factory.equals("")){url=url+"&factory="+factory;}
	%>
<!--区域下拉列表-->
<div class="dl_area_list dl_sele fix">
    <div class="l dl_sele_l">
    <ul class="idTabs dl_sele_l_ls">
        <li><a  href="#area5"  >山东<i>17</i></a></li>
        <li><a  href="#area6"  >河北<i>11</i></a></li>
        <li><a  href="#area7"  >山西<i>11</i></a></li>
        <li><a  href="#area8"  >内蒙古<i>12</i></a></li>
        <li><a  href="#area9"  >江苏<i>18</i></a></li>
        <li><a  href="#area10"  >浙江<i>11</i></a></li>
        <li><a  href="#area11"  >安徽<i>17</i></a></li>
        <li><a  href="#area12"  >广东<i>21</i></a></li>
        <li><a  href="#area13"  >福建<i>9</i></a></li>
        <li><a  href="#area14"  >广西<i>14</i></a></li>
        <li><a  href="#area15"  >江西<i>11</i></a></li>
        <li><a  href="#area16"  >海南<i>2</i></a></li>
        <li><a  href="#area17"  >河南<i>18</i></a></li>
        <li><a  href="#area18"  >湖北<i>14</i></a></li>
        <li><a  href="#area19"  >湖南<i>14</i></a></li>
        <li><a  href="#area20"  >辽宁<i>14</i></a></li>
        <li><a  href="#area21"  >吉林<i>9</i></a></li>
        <li><a  href="#area22"  >黑龙江<i>14</i></a></li>
        <li><a  href="#area23"  >四川<i>22</i></a></li>
        <li><a  href="#area24"  >贵州<i>9</i></a></li>
        <li><a  href="#area25"  >云南<i>16</i></a></li>
        <li><a  href="#area26"  >西藏<i>7</i></a></li>
        <li><a  href="#area27"  >陕西<i>10</i></a></li>
        <li><a  href="#area28"  >甘肃<i>14</i></a></li>
        <li><a  href="#area29"  >青海<i>8</i></a></li>
        <li><a  href="#area30"  >宁夏<i>5</i></a></li>
        <li><a  href="#area31"  >新疆<i>14</i></a></li>
	    <li><a href="agent_list.jsp?<%=url%>&city=101-101"  >北京<i></i></a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=102-102"  >天津<i></i></a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=103-103"  >上海<i></i></a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=104-104"  >重庆<i></i></a></li>
    </ul>
  </div>
  <div class="r dl_sele_r">
    <div class="dl_sele_r_ls" id="area1">
      <ul>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area2">
      <ul>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area3">
      <ul>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area4">
      <ul>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area5">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105001"><span>34</span>济南</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105002"><span>18</span>青岛</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105003"><span>23</span>淄博</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105004"><span>27</span>临沂</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105005"><span>19</span>济宁</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105006"><span>11</span>东营</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105007"><span>18</span>泰安</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105008"><span>12</span>滨州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105009"><span>16</span>德州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105010"><span>3</span>菏泽</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105011"><span>11</span>枣庄</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105012"><span>11</span>聊城</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105013"><span>8</span>莱芜</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105014"><span>20</span>烟台</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105015"><span>21</span>潍坊</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105016"><span>12</span>威海</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=105-105017"><span>21</span>日照</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area6">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=106-106001"><span>24</span>石家庄</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=106-106002"><span>14</span>唐山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=106-106003"><span>15</span>保定</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=106-106004"><span>10</span>邯郸</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=106-106005"><span>9</span>沧州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=106-106006"><span>8</span>邢台</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=106-106007"><span>5</span>廊坊</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=106-106008"><span>10</span>秦皇岛</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=106-106009"><span>20</span>张家口</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=106-106010"><span>6</span>衡水</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=106-106011"><span>14</span>承德</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area7">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=107-107001"><span>19</span>太原</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=107-107002"><span>19</span>临汾</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=107-107003"><span>14</span>运城</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=107-107004"><span>11</span>长治</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=107-107005"><span>15</span>大同</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=107-107006"><span>13</span>晋城</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=107-107007"><span>12</span>晋中</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=107-107008"><span>13</span>忻州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=107-107009"><span>16</span>吕梁</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=107-107010"><span>9</span>朔州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=107-107011"><span>10</span>阳泉</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area8">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108001"><span>13</span>呼和浩特</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108002"><span>23</span>包头</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108003"><span>22</span>鄂尔多斯</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108004"><span>13</span>赤峰</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108005"><span>12</span>通辽</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108006"><span>16</span>呼伦贝尔</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108007"><span>10</span>乌海</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108008"><span>8</span>乌兰察布</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108009"><span>6</span>巴彦淖尔</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108010"><span>2</span>兴安</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108011"><span>9</span>锡林郭勒</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=108-108012"><span>7</span>阿拉善</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area9">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109001"><span>23</span>南京</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109002"><span>8</span>苏州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109003"><span>14</span>常州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109004"><span>10</span>南通</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109005"><span>10</span>徐州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109006"><span>14</span>扬州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109007"><span>12</span>镇江</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109008"><span>15</span>盐城</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109009"><span>10</span>无锡</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109010"><span>12</span>泰州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109011"><span>12</span>连云港</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109012"><span>14</span>淮安</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109013"><span>12</span>宿迁</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109014"><span>2</span>常熟</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109015"><span>7</span>昆山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109016"><span>3</span>张家港</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109017"><span>0</span>太仓</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=109-109018"><span>3</span>江阴</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area10">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=110-110001"><span>15</span>杭州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=110-110002"><span>15</span>宁波</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=110-110003"><span>16</span>温州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=110-110004"><span>12</span>台州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=110-110005"><span>10</span>绍兴</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=110-110006"><span>14</span>嘉兴</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=110-110007"><span>12</span>金华</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=110-110008"><span>14</span>湖州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=110-110009"><span>9</span>衢州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=110-110010"><span>7</span>丽水</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=110-110011"><span>11</span>舟山</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area11">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111001"><span>26</span>合肥</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111002"><span>13</span>安庆</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111003"><span>12</span>阜阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111004"><span>12</span>蚌埠</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111005"><span>12</span>六安</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111006"><span>9</span>淮北</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111007"><span>10</span>淮南</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111008"><span>14</span>芜湖</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111009"><span>14</span>宿州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111010"><span>7</span>亳州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111011"><span>6</span>铜陵</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111012"><span>8</span>马鞍山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111013"><span>7</span>巢湖</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111014"><span>7</span>池州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111015"><span>4</span>黄山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111016"><span>11</span>滁州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=111-111017"><span>9</span>宣城</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area12">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112001"><span>17</span>深圳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112002"><span>19</span>广州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112003"><span>5</span>珠海</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112004"><span>3</span>中山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112005"><span>6</span>惠州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112006"><span>10</span>东莞</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112007"><span>11</span>佛山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112008"><span>5</span>汕头</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112009"><span>2</span>江门</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112010"><span>11</span>韶关</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112011"><span>1</span>揭阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112012"><span>12</span>肇庆</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112013"><span>6</span>清远</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112014"><span>2</span>汕尾</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112015"><span>6</span>河源</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112016"><span>2</span>阳江</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112017"><span>5</span>湛江</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112018"><span>2</span>潮州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112019"><span>9</span>茂名</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112020"><span>3</span>云浮</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=112-112021"><span>9</span>梅州</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area13">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=113-113001"><span>11</span>福州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=113-113002"><span>11</span>厦门</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=113-113003"><span>6</span>泉州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=113-113004"><span>8</span>龙岩</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=113-113005"><span>4</span>漳州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=113-113006"><span>8</span>三明</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=113-113007"><span>3</span>莆田</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=113-113008"><span>5</span>宁德</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=113-113009"><span>20</span>南平</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area14">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114001"><span>14</span>南宁</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114002"><span>12</span>柳州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114003"><span>13</span>桂林</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114004"><span>5</span>北海</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114005"><span>10</span>河池</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114006"><span>5</span>玉林</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114007"><span>7</span>防城港</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114008"><span>8</span>梧州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114009"><span>4</span>来宾</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114010"><span>5</span>崇左</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114011"><span>12</span>钦州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114012"><span>15</span>百色</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114013"><span>8</span>贵港</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=114-114014"><span>8</span>贺州</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area15">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=115-115001"><span>15</span>南昌</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=115-115002"><span>12</span>赣州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=115-115003"><span>9</span>九江</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=115-115004"><span>17</span>上饶</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=115-115005"><span>8</span>宜春</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=115-115006"><span>8</span>鹰潭</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=115-115007"><span>8</span>抚州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=115-115008"><span>8</span>景德镇</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=115-115009"><span>10</span>吉安</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=115-115010"><span>8</span>新余</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=115-115011"><span>9</span>萍乡</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area16">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=116-116001"><span>11</span>海口</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=116-116002"><span>6</span>三亚</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area17">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117001"><span>21</span>郑州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117002"><span>15</span>洛阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117003"><span>8</span>新乡</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117004"><span>20</span>南阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117005"><span>13</span>安阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117006"><span>11</span>焦作</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117007"><span>5</span>许昌</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117008"><span>2</span>濮阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117009"><span>16</span>平顶山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117010"><span>8</span>商丘</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117011"><span>5</span>周口</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117012"><span>22</span>信阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117013"><span>6</span>漯河</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117014"><span>5</span>开封</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117015"><span>9</span>鹤壁</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117016"><span>14</span>驻马店</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117017"><span>5</span>济源</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=117-117018"><span>15</span>三门峡</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area18">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118001"><span>29</span>武汉</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118002"><span>13</span>宜昌</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118003"><span>4</span>襄阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118004"><span>20</span>十堰</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118005"><span>11</span>黄石</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118006"><span>7</span>荆州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118007"><span>9</span>咸宁</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118008"><span>7</span>孝感</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118009"><span>0</span>潜江</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118010"><span>10</span>恩施</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118011"><span>9</span>黄冈</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118012"><span>0</span>鄂州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118013"><span>10</span>随州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=118-118014"><span>12</span>荆门</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area19">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119001"><span>19</span>长沙</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119002"><span>11</span>郴州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119003"><span>11</span>常德</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119004"><span>13</span>衡阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119005"><span>9</span>娄底</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119006"><span>9</span>株洲</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119007"><span>14</span>邵阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119008"><span>9</span>岳阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119009"><span>0</span>湘西</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119010"><span>9</span>张家界</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119011"><span>8</span>益阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119012"><span>10</span>永州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119013"><span>9</span>湘潭</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=119-119014"><span>12</span>怀化</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area20">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120001"><span>27</span>沈阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120002"><span>25</span>大连</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120003"><span>20</span>鞍山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120004"><span>16</span>锦州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120005"><span>12</span>营口</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120006"><span>8</span>葫芦岛</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120007"><span>9</span>辽阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120008"><span>10</span>本溪</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120009"><span>34</span>朝阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120010"><span>4</span>铁岭</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120011"><span>1</span>盘锦</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120012"><span>7</span>阜新</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120013"><span>12</span>抚顺</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=120-120014"><span>15</span>丹东</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area21">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=121-121001"><span>21</span>长春</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=121-121002"><span>158</span>吉林</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=121-121003"><span>2</span>延边</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=121-121004"><span>4</span>通化</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=121-121005"><span>5</span>白城</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=121-121006"><span>6</span>白山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=121-121007"><span>2</span>辽源</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=121-121008"><span>7</span>四平</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=121-121009"><span>8</span>松原</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area22">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122001"><span>21</span>哈尔滨</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122002"><span>6</span>大庆</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122003"><span>7</span>牡丹江</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122004"><span>8</span>齐齐哈尔</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122005"><span>3</span>双鸭山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122006"><span>3</span>绥化</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122007"><span>1</span>大兴安岭</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122008"><span>4</span>黑河</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122009"><span>3</span>伊春</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122010"><span>12</span>佳木斯</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122011"><span>5</span>鸡西</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122012"><span>2</span>七台河</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122013"><span>4</span>鹤岗</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=122-122014"><span>143</span>重庆</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area23">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123001"><span>23</span>成都</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123002"><span>7</span>绵阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123003"><span>6</span>南充</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123004"><span>3</span>德阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123005"><span>9</span>乐山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123006"><span>8</span>万州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123007"><span>2</span>凉山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123008"><span>0</span>甘孜</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123009"><span>0</span>阿坝</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123010"><span>13</span>泸州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123011"><span>6</span>巴中</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123012"><span>3</span>眉山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123013"><span>6</span>达州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123014"><span>5</span>广安</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123015"><span>7</span>内江</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123016"><span>5</span>雅安</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123017"><span>13</span>宜宾</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123018"><span>10</span>攀枝花</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123019"><span>5</span>广元</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123020"><span>6</span>资阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123021"><span>10</span>自贡</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=123-123022"><span>7</span>遂宁</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area24">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=124-124001"><span>16</span>贵阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=124-124002"><span>11</span>遵义</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=124-124003"><span>4</span>安顺</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=124-124004"><span>6</span>铜仁</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=124-124005"><span>1</span>黔东南</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=124-124006"><span>7</span>六盘水</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=124-124007"><span>0</span>黔南</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=124-124008"><span>5</span>毕节</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=124-124009"><span>2</span>黔西南</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area25">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125001"><span>20</span>昆明</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125002"><span>6</span>曲靖</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125003"><span>10</span>大理</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125004"><span>6</span>玉溪</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125005"><span>6</span>红河</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125006"><span>3</span>丽江</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125007"><span>0</span>怒江</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125008"><span>1</span>德宏</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125009"><span>3</span>临沧</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125010"><span>2</span>迪庆</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125011"><span>4</span>昭通</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125012"><span>1</span>西双版纳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125013"><span>4</span>文山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125014"><span>5</span>保山</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125015"><span>3</span>楚雄</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=125-125016"><span>9</span>普洱</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area26">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=126-126001"><span>7</span>拉萨</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=126-126002"><span>0</span>阿里</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=126-126003"><span>0</span>那曲</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=126-126004"><span>0</span>山南</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=126-126005"><span>0</span>昌都</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=126-126006"><span>0</span>日喀则</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=126-126007"><span>0</span>林芝</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area27">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=127-127001"><span>12</span>西安</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=127-127002"><span>6</span>榆林</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=127-127003"><span>0</span>渭南</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=127-127004"><span>3</span>宝鸡</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=127-127005"><span>3</span>汉中</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=127-127006"><span>3</span>安康</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=127-127007"><span>0</span>咸阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=127-127008"><span>1</span>商洛</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=127-127009"><span>0</span>铜川</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=127-127010"><span>2</span>延安</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area28">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128001"><span>15</span>兰州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128002"><span>7</span>张掖</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128003"><span>6</span>酒泉</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128004"><span>8</span>庆阳</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128005"><span>9</span>天水</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128006"><span>5</span>武威</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128007"><span>2</span>临夏</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128008"><span>8</span>平凉</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128009"><span>3</span>定西</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128010"><span>1</span>金昌</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128011"><span>4</span>嘉峪关</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128012"><span>5</span>白银</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128013"><span>0</span>甘南</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=128-128014"><span>9</span>陇南</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area29">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=129-129001"><span>13</span>西宁</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=129-129002"><span>2</span>玉树</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=129-129003"><span>1</span>果洛</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=129-129004"><span>1</span>黄南</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=129-129005"><span>77</span>海南</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=129-129006"><span>2</span>海东</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=129-129007"><span>18</span>海西</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=129-129008"><span>1</span>海北</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area30">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=130-130001"><span>13</span>银川</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=130-130002"><span>9</span>固原</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=130-130003"><span>6</span>吴忠</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=130-130004"><span>8</span>中卫</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=130-130005"><span>10</span>石嘴山</a></li>
      </ul>
    </div>
    <div class="dl_sele_r_ls" id="area31">
      <ul>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131001"><span>16</span>乌鲁木齐</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131002"><span>8</span>和田</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131003"><span>14</span>阿克苏</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131004"><span>11</span>哈密</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131005"><span>10</span>喀什</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131006"><span>0</span>新疆克州</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131007"><span>14</span>阿勒泰</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131008"><span>1</span>塔城</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131009"><span>5</span>吐鲁番</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131010"><span>19</span>伊犁</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131011"><span>4</span>克拉玛依</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131012"><span>12</span>巴音郭楞</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131013"><span>0</span>博尔塔拉</a></li>
        <li><a href="agent_list.jsp?<%=url%>&city=131-131014"><span>12</span>昌吉</a></li>
      </ul>
    </div>
  </div>
  <div class="dl_sele_btm"></div>
</div>
<!--end 区域下拉列表 --> 