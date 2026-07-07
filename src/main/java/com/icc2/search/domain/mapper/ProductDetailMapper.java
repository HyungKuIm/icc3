package com.icc2.search.domain.mapper;

import com.icc2.search.domain.model.InsuranceProductDetailDTO;

public interface ProductDetailMapper {
	InsuranceProductDetailDTO selectProductDetail(int productId);
}
