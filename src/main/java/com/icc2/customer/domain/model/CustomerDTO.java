package com.icc2.customer.domain.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;



@Data
public class CustomerDTO implements UserDetails {
	private int id;
	private String name;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birth_date;
	private String gender;
	private String occupation;
	private String email;
	private String pw;
	private LocalDateTime reg_date;
	private LocalDateTime mod_date;
	private int age;
	
	private List<CustomerRole> roleNames;

    // 권한 추가
    public void addRole(CustomerRole role) {
        if (roleNames == null) {
            roleNames = new ArrayList<>();
        }
        roleNames.add(role);
    }

    // 권한 클리어
    public void clearRoles() {
        roleNames.clear();
    }
	
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        if (roleNames == null || roleNames.isEmpty()) {
            return List.of();
        }

        return roleNames.stream()
                .map(customerRole -> new SimpleGrantedAuthority("ROLE_" + customerRole.name()))
                .collect(Collectors.toList());
    }

    @Override
    public String getPassword() {
        return pw;
    }

    @Override
    public String getUsername() {
        return email;
    }

}
