package com.authentication.service;

import com.authentication.model.AccessToken;

public interface OAuth2Service {

    AccessToken getAccessToken(String clientId, String clientSecret, String redirectUri, String code, String state);
}
