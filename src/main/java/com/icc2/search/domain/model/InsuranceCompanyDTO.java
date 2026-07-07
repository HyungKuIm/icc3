package com.icc2.search.domain.model;

import lombok.Data;

// 보험사

@Data
public class InsuranceCompanyDTO {
	private Long id;
    private String name;
    private String phone;
    private String website;
    private String imageUrl;
}
