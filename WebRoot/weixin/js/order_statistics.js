$(function(){
	//返回键
	$('.back').on('tap',function(){
		window.history.back();
	})
	//main部分滑动控制
	var windowHeight = $(window).height(),
	footerHeight = window.getComputedStyle(document.getElementsByClassName('footer')[0]).height,
	headerHeight = window.getComputedStyle(document.getElementsByClassName('header')[0]).height,
	navHeight = window.getComputedStyle(document.getElementsByClassName('nav')[0]).height,
	mainHeight = windowHeight - parseFloat(footerHeight) - parseFloat(headerHeight) - parseFloat(navHeight);
	$('.main').css('height',mainHeight+'px');
	//上拉加载mui
	mui.init({
		pullRefresh: {
			container: '#main',
			up: {
				contentrefresh: '正在加载...',
				callback: pullupRefresh
			}
		}
	});
	/**
	 * 上拉加载具体业务实现
	 */
	var count = 0;
	function pullupRefresh() {
		mui('#main').pullRefresh().endPullupToRefresh((++count > 2)); //参数为true代表没有更多数据了。
		var resultAll = $('#list');
		var resultDetail = $('.section');
		for (var i = 0, len=10; i < len; i++) {
			var li = document.createElement('li');
			li.className = 'section';
			li.innerHTML = '<div class="salesman_info fix">'+
						'<div class="img_box l"><i class="ion">&#xe60d;</i></div>'+
						'<div class="info l">'+
							'<p class="name">李华</p>'+
							'<p class="tel">18800001234</p>'+
						'</div>'+
					'</div>'+
					'<div class="order_count fix">'+
						'<div class="order_sep l">'+
							'<a href="javascript:void(0);" class="dib">'+
								'<p class="num">150</p>'+
								'<p class="kind">未处理</p>'+
							'</a>'+
						'</div>'+
						'<div class="order_sep l">'+
							'<a href="javascript:void(0);" class="dib">'+
								'<p class="num">150</p>'+
								'<p class="kind">跟踪中</p>'+
							'</a>'+
						'</div>'+
						'<div class="order_sep l">'+
							'<a href="javascript:void(0);" class="dib">'+
								'<p class="num">150</p>'+
								'<p class="kind">成交</p>'+
							'</a>'+
						'</div>'+
						'<div class="order_sep l">'+
							'<a href="javascript:void(0);" class="dib">'+
								'<p class="num">150</p>'+
								'<p class="kind">流失</p>'+
							'</a>'+
						'</div>'+
						'<div class="order_sep l">'+
							'<a href="javascript:void(0);" class="dib">'+
								'<p class="num">150</p>'+
								'<p class="kind">星标客户</p>'+
							'</a>'+
						'</div>'+
					'</div>'
			resultAll.append(li);
		}
		$('.mui-pull-bottom-pocket').remove();
		$('.mui-scrollbar').remove();
	}
	//进页面首次加载一次数据
	pullupRefresh();
})