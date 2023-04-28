package com.client.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

@Controller
public class ClientController {
    private final String REDIRECT_URL_VERIFY_PASS = "redirect:http://localhost:8081/oauth/authorize?target=4&email=";

    @RequestMapping(value = { "/", "/login" })
    public ModelAndView login() {
        return new ModelAndView("login");
    }

    @RequestMapping("/user")
    public ModelAndView user() {
        return new ModelAndView("userpage");
    }

    @RequestMapping("/admin")
    public ModelAndView admin() {
        return new ModelAndView("adminpage");
    }

    @RequestMapping("/403")
    public ModelAndView error403() {
        return new ModelAndView("403page");
    }

    @RequestMapping("/404")
    public ModelAndView error404() {
        return new ModelAndView("404page");
    }

    @GetMapping("/changePassword")
    public ModelAndView changePassword(@RequestParam Map<String, String> requestParam) {
        String email = requestParam.get("email");
        return new ModelAndView(REDIRECT_URL_VERIFY_PASS + email);
    }
}
