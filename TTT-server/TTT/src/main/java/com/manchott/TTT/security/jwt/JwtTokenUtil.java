package com.manchott.TTT.security.jwt;

import static com.manchott.TTT.security.jwt.JwtConstants.DAY;
import static com.manchott.TTT.security.jwt.JwtConstants.MONTH;
import static com.manchott.TTT.security.jwt.TokenValidationResult.TokenError.EXPIRED;
import static com.manchott.TTT.security.jwt.TokenValidationResult.TokenError.INVALID;
import static com.manchott.TTT.security.jwt.TokenValidationResult.TokenError.UNEXPECTED;

import com.manchott.TTT.security.jwt.TokenValidationResult.TokenError;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.Keys;
import java.security.Key;
import java.util.Date;
import java.util.function.Function;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class JwtTokenUtil {

  @Value("${jwt.secret}")
  private String JWT_SECRET;

  public String getUserEmailFromToken(String token) {
    return getClaimFromToken(token, Claims::getSubject);
  }

  public Date getExpirationDateFromToken(String token) {
    return getClaimFromToken(token, Claims::getExpiration);
  }

  public <T> T getClaimFromToken(String token, Function<Claims, T> claimsResolver) {
    final Claims claims = getAllClaimsFromToken(token);
    return claimsResolver.apply(claims);
  }

  private Claims getAllClaimsFromToken(String token) {
    return Jwts.parserBuilder()
        .setSigningKey(getSigningKey())
        .build()
        .parseClaimsJws(token)
        .getBody();
  }

  private Boolean isTokenExpired(String token) {
    final Date expiration = getExpirationDateFromToken(token);
    if (expiration == null) {
      return false;
    }
    return expiration.before(new Date());
  }

  public String generateAccessToken(String userEmail) {
    return doGenerateToken(userEmail, 12 * MONTH);
  }

  public String generateRefreshToken(String userEmail) {
    return doGenerateToken(userEmail, 30 * DAY);
  }

  private String doGenerateToken(String userEmail, long expireTime) {
    return Jwts.builder()
        .setSubject(userEmail)
        .setIssuedAt(new Date(System.currentTimeMillis()))
        .setExpiration(new Date(System.currentTimeMillis() + expireTime))
        .signWith(getSigningKey())
        .compact();
  }


  public TokenValidationResult validateToken(String token) {
    TokenError tokenError = null;
    try {
      Jwts.parserBuilder()
          .setSigningKey(getSigningKey())
          .build()
          .parseClaimsJws(token)
          .getBody();
      return new TokenValidationResult(true, null);
    } catch (ExpiredJwtException e) {
      log.error("만료된 JWT 토큰입니다.");
      tokenError = EXPIRED;
    } catch (MalformedJwtException e) {
      log.error("잘못된 JWT 서명입니다.");
      tokenError = INVALID;
    } catch (UnsupportedJwtException e) {
      log.error("지원되지 않는 JWT 토큰입니다.");
      tokenError = INVALID;
    } catch (IllegalArgumentException e) {
      log.error("JWT 토큰이 잘못되었습니다.");
      tokenError = INVALID;
    } catch (Exception e) {
      log.error(e.getMessage());
      tokenError = UNEXPECTED;
    }
    return new TokenValidationResult(false, tokenError);
  }

  private Key getSigningKey() {
    return Keys.hmacShaKeyFor(JWT_SECRET.getBytes());
  }

}