package com.manchott.TTT.user;

import com.manchott.TTT.security.jwt.JwtTokenUtil;
import com.manchott.TTT.user.dto.JoinReqDto;
import com.manchott.TTT.user.dto.LoginResDto;
import com.manchott.TTT.user.entity.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {

  private final UserRepository userRepository;
  private final JwtTokenUtil jwtTokenUtil;

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

}
