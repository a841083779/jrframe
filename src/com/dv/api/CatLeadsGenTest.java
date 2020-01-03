package com.dv.api;




public class CatLeadsGenTest {

	public static void main(String[] stra){
		   String xml = "<Cat>" +
           "<UserInfo>" +
               "<UserID>164048</UserID>" +
               "<Name>观青平</Name>" +
               "<Gender></Gender>" +
               "<Mobile>13574381719</Mobile>" +
               "<Telephone></Telephone>" +
               "<Company></Company>" +
               "<Position></Position>" +
               "<Province></Province>" +
               "<City></City>" +
               "<Birthday></Birthday>" +
               "<PurchasePeriod></PurchasePeriod>" +
               "<ExcavatorSize>30</ExcavatorSize>" +
               "<ExcavatorModel>349D2/349D2 L</ExcavatorModel>" +
               "<AgreeContact>Y</AgreeContact>" +
               "<OrderMessage></OrderMessage>" +
               "<RegDate>2018-02-06 12:01:41</RegDate>" +
               "<RegisterType>询价</RegisterType>" +
               "<DataSource>CATWAJI</DataSource>" +
               "<MediaSource><![CDATA[None|http://www.catwaji.com/enquiry.html?id=130|None|None|None]]></MediaSource>" +
               "<DataSourceCode>CG0108</DataSourceCode>" +
               "<GAID></GAID>" +
               "<UTM_SOURCE>None</UTM_SOURCE>" +
               "<UTM_MEDIUM>http://www.catwaji.com/enquiry.html?id=130</UTM_MEDIUM>" +
               "<UTM_CONTENT><![CDATA[None]]></UTM_CONTENT>" +
               "<UTM_CAMPAIGN>None</UTM_CAMPAIGN>" +
               "<UTM_TERM>None</UTM_TERM>" +
           "</UserInfo>" +
       "</Cat>";
        DvRequestEntity requestEntity = new DvRequestEntity(DvConstants.METHOD_CAT_BCP_USERINFO, DvConstants.FORMAT_XML,1,xml);
        String response = new DvHttpClient().execute(requestEntity);
        System.out.println(response);
	}
	
 


 
}
