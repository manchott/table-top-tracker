package com.manchott.TTT.security.jwt;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class JwtConstants {

  // Expiration Time
  public static final long MINUTE = 1000 * 60;
  public static final long HOUR = 60 * MINUTE;
  public static final long DAY = 24 * HOUR;
  public static final long MONTH = 30 * DAY;

  public static final long AT_EXP_TIME = HOUR;
  public static final long RT_EXP_TIME = 30 * DAY;

  // Header
  public static final String HEADER_STRING = "Authorization";
  public static final String TOKEN_PREFIX = "Bearer: ";

}
