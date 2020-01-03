var ie6 = !-[1,] && !window.XMLHttpRequest; 
//Slide func
$.fn.slide=function(){
var defaults,opts,data_opts,$this,$b_,t,n=0,count,$nav,$p,$n;
	defaults={
		fade:true,
		auto:true,
		time:4000,
		callback:null
		};
	$this=$(this);
	if($this.attr('data-slide')){eval('data_opts='+$this.attr('data-slide'))};
	opts=$.extend({},defaults,data_opts);
	$b_=$this.children('.ban_c');
	count=$b_.length;
	if($this.find('.ban_nav').length){$nav=$this.find('.ban_nav')}else{
			$nav=$('<div class="ban_nav"></div>');
			for(i=0;i<count;i++){$nav.append('<a>'+(i+1)+'</a>')};
			$this.append($nav)
			};
	$this.append('<a class="Left"></a><a class="Right"></a>');
	$nav.children('a').eq(0).addClass('on');
	$nav.children('a').eq(1).addClass('ban_next');
	$nav.children('a').eq(count-1).addClass('ban_prev');
	$b_.hide().eq(0).show();
	if(ie6){$b_.height($b_.attr('height') || $this.height())};
	$nav.children('a').each(function(index) {
		$(this).click(function(event) {
			event.preventDefault();
			if (index >= count){return}else{
					$nav.children('a').eq(index-1).addClass('ban_prev').siblings().removeClass('ban_prev');
					$nav.children('a').eq(index==count-1 ? 0 : index+1).addClass('ban_next').siblings().removeClass('ban_next')
					};
			if(opts.fade){$b_.stop(1,1).fadeOut(500).eq(index).stop(1,1).fadeIn(800)}else{$b_.hide().eq(index).show()};
			$(this).addClass('on').siblings().removeClass("on");
			n=index
		})
	});
	$p=$(this).find('.Left');
	$n=$(this).find('.Right');
	if(opts.auto){
		t = setInterval(function(){showAuto()}, opts.time);
		$this.hover(function(){clearInterval(t)},function(){t=setInterval(function(){showAuto()},opts.time)})
		};
	$p.click(function(){showPre()});
	$n.click(function(){showAuto()});
	function showAuto(){n=n>=(count - 1) ? 0 : ++n;$nav.find('a').eq(n).trigger('click')};
	function showPre(){n=n<=0 ? (count - 1) : --n;$nav.find('a').eq(n).trigger('click')};
	if(opts.callback){opts.callback($b_,$nav,count)}
};
$('.slide').each(function() {$(this).slide()});
//连续滚动
$.fn.conScroll=function(){
	var Con=$(this)
		,Ul=Con.find('ul')
		,Li=Ul.find('li')
		,BtnL=Con.prev('.BtnL')
		,BtnR=Con.next('.BtnR')
		,Speed=1
		,T,
		LiWidth=0;
	for(var i=0;i<Li.length;i++){
		LiWidth+=(Li.eq(i).outerWidth(true))
		}
	Ul.append(Ul.html());
	Ul.width(LiWidth*2);
	function goRoll(){
		T=setInterval(function(){
			Ul.css('left',parseInt(Ul.css('left'))-Speed+'px');
			if(parseInt(Ul.css('left'))<-parseInt(Ul.width())/2){
				Ul.css('left','0')
				}else if(parseInt(Ul.css('left'))>=0){
					Ul.css('left',-parseInt(Ul.width())/2)
					}
			},30);
		}
	Ul.mouseover(function() {clearInterval(T)});
	Ul.mouseout(function() {goRoll()});
	BtnL.mouseover(function() {Speed = -1});
	BtnR.mouseover(function() {Speed = 1});
	goRoll();
	};
$('.conscroll').each(function() {$(this).conScroll()});
//选项卡
$.fn.tab=function(){
	var $key=$(this).find('.tab_key'),
		 $val=$(this).find('.tab_val');
	$key.first().addClass('cur');
	$val.first().show();
	$key.each(function(index){
		$(this).click(function(event){
			event.preventDefault();
			$(this).addClass('cur').siblings().removeClass('cur');
			$val.hide().eq(index).show();
			})
		})
	};
