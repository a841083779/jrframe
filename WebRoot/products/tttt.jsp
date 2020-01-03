  <ul class="ConditionBottom">
        <script type="text/javascript">
	  jQuery(document).ready(function() {
		  jQuery(".pbtn").click(function(){
			  jQuery(this).next("div").slideToggle(0)
			  .siblings(".plmore:visible").slideUp(0);
			  jQuery(this).toggleClass("pbon");
			  jQuery(this).siblings(".pbon").removeClass("pbon");
		  });	
	  });
	  </script>
        <li class="cblist">
          <dt> 类别 </dt>
          <input type="hidden" name="factory" id="factory_id" />
          <input type="hidden" name="catalog" id="catalognum" />
          <dd> <a href="/products/prolist.jsp" <%if("".equals(catalog)){%> class='select' <%} %>>不限</a> <a href="/products/prolist.jsp?catalog=101001" <%if("101001".equals(catalog)){%> class='select' <%} %>>挖掘机</a> <a href="/products/prolist.jsp?catalog=101002" <%if("101002".equals(catalog)){%> class='select' <%} %>>装载机</a> <a href="/products/prolist.jsp?catalog=102" <%if("102".equals(catalog)){%> class='select' <%} %>>起重机</a> <a href="/products/prolist.jsp?catalog=101003" <%if("101003".equals(catalog)){%> class='select' <%} %>>推土机</a> <a href="/products/prolist.jsp?catalog=103" <%if("103".equals(catalog)){%> class='select' <%} %>>混凝土</a> <a href="/products/prolist.jsp?catalog=106001" <%if("106001".equals(catalog)){%> class='select' <%} %>>压路机</a> <a href="/products/prolist.jsp?catalog=101005" <%if("101005".equals(catalog)){%> class='select' <%} %>>平地机</a> <a href="/products/prolist.jsp?catalog=105003" <%if("105003".equals(catalog)){%> class='select' <%} %>>旋挖钻</a> <a href="/products/prolist.jsp?catalog=113001" <%if("113001".equals(catalog)){%> class='select' <%} %>>破碎锤</a> <a href="/products/prolist.jsp?catalog=104001" <%if("104001".equals(catalog)){%> class='select' <%} %>>摊铺机</a>
            <div id="changethis" class="pbtn"></div>
            <div class="plmore" style="padding-left: 0px; width: 680px;;">
            <jsp:include page="/include/products/catalog.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
            <jsp:param value="<%=order%>" name="order"/>
            </jsp:include>   
            </div>
          </dd>
        </li>
        <li class="cblist">
          <dt> 品牌 </dt>
          <dd>
            <%
											if (!"".equals(catalog)) {
										%>
            <a onClick="sosuo('<%=catalog%>','','<%=tonandmeter%>');"
											href="javascript:void(0)" <%if("".equals(factoryid)){%>
											class="select" <%} %>>不限</a>
            <%
											List<Map> recommend_brands = dbHelper
															.getMapList(" select catalognum,catalogname,factoryid,factoryname from pro_catalog_factory where catalognum ='" + catalog
																	+ "' order by order_no desc",connection);
													if (null != recommend_brands && recommend_brands.size() > 0) {
														int i = 0;
														for (Map oneMap : recommend_brands) {
															i++;
															if (i == 20) {
																break;
															}
										%>  
            <!-- 挖掘机 --> 
            <a
											onclick="sosuo('<%=catalog%>','<%=CommonString.getFormatPara(oneMap.get("factoryid"))%>','<%=tonandmeter%>')"
											href="javascript:;"
											<%if(CommonString.getFormatPara(oneMap.get("factoryid")).equals(factoryid)){%>
											class="select" <%} %>><%=CommonString.getFormatPara(oneMap.get("factoryname"))%></a>
            <%
											}
													}
												} else {
										%>
            <a <%if("".equals(factoryid)){%> class='select' <%} %> href="/products/prolist.jsp">不限</a> 
            <!-- 挖掘机 --> 
            <a <%if("133".equals(factoryid)){%> class='select' <%} %> href="/products/prolist.jsp?factory=133<%=catalog.equals("")?"":"&catalog="+catalog%>">三一</a> 
            <!-- 挖掘机 --> 
            <a <%if("182".equals(factoryid)){%>
											class='select' <%} %> href="/products/prolist.jsp?factory=182<%=catalog.equals("")?"":"&catalog="+catalog%>">小松</a> 
            <!-- 挖掘机 --> 
            <a <%if("192".equals(factoryid)){%>
											class='select' <%} %> href="/products/prolist.jsp?factory=192<%=catalog.equals("")?"":"&catalog="+catalog%>">斗山</a> 
            <!-- 挖掘机 --> 
            <a <%if("184".equals(factoryid)){%>
											class='select' <%} %> href="/products/prolist.jsp?factory=184<%=catalog.equals("")?"":"&catalog="+catalog%>">日立</a> 
            <!-- 挖掘机 --> 
            <a <%if("183".equals(factoryid)){%>
											class='select' <%} %> href="/products/prolist.jsp?factory=183<%=catalog.equals("")?"":"&catalog="+catalog%>">神钢</a> 
            <!-- 挖掘机 --> 
            <a <%if("175".equals(factoryid)){%>
											class='select' <%} %> href="/products/prolist.jsp?factory=175<%=catalog.equals("")?"":"&catalog="+catalog%>">沃尔沃</a> 
            <!-- 挖掘机 --> 
            <a <%if("174".equals(factoryid)){%>
											class='select' <%} %> href="/products/prolist.jsp?factory=174<%=catalog.equals("")?"":"&catalog="+catalog%>">卡特彼勒</a> 
            <!-- 挖掘机 --> 
            <a <%if("146".equals(factoryid)){%>
											class='select' <%} %> href="/products/prolist.jsp?factory=146<%=catalog.equals("")?"":"&catalog="+catalog%>">玉柴重工</a> 
            <!-- 挖掘机 --> 
            <a <%if("136".equals(factoryid)){%>
											class='select' <%} %> href="/products/prolist.jsp?factory=136<%=catalog.equals("")?"":"&catalog="+catalog%>">柳工</a> 
            <!-- 挖掘机 --> 
            <a <%if("194".equals(factoryid)){%>
											class='select' <%} %> href="/products/prolist.jsp?factory=194<%=catalog.equals("")?"":"&catalog="+catalog%>">现代京城</a>
            <a <%if("1220".equals(factoryid)){%>
											class='select' <%} %> href="/products/prolist.jsp?factory=1220<%=catalog.equals("")?"":"&catalog="+catalog%>">华通动力</a>
            <%
											}
										%>
            <div id="changethis" class="pbtn"></div>
            <div class="plmore" style="padding-left: 0px; width: 680px;">
            <jsp:include page="/include/products/brand.jsp" flush="true">
            <jsp:param value="<%=catalog%>" name="catalog"/>
            <jsp:param value="<%=factoryid%>" name="factoy_id"/>
            <jsp:param value="<%=tonandmeter%>" name="tonandmeter"/>
            <jsp:param value="<%=order%>" name="order"/>
            </jsp:include>
            </div>
          </dd>
        </li>
        <li class="cblist" id="grab" style="display: none;">
          <dt> 吨位 </dt>
          <dd>
            <input type="hidden" name="tonandmeter" id="tonandmeter" />
            <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_1_13')"
											<%if("grab_1_13".equals(tonandmeter)){%> class="select" <%}%>>小挖(1T～13T)</a>&nbsp; <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_14_30')"
											<%if("grab_14_30".equals(tonandmeter)){%> class="select"
											<%}%>>中挖(14T～30T)</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','grab_30_1')"
											<%if("grab_30_1".equals(tonandmeter)){%> class="select" <%}%>>大挖(30T以上)</a> </dd>
        </li>
        <li class="cblist" style="display: none;" id="loader">
          <dt> 吨位 </dt>
          <dd> <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_1_3')"
											<%if("loader_1_3".equals(tonandmeter)){%> class="select"
											<%}%>>3T以下</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_3_01')"
											<%if("loader_3_01".equals(tonandmeter)){%> class="select"
											<%}%>>3T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_3_5')"
											<%if("loader_3_5".equals(tonandmeter)){%> class="select"
											<%}%>>3T～5T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','loader_5_1')"
											<%if("loader_5_1".equals(tonandmeter)){%> class="select"
											<%}%>>5T以上</a> </dd>
        </li>
        <li class="cblist" style="display: none;" id="crane">
          <dt> 吨位 </dt>
          <dd> <a href="javascript:void(0)"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>')"
											<%if("".equals(tonandmeter)){%> class="select" <%}%>>不限</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_1_16')"
											<%if("crane_1_16".equals(tonandmeter)){%> class="select"
											<%}%>>16T以下</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_20_70')"
											<%if("crane_20_70".equals(tonandmeter)){%> class="select"
											<%}%>>20T～70T</a> <a href="javascript:;"
											onclick="sosuo('<%=catalog%>','<%=factoryid%>','crane_70_1')"
											<%if("crane_70_1".equals(tonandmeter)){%> class="select"
											<%}%>> 70T以上</a> </dd>
        </li>
        
   
 
 
 

        <script type="text/javascript">
	            if('<%=catalog%>'.indexOf("101001")!=-1){
	              jQuery("#grab").attr("style","display:;") ;
	            }
	               if('<%=catalog%>'.indexOf("101002")!=-1){
	              jQuery("#loader").attr("style","display:;") ;
	            }
	               if('<%=catalog%>'.indexOf("102")!=-1){
	              jQuery("#crane").attr("style","display:;") ;
	            }
	          </script>
      </ul>