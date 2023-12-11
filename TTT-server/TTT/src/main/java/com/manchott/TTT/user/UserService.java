package com.manchott.TTT.user;

import static com.manchott.TTT.security.jwt.JwtConstants.HEADER_STRING;
import static com.manchott.TTT.security.jwt.JwtConstants.MONTH;
import static com.manchott.TTT.security.jwt.JwtConstants.TOKEN_PREFIX;

import com.manchott.TTT.security.jwt.JwtTokenUtil;
import com.manchott.TTT.security.redis.RedisTokenService;
import com.manchott.TTT.user.dto.JoinReqDto;
import com.manchott.TTT.user.dto.LoginResDto;
import com.manchott.TTT.user.entity.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {

  private final UserRepository userRepository;
  private final JwtTokenUtil jwtTokenUtil;
  private final RedisTokenService redisTokenService;

  public User getUserByEmail(String email) {
    return userRepository.findByEmail(email).orElse(null);
  }

  @Transactional
  public LoginResDto login(User user, String deviceToken) {
    user.setDeviceToken(deviceToken);
    return LoginResDto.of(user);
  }

  @Transactional
  public User createUser(JoinReqDto joinReqDto) {
    return userRepository.save(User.builder()
        .email(joinReqDto.getEmail())
        .googleId(joinReqDto.getGoogleId())
        .nickname(joinReqDto.getNickname())
        .build());
  }

  public HttpHeaders setHeader(String email) {
    String accessToken = jwtTokenUtil.generateAccessToken(email);
    String refreshToken = jwtTokenUtil.generateRefreshToken(email);
    log.info(accessToken);
    log.info(refreshToken);
    redisTokenService.setValuesWithTimeout(accessToken, refreshToken, MONTH); // TODO: 추후에 기간 바꾸기
    HttpHeaders headers = new HttpHeaders();
    headers.set(HEADER_STRING, TOKEN_PREFIX + accessToken);
    return headers;
  }

}
