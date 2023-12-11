package com.manchott.TTT.user;

import com.manchott.TTT.security.jwt.JwtTokenUtil;
import com.manchott.TTT.security.redis.RedisTokenService;
import com.manchott.TTT.user.dto.JoinReqDto;
import com.manchott.TTT.user.dto.LoginReqDto;
import com.manchott.TTT.user.dto.LoginResDto;
import com.manchott.TTT.user.dto.TempDto;
import com.manchott.TTT.user.entity.User;
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
  public ResponseEntity<?> login(@RequestBody LoginReqDto loginReqDto) throws Exception {
    String email = loginReqDto.getEmail();
    log.info(email);
    User user = userService.getUserByEmail(email);
    // 신규 가입자면 404 not found
    if (user == null) {
      return new ResponseEntity<>(loginReqDto, HttpStatus.NOT_FOUND);
    }
    // 로그인 방법 확인
    if (loginReqDto.getGoogleId() != null) {
      // 구글이 아닌 다른 것으로 회원가입한 사용자면 403 forbidden, 계정연동 하겠냐고 물어야함
      if (user.getGoogleId() == null) {
        return new ResponseEntity<>(HttpStatus.FORBIDDEN);
      }
    }
    // else if (loginReqDto.getAppleUid() != null){
    //   // 애플이 아닌 다른 것으로 회원가입한 사용자, 계정연동 하겠냐고 물어야함
    //   if (user.getAppleUid() == null) {
    //     return new ResponseEntity<>(HttpStatus.FORBIDDEN);
    //   }
    // }
    // 올바른 sns로 로그인 한 사용자는 토큰을 발급해주고 헤더에 넣어준 뒤 로그인시킨다
    LoginResDto loginResDto = userService.login(user, loginReqDto.getDeviceToken());
    HttpHeaders headers = userService.setHeader(loginReqDto.getEmail());

    return new ResponseEntity<>(loginResDto, headers, HttpStatus.OK);
  }

  @PostMapping("/join")
  public ResponseEntity<?> join(@RequestBody JoinReqDto joinReqDto) {
    log.info("JOIN");
    User user = null;
    try {
      user = userService.createUser(joinReqDto);
    } catch (Exception e) {
      return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    LoginResDto loginResDto = userService.login(user, joinReqDto.getDeviceToken());
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
