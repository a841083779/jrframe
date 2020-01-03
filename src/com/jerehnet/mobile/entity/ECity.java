package com.jerehnet.mobile.entity;

import java.io.Serializable;

public class ECity implements Serializable
	{
		/**
		 * @authour xuml
		 * @todo TODO
		 * @data 下午6:31:43
		 */
		private int id;
		
		
		private String CityName;
		public int getId()
		{
			return id;
		}
		
		public void setId(int id)
		{
			this.id = id;
		}
		public String getCityName()
		{
			return CityName;
		}
		public void setCityName(String cityName)
		{
			CityName = cityName;
		}
		
	}
