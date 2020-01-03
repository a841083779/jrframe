/*
 * name: superscrollorama.js
 * version: v0.0.1
 * update: https://github.com/johnpolacek/superscrollorama
 * date: 2016-07-18
 */
define('superscrollorama', function(require, exports, module) {
  var $ = require('jquery');
  (function($){$.superscrollorama=function(options){var superscrollorama={};var defaults={isVertical:true,triggerAtCenter:true,playoutAnimations:true,reverse:true};superscrollorama.settings=$.extend({},defaults,options);var $window=$(window);var animObjects=[],pinnedObjects=[],scrollContainerOffset={x:0,y:0},doUpdateOnNextTick=false,targetOffset,i;function init(){$window.scroll(function(){doUpdateOnNextTick=true;});TweenLite.ticker.addEventListener("tick",tickHandler);}
  function cssNumericPosition($elem){var obj={top:parseFloat($elem.css("top")),left:parseFloat($elem.css("left"))};if(isNaN(obj.top)){obj.top=0;}
  if(isNaN(obj.left)){obj.left=0;}
  return obj;}
  function tickHandler(){if(doUpdateOnNextTick){checkScrollAnim();doUpdateOnNextTick=false;}}
  function resetPinObj(pinObj){pinObj.el.css('position',pinObj.origPositioning.pos);pinObj.el.css('top',pinObj.origPositioning.top);pinObj.el.css('left',pinObj.origPositioning.left);}
  function setTweenProgress(tween,progress){if(tween){if(tween.totalProgress){tween.totalProgress(progress).pause();}else{tween.progress(progress).pause();}}}
  function checkScrollAnim(){var currScrollPoint=superscrollorama.settings.isVertical?$window.scrollTop()+scrollContainerOffset.y:$window.scrollLeft()+scrollContainerOffset.x;var offsetAdjust=superscrollorama.settings.triggerAtCenter?(superscrollorama.settings.isVertical?-$window.height()/2:-$window.width()/2):0;var i,startPoint,endPoint;var numAnim=animObjects.length;for(i=0;i<numAnim;i++){var animObj=animObjects[i],target=animObj.target,offset=animObj.offset;if(typeof(target)==='string'){targetOffset=$(target).offset()||{};startPoint=superscrollorama.settings.isVertical?targetOffset.top+scrollContainerOffset.y:targetOffset.left+scrollContainerOffset.x;offset+=offsetAdjust;}else if(typeof(target)==='number'){startPoint=target;}else if($.isFunction(target)){startPoint=target.call(this);}else{targetOffset=target.offset();startPoint=superscrollorama.settings.isVertical?targetOffset.top+scrollContainerOffset.y:targetOffset.left+scrollContainerOffset.x;offset+=offsetAdjust;}
  startPoint+=offset;endPoint=startPoint+animObj.dur;if((currScrollPoint>startPoint&&currScrollPoint<endPoint)&&animObj.state!=='TWEENING'){animObj.state='TWEENING';animObj.start=startPoint;animObj.end=endPoint;}
  if(currScrollPoint<startPoint&&animObj.state!=='BEFORE'&&animObj.reverse){if(superscrollorama.settings.playoutAnimations||animObj.dur===0){animObj.tween.reverse();}else{setTweenProgress(animObj.tween,0);}
  animObj.state='BEFORE';}else if(currScrollPoint>endPoint&&animObj.state!=='AFTER'){if(superscrollorama.settings.playoutAnimations||animObj.dur===0){animObj.tween.play();}else{setTweenProgress(animObj.tween,1);}
  animObj.state='AFTER';}else if(animObj.state==='TWEENING'){var repeatIndefinitely=false;if(animObj.tween.repeat){repeatIndefinitely=(animObj.tween.repeat()===-1);}
  if(repeatIndefinitely){var playheadPosition=animObj.tween.totalProgress();if(animObj.playeadLastPosition===null||playheadPosition===animObj.playeadLastPosition){if(playheadPosition===1){if(animObj.tween.yoyo()){animObj.tween.reverse();}else{animObj.tween.totalProgress(0).play();}}else{animObj.tween.play();}}
  animObj.playeadLastPosition=playheadPosition;}else{setTweenProgress(animObj.tween,(currScrollPoint-animObj.start)/(animObj.end-animObj.start));}}}
  var numPinned=pinnedObjects.length;for(i=0;i<numPinned;i++){var pinObj=pinnedObjects[i];var el=pinObj.el;if(pinObj.state!=='PINNED'){var pinObjSpacerOffset=pinObj.spacer.offset();if(pinObj.state==='UPDATE'){resetPinObj(pinObj);}
  startPoint=superscrollorama.settings.isVertical?pinObjSpacerOffset.top+scrollContainerOffset.y:pinObjSpacerOffset.left+scrollContainerOffset.x;startPoint+=pinObj.offset;endPoint=startPoint+pinObj.dur;var jumpedPast=((currScrollPoint>endPoint&&pinObj.state==='BEFORE')||(currScrollPoint<startPoint&&pinObj.state==='AFTER'));var inPinAra=(currScrollPoint>startPoint&&currScrollPoint<endPoint);if(inPinAra||jumpedPast){if(pinObj.pushFollowers&&el.css('position')==="static"){el.css('position',"relative");}
  pinObj.origPositioning={pos:el.css('position'),top:pinObj.spacer.css('top'),left:pinObj.spacer.css('left')};pinObj.fixedPositioning={top:superscrollorama.settings.isVertical?-pinObj.offset:pinObjSpacerOffset.top,left:superscrollorama.settings.isVertical?pinObjSpacerOffset.left:-pinObj.offset};el.css('position','fixed');el.css('will-change','top');el.css('top',pinObj.fixedPositioning.top);el.css('left',pinObj.fixedPositioning.left);pinObj.pinStart=startPoint;pinObj.pinEnd=endPoint;if(pinObj.pushFollowers){if(superscrollorama.settings.isVertical){pinObj.spacer.height(pinObj.dur+el.outerHeight(true));}else{pinObj.spacer.width(pinObj.dur+el.outerWidth(true));}}else{if(pinObj.origPositioning.pos==="absolute"){pinObj.spacer.width(0);pinObj.spacer.height(0);}else{if(superscrollorama.settings.isVertical){pinObj.spacer.height(el.outerHeight(true));}else{pinObj.spacer.width(el.outerWidth(true));}}}
  if(pinObj.state==="UPDATE"){if(pinObj.anim){setTweenProgress(pinObj.anim,0);}}else if(pinObj.onPin){pinObj.onPin(pinObj.state==="AFTER");}
  pinObj.state='PINNED';}}
  if(pinObj.state==='PINNED'){if(currScrollPoint<pinObj.pinStart||currScrollPoint>pinObj.pinEnd){var before=currScrollPoint<pinObj.pinStart;pinObj.state=before?'BEFORE':'AFTER';setTweenProgress(pinObj.anim,before?0:1);var spacerSize=before?0:pinObj.dur;if(superscrollorama.settings.isVertical){pinObj.spacer.height(pinObj.pushFollowers?spacerSize:0);}else{pinObj.spacer.width(pinObj.pushFollowers?spacerSize:0);}
  var deltay=pinObj.fixedPositioning.top-cssNumericPosition(pinObj.el).top;var deltax=pinObj.fixedPositioning.left-cssNumericPosition(pinObj.el).left;resetPinObj(pinObj);if(!pinObj.pushFollowers||pinObj.origPositioning.pos==="absolute"){var pinOffset;if(pinObj.origPositioning.pos==="relative"){pinOffset=superscrollorama.settings.isVertical?parseFloat(pinObj.origPositioning.top):parseFloat(pinObj.origPositioning.left);if(isNaN(pinOffset)){pinOffset=0;}}else{pinOffset=superscrollorama.settings.isVertical?pinObj.spacer.position().top:pinObj.spacer.position().left;}
  var direction=superscrollorama.settings.isVertical?"top":"left";pinObj.el.css(direction,pinOffset+spacerSize);}
  if(deltay!==0){pinObj.el.css("top",cssNumericPosition(pinObj.el).top-deltay);}
  if(deltax!==0){pinObj.el.css("left",cssNumericPosition(pinObj.el).left-deltax);}
  if(pinObj.onUnpin){pinObj.onUnpin(!before);}}else if(pinObj.anim){setTweenProgress(pinObj.anim,(currScrollPoint-pinObj.pinStart)/(pinObj.pinEnd-pinObj.pinStart));}}}}
  superscrollorama.addTween=function(target,tween,dur,offset,reverse){tween.pause();animObjects.push({target:target,tween:tween,offset:offset||0,dur:dur||0,reverse:(typeof reverse!=="undefined")?reverse:superscrollorama.settings.reverse,state:'BEFORE'});return superscrollorama;};superscrollorama.pin=function(el,dur,vars){if(typeof(el)==='string'){el=$(el);}
  var defaults={offset:0,pushFollowers:true};vars=$.extend({},defaults,vars);if(vars.anim){vars.anim.pause();}
  var spacer=$('<div class="superscrollorama-pin-spacer"></div>');spacer.css("position","relative");spacer.css("top",el.css("top"));spacer.css("left",el.css("left"));el.before(spacer);pinnedObjects.push({el:el,state:'BEFORE',dur:dur,offset:vars.offset,anim:vars.anim,pushFollowers:vars.pushFollowers,spacer:spacer,onPin:vars.onPin,onUnpin:vars.onUnpin});return superscrollorama;};superscrollorama.updatePin=function(el,dur,vars){if(typeof(el)==='string'){el=$(el);}
  if(vars.anim){vars.anim.pause();}
  var numPinned=pinnedObjects.length;for(i=0;i<numPinned;i++){var pinObj=pinnedObjects[i];if(el.get(0)===pinObj.el.get(0)){if(dur){pinObj.dur=dur;}
  if(vars.anim){pinObj.anim=vars.anim;}
  if(vars.offset){pinObj.offset=vars.offset;}
  if(typeof vars.pushFollowers!=="undefined"){pinObj.pushFollowers=vars.pushFollowers;}
  if(vars.onPin){pinObj.onPin=vars.onPin;}
  if(vars.onUnpin){pinObj.onUnpin=vars.onUnpin;}
  if((dur||vars.anim||vars.offset)&&pinObj.state==='PINNED'){pinObj.state='UPDATE';checkScrollAnim();}}}
  return superscrollorama;};superscrollorama.removeTween=function(target,tween,reset){var count=animObjects.length;if(typeof reset==="undefined"){reset=true;}
  for(var index=0;index<count;index++){var value=animObjects[index];if(value.target===target&&(!tween||value.tween===tween)){animObjects.splice(index,1);if(reset){setTweenProgress(value.tween,0);}
  count--;index--;}}
  return superscrollorama;};superscrollorama.removePin=function(el,reset){if(typeof(el)==='string'){el=$(el);}
  if(typeof reset==="undefined"){reset=true;}
  var count=pinnedObjects.length;for(var index=0;index<count;index++){var value=pinnedObjects[index];if(value.el.is(el)){pinnedObjects.splice(index,1);if(reset){value.spacer.remove();resetPinObj(value);if(value.anim){setTweenProgress(value.anim,0);}}
  count--;index--;}}
  return superscrollorama;};superscrollorama.setScrollContainerOffset=function(x,y){scrollContainerOffset.x=x;scrollContainerOffset.y=y;return superscrollorama;};superscrollorama.triggerCheckAnim=function(immediately){if(immediately){checkScrollAnim();}else{doUpdateOnNextTick=true;}
  return superscrollorama;};init();return superscrollorama;};})($);
});