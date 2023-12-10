package com.manchott.TTT.config;

import com.manchott.TTT.security.jwt.JwtFilter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.HttpBasicConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.HttpStatusEntryPoint;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Slf4j
@RequiredArgsConstructor
@Configuration
@EnableWebSecurity
public class SecurityConfig {

  private final JwtFilter jwtFilter;

  @Bean
  public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http.httpBasic(HttpBasicConfigurer::disable)
        .cors(AbstractHttpConfigurer::disable)
        .csrf(AbstractHttpConfigurer::disable)
        .sessionManagement(configurer -> configurer.sessionCreationPolicy(
            SessionCreationPolicy.STATELESS)); // 토큰 기반 인증을 위해 세션 생성x

    http.authorizeHttpRequests(authorize -> authorize
        .requestMatchers(HttpMethod.POST, "/user/login", "/user/join", "/user/signup", "/exercise",
            "/user/test")
        .permitAll()
        .requestMatchers(HttpMethod.GET, "/user/nameCheck/**", "/user/namecheck", "/user/test")
        .permitAll()
        .anyRequest().authenticated()
    );

    http.addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
        .exceptionHandling(exception -> exception.authenticationEntryPoint(
            new HttpStatusEntryPoint(HttpStatus.UNAUTHORIZED))
        )
    ; // 권한 설정
    // .logout((logout) -> logout.logoutUrl("/"))
    // .oauth2Login(oauth2 -> oauth2.userInfoEndpoint(
    //     userInfo -> userInfo.userService(customOAuth2UserService)));
    return http.build();
  }
}