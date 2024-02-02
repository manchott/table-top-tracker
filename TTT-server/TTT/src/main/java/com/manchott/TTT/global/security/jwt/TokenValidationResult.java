package com.manchott.TTT.global.security.jwt;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class TokenValidationResult {

  private boolean isValid;
  private TokenError tokenError;

  public enum TokenError {
    EXPIRED, INVALID, UNEXPECTED
  }
}
