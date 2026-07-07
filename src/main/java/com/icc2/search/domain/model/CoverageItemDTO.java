package com.icc2.search.domain.model;

import lombok.Data;

//담보(보장항목)

@Data
public class CoverageItemDTO {
	private Long id;
    private String name;
    private String description;
    private Integer coverageAmount;
    private Integer waitingPeriodDays;
    private String benefitLimit;
}
