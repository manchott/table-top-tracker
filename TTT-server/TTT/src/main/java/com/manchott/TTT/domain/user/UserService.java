package com.manchott.TTT.domain.user;

import static com.manchott.TTT.global.security.jwt.JwtConstants.HEADER_STRING;
import static com.manchott.TTT.global.security.jwt.JwtConstants.MONTH;
import static com.manchott.TTT.global.security.jwt.JwtConstants.TOKEN_PREFIX;

import com.manchott.TTT.domain.user.entity.Sns;
import com.manchott.TTT.global.exception.AlreadyExistsException;
import com.manchott.TTT.global.exception.InvalidSnsLoginException;
import com.manchott.TTT.global.exception.NotFoundException;
import com.manchott.TTT.global.security.jwt.JwtTokenUtil;
import com.manchott.TTT.global.security.redis.RedisTokenService;
import com.manchott.TTT.domain.user.dto.JoinReqDto;
import com.manchott.TTT.domain.user.dto.LoginResDto;
import com.manchott.TTT.domain.user.entity.User;
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

  public User getUserByEmail(String email){
    return userRepository.findByEmail(email).orElseThrow(() -> new NotFoundException("존재하지 않는 유저입니다."));
  }
  @Transactional
  public LoginResDto login(String email, Sns sns, String deviceToken) {

    User user = userRepository.findByEmail(email).orElseThrow(() -> new NotFoundException("존재하지 않는 유저입니다."));
    switch (sns){
      case GOOGLE -> {
        if (user.getGoogleId() == null){
          throw new InvalidSnsLoginException("잘못된 sns 로그인입니다. 다른 sns 로그인을 시도해주세요.");
        }
      }
      case APPLE -> {
        log.info("애플 로그인");
      }
    }
    log.info(email);
    user.updateDeviceToken(deviceToken);
    return LoginResDto.of(user);
  }

  @Transactional
  public void createUser(JoinReqDto joinReqDto) {
    if(userRepository.findByEmail(joinReqDto.getEmail()).isPresent()){
      throw new AlreadyExistsException("이미 가입된 이메일입니다.");
    }

    switch (joinReqDto.getSns()){
      case GOOGLE -> {
        userRepository.save(User.builder()
                .email(joinReqDto.getEmail())
                .googleId(joinReqDto.getSnsId())
                .nickname(joinReqDto.getNickname())
                .build());
      }
      case APPLE -> {
        log.info("애플 로그인");
      }
    }
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
