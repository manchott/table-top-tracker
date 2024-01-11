import 'package:json_annotation/json_annotation.dart';

part 'bgg_detail.g.dart';

@JsonSerializable()
class BggDetail {
  const BggDetail(
      {required this.type,
      required this.id,
      required this.thumbnail,
      required this.nameKR});
  // factory BggDetail.fromJson(Map<String, dynamic> json) => _$BggDetailFromJson(json);

  factory BggDetail.fromJson(Map<String, dynamic> json) {
    String type = json["items"]["item"]["@type"];
    String id = json["items"]["item"]["@id"];
    String thumbnail = json["items"]["item"]["thumbnail"]['\$'];
    String nameEN = json["items"]["item"]["name"]
        .firstWhere((entry) => entry['@type'] == 'primary')['@value'];
    String nameKR = json["items"]["item"]["name"].firstWhere(
            (entry) =>
                entry['@type'] == 'alternate' &&
                RegExp(r'[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ]').hasMatch(entry['@value']),
            orElse: () => null)?['@value'] ??
        nameEN;
    return BggDetail(
      type: type,
      id: id,
      thumbnail: thumbnail,
      nameKR: nameKR,
    );
  }

  final String type;
  final String id;
  final String thumbnail;
  final String nameKR;
}
