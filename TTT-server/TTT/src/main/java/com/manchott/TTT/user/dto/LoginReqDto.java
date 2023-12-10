package com.manchott.TTT.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LoginReqDto {

  private String email;
  private String googleId;
  // private String appleId;
  private String deviceToken;

}
