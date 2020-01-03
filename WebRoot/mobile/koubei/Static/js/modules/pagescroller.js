define(function(require, exports, module) {
   var $ = require('$');

var pageScroller = {};
(function (e) {
    e.fn.extend({
        pageScroller: function (j) {
            j = e.extend({
                currentSection: 0,
                sectionClass: "section",
                linkClass: "link",
                navigation: [],
                navigationClass: "standardNav light",
                navigationLabel: "Navigation",
                animationSpeed: 500,
                animationType: "swing",
                scrollOffset: 0,
                HTML5mode: !1,
                deepLink: !1,
                keyboardControl: !0,
                animationBefore: function () {},
                animationComplete: function () {},
                onChange: function () {}
            }, j);
            pageScroll = function (a, c) {
                e.fx.interval = 5;
                pageScroller.scrollDocument = e(document);
                pageScroller.scrollWindow = e(window);
                pageScroller.scrollBody = e("body");
                pageScroller.scrollPosition = pageScroller.scrollWindow.scrollTop();
                pageScroller.currentSectionHeight = pageScroller.scrollWindow.height();
                pageScroller.options = c;
                pageScroller.options.scrollOffset = parseInt(pageScroller.options.scrollOffset);
                var d = "div";
                c.HTML5mode && (d = "nav");
                pageScroller.options.navigation instanceof Array && (a.append("<" + d + ' class="pageScrollerNav ' + c.navigationClass + '"><ul></ul></' + d + ">"), pageScroller.wrapper = e("." + c.navigationClass.replace(/\s/g, "."), a), pageScroller.navigation = e("ul", pageScroller.wrapper), pageScroller.wrapper.addClass("left"), a.css({
                    position: "relative"
                }));
                c.HTML5mode ? pageScroller.sections = e("section", a) : pageScroller.sections = e("." + c.sectionClass, a);
                pageScroller.sections.each(function (b) {
                    var a = e(this),
                        d = pageScroller.sections.eq(b).attr("title"),
                        f = c.linkClass + " " + c.linkClass + "_" + (b + 1);
                    b == pageScroller.sections.length - 1 && (f += " " + c.linkClass + "_last");
                    a.css({
                        display: "block",
                        position: "relative",
                        "float": "none"
                    });
                    a.addClass(pageScroller.options.sectionClass + "_" + (b + 1));
                    pageScroller.options.navigation instanceof Array ? pageScroller.options.navigation.length ? pageScroller.navigation.append('<li class="' + f + '"><a href="#pageScroll' + b + '">' + pageScroller.options.navigation[b] + "</a></li>") : d && "" != d ? pageScroller.navigation.append('<li class="' + f + '"><a href="#pageScroll' + b + '">' + d + "</a></li>") : pageScroller.navigation.append('<li class="' + f + '"><a href="#pageScroll' + b + '">Navigation ' + (b + 1) + "</a></li>") : pageScroller.navigation = e(pageScroller.options.navigation)
                });
                pageScroller.pageLinks = e("a", pageScroller.navigation);
                pageScroller.pageLinks.each(function (b) {
                    e(this).bind("click", function (d) {
                        d.preventDefault();
                        c.animationBefore();
                        pageScroller.scrollBody.is(":animated") || (pageScroller.pageLinks.parent("li").removeClass("active"), e(this).parent("li").addClass("active"));
                        g(a, pageScroller.sections.eq(b), b)
                    })
                });
                pageScroller.next = function () {
                    var b = pageScroller.options.currentSection + 1;
                    if (b != pageScroller.sections.length) {
                        var c = pageScroller.sections.eq(b);
                        g(a, c, b)
                    }
                };
                pageScroller.prev = function () {
                    var b = pageScroller.options.currentSection - 1;
                    0 >= b && (b = 0);
                    var c = pageScroller.sections.eq(b);
                    g(a, c, b)
                };
                pageScroller.goTo = function (b) {
                    var b = b - 1,
                        c = pageScroller.sections.eq(b);
                    g(a, c, b)
                };
                pageScroller.options.keyboardControl && pageScroller.scrollDocument.bind("keydown", function (b) {
                    var a = b.which ? b.which : b.keyCode;
                    if (38 == a || 40 == a) b.preventDefault(), 38 == a ? pageScroller.options.currentSection ? pageScroller.goTo(pageScroller.options.currentSection) : pageScroller.goTo(pageScroller.options.currentSection + 1) : 40 == a && (pageScroller.options.currentSection + 1 == pageScroller.sections.length ? pageScroller.goTo(pageScroller.options.currentSection + 1) : pageScroller.goTo(pageScroller.options.currentSection + 2))
                });
                pageScroller.scrollWindow.bind("scroll", function () {
                    k()
                });
                setTimeout(function () {
                    0 == pageScroller.scrollPosition && l();
                    k()
                }, 200)
            };
            var l = function () {
                    if (pageScroller.options.deepLink) {
                        var a = window.location.hash;
                        a && pageScroller.pageLinks.each(function (c) {
                            var d = pageScroller.pageLinks.eq(c).html(),
                                d = d.replace(/[^a-zA-Z 0-9]+/g, "").replace(/\s+/g, "-").toLowerCase();
                            if (a == "#section-" + d) return pageScroller.goTo(c + 1), !1
                        })
                    }
                },
                k = function () {
                    pageScroller.scrollPosition = pageScroller.scrollWindow.scrollTop();
                    pageScroller.scrollDistance = pageScroller.scrollPosition + pageScroller.currentSectionHeight;
                    for (i = 0; i < pageScroller.sections.length; i++) {
                        var a = pageScroller.sections.eq(i).offset().top;
                        pageScroller.options.scrollOffset && a && (a += parseInt(pageScroller.options.scrollOffset));
                        var c = 0;
                        if (i < pageScroller.sections.length - 1) {
                            var d = pageScroller.sections.eq(i + 1);
                            pageScroller.options.scrollOffset ? c = parseInt(d.offset().top + pageScroller.options.scrollOffset) : c = d.offset().top;
                            var d = pageScroller.pageLinks.eq(i).parent("li"),
                                b = pageScroller.pageLinks.eq(pageScroller.sections.length - 1).parent("li")
                        }
                        if (pageScroller.scrollBody.is(":animated")) return !1;
                        if (pageScroller.scrollDocument.height() == pageScroller.scrollDistance) {
                            if (!b.hasClass("active")) return updateTo = pageScroller.sections.length - 1, h(updateTo), !1
                        } else if (c) {
                            if (pageScroller.scrollPosition >= a && pageScroller.scrollPosition < c && !d.hasClass("active")) return updateTo = i, h(updateTo), !1
                        } else if (pageScroller.scrollPosition >= a && i == pageScroller.sections.length - 1 && !b.hasClass("active")) return updateTo = pageScroller.sections.length - 1, h(updateTo), !1
                    }
                },
                g = function (a, c, d) {
                    var a = e("html, body"),
                        b = e(window).scrollTop(),
                        c = c.offset().top;
                    parseInt(pageScroller.options.scrollOffset) && (c += parseInt(pageScroller.options.scrollOffset));
                    0 > c && (c = 0);
                    c != b && !a.is(":animated") && a.animate({
                        scrollTop: c
                    }, pageScroller.options.animationSpeed, pageScroller.options.animationType).promise().done(function () {
                        h(d);
                        pageScroller.options.animationComplete()
                    })
                },
                h = function (a) {
                    pageScroller.pageLinks.parent("li").removeClass("active");
                    pageScroller.pageLinks.eq(a).parent("li").addClass("active");
                    pageScroller.options.currentSection = a;
                    pageScroller.options.deepLink && (a = pageScroller.pageLinks.eq(a).html(), a = a.replace(/[^a-zA-Z 0-9]+/g, "").replace(/\s+/g, "-").toLowerCase(), window.location.hash = "section-" + a);
                    pageScroller.options.onChange()
                };
            if (!pageScroller.options) return pageScroll(this, j)
        }
    })
})($);

})