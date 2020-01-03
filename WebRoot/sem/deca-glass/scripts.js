// JavaScript Document
function displaylayer(div) {
	var subMenu = div.getElementsByTagName("span")[0];
	subMenu.style.display = "block";
}
function hidelayer(div) {
	var subMenu = div.getElementsByTagName("span")[0];
	subMenu.style.display = "none";
}
//banner
$.fn.T_banner=function(){
var $this,$b_,t,n=0,count,$nav,$p,$n;
	$this=$(this);
	$b_=$this.children('.ban_c');
	count=$b_.length;
	$nav=$('<div class="ban_nav"></div>');
	for(i=0;i<count;i++){
		$nav.append('<a>'+(i+1)+'</a>')
		}
	$this.append($nav);
	$nav.children('a').eq(0).addClass('on');
	$b_.hide().eq(0).show();
	$nav.children('a').each(function(index, element) {
		$(this).click(function() {
			if (index >= count) return;
			$b_.fadeOut(500).eq(index).fadeIn(800);
			$(this).addClass('on').siblings().removeAttr("class");
			n=index
		})
	});
	$p=$(this).find('.tbLeft');
	$n=$(this).find('.tbRight');
	t = setInterval(function(){
		showAuto()
		}, 3000);
	$this.hover(function(){clearInterval(t)}, function(){t = setInterval(function(){
		showAuto()
		}, 3000);});
	$p.click(function(){showPre()})
	$n.click(function(){showAuto()})
	function showAuto(){
		n = n >=(count - 1) ? 0 : ++n;
		$nav.find('a').eq(n).trigger('click')
	}
	function showPre(){
		n = n <=0 ? (count - 1) : --n;
		$nav.find('a').eq(n).trigger('click')
	}
}

jQuery(document).ready(function(){
$(".pro_one").hover(
function(){
	$(this).children("a").children("span").css("color","#0266bb");
	$(this).children("div").children("a").children("span").css("color","#0266bb");
	},
function(){
	$(this).children("a").children("span").css("color","#000");
	$(this).children("div").children("a").children("span").css("color","#000");
	})
})