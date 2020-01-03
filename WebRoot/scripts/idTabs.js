﻿(function() {
    var init = function() { (function($) {
            $.fn.idTabs = function() {
                var s = {};
                for (var i = 0; i < arguments.length; ++i) {
                    var a = arguments[i];
                    switch (a.constructor) {
                    case Object:
                        $.extend(s, a);
                        break;
                    case Boolean:
                        s.change = a;
                        break;
                    case Number:
                        s.start = a;
                        break;
                    case Function:
                        s.click = a;
                        break;
                    case String:
                        if (a.charAt(0) == '.') s.selected = a;
                        else if (a.charAt(0) == '!') s.event = a;
                        else s.start = a;
                        break;
                    }
                }
                if (typeof s['return'] == "function") s.change = s['return'];
                return this.each(function() {
                    $.idTabs(this, s);
                });
            }
            $.idTabs = function(tabs, options) {
                var meta = ($.metadata) ? $(tabs).metadata() : {};
                var s = $.extend({},
                $.idTabs.settings, meta, options);
                if (s.selected.charAt(0) == '.') s.selected = s.selected.substr(1);
                if (s.event.charAt(0) == '!') s.event = s.event.substr(1);
                if (s.start == null) s.start = -1;
                var showId = function() {
                    if ($(this).is('.' + s.selected)) return s.change;
                    var id = "#" + this.href.split('#')[1];
                    var aList = [];
                    var idList = [];
                    $("a", tabs).each(function() {
                        if (this.href.match(/#/)) {
                            aList.push(this);
                            idList.push("#" + this.href.split('#')[1]);
                        }
                    });
                    if (s.click && !s.click.apply(this, [id, idList, tabs, s])) return s.change;
                    for (i in aList) $(aList[i]).removeClass(s.selected);
                    for (i in idList) $(idList[i]).hide();
                    $(this).addClass(s.selected);
                    $(id).show();
					if(id.indexOf("1") < 0){
						$(id).load("/ajax/"+id.replace("#","")+".htm");
					}
                    return s.change;
                }
                var list = $("a[href*='#']", tabs).unbind(s.event, showId).bind(s.event, showId);
                list.each(function() {
                    $("#" + this.href.split('#')[1]).hide();
                });
                var test = false;
                if ((test = list.filter('.' + s.selected)).length);
                else if (typeof s.start == "number" && (test = list.eq(s.start)).length);
                else if (typeof s.start == "string" && (test = list.filter("[href*='#" + s.start + "']")).length);
                if (test) {
                    test.removeClass(s.selected);
                    test.trigger(s.event);
                }
                return s;
            }
            $.idTabs.settings = {
                start: 0,
                change: false,
                click: null,
                selected: ".selected",
                event: "!click"
            };
            $.idTabs.version = "2.2";
            $(function() {
                $(".idTabs").idTabs();
            });
        })(jQuery);
    }
    return init();
})();