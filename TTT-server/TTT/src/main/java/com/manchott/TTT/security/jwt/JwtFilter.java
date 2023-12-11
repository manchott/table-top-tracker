package com.manchott.TTT.security.jwt;

import static com.manchott.TTT.security.jwt.JwtConstants.HEADER_STRING;
import static com.manchott.TTT.security.jwt.JwtConstants.TOKEN_PREFIX;

import com.manchott.TTT.security.jwt.TokenValidationResult.TokenError;
import com.manchott.TTT.security.redis.RedisTokenService;
import com.manchott.TTT.user.UserService;
import com.manchott.TTT.user.entity.User;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 * 지정한 URL별 JWT의 유효성 검증을 수행하며 직접적인 사용자 인증을 확인합니다.
 */
@Slf4j
@RequiredArgsConstructor
@Component
public class JwtFilter extends OncePerRequestFilter {

  private final JwtTokenUtil jwtTokenUtil;
  private final RedisTokenService redisTokenService;
  private final UserService userService;
  @Value("${jwt.secret}")
  private String JWT_SECRET;

  @Override
  protected void doFilterInternal(
      HttpServletRequest request,
      @NonNull HttpServletResponse response,
      @NonNull FilterChain filterChain
  ) throws ServletException, IOException {
    // 1. 토큰이 필요하지 않은 API URL에 대해서 배열로 구성한다.
    List<String> list = Arrays.asList(
        "/",
        "/user/test",
        "/user/login",
        "/user/join",
        "/css/**",
        "/js/**",
        "/images/**"
    );

    // 2. 토큰이 필요하지 않은 API URL의 경우, 로직 처리 없이 다음 필터로 이동한다.
    if (list.contains(request.getRequestURI())) {
      log.info("PASS");
      filterChain.doFilter(request, response);
      return;
    }

    // 3. Request Header 에서 토큰을 꺼냄
    String authToken = request.getHeader(HEADER_STRING);
    String accessToken = null;
    String email = null;
    // 토큰이 없거나 헤더에 TOKEN_PREFIX 없으면 에러 발생시킨다.
    if (authToken == null || !authToken.startsWith(TOKEN_PREFIX)) {
      response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
      response.getWriter().write("Authentication token missing");
      response.getWriter().flush();
    } else {
      accessToken = authToken.replace(TOKEN_PREFIX, "");
      email = jwtTokenUtil.getUserEmailFromToken(accessToken);
    }

    // 4. 토큰을 validation 후 처리
    TokenValidationResult accessTokenValidationResult = jwtTokenUtil.validateToken(accessToken);
    // 4-1. accessToken 유효하지 않은 경우
    if (!accessTokenValidationResult.isValid()) {
      TokenError tokenError = accessTokenValidationResult.getTokenError();
      switch (tokenError) {
        case EXPIRED -> {
          String refreshToken = redisTokenService.getRefreshToken(accessToken);
          if (refreshToken != null) {
            TokenValidationResult refreshTokenValidationResult = jwtTokenUtil.validateToken(
                refreshToken);
            if (!refreshTokenValidationResult.isValid()) {
              filterChain.doFilter(request, response);
              return;
            }
            // accessToken 만료 & refreshToken 유효, 토큰 새로 발급 후 설정
            HttpHeaders headers = userService.setHeader(email);
            response.setHeader(HttpHeaders.AUTHORIZATION,
                headers.getFirst(HttpHeaders.AUTHORIZATION));
            filterChain.doFilter(request, response);
          }
        }
        case INVALID -> {
          response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
          response.getWriter().write("Invalid token");
          response.getWriter().flush();
        }
        case UNEXPECTED -> {
          response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
          response.getWriter().write("Internal Server Error");
          response.getWriter().flush();
        }
        default -> {
          response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
          response.getWriter().write("Unexpected value for tokenError");
          response.getWriter().flush();
        }
      }
    } else {
      log.info("Validated");
      // 4-2. accessToken 유요한 경우
      // 사용자 계정이 존재하는지에 대한 여부를 체크한다.
      User user = null;
      user = userService.getUserByEmail(email);
      UserDetails userDetails = new CustomUserDetails(user);
      UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
          email,
          null, userDetails.getAuthorities());
      log.info(authentication.toString());
      SecurityContextHolder.getContext().setAuthentication(authentication);
      filterChain.doFilter(request, response);
    }
  }
}