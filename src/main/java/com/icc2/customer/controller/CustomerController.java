package com.icc2.customer.controller;


import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icc2.customer.domain.model.CustomerDTO;
import com.icc2.customer.service.CustomerService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    //로그인 페이지 보기
    @RequestMapping(value="/login.do", method=GET)
    public String loginView() {

        return "customer/login";
    }

    //회원가입 페이지 보기
    @RequestMapping(value="/addCustomer.do",method = GET)
    public String showAddCustomerForm() {
        return "customer/register";
    }

    // 회원가입처리
    @RequestMapping(value="/addCustomer.do",method = POST)
    public String processAddCustomer(CustomerDTO customerDTO) {
        if(customerDTO == null) {
            return "customer/register";
        }
        customerService.addCustomer(customerDTO);
        return "redirect:/login.do";
    }

    //이메일 중복체크
    @ResponseBody
    @RequestMapping(value="/emailCheck",method = POST,produces = "application/json")
    public Map<String, Object> emailCheck(@RequestParam("email") String email) {

        int result = customerService.emailCheck(email);

        return Map.of("check", result);
    }

    @PreAuthorize("isAuthenticated()")  // 로그인한 사용자 본인만 접근 가능
    // 마이페이지
    @RequestMapping(value="/info.do", method = GET)
    public String info(@AuthenticationPrincipal CustomerDTO customerDTO, Model model) {
        // 서비스 클래스를 통해 사용자 정보를 조회합니다
        CustomerDTO customerInfo = customerService.myInfo(customerDTO.getId());

        // 모델에 사용자 정보를 추가합니다
        model.addAttribute("info", customerInfo);

        return "mypage/mypage";
    }

    //개인정보 수정
    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value="/update.do", method=POST)
    public String updateInfo(CustomerDTO customerDTO) throws Exception {
        customerService.updateInfo(customerDTO);

        return "redirect:/";
    }

    //회원탈퇴
    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/deleteView.do", method = GET)
    public String deleteView() {
        return "mypage/mypage_unregister";
    }
    
    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value="/deleteAccount.do", method=POST)
    public String deleteAccount(@AuthenticationPrincipal CustomerDTO customerDTO,
                                RedirectAttributes redirectattr,
                                @RequestParam("pw") String pw,
                                HttpServletRequest request,
                                HttpServletResponse response) {


        //비밀번호 검사
        boolean isPw=customerService.checkPw(customerDTO.getId(),pw);
        if(!isPw) {
            redirectattr.addFlashAttribute("errorMessage","비밀번호가 올바르지 않습니다. 다시 시도하세요.");
            return "redirect:/deleteView.do";
        }
        // 사용자 계정 삭제

        customerService.deleteCustomer(customerDTO.getId());

        // Spring Security 세션 & 인증정보 삭제
        new SecurityContextLogoutHandler().logout(request, response, null);

        // 탈퇴 후 메인 페이지로 리디렉션
        return "redirect:/";
    }

    
}
