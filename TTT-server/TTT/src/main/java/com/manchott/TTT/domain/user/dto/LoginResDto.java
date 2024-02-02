package com.manchott.TTT.domain.user.dto;

import com.manchott.TTT.domain.user.entity.User;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class LoginResDto {

  private Long userId;
  private String nickname;

  public static LoginResDto of(User user) {
    return LoginResDto.builder()
        .userId(user.getUserId())
        .nickname(user.getNickname())
        .build();
  }
}
