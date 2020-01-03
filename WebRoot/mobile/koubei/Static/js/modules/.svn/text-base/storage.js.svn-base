define(function(require, exports, module) {
  var $ = require('$');
  require('./cookie');
  
  $.storage = function(name,value){
		if (typeof value != 'undefined') {
			window.localStorage ? localStorage.setItem(name, value) : $.cookie(name,value);
			}else{
				return window.localStorage ? localStorage.getItem(name): $.cookie(name);	
				}
		}

})