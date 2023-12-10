import 'package:json_annotation/json_annotation.dart';

part 'user_join.g.dart';

@JsonSerializable()
class UserJoin {
  const UserJoin({
    required this.email,
    required this.googleId,
    required this.deviceToken,
    required this.nickname,
  });

  factory UserJoin.fromJson(Map<String, dynamic> json) =>
      _$UserJoinFromJson(json);

  final String email;
  final String googleId;
  final String deviceToken;
  final String nickname;

  Map<String, dynamic> toJson() => _$UserJoinToJson(this);
}
