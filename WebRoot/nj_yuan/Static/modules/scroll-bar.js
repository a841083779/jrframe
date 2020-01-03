/*
 * name:scrollBar
 * vertion: v2.0.2
 * update: scroll_c改成scroll_cont，避免冲突
 * date: 2015-06-06
 */
define('scroll-bar', function(require, exports, module) {
    var $ = require('jquery');
    var base = require('base');
    seajs.importStyle('.scroll_cont{position:relative}.scroll_bar{position:absolute;z-index:8;overflow:hidden;cursor:default;-moz-user-select:none;opacity:0;background:#efefef;transition:opacity ease .3s}.scrollBar-ui-hover .scroll_bar{opacity:1}.scroll_up,.scroll_down{position:absolute;left:0;overflow:hidden;background:black;*zoom:1}.scroll_up{top:0}.scroll_down{bottom:0}.scroll_up_on,.scroll_down_on{background:#ccc}.scroll_slider{position:absolute;left:0;cursor:default;border-radius:4px;background:#666}.scroll_slider_on{background:#ccc}', module.uri)

    require('mousewheel');
    var isFirefox = typeof document.body.style.MozUserSelect != 'undefined',
        def = {
            wrap: null, //包裹元素，默认不指定，将新增div.scroll_cont
            monitor: false, //监听内容变化（用于多插件协作），布尔值，默认false
            overflow: "y", //滚动条方向，默认"y"(纵向)，可选"x"(横向)
            keyway: 30, //键程，默认30（px）
            width: 8, //滚动条宽度，默认8（px）
            btnLength: 0, //按钮长度，默认0（不显示按钮）
            btnBreadth: '100%', //按钮宽度，默认与滚动条同宽
            sliderWidth: '100%', //滑块宽度，默认与滚动条同宽
            hideBar: false //自动隐藏滚动条
        };

    $.fn.scrollBar = function(config) {

        if (base.browser.isMobile) {
            $(this).css({
                'overflow': 'auto',
                '-webkit-overflow-scrolling': 'touch'
            });
            return $(this);
        };

        return $(this).each(function(i, e) {
            if ($(e).data('scrollBar')) {
                return;
            }
            var $this = $(e).data('scrollBar', true).fadeIn(320),
                scrollCont, sliderBar, sliderLength, prop, wheelHandler, init, passive, setSlider,
                _length, _breadth, _posiLength, _posiBreadth, _scrollContLength, thisLength,
                sliderGone = 0,
                testVal = false,
                sliderBar = $("<div class='scroll_bar' onselectstart='return false;'>\
                        <div class='scroll_up'><!----></div>\
                        <div class='scroll_slider' unselectable='on'><!----></div>\
                        <div class='scroll_down'><!----></div>\
                    </div>"),
                btnUp = sliderBar.children('.scroll_up'),
                btnDown = sliderBar.children('.scroll_down'),
                scrollSlider = sliderBar.children('.scroll_slider'),
                opt = $.extend({}, def, config || {}, $this.data('config') || {});

            if ($this.find(opt.wrap).size()) {
                scrollCont = $this.find(opt.wrap);
            } else {
                $this.wrapInner("<div class='scroll_cont'></div>");
                scrollCont = $this.children('.scroll_cont');
            };
            $this.append(sliderBar);
            if (opt.hideBar) {
                $this.on({
                    'mouseenter': function() {
                        $(this).addClass('scrollBar-ui-hover');
                    },
                    'mouseleave': function() {
                        $(this).removeClass('scrollBar-ui-hover');
                    }
                })
            } else {
                $this.addClass('scrollBar-ui-hover');
            }
            //预处理
            switch (opt.overflow) {
                case 'x':
                    _length = "width"
                    _breadth = "height"
                    _posiLength = "left"
                    _posiBreadth = "bottom"
                    break;
                case 'y':
                    _length = "height"
                    _breadth = "width"
                    _posiLength = "top"
                    _posiBreadth = "right"
                    break;
            };
            thisLength = parseFloat($this.css(_length));
            sliderBar.
                css(_length, "100%").
                css(_breadth, opt.width).
                css(_posiBreadth, 0).
                css(_posiLength, 0);
            btnUp.
                css(_length, opt.btnLength).
                css(_breadth, opt.btnBreadth);
            btnDown.
                css(_length, opt.btnLength).
                css(_breadth, opt.btnBreadth);
            scrollSlider.
                css(_breadth, opt.sliderWidth).
                css(_posiBreadth, 0).
                css(_posiLength, 0);

            scrollSlider.bind('mousedown', function(e) {
                var pageLength, topCur, Move,
                    docMouseMove = function(e2) {
                        if (opt.overflow === 'y') {
                            Move = e2.pageY - pageLength;
                        } else {
                            Move = e2.pageX - pageLength;
                        };
                        sliderGone = topCur + Move;
                        setSlider();
                        return false;
                    },
                    docMouseUp = function() {
                        $(document)
                            .unbind('mousemove', docMouseMove)
                            .unbind('mouseup', docMouseUp);
                        scrollSlider.removeClass('scroll_slider_on');
                    };
                if (opt.overflow === 'y') {
                    pageLength = e.pageY
                } else {
                    pageLength = e.pageX
                };
                topCur = parseFloat($(this)._css(_posiLength));

                $(this).addClass('scroll_slider_on');
                $(document)
                    .bind('mousemove', docMouseMove)
                    .bind('mouseup', docMouseUp);
            });
            btnUp.bind({
                'mousedown': function() {
                    $(this).addClass('scroll_up_on');
                },
                'mouseup': function() {
                    sliderGone = sliderGone - opt.keyway / prop;
                    setSlider();
                    $(this).removeClass('scroll_up_on');
                }
            });
            btnDown.bind({
                'mousedown': function() {
                    $(this).addClass('scroll_down_on');
                },
                'mouseup': function() {
                    sliderGone = sliderGone + opt.keyway / prop;
                    setSlider();
                    $(this).removeClass('scroll_down_on')
                }
            });
            setSlider = function() {
                if (sliderGone < opt.btnLength) {
                    sliderGone = opt.btnLength
                } else if (sliderGone > thisLength - opt.btnLength - sliderLength) {
                    sliderGone = thisLength - opt.btnLength - sliderLength
                };
                scrollSlider._css(_posiLength, sliderGone);
                scrollCont._css(_posiLength, -((sliderGone - opt.btnLength) * prop));
            };
            init = function(fromMonitor) {
                var _scrollContClone;
                if (opt.overflow === 'x') {
                    _scrollContClone = scrollCont.clone().css('position', 'absolute').appendTo('body');
                    _scrollContLength = parseFloat(_scrollContClone.css(_length));
                } else {
                    _scrollContLength = parseFloat(scrollCont.css(_length));
                }
                _scrollContClone && _scrollContClone.remove();

                if (_scrollContLength > thisLength) {
                    //计算滚动条长度
                    sliderLength = parseFloat(scrollSlider.css(_length)) ?
                        parseFloat(scrollSlider.css(_length)) :
                        Math.round(thisLength / _scrollContLength * thisLength);

                    sliderBar.show();
                    testVal = true;
                } else {
                    sliderBar.hide();
                    testVal = false;
                };
                if (fromMonitor && !testVal) return;

                scrollSlider.css(_length, sliderLength);
                prop = (_scrollContLength - thisLength) < 0 ? 0 :
                    (_scrollContLength - thisLength) / (thisLength - opt.btnLength * 2 - sliderLength);

                setSlider();
                //滚轮事件
                wheelHandler = function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    if (_scrollContLength > thisLength) {
                        var delta = e.deltaY * opt.keyway;
                        sliderGone -= delta;
                        setSlider();
                    } else {
                        sliderGone = 0;
                        setSlider();
                        if (!testVal) {
                            $this.off('mousewheel');
                        }
                    }
                }
                $this.on('mousewheel', wheelHandler);
            };
            //监听
            passive = function(scrollCont) {
                var scTop, _sliderGone, _ssH = _scrollContLength;
                setInterval(function(event) {
                    //内容定位改变
                    _sliderGone = scrollCont._css(_posiLength);
                    if (scTop != _sliderGone) {
                        scrollSlider._css(_posiLength, opt.btnLength - _sliderGone / prop);
                        scTop = _sliderGone;
                    };
                    //内容高度改变
                    if (parseFloat(scrollCont.css(_length)) != _ssH) {
                        init(true); //区分来自监听的初始化
                        _ssH = parseFloat(scrollCont.css(_length));
                    }
                }, 160)
            };

            //初始化
            if (scrollCont.find('img').size()) {
                require.async('img-loaded', function() {
                    scrollCont.imagesLoaded(function() {
                        init(false);
                        if (opt.monitor) passive(scrollCont);
                    })
                })
            } else {
                init(false);
                if (opt.monitor) passive(scrollCont);
            };

        })
    };
})