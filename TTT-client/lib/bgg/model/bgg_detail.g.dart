// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bgg_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BggDetail _$BggDetailFromJson(Map<String, dynamic> json) => BggDetail(
      type: json['type'] as String,
      id: json['id'] as String,
      thumbnail: json['thumbnail'] as String,
      nameKR: json['nameKR'] as String,
      weight: (json['weight'] as num).toDouble(),
      description: json['description'] as String,
      yearPublished: json['yearPublished'] as String,
      minPlayers: json['minPlayers'] as String,
      maxPlayers: json['maxPlayers'] as String,
      playingTime: json['playingTime'] as String,
      minPlayTime: json['minPlayTime'] as String,
      maxPlayTime: json['maxPlayTime'] as String,
      categoryIdList: json['categoryIdList'] as List<dynamic>,
      mechanicIdList: json['mechanicIdList'] as List<dynamic>,
    );

Map<String, dynamic> _$BggDetailToJson(BggDetail instance) => <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'thumbnail': instance.thumbnail,
      'nameKR': instance.nameKR,
      'weight': instance.weight,
      'description': instance.description,
      'yearPublished': instance.yearPublished,
      'minPlayers': instance.minPlayers,
      'maxPlayers': instance.maxPlayers,
      'playingTime': instance.playingTime,
      'minPlayTime': instance.minPlayTime,
      'maxPlayTime': instance.maxPlayTime,
      'categoryIdList': instance.categoryIdList,
      'mechanicIdList': instance.mechanicIdList,
    };
