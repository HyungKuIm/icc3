package com.icc2.search.domain.model;

import lombok.Data;

// 보험료 조건

@Data
public class PremiumConditionDTO {
	private Long id;
    private Integer minAge;
    private Integer maxAge;
    private Gender gender;                // ENUM 매핑
    private Integer premium;
    private Integer paymentPeriodYears;
    private Integer insurancePeriodYears;
}
