package com.client.config;

import org.springframework.security.web.savedrequest.HttpSessionRequestCache;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CustomRequestCache extends HttpSessionRequestCache {
    public static String preUrl;

    @Override
    public void saveRequest(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
        if (!httpServletRequest.getRequestURI().equals("/oauth/callback")) {
            this.preUrl = httpServletRequest.getRequestURI();
        }
        super.saveRequest(httpServletRequest, httpServletResponse);
    }
}