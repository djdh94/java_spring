package com.ict.domain;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum=1; 
	private int number=10;
	
	public int getPageStart() {
		return (this.pageNum-1)*number;
	}
	
	public int getPageEnd() {
		return this.pageNum*number;
	}
}
