/*
imgAuto

v.09

*/
define(function(require) {
   var $ = require('$');
	var base=require('base');


$.fn.imgAuto=function(callback){
	if(!$(this).find('img').length) return;
	var this_=$(this),
		 img_=this_.find('img').eq(0),
		 $src=img_.attr('src'),
		 $prop=Math.floor(this_.width()/this_.height()*100)/100,
		 showAuto=setTimeout(function(){
			 img_.css('opacity',1);
			 console.log('false')
			 },2000),
		 _thisH=this_.height()+'px';

	if(base.ie6){
		img_.after('<s style="display:inline-block;width:0;height:100%;overflow:hidden;vertical-align:middle;" />')
		};
	this_.css({'text-align':'center','line-height':_thisH,'overflow':'hidden'});
	img_.css({'opacity':0,'display':'inline-block','vertical-align':'middle'});
	
	require.async('modules/img-ready',function(imgReady){
		imgReady($src, function (width, height) {
			var $myprop=Math.floor(width/height*100)/100;
			clearTimeout(showAuto);
			if(width>this_.width()||height>this_.height()){
				if($myprop>=$prop){
					img_.width(this_.width());
					}else{
						img_.height(this_.height())
						};
				if(callback) callback();
			}else{
				if(callback) callback();
			}
		},function(){
			if(base.ie6 || base.ie7 || base.ie8){
				img_.css('opacity',1)
				}else{
					img_.animate({opacity:1},250)
				};
			});
		})
	};
	
})