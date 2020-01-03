$(function(){
	$('body').height($(window).height());
	/**
	 * 背景图控制
	 */
	var bg = $('<div></div>')
	.addClass('rollbg')
	.css({
		'width':$(window).height(),
		'height':$(window).height(),
		'position':'fixed',
		'left':'50%',
		'margin-left':'-'+$(window).height()/2+'px',
		'z-index':'1',
		'background-image':'url(images/star.png)',
		'background-size':'100% 100%',
		'top':'0'
	})
	.appendTo($('body'));
	
	/**
	 * 提示框 开启/关闭
	 */
	$('.close_it').on('click',function(){
		$(this).parents('.tip_mask').fadeOut(function(){
			$(this).addClass('hide');
		});
	})
	
	$('#ranking').on('click',function(){
		$('.el').html('该活动8月6号上线，敬请期待！');
		$('.tip_mask').fadeIn().removeClass('hide');
	})
	$('#adv').on('click',function(){
		$('.el').html('该活动8月6号上线，敬请期待！');
		$('.tip_mask').fadeIn().removeClass('hide');
	})
	$('#letter').on('click',function(){
		$('.el').html('敬请期待！');
		$('.tip_mask').fadeIn().removeClass('hide');
	})
	
	/**
	 * 留言滚动
	 */
	var lyHei = $('.roll_line').height(),
	lyLen = $('.roll_main').find('.roll_line').length,
	lyCount = 0;
	var lyRoll = setInterval(function(){
		if(lyCount==lyLen){
			lyCount=0;
			$('.roll_main').css({
				'margin-top':'0px'
			})
			return false;
		}
		$('.roll_main').animate({
			'margin-top':'-'+lyCount*lyHei+'px'
		},500)
		lyCount++;
	},Math.floor(Math.random()*3000+1000))
	
	
	/**
	 * 流星效果
	 */
	var light = setInterval(function(){
		var elem = $('<div></div>')
		.addClass('light')
		.addClass('pa')
		.css({
			'width':Math.floor(Math.random()*35+20)+'%',
			'top':'-'+3*Math.random()+'rem',
			'left':'-'+3*Math.random()+'rem'
		})
		.html('<img src="images/light_index.png"/>')
		.appendTo($('body'))
		.animate({
			'top':Math.floor(Math.random()*5+3)+'rem',
			'left':Math.floor(Math.random()*5+3)+'rem',
			'opacity':'0'
		},3000*Math.random(),function(){
			$(this).remove();
		})
	},500)

	
	
})