package com.icc2.search.domain.model;

import lombok.Data;

@Data
public class EligibleProductDTO {
	private int product_id;
	private String product_name;
	private String company_name;
	private int premium;
	private int min_age;
	private int max_age;
}
