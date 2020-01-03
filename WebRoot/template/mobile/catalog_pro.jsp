 <#list query("select factoryid from pro_agent_product_vi where agent_id="${agent_id}"   group by factoryid") as fac_sec>
  <#list query("select top 1 catanum ,cataname,factoryname,factoryid from pro_agent_product_vi where factoryid="${fac_sec.factoryid}" and is_show=1 group by catanum) as fac_pro>
<div class="dl_detail">
  <h3><a href="agent_pro.jsp?agent_id=${agent_id}&catalog=${fac_pro.catanum}&catalog=${fac_pro.factoryid}" class="more">更多</a>${fac_pro.factoryname}${fac_pro.cataname}<h3>
  <ul class="fix">
  <#list query("select agentproductid  from pro_agent_product_vi where catanum="${fac_pro.catanum}" and is_show=1) as fac_thr>
	  <#list query(" top 2 id,factoryname,catalogname,name,img2 from pro_products where id='${fac_thr.agentproductid}' and is_show=1) as fac_for>
    <li><a href="#">
	<img src="/uploadfiles/<#if fac_for.img2?indexOf('image')>0>${fac_for.img2?substring(6,fac_for.img?length())}<#else>${fac_for.img2}</#if>" class="img"  onerror="/uploadfiles/no_small.gif" /> 
	<strong>${fac_for.factoryname}${fac_for.name}${fac_for.catalogname}></strong> </a>
	<a class="btn dj"  href="tel:4006-521-526"><img src="Static/img/dl_btn_bg_06.png">询问底价</a>
	<a class="btn dg" href="/form.jsp?pid=${fac_for.id}"><img src="Static/img/dl_btn_bg_03.png">立即订购</a></li>
</list>
</list>
  </ul>
</div>
</list>
</list>


