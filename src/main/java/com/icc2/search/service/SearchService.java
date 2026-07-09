package com.icc2.search.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icc2.search.domain.mapper.ProductDetailMapper;
import com.icc2.search.domain.mapper.SearchMapper;
import com.icc2.search.domain.model.CheapestProductDTO;
import com.icc2.search.domain.model.EligibleProductDTO;
import com.icc2.search.domain.model.InsuranceProductDetailDTO;
import com.icc2.search.domain.model.ProductCoverageRecommendationDTO;
import com.icc2.search.domain.model.SearchDTO;

@Service
public class SearchService {
	
	@Autowired
	private SearchMapper searchMapper;
	
	@Autowired
	private ProductDetailMapper productDetailMapper;
	
	public List<SearchDTO> getProductsByName(String name) {
		return searchMapper.findByName(name);
	}
	
	public InsuranceProductDetailDTO getProductById(int prodId, Integer custId) {
		return productDetailMapper.selectProductDetail(prodId, custId);
	}
	
	public List<EligibleProductDTO> getEligibleProducts(int custId) {
		return searchMapper.findByCust(custId);
	}
	
	public List<ProductCoverageRecommendationDTO> getRichProducts() {
		return searchMapper.selectCoverageRichProducts();
	}
	
	public List<CheapestProductDTO> getCheapProduct(int age, String gender, boolean unisex) {
		return searchMapper.selectCheapestByAgeGender(age, gender, unisex);
		
	}
	
}
