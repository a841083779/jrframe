/**
 * index
 */
define(function(require) {
  var $ = require('jquery');
  var base=require('base');
  require('./common');

	(function (win, doc) {
		var docEl = doc.documentElement,
		resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
		setFontSize = function () {
			var clientWidth = docEl.clientWidth;
			if (!clientWidth) return;
			    docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
			};
			if (!doc.addEventListener) return;
			win.addEventListener(resizeEvt, setFontSize, false);
			doc.addEventListener('DOMContentLoaded', setFontSize, false);
			if (/Android (\d+\.\d+)/.test(navigator.userAgent)) {
        win.addEventListener(resizeEvt, function () {
            clearTimeout(timer);
            timer = setTimeout(setFontSize, 300);
        }, false);
        win.addEventListener("pageshow", function(e) {
            if (e.persisted) {
                clearTimeout(timer);
                timer = setTimeout(setFontSize, 300);
            }
        }, false);
			  setFontSize();
			} 
		})(window,document);

})

