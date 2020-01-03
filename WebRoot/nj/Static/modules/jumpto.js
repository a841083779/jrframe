define('jumpto',function(require, exports, module) {
	var $ = require('jquery');

!function($){
  
  var defaults = {
    firstLevel: "> h2",
    secondLevel: false,
    innerWrapper: ".jumpto-block",
    offset: 400,
    animate: 1000,
    navContainer: false,
    anchorTopPadding: 50,
    showTitle: "Jump To",
    closeButton: true
	};
	
	function isScrolledIntoView(elem)
  {
      var docViewTop = $(window).scrollTop();
      var docViewBottom = docViewTop + ($(window).height() /4);
      
      var elemTop = $(elem).offset().top;
      var elemBottom = elemTop + $(elem).height();

      return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
  }
	
  $.fn.jumpto = function(options){
    var settings = $.extend({}, defaults, options),
        el = $(this),
        html = "",
        block = $(settings.innerWrapper),
        selectors = "",
        title = "",
        close ="";
        
    el.addClass("jumpto-cotainer");
    
    redrawMenu = function(){
      $(selectors.slice(0,-2)).each(function( index ) {
        if (isScrolledIntoView($(this))) {
          $(".jumpto-subnav a").removeClass("active").parent().find(" a[href='#"+$(this).attr("id")+"']").addClass("active")
          
          if($("a[href='#"+$(this).attr("id")+"']").parent().parent().hasClass("jumpto-second")) {
            $("a[href='#"+$(this).attr("id")+"']").closest(".jumpto-second").show()
          }
          if($("a[href='#"+$(this).attr("id")+"']").parent().parent().hasClass("jumpto-first")) {
            $("a[href='#"+$(this).attr("id")+"']").closest(".jumpto-first").find(".jumpto-second").hide()
          }
          if($("a[href='#"+$(this).attr("id")+"']").parent().find(".jumpto-second")) {
            $("a[href='#"+$(this).attr("id")+"']").parent().find(".jumpto-second").show()
          }
        }
      });
	  
      if($(document).scrollTop() > el.offset().top - 50) {
        $(".jumpto-subnav").removeClass("bottom").addClass("fixed");
      } else {
        $(".jumpto-subnav").removeClass("bottom fixed");
      }
      if($(document).scrollTop() > el.offset().top + el.outerHeight(true)-$(".jumpto-subnav").outerHeight() -25) {
        $(".jumpto-subnav").addClass("bottom fixed");
      }
    }
    
    block.find(settings.firstLevel).each(function( index ) {
      var b = $(this),
          i = index,
          inner_html = "";
      if ( b.parent().find(settings.secondLevel).length > 0) {
        inner_html += "<ul class='jumpto-second'>"
        b.parent().find(settings.secondLevel).each(function( index ) {
          var id = "jumpto_" + i + "_" + index;
          $(this).attr("id", id);
          link_to = "<a href='#" + id + "'>" + "<span>" + $(this).text() + "</span>" + "</a>"
          inner_html += "<li>" + link_to + "</li>"
          selectors += "#"+id + ", ";
        });
        inner_html += "</ul>"
        var id = "jumpto_" + i;
        b.attr("id", id);
        link_to = "<a href='#" + id + "'>" + "<span>" + b.text() + "</span>" + "</a>"
        selectors += "#"+id + ", ";
        html += "<li>" + link_to + inner_html + "</li>"
      } else {
        var id = "jumpto_" + i;
        link_to = "<a href='#" + id + "'>" + "<span>" + b.text() + "</span>" + "</a>"
        b.attr("id", id);
        selectors += "#"+id + ", ";
        html += "<li>" + link_to + "</li>"
      }
    });
    if (settings.showTitle != false) {
      var title = "<div class='jumpto-title'>"+settings.showTitle+"</div>"
    }
    
    if (settings.closeButton != false) {
      var close = "<div class='jumpto-close'><a href='#' id='jumpto-close'>Close</a></div>"
    }
    if(settings.navContainer == false) {
      $(this).append("<nav class='jumpto-subnav'>"+ title +"<ul class='jumpto-first'>" + html + "</ul>"+ close +"</nav>")
    }else{
      $(settings.navContainer).addClass("jumpto-subnav").html(title +"<ul class='jumpto-first'>" + html + "</ul>"+ close)
    }
    
    
    $('.jumpto-subnav a[href*=#]:not([href=#])').click(function() {
      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') 
          || location.hostname == this.hostname) {
    
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
        if (target.length) {
          $('html,body').animate({
            scrollTop: target.offset().top - settings.anchorTopPadding
          }, settings.animate, 'swing');
          return false;
        }
      }
    });
    
    $(window).scroll(function() {
      redrawMenu()
    });
    
    $(".jumpto-subnav #jumpto-close").click(function() {
      var btn = $(this)
      btn.parent().parent().find("> .jumpto-first").slideToggle( "slow", function() {
          if ($(this).is(":visible")) {
            btn.html("Close");
          } else {
            btn.html("Open");
          }
        });
        return false;
    });
    
    setInterval(function() {
      var track = [];
      $(selectors.slice(0,-2)).each(function( index ) {
        track.push(isScrolledIntoView($(this)))
      });
      if($.inArray(true, track) == -1) {
        $(".jumpto-subnav a").removeClass("active")
        $(".jumpto-subnav .jumpto-second").hide()
      }
    }, 500);
  }
}($);



})