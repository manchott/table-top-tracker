import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/http.dart';

part 'bgg_client.g.dart';

String baseUrl = dotenv.env['BASE_URL']!;

@RestApi(baseUrl: "")
abstract class BggClient {
  factory BggClient(Dio dio) {
    final baseUrl = dotenv.env['BASE_URL'];
    return _BggClient(dio,
        baseUrl: 'https://boardgamegeek.com/xmlapi2/thing?id=365717');
  }

  @GET('/')
  Future<String> getBgg();
}
