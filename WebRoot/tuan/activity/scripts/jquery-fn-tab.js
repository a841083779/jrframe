﻿jQuery.fn.tabs = function(tabList, tabTxt, options) {
    var _tabList = jQuery(this).find(tabList);
    var _tabTxt = jQuery(this).find(tabTxt);

    //为了简化操作，强制规定选项卡必须用li标签实现

    var tabListLi = _tabList.find("li");
    var defaults = { currentTab: 0, defaultClass: "current", isAutoPlay: false, stepTime: 2000, switchingMode: "c" };
    var o = jQuery.extend({}, defaults, options);
    var _isAutoPlay = o.isAutoPlay;
    var _stepTime = o.stepTime;
    var _switchingMode = o.switchingMode;
    _tabList.find("li:eq(" + o.currentTab + ")").addClass(o.defaultClass);

    //强制规定内容层必须以div来实现
    _tabTxt.children("div").each(function(i) {
        jQuery(this).attr("id", "wp_div" + i);
    }).eq(o.currentTab).css({ "display": "block" });


    tabListLi.each(
		function(i) {
		    jQuery(tabListLi[i]).mouseover(
				function() {
				    if (_switchingMode == "o") {
				        jQuery(this).click();
				    }
				    _isAutoPlay = false;
				}
			);
		    jQuery(tabListLi[i]).mouseout(
				function() {
				    _isAutoPlay = true;
				}
			)
		}
	);

    _tabTxt.each(
		function(i) {
		    jQuery(_tabTxt[i]).mouseover(
				function() {
				    _isAutoPlay = false;
				}
			);
		    jQuery(_tabTxt[i]).mouseout(
				function() {
				    _isAutoPlay = true;
				}
			)
		});

    // }
    //    else {
    tabListLi.each(
		function(i) {
		    jQuery(tabListLi[i]).click(
				function() {
				    if (jQuery(this).className != o.defaultClass) {
				        jQuery(this).addClass(o.defaultClass).siblings().removeClass(o.defaultClass);
				    }
				    if (jQuery.browser.msie) {
				        _tabTxt.children("div").eq(i).siblings().css({ "display": "none" });
				        _tabTxt.children("div").eq(i).fadeIn(600);
				    } else {
				        _tabTxt.children("div").eq(i).css({ "display": "block" }).siblings().css({ "display": "none" }); //标准样式
				    }


				}
			)
		}
	);

    // }
    function selectMe(oo) {

        if (oo != null && oo.html() != null && _isAutoPlay) {
            oo.click();
        }
        if (oo.html() == null) {
            selectMe(_tabList.find("li").eq(0));

        } else {
            window.setTimeout(selectMe, _stepTime, oo.next());
        }
    }
    if (_isAutoPlay) {
        //alert("_isAutoPlay:" + _isAutoPlay);
        selectMe(_tabList.find("li").eq(o.currentTab));
    }
    //alert(_isAutoPlay);
    return this;
};





//*=============================================================
//*   功能： 修改 window.setInterval ，使之可以传递参数和对象参数   
//*   方法： setInterval (回调函数,时间,参数1,,参数n)  参数可为对象:如数组等
//*=============================================================

var __sto = setTimeout;
window.setTimeout = function(callback, timeout, param) {
    var args = Array.prototype.slice.call(arguments, 2);
    var _cb = function() {
        callback.apply(null, args);
    }
    __sto(_cb, timeout);
}


jQuery(document).ready(function() {
    jQuery("#prorec").tabs(".Tab01Title", ".Tab01Box", { currentTab: 0, switchingMode: 'c' });
    jQuery("#prorec").find(".Tab02").tabs(".Tab02Title", ".Tab02Box", { currentTab: 0, isAutoPlay: false });
});


