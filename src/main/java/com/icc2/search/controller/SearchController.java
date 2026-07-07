package com.icc2.search.controller;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.icc2.search.domain.model.CheapestProductDTO;
import com.icc2.search.domain.model.InsuranceProductDetailDTO;
import com.icc2.search.domain.model.ProductCoverageRecommendationDTO;
import com.icc2.search.service.SearchService;

@Controller
public class SearchController {

	@Autowired
	private SearchService searchService;
	
	// 보험 검색
	@RequestMapping(path="/search.do")
	public String searchInsurance(@RequestParam(value="keyWord", required=false) String Keyword, Model model) {
		
		
		
		model.addAttribute("SRArrSDTO", searchService.getProductsByName(Keyword));
		return "search/clinic_theme";
	}
	
	// 보험 상세
	@RequestMapping(path = "/detail.do", method = GET)
	public String detailInsurance(@RequestParam("prodId") Integer prodId, Model model) {
		

		InsuranceProductDetailDTO prodDetail = searchService.getProductById(prodId);
		model.addAttribute("ProdDetail", prodDetail);
		
		return "search/prod_detail";
	}
	
	// 보장금액 많은 보험 상품 추천
	@RequestMapping(path="/goRich.do", method = GET)
	public String goRich(@RequestParam(value = "page", defaultValue = "1") int page,
						Model model) {
		int pageSize = 12; // 페이지당 항목 수를 12로 설정


		List<ProductCoverageRecommendationDTO> allRiches = searchService.getRichProducts();

		// 총 항목 수
		int totalItems = allRiches.size();

		// 전체 페이지 수 계산
		int totalPages = (int) Math.ceil((double) totalItems / pageSize);

		// 현재 페이지의 항목 추출
		int startIndex = (page - 1) * pageSize;
		int endIndex = Math.min(startIndex + pageSize, totalItems);

		// 페이징 범위 체크
		if (startIndex >= totalItems) {
			startIndex = Math.max(totalItems - pageSize, 0);
			endIndex = totalItems;
		}

		List<ProductCoverageRecommendationDTO> pageItems = allRiches.subList(startIndex, endIndex);

		// 모델에 데이터 추가
		model.addAttribute("CVArrRDTO", pageItems);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("pageSize", pageSize);

		return "recommend/Rich_Re";
	}
	
	// 연령별/성별 저렴한 보험료 추천
	@RequestMapping(path="/goCheap.do", method = GET)
	public String goAge(@RequestParam(value = "page", defaultValue = "1") int page,
						@RequestParam(value = "age", defaultValue = "30") int age, 
						@RequestParam(value = "gender", defaultValue = "M") String gender, 
						@RequestParam(value = "unisex", defaultValue = "false") boolean unisex, 
						
						Model model) {
		int pageSize = 12; // 페이지당 항목 수를 12로 설정


		List<CheapestProductDTO> allCheaps = searchService.getCheapProduct(age, gender, unisex);

		// 총 항목 수
		int totalItems = allCheaps.size();

		// 전체 페이지 수 계산
		int totalPages = (int) Math.ceil((double) totalItems / pageSize);

		// 현재 페이지의 항목 추출
		int startIndex = (page - 1) * pageSize;
		int endIndex = Math.min(startIndex + pageSize, totalItems);

		// 페이징 범위 체크
		if (startIndex >= totalItems) {
			startIndex = Math.max(totalItems - pageSize, 0);
			endIndex = totalItems;
		}

		List<CheapestProductDTO> pageItems = allCheaps.subList(startIndex, endIndex);

		// 모델에 데이터 추가
		model.addAttribute("AGArrRDTO", pageItems);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("pageSize", pageSize);

		return "recommend/Cheap_Re";
	}
	
	// 가입가능상품 추천
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(path="/goMy.do", method = GET)
	public String goMy(@RequestParam("custId") int custId,Model model) {
		model.addAttribute("URArrPDTO", searchService.getEligibleProducts(custId));
		return "recommend/My_Re";
	}
}
