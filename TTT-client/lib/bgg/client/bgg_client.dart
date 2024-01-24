import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/http.dart';

part 'bgg_client.g.dart';

String baseUrl = dotenv.env['BASE_URL']!;

@RestApi(baseUrl: "https://boardgamegeek.com")
abstract class BggClient {
  factory BggClient(Dio dio, {String baseUrl}) = _BggClient;

  @GET('/xmlapi2/thing?id={id}&stats=1')
  Future<String> getBgg(@Path('id') String id);

  @Headers(<String, String>{'Accept': 'application/json'})
  @GET('/search/boardgame?nosession=1&showcount=20')
  Future<String> searchBgg(
    @Query('q') String query,
  );
}
