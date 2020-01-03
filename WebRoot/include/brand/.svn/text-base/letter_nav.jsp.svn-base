<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div class="suoyin">
  <div class="brand_new clearfix" id="suoyinfloat">
    <div class="brand_select">
      <strong class="n">品牌直达</strong>
      <div class="nsel">
        <b class="n" style="width:50px;">一级类别</b>
        <span class="sel">
        <select name="catalog" id="catalog" disabled="disabled">
          <option value="">请选择一级类别</option>
        </select>
        </span>
      </div>
      <div class="nsel">
        <b class="n" style="width:50px;">二级类别</b>
        <span class="sel">
        <select name="catalog_sub" id="catalog_sub" disabled="disabled">
          <option value="">请选择二级类别(可不选)</option>
        </select>
        </span>
      </div>
      <div class="nsel">
        <b class="n">品牌</b>
        <span class="sel">
        <select name="factoryid" id="factoryid" disabled="disabled">
          <option value="">请选择品牌(可不选)</option>
        </select>
        </span>
      </div>
      <div class="btn">
        <input type="submit" name="doCheck" id="doCheck" value="搜索" onclick="doSearch();" style="cursor: pointer;"/>
      </div>
    </div>
    <div class="brand_letter">
      <strong class="n">按首字母索引</strong>
      <div class="treeSubNavv1">
        <ul id="tree_letter">
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#A" target="_blank">A</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#B" target="_blank">B</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#C" target="_blank">C</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#D" target="_blank">D</a></li>
          <li class="none">E</li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#F" target="_blank">F</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#G" target="_blank">G</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#H" target="_blank">H</a></li>
          <li class="none">I</li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#J" target="_blank">J</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#K" target="_blank">K</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#L" target="_blank">L</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#M" target="_blank">M</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#N" target="_blank">N</a></li>
          <li class="none">O</li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#P" target="_blank">P</a></li>
         <li><a onclick="javascript:;" href="/brand/index_b.shtm#Q" target="_blank">Q</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#R" target="_blank">R</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#S" target="_blank">S</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#T" target="_blank">T</a></li>
          <li class="none">U</li>
          <li class="none">V</li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#W" target="_blank">W</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#X" target="_blank">X</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#Y" target="_blank">Y</a></li>
          <li><a onclick="javascript:;" href="/brand/index_b.shtm#Z" target="_blank">Z</a></li>
          <li class="all"><a onclick="javascript:;" href="/brand/index_b.shtm" target="_blank">全部</a></li>
        </ul>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="/brand/choose_cascade/choose_cascade_date.js"></script>
  <script type="text/javascript" src="/scripts/smart_float.js"></script>
  <script type="text/javascript">
  	function doSearch(){
  		var catalog = jQuery("#catalog").val() ;
  		var catalog_sub = jQuery("#catalog_sub").val() ;
  		var factoryid = jQuery("#factoryid").val() ;
  		if(''!=factoryid){
  			window.open("/brand/"+factoryid+"/") ;
  		}else if(''!=catalog_sub){
  			window.open("list.jsp?catalognum="+catalog_sub) ;
  		}else if(''!=catalog){
  			window.open("list.jsp?catalognum="+catalog) ;
  		}
  	}
relatedSelect(
{id:"catalog",url:"/brand/choose_cascade/level_1_json_chooser.jsp",node:{root:"catalog", value:"id", text:"text",custom:"id"},load:true},
{id:"catalog_sub",url:"/brand/choose_cascade/level_2_json_chooser.jsp?text=",node:{root:"catalog_sub", value:"id", text:"text",custom:"id"}},
{id:"factoryid",url:"/brand/choose_cascade/level_3_json_chooser.jsp?text=",node:{root:"factoryid", value:"id", text:"text",custom:"id"}}
); 
  </script>
</div>