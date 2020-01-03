document.write("<div class='QQbox' id='divQQbox' >");
document.write("<div class='Qlist' id='divOnline' >");
document.write("<div class='t'></div>");
document.write("<div class='infobox'>业务咨询</div>");
document.write("<div class='con'>");

document.write("<ul>");


document.writeln("<div style=\"margin-bottom:5px;\"><a target=\"_blank\" style=\"padding-right:2px;\" href=\"http:\/\/wpa.qq.com\/msgrd?v=3&uin=1969036473&site=qq&menu=yes\"><img border=\"0\" src=\"http:\/\/wpa.qq.com\/pa?p=2:1969036473:41\" style=\"display:inline;\" alt=\"点击这里给我发消息\" title=\"点击这里给我发消息\"><\/a><\/div>");

document.writeln("<div style=\"margin-bottom:5px;\"><a target=\"_blank\" style=\"padding-right:2px;\" href=\"http:\/\/wpa.qq.com\/msgrd?v=3&uin=1970397999&site=qq&menu=yes\"><img border=\"0\" src=\"http:\/\/wpa.qq.com\/pa?p=2:1970397999:41\" style=\"display:inline;\" alt=\"点击这里给我发消息\" title=\"点击这里给我发消息\"><\/a><\/div>");

//document.writeln("<div style=\"margin-bottom:5px;\"><a target=\"_blank\" style=\"padding-right:2px;\" href=\"http:\/\/wpa.qq.com\/msgrd?v=3&uin=541721078&site=qq&menu=yes\"><img border=\"0\" src=\"http:\/\/wpa.qq.com\/pa?p=2:541721078:41\" style=\"display:inline;\" alt=\"点击这里给我发消息\" title=\"点击这里给我发消息\"><\/a><\/div>");

document.writeln("<div style=\"margin-bottom:5px;\"><a target=\"_blank\" style=\"padding-right:2px;\" href=\"http:\/\/wpa.qq.com\/msgrd?v=3&uin=1375783407&site=qq&menu=yes\"><img border=\"0\" src=\"http:\/\/wpa.qq.com\/pa?p=2:1375783407:51\" style=\"display:inline;\" alt=\"您好！广州市玛润机械设备有限为您服务\" title=\"您好！广州市玛润机械设备有限公司为您服务\"><\/a><\/div>");



document.write("</ul>");

document.write("</div>");

document.write("<div class='b'></div>");

document.write("</div>");

//document.write("<div id='divMenu' onmouseover='OnlineOver();'><img src='../okqq/images/qq_1.gif' class='press' alt='在线咨询'></div>");

document.write("</div>");



//<![CDATA[

var tips; var theTop = 145/*这是默认高度,越大越往下*/; var old = theTop;

function initFloatTips() {

tips = document.getElementById('divQQbox');

moveTips();

};

function moveTips() {

var tt=50;

if (window.innerHeight) {

pos = window.pageYOffset

}

else if (document.documentElement && document.documentElement.scrollTop) {

pos = document.documentElement.scrollTop

}

else if (document.body) {

pos = document.body.scrollTop;

}

pos=pos-tips.offsetTop+theTop;

pos=tips.offsetTop+pos/10;



if (pos < theTop) pos = theTop;

if (pos != old) {

tips.style.top = pos+"px";

tt=10;

//alert(tips.style.top);

}



old = pos;

setTimeout(moveTips,tt);

}

//!]]>

initFloatTips();







function OnlineOver(){

document.getElementById("divMenu").style.display = "none";

document.getElementById("divOnline").style.display = "block";

document.getElementById("divQQbox").style.width = "170px";

}



function OnlineOut(){

document.getElementById("divMenu").style.display = "block";

document.getElementById("divOnline").style.display = "none";



}



if(typeof(HTMLElement)!="undefined")    //给firefox定义contains()方法，ie下不起作用
{   
      HTMLElement.prototype.contains=function(obj)   
      {   
          while(obj!=null&&typeof(obj.tagName)!="undefind"){ //通过循环对比来判断是不是obj的父元素
   　　　　if(obj==this) return true;   
   　　　　obj=obj.parentNode;
   　　}   
          return false;   
      };   
}  


function hideMsgBox(theEvent){ //theEvent用来传入事件，Firefox的方式

　 if (theEvent){

　 var browser=navigator.userAgent; //取得浏览器属性

　 if (browser.indexOf("Firefox")>0){ //如果是Firefox

　　 if (document.getElementById('divOnline').contains(theEvent.relatedTarget)) { //如果是子元素

　　 return; //结束函式

} 

} 

if (browser.indexOf("MSIE")>0){ //如果是IE

if (document.getElementById('divOnline').contains(event.toElement)) { //如果是子元素

return; //结束函式

}

}

}

/*要执行的操作*/

document.getElementById("divMenu").style.display = "block";

document.getElementById("divOnline").style.display = "none";

}









   