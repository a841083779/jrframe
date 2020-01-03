/**
 * videolist
 */
define(function(require) {
	var $ = require('$');
	var base=require('base');
	var com=require('./common');
	//优酷播放器
	var player=require('player');
	
	//弹出播放
	require.async('box',function(){
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