$('.tab').each(function() { $(this).tab()});
//纵向滚动
$.fn.Scroll=function(opt,callback){
	 if(!opt) var opt={};
	 var _btnUp = $("#"+ opt.up),
	 	 _btnDown = $("#"+ opt.down),
	 	 _this=this.eq(0).find("ul:first"),
	    lineH=_this.find("li").height(), 
		 line=opt.line?parseInt(opt.line,10):parseInt(this.height()/lineH,10), 
		 speed=opt.speed?parseInt(opt.speed,10):500,
		 timer=opt.timer || 30000,
		 cols,lasted,timerID;
	 line=line?line:1;
	 var upHeight=0-line*lineH;
	 var scrollUp=function(){
		 	cols=Math.floor(_this.width()/_this.find("li").width());
			_btnUp.unbind("click",scrollUp);
			_this.animate({marginTop:upHeight},speed,function(){
					_this.find("li:lt("+cols+")").appendTo(_this);
					_this.css('marginTop',0);
					_btnUp.bind("click",scrollUp);
			})
	 };
	 var scrollDown=function(){
		 lasted=_this.find("li").length-Math.floor(_this.width()/_this.find("li").width())-1;
			_btnDown.unbind("click",scrollDown);
			for(i=1;i<=line;i++){_this.find("li:gt("+lasted+")").show().prependTo(_this)};
			_this.css({marginTop:upHeight});
			_this.animate({marginTop:0},speed,function(){
				_btnDown.bind("click",scrollDown)
			})
	 };
	 var autoPlay = function(){if(timer)timerID = window.setInterval(scrollUp,timer)};
	 var autoStop = function(){if(timer)window.clearInterval(timerID)};
	 _this.hover(autoStop,autoPlay).mouseout();
	 _btnUp.click( scrollUp ).hover(autoStop,autoPlay);
	 _btnDown.click( scrollDown ).hover(autoStop,autoPlay);
  };    
//关闭标签页     
function CloseWin(){window.opener=null;window.open("","_self");window.close()};
//字号调节
var $speech=$('.myart'),defaultsize=$speech.css('font-size');
$('#switcher a').click(function(){
	var num=parseFloat($speech.css('font-size'),10)
	switch(this.id){
		case 'switch-small':
		num/=1.4;
		break;
		case 'switch-big':
		num*=1.4;
		break;
		default:
		num=parseFloat(defaultsize,10)
		}
		$speech.css('font-size',num+'px')
	});
//ie6定位修复
$.fn.ie6Fix=function(){
	var $this=$(this),
		 posiTop=$this.css('top')!='auto' ? true : ($this.css('bottom')!='auto' ? false : null),
		 selfHei=$(this).outerHeight(true),
		 $H=$(window).height(),	
		 posiVal=parseInt($this.css(posiTop ? 'top' : 'bottom'));
	if(posiTop!=null){
		$this.css('top',posiTop ? posiVal : $H-selfHei-posiVal).css('position','absolute');
		$(window).resize(function(){
			$H=$(this).height();
			$this.css('top',posiTop ? posiVal : $H-selfHei-posiVal);
		})
		$(window).scroll(function(){
			$H=$(this).height();
			$this.css('top',posiTop ? $(this).scrollTop()+posiVal : $H-selfHei-posiVal+$(this).scrollTop());
		})
	}else{
		alert('ie6Fix():缺少top或bottom')
		}
};
if(ie6){$('.ie6Fix').each(function() {$(this).ie6Fix()})};
//返回顶部
$('.gotop').click(function(){$('html,body').stop().animate({scrollTop:'0'},300)});
//内页左侧菜单
var $menu=$('.s_menu').find('.dd').children('ul');
$menu.find('.cur').children('ul').show();
$menu.find('li').has('ul').children('a').click(function(event){
		event.preventDefault();
		$(this).parent().toggleClass('cur').siblings().removeClass('cur').children('ul').slideUp('fast');
		$(this).next('ul').slideToggle('fast')
	});
//导航
/*var $nav=$('.nav').find('li').has('ul');
$nav.mouseenter(function(){
		$(this).children('ul').stop(1,1).slideDown('fast')
	}).mouseleave(function(){
		$(this).children('ul').stop(1,1).slideUp('fast')
});
*/
$(function(){
	var $nav=$('.menu').find('li').has('ul');
	$nav.hover(
		function (){
			$(this).children(".sub").toggle();	
			$('.nav .subnavbg').toggle();
			$(this).children('em').toggle();
		})
})



 