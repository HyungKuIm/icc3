package com.icc2.analysis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icc2.analysis.domain.mapper.AnalysisMapper;
import com.icc2.analysis.domain.model.AnalysisResultDTO;
import com.icc2.customer.domain.mapper.CustomerMapper;
import com.icc2.customer.domain.model.CustomerDTO;

@Service
public class AnalysisService {

	@Autowired
	private AnalysisMapper analysisMapper;
	
	@Autowired
	private CustomerMapper customerMapper;
	

    @Transactional
    public AnalysisResultDTO runForProduct(int customerId, int productId, boolean includeUnisex) {
		// 1)고객 프로필 가져오기
		CustomerDTO customerDTO = customerMapper.getCustomerInfo(customerId);
		if (customerDTO == null) throw new IllegalArgumentException("고객정보 없음");
		
		// 2) (선택) 가입 가능 여부 확인
        boolean eligible = analysisMapper.existsEligiblePremium(productId, customerDTO.getAge(),
        		customerDTO.getGender(), includeUnisex);
        if (!eligible) {
            // 가입 불가 → 저장하지 않고 오류 반환(또는 저장은 하되 메시지만 안내하도록 정책 선택)
            throw new IllegalStateException("해당 연령/성별로 가입 가능한 조건이 없습니다.");
        }
        
     // 3) 업서트 (고객 조건으로 최저 보험료 저장)
        analysisMapper.upsertCoverageAnalysis(
                customerId, productId, customerDTO.getAge(), customerDTO.getGender(), includeUnisex);

        // 4) 결과 SELECT → DTO
        AnalysisResultDTO res = analysisMapper.selectAnalysisResult(
                customerId, productId, customerDTO.getAge(), customerDTO.getGender(), includeUnisex);

        // 5) 메시지 등 후처리
        if (res != null) {
            res.setMessage("보장분석이 완료되었습니다.");
        }
        return res;
        
        
	}
	
}
