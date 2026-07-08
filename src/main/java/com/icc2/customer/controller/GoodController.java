package com.icc2.customer.controller;

import com.icc2.customer.service.GoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

@Controller
public class GoodController {

    @Autowired
    private GoodService goodService;

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
