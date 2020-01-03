//导航当前状态
var jrChannelArr=jrChannel.split('#');
$('.comNav ul.fix').children('li').eq(jrChannelArr[0]).addClass('cur').find('li').eq(jrChannelArr[1]).addClass('cur');

$('.comNav li').mouseenter(function(){
	$(this).addClass('hover');
}).mouseleave(function(){
	$(this).removeClass('hover');
})

/*var jrChannelArr_shop=jrChannel_shop.split('#');
$('.shopNav').children('li').eq(jrChannelArr_shop[0]).addClass('cur').find('li').eq(jrChannelArr_shop[1]).addClass('cur');*/

$('body').on('click','.favorite',function(){var sURL = "http:&#47;&#47;"+document.domain+"&#47;",sTitle = document.title;try{window.external.addFavorite(sURL, sTitle)} catch (e){try{window.sidebar.addPanel(sTitle, sURL, "")}catch (e){alert("加入收藏失败，请使用Ctrl+D进行添加")}}});

$('.kb_cates .kbc').mouseenter(function(){
	$(this).addClass('kbc-hover');
}).mouseleave(function(){
	$(this).removeClass('kbc-hover');
});

