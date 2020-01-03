

/**
 * 成功弹出框
 * 
 * @param {}
 *            content 内容
 */
function jrSuccess(content) {
	window.parent.jQuery.ligerDialog.success(content);
}
/**
 * 提示弹出框
 * 
 * @param {}
 *            content 内容
 */
function jrWarn(content) {
	window.parent.jQuery.ligerDialog.warn(content);
}
/**
 * Alert提示框
 * 
 * @param {}
 *            content 内容
 */
function jrAlert(content) {
	window.parent.jQuery.ligerDialog.alert(content, "提示");
}
/**
 * 错误弹出框
 * 
 * @param {}
 *            content 内容
 */
function jrError(content) {
	window.parent.jQuery.ligerDialog.error(content);
}

/**
 * 问题弹出框
 * 
 * @param {}
 *            content 内容
 */
function jrQuestion(content) {
	window.parent.jQuery.ligerDialog.question(content);
}

/**
 * 确认弹出框
 * 
 * @param {}
 *            content 内容
 * @param {}
 *            fun 回调函数
 */
function jrConfirm(content, fun) {
	window.parent.jQuery.ligerDialog.confirm(content, function(yes) {
				fun(yes);
			});
}

/**
 * 警告弹出框
 * 
 * @param {}
 *            content 内容
 * @param {}
 *            fun 回调函数
 */
function jrWarning(content, fun) {
	window.parent.jQuery.ligerDialog.warning(content, function(yes) {
				fun(yes);
			});
}

/**
 * 根据索引删除行
 * 
 * @param {}
 *            index 索引
 */
function jrDeleteRow(index) {
	grid.deleteRow(grid.getRowObj(index));
}
/**
 * 为grid增加便行
 * 
 * @param {}
 *            obj 行对象
 */
function jrAddEditRow(obj) {
	grid.addEditRow();
}

window.parent.jQuery.ligerui.controls.Dialog.prototype._borderX = 2;
window.parent.jQuery.ligerui.controls.Dialog.prototype._borderY = 0;

/**
 * Window弹出
 * 
 * @param {}
 *            url iframe路径
 * @param {}
 *            title 标题
 * @param {}
 *            width 宽度
 * @param {}
 *            height 高度
 */
function jrWindow(url, title, width, height) {
	parent.nowDialog = window.parent.jQuery.ligerDialog.open({
				height : height,
				url : url,
				width : width,
				showMax : false,
				showToggle : false,
				showMin : false,
				isResize : false,
				modal : true,
				title : title,
				buttons : [{
					text : '确定',
					onclick : function(item, dialog) {
						if(typeof(dialog.frame.doSub)=='undefined'){
							dialog.close();
							return;
						}
						var rs = dialog.frame.doSub(dialog);
						if(rs!=undefined&&rs=='no_refresh'){
							dialog.close();
							return;
						}
						var ifid = parent.tab.getSelectedTabItemID();
						parent.document.getElementById(ifid).contentWindow.grid
								.loadData();
						if(rs!=undefined&&rs==true){
							dialog.close();
						}
					}
				}, {
					text : '取消',
					onclick : function(item, dialog) {
						dialog.close();
					}
				}]
			});
}

/**
 * 遍历所有的iframe得到应该得到的那一个
 * 
 * @param {}
 *            url
 * @return {}
 */
function eachIframe(url) {
	var iframe = null;
	if (url.indexOf('/backend/') != -1) {
		url = url.substring(url.indexOf('/backend/'));
	}
	jQuery.each(jQuery(parent.document).find("iframe"), function(index, data) {
				if (jQuery(this).attr("src") == url) {
					iframe = this;
				}
			})
	return iframe;
}

/**
 * 多表联查
 * 
 * @type String
 */
var main = '';

/**
 * 列表删除方法
 * 
 * @param {}
 *            arg 删除时要传的参数
 */
