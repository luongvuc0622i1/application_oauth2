package com.client.controller;

import com.client.model.AccessToken;
import com.client.service.OAuth2Service;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import static org.springframework.http.HttpStatus.*;

@Controller
public class OAuth2Controller {
    private static final String CLIENT_ID = "mobile";
    private static final String CLIENT_SECRET = "pin";
    private static final String REDIRECT_URI = "http://localhost:8080/oauth/callback";
    private final String REDIRECT_URL_ACCOUNT = "redirect:http://localhost:8081/oauth/authorize?client_id=mobile&response_type=code&redirect_uri=http://localhost:8080/oauth/callback&scope=WRITE";
    private final String REDIRECT_URL_VERIFY_PASS = "redirect:http://localhost:8081/oauth/authorize?target=4&email=";
    private final String REDIRECT_URL_INFO = "redirect:http://localhost:8081/users/profile?access_token=";
    private final String REDIRECT_URL_LOGOUT_1 = "redirect:http://localhost:8081/oauth/revoke_token?access_token=";
    private final String REDIRECT_URL_LOGOUT_2 = "&refresh_token=";

    @Autowired
    private OAuth2Service oAuth2Service;

    @GetMapping("/oauth/callback")
    public ModelAndView oauthCallback(@RequestParam Map<String, String> requestParam, HttpSession session) {
        ModelAndView modelAndView = new ModelAndView();
        if (requestParam == null || requestParam.isEmpty()) {
            modelAndView.setViewName("error");
            modelAndView.setStatus(FORBIDDEN);
            return modelAndView;
        } else if (requestParam.containsKey("error")) {
            modelAndView.setViewName("error");
            modelAndView.setStatus(NOT_FOUND);
            return modelAndView;
        }
        AccessToken bodyAccessToken = oAuth2Service.getAccessToken(CLIENT_ID, CLIENT_SECRET, REDIRECT_URI, requestParam.get("code"), requestParam.get("state"));
        String accessToken = bodyAccessToken.getAccessToken();
        String refreshToken = bodyAccessToken.getRefreshToken();
        String username = this.getUsernameFrom8081Info(accessToken);

        modelAndView.setViewName("home");
        modelAndView.setStatus(OK);
        modelAndView.addObject("accessToken", accessToken);
        modelAndView.addObject("username", username);

        session.setAttribute("username", username);
        session.setAttribute("access_token", accessToken);
        session.setAttribute("refresh_token", refreshToken);
        return modelAndView;
    }

    private String getUsernameFrom8081Info(String accessToken) {
        String https_url = "http://localhost:8081/users/profile?access_token="+accessToken;
        URL url;
        String username = "";
        try {
            url = new URL(https_url);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // print result
            ObjectMapper mapper = new ObjectMapper();
            JsonNode node = mapper.readTree(String.valueOf(response));
            return node.get("username").asText();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @GetMapping("/account")
    public ModelAndView account(HttpSession session) {
        String accessToken = (String) session.getAttribute("access_token");
        String username = (String) session.getAttribute("username");
        if (accessToken != null) {
            ModelAndView modelAndView = new ModelAndView("home");
            modelAndView.addObject("username", username);
            return modelAndView;
        }
        return new ModelAndView(REDIRECT_URL_ACCOUNT);
    }

    @GetMapping("/info")
    public ModelAndView info(HttpSession session) {
        String username = (String) session.getAttribute("username");
        ModelAndView modelAndView = new ModelAndView("home");
        modelAndView.addObject("username", username + "info");
        return modelAndView;
//        String accessToken = (String) session.getAttribute("access_token");
//        return new ModelAndView(REDIRECT_URL_INFO + accessToken);
    }

    @GetMapping("/signout")
    public ModelAndView signout(HttpSession session) {
        String accessToken = (String) session.getAttribute("access_token");
        String refreshToken = (String) session.getAttribute("refresh_token");
        session.removeAttribute("access_token");
        session.removeAttribute("refresh_token");
        session.removeAttribute("username");
        return new ModelAndView(REDIRECT_URL_LOGOUT_1 + accessToken + REDIRECT_URL_LOGOUT_2 + refreshToken);
    }

    @GetMapping("/changePassword")
    public ModelAndView changePassword(@RequestParam Map<String, String> requestParam) {
        String email = requestParam.get("email");
        return new ModelAndView(REDIRECT_URL_VERIFY_PASS + email);
    }
}
