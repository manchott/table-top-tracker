import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/retrofit.dart';
import 'package:table_top_tracker/user/model/user_join.dart';
import 'package:table_top_tracker/user/model/user_login.dart';

import '../model/user.dart';

part 'user_client.g.dart';

String baseUrl = dotenv.env['BASE_URL']!;

@RestApi(baseUrl: "")
abstract class UserClient {
  factory UserClient(Dio dio) {
    final baseUrl = dotenv.env['BASE_URL'];
    return _UserClient(dio, baseUrl: '$baseUrl/user');
  }
  @POST('/login')
  Future<User> login(@Body() UserLogin userLogin);

  @POST('/join')
  Future<User> join(@Body() UserJoin userJoin);
}
