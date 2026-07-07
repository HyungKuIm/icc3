package com.icc2.customer.domain.mapper;

import com.icc2.customer.domain.model.CustomerDTO;

public interface CustomerMapper {
	void addCustomer(CustomerDTO customerDTO);
    int emailCheck(String email);
    CustomerDTO findByEmail(String email);
    CustomerDTO getCustomerInfo(int id);
    void updateInfo(CustomerDTO customerDTO);
    
    void deleteAccount(int id);
}
