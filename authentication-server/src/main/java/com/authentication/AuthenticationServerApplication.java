package com.authentication;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class AuthenticationServerApplication {
    public static void main(String[] args) {
        SpringApplication.run(AuthenticationServerApplication.class, args);
    }
}
