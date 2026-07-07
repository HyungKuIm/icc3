package com.icc2.analysis.domain.model;

import lombok.Data;

@Data
public class AnalysisRequest {

    private int productId;

    private int customerId;
    private Boolean includeUnisex = Boolean.TRUE; // 남녀공용 조건 허용 여부(기본 true)
}
