package com.manchott.TTT.security.redis;


import java.util.concurrent.TimeUnit;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class RedisTokenService {

  private final RedisTemplate<String, Object> redisTemplate;

  @Transactional
  public String getRefreshToken(String key) {
    return (String) redisTemplate.opsForValue().get(key);
  }

  @Transactional
  public void setValues(String key, String value) {
    redisTemplate.opsForValue().set(key, value);
  }

  // 만료시간 설정 -> 자동 삭제
  @Transactional
  public void setValuesWithTimeout(String key, String value, long timeout) {
    redisTemplate.opsForValue().set(key, value, timeout, TimeUnit.MILLISECONDS);
  }

  @Transactional
  public void deleteValues(String key) {
    redisTemplate.delete(key);
  }

}