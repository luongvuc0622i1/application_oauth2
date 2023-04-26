package com.resource.controller;

import com.resource.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MailController {
    @Autowired
    private MailService mailService;

    @GetMapping("/verifyCode")
    public ResponseEntity verifyCode(@RequestParam String email){
        mailService.sendEmail(email,"verify","http://localhost:8080/changePassword?email="+email);
        return ResponseEntity.ok("sent");
    }
}
