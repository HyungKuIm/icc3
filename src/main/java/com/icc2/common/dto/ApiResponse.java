package com.icc2.common.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ApiResponse<T> {
	private boolean ok;
    private T data;
    private String message;
}
