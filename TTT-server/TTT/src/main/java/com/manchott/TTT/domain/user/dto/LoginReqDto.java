package com.manchott.TTT.domain.user.dto;

import com.manchott.TTT.domain.user.entity.Sns;
import com.manchott.TTT.global.validator.ValidEnum;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LoginReqDto {

  @NotEmpty(message="email은 빈값 일 수 없습니다")
  @NotNull(message="email은 null 일 수 없습니다")
  private String email;
  @ValidEnum(enumClass = Sns.class, message = "올바른 sns값이 아닙니다")
  private Sns sns;
  @NotEmpty(message="deviceToken은 빈값 일 수 없습니다")
  @NotNull(message="deviceToken은 null 일 수 없습니다")
  private String deviceToken;

}
