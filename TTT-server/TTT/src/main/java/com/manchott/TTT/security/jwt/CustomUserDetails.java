package com.manchott.TTT.security.jwt;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.manchott.TTT.user.entity.User;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * Redis에 캐싱할 때, 기본적인 UserDetails로 저장할 경우는 역직렬화가 되지 않는 이슈 인증과 권한체크를 위한 정보들을 필드로 설정
 */
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CustomUserDetails implements UserDetails {

  private User user;
  private String username;
  @Builder.Default
  private List<GrantedAuthority> roles = new ArrayList<>();

  public CustomUserDetails(User user) {
    super();
    this.user = user;
  }

  public static UserDetails of(User user) {
    return CustomUserDetails.builder()
        .username(user.getEmail())
        .build();
  }

  @Override
  public Collection<? extends GrantedAuthority> getAuthorities() {
    return this.roles;
  }


  @Override
  public String getPassword() {
    return null;
  }


  @Override
  public String getUsername() {
    return username;
  }

  @Override
  @JsonIgnore
  public boolean isAccountNonExpired() {
    return false;
  }

  @Override
  @JsonIgnore
  public boolean isAccountNonLocked() {
    return false;
  }

  @Override
  @JsonIgnore
  public boolean isCredentialsNonExpired() {
    return false;
  }

  @Override
  @JsonIgnore
  public boolean isEnabled() {
    return false;
  }

  public void setAuthorities(List<GrantedAuthority> roles) {
    this.roles = roles;
  }
}
