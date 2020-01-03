package com.jerehnet.util.getproducts;

public enum TempProductFlag {
	// imported("已导入", 1), unhandle("未导入", 2), nothandle("不处理", 3), imported_update("导入后更新", 4), nothandle_update("不处理后更新", 5),changed("已修改", 6);
	imported("已导入", 1), unhandle("未处理", 2), nothandle("扔弃", 3), imported_update("刚更新未处理", 4), nothandle_update("刚更新未处理", 5),changed("已修改", 6);

	private String name;
	private int value;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	private TempProductFlag(String name, int value) {
		this.name = name;
		this.value = value;
	}

	public static TempProductFlag valueOf(int value) {
		TempProductFlag rtn = null;
		for (TempProductFlag e : TempProductFlag.values()) {
			if (e.getValue() == value) {
				rtn = e;
			}
		}
		return rtn;
	}

}
