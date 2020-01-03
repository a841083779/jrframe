/*

scrollBar

wrap:		包裹元素,jQuery选择器格式,默认不指定，将新增div.scroll_c;
monitor: 是否监听内容height和top变化(用于多插件协作),布尔值,默认false;
keyway:	滑条键程,数值(px),默认30;

*/
define(function(require, exports, module) {
   var $ = require('$');
	require('./scroll-bar.css')
	
	var isFirefox = typeof document.body.style.MozUserSelect != 'undefined';
	function addEvent(obj, type, fn) {if (obj.addEventListener) {obj.addEventListener(isFirefox ? 'DOMMouseScroll' : type, fn, false)}else{obj.attachEvent('on' + type, fn)};return fn};
	function delEvent(obj, type, fn) {if (obj.removeEventListener) {obj.removeEventListener(isFirefox ? 'DOMMouseScroll' : type, fn, false)}else{obj.detachEvent('on' + type, fn)}};

$.fn.scrollBar=function(config){
	var this_=$(this),sC,sB,sU,sD,sS,sW,sAH,sAW,sSH,sSW,prop,keyway,ssTop=0,defaults,opts,testVal=false,testID,testMe,testHandler;
	defaults={
		wrap:null,
		monitor:false,
		keyway:30,
		fn:function(){}
		};
	opts=$.extend({},defaults, config || {}, this_.data('config')||{});
	if(opts.wrap){
		sC=$(''+opts.wrap)
		}else{
			this_.wrapInner("<div class='scroll_c'></div>");
			sC=this_.children('.scroll_c');
			};
	testID=this_.attr('id') ? this_.attr('id') : 'scrollID'+Math.floor(Math.random()*100);
	this_.attr('id',testID).append("<div class='scroll_bar' onselectstart='return false;'><div class='scroll_up'><!----></div><div class='scroll_slider' unselectable='on'><!----></div><div class='scroll_down' style='position:absolute;bottom:0;left:0;overflow:hidden'><!----></div></div>");
	sB=this_.children('.scroll_bar');
	sU=sB.children('.scroll_up');
	sD=sB.children('.scroll_down');
	sS=sB.children('.scroll_slider');
	sW=!!sB.width()?sB.width() : 10;		//滚动条宽度
	sAH=!!sU.height()?sU.height():16;	//按钮高度
	sAW=!!sU.width()?sU.width():'100%';	//按钮宽度
	sSW=!!sS.width()?sS.width():'100%';	//滑块宽度
	keyway=opts.keyway; 						//按钮键程
	testMe=document.getElementById(testID);
	sB.width(sW);
	sC.css({marginRight:sW,position:"relative"});
	sU.height(sAH).width(sAW);
	sD.height(sAH).width(sAW);
	sS.width(sSW);
	if(opts.monitor) passive(sC);
	testheight(false);//初始化
	//滑条
	sS.bind('mousedown',function(e){
		var pageY = e.pageY,
			 topCur=parseFloat($(this).css('top')),
			 Move;
		$(this).addClass('scroll_slider_on');
		$(document).mousemove(function(e2){
			Move = e2.pageY - pageY;
			ssTop=topCur+Move;
			setTop();
			return false;
			});
		$(document).mouseup(function(){
			$(this).unbind();
			sS.removeClass('scroll_slider_on');
			});
		});
	//向上按钮
	sU.bind({
		'mousedown':function(){
			$(this).addClass('scroll_up_on');
			},
		'mouseup':function(){
			ssTop=ssTop-keyway/prop;
			setTop();
			$(this).removeClass('scroll_up_on');
			}
		});
	//向下按钮
	sD.bind({
		'mousedown':function(){
			$(this).addClass('scroll_down_on');
			},
		'mouseup':function(){
			ssTop=ssTop+keyway/prop;
			setTop();
			$(this).removeClass('scroll_down_on')
			}
		});
	//设置top
	function setTop(){	
		if(ssTop<sAH){
			ssTop=sAH
			}else if(ssTop>this_.height()-sAH-sSH){
				ssTop=this_.height()-sAH-sSH
				};
		sS.css({top:ssTop});
		sC.css({top:-((ssTop-sAH)*prop)});
		};
	//高度检测
	function testheight(fromMonitor){
		if(sC.height()>this_.height()) {sB.show();testVal=true}else{sB.hide();testVal=false};
		if (fromMonitor && !testVal) return;
		//滑块高度
		sSH=!!sS.height()?sS.height():parseInt(this_.height())*parseInt(this_.height())/parseInt(sC.height());
		sS.height(sSH);
		//计算prop
		if(sC.find('img').length && !fromMonitor){//如果有图片而且是初次执行，等待load后再计算prop以得到正确的结果			
			$(function(){
				prop=(sC.height()-this_.height())<0 ? 0 : (sC.height()-this_.height())/(this_.height()-sAH*2-sSH);
				setTop();
				});
			}else{	//没有图片或是有图片但并非初次执行不需要等待load，可以立即计算prop
				prop=(sC.height()-this_.height())<0 ? 0 : (sC.height()-this_.height())/(this_.height()-sAH*2-sSH);
				setTop();
				};
		//滚轮事件
		testHandler = addEvent(testMe, 'mousewheel', function(e) {
			e = e || event;
			if(sC.height()>this_.height()) {
				var delta = e.wheelDelta ? e.wheelDelta/3  :  -e.detail*10;
				if (e.preventDefault) {e.preventDefault()}else{e.returnValue = false};
				ssTop-=delta;
				setTop();
				}else{
					ssTop=0;
					setTop();
					if(!testVal){
						delEvent(testMe, 'mousewheel', testHandler);
						}
					}
				})
			};
	//内容监听
	function passive(sC){
		var scTop,_ssTop,_ssH=sC.height();
		setInterval(function(event){
			_ssTop=parseFloat(sC.css('top'));
			if(scTop != _ssTop){//内容定位驱动滑条定位
				sS.css({top:sAH-_ssTop/prop});
				scTop = _ssTop
				};
			if(sC.height() != _ssH){
				testheight(true);//传值区分来自监听的高度检测
				_ssH=sC.height()
				}
			},16)
		}
	};
})