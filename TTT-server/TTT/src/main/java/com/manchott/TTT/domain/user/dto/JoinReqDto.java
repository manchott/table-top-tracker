package com.manchott.TTT.domain.user.dto;

import com.manchott.TTT.domain.user.entity.Sns;
import com.manchott.TTT.global.validator.ValidEnum;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class JoinReqDto {

  @NotEmpty(message="email은 빈값일 수 없습니다")
  @NotNull(message="email은 null일 수 없습니다")
  private String email;
  @ValidEnum(enumClass = Sns.class, message = "올바른 sns값이 아닙니다")
  private Sns sns;
  @NotEmpty(message="snsId는 빈값일 수 없습니다")
  @NotNull(message="snsId는 null일 수 없습니다")
  private String snsId;
  @NotEmpty(message="deviceToken은 빈값일 수 없습니다")
  @NotNull(message="deviceToken은 null일 수 없습니다")
  private String deviceToken;
  @NotEmpty(message="nickname은 빈값일 수 없습니다")
  @NotNull(message="nickname은 null일 수 없습니다")
  private String nickname;
}
