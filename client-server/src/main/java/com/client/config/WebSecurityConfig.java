package com.client.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {


    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // Cấu hình public
        http.authorizeRequests().antMatchers("/oauth/callback", "/changePassword").permitAll();

        // Chỉ cho phép user có quyền ADMIN truy cập đường dẫn /admin/**
        http.authorizeRequests().antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')");

        // Chỉ cho phép user có quyền ADMIN hoặc USER truy cập đường dẫn /user/**
        http.authorizeRequests().antMatchers("/home", "/user/**").access("hasRole('ROLE_USER')");

        // Khi người dùng đã login, với vai trò USER, Nhưng truy cập vào trang yêu cầu vai trò ADMIN, sẽ chuyển hướng tới trang /403
        http.authorizeRequests().and().exceptionHandling().accessDeniedPage("/403");

        // Cấu hình cho Login Form.
        http.requestCache().requestCache(new CustomRequestCache())
                .and().authorizeRequests()
                .and().formLogin()//
//                .loginProcessingUrl("/j_spring_security_login")//
                .loginPage("http://localhost:8081/oauth/authorize?client_id=mobile&response_type=code&redirect_uri=http://localhost:8080/oauth/callback&scope=WRITE")
//                .defaultSuccessUrl("/")//
//                .failureUrl("/login?message=error")//
                .usernameParameter("username")//
                .passwordParameter("password")
                // Cấu hình cho Logout Page.
                .and().logout().logoutUrl("/logout").logoutSuccessUrl("/");
    }
}
