package com.manchott.TTT.domain.user.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "user_id", nullable = false)
  private Long userId;

  @Column(nullable = false, unique = true)
  private String email;

  private String googleId;

  private String deviceToken; // 핸드폰 정보

  private String nickname;

  public void updateGoogleId(String googleId) {
    this.googleId = googleId;
  }

  public void updateDeviceToken(String deviceToken) {
    this.deviceToken = deviceToken;
  }

  public void updateNickname(String nickname) {
    this.nickname = nickname;
  }
}
