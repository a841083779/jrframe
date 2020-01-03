<%@ page language="java" import="java.util.*,com.jerehnet.util.common.*" pageEncoding="UTF-8"%><%@ page session="false" %>
<div class="search contain980 mb10">
  <div class="quickSearch">
    <form id="top_search" name="top_search" method="get" action="/products/prolist.jsp" target="_blank">
      <strong>快速搜索：</strong>
      <div class="qsi l">
        <input type="text" name="keyword" id="keyword" maxlength="30" value="<%=CommonString.getFormatPara(request.getParameter("keyword"))%>"/>
      </div>
    </form>
      <div class="qsb l">
        <input type="button" name="button" id="button" value="&nbsp;" onClick="document.top_search.submit();" />
      </div>
  </div>
  <div class="brandSearch">
    <form id="form2" name="form2" method="get" action="/products/prolist.jsp" target="_blank">
      <strong>品牌搜索：</strong>
      <div class="bsi l" style="height:20px;">
        <select id="factory" name="factory" style="width:120px">
              <option selected="selected" value=""> 选择品牌 </option>
            </select>
            <select  id="catalog" name="catalog" disabled="disabled" style="width:160px">
              <option selected="selected" value=""> 选择机型　　 </option>
            </select>
      </div>
      <div class="bsb l">
        <input type="submit" value="&nbsp;" />
      </div>
    </form>
  </div>
  <ul class="searchCate">
    <li><a href="/brand/">按品牌查找</a></li>
    <li><a href="/top_list/">按排行查找</a></li>
    <li><a href="/products/">按机型查找</a></li>
  </ul>
</div>
