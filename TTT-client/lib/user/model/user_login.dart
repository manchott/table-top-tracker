import 'package:json_annotation/json_annotation.dart';

part 'user_login.g.dart';

@JsonSerializable()
class UserLogin {
  const UserLogin({
    required this.email,
    required this.googleId,
    required this.deviceToken,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) =>
      _$UserLoginFromJson(json);

  final String email;
  final String googleId;
  final String deviceToken;

  Map<String, dynamic> toJson() => _$UserLoginToJson(this);
}
