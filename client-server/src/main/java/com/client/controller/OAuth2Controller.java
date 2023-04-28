package com.client.controller;

import com.client.model.AccessToken;
import com.client.model.UserPojo;
import com.client.model.UserUtils;
import com.client.service.OAuth2Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Map;

@Controller
public class OAuth2Controller {
    private static final String CLIENT_ID = "mobile";
    private static final String CLIENT_SECRET = "pin";
    private static final String REDIRECT_URI = "http://localhost:8080/oauth/callback";

    @Autowired
    private OAuth2Service oAuth2Service;

    @Autowired
    private UserUtils userUtils;

    @GetMapping("/oauth/callback")
    public String oauthCallback(@RequestParam Map<String, String> requestParam, HttpServletRequest request) throws IOException {
        if (requestParam == null || requestParam.isEmpty()) {
            return "redirect:/404";
        } else if (requestParam.containsKey("error")) {
            return "redirect:/404";
        }
        AccessToken bodyAccessToken = oAuth2Service.getAccessToken(CLIENT_ID, CLIENT_SECRET, REDIRECT_URI, requestParam.get("code"), requestParam.get("state"));
        String accessToken = bodyAccessToken.getAccessToken();
        String refreshToken = bodyAccessToken.getRefreshToken();

        UserPojo userPojo = userUtils.getUserInfo(accessToken);
        UserDetails userDetail = userUtils.buildUser(userPojo);
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetail, null,
                userDetail.getAuthorities());
        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        return "redirect:/user";
    }
}
