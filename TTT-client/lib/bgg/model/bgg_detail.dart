import 'dart:convert';

import 'package:html_unescape/html_unescape.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bgg_detail.g.dart';

@JsonSerializable()
class BggDetail {
  const BggDetail({
    required this.type,
    required this.id,
    required this.thumbnail,
    required this.nameKR,
    required this.weight,
    required this.description,
    required this.yearPublished,
    required this.minPlayers,
    required this.maxPlayers,
    required this.playingTime,
    required this.minPlayTime,
    required this.maxPlayTime,
    required this.categoryIdList,
    required this.mechanicIdList,
  });
  // factory BggDetail.fromJson(Map<String, dynamic> json) => _$BggDetailFromJson(json);

  final String type;
  final String id;
  final String thumbnail;
  final String nameKR;
  final double weight;
  final String description;
  final String yearPublished;
  final String minPlayers;
  final String maxPlayers;
  final String playingTime;
  final String minPlayTime;
  final String maxPlayTime;
  final List<dynamic> categoryIdList;
  final List<dynamic> mechanicIdList;

  factory BggDetail.fromJson(Map<String, dynamic> json) {
    var unescape = HtmlUnescape();
    String type = json["items"]["item"]["@type"];
    String id = json["items"]["item"]["@id"];
    String thumbnail = json["items"]["item"]["thumbnail"]["\$"];
    String nameEN = json["items"]["item"]["name"] is List
        ? json["items"]["item"]["name"]
            .firstWhere((entry) => entry["@type"] == "primary")["@value"]
        : json["items"]["item"]["name"]["@value"];
    String nameKR = json["items"]["item"]["name"] is List
        ? (json["items"]["item"]["name"].firstWhere(
                (entry) =>
                    entry["@type"] == "alternate" &&
                    RegExp(r"[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ]").hasMatch(entry["@value"]),
                orElse: () => null)?["@value"] ??
            nameEN)
        : nameEN;
    String description = unescape
        .convert(decodeString(json["items"]["item"]["description"]["\$"]));
    String yearPublished = json["items"]["item"]["yearpublished"]["@value"];
    String minPlayers = json["items"]["item"]["minplayers"]["@value"];
    String maxPlayers = json["items"]["item"]["maxplayers"]["@value"];
    String playingTime = json["items"]["item"]["playingtime"]["@value"];
    String minPlayTime = json["items"]["item"]["minplaytime"]["@value"];
    String maxPlayTime = json["items"]["item"]["maxplaytime"]["@value"];
    double weight = (double.parse(json["items"]["item"]["statistics"]["ratings"]
                    ["averageweight"]["@value"]) *
                100)
            .floorToDouble() /
        100;
    List<dynamic> categoryIdList = json["items"]["item"]["link"]
        .where((element) => element["@type"] == "boardgamecategory")
        .map((element) => element["@id"])
        .toList();
    List<dynamic> mechanicIdList = json["items"]["item"]["link"]
        .where((element) => element["@type"] == "boardgamemechanic")
        .map((element) => element["@id"])
        .toList();
    return BggDetail(
      type: type,
      id: id,
      thumbnail: thumbnail,
      nameKR: nameKR,
      weight: weight,
      description: description,
      yearPublished: yearPublished,
      minPlayers: minPlayers,
      maxPlayers: maxPlayers,
      playingTime: playingTime,
      minPlayTime: minPlayTime,
      maxPlayTime: maxPlayTime,
      categoryIdList: categoryIdList,
      mechanicIdList: mechanicIdList,
    );
  }
}

String decodeString(String orgString) {
  List<int> start = [];
  List<int> end = [];
  bool flag = false;
  RegExp regexStart = RegExp(r'[0-9#&;]');
  RegExp regex2 = RegExp(r'\d+');
  orgString += "  ";
  Map<String, String> convertMap = {};

  for (int i = 0; i < orgString.runes.length - 1; i++) {
    String curCharacter = String.fromCharCode(orgString.runes.elementAt(i));
    String nxtCharacter = String.fromCharCode(orgString.runes.elementAt(i + 1));
    if (flag && !regexStart.hasMatch(curCharacter)) {
      if (String.fromCharCode(orgString.runes.elementAt(i - 1)) != ";") {
        end.add(i - 2);
      } else {
        end.add(i - 1);
      }
      flag = false;
    } else if (flag) {
      continue;
    } else if (curCharacter == "&" && nxtCharacter == "#") {
      start.add(i);
      flag = true;
    }
  }
  for (int i = 0; i < start.length; i++) {
    String temp = orgString.substring(start[i], end[i] + 1);
    String utfTemp = utf8.decode(regex2
        .allMatches(temp)
        .map((m) => m.group(0)!)
        .map((s) => int.parse(s))
        .toList());
    convertMap[temp] = utfTemp;
  }
  convertMap.forEach((key, value) {
    orgString = orgString.replaceFirst(key, value);
  });

  return orgString;
}
