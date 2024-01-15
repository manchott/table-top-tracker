import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/http.dart';

part 'bgg_client.g.dart';

String baseUrl = dotenv.env['BASE_URL']!;

@RestApi(baseUrl: "")
abstract class BggClient {
  factory BggClient(Dio dio) {
    final baseUrl = dotenv.env['BASE_URL'];
    return _BggClient(dio, baseUrl: 'https://boardgamegeek.com');
  }

  @GET('/xmlapi2/thing?id=2944')
  Future<String> getBgg();

  @Headers(<String, String>{'Accept': 'application/json'})
  @GET('/search/boardgame?nosession=1&showcount=20')
  Future<String> searchBgg(
    @Query('q') String query,
  );
}
