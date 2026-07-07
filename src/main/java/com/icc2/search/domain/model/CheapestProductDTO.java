package com.icc2.search.domain.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class CheapestProductDTO {
	private Long productId;        // p.id (권장: 식별자 포함)
    private String productName;    // p.name
    private Long companyId;        // c.id (선택)
    private String companyName;    // c.name
    private String imageUrl;
    private BigDecimal premium;    // pc.premium (금융 도메인이라 BigDecimal 권장)
}
