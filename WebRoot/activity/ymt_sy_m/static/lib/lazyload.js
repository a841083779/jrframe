/*!
 * Lazy Load - jQuery plugin for lazy loading images
 *
 * Copyright (c) 2007-2015 Mika Tuupola
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Project home:
 *   http://www.appelsiini.net/projects/lazyload
 *
 * Version:  1.9.7
 *
 */
(function($, window, document, undefined) {
    var $window = $(window);

    $.fn.lazyload = function(options) {
        var elements = this;
        var $container;
        var settings = {
            threshold       : 0,
            failure_limit   : 0,
            event           : "scroll",
            effect          : "show",
            container       : window,
            data_attribute  : "original",
            skip_invisible  : false,
            appear          : null,
            load            : null,
            placeholder     : "data:image/gif;base64,R0lGODlhpgB4ANUAAK6urq2trcXFxaysrNvb283NzczMzMjIyMTExMPDw9ra2rGxsaurq8fHx9jY2NLS0tnZ2cLCwrCwsK+vr9XV1dPT09fX18vLy9DQ0Lu7u9bW1tTU1MDAwMbGxs7Ozr29vc/Pz7i4uLe3t9HR0b+/v7m5uby8vKqqqrS0tMnJycHBwcrKyr6+vrOzs7a2trW1tbq6urKysqmpqdzc3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH/C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS4zLWMwMTEgNjYuMTQ1NjYxLCAyMDEyLzAyLzA2LTE0OjU2OjI3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M2IChXaW5kb3dzKSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpCRTcxOUQyMzExMDMxMUU2QUY2NTgwOTQ1RkE1NTI3MyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpCRTcxOUQyNDExMDMxMUU2QUY2NTgwOTQ1RkE1NTI3MyI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkJFNzE5RDIxMTEwMzExRTZBRjY1ODA5NDVGQTU1MjczIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlk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"
        };

        function update() {
            var counter = 0;

            elements.each(function() {
                var $this = $(this);
                if (settings.skip_invisible && !$this.is(":visible")) {
                    return;
                }
                if ($.abovethetop(this, settings) ||
                    $.leftofbegin(this, settings)) {
                        /* Nothing. */
                } else if (!$.belowthefold(this, settings) &&
                    !$.rightoffold(this, settings)) {
                        $this.trigger("appear");
                        /* if we found an image we'll load, reset the counter */
                        counter = 0;
                } else {
                    if (++counter > settings.failure_limit) {
                        return false;
                    }
                }
            });

        }

        if(options) {
            /* Maintain BC for a couple of versions. */
            if (undefined !== options.failurelimit) {
                options.failure_limit = options.failurelimit;
                delete options.failurelimit;
            }
            if (undefined !== options.effectspeed) {
                options.effect_speed = options.effectspeed;
                delete options.effectspeed;
            }

            $.extend(settings, options);
        }

        /* Cache container as jQuery as object. */
        $container = (settings.container === undefined ||
                      settings.container === window) ? $window : $(settings.container);

        /* Fire one scroll event per scroll. Not one scroll event per image. */
        if (0 === settings.event.indexOf("scroll")) {
            $container.bind(settings.event, function() {
                return update();
            });
        }

        this.each(function() {
            var self = this;
            var $self = $(self);

            self.loaded = false;

            /* If no src attribute given use data:uri. */
            if ($self.attr("src") === undefined || $self.attr("src") === false) {
                if ($self.is("img")) {
                    $self.attr("src", settings.placeholder);
                }
            }

            /* When appear is triggered load original image. */
            $self.one("appear", function() {
                if (!this.loaded) {
                    if (settings.appear) {
                        var elements_left = elements.length;
                        settings.appear.call(self, elements_left, settings);
                    }
                    $("<img />")
                        .bind("load", function() {

                            var original = $self.attr("data-" + settings.data_attribute);
                            $self.hide();
                            if ($self.is("img")) {
                                $self.attr("src", original);
                            } else {
                                $self.css("background-image", "url('" + original + "')");
                            }
                            $self[settings.effect](settings.effect_speed);

                            self.loaded = true;

                            /* Remove image from array so it is not looped next time. */
                            var temp = $.grep(elements, function(element) {
                                return !element.loaded;
                            });
                            elements = $(temp);

                            if (settings.load) {
                                var elements_left = elements.length;
                                settings.load.call(self, elements_left, settings);
                            }
                        })
                        .attr("src", $self.attr("data-" + settings.data_attribute));
                }
            });

            /* When wanted event is triggered load original image */
            /* by triggering appear.                              */
            if (0 !== settings.event.indexOf("scroll")) {
                $self.bind(settings.event, function() {
                    if (!self.loaded) {
                        $self.trigger("appear");
                    }
                });
            }
        });

        /* Check if something appears when window is resized. */
        $window.bind("resize", function() {
            update();
        });

        /* With IOS5 force loading images when navigating with back button. */
        /* Non optimal workaround. */
        if ((/(?:iphone|ipod|ipad).*os 5/gi).test(navigator.appVersion)) {
            $window.bind("pageshow", function(event) {
                if (event.originalEvent && event.originalEvent.persisted) {
                    elements.each(function() {
                        $(this).trigger("appear");
                    });
                }
            });
        }

        /* Force initial check if images should appear. */
        $(document).ready(function() {
            update();
        });

        return this;
    };

    /* Convenience methods in jQuery namespace.           */
    /* Use as  $.belowthefold(element, {threshold : 100, container : window}) */

    $.belowthefold = function(element, settings) {
        var fold;

        if (settings.container === undefined || settings.container === window) {
            fold = (window.innerHeight ? window.innerHeight : $window.height()) + $window.scrollTop();
        } else {
            fold = $(settings.container).offset().top + $(settings.container).height();
        }

        return fold <= $(element).offset().top - settings.threshold;
    };

    $.rightoffold = function(element, settings) {
        var fold;

        if (settings.container === undefined || settings.container === window) {
            fold = $window.width() + $window.scrollLeft();
        } else {
            fold = $(settings.container).offset().left + $(settings.container).width();
        }

        return fold <= $(element).offset().left - settings.threshold;
    };

    $.abovethetop = function(element, settings) {
        var fold;

        if (settings.container === undefined || settings.container === window) {
            fold = $window.scrollTop();
        } else {
            fold = $(settings.container).offset().top;
        }

        return fold >= $(element).offset().top + settings.threshold  + $(element).height();
    };

    $.leftofbegin = function(element, settings) {
        var fold;

        if (settings.container === undefined || settings.container === window) {
            fold = $window.scrollLeft();
        } else {
            fold = $(settings.container).offset().left;
        }

        return fold >= $(element).offset().left + settings.threshold + $(element).width();
    };

    $.inviewport = function(element, settings) {
         return !$.rightoffold(element, settings) && !$.leftofbegin(element, settings) &&
                !$.belowthefold(element, settings) && !$.abovethetop(element, settings);
     };

    /* Custom selectors for your convenience.   */
    /* Use as $("img:below-the-fold").something() or */
    /* $("img").filter(":below-the-fold").something() which is faster */

    $.extend($.expr[":"], {
        "below-the-fold" : function(a) { return $.belowthefold(a, {threshold : 0}); },
        "above-the-top"  : function(a) { return !$.belowthefold(a, {threshold : 0}); },
        "right-of-screen": function(a) { return $.rightoffold(a, {threshold : 0}); },
        "left-of-screen" : function(a) { return !$.rightoffold(a, {threshold : 0}); },
        "in-viewport"    : function(a) { return $.inviewport(a, {threshold : 0}); },
        /* Maintain BC for couple of versions. */
        "above-the-fold" : function(a) { return !$.belowthefold(a, {threshold : 0}); },
        "right-of-fold"  : function(a) { return $.rightoffold(a, {threshold : 0}); },
        "left-of-fold"   : function(a) { return !$.rightoffold(a, {threshold : 0}); }
    });

})(jQuery, window, document);