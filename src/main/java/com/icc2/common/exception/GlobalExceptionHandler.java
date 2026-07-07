package com.icc2.common.exception;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.icc2.common.dto.ApiResponse;

//GlobalExceptionHandler.java
@RestControllerAdvice
public class GlobalExceptionHandler {

 @ExceptionHandler(IllegalArgumentException.class)
 public ResponseEntity<ApiResponse<Void>> handleBadRequest(IllegalArgumentException e) {
     return ResponseEntity
         .badRequest()
         .body(ApiResponse.<Void>builder().ok(false).message(e.getMessage()).build());
 }

 @ExceptionHandler(IllegalStateException.class)
 public ResponseEntity<ApiResponse<Void>> handleConflict(IllegalStateException e) {
     // 가입불가 등 ‘상태 충돌’ → 409가 의미상 잘 맞음
     return ResponseEntity
         .status(409)
         .body(ApiResponse.<Void>builder().ok(false).message(e.getMessage()).build());
 }

 // (선택) 인증/인가
 @ExceptionHandler(org.springframework.security.access.AccessDeniedException.class)
 public ResponseEntity<ApiResponse<Void>> handleForbidden(Exception e) {
     return ResponseEntity.status(403)
         .body(ApiResponse.<Void>builder().ok(false).message("접근 권한이 없습니다.").build());
 }

 @ExceptionHandler(org.springframework.security.core.AuthenticationException.class)
 public ResponseEntity<ApiResponse<Void>> handleUnauth(Exception e) {
     return ResponseEntity.status(401)
         .body(ApiResponse.<Void>builder().ok(false).message("로그인이 필요합니다.").build());
 }

 // (옵션) 마지막 안전망
 @ExceptionHandler(Exception.class)
 public ResponseEntity<ApiResponse<Void>> handleEtc(Exception e) {
     return ResponseEntity.status(500)
         .body(ApiResponse.<Void>builder().ok(false).message("처리 중 오류가 발생했습니다.").build());
 }
}