function toolbarDel(arg) {
	if (arg == undefined || arg == null) {
		arg = {};
	}
	var checkedRows = grid.getCheckedRows();
	if (checkedRows.length <= 0) {
		return;
	}
	// 遍历所有的选中行，如果是没有UUID，则移除
	jQuery.each(checkedRows, function(index, data) {
				if (this.uuid == undefined) {
					jrDeleteRow(this.__index);
				}
			});
	jrConfirm(((typeof(arg.flag)=='undefined' || arg.flag!='cancelProductsOrder')?"确定删除选中项吗？":"确定取消产品排序吗？"), function(v) {
				if (v) {
					var checkedRows = grid.getCheckedRows();
					var idStr = "";
					for (var i = 0; i < checkedRows.length; i++) {
						idStr += "'" + checkedRows[i].uuid + "',";
					}
					if (idStr.indexOf(",") != -1) {
						idStr = idStr.substring(0, idStr.length - 1);
					}
					arg.del_id = idStr;
					if(undefined==arg.tableName){
						arg.tableName = tableName;
					}
					if(typeof(arg.flag)!='undefined' && arg.flag=='cancelProductsOrder'){
					  executeCancelOrder(arg) ;// 取消设置好的订单
					}else{
					executeDel(arg);
				}
				}
			});
}
/**
 * 批量设为显示 
 * 
 * @param {}
 *            arg 删除时要传的参数
 */
function setYmtShow(arg) {
	if (arg == undefined || arg == null) {
		arg = {};
	}
	var checkedRows = grid.getCheckedRows();
	if (checkedRows.length <= 0) {
	   jrWarn("请选择产品") ;
		return;
	}
	// 遍历所有的选中行，如果是没有UUID，则移除
	jQuery.each(checkedRows, function(index, data) {
				if (this.uuid == undefined) {
					jrDeleteRow(this.__index);
				}
			});
	jrConfirm(((typeof(arg.flag)!='undefined' && arg.flag=='setYmtShow')?"确定显示所选吗？":"确定隐藏所选吗？"), function(v) {
				if (v) {
					var checkedRows = grid.getCheckedRows();
					var idStr = "";
					for (var i = 0; i < checkedRows.length; i++) {
						idStr += "'" + checkedRows[i].uuid + "',";
					}
					if (idStr.indexOf(",") != -1) {
						idStr = idStr.substring(0, idStr.length - 1);
					}
					arg.opt_id = idStr;
					if(undefined==arg.tableName){
						arg.tableName = tableName;
					}
					if(typeof(arg.flag)!='undefined' && arg.flag=='setYmtShow'){
					  executesetYmtShow(arg) ;// 显示所选产品
					}else if(typeof(arg.flag)!='undefined' && arg.flag=='setYmtHide'){
					executesetYmtShow(arg) ; // 隐藏所选产品
				}
				}
			});
}
function executesetYmtShow(arg){
 	 		jQuery.ajax({
				url : '/backend/action/ajax_cud.jsp',
				data : arg,
				type : 'post',
				async : false,
				cache : false,
				success : function(data) {
					grid.loadData();
				}
			});
}
/**
 * 执行删除的方法
 * 
 * @param {}
 *            data 要传向后台的数据
 */
function executeDel(delData) {
	jQuery.ajax({
				url : '/backend/action/crud.jsp',
				data : delData,
				type : 'post',
				async : false,
				cache : false,
				success : function(data) {
					grid.loadData();
				}
			});
}
/**
 * 执行取消设置好订单排序的方法
 * 
 * @param {}
 *            data 要传向后台的数据
 */
function executeCancelOrder(delData) {
	jQuery.ajax({
				url : '/backend/action/ajax_cud.jsp',
				data : delData,
				type : 'post',
				async : false,
				cache : false,
				success : function(data) {
				jQuery.jBox.tip("取消成功!") ;
					// grid.loadData();
				}
			});
}
/**
 * 增加和修改的方法
 * 
 * @param {}
 *            obj 行对象
 * @param {}
 *            arg 显示参数 目前拥有 width,height,title,fileName 4个属性
 */
