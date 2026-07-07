package com.icc2.home.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j2;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
@Controller
@Log4j2
public class HomeController {
	

	@RequestMapping(path = {"/", "/home"}, method = GET)
	public String home(Model model) {
		log.info("home");
		
		return "Main";
	}

}
