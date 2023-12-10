package com.manchott.TTT.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class JoinReqDto {

  private String email;
  private String googleId;
  private String deviceToken;
  private String nickname;
}
