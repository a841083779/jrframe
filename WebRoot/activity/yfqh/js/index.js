/*
* name: index.js
*/

!
function($, window){
	
	//加载
	var viewHeight = $(window).height();
	var $loading = $('#loading');
	loadingFn({
		parent : $('.page-bg'),
		src : 'static/images/bg.jpg',
		callback : function(oImg) {
			$loading.remove();
			
			$('.page-bg').height(viewHeight - 48);
			var w = oImg.offsetWidth;
			oImg.style.marginLeft = - w / 2 + 'px';
			$(window).resize(function(e) {
			  var w = oImg.offsetWidth;
			oImg.style.marginLeft = - w / 2 + 'px';
                });
			}
		});
	
	function loadingFn(obj) {
		var bgImg = new Image();
		bgImg.onload = function() {
			bgImg = null;
			
			var oImg = document.createElement('img');
			oImg.src = this.src;
			obj.parent.append(oImg);
			
			if(obj.callback instanceof Function){
				obj.callback(oImg);
				}
			};
		bgImg.src = obj.src;
		
		}
	
	
	}(jQuery, window),

function($){
	
	//brand-list
	var rate = $('.brand-list').height() / 920;
	var listWidth = 1150 * rate;
	$('.brand-list').width(listWidth);
	$('.brand-list').css('margin-left', - listWidth / 2);
	
	}(jQuery),

function($){
	
	//brand
	$('.brand-list .brand-ele, .brand-list .brand-sg-zb').on('click', function() {
		var brand = $(this).data('brand');
		
		$('.mask').fadeIn(300).children().css('display', 'none');
		$('.' + brand + '-layer').css('display', 'block');
		
		});
	
	$('.close-layer').on('click', function() {
		$('.mask').fadeOut(300);
		});
	
	}(jQuery);