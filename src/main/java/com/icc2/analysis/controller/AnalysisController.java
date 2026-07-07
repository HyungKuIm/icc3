package com.icc2.analysis.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.icc2.analysis.domain.model.AnalysisRequest;
import com.icc2.analysis.domain.model.AnalysisResultDTO;
import com.icc2.analysis.service.AnalysisService;
import com.icc2.common.dto.ApiResponse;

@Controller
public class AnalysisController {

	@Autowired
	private AnalysisService analysisService;
	
	@RequestMapping(path = "/runForProduct.do", consumes = "application/json", produces = "application/json", method = RequestMethod.POST)
    public ResponseEntity<ApiResponse<AnalysisResultDTO>> runForProduct(@RequestBody AnalysisRequest req) {
		
		 // 3) 서비스 실행 (가입 가능 여부 체크 + UPSERT + 집계 결과)
        AnalysisResultDTO result = analysisService.runForProduct(req.getCustomerId(),
                                                                 req.getProductId(),
                                                                 Boolean.TRUE.equals(req.getIncludeUnisex()));
        return ResponseEntity.ok(
            ApiResponse.<AnalysisResultDTO>builder()
                .ok(true).data(result)
                .build()
        );
	}
}
