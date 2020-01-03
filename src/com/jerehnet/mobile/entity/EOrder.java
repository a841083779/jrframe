package com.jerehnet.mobile.entity;

import java.io.Serializable;
/**
 * 订单表
 * @author Administrator
 */
public class EOrder implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private int flag;
	private String orderNo;
	private String machineNo;
	private String machineImg;
	private String createDate;
	private String linkMan;
	private String linkTel;
	private String address;
	private String receiveDate;
	private String receiveMan;
	private String receiveManId;
	//private String lastRecordDate;
	private int agentId;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getMachineNo() {
		return machineNo;
	}
	public void setMachineNo(String machineNo) {
		this.machineNo = machineNo;
	}
	public String getMachineImg() {
		return machineImg;
	}
	public void setMachineImg(String machineImg) {
		this.machineImg = machineImg;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getLinkMan() {
		return linkMan;
	}
	public void setLinkMan(String linkMan) {
		this.linkMan = linkMan;
	}
	public String getLinkTel() {
		return linkTel;
	}
	public void setLinkTel(String linkTel) {
		this.linkTel = linkTel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getReceiveDate() {
		return receiveDate;
	}
	public void setReceiveDate(String receiveDate) {
		this.receiveDate = receiveDate;
	}
	public String getReceiveMan() {
		return receiveMan;
	}
	public void setReceiveMan(String receiveMan) {
		this.receiveMan = receiveMan;
	}
	public String getReceiveManId() {
		return receiveManId;
	}
	public void setReceiveManId(String receiveManId) {
		this.receiveManId = receiveManId;
	}
	
//	public String getLastRecordDate() {
//		return lastRecordDate;
//	}
//	public void setLastRecordDate(String lastRecordDate) {
//		this.lastRecordDate = lastRecordDate;
//	}
//	
	public int getAgentId() {
		return agentId;
	}
	public void setAgentId(int agentId) {
		this.agentId = agentId;
	}

}
