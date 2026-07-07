package com.icc2.search.domain.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class ProductCoverageRecommendationDTO {
	private Long productId;                 // p.id (GROUP BY 기준)
    private String productName;             // p.name
    private Long companyId;        // c.id (선택)
    private String companyName;    // c.name
    private String imageUrl;
    private BigDecimal totalCoverageAmount; // SUM(ci.coverage_amount)
    private BigDecimal avgPremium;          // AVG(pc.premium)
}