function toolbarAdd(arg, obj) {
	var tblTemp = tableName.replace("[", "").replace("]", "");
	var width = null;
	var height = null;
	var title = null;
	var fileName = null;
	var folderName = null;
	if (arg == undefined || arg.width == undefined) {
		width = 800;
	} else {
		width = arg.width;
	}
	if (arg == undefined || arg.height == undefined) {
		height = 600;
	} else {
		height = arg.height;
	}
	if (arg == undefined || arg.title == undefined) {
		title = "编辑";
	} else {
		title = arg.title;
	}
	if (arg == undefined || arg.fileName == undefined) {
		fileName = tblTemp;
	} else {
		fileName = arg.fileName;
	}
	if (arg == undefined || arg.folderName == undefined) {
		folderName = tblTemp;
	} else {
		folderName = arg.folderName;
	}
	
	var prefix = jQuery("script[prefix]").attr("prefix");
	if(folderName.indexOf("common_channel_subblock_data")!=-1){
		folderName = folderName.substring(prefix.length);
	}else if(folderName.indexOf("common_channel_subblock")!=-1){
		folderName = folderName.substring(prefix.length);
	}else if(folderName.indexOf("common_channel")!=-1){
		folderName = folderName.substring(prefix.length);
	}else if(folderName.indexOf("common_enum")!=-1){
		folderName = folderName.substring(prefix.length);
	}else if(folderName.indexOf("common_role")!=-1){
		folderName = folderName.substring(prefix.length);
	}else if(folderName.indexOf("common_template")!=-1){
		folderName = folderName.substring(prefix.length);
	}else if(folderName.indexOf("common_user")!=-1){
		folderName = folderName.substring(prefix.length);
	}
	
	if(folderName.indexOf("common_channel_subblock_data")!=-1){
		fileName = fileName.substring(prefix.length);
	}else if(folderName.indexOf("common_channel_subblock")!=-1){
		fileName = fileName.substring(prefix.length);
	}else if(fileName.indexOf("common_channel")!=-1){
		fileName = fileName.substring(prefix.length);
	}else if(folderName.indexOf("common_enum")!=-1){
		fileName = fileName.substring(prefix.length);
	}else if(folderName.indexOf("common_role")!=-1){
		fileName = fileName.substring(prefix.length);
	}else if(folderName.indexOf("common_template")!=-1){
		fileName = fileName.substring(prefix.length);
	}else if(folderName.indexOf("common_user")!=-1){
		fileName = fileName.substring(prefix.length);
	}
	// 增加
	if (obj == undefined) {
		var url = "/backend/" + folderName + "/" + fileName + "_edit.jsp";
		if (undefined != arg.params && null != arg.params) {
			url += "?";
			for (var key in arg.params) {
				url += key + "=" + arg.params[key] + "&";
			}
			if (null != url && url.indexOf("&") != -1) {
				url = url.substring(0, url.length - 1);
			}
		}
		jrWindow(url, title, width, height);
	} else {// 修改
		var url = "/backend/" + folderName + "/" + fileName + "_edit.jsp?id="
				+ obj;
		if (undefined != arg.params && null != arg.params) {
			url += "&";
			for (var key in arg.params) {
				url += key + "=" + arg.params[key] + "&";
			}
			if (null != url && url.indexOf("&") != -1) {
				url = url.substring(0, url.length - 1);
			}
		}
		jrWindow(url, title, width, height);
	}
}

/**
 * 根据键获取枚举值
 * 
 * @param {}
 *            key 键
 * @return {}
 */
var enum_map = null;
function getEnum(key) {
	var value = null;
	if (null == enum_map) {// 如果枚举时空，则从服务器取回，否则，直接拿本地的
		jQuery.ajax({
					url : '/backend/action/ajax_r.jsp',
					data : {
						'flag' : 'get_enum'
					},
					type : 'get',
					async : false,
					cache : true,
					dataType : 'jsonp',
					jsonp : 'callback',
					type : 'post',
					success : function(json) {
						enum_map = json;
					}
				});
	}
	value = enum_map[key];
	return value;
}


