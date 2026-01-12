package com.hs.controller;

import java.io.IOException;

import com.hs.mvc.annotation.Controller;
import com.hs.mvc.annotation.RequestMapping;
import com.hs.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/member/settings/*")
public class SettingController {
	
	@RequestMapping("")
	public ModelAndView settings(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
	    return new ModelAndView("member/settings");
	}

    @RequestMapping("/profile")
    public String settingsProfile() {
        return "member/setting/settings_profile";
    }

    @RequestMapping("/account")
    public String settingsAccount() {
        return "member/setting/settings_account";
    }
}
