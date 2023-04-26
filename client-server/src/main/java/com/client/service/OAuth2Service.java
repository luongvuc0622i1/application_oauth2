package com.client.service;

import com.client.model.AccessToken;

public interface OAuth2Service {
    AccessToken getAccessToken(String clientId, String clientSecret, String redirectUri, String code, String state);
}
