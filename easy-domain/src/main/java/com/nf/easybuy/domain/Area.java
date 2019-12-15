package com.nf.easybuy.domain;

import java.io.Serializable;

public class Area implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer areaId;
	private Integer parentId;
	private String type;
	private String name;
	public Integer getAreaId() {
		return areaId;
	}
	public void setAreaId(Integer areaId) {
		this.areaId = areaId;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
