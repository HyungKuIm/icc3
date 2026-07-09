package com.icc2.search.domain.mapper;

import com.icc2.search.domain.model.InsuranceProductDetailDTO;
import org.apache.ibatis.annotations.Param;

public interface ProductDetailMapper {
	InsuranceProductDetailDTO selectProductDetail(@Param("productId") int productId,
												  @Param("custId") Integer custId);
}
