// JavaScript Document

function nTabs(thisObj, Num) {
	if (thisObj.className == "active") return;
	var tabObj = thisObj.parentNode.id;
	var tabList = document.getElementById(tabObj).getElementsByTagName("li");
	for (i = 0; i < tabList.length; i++) {
		if (i == Num) {
			thisObj.className = "active";
			document.getElementById(tabObj + "_Content" + i).style.display = "block";
		} else {
			tabList[i].className = "normal";
			document.getElementById(tabObj + "_Content" + i).style.display = "none";
		}
	}
}

window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"1","bdSize":"16"},"share":{}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];
$(".backTop").click(function(){
	$('body,html').animate({scrollTop:0},1000);
	return false;
});

/*导航菜单*/
var $nav=$('.nav').find('li').has('.subnav');
$nav.mouseenter(function(){
		$(this).children('.subnav').stop(1,1).slideDown('fast');
		$(this).addClass('cur');
		//$(this).children('a').css('border-bottom','#ffb400 solid 4px;')
	}).mouseleave(function(){
			$(this).removeClass('cur')
		$(this).children('.subnav').stop(1,1).slideUp('fast')
});

/*左侧导航配件滚动*/
jQuery(".leftPart").slide({ mainCell:".bd ul",effect:"leftLoop",vis:1,scroll:1,autoPlay:true});





function P7_colH(){

       var i,oh,hh,h=0,dA=document.p7eqc,an=document.p7eqa;

       if(dA&&dA.length){

              for(i=0;i<dA.length;i++){

                     dA[i].style.height='auto';

              }

              for(i=0;i<dA.length;i++){

                     oh=dA[i].offsetHeight;h=(oh>h)?oh:h;

              }

              for(i=0;i<dA.length;i++){

                     if(an){

                            dA[i].style.height=h+'px';

                     }

                     else{

                            P7_eqA(dA[i].id,dA[i].offsetHeight,h);

                     }

              }

 

       if(an){

              for(i=0;i<dA.length;i++){

                     hh=dA[i].offsetHeight;

                     if(hh>h){

                            dA[i].style.height=(h-(hh-h))+'px';

                     }

              }

       }else{

              document.p7eqa=1;

       }

              document.p7eqth=document.body.offsetHeight;

              document.p7eqtw=document.body.offsetWidth;

       }

}

 

function P7_eqT(){

       if(document.p7eqth!=document.body.offsetHeight||document.p7eqtw!=document.body.offsetWidth){

              P7_colH();

       }

}

 

function P7_equalCols(){
		alert("ddd")
       if(document.getElementById){

              document.p7eqc=new Array;

              for(i=0;i<arguments.length;i++){

                     document.p7eqc[i]=document.getElementById(arguments[i]);

              }

              setInterval("P7_eqT()",10);

       }

}

 

function P7_eqA(el,h,ht){

       var sp=10,inc=10,nh=h,g=document.getElementById(el),oh=g.offsetHeight,ch=parseInt(g.style.height);

       ch=(ch)?ch:h;

       var ad=oh-ch,adT=ht-ad;

       nh+=inc;

       nh=(nh>adT)?adT:nh;

       g.style.height=nh+'px';

       oh=g.offsetHeight;

       if(oh>ht){

              nh=(ht-(oh-ht));g.style.height=nh+'px';

       }

       if(nh<adT){

              setTimeout("P7_eqA('"+el+"',"+nh+","+ht+")",sp);

       }

}

