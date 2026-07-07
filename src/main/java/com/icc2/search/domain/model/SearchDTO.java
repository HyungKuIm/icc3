package com.icc2.search.domain.model;

import java.time.LocalDate;

import lombok.Data;

@Data
public class SearchDTO {
	private int product_id;
	private String product_name;
	private String company_name;
	private String image_url;
	private String product_type;
	private LocalDate start_date;
	private LocalDate end_date;
	private String coverage_items;
	private int min_premium;
	private int max_premium;
	private int rating;
	
	
}
