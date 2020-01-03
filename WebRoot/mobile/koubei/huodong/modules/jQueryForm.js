define(function(require, exports, module) {
	var $ = require('$');
	var base = require('base');
	$.fn.ajaxSubmit = function(options) {
		if (typeof options == 'function') options = {
			success: options
		};
		options = $.extend({
			url: this.attr('action') || window.location,
			type: this.attr('method') || 'GET'
		}, options || {});
		var a = this.formToArray(options.semantic);
		if (options.beforeSubmit && options.beforeSubmit(a, this, options) === false) return this;
		var veto = {};
		$.event.trigger('form.submit.validate', [a, this, options, veto]);
		if (veto.veto) return this;
		var q = $.param(a);
		if (options.type.toUpperCase() == 'GET') {
			options.url += (options.url.indexOf('?') >= 0 ? '&' : '?') + q;
			options.data = null
		} else options.data = q;
		var $form = this,
			callbacks = [];
		if (options.resetForm) callbacks.push(function() {
			$form.resetForm()
		});
		if (options.clearForm) callbacks.push(function() {
			$form.clearForm()
		});
		if (!options.dataType && options.target) {
			var oldSuccess = options.success;
			callbacks.push(function(data) {
				$(options.target).attr("innerHTML", data).evalScripts().each(oldSuccess, arguments)
			})
		} else if (options.success) callbacks.push(options.success);
		options.success = function(data, status) {
			for (var i = 0, max = callbacks.length; i < max; i++) callbacks[i](data, status, $form)
		};
		var files = $('input:file', this).fieldValue();
		var found = false;
		for (var j = 0; j < files.length; j++) if (files[j]) found = true;
		if (options.iframe || found) fileUpload();
		else $.ajax(options);
		$.event.trigger('form.submit.notify', [this, options]);
		return this;

		function fileUpload() {
			var form = $form[0];
			var opts = $.extend({}, $.ajaxSettings, options);
			var id = 'jqFormIO' + $.fn.ajaxSubmit.counter++;
			var $io = $('<iframe id="' + id + '" name="' + id + '" />');
			var io = $io[0];
			if (base.ie6 || base.ie7 || base.ie8) io.src = 'javascript:false;document.write("");';
			$io.css({
				position: 'absolute',
				top: '-1000px',
				left: '-1000px'
			});
			var xhr = {
				responseText: null,
				responseXML: null,
				status: 0,
				statusText: 'n/a',
				getAllResponseHeaders: function() {},
				getResponseHeader: function() {},
				setRequestHeader: function() {}
			};
			var g = opts.global;
			if (g && !$.active++) $.event.trigger("ajaxStart");
			if (g) $.event.trigger("ajaxSend", [xhr, opts]);
			var cbInvoked = 0;
			var timedOut = 0;
			setTimeout(function() {
				$io.appendTo('body');
				io.attachEvent ? io.attachEvent('onload', cb) : io.addEventListener('load', cb, false);
				var encAttr = form.encoding ? 'encoding' : 'enctype';
				var t = $form.attr('target');
				$form.attr({
					target: id,
					method: 'POST',
					encAttr: 'multipart/form-data',
					action: opts.url
				});
				if (opts.timeout) setTimeout(function() {
					timedOut = true;
					cb()
				}, opts.timeout);
				form.submit();
				$form.attr('target', t)
			}, 10);

			function cb() {
				if (cbInvoked++) return;
				io.detachEvent ? io.detachEvent('onload', cb) : io.removeEventListener('load', cb, false);
				var ok = true;
				try {
					if (timedOut) throw 'timeout';
					var data, doc;
					doc = io.contentWindow ? io.contentWindow.document : io.contentDocument ? io.contentDocument : io.document;
					xhr.responseText = doc.body ? doc.body.innerHTML : null;
					xhr.responseXML = doc.XMLDocument ? doc.XMLDocument : doc;
					if (opts.dataType == 'json' || opts.dataType == 'script') {
						var ta = doc.getElementsByTagName('textarea')[0];
						data = ta ? ta.value : xhr.responseText;
						if (opts.dataType == 'json') eval("data = " + data);
						else $.globalEval(data)
					} else if (opts.dataType == 'xml') {
						data = xhr.responseXML;
						if (!data && xhr.responseText != null) data = toXml(xhr.responseText)
					} else {
						data = xhr.responseText
					}
				} catch (e) {
					ok = false;
					$.handleError(opts, xhr, 'error', e)
				}
				if (ok) {
					opts.success(data, 'success');
					if (g) $.event.trigger("ajaxSuccess", [xhr, opts])
				}
				if (g) $.event.trigger("ajaxComplete", [xhr, opts]);
				if (g && !--$.active) $.event.trigger("ajaxStop");
				if (opts.complete) opts.complete(xhr, ok ? 'success' : 'error');
				setTimeout(function() {
					$io.remove();
					xhr.responseXML = null
				}, 100)
			};

			function toXml(s, doc) {
				if (window.ActiveXObject) {
					doc = new ActiveXObject('Microsoft.XMLDOM');
					doc.async = 'false';
					doc.loadXML(s)
				} else doc = (new DOMParser()).parseFromString(s, 'text/xml');
				return (doc && doc.documentElement && doc.documentElement.tagName != 'parsererror') ? doc : null
			}
		}
	};
	$.fn.ajaxSubmit.counter = 0;
	$.fn.ajaxForm = function(options) {
		return this.ajaxFormUnbind().submit(submitHandler).each(function() {
			this.formPluginId = $.fn.ajaxForm.counter++;
			$.fn.ajaxForm.optionHash[this.formPluginId] = options;
			$(":submit,input:image", this).click(clickHandler)
		})
	};
	$.fn.ajaxForm.counter = 1;
	$.fn.ajaxForm.optionHash = {};

	function clickHandler(e) {
		var $form = this.form;
		$form.clk = this;
		if (this.type == 'image') {
			if (e.offsetX != undefined) {
				$form.clk_x = e.offsetX;
				$form.clk_y = e.offsetY
			} else if (typeof $.fn.offset == 'function') {
				var offset = $(this).offset();
				$form.clk_x = e.pageX - offset.left;
				$form.clk_y = e.pageY - offset.top
			} else {
				$form.clk_x = e.pageX - this.offsetLeft;
				$form.clk_y = e.pageY - this.offsetTop
			}
		}
		setTimeout(function() {
			$form.clk = $form.clk_x = $form.clk_y = null
		}, 10)
	};

	function submitHandler() {
		var id = this.formPluginId;
		var options = $.fn.ajaxForm.optionHash[id];
		$(this).ajaxSubmit(options);
		return false
	};
	$.fn.ajaxFormUnbind = function() {
		this.unbind('submit', submitHandler);
		return this.each(function() {
			$(":submit,input:image", this).unbind('click', clickHandler)
		})
	};
	$.fn.formToArray = function(semantic) {
		var a = [];
		if (this.length == 0) return a;
		var form = this[0];
		var els = semantic ? form.getElementsByTagName('*') : form.elements;
		if (!els) return a;
		for (var i = 0, max = els.length; i < max; i++) {
			var el = els[i];
			var n = el.name;
			if (!n) continue;
			if (semantic && form.clk && el.type == "image") {
				if (!el.disabled && form.clk == el) a.push({
					name: n + '.x',
					value: form.clk_x
				}, {
					name: n + '.y',
					value: form.clk_y
				});
				continue
			}
			var v = $.fieldValue(el, true);
			if (v && v.constructor == Array) {
				for (var j = 0, jmax = v.length; j < jmax; j++) a.push({
					name: n,
					value: v[j]
				})
			} else if (v !== null && typeof v != 'undefined') a.push({
				name: n,
				value: v
			})
		}
		if (!semantic && form.clk) {
			var inputs = form.getElementsByTagName("input");
			for (var i = 0, max = inputs.length; i < max; i++) {
				var input = inputs[i];
				var n = input.name;
				if (n && !input.disabled && input.type == "image" && form.clk == input) a.push({
					name: n + '.x',
					value: form.clk_x
				}, {
					name: n + '.y',
					value: form.clk_y
				})
			}
		}
		return a
	};
	$.fn.formSerialize = function(semantic) {
		return $.param(this.formToArray(semantic))
	};
	$.fn.fieldSerialize = function(successful) {
		var a = [];
		this.each(function() {
			var n = this.name;
			if (!n) return;
			var v = $.fieldValue(this, successful);
			if (v && v.constructor == Array) {
				for (var i = 0, max = v.length; i < max; i++) a.push({
					name: n,
					value: v[i]
				})
			} else if (v !== null && typeof v != 'undefined') a.push({
				name: this.name,
				value: v
			})
		});
		return $.param(a)
	};
	$.fn.fieldValue = function(successful) {
		for (var val = [], i = 0, max = this.length; i < max; i++) {
			var el = this[i];
			var v = $.fieldValue(el, successful);
			if (v === null || typeof v == 'undefined' || (v.constructor == Array && !v.length)) continue;
			v.constructor == Array ? $.merge(val, v) : val.push(v)
		}
		return val
	};
	$.fieldValue = function(el, successful) {
		var n = el.name,
			t = el.type,
			tag = el.tagName.toLowerCase();
		if (typeof successful == 'undefined') successful = true;
		if (successful && (!n || el.disabled || t == 'reset' || t == 'button' || (t == 'checkbox' || t == 'radio') && !el.checked || (t == 'submit' || t == 'image') && el.form && el.form.clk != el || tag == 'select' && el.selectedIndex == -1)) return null;
		if (tag == 'select') {
			var index = el.selectedIndex;
			if (index < 0) return null;
			var a = [],
				ops = el.options;
			var one = (t == 'select-one');
			var max = (one ? index + 1 : ops.length);
			for (var i = (one ? index : 0); i < max; i++) {
				var op = ops[i];
				if (op.selected) {
					var v = (base.ie6 || base.ie7 || base.ie8) && !(op.attributes['value'].specified) ? op.text : op.value;
					if (one) return v;
					a.push(v)
				}
			}
			return a
		}
		return el.value
	};
	$.fn.clearForm = function() {
		return this.each(function() {
			$('input,select,textarea', this).clearFields()
		})
	};
	$.fn.clearFields = $.fn.clearInputs = function() {
		return this.each(function() {
			var t = this.type,
				tag = this.tagName.toLowerCase();
			if (t == 'text' || t == 'password' || tag == 'textarea') this.value = '';
			else if (t == 'checkbox' || t == 'radio') this.checked = false;
			else if (tag == 'select') this.selectedIndex = -1
		})
	};
	$.fn.resetForm = function() {
		return this.each(function() {
			if (typeof this.reset == 'function' || (typeof this.reset == 'object' && !this.reset.nodeType)) this.reset()
		})
	}
})