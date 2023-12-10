package com.manchott.TTT.security.redis;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.data.redis.core.RedisHash;

@AllArgsConstructor
@Getter
@RedisHash(value = "jwtToken", timeToLive = 60 * 60 * 24 * 30) // 1달
public class RedisToken {

  @Id
  private String accessToken;

  private String refreshToken;

}
