package com.manchott.TTT.domain.user.controller;

import com.manchott.TTT.domain.user.UserService;
import com.manchott.TTT.global.security.jwt.JwtTokenUtil;
import com.manchott.TTT.global.security.redis.RedisTokenService;
import com.manchott.TTT.domain.user.dto.JoinReqDto;
import com.manchott.TTT.domain.user.dto.LoginReqDto;
import com.manchott.TTT.domain.user.dto.LoginResDto;
import com.manchott.TTT.domain.user.dto.TempDto;
import com.manchott.TTT.domain.user.entity.User;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

  @Value("${spring.security.oauth2.client.registration.google.client-id}")
  private String clientId;
  @Value("${spring.security.oauth2.client.registration.google.client-secret}")
  private String clientSecretKey;

  private final UserService userService;
  private final JwtTokenUtil jwtTokenUtil;
  private final RedisTokenService redisTokenService;

  @PostMapping("/login")
  public ResponseEntity<?> login(@RequestBody LoginReqDto loginReqDto) {
    LoginResDto loginResDto = userService.login(loginReqDto.getEmail(), loginReqDto.getSns(), loginReqDto.getDeviceToken());
    HttpHeaders headers = userService.setHeader(loginReqDto.getEmail());

    return new ResponseEntity<>(loginResDto, headers, HttpStatus.OK);
  }

  @PostMapping("/join")
  public ResponseEntity<?> join(@Valid @RequestBody JoinReqDto joinReqDto) {
    log.info(joinReqDto.getNickname());
    log.info("JOIN");
    userService.createUser(joinReqDto);
    LoginResDto loginResDto = userService.login(joinReqDto.getEmail(), joinReqDto.getSns(), joinReqDto.getDeviceToken());
    HttpHeaders headers = userService.setHeader(joinReqDto.getEmail());
    return new ResponseEntity<>(loginResDto, headers, HttpStatus.CREATED);
  }

  @GetMapping("/test")
  public ResponseEntity<?> test() {
    log.info("Test");
    String accessToken = jwtTokenUtil.generateAccessToken("manchott@naver.com");
    System.out.println(accessToken);
    log.info(accessToken);
    TempDto tempDto = TempDto.builder()
        .user("me")
        .answer("hi")
        .build();
    return new ResponseEntity<>(tempDto, HttpStatus.OK);
  }


}
