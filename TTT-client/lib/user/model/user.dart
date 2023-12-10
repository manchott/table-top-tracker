import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.userId,
    required this.email,
    required this.nickname,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     id: json['id'] as int,
  //     email: json['email'] as String,
  //     nickname: json['nickname'] as String,
  //   );
  // }

  final int userId;
  final String? email;
  final String nickname;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
