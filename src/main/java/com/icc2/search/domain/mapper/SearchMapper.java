package com.icc2.search.domain.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.icc2.search.domain.model.CheapestProductDTO;
import com.icc2.search.domain.model.EligibleProductDTO;
import com.icc2.search.domain.model.ProductCoverageRecommendationDTO;
import com.icc2.search.domain.model.SearchDTO;

public interface SearchMapper {
	List<SearchDTO> findByName(String keyword);
	List<EligibleProductDTO> findByCust(int custId);
	List<ProductCoverageRecommendationDTO> selectCoverageRichProducts();
	List<CheapestProductDTO> selectCheapestByAgeGender(@Param("age") int age,
            @Param("gender") String gender,   // 'M' or 'F'
            @Param("includeUnisex") boolean includeUnisex);
}
