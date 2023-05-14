package org.zerock.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.zerock.domain.EmployeeDTO;

import lombok.Getter;

@Getter
public class CustomUser extends User {

	private EmployeeDTO employee;

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomUser(EmployeeDTO dto) {
		super(dto.getEmp_no().toString(), dto.getEmp_pw(), dto.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.employee = dto;
	}

}
