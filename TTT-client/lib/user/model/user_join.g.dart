// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_join.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJoin _$UserJoinFromJson(Map<String, dynamic> json) => UserJoin(
      email: json['email'] as String,
      googleId: json['googleId'] as String,
      deviceToken: json['deviceToken'] as String,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$UserJoinToJson(UserJoin instance) => <String, dynamic>{
      'email': instance.email,
      'googleId': instance.googleId,
      'deviceToken': instance.deviceToken,
      'nickname': instance.nickname,
    };
