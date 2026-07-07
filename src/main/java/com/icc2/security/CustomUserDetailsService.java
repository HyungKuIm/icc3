package com.icc2.security;


import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.icc2.customer.domain.mapper.CustomerMapper;
import com.icc2.customer.domain.model.CustomerDTO;
import com.icc2.customer.domain.model.CustomerRole;

@Service
@Log4j2
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        log.info("----------loadUserByUsername------------" + username);

        CustomerDTO customerDTO = customerMapper.findByEmail(username);
        customerDTO.addRole(CustomerRole.USER);

        return customerDTO;
    }
}
