package com.icc2.customer.controller;

import com.icc2.customer.domain.model.CustomerDTO;
import com.icc2.customer.service.GoodService;
import com.icc2.search.domain.model.SearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

@Controller
public class GoodController {

    @Autowired
    private GoodService goodService;

    @PreAuthorize("isAuthenticated()")
    @RequestMapping(value = "/myGood.do", method = GET)
    //마이패이지 좋아요
    public ModelAndView getLikedProds(@AuthenticationPrincipal CustomerDTO customerDTO,
                                      @RequestParam(value="page", defaultValue = "1") int page) {
        int pageSize = 2; //페이지당 상품 수
        int totalProds = goodService.getLikedProdsCount(customerDTO.getId());  // 전체 상품수(좋아요한)
        List<SearchDTO> prods = goodService.getLikedProds(customerDTO.getId(), page, pageSize);
        ModelAndView mav = new ModelAndView("mypage/mypage_like");
        mav.addObject("prods", prods);
        mav.addObject("currentPage", page);
        mav.addObject("totalPages", (int)Math.ceil((double) totalProds / pageSize));
        return mav;
    }

    //상세페이지 좋아요
    @RequestMapping(value="/addGood.do", method=POST)
    @ResponseBody
    public String addGood(@RequestParam("custId") String custId,
                          @RequestParam("prodId") int prodId) {
        if(custId.isEmpty()) {
            return "needlogin";
        }
        String findGoodResult = goodService.findGood(custId, prodId);
        if(findGoodResult != null && findGoodResult.equals("Y")) {
            return "already";
        }

        goodService.addGood(custId, prodId);

        return "done";
    }
}
