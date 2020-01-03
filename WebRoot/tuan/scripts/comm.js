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
var $nav=$('.subNav').find('li').has('.menu');
$nav.mouseenter(function(){

	//	$(this).children('.subnav').stop(1,1).slideDown('fast');
		$(this).addClass('cur');
		//$(this).children('a').css('border-bottom','#ffb400 solid 4px;')
	}).mouseleave(function(){
			$(this).removeClass('cur')
		//$(this).children('.subnav').stop(1,1).slideUp('fast')
});


	$('.city').hover( function(){
		$(this).find(".address").toggle();	
		$(this).toggleClass("arr_up");
	})

