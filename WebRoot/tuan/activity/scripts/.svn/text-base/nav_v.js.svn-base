//main nav
jQuery.fn.extend({
	allenMenu: function() {
		jQuery(this).children('ul').children('li').hover(
			function() {
				if(!jQuery(this).children('ul').hasClass('focus')) {
					jQuery(this).addClass('focus');
					jQuery(this).children('ul:first').stop(true, true).animate({ height:'show' }, 'fast');
				}
			},
			function() {
				jQuery(this).removeClass('focus');
				jQuery(this).children('ul:first').stop(true, true).animate({ height:'hide', opacity:'hide' }, 'slow');
			}
		);
		jQuery(this).children('ul').children('li').children('ul').hover(
			function() {
				jQuery(this).addClass('focus');
			},
			function() {
				jQuery(this).removeClass('focus');
			}
		);
	}
});
jQuery(document).ready(function() {
	jQuery('#nav_v').allenMenu();
});
//end of nav