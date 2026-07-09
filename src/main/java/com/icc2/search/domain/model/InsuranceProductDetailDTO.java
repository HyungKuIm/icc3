package com.icc2.search.domain.model;

import java.util.List;

import lombok.Data;

@Data
public class InsuranceProductDetailDTO {
	private Long id;
    private String name;
    private String productType;
    private java.time.LocalDate startDate;
    private java.time.LocalDate endDate;
    private String rating;
    private Integer liked;
    private int likedCount;

    private InsuranceCompanyDTO company;               // association (1)
    private List<CoverageItemDTO> coverageItems;      // collection (N)
    private List<PremiumConditionDTO> premiumConditions; // collection (N)
}
