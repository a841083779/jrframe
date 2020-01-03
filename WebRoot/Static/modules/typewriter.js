/*
 * typewriter.js
 *
 * Copyright 2014, Connor Atherton - http://connoratherton.com/
 * Released under the MIT Licence
 * http://opensource.org/licenses/MIT
 *
 * Github:  http://github.com/ConnorAtherton/typewriter
 */
// 兼容ie7；to jquery plugin；
define(function(require, module, exports) {
  var $ = require('jquery'),
    def = {
      element: null,
      text: null,
      words: false,
      interval: 'human',
      lowerBound: 30,
      upperBound: 200,
      callback: function() {}
    },
    randomIntFromInterval = function(min, max) {
      return Math.floor(Math.random() * (max - min + 1) + min);
    },
    isNumber = function(n) {
      return !isNaN(parseFloat(n)) && isFinite(n);
    };

  $.fn.typer = function(config) {
    var $this = $(this),
      options = $.extend({}, def, config || {}),

      getIntervalSpeed = function() {
        if (isNumber(options.interval)) return options.interval;

        return randomIntFromInterval(options.lowerBound, options.upperBound);
      },

      typeByLettersConstantInterval = function(cb) {
        var numberOfLetters = options.text.length,
          currentPosition = 0;

        var interval = window.setInterval(function() {
          if (currentPosition === numberOfLetters) {
            window.clearInterval(interval);

            cb && cb.call(window);
          } else {
            $this.get(0).innerHTML += options.text.substring(currentPosition,currentPosition+1);
            currentPosition++;
          }
        }, getIntervalSpeed());
      },

      typeByLettersRandomisedInterval = function(cb) {
        var numberOfLetters = options.text.length,
          currentPosition = 0;

        repeat(numberOfLetters, currentPosition, cb);
      },

      repeat = function(numberOfLetters, currentPosition, cb) {
        if (numberOfLetters === 0) return cb && cb.call(window);

        var interval = getIntervalSpeed.call(),
          timer;

        $this.get(0).innerHTML += options.text.substring(currentPosition,currentPosition+1);

        timer = setTimeout(function() {
          numberOfLetters--;
          currentPosition++;
          repeat(numberOfLetters, currentPosition, cb);
        }, interval);
      },

      typeByWords = function(cb) {
        var words = options.text.split(' '),
          numberOfWords = words.length,
          currentPosition = 0;

        var interval = window.setInterval(function() {
          if (currentPosition === numberOfWords) {
            window.clearInterval(interval);

            cb && cb.call(window);
          } else {
            $this.get(0).innerHTML += (words[currentPosition] + ' ');
            currentPosition++;
          }
        }, getIntervalSpeed());
      };

    options.words ? typeByWords(options.callback) :
      isNumber(options.interval) ? typeByLettersConstantInterval(options.callback) :
      typeByLettersRandomisedInterval(options.callback);

    return $this;
  }

})