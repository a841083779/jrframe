<%@ page language="java" import="java.util.*,java.sql.*,com.jerehnet.util.dbutil.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%>
<%
	Connection connection = null;
	String tablePrefix = Env.getInstance().getProperty("table_prefix");
	DBHelper dbHelper = DBHelper.getInstance();
	Map model = new HashMap();
	String tableName = "pro_products";
	Map adminInfo = (Map)session.getAttribute("adminInfo");
	String adminName="";
	if(adminInfo!=null){
	adminName=CommonString.getFormatPara(adminInfo.get("usern"));
	}
	try{
		connection = dbHelper.getConnection();
		String id = CommonString.getFormatPara(request.getParameter("id"));
		String channelUUID = CommonString.getFormatPara(request.getParameter("channel_uuid"));
		if(null!=id&&!"".equals(id)){
			model = dbHelper.getMap(" select * from "+tableName+" where id = ? ",new Object [] {id} , connection);
		}
		if("".equals(channelUUID)&&null!=model){
			channelUUID = (String)model.get("channel_uuid");
		}
		
		//List <Map> brandList = (ArrayList)application.getAttribute("brandList");
		List <Map> brandList =  dbHelper.getMapList(" select id,name,upper_index from pro_agent_factory where is_show=1 and flag=1 order by upper_index",connection) ;
		List <Map> catalogAppList = (ArrayList<Map>)application.getAttribute("catalogList");
		List <Map> catalogList = CommonApplication.getTreeByPno("0", catalogAppList , "parentid","id");
		String factoryid = "" ;
		String no="";
		if(null!=model){
			factoryid = CommonString.getFormatPara(model.get("factoryid")) ;  // 品牌 id 
			no = CommonString.getFormatPara(model.get("catalognum")); // 

		}		
	List<Map> procatalogAppList = dbHelper.getMapList(" select id,parentid,num,catalogname from pro_factory_category where factoryid=?",new Object[]{factoryid}) ;
	List <Map> procatalogList = null ;
	  if(procatalogAppList!=null){
		  procatalogList = CommonApplication.getTreeByPno("0", procatalogAppList , "parentid","num");
	  }
	  Map ishotMap = new HashMap() ;
	  ishotMap.put("10","否") ;
	  ishotMap.put("11","是") ;
	  List<Map> list = Tools.getCategoryParam(no,"106001");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Env.getInstance().getProperty("project_name") %></title>
<link href="/plugin/ui/ligerUI/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/Gray/css/all.css" rel="stylesheet" type="text/css" />
<link href="/plugin/ui/ligerUI/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/plugin/other/highslide/highslide.css" />
<link href="/backend/style/style.css" rel="stylesheet" type="text/css" />
<script src="/plugin/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_config_normal.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/editor/ueditor/editor_all_min.js"></script>
<link rel="stylesheet" type="text/css" href="/plugin/editor/ueditor/themes/default/ueditor.css"/>
</head>
<body style="margin: 0;padding: 0; overflow-x: hidden;overflow-y: auto; ">
<form name="theform" id="theform" action="/backend/action/crud.jsp">
  <div class="formDiv">
    <div style="clear:left;"></div>
    <div class="formLeft">产品型号</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_name" id="zd_name" value="<%=CommonString.getFormatPara(model.get("name")) %>"<%if(id.equals("")){ %> onblur="setFileName(this.value);" <%} %>/>
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">品<span class="span2">&nbsp;</span>牌</div>
    <div class="formRight">
      <select class="jr_select" id="zd_factoryid" name="zd_factoryid" onchange="jQuery('#zd_factoryname').val(jQuery('#zd_factoryid').find('option:selected').attr('id'))">
        <option value="">--请选择品牌--</option>
        <%if(brandList != null){for(Map m : brandList){%>
        <option value="<%=m.get("id")%>" id="<%=m.get("name")%>"  <%if(CommonString.getFormatPara(model.get("factoryid")).equals(m.get("id").toString())){%> selected="selected"<%}%>><%=m.get("upper_index")%>-<%=m.get("name")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_factoryname" id="zd_factoryname" value="<%=CommonString.getFormatPara(model.get("factoryname")) %>"  style="width:270px"/>
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">类<span class="span2">&nbsp;</span>别</div>
    <div class="formRight">
      <select class="jr_select" id="zd_catalognum" name="zd_catalognum" onchange="jQuery('#zd_catalogname').val(jQuery.trim(jQuery('#zd_catalognum').find('option:selected').text()));getarea(this.options[this.selectedIndex].value);">
        <option value="">--请选择产品类别--</option>
        <%if(catalogList != null){for(Map m : catalogList){
		  if(CommonString.getFormatPara(m.get("num")).equals("121")){
		  %>
        <%}else{%>
        <option
		<%if(CommonString.getFormatPara(m.get("num")).equals("101")||CommonString.getFormatPara(m.get("num")).equals("101001")||CommonString.getFormatPara(m.get("num")).equals("101002")||CommonString.getFormatPara(m.get("num")).equals("101003")||CommonString.getFormatPara(m.get("num")).equals("106001")||CommonString.getFormatPara(m.get("num")).equals("101005")||CommonString.getFormatPara(m.get("num")).equals("101008")||CommonString.getFormatPara(m.get("num")).equals("102")||CommonString.getFormatPara(m.get("num")).equals("103")||CommonString.getFormatPara(m.get("num")).equals("104")||CommonString.getFormatPara(m.get("num")).equals("105")||CommonString.getFormatPara(m.get("num")).equals("107")||CommonString.getFormatPara(m.get("num")).equals("110")||CommonString.getFormatPara(m.get("num")).equals("109")||CommonString.getFormatPara(m.get("num")).equals("111")||CommonString.getFormatPara(m.get("num")).equals("118")||CommonString.getFormatPara(m.get("num")).equals("122")){%>
	      disabled="true" 
		<%}%>
		value="<%=m.get("num")%>" <%if(CommonString.getFormatPara(model.get("catalognum")).equals(m.get("num").toString())){%> selected="selected"<%}%>>
        <%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("name")%>
        </option>
        <%}}}%>
      </select>
    </div>
    <div class="formRight" style="width:350px">
      <input type="text" class="jr_text" name="zd_catalogname" id="zd_catalogname" value="<%=CommonString.getFormatPara(model.get("catalogname")) %>" style="width:270px" />
      <span style="color:red">(产品名称)</span>
      <input type="hidden" class="jr_text" name="zd_catalognum_new" id="zd_catalognum_new" value="<%=CommonString.getFormatPara(model.get("catalognum_new")) %>" style="width:270px" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">旗舰店类别</div>
    <div class="formRight">
      <select class="jr_select" id="zd_catalognum_spe" name="zd_catalognum_spe" onchange="jQuery('#zd_catalogname_spe').val(jQuery.trim(jQuery('#zd_catalognum_spe').find('option:selected').text()));">
        <option value="">--请选择产品类别--</option>
        <%if(procatalogList != null){for(Map m : procatalogList){%>
        <option value="<%=m.get("num")%>" <%if(CommonString.getFormatPara(model.get("catalognum_spe")).equals(m.get("num").toString())){%> selected="selected"<%}%>><%=CommonForm.getSpace(m.get("num").toString(),1)%><%=m.get("catalogname")%></option>
        <%}}%>
      </select>
    </div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_catalogname_spe" id="zd_catalogname_spe" value="<%=CommonString.getFormatPara(model.get("catalogname_spe")) %>" style="width:270px" />
    </div>
    <div style="clear: left;"></div>
    <div class="formLeft">产品图片</div>
    <div class="formRight">
      <input type="text" style="width: 400px;" class="jr_text" name="zd_img2" id="zd_img2" value="<%=CommonString.getFormatPara(model.get("img2")) %>" />
    </div>
    <div class="formRight" style="padding-left: 240px; position: relative; top:-2px;width:240px">
	<div style="float:right"> 尺寸：900*600</div>
      <input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_img2',700,480);" value="选择图片" />
      <a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_img2");'>
      <input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" />
      </a></div>
    <div style="clear:left;"></div>
    <div class="formLeft">吨位/米</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_tonandmeter" id="zd_tonandmeter" value="<%=CommonString.getFormatPara(model.get("tonandmeter")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">价格区间</div>
    <div class="formRight" style="width:155px; text-align:left">
      <input type="text" class="jr_text" name="zd_price_start" id="zd_price_start" value="<%=CommonString.getFormatPara(model.get("price_start")).equals("")?"0":CommonString.getFormatPara(model.get("price_start")) %>" style="width:130px" />
      &nbsp;万 </div>
    <div class="formLeft" style="width:10px; text-align:left">-</div>
    <div class="formRight" style="width:200px; text-align:left">
      <input type="text" class="jr_text" name="zd_price_end" id="zd_price_end" value="<%=CommonString.getFormatPara(model.get("price_end")).equals("")?"0":CommonString.getFormatPara(model.get("price_end")) %>" style="width:130px" />
      &nbsp;万 </div>
	<div style="clear:left;"></div>
    <div class="formLeft">备注</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_remark" id="zd_remark" value="<%=CommonString.getFormatPara(model.get("remark")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="group"> <span><img src="/plugin/ui/ligerUI/ligerUI/skins/icons/communication.gif"/> </span> <span class="groupTitle">拓展信息</span> </div>
    <div style="clear:left;"></div>
    <div class="formLeft">文件名称</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_file_name" id="zd_file_name" value="<%=CommonString.getFormatPara(model.get("file_name")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">web_title</div>
    <div class="formRight">
      <input type="text" class="jr_text" name="zd_web_title" id="zd_web_title" value="<%=CommonString.getFormatPara(model.get("web_title")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">点击次数</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_view_count" id="zd_view_count" value="<%=CommonString.getFormatPara(model.get("view_count")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">产品列表排序</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_order_no" id="zd_order_no" value="<%=CommonString.getFormatPara(model.get("order_no")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">是否显示</div>
    <div class="formRight"> <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_show")),"zd_is_show") %> </div>
    <div class="formLeft">是否热卖(旗舰店)</div>
    <div class="formRight" style="width:100px;"> <%=CommonForm.createRadio(ishotMap,CommonString.getFormatPara(model.get("zoomlion_hot")),"zd_zoomlion_hot") %> </div>
    <div class="formLeft" style="width:150px;">是否推荐到产品列表页</div>
    <div class="formRight"> <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_rec")).equals("")?"0":CommonString.getFormatPara(model.get("is_rec")),"zd_is_rec") %></div>
    <div style="clear:left;"></div>
    <div class="formLeft"><font color="red">热卖图片</font></div>
    <div class="formRight">
      <input type="text" readonly style="width: 400px;" class="jr_text" name="zd_zoomlion_hot_pic" id="zd_zoomlion_hot_pic" value="<%=CommonString.getFormatPara(model.get("zoomlion_hot_pic")) %>" />
    </div>
    <div class="formRight" style="padding-left: 220px; position: relative; top:-2px;">
      <input style="float:right;" type="button" class="btn" onclick="chooseFile('zd_zoomlion_hot_pic',700,480);" value="选择图片" />
      <a href="javascript:void(0);" class='highslide' onclick='return smallToBig(this,"zd_zoomlion_hot_pic");'>
      <input style="float:right; margin-right: 5px;" type="button" class="btn" value="预览" />
      </a> </div>
    <div style="clear:left;"></div>
    <div class="formLeft" style="width:150px;color:green">生产年限(停产9999)</div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_year" id="zd_year" value="<%=CommonString.getFormatPara(model.get("year")).equals("")?"1":CommonString.getFormatPara(model.get("year")) %>" />
    </div>
    <div class="formLeft" style="width:100px;color:green">是否推广</div>
    <div class="formRight"> <%=CommonForm.createIsRadio(CommonString.getFormatPara(model.get("is_hot")).equals("")?"0":CommonString.getFormatPara(model.get("is_hot")),"zd_is_hot") %> </div>
    <div style="clear:left;"></div>
    <div class="formLeft" style="width:150px;color:green"><a href="/products/" target="_blank">热门机型</a></div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_hot_num" id="zd_hot_num" value="<%=CommonString.getFormatPara(model.get("hot_num")).equals("")?"0":CommonString.getFormatPara(model.get("hot_num")) %>" />
    </div>
    <div class="formLeft" style="width:100px;color:green"><a href="/products/" target="_blank">新品展示</a></div>
    <div class="formRight">
      <input type="text" class="jr_text" style="width:100%;" name="zd_new_num" id="zd_new_num" value="<%=CommonString.getFormatPara(model.get("new_num")).equals("")?"0":CommonString.getFormatPara(model.get("new_num")) %>" />
    </div>
    <div style="clear:left;"></div>
    <div class="formLeft">产品介绍</div>
    <div class="formRight" style="height: 320px; text-align: left;">
      <script type="text/plain" id="editor_introduce" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("introduce")) %></script>
      <input type="hidden" name="zd_introduce" id="zd_introduce" value='' />
    </div>
    <div style="clear:left;"></div>
    <!--<div class="formLeft">产品参数</div>
    <div class="formRight" style="height: 300px; text-align: left;">
      <script type="text/plain" id="editor_paras" style="width:650px; height:200px;"><%=CommonString.getFormatPara(model.get("paras")) %></script>
      <input type="hidden" name="zd_paras" id="zd_paras" value='' />
    </div>
    <br>
	-->
    <div style="clear:left;"></div>
    <div class="formLeft">可选器具</div>
    <div class="formRight" style="height: 100px; text-align: left;">
      <script type="text/plain" id="editor_instruments" style="width:650px; height:100px;"><%=CommonString.getFormatPara(model.get("instruments")) %></script>
      <input type="hidden" name="zd_instruments" id="zd_instruments" value='' />
    </div>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<div style="clear:left;"></div>
    <div class="formLeft" style="margin-top:150px">备选参数</div>
    <div class="formRight" style="height: 100px; text-align: left;">
      <script type="text/plain" id="editor_alternative_param" style="width:650px; height:100px;"><%=CommonString.getFormatPara(model.get("alternative_param")) %></script>
      <input type="hidden" name="zd_alternative_param" id="zd_alternative_param" value='' />
    </div>
  </div>
  <div style="clear: left;"></div>
  <input type="hidden" name="tableName" id="tableName" value="<%=tableName %>" />
  <input type="hidden" name="zd_id" id="zd_id" value="<%=CommonString.getFormatPara(model.get("id")) %>" />
  <input type="hidden" name="eventAfter" value="productsCreate" />
  <input type="hidden" name="zd_last_modify_date" id="zd_last_modify_date"  value="<%=CommonDate.getToday("yyyy-MM-dd HH:mm:ss") %>"/>
</form>
</body>
</html>
<script type="text/javascript" src="/plugin/jquery/jquery.form.js"></script>
<script src="/plugin/ui/ligerUI/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/backend/scripts/common.js" prefix="<%=tablePrefix %>" type="text/javascript"></script>
<script src="/plugin/validator/wofoshan/validator.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/plugin/other/highslide/highslide.min.js"></script>
<script type="text/javascript">
	hs.graphicsDir = '/plugin/other/highslide/graphics/';
	hs.wrapperClassName = 'wide-border';
	var result = 0 ;
	function doSub(){
		var arr = '最,最佳,最具,最爱,最赚,最优,最优秀,最好,最大,最大程度,最高,最高级,最高档,最奢侈,最低,最低级,最低价,最底,最便宜,时尚最低价,最流行,最受欢迎,最时尚,最聚拢,最符合,最舒适,最先,最先进,最先进科学,最先进加工工艺,最先享受,最后,最后一波,最新,最新科技,最新科学,第一,中国第一,全网第一,销量第一,排名第一,唯一,第一品牌,NO.1,TOP.1,独一无二,全国第一,一流,一天,仅此一次,最后一波,大品牌之一,国家级,国家级产品,全球级,宇宙级,世界级,顶级,顶尖,尖端,顶级工艺,顶级享受,极品,极佳,绝佳,绝对,终极,极致,首个,首选,独家,独家配方,全国首发,首款,全国销量冠军,国家级产品,国家,国家免检,国家领导人,填补国内空白,中国驰名,驰名商标,国际品质,王牌,领袖品牌,世界领先,遥遥,领先,领导者,缔造者,创领品牌,领先上市,巨星,著名,掌门人,至尊,巅峰,奢侈,优秀,资深,领袖,之王,王者,冠军,史无前例,前无古人,永久,万能,祖传,特效,无敌,纯天然,100%,高档,正品,真皮,超赚,精准,史无前例,前无古人,永久,万能,祖传,特效,无敌,纯天然,100%,点击领奖,恭喜获奖,全民免单,点击有惊喜,点击获取,点击转身,点击试穿,点击翻转,秒杀,抢爆,再不抢就没了,不会更便宜了,错过就没机会了,万人疯抢,全民疯抢,抢购,抢疯了,卖疯了,几天几夜,倒计时,趁现在,仅限,周年庆,特惠趴,购物大趴,闪购,品牌团,精品团,随时结束,随时涨价,马上降价,老字号,中国驰名商标,特供,专供,专家推荐,质量免检,无需国家质量检测,免抽检,领导人推荐,机关推荐,顶尖技术,业内领先,使用人民币图样'.split(',');
		var tishi='';
		for(var i in arr){
			if(ue_introduce.getContent().indexOf(arr[i])>=0 ){
			   tishi=tishi+arr[i]+',';
           
			}
        }
        if(tishi!=''){
			jrSuccess("产品介绍中含有敏感词:"+tishi)
		}		

		var rs = Validator.Validate(document.getElementById("theform"),1);
		if(rs){
			jQuery.ajax({
				type:"post",
				url:"/backend/action/ajax_r.jsp",
				data:{ flag:'checkFileName',id:'<%=CommonString.getFormatPara(model.get("id")) %>',file_name: jQuery("#zd_file_name").val()  },
				success:function(data){
					if(jQuery.trim(data)=='success'){				
					    result = rs ;
	                    savaProductAndParam(); 
					}else{
						result=-1;
			            jrWarn("产品文件名重复，请修改文件名");
			            return;
					}
				}	
			})
		}
		if(result>0)
		{
		  return true ;
		}
	}
	
	//保存方法
	function savaProductAndParam(){
		//参数保存----
		var paramV = document.getElementsByName("param");
		var zd_param = "["
		for(var i =0;paramV.length > 0 && i<paramV.length;i++){
			//组装json
			if(i==paramV.length-1){
				zd_param += "{"+paramV[i].lang+",'value':'"+paramV[i].value+"'}";	
			}else{
				zd_param += "{"+paramV[i].lang+",'value':'"+paramV[i].value+"'},";
			}
		}
		zd_param += "]";
		jQuery("#zd_param").val(zd_param);
		
		jQuery.ajax({
			url : '/backend/action/ajax_cud.jsp',	
			data : { paramStr:zd_param , product_no:'<%=no%>' , flag:'saveParamValue' , enumNo:'106013' },
			type : 'post',
			async : false
		});
		//参数保存----
		//关键参数项保存，设置该产品有的关键参数项
		var keyparam = "[";
		jQuery.each(jQuery("table[id^=key_]"),function(){
			keyparam += "{"+jQuery(this).attr("lang")+",'param':[";
			var pKey = jQuery(this).find("input:checkbox");
			for(var i = 0; i < pKey.length; i++){
				if(pKey[i].checked){
					keyparam += pKey[i].value+",";	
				}
			}
			if(keyparam.substring(keyparam.length-1) == ","){
				keyparam = keyparam.substring(0,keyparam.length-1);
			}
			keyparam += "]},";
		});
		if(keyparam.substring(keyparam.length-1) == ","){
			keyparam = keyparam.substring(0,keyparam.length-1);
		}
		keyparam += "]";
		jQuery("#zd_param_key").val(keyparam);
		
		jQuery("#theform").ajaxSubmit({
				type : "POST",
				async : false ,
				success : function(data) {
					var rs = parseInt(jQuery.trim(data), 10);
					if (rs > 0) {
						jrSuccess("保存成功！");
						<%
						if("".equals(id)){
							%>
						window.location.reload();
							<%
						}
						%>
					} 
				}
			});	
	}
	
    var ue_introduce = new baidu.editor.ui.Editor({
    	textarea : 'zd_introduce',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_introduce.render('editor_introduce');
    ue_introduce.addListener("selectionchange",function(){
	    var state_introduce = ue_introduce.queryCommandState("source");
	    document.getElementById("zd_introduce").value=ue_introduce.getContent();
	});
	

    /**var ue_paras = new baidu.editor.ui.Editor({
    	textarea : 'zd_paras',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_paras.render('editor_paras');
    ue_paras.addListener("selectionchange",function(){
	    var state_paras = ue_paras.queryCommandState("source");
	    document.getElementById("zd_paras").value=ue_paras.getContent();
	});**/
	 var ue_instruments = new baidu.editor.ui.Editor({
    	textarea : 'zd_instruments',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_instruments.render('editor_instruments');
    ue_instruments.addListener("selectionchange",function(){
	    var state_instruments = ue_instruments.queryCommandState("source");
	    document.getElementById("zd_instruments").value=ue_instruments.getContent();
	});
	
	var ue_alternative_param = new baidu.editor.ui.Editor({
    	textarea : 'zd_alternative_param',
    	autoHeightEnabled:false,
    	minFrameHeight:220
    });
    ue_alternative_param.render('editor_alternative_param');
    ue_alternative_param.addListener("selectionchange",function(){
	    var state_alternative_param = ue_alternative_param.queryCommandState("source");
	    document.getElementById("zd_alternative_param").value=ue_alternative_param.getContent();
	});
	
    document.getElementById("zd_instruments").value = ue_instruments.getContent();
	document.getElementById("zd_alternative_param").value = ue_alternative_param.getContent();
	//document.getElementById("zd_paras").value = ue_paras.getContent();
	document.getElementById("zd_introduce").value = ue_introduce.getContent();
	function smallToBig(o,id){
		jQuery(o).attr("href","/uploadfiles/"+jQuery("#"+id).val());
		return hs.expand(o);
	}
	function setFileName(value){
		var jsonData = {"name":value,"flag":"file_name"};
		jQuery.ajax({
				type:"post",
				url:"/backend/action/ajax_r.jsp",
				data:jsonData,
				success:function(data){
					jQuery("#zd_file_name").val(jQuery.trim(data));
				}
				
			})
	}
	function getarea(a){
	jQuery.post("/backend/pro_products/tools/ajax_catalog_new.jsp",{"catalognum":a},function(data){$('#zd_catalognum_new').val(data);});
    }
	function showParam(category){
		jQuery.ajax({
			url : 'get_param_html.jsp',
			data : { category : category , no : '<%=no%>' } ,
			type : 'post' ,
			async : false ,
			success : function(data){
				jQuery("#paramId").css("display","block");
				jQuery("#paramId").html(data);
			}
		});
	}
	//为参数赋值
	var param = <%=CommonString.getFormatPara(model.get("param")).equals("")?"[]":CommonString.getFormatPara(model.get("param"))%>;
	for(var i = 0; i < param.length; i++){
		if(jQuery("#"+param[i].no) != null){
			jQuery("#"+param[i].no).val(param[i].value);
		}
	}
	//为关键参数项赋值
	var paramKey = <%=CommonString.getFormatPara(model.get("param_key")).equals("")?"[]":CommonString.getFormatPara(model.get("param_key"))%>;
	for(var i = 0; i < paramKey.length; i++){
		for(var j = 0; j < paramKey[i].param.length; j++){
			var paramA = paramKey[i].param[j];
			jQuery("#"+paramA.no).attr("checked","checked");
		}
	}
</script>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBHelper.freeConnection(connection);
	}
%>