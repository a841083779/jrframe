/**
 * videolist
 */
define(function(require) {
   var $ = require('$');
	var base=require('base');
	require('./common');

	var player=require('modules/youkuPlayer');
	
	//弹出播放
	require.async('modules/box',function(){
		$('#videoPlay').find('a').on('click',function(e){
			if($(this).data('v')){
				e.preventDefault();
				var swfSrc=$(this).data('v');
				$.box(player(swfSrc,550,400),{
					style:"box2.css",
					bar:false
					})
				}
			})
		});
	
	
		
})

