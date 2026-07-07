package com.icc2.analysis.domain.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class AnalysisResultDTO {
	private int productId;
    private int customerId;
    private int totalCoverage;            // 담보 합계
    private BigDecimal minPremium;
    private BigDecimal avgPremium;
    private BigDecimal maxPremium;
    private String message;
    
}