/**
 * 根据键获取枚举值
 * 
 * @param {}
 *            key 键
 * @return {}
 */
var brand_map = null;
function getBrand(key) {
	var value = null;
	if (null == brand_map) {// 如果枚举时空，则从服务器取回，否则，直接拿本地的
		jQuery.ajax({
					url : '/backend/action/ajax_r.jsp',
					data : {
						'flag' : 'get_brand'
					},
					type : 'get',
					async : false,
					cache : true,
					dataType : 'jsonp',
					jsonp : 'callback',
					type : 'post',
					success : function(json) {
						brand_map = json;
					}
				});
	}
	value = brand_map[key];
	return value;
}


/**
 * 根据键获取枚举值
 * 
 * @param {}
 *            key 键
 * @return {}
 */
var category_map = null;
function getCategory(key) {
	var value = null;
	if (null == category_map) {// 如果枚举时空，则从服务器取回，否则，直接拿本地的
		jQuery.ajax({
					url : '/backend/action/ajax_r.jsp',
					data : {
						'flag' : 'get_category'
					},
					type : 'get',
					async : false,
					cache : true,
					dataType : 'jsonp',
					jsonp : 'callback',
					type : 'post',
					success : function(json) {
						category_map = json;
					}
				});
	}
	value = category_map[key];
	return value;
}

/**
 * 通用同级排序
 */
function commonSort(arg) {
	var url = "/backend/function/sort.jsp?tableName=" + arg.tableName;
	url += "&value=" + arg.value;
	url+= "&factoryid="+arg.factoryid ;
	url += "&catalognum="+arg.catalognum ;
	jrWindow(url, "排序", 300, 500);
}
/**
 * 选择文件
 * 
 * @param {}
 *            id
 */
function chooseFile(id, w, h) {
	var url = "/backend/function/file/choose_list.jsp?id=" + id;
	var title = "选择";
	var width = 650;
	if (w != undefined) {
		width = w;
	}
	var height = 400;
	if (h != undefined) {
		height = h;
	}
	jQuery.ligerDialog.open({
				height : height,
				url : url,
				width : width,
				showMax : true,
				showToggle : false,
				showMin : false,
				isResize : false,
				modal : true,
				title : title,
				buttons : [{
					text : '确定',
					onclick : function(item, dialog) {
						dialog.frame.doSub(dialog);
						var ifid = parent.tab.getSelectedTabItemID();
						parent.document.getElementById(ifid).contentWindow.grid
								.loadData();
					}
				}, {
					text : '取消',
					onclick : function(item, dialog) {
						dialog.close();
					}
				}]
			});
}

/**
 * 执行ajax的方法
 * @param {} url 请求地址
 * @param {} data post数据
 * @param {} fun 回调函数
 * @param {} async 是否异步
 */
function doAjax(url,data,fun,async){
	if(undefined==async){
		async = true;
	}
	jQuery.ajax({
		url:url,
		type:'post',
		data:data,
		async:async,
		cache:false,
		success:function(data){
			if(undefined!=fun){
				fun(data);
			}
		}
	});
}

/**
 * 对表单添加效果
 */
jQuery(function() {
			var jrCss = jQuery(".jr_text,jr_select");
			jrCss.focus(function() {
						jQuery(this).css("border", "1px solid #000");
					});
			jrCss.blur(function() {
						jQuery(this).css("border", "1px solid #999");
					});
			jQuery(".jr_text[readonly=readonly]").css("color","#666");
		})

