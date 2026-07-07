package com.icc2.customer.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icc2.customer.domain.mapper.CustomerMapper;
import com.icc2.customer.domain.model.CustomerDTO;


@Service
public class CustomerService {

    @Autowired
    private CustomerMapper customerMapper;


    @Autowired
    private BCryptPasswordEncoder passwordEncoder;


    // 회원가입
    @Transactional
    public void addCustomer(CustomerDTO customer) {
        String rawPw = customer.getPw();
        String encPw = passwordEncoder.encode(rawPw);
        customer.setPw(encPw);
        System.out.println(customer);
        System.out.println(customer.getPw());
        customerMapper.addCustomer(customer);

    }

    // 이메일 중복 체크
    public int emailCheck(String email) {
        return customerMapper.emailCheck(email);
    }

    // 마이페이지
    public CustomerDTO myInfo(int customer_id) {

    	CustomerDTO customerDTO = customerMapper.getCustomerInfo(customer_id);

        if (customerDTO == null) {
            throw new IllegalArgumentException("customer not found for ID: " + customer_id);
        }

        return customerDTO;
    }





    //수정
    @Transactional
    public void updateInfo(CustomerDTO customer) {
        // 비밀번호 변경이 입력된 경우만 암호화 처리
        if (customer.getPw() != null && !customer.getPw().isEmpty()) {
            String rawPw = customer.getPw();
            String encPw = passwordEncoder.encode(rawPw);
            customer.setPw(encPw);
        }
        customerMapper.updateInfo(customer);

    }
    
    @Transactional
    public void deleteCustomer(int i) {
    	customerMapper.deleteAccount(i);
    }
    
    
    // 비밀번호 검사
    public boolean checkPw(int custId, String inputPassword) {
        // 데이터베이스에서 사용자 정보 가져오기
        CustomerDTO customer = customerMapper.getCustomerInfo(custId);

        // 입력된 비밀번호와 데이터베이스에 저장된 비밀번호 비교
        if (customer != null) {
            //return customer.getPw().equals(inputPassword); // 비밀번호가 일치하는지 확인
        	return passwordEncoder.matches(inputPassword, customer.getPw());
        }
        return false; // 사용자 정보가 없으면 false 반환
    }

    



}
