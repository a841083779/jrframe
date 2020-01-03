package com.jerehnet.mobile.statistics;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.jerehnet.util.common.CommonDate;

/**
 * 统计日期类
 * 
 * @author sunyanbin
 * @date   2014-10-21
 */
public class BusinessDate {
	/**
	 * 根据当前日期获得本周周一至周日日期
	 * @return
	 */
	public static List<String> dateToWeek(){
	      
		  Date date = new Date();
		  int b=date.getDay();
		  Date fdate ;
		  List <String> list = new ArrayList();
		  Long fTime=date.getTime()-b*24*3600000;
		  
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		  
		  for(int a=0;a<9;a++){	  
			  fdate= new Date();
			  fdate.setTime(fTime+(a*24*3600000));
			  String dateStr=sdf.format(fdate);
			  list.add(a, dateStr);
		  }
		  return list;
	}
public static void main(String [] args){
	//Date date = new Date(); 
	//System.out.println("周一："+ BusinessDate.dateToWeek().get(1) +"，"+"周日:"+BusinessDate.dateToWeek().get(7));
	
}
}