function Dev21sunGrid(config){
    if (url == '') {
        url = "/backend/action/liger.jsp";
    }
    params.push({
        'name': 'tableName',
        'value': tableName
    });
    params.push({
        'name': 'fields',
        'value': fields
    });
    params.push({
        'name': 'whereStr',
        'value': whereStr
    });
    params.push({
        'name': 'orderBy',
        'value': orderBy
    });
    var buttons = null;
    // 如果查询不是关闭状态
    if (typeof(config) != 'undefined' && typeof(config.searchIsClose) != 'undefined' && !config.searchIsClose) {
        buttons = [{
            text: '增加',
            click: function(){
                addAndEdit();
            },
            icon: 'add'
        }, {
            text: '删除',
            click: function(){
                toolbarDel({
                    channel_uuid: channelUUID
                });
            },
            icon: 'delete'
        }, {
            text: '关闭查询',
            click: function(){
                closeAndOpen();
            },
            icon: 'busy'
        }];
        jQuery(".searchForm").show();
    }
    else {
        buttons = [{
            text: '增加',
            click: function(){
                addAndEdit();
            },
            icon: 'add'
        }, {
            text: '删除',
            click: function(){
                toolbarDel({
                    channel_uuid: channelUUID
                });
            },
            icon: 'delete'
        }, {
            text: '打开查询',
            click: function(){
                closeAndOpen();
            },
            icon: 'right'
        }];
    }
    var myToolbar = {
        items: buttons
    };
    if (typeof(config) != 'undefined' && typeof(config.toolbar) != 'undefined') {
        myToolbar = config.toolbar;
    }
    // 增加的按钮
    if (typeof(config) != 'undefined' && typeof(config.addToolbar) != 'undefined') {
        for (var i = 0; i < config.addToolbar.length; i++) {
            myToolbar.items.push(config.addToolbar[i]);
        }
    }
    
    var defualts = {
        url: url,
        toolbar: myToolbar,
        columns: columnsArr,
        id: "maingrid",
        alternatingRow: true,
        addColumns: true, // 是否追加列
        params: params,
        data: null,
        width: "99.8%",
        height: "98%",
        pageSize: 20,
        showTitle: false,
        checkbox: true,
        RequireData: false,
        tableName: null,
        tree: null,
        async: true,
        usePager: true,
        onSuccess: function(){
        
        },
        onLoaded: null,
        title: null,
        enabledEdit: false,
        selectRowButtonOnly: true,
        rownumbers: true,
        clickToEdit: false,
        isChecked: function(obj){
        },
        onAfterEdit: null,
        onBeforeSubmitEdit: function(obj){
        
        },
        onDblClickRow: function(data, rowindex, rowobj){
        
        },
        tree: null
    };
    var opts = jQuery.extend(true, {}, defualts, config);
    var g = jQuery("#" + opts.id).ligerGrid({
        columns: opts.columns,
        url: opts.url,
        pageSize: opts.pageSize,
        method: "post",
        tree: opts.tree,
        width: opts.width,
        height: opts.height,
        checkbox: opts.checkbox,
        selectRowButtonOnly: opts.selectRowButtonOnly,
        parms: opts.params,
        onLoaded: opts.onLoaded,
        usePager: opts.usePager,
        showTitle: opts.showTitle,
        alternatingRow: opts.alternatingRow,
        rownumbers: opts.rownumbers,
        toolbar: opts.toolbar,
        clickToEdit: opts.clickToEdit,
        enabledEdit: opts.enabledEdit,
        isChecked: opts.isChecked,
        frozenCheckbox: true,
        tree: opts.tree,
        rownumbers: true,
        allowUnSelectRow: true,
        async: opts.async,
        frozenRownumbers: false,
        title: opts.title,
        onSuccess: opts.onSuccess,
        onAfterShowData: opts.onAfterShowData,
        data: opts.data,
        RequireData: opts.RequireData,
        onDblClickRow: opts.onDblClickRow,
        onBeforeSubmitEdit: opts.onBeforeSubmitEdit,
        onAfterEdit: opts.onAfterEdit
    });
    jQuery("#pageloading").hide();
    return g;
}
// 取消订单的实时提醒
jQuery("body").click(function(){
	jQuery.ajax({
		url:'/backend/action/ajax_cud.jsp',
		type:'post',
		data:{flag:'clearOrderInfo'},
		success:function(msg){
		}
	}) ;
}) ;