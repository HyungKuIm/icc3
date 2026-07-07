package com.icc2.analysis.domain.mapper;

import org.apache.ibatis.annotations.Param;

import com.icc2.analysis.domain.model.AnalysisResultDTO;

public interface AnalysisMapper {
	int upsertCoverageAnalysis(@Param("customerId") int customerId,
            @Param("productId") int productId,
            @Param("age") int age,
            @Param("gender") String gender,
            @Param("includeUnisex") boolean includeUnisex);
	
	boolean existsEligiblePremium(@Param("productId") int productId,
            @Param("age") int age,
            @Param("gender") String gender,
            @Param("includeUnisex") boolean includeUnisex);
	
	AnalysisResultDTO selectAnalysisResult(@Param("customerId") int customerId,
            @Param("productId") int productId,
            @Param("age") int age,
            @Param("gender") String gender,
            @Param("includeUnisex") boolean includeUnisex);
}
